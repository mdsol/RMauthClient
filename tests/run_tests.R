library(RUnit)

source("R/RMauthClient.R")

test.suite <- defineTestSuite("RMauthClient",
                              dirs = file.path("tests"),
                              testFileRegexp = '^\\d+\\.R')

test.result <- runTestSuite(test.suite)

printTextProtocol(test.result)