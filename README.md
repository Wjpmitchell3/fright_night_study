# fright_night_study
### Contact: BLINDED@BLINDED.edu
Data and scripts from the manuscript: Emotion regulation strategy usage in a quasi-naturalistic context

## Structure
All of the data and products for the project are organized into four self-explanatory directories: **1) data**, **2) plots**, **3) qualtrics**, and **4) scripts**. 

### Data Directory
The data directory divides the data by study, so data used for Study 01 is in a separate directory from the data we'd used for Study 02 and Study 03. Each Study directory itself contains directores for source data, raw data, and derivative data. The source data is the data pulled directly from qualtrics, completely unedited and unmodified. It may also include manually coded data, such as the responses that the raters gave for strategy classifications. Raw data is data that has been cleaned up and manipulated into a format that's ready for analysis, but usually not specialized or subsetted in anyway. Derviative data includes dataframes built for a very specific purpose (e.g., person-level dataframes, subsets, etc.). If you'd like to recreate our original analyses using out scripts, you likely will not need to make any modifications to the structure of the data directory or really to access it all, but obviously it is here for folks to explore and use as they wish.

### Plots Directory
The plots directory simply contains the raw plots we had created in R for use in our manuscript. This likely won't be of much interest for others, but we included it for the sake of tranparency and posterity. 

## Qualtrics Directory
The qualtrics directory contains the actual questionnaires participants responded to in the form of .QSF files exported from qualtrics. In order to view these, you would need to import them into qualtrics. These are likely only of interest if you'd like to replicate this study or use our questionnaires as a foundation for your own study. 

### Scripts Directory
The scripts directory is likely the most interesting to folks, I'd assume. I'd numbered the scripts to make the progression more clear. Using the `here` function from the `here` package, which will automatically identify filepaths for the scripts and data currently being used, should allow users to be able to download our repository and run the scripts as they are without input from the user, **providing no changes to file structure are made**. Each study has two scripts associated with it: 1) a dataframe creation script (identifiable by the "_DFcreation" suffix), and 2) an analysis script (identifiable by the "_analysis" suffix). All scripts are heavily commented to explain what each step is accomplishing and, when applicable, how we are accomplishing it. The scripts have been optimized to generate minimal warnings, but in some cases, such as with ```stargazer()```'s well-known *NULL length* message, warnings could not be avoided. In each case, an explanation for what the warning is telling us is provided, including a link to external documentation, and I explain why the warning is of minimal concern towards the goal of our analyses. If anything is unclear, please contact the author; I'd be happy to walk through any issues.  

It should be noted that I'd opted to format each script as an R Markdown file (.RMD) rather than a vanilla R script (.R). R Markdown is a notebook-style scripting format (similar to a Jupyter Notebook for Python) which allows the programmer greater freedom in how the functions they enter are presented and conveniently centralizes all of the output to the viewer window. It operates the same as a vanilla R script, but adds additional functionality making it ideal for communicating the analytic process to others. Users unfamiliar with R Markdown might be interested in [this helpful .PDF summary of R Markdown and its functions hosted by the R Core Team](https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf). The author also has written a tutorial on how to use R Markdown that they will link to in the future, but which I will refrain from including at the moment due to the blinding that must occur for the review process.  

It should also be noted that scripts for Study 2 utilize custom functions sourced from GitHub which will make datawrangling easier. Sourcing these scripts requires an active internet connection. In the event that you would like to run these scripts without an internet connection, you would need to download said functions and either add them to the script directly, or save them as an .R (not .RMD) file and replace the URL under ```source()``` with the filepath leading to the .R file containing the function.  

  

