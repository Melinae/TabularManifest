require(testthat)
#For a definition of 'smoke test': http://stackoverflow.com/questions/745192/what-is-a-smoke-testing-and-what-will-it-do-for-me

###########
context("Graphing Smoke Tests") 
###########

test_that("HistogramContinuous: InsectSprays", {  
  HistogramContinuous(dsObserved=InsectSprays, variableName="count", binWidth=1)
  expect_true(TRUE) #Put an assert to show a dot and more easily verify the function executed without bursting into flames.
})
test_that("HistogramContinuous: beaver", {  
  HistogramContinuous(dsObserved=beaver1, variableName="temp", binWidth=.1)
  expect_true(TRUE) #Put an assert to show a dot and more easily verify the function executed without bursting into flames.
})

test_that("HistogramDiscrete: eduction", {  
  HistogramDiscrete(dsObserved=infert, variableName="education")
  expect_true(TRUE) #Put an assert to show a dot and more easily verify the function executed without bursting into flames.
})
test_that("HistogramDiscrete: age", {  
  HistogramDiscrete(dsObserved=infert, variableName="age")
  expect_true(TRUE) #Put an assert to show a dot and more easily verify the function executed without bursting into flames.
})
