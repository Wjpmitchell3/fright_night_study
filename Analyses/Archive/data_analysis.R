# ----- SETUP -----

## Loading packages
if (require("pacman") == FALSE){
  install.packages("pacman")
}

## Loading in my packages with my pacman manager
pacman::p_load(here, lme4, lmerTest, DHARMa, tidyverse)

## Setting a working directory
here()

## Loading Custom Function
source("func_pavlovia_cleaner.R")

# ----- LOADING IN DATA -----

## Specifying Data Source
files <- list.files("../data/",
                    full.names = T) %>%
         .[file.size(.) > 20000]

## Iterating Through Each File in the Source
for (FILE in 1:length(files)){
  
  ## If this is the first file we're reading ...
  if (FILE == 1){
    
    ## ... Define it as df
    df <- pavlovia_cleaner(files[FILE])
    
  }
  
  ## If this is a later file we're reading ...
  if (FILE > 1){
    
    ## ... Process it ...
    df_ <- pavlovia_cleaner(files[FILE])
    
    ## ... and then append it to df. 
    df <- bind_rows(df,
                    df_)
  }
  
  ## If this is the last iteration ...
  if (FILE == length(files)){
    
    ## Clean Our Space
    rm(pavlovia_cleaner, FILE, files, df_)
  }
}

# ----- FILTERING DATA -----

## If people failed the attention check, get rid of them
df <- df[df$Attention_Check == 4,]

## If people are familiar with the stimuli, get rid of that stimulus
for (PID in unique(df$PID)){
  if (any(!is.na(df$Familiar_specific[df$PID == PID]))){
    array <- df$Familiar_specific[df$PID == PID & !is.na(df$PID)][1] %>%
             strsplit(" ") %>%
             as.data.frame() %>%
             .[,1]
    for (VID in 1:length(array)){
      df <- df[-which(df$PID == PID & !is.na(df$PID) & df$Stimulus == array[VID]),] 
    }
  }
}

# ----- ADDING VARIABLE -----

## Adding categories for stimulus levels
df$StimInt <- NA
df$StimInt[df$Stimulus == "ARF1665" | df$Stimulus == "HIU8424"] <- "High"
df$StimInt[df$Stimulus == "CNL1892" | df$Stimulus == "FGV3524"] <- "Low"

# Binarizing Regulation
df$Regulated <- NA
df$Regulated[df$Choice == "Distraction" | df$Choice == "Reappraisal"] <- 1
df$Regulated[df$Choice == "Neither"] <- 0

# Binarizing Choice
df$Distracted <- NA
df$Distracted[df$Choice == "Distraction"] <- 1
df$Distracted[df$Choice == "Reappraisal"] <- 0

# If PID is missing add "Missing"
df$PID[is.na(df$PID)] <- "Missing"

# ----- FORMATTING VARIABLES -----

df$IntAfter <- as.numeric(df$IntAfter)
df$IntBefore <- as.numeric(df$IntBefore)
df$IntReduce <- as.numeric(df$IntReduce)
df$Condition <- as.factor(df$Condition)
df$Date <- as.factor(df$Date)

# ----- STANDARDIZING VARIABLES -----

df$IntBefore_z <- as.numeric(scale(df$IntBefore))
df$IntAfter_z <- as.numeric(scale(df$IntAfter))
df$IntReduce_z <- as.numeric(scale(df$IntReduce))

# ----- QA Checks -----

## The videos we've labeled as high intensity should have a higher rating by participants than what we've labeled as low-intensity
(t_test_result <- t.test(x = df$IntAfter[df$StimInt == "High"],
                        y = df$IntAfter[df$StimInt == "Low"]))

## RESULTS: High intensity videos (x = 53.2) were not significantly more intense than low intensity videos (x = 40.2) (t = 1.87, df = 80.9, p = 0.065)

# Create a data frame with t-test results
results <- data.frame(
  Group = c("High", "Low"),
  rating = t_test_result$estimate,
  t_value = t_test_result$statistic,
  p_value = t_test_result$p.value
)

# Define the plot
ggplot(results, aes(x = Group, y = rating, fill = Group)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.5) +
  geom_text(aes(label = sprintf("Rating = %.2f", rating), y = rating), vjust = -0.5, size = 4) +
  labs(title = "Rating versus Category", y = "Rating") +
  scale_y_continuous(limits = c(0,100), breaks = seq(0,100,20)) +
  theme_minimal()

## Regulated videos should be of a greater intensity than not regulated videos
(t_test_result <- t.test(x = df$IntAfter[df$Regulated == 1],
                         y = df$IntAfter[df$Regulated == 0]))

## RESULTS: Regulated videos (x = 53.5) were significantly more intense than unregulated videos (x = 38.1) (t = 2.26, df = 81.32, p = 0.027)

# Create a data frame with t-test results
results <- data.frame(
  Group = c("Regulated", "Unregulated"),
  rating = t_test_result$estimate,
  t_value = t_test_result$statistic,
  p_value = t_test_result$p.value
)

# Define the plot
ggplot(results, aes(x = Group, y = rating, fill = Group)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.5) +
  geom_text(aes(label = sprintf("Rating = %.2f", rating), y = rating), vjust = -0.5, size = 4) +
  labs(title = "Rating versus Regulation", y = "Rating") +
  scale_y_continuous(limits = c(0,100), breaks = seq(0,100,20)) +
  theme_minimal()

# ----- ASSUMPTIONS -----

hist(df$IntBefore, breaks = seq(0,100,10))
hist(df$IntAfter, breaks = seq(0,100,10))

# ----- ANALYSIS -----

## Chi Square Test
m1 <- glmer(Regulated ~ IntAfter * Condition + (1|PID), 
          data = df,
          family = "binomial")
summary(m1)

sjPlot::plot_model(m1, type = "int")
## RESULTS: The association between condition and regulating at all trends towards significance (p = 0.0547); forecasters are more likely to choose a strategy than experiencers. This may simply be a demand effect. 

## Chi Square Test
m2 <- glmer(Distracted ~ IntAfter + Condition + (1 | PID), 
          data = df,
          family = "binomial")
summary(m2)

sjPlot::plot_model(m2, type = "int")

## RESULTS: The association between intensity and choice is significant (p = 0.0467); As intensity increases, participants were more likely to use distraction. 

# ----- ASSUMPTION CHECKS -----

## Descriptive Stats
skimr::skim(df$IntBefore)

## Calculating probabilities from the model
probabilities <- predict(m2, 
                         type = "response")

# Bind the logit and tidying the data for plot
df_assum <- df %>%
  subset(!is.na(.$Distracted), 
         select = c("Distracted", "IntAfter")) %>%
  mutate(logit = log(probabilities/(1 - probabilities))) %>%
  gather(key = "predictors", value = "predictor.value", -logit)

## Examining linearity
ggplot(df_assum, aes(logit, predictor.value))+
  geom_point(size = 0.5, alpha = 0.5) +
  geom_smooth(method = "loess") + 
  theme_bw() + 
  facet_wrap(~predictors, scales = "free_y")

# Calculate Cook's distance
cooksd_values <- cooks.distance(m2)
# Plotting Cook's Distances
threshold <- 0.5
plot(cooksd_values, type = "p", pch = 19, main = "Cook's Distance Plot", xlab = "Observation Index", ylab = "Cook's Distance")
text(which(cooksd_values > threshold), cooksd_values[cooksd_values > threshold], labels = which(cooksd_values > threshold), pos = 3)
# 203, 233, 291, 454, 558

# Calculating simulated standardized residuals
residuals_sim <- simulateResiduals(m2, n = 1000)

# Plotting standardized residuals
plot(residuals_sim)
test_res <- testResiduals(residuals_sim)
summary(test_res)
performance::check_model(m2)

# ----- POST TESTS -----

## Distraction should be less effortful than reappraisal
t.test(x = df$Effort[df$Choice == "Distraction"],
       y = df$Effort[df$Choice == "Reappraisal"])

## RESULTS: Reappraisal (x = 3.17) is not significantly more effortful than distraction (x = 2.58) (t = 1.18, df = 43.97, p = 0.243)

## Reapparaisal should be less successul at high intensities than distraction
m3 <- lm(Success ~ Choice * IntAfter, data = df)
summary(m3)

## RESULTS: We did not find this

