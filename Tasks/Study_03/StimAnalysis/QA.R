# Clearing environment
rm(list=ls())

# Loading Packages
pacman::p_load(lme4, lmerTest, R_Color_Brewer, tidyverse)

# Denoting filepath
filepath <- "C:/Users/tui81100/Desktop/Independ_raters_qualtrics_NEW/"

# Loading dataframe
df <- read.csv(file=paste0(filepath, 'Independent_Ratings.csv')) %>%
  
  # Deleting and columns with only NA values
  select_if(function(col) any(!is.na(col))) %>%

  # Filtering out data for non-aversive videos
  .[which(.$stimset=='1'),]

# Generating mean values for each category
df_mean <- df %>%
  select(-c(PID, stimset)) %>%
  group_by(Videos) %>%
  summarise(across(everything(), mean, na.rm = TRUE))

# Generating median values for each category
df_med <- df %>%
  select(-c(PID, stimset)) %>%
  group_by(Videos) %>%
  summarise(across(everything(), median, na.rm = TRUE))
names(df_med) <- paste0(names(df_med),"_median")

# Generating variance values for each category
df_var <- df %>%
  select(-c(PID, stimset)) %>%
  group_by(Videos) %>%
  summarise(across(everything(), var, na.rm = TRUE))

# Merging together dataframes
df_sum <- merge(df_mean,
                df_var,
                by = "Videos",
                suffixes = c("_mean", "_var"))

# Merging together dataframes
df_sum <- merge(df_sum,
                df_med,
                by.x = "Videos",
                by.y = "Videos_median")

# Adding additional variables
df_sum$Length_s <- 120
df_sum$Category <- "Aversive"
df_sum$Movie <- c("Vicious Fun",
                  "Downrange",
                  "Head Count",
                  "Hounds of Love",
                  "Motherly",
                  "Superhost",
                  "The Cleansing Hour",
                  "The Marshes",
                  "The Seed",
                  "The Triangle")
df_sum$File <- paste0(df_sum$Videos, ".mp4")

# Rearranging and exporting df_sum
df_sum %>%
  select(c(File, Movie, Category, Length_s, 
           Arousal_mean, Arousal_median, Arousal_var,
           Valence_mean,Valence_median, Valence_var, 
           Coherence_mean, Coherence_median, Coherence_var,
           Familiarity_mean, Familiarity_median, Familiarity_var)) %>%
  write.csv(paste0(filepath, "File_List.csv"))

# Scaling variables 
df$Arousal_z <- as.numeric(scale(df$Arousal))
df$Valence_z <- as.numeric(scale(df$Valence))
df$Coherence_z <- as.numeric(scale(df$Coherence))
df$Familiarity_z <- as.numeric(scale(df$Familiarity))

# Generating a histogram faceted by movie of arousal to look at the distributions more closely
ggplot(df, aes(x = Arousal)) +
  geom_histogram(binwidth = 10, fill = "lightblue", color = "black") +
  facet_wrap(~ Videos, ncol = 2) +
  labs(title = "Histograms of Arousal by Video", x = "Arousal", y = "Frequency")

# Creating a factor 
df$Videos <- factor(df$Videos, levels = df_sum$Videos[order(df_sum$Arousal_median)])

# Let's try this again with a boxplot because I didn't get shit from this really
ggplot(data = df, aes(x = Videos, y = Arousal, fill= Videos, color = Videos)) + 
  theme_classic()+
  geom_violin(trim=F, alpha=0.3, linewidth = 1.5) +
  geom_point(aes(alpha = 0.95, color=Videos),shape=16, size = 4.5, position = position_jitter(width = 0.2, height = 0)) + 
  scale_color_brewer(palette = "Spectral") +
  scale_fill_brewer(palette = "Spectral") +
  coord_cartesian(ylim = c(-5, 105)) +
  xlab("Videos") +
  ylab("Arousal") +
  theme(legend.position="none") +
  geom_boxplot(width=0.2, color="black", alpha=0.2)

# Determining whether there's a relationship between arousal and coherence
ggplot(data = df, aes(x = Arousal, y = Coherence)) +
  geom_smooth(method = "lm") +
  geom_point() +
  coord_cartesian(xlim = c(00, 100), ylim = c(00, 100)) +
  theme_classic()

# Testing for statistical significance | No relationship found
summary(lmer(Coherence_z ~ Arousal_z + (1 | PID), data = df))

# Determining whether there's a relationship between arousal and valence
ggplot(data = df, aes(x = Arousal, y = Valence)) +
  geom_smooth(method = "lm") +
  geom_point() +
  coord_cartesian(xlim = c(00, 100), ylim = c(00, 100)) +
  theme_classic()

# Testing for statistical significance | beta = -0.297 ***
summary(lmer(Valence_z ~ Arousal_z + (1 | PID), data = df))

# Determining whether there's a relationship between arousal and familiarity
ggplot(data = df, aes(x = Arousal, y = Familiarity)) +
  geom_smooth(method = "lm") +
  geom_point() +
  coord_cartesian(xlim = c(00, 100), ylim = c(00, 100)) +
  theme_classic()

# Testing for statistical significance | No relationship found
summary(lmer(Familiarity_z ~ Arousal_z + (1 | PID), data = df))

# Determining whether there's a relationship between coherence and valence
ggplot(data = df, aes(x = Coherence, y = Valence)) +
  geom_smooth(method = "lm") +
  geom_point() +
  coord_cartesian(xlim = c(00, 100), ylim = c(00, 100)) +
  theme_classic()

# Testing for statistical significance | beta = -0.218 **
summary(lmer(Valence_z ~ Coherence_z + (1 | PID), data = df))

# Determining whether there's a relationship between coherence and familiarity
ggplot(data = df, aes(x = Coherence, y = Familiarity)) +
  geom_smooth(method = "lm") +
  geom_point() +
  coord_cartesian(xlim = c(00, 100), ylim = c(00, 100)) +
  theme_classic()

# Testing for statistical significance | beta = -0.315 ***
summary(lmer(Familiarity_z ~ Coherence_z + (1 | PID), data = df))

# Determining whether there's a relationship between valence and familiarity
ggplot(data = df, aes(x = Valence, y = Familiarity)) +
  geom_smooth(method = "lm") +
  geom_point() +
  coord_cartesian(xlim = c(00, 100), ylim = c(00, 100)) +
  theme_classic()

# Testing for statistical significance | No relationship found
summary(lmer(Familiarity_z ~ Valence_z + (1 | PID), data = df))


