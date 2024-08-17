pollutantmean <- function(directory, pollutant, id = 1:332) {
  # Initialize an empty vector to store pollutant data
  pollutant_data <- c()
  
  # Loop through each monitor ID
  for (i in id) {
    # Create the file name by appending the monitor ID to the directory
    file_name <- sprintf("%s/%03d.csv", directory, i)
    
    # Read the CSV file
    data <- read.csv(file_name)
    
    # Extract the pollutant data, ignoring NAs
    pollutant_data <- c(pollutant_data, data[[pollutant]])
  }
  # Calculate the mean, ignoring NAs pollutantmean("/Users/irooooda/Desktop/R/RProjects/Coursera/M2_airpollution/specdata", "sulfate", 1:10)
  
  mean_value <- mean(pollutant_data, na.rm = TRUE)
  
  # Return the calculated mean
  return(mean_value)
}
