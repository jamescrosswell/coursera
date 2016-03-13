pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)    
    
    # work out paths to the relevant data files by combining the directory with the various
    # monitor ids that the user wants to summarize
    monitorFiles <- sapply(id, function(monitorId){ sprintf("%s/%03d.csv", directory, monitorId) })
    
    # extract 'pollutant' data from each of the monitor files 
    polutantData <- vector(mode="numeric")
    for (mFile in monitorFiles){
        monitorData <- read.csv(mFile)[,pollutant]
        polutantData <- c(polutantData, monitorData)
    }    
    
    # Return the mean of the pollutant across all monitors list
    # in the 'id' vector (ignoring NA values)    
    round(mean(polutantData, na.rm = TRUE), 3)
}
