library('RUnit')

source('pollutantmean.R')
source('complete.R')
source('corr.R')

test.suite <- defineTestSuite("Air Pollution",
                              dirs = file.path("./tests"),
                              testFileRegexp = '^.*\\.R')

test.result <- runTestSuite(test.suite)

printTextProtocol(test.result)
