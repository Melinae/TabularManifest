require(testthat)

###########
context("Calculate Bins")
###########
expected_element_names <- c("binWidth", "binStart")

test_that("Dataset: InsectSprays; Bin count: default", {  
  #Declare the input.
  dsObserved <- datasets::InsectSprays  
  
  #Declare the expected values.
  expected_bins <- structure(list(binWidth = c(1, 1), binStart = c(0, 1)), .Names = c("binWidth", "binStart"))
  
  #Run the function
  returned_bins <- CalculateBins(dsObserved=dsObserved )  #dput(returned_bins)
  
  #Compare the returned & expected values.
  expect_equal(names(returned_bins), expected_element_names, label="The element names should be correct.")
  expect_equivalent(returned_bins, expected=expected_bins, label="The calculated bin characteristics should be correct.") # dput(returned_object$data)
})
test_that("Dataset: freeny; Bin count: default", {  
  #Declare the input.
  dsObserved <- datasets::freeny  
  
  #Declare the expected values.
  expected_bins <- structure(list(binWidth = c(1, 0.0500000000000007, 0.0199999999999996, 
                                                0.00999999999999979, 0.00500000000000078), binStart = c(1, 8.75, 
                                                                                                         4.26, 5.82, 12.965)), .Names = c("binWidth", "binStart"))
  #Run the function
  returned_bins <- CalculateBins(dsObserved=dsObserved )  #dput(returned_bins)
  
  #Compare the returned & expected values.
  expect_equal(names(returned_bins), expected_element_names, label="The element names should be correct.")
  expect_equivalent(returned_bins, expected=expected_bins, label="The calculated bin characteristics should be correct.") # dput(returned_object$data)
})

rm(expected_element_names)
