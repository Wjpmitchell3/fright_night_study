# ----- SCRIPT START -----

## Packages I Use ----
   library(ggpubr)  
   library(psych)
   library(tidyverse)

## Number Formatting ----
  options(scipen=100)
  options(digits=3)
  options(tinytex.verbose = TRUE)

  
# Specifying filepath ----
  WorkDir <- "C:/Users/wjpmi/Dropbox/My PC (UncleSplashysSaddnessEmporium)/Desktop/Grad School/Projects/Complete/Fright Night/Public_Records/"
  Scripts <- paste0(WorkDir,"scripts/3_Study2_DFcreation/")
  Export <- paste0(WorkDir, "data/Study_02/Raw/")
  Import <- paste0(WorkDir, "data/Study_02/Source/")
  
  
## Pulling in Cleaned Data ----
  source(paste0(Scripts, "Data_Cleaning.R"))

# ----- SEPARATING DATAFRAMES -----
## Separating dataframes into sets ----
  df_rat <- df[,c(18:541)]

# ----- RENAMING VARIABLES -----

## Specifying Example Column Names ----
Cols.Example <- c("PID", "Stage", 
                 "Example.1_FirstClick", "Example.1_LastClick", "Example.1_PageSubmit", "Example.1_ClickCount", "Example.1_Response",
                 "Example.1_Answer.FirstClick.", "Example.1_Answer.LastClick", "Example.1_Answer.PageSubmit", "Example.1_Answer.ClickCount",
                 "Example.1_ISI.FirstClick.", "Example.1_ISI.LastClick", "Example.1_ISI.PageSubmit", "Example.1_ISI.ClickCount",
                 "Example.2_FirstClick", "Example.2_LastClick", "Example.2_PageSubmit", "Example.2_ClickCount", "Example.2_Response",
                 "Example.2_Answer.FirstClick.", "Example.2_Answer.LastClick", "Example.2_Answer.PageSubmit", "Example.2_Answer.ClickCount",
                 "Example.2_ISI.FirstClick.", "Example.2_ISI.LastClick", "Example.2_ISI.PageSubmit", "Example.2_ISI.ClickCount",
                 "Example.3_FirstClick", "Example.3_LastClick", "Example.3_PageSubmit", "Example.3_ClickCount", "Example.3_Response",
                 "Example.3_Answer.FirstClick.", "Example.3_Answer.LastClick", "Example.3_Answer.PageSubmit", "Example.3_Answer.ClickCount",
                 "Example.3_ISI.FirstClick.", "Example.3_ISI.LastClick", "Example.3_ISI.PageSubmit", "Example.3_ISI.ClickCount",
                 "Example.4_FirstClick", "Example.4_LastClick", "Example.4_PageSubmit", "Example.4_ClickCount", "Example.4_Response",
                 "Example.4_Answer.FirstClick.", "Example.4_Answer.LastClick", "Example.4_Answer.PageSubmit", "Example.4_Answer.ClickCount",
                 "Example.4_ISI.FirstClick.", "Example.4_ISI.LastClick", "Example.4_ISI.PageSubmit", "Example.4_ISI.ClickCount",
                 "Example.5_FirstClick", "Example.5_LastClick", "Example.5_PageSubmit", "Example.5_ClickCount", "Example.5_Response",
                 "Example.5_Answer.FirstClick.", "Example.5_Answer.LastClick", "Example.5_Answer.PageSubmit", "Example.5_Answer.ClickCount",
                 "Example.5_ISI.FirstClick.", "Example.5_ISI.LastClick", "Example.5_ISI.PageSubmit", "Example.5_ISI.ClickCount",
                 "Example.6_FirstClick", "Example.6_LastClick", "Example.6_PageSubmit", "Example.6_ClickCount", "Example.6_Response",
                 "Example.6_Answer.FirstClick.", "Example.6_Answer.LastClick", "Example.6_Answer.PageSubmit", "Example.6_Answer.ClickCount",
                 "Example.6_ISI.FirstClick.", "Example.6_ISI.LastClick", "Example.6_ISI.PageSubmit", "Example.6_ISI.ClickCount",
                 "Example.7_FirstClick", "Example.7_LastClick", "Example.7_PageSubmit", "Example.7_ClickCount", "Example.7_Response",
                 "Example.7_Answer.FirstClick.", "Example.7_Answer.LastClick", "Example.7_Answer.PageSubmit", "Example.7_Answer.ClickCount",
                 "Example.7_ISI.FirstClick.", "Example.7_ISI.LastClick", "Example.7_ISI.PageSubmit", "Example.7_ISI.ClickCount",
                 "Example.8_FirstClick", "Example.8_LastClick", "Example.8_PageSubmit", "Example.8_ClickCount", "Example.8_Response",
                 "Example.8_Answer.FirstClick.", "Example.8_Answer.LastClick", "Example.8_Answer.PageSubmit", "Example.8_Answer.ClickCount",
                 "Example.8_ISI.FirstClick.", "Example.8_ISI.LastClick", "Example.8_ISI.PageSubmit", "Example.8_ISI.ClickCount",
                 "Example.9_FirstClick", "Example.9_LastClick", "Example.9_PageSubmit", "Example.9_ClickCount", "Example.9_Response",
                 "Example.9_Answer.FirstClick.", "Example.9_Answer.LastClick", "Example.9_Answer.PageSubmit", "Example.9_Answer.ClickCount",
                 "Example.9_ISI.FirstClick.", "Example.9_ISI.LastClick", "Example.9_ISI.PageSubmit", "Example.9_ISI.ClickCount")

## Specifying Response Column Names ----
ColTypes <- c("_FirstClick", "_LastClick", "_PageSubmit", "_ClickCount", "_Response",
                 "_ISI.FirstClick.", "_ISI.LastClick", "_ISI.PageSubmit", "_ISI.ClickCount")

Groups <- c("A", "B", "C")

Qs <- NA
for (i in 1:length(Groups)){
    Qs <- sort(c(Qs, paste0(Groups[i], "0", 1:9), paste0(Groups[i], 10:15)))
}

Cols.Response <- NA
for (i in 1:length(Qs)){
  Cols.Response <- c(Cols.Response, paste0(Qs[i], ColTypes))
}

Cols.Response <- Cols.Response[-1]

rm(ColTypes, Groups)

## Renaming Columns ----
RAT.Cols <- c(Cols.Example, Cols.Response)
colnames(df_rat) <- RAT.Cols

rm(Cols.Example)

# ----- REMOVING SUPERFLUOUS COLUMNS -----
# I don't know what ISI Timing or the Practice columns could possibly tell us
## Removing ISI Timing ----
df_rat <- df_rat[, -c(grep("Example.", colnames(df_rat)),grep("ISI.", colnames(df_rat)))]

# ----- PIVOTING DATATFRAME -----
## Pivoting Dataframe Based on Condition ----
df_rat <- pivot_longer(data = df_rat,
                          cols = grep("\\_", colnames(df_rat)),
                          names_to = c("Question", ".value"),
                          names_sep = "\\_",
                          values_drop_na = TRUE)

# ----- ADDING CORRECT ANSWERS -----
## Creating Answer Vectors ----
Answers <- c("boat", "honey", "pin", "blue", "soap", "fast",
             "copy", "saw", "top", "pack", "under", "sweet",
             "suit", "battle", "power", "watch", "bill", "sugar",
             "bank", "space", "bowl", "ball", "gas", "dog","air",
             "check", "post", "steam", "jelly", "broad", "sore",
             "chair", "day", "pot", "blind", "candle", "cart",
             "camp", "station", "mark", "gate", "field", "tow",
             "salad", "lip")

df_rat$Answer <- NA
for (i in 1:length(rownames(df_rat))){
  for (j in 1:length(Qs)){
   if (df_rat$Question[i] == Qs[j])
     df_rat$Answer[i] <- Answers[j]
  }
}

rm(Answers, Qs, Cols.Response)

## Comparing Responses and desired answers ----
df_rat$Correct <- NA
df_rat$Response[is.na(df_rat$Response)] <- "NO ANSWER"
for (i in 1:length(rownames(df_rat))){
 if (is.na(df_rat$Response[i]))
     df_rat$Correct[i] <- 0
 if (tolower(df_rat$Response[i]) != tolower(df_rat$Answer[i]))
     df_rat$Correct[i] <- 0
 if (tolower(df_rat$Response[i]) == tolower(df_rat$Answer[i]))
     df_rat$Correct[i] <- 1 
}

rm(i)
# ----- CREATING A PERSONAL LEVEL DATAFRAME -----
## Creating a New Dataframe ----
  Rows <- 1:length(sort(rep(unique(df_rat$PID), 3)))
  Cols <- c("PID", "Stage", "Correct", "AvgTime")
  df_rat_pl  <- data.frame(matrix(NA, 
                                nrow = length(Rows), 
                                ncol = length(Cols), 
                                dimnames = list(Rows, Cols)))
  
  rm(Rows, Cols)

## Filling the New Dataframe ----
  df_rat_pl$PID <- sort(rep(unique(df_rat$PID), 3))
  df_rat_pl$Stage <- rep(unique(df_rat$Stage), length(unique(df_rat_pl$PID)))
  for (i in unique(df_rat_pl$Stage)){
    for (j in unique(df_rat_pl$PID)){
      df_rat_pl$Correct[df_rat_pl$Stage == i & df_rat_pl$PID == j] <- sum(as.numeric(df_rat$Correct[df_rat$Stage == i & df_rat$PID == j]))
      df_rat_pl$AvgTime[df_rat_pl$Stage == i & df_rat_pl$PID == j] <- mean(as.numeric(df_rat$PageSubmit[df_rat$Stage == i & df_rat$PID == j]), na.rm =  T)
      df_rat_pl$AvgTime_correct[df_rat_pl$Stage == i & df_rat_pl$PID == j] <- mean(as.numeric(df_rat$PageSubmit[df_rat$Stage == i & df_rat$PID == j & df_rat$Correct == 1]), na.rm =  T)
    }
  }
  
  rm(i, j)

## Removing rows lacking average times ----
## These rows are indicative of missing data
  df_rat_pl <- df_rat_pl[-which(is.na(df_rat_pl$AvgTime)),]
  
# ----- QUALITY ASSURANCE ANALYSES -----
  
  # I want to know, in general, are there differences across groups 
  # in RAT accuracy. This won't necessarily tell us anything about 
  # how effective this measure was, but, if there are differences 
  # by stage, we may get a sense for to what extent practice effects 
  # might be present. 
  
  ## Releveling our Stage Variable ----
  df_rat_pl$Stage <- relevel(as.factor(df_rat_pl$Stage), ref = "Pre-Exposure")
  
  ## Testing Correct Answers ----
  ## Adjusting for Individual ----
  aov <- aov(Correct ~ Stage + Error(PID), data = df_rat_pl)
  summary(aov)
  
  ## Building a New Dataframe of Complete Entries ----
  df_rat_aov <- df_rat_pl %>%
    pivot_wider(names_from = Stage,
                values_from = c(Correct, AvgTime, AvgTime_correct))
  
  df_rat_aov <- subset(df_rat_aov,
                       !is.na(df_rat_aov$`Correct_Pre-Exposure`) & 
                       !is.na(df_rat_aov$`Correct_Immediate Post-Exposure`) &
                       !is.na(df_rat_aov$`Correct_One Week Post-Exposure`))  
  
  # There are differences! So let's take a closer look and see what 
  # the effect size and power are.
  
  ## Effect Sizes from Correct Answers ----
  sjstats::anova_stats(aov, digits = 3)

  # Sufficiently powered (post-hoc, of course) and a non-insignificant 
  # partial omega squared. Let's take a closer look at how these differ
  
  ## Contrasts ----
  # Pre vs. Post
  t.test(df_rat_aov$`Correct_Pre-Exposure`,
         df_rat_aov$`Correct_Immediate Post-Exposure`, 
         paired = TRUE)
  
  # Pre vs. Delay
  t.test(df_rat_aov$`Correct_Pre-Exposure`,
         df_rat_aov$`Correct_One Week Post-Exposure`, 
         paired = TRUE)
  
  # Post vs. Delay
  t.test(df_rat_aov$`Correct_Immediate Post-Exposure`,
         df_rat_aov$`Correct_One Week Post-Exposure`, 
         paired = TRUE)
  
  # Not surprising, Pre is less than Post and Delay but no differences exist between the latter two.
  # Let's visualize this.
  
  ## Correct Answers Plot ----
  (plot <- ggplot(df_rat_pl, aes(x = Stage, y = Correct)) +
    stat_summary(geom="point", fun = mean, size = 3.5) +
    geom_signif(y_position= 4.0, vjust = 3.5, textsize = 6, tip_length = c(.01, -.01), annotations = "**", color = "black", xmin = 1, xmax = 2) +
    geom_signif(y_position= 4.7, vjust = 1.5, textsize = 6, tip_length = c(.01, .01), annotations = "N.S.", color = "black", xmin = 2, xmax = 3) + 
    geom_signif(y_position= 3.35, vjust = 1, textsize = 6, tip_length = c(-.01, -.01), annotations = "**", color = "black", xmin = 1, xmax = 3) +      
    labs(title = "Differences in Correct RAT Responses By Stage",
         subtitle = "Range: 0 correct - 15 correct",
         x =NULL, 
         y ="Number Correct",
         caption = "p > 0.05: N.S. \np < 0.05: * \np < 0.01: ** \np < 0.001: ***") +
    theme_classic() +
    coord_cartesian(ylim=c(2.5, 5.0)) +
    theme(plot.title = element_text(face="bold", size=13, hjust = 0.5)) +
    theme(plot.subtitle = element_text(size = 10, hjust = 0.5, face = "italic")) +
    theme(plot.caption = element_text(size = 8, hjust = 0.0, face = "italic")) +
    theme(axis.title = element_text(size = 12)) +
    theme(axis.text.x = element_text(size = 8, color = "Black")) +
    theme(axis.text.y = element_text(size = 14, color = "Black")))
  
  ## Exporting Visualization ----
  # setwd("S:/Murty_Group/studies/frightnight.02/scripts/R/Regulation/")
  # pdf("Rat_Correct.pdf", width = 6.5, height = 5)
  # plot
  # dev.off()
  
  ## Cleaning Space ----
  rm(plot,aov)
  
  #Nice, so this sort of diminishing returns relationship is about what I 
  # would expect from practice effects. Now, keep in mind, before each 
  # iteration, participants did get a few practice problems, so maybe 
  # this isn't a practice effect, but I'd put money on this being that.
  
  # Let's take a look at the average time of answers next. I assume we'll 
  # see a similar pattern, but decreasing, rather than increasing.
  
  ## Testing practice effects in time ----
  aov <- aov(AvgTime ~ Stage + Error(PID), data = df_rat_pl)
  summary(aov)
  
  # Still significant, which is a good sign for my prediction. 
  # I'm wondering if this holds up with correct answers.
  
  ## Testing practice effects in time ----
  aov <- aov(AvgTime_correct ~ Stage + Error(PID), data = df_rat_pl)
  summary(aov)
  
  ## Effect Sizes for response time ----
  sjstats::anova_stats(aov, digits = 3)
  
  ## Contrasts ----
  # Pre vs. Post
  t.test(df_rat_aov$`AvgTime_Pre-Exposure`,
         df_rat_aov$`AvgTime_Immediate Post-Exposure`, 
         paired = TRUE)
  
  # Pre vs. Delay
  t.test(df_rat_aov$`AvgTime_Pre-Exposure`,
         df_rat_aov$`AvgTime_One Week Post-Exposure`, 
         paired = TRUE)
  
  # Post vs. Delay
  t.test(df_rat_aov$`AvgTime_Immediate Post-Exposure`,
         df_rat_aov$`AvgTime_One Week Post-Exposure`, 
         paired = TRUE)
  
  # Similar relationship, significant differences between points 
  # Pre and Post and Pre and Delay, but not the latter two.
  
  ## Correct Response Time Plot ----
  (plot <- ggplot(df_rat_pl, aes(x = Stage, y = AvgTime)) +
     stat_summary(geom="point", fun = mean, size = 3.5) +
     geom_signif(y_position= 11.6, vjust = 3, textsize = 6, tip_length = c(-.01, .01), annotations = "***", color = "black", xmin = 1, xmax = 2) +
     geom_signif(y_position= 10.6, vjust = 1, textsize = 6, tip_length = c(-.01, -.01), annotations = "N.S.", color = "black", xmin = 2, xmax = 3) + 
     geom_signif(y_position= 12.30, vjust = 2, textsize = 6, tip_length = c(.01, .01), annotations = "***", color = "black", xmin = 1, xmax = 3) +      
     labs(title = "Differences in RAT Response Time By Stage",
          subtitle = "Range: 0.0s - 15.0s",
          x =NULL, 
          y ="Response Time (s)",
          caption = "p > 0.05: N.S. \np < 0.05: * \np < 0.01: ** \np < 0.001: ***") +
     coord_cartesian(ylim=c(10, 12.5)) +
     theme_classic() +
     theme(plot.title = element_text(face="bold", size=13, hjust = 0.5)) +
     theme(plot.subtitle = element_text(size = 10, hjust = 0.5, face = "italic")) +
     theme(plot.caption = element_text(size = 8, hjust = 0.0, face = "italic")) +
     theme(axis.title = element_text(size = 12)) +
     theme(axis.text.x = element_text(size = 10, color = "Black")) +
     theme(axis.text.y = element_text(size = 14, color = "Black")))
  
  # Great (sort of). Prediction holds up.
  
  ## Exporting Visualization ----
  # pdf("Rat_Time.pdf", width = 6.5, height = 5)
  # plot
  # dev.off()
  
  ## Contrasts ----
  # Pre vs. Post
  t.test(df_rat_aov$`AvgTime_Pre-Exposure`,
         df_rat_aov$`AvgTime_Immediate Post-Exposure`, 
         paired = TRUE)
  
  # Pre vs. Delay
  t.test(df_rat_aov$`AvgTime_Pre-Exposure`,
         df_rat_aov$`AvgTime_One Week Post-Exposure`, 
         paired = TRUE)
  
  # Post vs. Delay
  t.test(df_rat_aov$`AvgTime_Immediate Post-Exposure`,
         df_rat_aov$`AvgTime_One Week Post-Exposure`, 
         paired = TRUE)
  
  ## Correct Response Time Plot ----
  (plot <- ggplot(df_rat_pl, aes(x = Stage, y = AvgTime_correct)) +
    stat_summary(geom="point", fun = mean, size = 3.5) +
    geom_signif(y_position= 8.95, vjust = 3, textsize = 6, tip_length = c(-.01, .01), annotations = "***", color = "black", xmin = 1, xmax = 2) +
    geom_signif(y_position= 8.15, vjust = 3, textsize = 6, tip_length = c(-.01, .01), annotations = "N.S.", color = "black", xmin = 2, xmax = 3) + 
    geom_signif(y_position= 7.55, vjust = 1, textsize = 6, tip_length = c(-.01, -.01), annotations = "***", color = "black", xmin = 1, xmax = 3) +      
    labs(title = "Differences in RAT Response Time of Correct Answers By Stage",
         subtitle = "Range: 0.0s - 15.0s",
         x =NULL, 
         y ="Response Time (s)",
         caption = "p > 0.05: N.S. \np < 0.05: * \np < 0.01: ** \np < 0.001: ***") +
    coord_cartesian(ylim=c(7.25, 9.75)) +
    theme_classic() +
    theme(plot.title = element_text(face="bold", size=13, hjust = 0.5)) +
    theme(plot.subtitle = element_text(size = 10, hjust = 0.5, face = "italic")) +
    theme(plot.caption = element_text(size = 8, hjust = 0.0, face = "italic")) +
    theme(axis.title = element_text(size = 12)) +
    theme(axis.text.x = element_text(size = 10, color = "Black")) +
    theme(axis.text.y = element_text(size = 14, color = "Black")))
  
  # Great (sort of). Prediction holds up.

  ## Exporting Visualization ----
  # pdf("Rat_TimeCorrect.pdf", width = 6.5, height = 5)
  # plot
  # dev.off()
  
  ## Cleaning Space ----
  rm(aov, plot)
  
# ----- CREATING A DIFFERENCE VARIABLE -----
  
  ## Creating New Difference Variables ----
  df_rat_pl$CogLoad_Pre <- NA
  df_rat_pl$CogLoad_Post <- NA
  for (i in unique(df_rat_pl$PID)){
    if (length(which(df_rat_pl$PID == i & (df_rat_pl$Stage == "Pre-Exposure" | df_rat_pl$Stage == "Immediate Post-Exposure"))) == 2){
        df_rat_pl$CogLoad_Pre[df_rat_pl$PID == i] <- df_rat_pl$Correct[df_rat_pl$PID == i & df_rat_pl$Stage == "Pre-Exposure"] - df_rat_pl$Correct[df_rat_pl$PID == i & df_rat_pl$Stage == "Immediate Post-Exposure"]
    }
    if (length(which(df_rat_pl$PID == i & (df_rat_pl$Stage == "Immediate Post-Exposure" | df_rat_pl$Stage == "One Week Post-Exposure"))) == 2){
        df_rat_pl$CogLoad_Post[df_rat_pl$PID == i] <- df_rat_pl$Correct[df_rat_pl$PID == i & df_rat_pl$Stage == "One Week Post-Exposure"] - df_rat_pl$Correct[df_rat_pl$PID == i & df_rat_pl$Stage == "Immediate Post-Exposure"]
    }
  }

## Cleaning Space ----
  rm(df_rat, df, RAT.Cols, i, df_rat_aov)
  