# Dependencies
library(tidyverse)
library(MASS)

# Setting a seed for randomization
set.seed(123456)

# I originally wanted to use an open dataset using the Sheppes paradigm to explore this but I couldn't find a single one that was available online. As such, I am simulating one to meet the described characteristics. 

# Creating a function to generate simulated data

# Specker et al., 2024, which is the only study I know of to capture pre- and post- exposure intensity scores, had 129 subjects who completed 30 trials each and who found a correlation of 0.809 between pre-and post exposure scores. Most paradigms I have seen use a minimum of 1 and a maximum of 9 for their scoring, but I have no study that I'm aware reported average self-report values for pre- or post-exposure. As such I'm estimating an even distribution of 6.5 for pre-exposure and 3.5 for post-exposure 
array_cor <- function(n = 129 * 30, target_cor = 0.809, min = 1, max = 9, mean_x = 6.5, mean_y = 3.5) {

  # Create a correlation matrix
  cor_matrix <- matrix(c(1, target_cor, target_cor, 1), nrow=2)
  
  data <- mvrnorm(n=n, mu=c(0, 0), Sigma=cor_matrix)
  
  # Transform the normal variables to uniform [0, 1]
  data_uniform <- pnorm(data)
  
  # Scale the uniform variables to the range [1, 9] with normal approximation
  array1 <- round(qnorm(data_uniform[, 1], mean = mean_x, sd = 1))
  array2 <- round(qnorm(data_uniform[, 2], mean = mean_y, sd = 1))
  
  # Ensure the values are within the desired range
  array1[array1 < min | array1 > max] <- sample(x = min:max, replace = T, 
                                                size = length(which(array1 < min | array1 > max)))
  array2[array2 < min | array2 > max] <- sample(x = min:max, replace = T, 
                                                size = length(which(array2 < min | array2 > max)))
  
  # Function to adjust correlations to target
  adjust_correlation <- function(array1, array2, target_correlation = target_cor, max_iterations = 1000, tolerance = 0.001, min_ = min, max_ = max) {
    
    current_correlation <- cor(array1, array2)
    iteration <- 0
    
    while (abs(current_correlation - target_correlation) > tolerance & iteration < max_iterations) {
      diff <- target_correlation - current_correlation
      adjust_amount <- diff * 0.1 # Adjust this factor as necessary
      
      array2 <- array2 + adjust_amount
      array2 <- round(array2)
      array2[array2 < min_] <- min_
      array2[array2 > max_] <- max_
      
      current_correlation <- cor(array1, array2)
      iteration <- iteration + 1
    }
    
    return(array2)
  }
  
  array2 <- adjust_correlation(array1, array2)
  
  # Ensure the means are as specified
  adjust_means <- function(array, target_mean, min_ = min, max_ = max) {
    current_mean <- mean(array)
    diff <- target_mean - current_mean
    array_adjusted <- array + round(diff)
    array_adjusted[array_adjusted < min_] <- min_
    array_adjusted[array_adjusted > max_] <- max_
    return(array_adjusted)
  }
  
  array1 <- adjust_means(array1, mean_x)
  array2 <- adjust_means(array2, mean_y)
  
  return(data.frame(X = array1, Y = array2))
}

# Constructing our simulated pre- and post-regulation intensity data as a dataframe

# NOTE: Our target cor value is substantially larger than intended. This is because trying to meet the criteria outlined using randomly sampling is quite difficult and I kept getting very low correlations with the approach below. I effectively settled on tweaking the seed and target_cor until I happened to fall on a near target dataframe. 
df <- array_cor(target_cor = 0.89)
names(df) <- c("Pre", "Post")
df$Strategy <- NULL

# Assessing that we are hitting our target metrics
mean(df$Pre)
mean(df$Post)
cor(df$Pre, df$Post)

# Visualizing the distributions
hist(df$Pre)
hist(df$Post)

# Pulled from Sheppes & Gross 2011; averaging across experiments
Low_Dist <- mean(1 - 0.763, 1 - 0.749, 1 - 0.669)
High_Dist <- mean(0.707, 0.600, 0.643)

# Iterate through all observations
for (ROW in 1:nrow(df)){
  
  # If this is a high-intensity event, use observed probabilities to simulate which strategy the subjects might use
  if (df$Pre[ROW] > mean(df$Pre)){
    df$Strategy[ROW] <- sample(size = 1, x = c("Distraction" , "Reappraisal"), prob = c(High_Dist, 1 - High_Dist))
  }
  
  # If this is a low-intensity event, use observed probabilities to simulate which strategy the subjects might use
  if (df$Pre[ROW] < mean(df$Pre)){
    df$Strategy[ROW] <- sample(size = 1, x = c("Distraction" , "Reappraisal"), prob = c(Low_Dist, 1 - Low_Dist))
  }
  
}

# Because success demonstrated an r = -0.497 correlation to post-regulation values, we're going to try to simulate those as well.

# Defining a new function to simulate a new array given correlated values in an existing array. 
array_scaler <- function(target_array, mean = 3, min = 1, max = 5) {
  
  # Function to scale an array to a specified range and mean
  scale_array_to_range <- function(array = target_array, target_min = min, target_max = max, target_mean = mean) {
    
    # Calculate the current mean and range of the array
    current_mean <- mean(array)
    current_min <- min(array)
    current_max <- max(array)
    
    # Scale the array to the range [0, 1]
    scaled_array <- (array - current_min) / (current_max - current_min)
    
    # Scale the array to the target range [target_min, target_max]
    scaled_array <- scaled_array * (target_max - target_min) + target_min
    
    # Adjust the mean of the scaled array to the target mean
    final_array <- scaled_array - mean(scaled_array) + target_mean
    
    return(final_array)
  }
  
  # Scale the array to match the specified range and mean
  return(scale_array_to_range())

}

# Defining a function to invert values
value_inverter <- function(array = ., max){
  return(max - array + 1)
}

# Defining a function to jitter values randomly until a certain correlation is reached
cor_jitter <- function(array1, array2 = ., target_cor = -0.497, tolerance = 0.001, sample_sizes = 10, iterations = 10000) {
  current_cor <- cor(array1, array2)
  cor_tracker <- NULL
  iteration = 0
  while (current_cor <= target_cor - tolerance | current_cor >= target_cor + tolerance) {
    
    indices <- sample(x = 1:length(array2), size = sample_sizes, replace = F)
    
    array2[indices] <- sample(x = unique(array2), size = length(indices), replace = T)
    
    current_cor <- cor(array1, array2)
    cor_tracker <- c(cor_tracker , current_cor) 
    
    iteration = iteration + 1
    
    if (iteration == iterations){
      print(paste0("No suitable array found after ", iterations, " iterations."))
      break()
    }
  }
  return(array2)
}

df$Success <- array_scaler(target_array = df$Post) %>%
              round() %>%
              value_inverter(max = 5) %>%
              cor_jitter(array1 = df$Post)
              
cor(df$Post, df$Success)
hist(df$Success)

summary(glm(as.factor(Strategy) ~ Pre, data = df, family = binomial))
summary(glm(as.factor(Strategy) ~ Post, data = df, family = binomial))
summary(lm(Success ~ Pre, data = df))
summary(lm(Success ~ Post, data = df))
summary(lm(Success ~ Pre * Strategy, data = df))

# Scatter plot with regression lines
ggplot(df, aes(x = Pre, y = Success, color = Strategy)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Linear Model: Success ~ Post * Strategy",
       x = "Post",
       y = "Success") +
  theme_minimal()
  
  # Copy over original values  
  # Convert them to the new scale
  # Match means between arrays
  # Create a conversion key for mins and maxes (i.e., slope)
  

























# Creating a function to specify the mean of a distribution
mean_fixer <- function(distribution = ., target_mean, min = 1, max = 9){
  
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
HighInt_Prereg<- sample(1:9, 100, replace = TRUE) %>%
                 mean_fixer(target_mean = 4.5)
LowInt_Prereg<- sample(1:9, 100, replace = TRUE) %>%
                 mean_fixer(target_mean = 3)

# In line with a effect size in emotion reduction, as observed in cite:
HighInt_Postreg<- sample(1:9, 100, replace = TRUE) %>%
                 mean_fixer(target_mean = 2)
LowInt_Postreg<- sample(1:9, 100, replace = TRUE) %>%
                 mean_fixer(target_mean = 1.5)

# Demonstrating that there are substantive differences
t.test(HighInt_Postreg, HighInt_Prereg)
t.test(HighInt_Postreg, LowInt_Postreg)
t.test(LowInt_Postreg, LowInt_Prereg)
t.test(HighInt_Prereg, LowInt_Prereg)

# Combining the values into a dataframe 


# TO DEMONSTRATE REGULATION SUCCESS