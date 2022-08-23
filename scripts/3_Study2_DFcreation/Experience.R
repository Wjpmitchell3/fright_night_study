## SCRIPT START ----
# Packages I Use ----
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
  

# Pulling in Cleaned Data ----
  source(paste0(Import, "Data_Cleaning.R"))

## SEPARATING DATAFRAMES ----
# Separating dataframes into sets ----
  df_exp <- df[,c(18:19, 647:665, 805:838, 1186:1211)]

## CLEANING EXPERIENCE ----
#We asked everyone whether they had been to TBTW in the past during screening AND at baseline, 
# so that's what this value captures. I'm just taking whatever value individuals indicated at 
# baseline and carrying it forward to later stages.
# Filling in missing TBTW spaces ----
for (i in sort(unique(df_exp$PID))){
  df_exp$TBTW[df_exp$PID == i & df_exp$Stage != "Pre-Exposure"] <- df_exp$TBTW[df_exp$PID == i & df_exp$Stage == "Pre-Exposure"]
}
df_exp <- rename(df_exp, TBTW.Previous = TBTW)
df_exp <- rename(df_exp, TBTW.Confirm = TBTW.Check)

## CONSOLIDATING VARIABLES ----
# We captured anticipation of positive and negative emotions three times throughout the process. 
# Each time the question was asked, we were measuring the same time point, but testing how memory 
# of anticipation might change over time, so the question wasn't identical, but was rephrased so 
# that it was targeting the same feelings as the time at which it was asked changed. As such, we 
# want to move this variable into the same column.
# Consolidating Anticipation Responses ----
for (i in 1:length(rownames(df_exp))){
  if (df_exp$Stage[i] == "Pre-Exposure")
    df_exp$Pos.Anticipate[i] <- df_exp$Pos.Anticipate[i]
  if (df_exp$Stage[i] == "Immediate Post-Exposure")
    df_exp$Pos.Anticipate[i] <- df_exp$IPE...Pos.Anticipate[i]
  if (df_exp$Stage[i] == "One Week Post-Exposure")
    df_exp$Pos.Anticipate[i] <- df_exp$Pos.Anticipat[i]
  if (df_exp$Stage[i] == "Pre-Exposure")
    df_exp$Neg.Anticipate[i] <- df_exp$Neg.Anticipate[i]
  if (df_exp$Stage[i] == "Immediate Post-Exposure")
    df_exp$Neg.Anticipate[i] <- df_exp$IPE...Neg.Anticipate[i]
  if (df_exp$Stage[i] == "One Week Post-Exposure")
    df_exp$Neg.Anticipate[i] <- df_exp$Neg.Anticipat[i]
}

# Same thing with the Fear Before responses.
# Consolidating Fear Before Responses ----
for (i in 1:length(rownames(df_exp))){
  if (df_exp$Stage[i] == "Pre-Exposure")
    df_exp$Fear.Before[i] <- df_exp$Fear.Before[i]
  if (df_exp$Stage[i] == "Immediate Post-Exposure")
    df_exp$Fear.Before[i] <- df_exp$IPE...Fear.Before[i]
  if (df_exp$Stage[i] == "One Week Post-Exposure")
    df_exp$Fear.Before[i] <- df_exp$Fear.Before.1[i]
}

# Same thing with the Fear During and After responses (though we obviously didn't capture 
# those before people went in.
# Consolidating Fear During and After Responses ----
for (i in 1:length(rownames(df_exp))){
  if (df_exp$Stage[i] == "Immediate Post-Exposure")
    df_exp$Fear.During[i] <- df_exp$IPE...Fear.During[i]
  if (df_exp$Stage[i] == "One Week Post-Exposure")
    df_exp$Fear.During[i] <- df_exp$Fear.During[i]
  if (df_exp$Stage[i] == "Immediate Post-Exposure")
    df_exp$Fear.After[i] <- df_exp$IPE...Fear.After[i]
  if (df_exp$Stage[i] == "One Week Post-Exposure")
    df_exp$Fear.After[i] <- df_exp$Fear.After[i]
}

# Consolidating Memory & Fear Questions ----
df_exp$S1.Memory <- NA
df_exp$S2.Memory <- NA
df_exp$S3.Memory <- NA
df_exp$S1.Fear <- NA
df_exp$S2.Fear <- NA
df_exp$S3.Fear <- NA
df_exp$Set.Memory <- NA

for (i in 1:length(rownames(df_exp))){
  if (df_exp$Stage[i] == "Immediate Post-Exposure")
    df_exp$S1.Memory[i] <- df_exp$IPE...S1.Memory[i]
  if (df_exp$Stage[i] == "Immediate Post-Exposure")
    df_exp$S2.Memory[i] <- df_exp$IPE...S2.Memory[i]
  if (df_exp$Stage[i] == "Immediate Post-Exposure")
    df_exp$S3.Memory[i] <- df_exp$IPE...S3.Memory[i]
  if (df_exp$Stage[i] == "Immediate Post-Exposure")
    df_exp$S1.Fear[i] <- df_exp$IPE...S1.Fear[i]
  if (df_exp$Stage[i] == "Immediate Post-Exposure")
    df_exp$S2.Fear[i] <- df_exp$IPE...S2.Fear[i]
  if (df_exp$Stage[i] == "Immediate Post-Exposure")
    df_exp$S3.Fear[i] <- df_exp$IPE...S3.Fear[i]
  if (df_exp$Stage[i] == "Immediate Post-Exposure")
    df_exp$Set.Memory[i] <- df_exp$IPE...Set.Memory[i]  
  if (df_exp$Stage[i] == "One Week Post-Exposure")
    df_exp$S1.Memory[i] <- df_exp$OWPE...S1.Memory[i]
  if (df_exp$Stage[i] == "One Week Post-Exposure")
    df_exp$S2.Memory[i] <- df_exp$OWPE...S2.Memory[i]
  if (df_exp$Stage[i] == "One Week Post-Exposure")
    df_exp$S3.Memory[i] <- df_exp$OWPE...S3.Memory[i]
  if (df_exp$Stage[i] == "One Week Post-Exposure")
    df_exp$S1.Fear[i] <- df_exp$OWPE...S1.Fear[i]
  if (df_exp$Stage[i] == "One Week Post-Exposure")
    df_exp$S2.Fear[i] <- df_exp$OWPE...S2.Fear[i]
  if (df_exp$Stage[i] == "One Week Post-Exposure")
    df_exp$S3.Fear[i] <- df_exp$OWPE...S3.Fear[i]
  if (df_exp$Stage[i] == "One Week Post-Exposure")
    df_exp$Set.Memory[i] <- df_exp$OWPE...Set.Memory[i]  
}

# Consolidating Haunted House Questions ----
for (i in 1:length(rownames(df_exp))){
  if (df_exp$Stage[i] == "Immediate Post-Exposure")
    df_exp$HH.Before[i] <- df_exp$IPE...HH.Before[i]
  if (df_exp$Stage[i] == "One Week Post-Exposure")
    df_exp$HH.Enjoy[i] <- df_exp$OWPE...HH.Enjoy[i]
}

# Consolidating Information Questions ----
for (i in 1:length(rownames(df_exp))){
  if (df_exp$Stage[i] == "One Week Post-Exposure")
    df_exp$Information[i] <- df_exp$OWPE...Information[i]
}

## RENAMING VARIABLES ----
# Renaming Social Support ----
  df_exp <- rename(df_exp, PT5.Support = IPE...PT5.Support)
  df_exp <- rename(df_exp, PT5.Close = IPE...PT5.Close)
  df_exp <- rename(df_exp, PT5.Relation = IPE...PT5.Relation)
  df_exp <- rename(df_exp, PT4.Support = IPE...PT4.Support)
  df_exp <- rename(df_exp, PT4.Close = IPE...PT4.Close)
  df_exp <- rename(df_exp, PT4.Relation = IPE...PT4.Relation)
  df_exp <- rename(df_exp, PT3.Support = IPE...PT3.Support)
  df_exp <- rename(df_exp, PT3.Close = IPE...PT3.Close)
  df_exp <- rename(df_exp, PT3.Relation = IPE...PT3.Relation)
  df_exp <- rename(df_exp, PT2.Support = IPE..PT2.Support)
  df_exp <- rename(df_exp, PT2.Close = IPE...PT2.Close)
  df_exp <- rename(df_exp, PT2.Relation = IPE...PT2.Relation)
  df_exp <- rename(df_exp, PT1.Support = IPE..PT1.Support)
  df_exp <- rename(df_exp, PT1.Close = IPE...PT1.Close)
  df_exp <- rename(df_exp, PT1.Relation = IPE...PT1.Relation)
  df_exp <- rename(df_exp, Social.Support = IPE...Social.Support )
  df_exp <- rename(df_exp, Peer.Number = IPE...Peer.Number)
  df_exp <- rename(df_exp, Peer.Presence = IPE...Peer.Presence)

# Renaming Confound Questions ----
  df_exp <- rename(df_exp, Discuss = OWPE...Discuss)
  df_exp <- rename(df_exp, Discuss.Times = OWPE...Discuss.Times)
  df_exp <- rename(df_exp, Search = OWPE...Search)
  df_exp <- rename(df_exp, Search.Times = OWPE...Search.Time)
  df_exp <- rename(df_exp, Phobias = IPE...Phobias)
  df_exp <- rename(df_exp, Phobias.Desc = IPE...Phobias.Desc.)  
  df_exp <- rename(df_exp, HH.Compare = IPE...HH.Compare)

# Renaming Motivations ----
  df_exp <- rename(df_exp, Motive.Payment = Motivations_1)
  df_exp <- rename(df_exp, Motive.Thrill = Motivations_2)
  df_exp <- rename(df_exp, Motive.Novelty = Motivations_3)
  df_exp <- rename(df_exp, Motive.Challenge = Motivations_4)
  df_exp <- rename(df_exp, Motive.Peers = Motivations_5)
  df_exp <- rename(df_exp, Motive.Science = Motivations_6)
  df_exp <- rename(df_exp, Motive.Bored = Motivations_7)

# Removing Columns w/ Unorganized Data ----
df_exp <- subset(df_exp, 
                        select= c("PID", "Stage", "TBTW.Previous", "TBTW.Confirm", "Pos.Anticipate", "Neg.Anticipate", "Fear.Before",
                                  "Fear.During", "Fear.After", "S1.Fear", "S1.Memory", "S2.Fear", "S2.Memory", "S3.Fear", "S3.Memory",
                                  "Set.Memory", "Peer.Presence", "Peer.Number", "Social.Support", "PT1.Relation", "PT1.Close", "PT1.Support", 
                                  "PT2.Relation", "PT2.Close", "PT2.Support", "PT3.Relation", "PT3.Close", "PT3.Support", "PT4.Relation", 
                                  "PT4.Close", "PT4.Support", "PT5.Relation", "PT5.Close", "PT5.Support", "Startle", "HH.Before", "HH.Compare", 
                                  "HH.Times", "HH.Enjoy","Fear.Enjoy", "Phobias", "Phobias.Desc", "Discuss", "Discuss.Times", "Search", 
                                  "Search.Times", "Motive.Payment", "Motive.Thrill", "Motive.Novelty", "Motive.Challenge", "Motive.Peers", 
                                  "Motive.Science", "Motive.Bored", "Information", "Sources"))

## PIVOTING DATAFRAME ----
# # Pivoting Dataframe Based on Times ----
# df_exp <- pivot_longer(data = df_exp,
#                               cols = starts_with("Motive."),
#                               names_to = "Motive.Cat",
#                               names_prefix = "Motive.",
#                               values_to = "Motive")
# 

## SCORING VARIABLES ----
# Scoring Anticipation Variables ----
Anticip.Cols <- grep("Anticipate", colnames(df_exp))
for (i in Anticip.Cols){
  for (j in 1:length(rownames(df_exp))){
    if (is.na(df_exp[j,i]))
      df_exp[j,i] <- NA
    if (!is.na(df_exp[j,i])){
      if (df_exp[j,i] == "None at all")
        df_exp[j,i] <- 0
      if (df_exp[j,i] == "A little")
        df_exp[j,i] <- 1
      if (df_exp[j,i] == "A moderate amount")
        df_exp[j,i] <- 2
      if (df_exp[j,i] == "A lot")
        df_exp[j,i] <- 3
      if (df_exp[j,i] == "A great deal")
        df_exp[j,i] <- 4
    }
  }
}

# Restructuring Anticipation Variables as Numeric ----
for (i in Anticip.Cols){
  df_exp[,i] <- as.numeric(df_exp[,i])
}

# Removing Anticpation Variables ----
rm(Anticip.Cols)

# Scoring Fear Variables ----
Fear.Cols <- grep(("Fear"), colnames(df_exp))
Fear.Cols <- Fear.Cols[-c(7)]
for (i in Fear.Cols){
  for (j in 1:length(rownames(df_exp))){
    if (is.na(df_exp[j,i]))
      df_exp[j,i] <- NA
    if (!is.na(df_exp[j,i])){
      if (df_exp[j,i] == "Not at all fearful")
        df_exp[j,i] <- 0
      if (df_exp[j,i] == "A little fearful")
        df_exp[j,i] <- 1
      if (df_exp[j,i] == "Moderately fearful")
        df_exp[j,i] <- 2
      if (df_exp[j,i] == "Very fearful")
        df_exp[j,i] <- 3
      if (df_exp[j,i] == "Extremely fearful")
        df_exp[j,i] <- 4
    }
  }
}

# Restructuring Fear Variables as Numeric ----
for (i in Fear.Cols){
  df_exp[,i] <- as.numeric(df_exp[,i])
}

# Removing Fear Variables ----
rm(Fear.Cols)

# Scoring  Variables ----
Memory.Cols <- grep((".Memory"), colnames(df_exp))
Memory.Cols <- Memory.Cols[-c(7)]
for (i in Memory.Cols){
  for (j in 1:length(rownames(df_exp))){
    if (is.na(df_exp[j,i]))
      df_exp[j,i] <- NA
    if (!is.na(df_exp[j,i])){
      if (df_exp[j,i] == "Not at all vivid")
        df_exp[j,i] <- 0
      if (df_exp[j,i] == "A little vivid")
        df_exp[j,i] <- 1
      if (df_exp[j,i] == "Moderately vivid")
        df_exp[j,i] <- 2
      if (df_exp[j,i] == "Very vivid")
        df_exp[j,i] <- 3
      if (df_exp[j,i] == "Extremely vivid")
        df_exp[j,i] <- 4
    }
  }
}

# Restructuring Memory Variables as Numeric ----
for (i in Memory.Cols){
  df_exp[,i] <- as.numeric(df_exp[,i])
}

# Removing Memory Variables ----
rm(Memory.Cols)

# Scoring Support Variables ----
Support.Cols <- grep(("Social.Support"), colnames(df_exp))
for (i in Support.Cols){
  for (j in 1:length(rownames(df_exp))){
    if (is.na(df_exp[j,i]))
      df_exp[j,i] <- NA
    if (!is.na(df_exp[j,i])){
      if (df_exp[j,i] == "Definitely not")
        df_exp[j,i] <- 0
      if (df_exp[j,i] == "Probably not")
        df_exp[j,i] <- 1
      if (df_exp[j,i] == "Probably yes")
        df_exp[j,i] <- 2
      if (df_exp[j,i] == "Definitely yes")
        df_exp[j,i] <- 3
    }
  }
}

# Restructuring Support Variables as Numeric ----
for (i in Support.Cols){
  df_exp[,i] <- as.numeric(df_exp[,i])
}

# Removing Support Variables ----
rm(Support.Cols)

# Scoring Participant Variables ----
Close.Cols <- grep((".Close"), colnames(df_exp))
PT.Cols <- NA
for (i in 1:length(Close.Cols)){
  PT.Cols <- sort(c(PT.Cols, Close.Cols[i], (Close.Cols[i] + 1)))
}

rm(Close.Cols)

for (i in PT.Cols){
  for (j in 1:length(rownames(df_exp))){
    if (is.na(df_exp[j,i]))
      df_exp[j,i] <- NA
    if (!is.na(df_exp[j,i])){
      if (grepl("Not at all", df_exp[j,i]))
        df_exp[j,i] <- 0
      if (grepl("A little", df_exp[j,i]))
        df_exp[j,i] <- 1
      if (grepl("Moderately", df_exp[j,i]))
        df_exp[j,i] <- 2
      if (grepl("Very", df_exp[j,i]))
        df_exp[j,i] <- 3
      if (grepl("Extremely", df_exp[j,i]))
        df_exp[j,i] <- 4      
    }
  }
}

# Restructuring Participant Variables as Numeric ----
for (i in PT.Cols){
  df_exp[,i] <- as.numeric(df_exp[,i])
}

# Removing Participant Variables ----
rm(PT.Cols)

# Scoring Startle Variables ----
Startle.Cols <- grep(("Startle"), colnames(df_exp))
for (i in Startle.Cols){
  for (j in 1:length(rownames(df_exp))){
    if (is.na(df_exp[j,i]))
      df_exp[j,i] <- NA
    if (!is.na(df_exp[j,i])){
      if (grepl("Not at all", df_exp[j,i]))
        df_exp[j,i] <- 0
      if (grepl("A little", df_exp[j,i]))
        df_exp[j,i] <- 1
      if (grepl("Moderately", df_exp[j,i]))
        df_exp[j,i] <- 2
      if (grepl("Very", df_exp[j,i]))
        df_exp[j,i] <- 3
      if (grepl("Extremely", df_exp[j,i]))
        df_exp[j,i] <- 4      
    }
  }
}

# Restructuring Startle Variables as Numeric ----
for (i in Startle.Cols){
  df_exp[,i] <- as.numeric(df_exp[,i])
}

# Removing Startle Variables ----
rm(Startle.Cols)

# Scoring Compare Variables ----
Compare.Cols <- grep(("Compare"), colnames(df_exp))
for (i in Compare.Cols){
  for (j in 1:length(rownames(df_exp))){
    if (is.na(df_exp[j,i]))
      df_exp[j,i] <- NA
    if (!is.na(df_exp[j,i])){
      if (grepl("Much less scary", df_exp[j,i]))
        df_exp[j,i] <- 0
      if (grepl("Less scary", df_exp[j,i]))
        df_exp[j,i] <- 1
      if (grepl("A little less scary", df_exp[j,i]))
        df_exp[j,i] <- 2
      if (grepl("About as scary", df_exp[j,i]))
        df_exp[j,i] <- 3
      if (grepl("A little more scary", df_exp[j,i]))
        df_exp[j,i] <- 4  
      if (grepl("More scary", df_exp[j,i]))
        df_exp[j,i] <- 5 
      if (grepl("Much more scary", df_exp[j,i]))
        df_exp[j,i] <- 6       
    }
  }
}

# Restructuring Compare Variables as Numeric ----
for (i in Compare.Cols){
  df_exp[,i] <- as.numeric(df_exp[,i])
}

# Removing Compare Variables ----
rm(Compare.Cols)

# Scoring Enjoy Variables ----
Enjoy.Cols <- grep(("Enjoy"), colnames(df_exp))
for (i in Enjoy.Cols){
  for (j in 1:length(rownames(df_exp))){
    if (is.na(df_exp[j,i]))
      df_exp[j,i] <- NA
    if (!is.na(df_exp[j,i])){
      if (grepl("Dislike a great deal", df_exp[j,i]))
        df_exp[j,i] <- 0
      if (grepl("Dislike a moderate amount", df_exp[j,i]))
        df_exp[j,i] <- 1
      if (grepl("Dislike a little", df_exp[j,i]))
        df_exp[j,i] <- 2
      if (grepl("Neither like nor dislike", df_exp[j,i]))
        df_exp[j,i] <- 3
      if (grepl("Like a little", df_exp[j,i]))
        df_exp[j,i] <- 4  
      if (grepl("Like a moderate amount", df_exp[j,i]))
        df_exp[j,i] <- 5 
      if (grepl("Like a great deal", df_exp[j,i]))
        df_exp[j,i] <- 6       
    }
  }
}

# Restructuring Enjoy Variables as Numeric ----
for (i in Enjoy.Cols){
  df_exp[,i] <- as.numeric(df_exp[,i])
}

# Removing Enjoy Variables ----
rm(Enjoy.Cols, i, j)

## FILLING IN PARTICIPANT LEVEL DETAILS ----
for (i in unique(df_exp$PID)){

  
  # Sharing Pre-Exposure specific information
  for (j in which(df_exp$PID == i & df_exp$Stage != "Pre-Exposure")){
    df_exp$Startle[j] <- df_exp$Startle[which(df_exp$PID == i & df_exp$Stage == "Pre-Exposure")]
    df_exp$HH.Times[j] <- df_exp$HH.Times[which(df_exp$PID == i & df_exp$Stage == "Pre-Exposure")]
    df_exp$Fear.Enjoy[j] <- df_exp$Fear.Enjoy[which(df_exp$PID == i & df_exp$Stage == "Pre-Exposure")]
    df_exp[j, grep(names(df_exp),pattern = "Motive\\.")] <- df_exp[which(df_exp$PID == i & df_exp$Stage == "Pre-Exposure"), 
                                                                   grep(names(df_exp),pattern = "Motive\\.")]
  }  
  
  # Sharing Immediate Post-Exposure specific information
  for (j in which(df_exp$PID == i & df_exp$Stage != "Immediate Post-Exposure")){
    df_exp[j, 17:34] <- df_exp[which(df_exp$PID == i & df_exp$Stage == "Immediate Post-Exposure"), 17:34]
    df_exp$HH.Compare[j] <- df_exp$HH.Compare[which(df_exp$PID == i & df_exp$Stage == "Immediate Post-Exposure")]
    df_exp$Phobias[j] <- df_exp$Phobias[which(df_exp$PID == i & df_exp$Stage == "Immediate Post-Exposure")]
    df_exp$Phobias.Desc[j] <- df_exp$Phobias.Desc[which(df_exp$PID == i & df_exp$Stage == "Immediate Post-Exposure")]
  }
  
  # Sharing Delayed Post-Exposure specific information
  for (j in which(df_exp$PID == i & df_exp$Stage != "One Week Post-Exposure")){
    if (length(which(df_exp$PID == i & df_exp$Stage == "One Week Post-Exposure")) != 0){
      df_exp$Discuss[j] <- df_exp$Discuss[which(df_exp$PID == i & df_exp$Stage == "One Week Post-Exposure")]
      df_exp$Discuss.Times[j] <- df_exp$Discuss.Times[which(df_exp$PID == i & df_exp$Stage == "One Week Post-Exposure")]
      df_exp$Search[j] <- df_exp$Search[which(df_exp$PID == i & df_exp$Stage == "One Week Post-Exposure")]
      df_exp$Search.Times[j] <- df_exp$Search.Times[which(df_exp$PID == i & df_exp$Stage == "One Week Post-Exposure")]
    }
  }
}

## EXPORTING DATAFRAME ----
# Exporting my hard work ----
  setwd(Export)
  write.csv(df_exp,
            file="df_exp.csv", 
            na = "N/A")