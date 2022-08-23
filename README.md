# fright_night_study
### Contact: billy.mitchell@temple.edu
Data and scripts from the manuscript: Emotional Intensity Fails to Predict Spontaneous  Regulation Strategy Usage in a Naturalistic Paradigm

## Structure
All of the data and products for the project are organized into three self-explanatory directories: **1) data**, **2) plots**, and **3) scripts**. 

### Data Directory
The data directory divides the data by study, so data used for Study 01 is in a separate directory from the data we'd used for Study 02 and Study 03. Each Study## directory itself contains directores for source data, raw data, and derivative data. The source data is the data pulled directly from qualtrics, completely unedited and unmodified. It may also include manually coded data, such as the responses that the raters gave for strategy classifications. Raw data is data that has been cleaned up and manipulated into a format that's ready for analysis, but usually not specialized or subsetted in anyway. Derviative data includes dataframes built for a very specific purpose (e.g., person-level dataframes, subsets, etc.). If you'd like to recreate our original analyses using out scripts, you likely will not need to make any modifications to the structure of the data directory or really to access it all, but obviously it is here for folks to explore and use as they wish.

### Plots Directory
The plots directory simply contains the raw plots we had created in R for use in our manuscript. This likely won't be of much interest for others, but we included it for the sake of tranparency and posterity. 

### Scripts Directory
The scripts directory is likely the most interesting to folks, I'd assume. I'd numbered the scripts to make the progression more clear. Each study has two scripts associated with it: 1) a dataframe creation script (identifiable by the "_DFcreation" suffix), and 2) an analysis script (identifiable by the "_analysis" suffix). I'd tried to rearrange the datapulling functions in a way that you could just pull the data directly from github and not have to update your filepaths, but unfortuantely, I kept running into data reading errors. Also, no matter how much coding skill I build I feel like I can never fully understand the ```Here``` package very well, which would eliminate this problem. At the very least, I built the scripts so that, providing you keep the file structure the same, you should only have to update the *Work.Dir* variable near the top of each script to reflect where you've saved the files on your local machine in order to run these scripts successfully. 

