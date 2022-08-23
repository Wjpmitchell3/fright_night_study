## SCRIPT START ----

# Packages I Use}
   library(psych)
   library(tidyverse)

# This is probably irrelevant for this process but I just always add this to any script for good measure.
# Number Formatting ----
  options(scipen=100)
  options(digits=3)
  options(tinytex.verbose = TRUE)

# Specifying filepath ----
  WorkDir <- "C:/Users/wjpmi/Dropbox/My PC (UncleSplashysSaddnessEmporium)/Desktop/Grad School/Projects/Complete/Fright Night/Public_Records/"
  Scripts <- paste0(WorkDir,"scripts/3_Study2_DFcreation/")
  Export <- paste0(WorkDir, "data/Study_02/Raw/")
  Import <- paste0(WorkDir, "data/Study_02/Source/")
  

## LOADING IN DATA ----
# Pulling in Cleaned Data ----
  source(paste0(Import,"Data_Cleaning.R"))


## SEPARATING DATAFRAMES ----
# Not all of the variables in the full dataframe are relevant to the validate measures, so I identified the ones that were. Whenever you see [,] following a dataframe it's identifying specific rows, columns or cells in the dataframe. The first place refers to row positions. They can refer to one row or multiple (if multiple, we need to concatenate them together using the c() command). When left blank, we are telling R to use all of the rows in the dataframe. The place after the comma is where we note columns. The numbers refer to their corresponding position in the dataframe. I hand to identify these by hand since the names are currently gibberish. So we are essentially telling R to create a new dataframe named "df_measures" that only contains these specific columns. 
# Separating dataframes into sets ----
  df_measures <- df[,c(18:19, 542:646)]


# ...and then removing any rows that don't have "Pre-Exposure" under the Stage column, since there were no measure questions asked after that stage.
# Removing Empty Rows of Data ----
  df_measures <- subset(df_measures, df_measures$Stage == "Pre-Exposure")

## SCORING BDI ----
# I know I've found more eloquent ways to assign numeric values to categorical variables in the past, but this'll have to do the trick now.
# Assigning Numeric Values to BDI Responses ----
df_measures$BDI.01[df_measures$BDI.01 == "I do not feel sad."] <- 0
df_measures$BDI.01[df_measures$BDI.01 == "I feel sad."] <- 1
df_measures$BDI.01[df_measures$BDI.01 == "I am sad all the time and I can't snap out of it."] <- 2
df_measures$BDI.01[df_measures$BDI.01 == "I am so sad and unhappy that I can't stand it."] <- 3
df_measures$BDI.02[df_measures$BDI.02 == "I am not particularly pessimistic or discouraged about the future."] <- 0
df_measures$BDI.02[df_measures$BDI.02 == "I feel discouraged about the future."]  <- 1
df_measures$BDI.02[df_measures$BDI.02 == "I feel I have nothing to look forward to."]  <- 2
df_measures$BDI.02[df_measures$BDI.02 == "I feel the future is hopeless and that things cannot improve."]  <- 3
df_measures$BDI.03[df_measures$BDI.03 == "I do not feel like a failure."] <- 0
df_measures$BDI.03[df_measures$BDI.03 == "I feel I have failed more than the average person."]  <- 1
df_measures$BDI.03[df_measures$BDI.03 == "As I look back on my life, all I can see is a lot of failures."]  <- 2
df_measures$BDI.03[df_measures$BDI.03 == "I feel I am a complete failure as a person."] <- 3
df_measures$BDI.04[df_measures$BDI.04 == "I am not particularly dissatisfied."] <- 0
df_measures$BDI.04[df_measures$BDI.04 == "I don't enjoy things the way I used to."] <- 1
df_measures$BDI.04[df_measures$BDI.04 == "I don't get satisfaction out of anything anymore."] <- 2
df_measures$BDI.04[df_measures$BDI.04 == "I am dissatisfied with everything."] <- 3
df_measures$BDI.05[df_measures$BDI.05 == "I don't feel particularly guilty."] <- 0
df_measures$BDI.05[df_measures$BDI.05 == "I feel guilty over many things I have done or should have done."] <- 1
df_measures$BDI.05[df_measures$BDI.05 == "I feel quite guilty most of the time."] <- 2
df_measures$BDI.05[df_measures$BDI.05 == "I feel guilty all of the time."] <- 3
df_measures$BDI.06[df_measures$BDI.06 == "I don't feel disappointed in myself."] <- 0
df_measures$BDI.06[df_measures$BDI.06 == "I am disappointed in myself."] <- 1
df_measures$BDI.06[df_measures$BDI.06 == "I am disgusted with myself."] <- 2
df_measures$BDI.06[df_measures$BDI.06 == "I hate myself."] <- 3
df_measures$BDI.07[df_measures$BDI.07 == "I have not lost interest in other people."] <- 0
df_measures$BDI.07[df_measures$BDI.07 == "I am less interested in other people than I used to be."] <- 1
df_measures$BDI.07[df_measures$BDI.07 == "I have lost most of my interest in other people."] <- 2
df_measures$BDI.07[df_measures$BDI.07 == "I have lost all of my interest in other people."] <- 3
df_measures$BDI.08[df_measures$BDI.08 == "I make decisions about as well as I ever could."] <- 0
df_measures$BDI.08[df_measures$BDI.08 == "I put off making decisions more than I used to."] <- 1
df_measures$BDI.08[df_measures$BDI.08 == "I have greater difficulty in making decisions more than I used to."] <- 2
df_measures$BDI.08[df_measures$BDI.08 == "I can't make any decisions at all anymore."] <- 3
df_measures$BDI.09[df_measures$BDI.09 == "I don't feel that I look any worse than I used to."] <- 0
df_measures$BDI.09[df_measures$BDI.09 == "I am worried that I am looking old or unattractive."] <- 1
df_measures$BDI.09[df_measures$BDI.09 == "I feel that there are permanent changes in my appearance and they make me look unattractive."] <- 2
df_measures$BDI.09[df_measures$BDI.09 == "I believe that I look ugly."] <- 3
df_measures$BDI.10[df_measures$BDI.10 == "I can work about as well as before."] <- 0
df_measures$BDI.10[df_measures$BDI.10 == "It takes extra effort to get started at doing something."] <- 1
df_measures$BDI.10[df_measures$BDI.10 == "I have to push myself very hard to do anything."] <- 2
df_measures$BDI.10[df_measures$BDI.10 == "I can't do any work at all."] <- 3
df_measures$BDI.11[df_measures$BDI.11 == "I don't get more tired than usual."] <- 0
df_measures$BDI.11[df_measures$BDI.11 == "I get tired more easily than I used to."] <- 1
df_measures$BDI.11[df_measures$BDI.11 == "I get tired from doing almost anything."] <- 2
df_measures$BDI.11[df_measures$BDI.11 == "I get too tired to do anything."] <- 3
df_measures$BDI.12[df_measures$BDI.12 == "My appetite is no worse than usual."] <- 0
df_measures$BDI.12[df_measures$BDI.12 == "My appetite is not as good as it used to be."] <- 1
df_measures$BDI.12[df_measures$BDI.12 == "My appetite is much worse now."] <- 2
df_measures$BDI.12[df_measures$BDI.12 == "I have no appetite at all anymore."] <- 3

# Restructuring BDI Variables as Numeric ----
BDI.Cols <- grep("BDI", colnames(df_measures))
for (i in BDI.Cols){
  df_measures[,i] <- as.numeric(df_measures[,i])
}

# Calculating BDI ----
for (i in 1:length(rownames(df_measures))){
  df_measures$BDI_Total[i] <- sum(df_measures[i,BDI.Cols])
}

# Removing BDI We No Longer Need ----
rm(BDI.Cols, i)

## SCORING ERQ ----
# Assigning Numeric Values to ERQ Responses ----
ERQ.Cols <- grep("ERQ", colnames(df_measures))
for (i in ERQ.Cols){
  for (j in 1:length(rownames(df_measures))){
    if (df_measures[j,i] == "Strongly disagree" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 1
    if (df_measures[j,i] == "Disagree" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 2
    if (df_measures[j,i] == "Somewhat disagree" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 3
    if (df_measures[j,i] == "Neither agree nor disagree" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 4
    if (df_measures[j,i] == "Somewhat agree" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 5
    if (df_measures[j,i] == "Agree" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 6
    if (df_measures[j,i] == "Strongly agree" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 7    
  }
}

# Restructuring ERQ Variables as Numeric ----
for (i in ERQ.Cols){
  df_measures[,i] <- as.numeric(df_measures[,i])
}

# Calculating ERQ ----
df_measures$ERQ_CogReap <- df_measures$ERQ.01 + df_measures$ERQ.03 + 
                           df_measures$ERQ.05 + df_measures$ERQ.07 + 
                           df_measures$ERQ.08 + df_measures$ERQ.10

df_measures$ERQ_ExpSup <- df_measures$ERQ.02 + df_measures$ERQ.04 + 
                          df_measures$ERQ.06 + df_measures$ERQ.09

# Removing ERQ We No Longer Need ----
rm(ERQ.Cols, i, j)

## SCORING IUS ----
# Assigning Numeric Values to IUS Responses ----
IUS.Cols <- grep("IUS", colnames(df_measures))
for (i in IUS.Cols){
  for (j in 1:length(rownames(df_measures))){
    if (df_measures[j,i] == "Not at all characteristic of me" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 1
    if (df_measures[j,i] == "A little characteristic of me" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 2
    if (df_measures[j,i] == "Somewhat characteristic of me" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 3
    if (df_measures[j,i] == "Very characteristic of me" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 4
    if (df_measures[j,i] == "Entirely characteristic of me" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 5
  }
}

# Restructuring IUS Variables as Numeric ----
for (i in IUS.Cols){
  df_measures[,i] <- as.numeric(df_measures[,i])
}

# Calculating IUS ----
for (i in 1:length(rownames(df_measures))){
  df_measures$IUS_Total[i] <- sum(df_measures[i,IUS.Cols])
  df_measures$IUS_F1[i] <- sum(df_measures[i,IUS.Cols[-c(4, 5, 6, 7, 8, 10, 11, 18, 19, 21, 26, 27)]])
  df_measures$IUS_F2[i] <- sum(df_measures[i,IUS.Cols[c(4, 5, 6, 7, 8, 10, 11, 18, 19, 21, 26, 27)]])
}

# Removing IUS We No Longer Need ----
rm(IUS.Cols, i, j)

## SCORING STAI ----
# Assigning Numeric Values to STAI Responses ----
STAI.Cols <- grep("STAI", colnames(df_measures))
for (i in STAI.Cols){
  for (j in 1:length(rownames(df_measures))){
    if (df_measures[j,i] == "Not at all" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 1
    if (df_measures[j,i] == "Somewhat" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 2
    if (df_measures[j,i] == "Moderately so" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 3
    if (df_measures[j,i] == "Very much so" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 4
  }
}

# Restructuring STAI Variables as Numeric ----
for (i in STAI.Cols){
  df_measures[,i] <- as.numeric(df_measures[,i])
}

# Reverse Scoring STAI ----
STAI.Cols.r <- STAI.Cols[c(1,2,5,8,10,11,15,16,19,20,21,26,27,30,31,35,36,39)]
for (i in STAI.Cols.r){
  df_measures[,i] <- 5 - df_measures[,i]
}

# Calculating STAI ----
for (i in 1:length(rownames(df_measures))){
  df_measures$STAI_State[i] <- sum(df_measures[i, STAI.Cols[-c(1:20)]])
  df_measures$STAI_Trait[i] <- sum(df_measures[i, STAI.Cols[c(1:20)]])
}

# Removing STAI We No Longer Need ----
rm(STAI.Cols, STAI.Cols.r, i, j)
        
## SCORING IRQ ----
# Assigning Numeric Values to IRQ Responses ----
IRQ.Cols <- grep("IRQ", colnames(df_measures))
for (i in IRQ.Cols){
  for (j in 1:length(rownames(df_measures))){
    if (df_measures[j,i] == "Strongly disagree" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 1
    if (df_measures[j,i] == "Disagree" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 2
    if (df_measures[j,i] == "Somewhat disagree" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 3
    if (df_measures[j,i] == "Neither agree nor disagree" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 4
    if (df_measures[j,i] == "Somewhat agree" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 5
    if (df_measures[j,i] == "Agree" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 6
    if (df_measures[j,i] == "Strongly agree" & !is.na(df_measures[j,i]))
      df_measures[j,i] <- 7   
  }
}

# Restructuring IRQ Variables as Numeric ----
for (i in IRQ.Cols){
  df_measures[,i] <- as.numeric(df_measures[,i])
}

# Calculating IRQ ----
for (i in 1:length(rownames(df_measures))){
  df_measures$IRQ_NT[i] <- sum(df_measures[i, IRQ.Cols[c(1:4)]])
  df_measures$IRQ_NE[i] <- sum(df_measures[i, IRQ.Cols[c(5:8)]])
  df_measures$IRQ_PT[i] <- sum(df_measures[i, IRQ.Cols[c(9:12)]])
  df_measures$IRQ_PE[i] <- sum(df_measures[i, IRQ.Cols[c(13:16)]])
}

# Removing IRQ We No Longer Need ----
rm(IRQ.Cols, i, j)
        
## EXPORTING DATAFRAME ----
# Exporting my hard work ----
  df_measures <- df_measures[,-2]
  setwd(Export)
  write.csv(df_measures,
            file="df_measures.csv", 
            na = "N/A")
  
