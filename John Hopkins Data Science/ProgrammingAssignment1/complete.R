complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases    
    
    # work out how many good rows are in each file and store the results in a matrix
    results <- matrix(data = NA, nrow = length(id), ncol = 2)
    for (i in seq_along(id)){
        mFile <- sprintf("%s/%03d.csv", directory, id[i])  
        monitorData <- read.csv(mFile)
        good <- complete.cases(monitorData)
        results[i,1] <- id[i]
        results[i,2] <- sum(good)
    }
    

    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases    
    data <- data.frame(results)
    colnames(data) <- c("id", "nobs")
    data
}
