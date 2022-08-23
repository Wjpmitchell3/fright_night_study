library(tidyverse)
install.packages("lexicon")
library(lexicon)

## Specifying Filepaths ----
WorkDir <- "C:/Users/wjpmi/Dropbox/My PC (UncleSplashysSaddnessEmporium)/Desktop/Grad School/Projects/Complete/Fright Night/Public_Records/"
Scripts <- paste0(WorkDir,"scripts/3_Study2_DFcreation/")
Export <- paste0(WorkDir, "data/Study_02/Raw/")
Import <- paste0(WorkDir, "data/Study_02/Source/")

df <- read.table(paste0(Import,"NRC-VAD-Lexicon.txt"), 
                 header = FALSE, 
                 sep = "^", 
                 dec = ".")

df$Word <- gsub(pattern = "[^a-zA-Z]",
              replacement = "",
              x = df$V1)

df$V1 <- str_replace_all(string = df$V1,
                         pattern = "[a-zA-Z]",
                         replacement = "")

df$Valence <- str_extract(string = df$V1, 
                          pattern = "[[:digit:]]+\\.[[:digit:]]+")

df$V1 <- str_replace(string = df$V1,
                     pattern = "[[:digit:]]+\\.[[:digit:]]+",
                     replacement = "")

df$Arousal <- str_extract(string = df$V1, 
                          pattern = "[[:digit:]]+\\.[[:digit:]]+")

df$V1 <- str_replace(string = df$V1,
                     pattern = "[[:digit:]]+\\.[[:digit:]]+",
                     replacement = "")

df$Dominance <- str_extract(string = df$V1, 
                          pattern = "[[:digit:]]+\\.[[:digit:]]+")

df <- df[,-1]

nrc <- as.data.frame(nrc_emotions)

nrc <- merge(x = df,
             y = nrc,
             by.x = "Word",
             by.y = "term",
             all.x = TRUE)

rm(df)
