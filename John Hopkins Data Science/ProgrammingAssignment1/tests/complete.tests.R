test.that_complete_returns_expected_results_for_monitor_1 <- function()
{
    ##   id nobs
    ## 1  1  117    
    rows <- 1
    expected <- data.frame(cbind(
        rows,
        c(117)
    ))
    colnames(expected)<-c("id","nobs")    
    allMatch <- all(as.vector(expected == complete("specdata", 1)))
    checkTrue(allMatch)    
}


test.that_complete_returns_expected_results_for_monitors_2_to_12 <- function()
{
    ##   id nobs
    ## 1  2 1041
    ## 2  4  474
    ## 3  8  192
    ## 4 10  148
    ## 5 12   96    
    rows <- c(2, 4, 8, 10, 12)
    expected <- data.frame(cbind(
        rows,
        c(1041,474,192,148,96)
    ))
    colnames(expected)<-c("id","nobs")      
    allMatch <- all(as.vector(expected == complete("specdata", rows)))
    checkTrue(allMatch)
}

test.that_complete_returns_expected_results_for_monitors_25_to_30 <- function()
{
    ##   id nobs
    ## 1 30  932
    ## 2 29  711
    ## 3 28  475
    ## 4 27  338
    ## 5 26  586
    ## 6 25  463
    rows <- 30:25
    expected <- data.frame(cbind(
        rows,
        c(932, 711, 475, 338, 586, 463)
    ))
    colnames(expected)<-c("id","nobs")      
    allMatch <- all(as.vector(expected == complete("specdata", rows)))
    checkTrue(allMatch)
}

test.that_complete_returns_expected_results_for_monitor_3 <- function()
{    
    ##   id nobs
    ## 1  3  243
    rows <- 3
    expected <- data.frame(cbind(
        rows,
        c(243)
    ))
    colnames(expected)<-c("id","nobs")      
    allMatch <- all(as.vector(expected == complete("specdata", rows)))
    checkTrue(allMatch)    
}