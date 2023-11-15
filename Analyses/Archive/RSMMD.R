df <- read.csv("C:/Users/Administrator/Documents/GitHub/fright_night_study/data/allSubsLIWC-HRData.csv") %>%
      subset(.$CodedRegType == "1" | .$CodedRegType == "2" | .$CodedRegType == "1 & 3" | .$CodedRegType == "1 & 4") %>%
      subset(!is.na(.$ZScoreRMSSD) & !is.na(.$Gender))

df$CodedRegType[df$CodedRegType == "1 & 3"] <- 1
df$CodedRegType[df$CodedRegType == "1 & 4"] <- 1

df$CodedRegType <- as.factor(df$CodedRegType)
df$PID <- as.factor(df$PID)

m0 <- glmer(CodedRegType ~ (1 | PID), data = df, family = binomial)
icc(m0)
m1 <- glmer(CodedRegType ~ ZScoreRMSSD + (1 | PID), data = df, family = binomial)
anova(m0, m1)
summary(m1)

m2 <- glmer(CodedRegType ~ ZScoreRMSSD + BaselineRMSSD + (1 | PID), data = df, family = binomial)
anova(m1, m2)
m3 <- glmer(CodedRegType ~ ZScoreRMSSD + Gender + (1 | PID), data = df, family = binomial)
anova(m1, m3)
m4 <- glmer(CodedRegType ~ ZScoreRMSSD + EmotionExtent + (1 | PID), data = df, family = binomial)
anova(m1, m4)

summary(lmer(EmotionExtent ~ ZScoreRMSSD + Gender * df$BaselineRMSSD + (1 | PID), data = df))

sjPlot::plot_model(m1, type = "pred")
