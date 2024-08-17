complete <- function(directory, id = 1:332) {
  # Initialize an empty data frame to store results
  results <- data.frame(id = numeric(), nobs = numeric())
  
  # Loop through each monitor ID
  for (i in id) {
    # Create the file name
    file_name <- sprintf("%s/%03d.csv", directory, i)
    
    # Read the CSV file
    data <- read.csv(file_name)
    
    # Count complete cases (rows without NAs)
    complete_cases <- sum(complete.cases(data))
    
    # Add the monitor ID and complete case count to the results
    results <- rbind(results, data.frame(id = i, nobs = complete_cases))
  }
  
  # Return the results data frame
  return(results)
}
