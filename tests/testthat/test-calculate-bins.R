library(testthat)

expected_element_names <- c("bin_width", "bin_start")

test_that("Dataset: InsectSprays; Bin count: default", {  
  #Declare the input.
  d_observed <- datasets::InsectSprays  
  
  #Declare the expected values.
  expected_bins <- structure(list(bin_width = c(1, 1), bin_start = c(0, 1)), .Names = c("bin_width", "bin_start"))
  
  #Run the function
  returned_bins <- calculate_bins(d_observed=d_observed )  #dput(returned_bins)
  
  #Compare the returned & expected values.
  expect_equal(names(returned_bins), expected_element_names, label="The element names should be correct.")
  expect_equal(returned_bins, expected=expected_bins, label="The calculated bin characteristics should be correct.", ignore_attr = TRUE) # dput(returned_object$data)
})
test_that("Dataset: freeny; Bin count: default", {  
  #Declare the input.
  d_observed <- datasets::freeny  
  
  #Declare the expected values.
  expected_bins <- structure(list(bin_width = c(1, 0.0500000000000007, 0.0199999999999996, 
                                                0.00999999999999979, 0.00500000000000078), bin_start = c(1, 8.75, 
                                                                                                         4.26, 5.82, 12.965)), .Names = c("bin_width", "bin_start"))
  #Run the function
  returned_bins <- calculate_bins(d_observed=d_observed )  #dput(returned_bins)
  
  #Compare the returned & expected values.
  expect_equal(names(returned_bins), expected_element_names, label="The element names should be correct.")
  expect_equal(returned_bins, expected=expected_bins, label="The calculated bin characteristics should be correct.", ignore_attr = TRUE) # dput(returned_object$data)
})

rm(expected_element_names)
