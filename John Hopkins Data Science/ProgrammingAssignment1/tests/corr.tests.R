checkVectorsAreSame <- function(v1, v2, msg, tol = 0){
    matches <- (v1 - v2) <= tol
    checkTrue(all(matches), msg)    
}

checkHead <- function(c, expected, msg){
    actual <- head(c)
    checkVectorsAreSame(actual, expected, msg, 0.001)    
} 

checkSummary <- function(c, expected, msg)
{
    actual <- as.vector(summary(c))
    checkVectorsAreSame(actual, expected, msg, 0.001)
}

test.that_corr_returns_expected_results_with_threshold_150 <- function()
{     
    cr <- corr("specdata", 150)
    ## [1] -0.01896 -0.14051 -0.04390 -0.06816 -0.12351 -0.07589
    checkHead(cr, c(-0.01896, -0.14051, -0.04390, -0.06816, -0.12351, -0.07589), "Unexpected head")
    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ## -0.2110 -0.0500  0.0946  0.1250  0.2680  0.7630 
    checkSummary(cr, c(-0.2110, -0.0500, 0.0946, 0.1250, 0.2680, 0.7630), "Unexpected summary")        
}

test.that_corr_returns_expected_results_with_threshold_400 <- function()
{   
    cr <- corr("specdata", 400)
    ## [1] -0.01896 -0.04390 -0.06816 -0.07589  0.76313 -0.15783
    checkHead(cr, c(-0.01896, -0.04390, -0.06816, -0.07589,  0.76313, -0.15783), "Unexpected head")
    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ## -0.1760 -0.0311  0.1000  0.1400  0.2680  0.7630    
    checkSummary(cr, c(-0.1760, -0.0311,  0.1000,  0.1400,  0.2680,  0.7630), "Unexpected summary")
}

test.that_corr_returns_expected_results_with_threshold_5000 <- function()
{   
    cr <- corr("specdata", 5000)
    ## [1] 0
    checkEqualsNumeric(length(cr), 0, "Unexpected length")
    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##     
    checkSummary(cr, c(NULL, NULL, NULL, NULL, NULL, NULL), "Unexpected summary")
}

test.that_corr_returns_expected_results_with_default_threshold <- function()
{   
    cr <- corr("specdata")
    ## [1] 323
    checkEqualsNumeric(length(cr), 323, "Unexpected length")  
    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ## -1.0000 -0.0528  0.1070  0.1370  0.2780  1.0000
    checkSummary(cr, c(-1.0000, -0.0528, 0.1070, 0.1370, 0.2780, 1.0000), "Unexpected summary")
}
