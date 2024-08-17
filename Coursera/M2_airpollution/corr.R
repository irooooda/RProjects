corr <- function(directory, threshold = 0) {
  # Initialize an empty vector to store correlations
  correlations <- c()
  
  # Get the number of complete cases for each monitor
  complete_data <- complete(directory)
  
  # Filter the monitors with more than the threshold complete cases
  monitors_above_threshold <- complete_data[complete_data$nobs > threshold, ]
  
  # Loop through each monitor that meets the threshold
  for (i in monitors_above_threshold$id) {
    # Create the file name
    file_name <- sprintf("%s/%03d.csv", directory, i)
    
    # Read the CSV file
    data <- read.csv(file_name)
    
    # Filter complete cases
    complete_data <- data[complete.cases(data), ]
    
    # Calculate the correlation between sulfate and nitrate
    if (nrow(complete_data) > 0) {
      corr_value <- cor(complete_data$sulfate, complete_data$nitrate)
      correlations <- c(correlations, corr_value)
    }
  }
  
  # Return the vector of correlations
  return(correlations)
}
