library(testthat)

test_that("histogram_continuous: InsectSprays", {
  histogram_continuous(d_observed=InsectSprays, variable_name="count", bin_width=1)
  expect_true(TRUE) #Put an assert to show a dot and more easily verify the function executed without bursting into flames.
})
test_that("histogram_continuous: beaver", {
  histogram_continuous(d_observed=beaver1, variable_name="temp", bin_width=.1)
  expect_true(TRUE) #Put an assert to show a dot and more easily verify the function executed without bursting into flames.
})

test_that("histogram_discrete: eduction", {
  histogram_discrete(d_observed=infert, variable_name="education")
  expect_true(TRUE) #Put an assert to show a dot and more easily verify the function executed without bursting into flames.
})
test_that("histogram_discrete: age", {
  histogram_discrete(d_observed=infert, variable_name="age")
  expect_true(TRUE) #Put an assert to show a dot and more easily verify the function executed without bursting into flames.
})
