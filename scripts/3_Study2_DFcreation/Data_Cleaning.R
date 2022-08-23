## Data_Cleaning || 1/26/2022"

## Packages I Use ---- 
   library(psych)
   library(tidyverse)


## Identifying our main directory ----
WorkDir <- "C:/Users/wjpmi/Dropbox/My PC (UncleSplashysSaddnessEmporium)/Desktop/Grad School/Projects/Complete/Fright Night/Public_Records/"
Scripts <- paste0(WorkDir,"scripts/3_Study2_DFcreation/")
Export <- paste0(WorkDir, "data/Study_02/Raw/")
Import <- paste0(WorkDir, "data/Study_02/Source/")
  

## Loading Data ----
  setwd(Import)
  df <- read.csv(file = "qualtrics.csv", 
                 header = T, 
                 sep=",", 
                 stringsAsFactors = F,
                 na.strings=c("","N/A"))
  
## Renaming Routing ---- 
  # Routing made sense as a variable name when it was literally routing individuals 
  # to different question sets, but now that we are out of the context of collection, 
  #  it might make more sense as "Stage"
df <- rename(df, Stage = Routing)

## Correcting A-010 ---- 
  # Participant A-010 got away with entering A-10 once so we have to correct that
df$PID[df$PID == "A-10"] <- "A-010"

## Correcting A-012 ---- 
  # A-012 entered several extra numbers following their ID for pre-exposure, 
  # so we have to correct that
df$PID[df$PID == "A-01263772"] <- "A-012"

## Correcting A-025 ---- 
  # A-025 accidentally entered A-024 as the PID for the immediate post-exposure. 
  # Since there are now two A-024s for immediate post-exposure, we confirmed on 
  # the day of the incident that A-025 (who submitted as A-024) completed the 
  # immediate post-exposure questions at 8:20PM and the real A-024 completed the 
  # post-exposure questions at 8:27PM.  
df$PID[df$PID == "A-024" & df$EndDate == "10/12/21 18:20"] <- "A-025"

## Correcting A-057 ---- 
  # A-057 typed in A-052 for pre-exposure, but started their survey after A-052, 
  # so we can differentiate them based on that fact.
df$PID[df$PID == "A-052" & df$StartDate == "10/13/21 20:12"] <- "A-057"

## Correcting A-057 ---- 
  # A-075 an extra space in their ID
df$PID[df$PID == "A-075 "] <- "A-075"

## Correcting Misattributions ---- 
  # Participant A-124 was originally assigned PID A-019, which was already in use. 
  # Therefore, we need to correct the instances in which the wrong PID was entered. 
  # This is simple to do if we just focus on the date on which data was entered. 
df$PID[df$PID == "A-019" & df$Stage == "Pre-Exposure" & df$StartDate == "10/27/21 17:32"] <- "A-124"
df$PID[df$PID == "A-019" & df$Stage == "Immediate Post-Exposure" & df$StartDate == "10/27/21 18:47"] <- "A-124"
df$PID[df$Stage == "One Week Post-Exposure" & df$StartDate == "11/3/21 8:36"] <- "A-124"
df$PID[df$PID == "A-123" & df$Stage == "One Week Post-Exposure" & df$StartDate == "11/5/21 13:59"] <- "A-050"

## Correcting A-057 ---- 
  # A-120's tablet crashed just after having started the survey so it was 
  # restarted. As such, the second entry is the correct one. Unfortunately, it 
  # still did not register as complete because my initial plan (before we decided 
  # to run the sessions at ESP) was to dismiss any individuals who reported having 
  # been to TBTW in the past such that Qualtrics would just shut down if an individual 
  # indicated such and would inform the RA. Unfortunately, that became sort of dismissal 
  # became unfeasible when we were having people transport themselves there and 
  # I forgot to update Qualtrics to stop it. It really only means that we lost 
  # motivation data, which isn't such a bummer, but it also means the data is 
  # viewed as incomplete, so we need to change that.
df$Progress[df$PID == "A-120" & df$StartDate == "10/26/21 15:50"] <- "100"

# Correcting A-114 ----
  # Participant filled out the questionnaire twice and we are using the first entry
df <- df[-(which(df$StartDate == "11/5/21 12:25" & df$PID == "A-114")),]

## Removing Test Trials ----
 # A few times we entered nonsense PIDs to test out Qualtrics. We'll remove those now.
df <- df[-c(which(df$PID == "A-186"), which(df$PID == "1")),]

## Removing Non-Completers and Pilot Data ---- 
  # Participant A-004 has two submissions for the immediate post-exposure, the 
  # one submitted in error can be determined because the RA entered VOID for all 
  # free response options, so we're going to remove that one.
  df <- subset(df, (df$Q907 != "VOID" | is.na(df$Q907)))
  df <- df[-c(1,2),]
  
  # Participants A-018, A-114, and A-120 all have multiple entries, which are only partially
  # completed so we will remove those as well. I'm going to run a general function to search
  # For any cases where a participant has two records and one of them is complete.
  for (i in sort(unique(df$PID))){
    for (j in sort(unique(df$Stage))){
      if (any(df$PID == i & df$Stage == j & df$Progress == 100)){
        if (any(df$PID == i & df$Stage == j & df$Progress != 100)){
          df <- df[-which(df$PID == i & df$Stage == j & df$Progress != 100),]
        }
      }
    }
  }
