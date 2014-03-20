require(testthat)
#For a definition of 'smoke test': http://stackoverflow.com/questions/745192/what-is-a-smoke-testing-and-what-will-it-do-for-me

###########
context("Graphing Smoke Tests") 
###########

test_that("HistogramContinuous: InsectSprays", {  
  HistogramContinuous(dsObserved=InsectSprays, variable_name="count", bin_width=1)
  expect_true(TRUE) #Put an assert to show a dot and more easily verify the function executed without bursting into flames.
})
test_that("HistogramContinuous: beaver", {  
  HistogramContinuous(dsObserved=beaver1, variable_name="temp", bin_width=.1)
  expect_true(TRUE) #Put an assert to show a dot and more easily verify the function executed without bursting into flames.
})

test_that("HistogramDiscrete: eduction", {  
  HistogramDiscrete(dsObserved=infert, variable_name="education")
  expect_true(TRUE) #Put an assert to show a dot and more easily verify the function executed without bursting into flames.
})
test_that("HistogramDiscrete: age", {  
  HistogramDiscrete(dsObserved=infert, variable_name="age")
  expect_true(TRUE) #Put an assert to show a dot and more easily verify the function executed without bursting into flames.
})
