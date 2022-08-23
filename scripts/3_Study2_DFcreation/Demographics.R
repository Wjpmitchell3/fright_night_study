## SCRIPT START ----

# Packages I Use ----
   library(psych)
   library(tidyverse)

# Number Formatting ----
  options(scipen=100)
  options(digits=3)
  options(tinytex.verbose = TRUE)
  
# Specifying filepath ----
  WorkDir <- "C:/Users/wjpmi/Dropbox/My PC (UncleSplashysSaddnessEmporium)/Desktop/Grad School/Projects/Complete/Fright Night/Public_Records/"
  Scripts <- paste0(WorkDir,"scripts/3_Study2_DFcreation/")
  Export <- paste0(WorkDir, "data/Study_02/Raw/")
  Import <- paste0(WorkDir, "data/Study_02/Source/")
  
  
# Pulling in Cleaned Data ----
  source(paste0(Scripts,"Data_Cleaning.R"))

## SEPARATING DATAFRAMES ----
# Separating dataframes into sets ----
  df_demo <- df[,c(18:19, 666:673)]

# Removing Empty Rows of Data ----
  df_demo <- subset(df_demo, df_demo$Stage == "Pre-Exposure")


## CLEANING DEMOGRAPHICS ===
# We left gender open ended which was a little bit of a mistake so here 
# I'm trying to categorize all of the possible responses into one of four categories...
# Standardizing Gender ----
  df_demo$Gender[df_demo$Gender == "Female" | df_demo$Gender == "female" | 
                         df_demo$Gender == "femal" | df_demo$Gender == "Female Cisgendered" |
                         df_demo$Gender == "Femal" | df_demo$Gender == "woman" | 
                         df_demo$Gender == "Woman" | df_demo$Gender == "women" |
                         df_demo$Gender == "She/Her" | df_demo$Gender == "FEMALE" |
                         df_demo$Gender == "F" | 
                         (df_demo$Gender == "STRAIGHT" & df_demo$Sex == "Female") ] <- 0
  df_demo$Gender[df_demo$Gender == "Male" | df_demo$Gender == "male" | 
                         df_demo$Gender == "MALE" | df_demo$Gender == "He/Him" |
                         df_demo$Gender == "Transgender Male"   ] <- 1
  df_demo$Gender[df_demo$Gender == "NonBinary" | df_demo$Gender == "Gender non-conforming " | 
                         df_demo$Gender == "genderfluid" | df_demo$Gender == "pangender" ] <- 2
  df_demo$Gender[df_demo$Gender == "Prefer not to specify " ] <- 3

# ...and then naming those categories. 
# Creating a categorical Gender Variable ----
  df_demo$Gender.cat[df_demo$Gender == "0" ] <- "Female"  
  df_demo$Gender.cat[df_demo$Gender == "1" ] <- "Male"  
  df_demo$Gender.cat[df_demo$Gender == "2" ] <- "Non-Binary"    
  df_demo$Gender.cat[df_demo$Gender == "3" ] <- "N/A"

# R won't understand the ranked order inherent to some of the points in this factor, 
# so we're adding a numeric value to this variable so that the order can be understood by R
# Creating a Ranked Factor Variable for Education ----
df_demo$Education.Num[df_demo$Education.Cat == "Some high school"] <- 0
df_demo$Education.Num[df_demo$Education.Cat == "High school degree or GED"] <- 1
df_demo$Education.Num[df_demo$Education.Cat == "Some college"] <- 2
df_demo$Education.Num[df_demo$Education.Cat == "Vocational / technical / trade training"] <- 3
df_demo$Education.Num[df_demo$Education.Cat == "College degree (BA, BS, etc.)"] <- 4
df_demo$Education.Num[df_demo$Education.Cat == "Some graduate school"] <- 5
df_demo$Education.Num[df_demo$Education.Cat == "Graduate school degree (MA, MS, PhD, etc.)"] <- 6

# Same thing here. 
# Creating a Ranked Factor Variable for Income ----
df_demo$Income.Num[df_demo$Income.Cat == "under $15,000"] <- 0
df_demo$Income.Num[df_demo$Income.Cat == "$15,001 - $25,000"] <- 1
df_demo$Income.Num[df_demo$Income.Cat == "$25,001 - $35,000"] <- 2
df_demo$Income.Num[df_demo$Income.Cat == "$35,001 - $50,000"] <- 3
df_demo$Income.Num[df_demo$Income.Cat == "$50,001 - $75,000"] <- 4
df_demo$Income.Num[df_demo$Income.Cat == "$75,001 - $100,000"] <- 5
df_demo$Income.Num[df_demo$Income.Cat == "$100,001 - $150,000"] <- 6
df_demo$Income.Num[df_demo$Income.Cat == "over $150,000"] <- 7

## EXPORTING DATAFRAME ----
# Exporting my hard work ----
  df_demo <- df_demo[,-2]
  setwd(Export)
  write.csv(df_demo,
            file="df_demo.csv", 
            na = "N/A")
  
