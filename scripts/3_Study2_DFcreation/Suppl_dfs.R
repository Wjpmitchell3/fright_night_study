# ----- INSERTING PARTICIPANT LEVEL SUPPLEMENTARY DATA -----

# Our next step should be to pivot the dataframe, but before I do 
# that I want to insert the relevant participant-level variables so 
# that we're not having R do more work than we need it to. These 
# will include Conditions and Measures, RAT scores, Fear Ratings, 
# Demographics information, and experiential information. I'm 
# starting with measures first: 
  
# Packages ----
library(tidyverse)
source("https://github.com/Wjpmitchell3/stinkR/blob/main/remove_NAs.R?raw=TRUE", local = T)

# Specifying filepath ----
WorkDir <- "C:/Users/wjpmi/Dropbox/My PC (UncleSplashysSaddnessEmporium)/Desktop/Grad School/Projects/Complete/Fright Night/Public_Records/"
Scripts <- paste0(WorkDir,"scripts/3_Study2_DFcreation/")
Export <- paste0(WorkDir, "data/Study_02/Raw/")
Import <- paste0(WorkDir, "data/Study_02/Source/")


  ### --- MEASURES ----
## Sourcing Measure Data ----
source(paste0(Scripts, "Measures.R"), local = T)

# We don't need all of individual elements of each measure, just 
# the composites, so I'm going to isolate those.

## Isolating Measures ----
df_suppl <- df_measures[,c(1,107:118)]

## Cleaning Measures ----
rm(df_measures)

### --- DEMOGRAPHICS ----

# Doing the same for demographics:

## Sourcing Demographic Data ----
source(paste0(Scripts, "Demographics.R"))

# and now we'll merge it to the regulation dataframe

## Merging Demographics ----
df_suppl <- merge(df_suppl,
                df_demo,
                by = "PID",
                all.x = T)

## Cleaning Demographics ----
rm(df_demo)

### --- EXPERIENCE ----

# Doing the same for Experience:
  
  ## Sourcing Experience Data ----
source(paste0(Scripts, "Experience.R"))

# There's a lot of stage specific details that are not captured 
# post-exposure that are relevant for our analysis, so we've going 
# to pivot the dataframe wider. Before we do that, we need to remove 
# any duplicate entries of our primary ID variables, and since 
# there are some cases where a participant completed the same stage 
# twice, due to errors or whatever, this applies. I'm going to first 
# identify and remove and rows that are full of NAs:

## Cleaning Experience Data Rows w/ NA Values ----
df_exp <- remove_NAs(df = df_exp, 
                     cols_range = 5:ncol(df_exp))

# Worked like a charm! Now let's reformat this dataframe:
  
#   ## Pivoting Experience Data ----
# df_exp <- pivot_wider(df_exp,
#                       id_cols = c("PID", "Stage"),
#                       names_from = "Stage",
#                       values_from = colnames(df_exp[3:length(colnames(df_exp))]),  
#                       names_sep = "_")
# 
# # I'd like to reduce the length of the new column name prefixes:
# 
# ## Renaming Experience Data Columns ----
# colnames(df_exp) <- colnames(df_exp) %>% 
#   str_replace_all(pattern = "Pre-Exposure",
#                   replacement ="Pre") %>%
#   str_replace_all(pattern = "Immediate Post-Exposure",
#                   replacement ="Imm") %>%
#   str_replace_all(pattern = "One Week Post-Exposure",
#                   replacement ="Del")

# Once again, going to remove columns with only NA Values to only 
# keep relevant data:

## Cleaning Experience Data Rows w/ NA Values ----
df_exp <- remove_NAs(df = df_exp)

# and now we'll merge it to the regulation dataframe

## Merging Demographics ----
df_suppl <- merge(df_suppl,
                df_exp,
                by = "PID",
                all.x = T)

## Cleaning Demographics ----
rm(df_exp)

### --- RAT ----

# Doing the same for the RAT:
  
  ## Sourcing Experience Data ----
source(paste0(Scripts, "RAT.R"))

## Merging Demographics ----
df_suppl <- merge(df_suppl,
                 df_rat_pl,
                 by = c("PID", "Stage"),
                 all.y = T)

## Cleaning RAT space ----
rm(df_rat_pl)

### ----- CONDITION -----

# Participants were assigned to different conditions which determined how
# they interacted with the stimuli inside. Not super important for our
# purposes, but I want to at least track it.

## Importing Conditions ----
df_cond <- read.csv(paste0(Import,"GoalAssignments.csv"),
                    header = T)

## Subsetting Conditions ----
df_cond <- subset(df_cond, select = c("PID", "Code", "Date_HH", "Time_HH"))

## Scoring Condition ----
df_cond$Code[df_cond$Code == 0] <- "Control"
df_cond$Code[df_cond$Code == 1] <- "Crypt_share"
df_cond$Code[df_cond$Code == 2] <- "Crypt_test"

## Creating a Group Variable ----
df_cond$Group <- NA
for (i in 1:nrow(unique(df_cond[,3:4]))){
  for (j in 1:nrow(df_cond)){
    if (all(cbind(df_cond[j,3:4]) == unique(df_cond[,3:4])[i,])){
        df_cond$Group[j] <- paste("Group", i)
    }
  }
}

## Renaming Variables -----
df_cond <- rename(df_cond,
                  c(Cond = Code))

## Restructuring Variables ----
df_cond$Cond <- as.factor(df_cond$Cond)
df_cond$Date_HH <- as.factor(df_cond$Date_HH)
df_cond$Time_HH <- as.factor(df_cond$Time_HH)
df_cond$Group <- as.factor(df_cond$Group)

## Merging Conditions ----
df_suppl <- merge(df_suppl,
                df_cond,
                by = "PID",
                all.x = T)

## Cleaning Conditions ----
rm(df_cond)

### ----- FEAR RATING -----

# Participants collected fear ratings throughout the house

## Importing Conditions ----
df_fear <- read.csv(paste0(Import,"fearrating.csv"),
                    header = T)

## Merging Conditions ----
df_suppl <- merge(df_suppl,
                df_fear,
                by = "PID",
                all.x = T)

## Cleaning Conditions ----
rm(df_fear)
