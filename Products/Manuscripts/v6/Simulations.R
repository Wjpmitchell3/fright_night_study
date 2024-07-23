# Dependencies
library(tidyverse)

# Setting a seed for randomization
set.seed(123)

# Creating a function to specify the mean of a distribution
mean_fixer <- function(distribution = ., target_mean, min = 1, max = 5){
  
  # Adjust the values to center the mean around 4.5
  while (mean(distribution) != target_mean) {
    diff <- target_mean - mean(distribution)
    if (diff > 0) {
      # Increase the value of a random element by 1 (if less than 5)
      idx <- sample(which(distribution < max), 1)
      distribution[idx] <- distribution[idx] + 1
    } else {
      # Decrease the value of a random element by 1 (if greater than 1)
      idx <- sample(which(distribution > min), 1)
      distribution[idx] <- distribution[idx] - 1
    }
  }
  return(distribution)
}

# Generate initial random sample of 100 values between 1 and 5
HighInt_Prereg<- sample(1:5, 100, replace = TRUE) %>%
                 mean_fixer(target_mean = 4.5)
LowInt_Prereg<- sample(1:5, 100, replace = TRUE) %>%
                 mean_fixer(target_mean = 3)

# In line with a effect size in emotion reduction, as observed in cite:
HighInt_Postreg<- sample(1:5, 100, replace = TRUE) %>%
                 mean_fixer(target_mean = 2)
LowInt_Postreg<- sample(1:5, 100, replace = TRUE) %>%
                 mean_fixer(target_mean = 1.5)

# Demonstrating that there are substantive differences
t.test(HighInt_Postreg, HighInt_Prereg)
t.test(HighInt_Postreg, LowInt_Postreg)
t.test(LowInt_Postreg, LowInt_Prereg)
t.test(HighInt_Prereg, LowInt_Prereg)

# Combining the values into a dataframe 


# TO DEMONSTRATE REGULATION SUCCESS