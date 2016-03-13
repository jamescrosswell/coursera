source('complete.R')

corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files    
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    
    # Get completion data for each of our monitors
    completions <- complete(directory)
    
    # Get ids of monitors above the threshold
    id <- completions[completions$nobs > threshold, "id"]
    
    # Calculate sulfate <-> nitrate correlations for each of the monitors
    correlations <- vector(mode="numeric", length=length(id))
    for (i in seq_along(id)){
        mFile <- sprintf("%s/%03d.csv", directory, id[i])  
        monitorData <- read.csv(mFile)
        goodData <- monitorData[complete.cases(monitorData),]
        correlations[i] = cor(goodData$sulfate, goodData$nitrate)
    }
    
    # spit back the results
    correlations    
}