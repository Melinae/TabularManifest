require(testthat)

###########
context("Create Manifest Explore")
###########
expected_metadata_column_count <- 9L #This is a property of the function, and not the input dataset.

test_that("Dataset: InsectSprays", {  
  #Declare the input.
  dsObserved <- datasets::InsectSprays
  
  #Declare the expected values.
  expected_metadata <- structure(list(variableName = c("count", "spray"), remark = c("", 
                                                                                      ""), class = c("numeric", "factor"), shouldGraph = c(TRUE, TRUE
                                                                                      ), graphFunction = c("HistogramContinuous", "HistogramDiscrete"
                                                                                      ), xLabelFormat = c("scales::comma", "scales::comma"), binWidth = c(1, 1), 
                                      binStart = c(0, 1), rounding_digits = c(0, 1)), .Names = c("variableName", 
                                                                                                  "remark", "class", "shouldGraph", "graphFunction", "xLabelFormat", 
                                                                                                  "binWidth", "binStart", "rounding_digits"), row.names = c(NA, 
                                                                                                                                                              -2L), class = "data.frame")
  #Run the function
  returned_metadata <- CreateManifestExploreUnivariate(dsObserved, write_to_disk=FALSE) #dput(returned_metadata)
  
  #Compare the returned & expected values.
  expect_equal(ncol(expected_metadata), expected_metadata_column_count, label="The number of metadata columns should be correct.")
  expect_equal(nrow(expected_metadata), ncol(dsObserved), label="The number of metadata rows should equal the number of rows in dsObserved.")
  expect_equivalent(returned_metadata, expected=expected_metadata, label="The returned data.frame should be correct") # dput(returned_object$data)
})

test_that("Dataset: freeny", {  
  #Declare the input.
  dsObserved <- datasets::freeny
  
  #Declare the expected values.
  expected_metadata <- structure(list(variableName = c("y", "lag.quarterly.revenue", 
                                                        "price.index", "income.level", "market.potential"), remark = c("", 
                                                                                                                       "", "", "", ""), class = c("ts", "numeric", "numeric", "numeric", 
                                                                                                                                                  "numeric"), shouldGraph = c(TRUE, TRUE, TRUE, TRUE, TRUE), graphFunction = c("histogram_generic", 
                                                                                                                                                                                                                                 "HistogramContinuous", "HistogramContinuous", "HistogramContinuous", 
                                                                                                                                                                                                                                 "HistogramContinuous"), xLabelFormat = c("scales::comma", "scales::comma", 
                                                                                                                                                                                                                                                                             "scales::comma", "scales::comma", "scales::comma"), binWidth = c(1, 0.0500000000000007, 
                                                                                                                                                                                                                                                                                                                       0.0199999999999996, 0.00999999999999979, 0.00500000000000078), 
                                      binStart = c(1, 8.75, 4.26, 5.82, 12.965), rounding_digits = c(1, 
                                                                                                      2, 2, 2, 2)), .Names = c("variableName", "remark", "class", 
                                                                                                                               "shouldGraph", "graphFunction", "xLabelFormat", "binWidth", 
                                                                                                                               "binStart", "rounding_digits"), row.names = c(NA, -5L), class = "data.frame")
  #Run the function
  returned_metadata <- CreateManifestExploreUnivariate(dsObserved, write_to_disk=FALSE) #dput(returned_metadata)
  
  #Compare the returned & expected values.
  expect_equal(ncol(expected_metadata), expected_metadata_column_count, label="The number of metadata columns should be correct.")
  expect_equal(nrow(expected_metadata), ncol(dsObserved), label="The number of metadata rows should equal the number of rows in dsObserved.")
  expect_equivalent(returned_metadata, expected=expected_metadata, label="The returned data.frame should be correct") # dput(returned_object$data)
})

# test_that("InsectSprays2", {  
#   
#   expected_data <- structure(list(variableName = structure(1:2, .Label = c("countDDDDD", 
#                                                                             "spray"), class = "factor"), class = structure(c(2L, 1L), .Label = c("factor", 
#                                                                                                                                                  "numeric"), class = "factor"), shouldGraph = c(TRUE, TRUE), 
#                                   graphFunction = structure(1:2, .Label = c("HistogramContinuous", 
#                                                                              "HistogramDiscrete"), class = "factor"), xLabelFormat = structure(c(1L, 
#                                                                                                                                                     1L), .Label = "scales::comma", class = "factor"), remark = structure(c(1L, 
#                                                                                                                                                                                                                            1L), class = "factor", .Label = "")), .Names = c("variableName", 
#                                                                                                                                                                                                                                                                             "class", "shouldGraph", "graphFunction", "xLabelFormat", 
#                                                                                                                                                                                                                                                                             "remark"), row.names = c("count", "spray"), class = "data.frame")
#   
#   returned_object <- CreateManifestExploreUnivariate(datasets::InsectSprays, write_to_disk=FALSE) #dput(returned_object)
#   
#   
#   expect_equivalent(returned_object, expected=expected_data, label="The returned data.frame should be correct") # dput(returned_object$data)
#   
# })
rm(expected_metadata_column_count)
