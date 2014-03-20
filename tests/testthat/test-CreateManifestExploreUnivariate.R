require(testthat)

###########
context("Create Manifest Explore")
###########
expected_metadata_column_count <- 9L #This is a property of the function, and not the input dataset.

test_that("Dataset: InsectSprays", {  
  #Declare the input.
  ds_observed <- datasets::InsectSprays
  
  #Declare the expected values.
  expected_metadata <- structure(list(variable_name = c("count", "spray"), remark = c("", 
                                                                                      ""), class = c("numeric", "factor"), should_graph = c(TRUE, TRUE
                                                                                      ), graph_function = c("histogram_continuous", "histogram_discrete"
                                                                                      ), x_label_format = c("scales::comma", "scales::comma"), bin_width = c(1, 1), 
                                      bin_start = c(0, 1), rounding_digits = c(0, 1)), .Names = c("variable_name", 
                                                                                                  "remark", "class", "should_graph", "graph_function", "x_label_format", 
                                                                                                  "bin_width", "bin_start", "rounding_digits"), row.names = c(NA, 
                                                                                                                                                              -2L), class = "data.frame")
  #Run the function
  returned_metadata <- create_manifest_explore_univariate(ds_observed, write_to_disk=FALSE) #dput(returned_metadata)
  
  #Compare the returned & expected values.
  expect_equal(ncol(expected_metadata), expected_metadata_column_count, label="The number of metadata columns should be correct.")
  expect_equal(nrow(expected_metadata), ncol(ds_observed), label="The number of metadata rows should equal the number of rows in ds_observed.")
  expect_equivalent(returned_metadata, expected=expected_metadata, label="The returned data.frame should be correct") # dput(returned_object$data)
})

test_that("Dataset: freeny", {  
  #Declare the input.
  ds_observed <- datasets::freeny
  
  #Declare the expected values.
  expected_metadata <- structure(list(variable_name = c("y", "lag.quarterly.revenue", 
                                                        "price.index", "income.level", "market.potential"), remark = c("", 
                                                                                                                       "", "", "", ""), class = c("ts", "numeric", "numeric", "numeric", 
                                                                                                                                                  "numeric"), should_graph = c(TRUE, TRUE, TRUE, TRUE, TRUE), graph_function = c("histogram_generic", 
                                                                                                                                                                                                                                 "histogram_continuous", "histogram_continuous", "histogram_continuous", 
                                                                                                                                                                                                                                 "histogram_continuous"), x_label_format = c("scales::comma", "scales::comma", 
                                                                                                                                                                                                                                                                             "scales::comma", "scales::comma", "scales::comma"), bin_width = c(1, 0.0500000000000007, 
                                                                                                                                                                                                                                                                                                                       0.0199999999999996, 0.00999999999999979, 0.00500000000000078), 
                                      bin_start = c(1, 8.75, 4.26, 5.82, 12.965), rounding_digits = c(1, 
                                                                                                      2, 2, 2, 2)), .Names = c("variable_name", "remark", "class", 
                                                                                                                               "should_graph", "graph_function", "x_label_format", "bin_width", 
                                                                                                                               "bin_start", "rounding_digits"), row.names = c(NA, -5L), class = "data.frame")
  #Run the function
  returned_metadata <- create_manifest_explore_univariate(ds_observed, write_to_disk=FALSE) #dput(returned_metadata)
  
  #Compare the returned & expected values.
  expect_equal(ncol(expected_metadata), expected_metadata_column_count, label="The number of metadata columns should be correct.")
  expect_equal(nrow(expected_metadata), ncol(ds_observed), label="The number of metadata rows should equal the number of rows in ds_observed.")
  expect_equivalent(returned_metadata, expected=expected_metadata, label="The returned data.frame should be correct") # dput(returned_object$data)
})

# test_that("InsectSprays2", {  
#   
#   expected_data <- structure(list(variable_name = structure(1:2, .Label = c("countDDDDD", 
#                                                                             "spray"), class = "factor"), class = structure(c(2L, 1L), .Label = c("factor", 
#                                                                                                                                                  "numeric"), class = "factor"), should_graph = c(TRUE, TRUE), 
#                                   graph_function = structure(1:2, .Label = c("histogram_continuous", 
#                                                                              "histogram_discrete"), class = "factor"), x_label_format = structure(c(1L, 
#                                                                                                                                                     1L), .Label = "scales::comma", class = "factor"), remark = structure(c(1L, 
#                                                                                                                                                                                                                            1L), class = "factor", .Label = "")), .Names = c("variable_name", 
#                                                                                                                                                                                                                                                                             "class", "should_graph", "graph_function", "x_label_format", 
#                                                                                                                                                                                                                                                                             "remark"), row.names = c("count", "spray"), class = "data.frame")
#   
#   returned_object <- create_manifest_explore_univariate(datasets::InsectSprays, write_to_disk=FALSE) #dput(returned_object)
#   
#   
#   expect_equivalent(returned_object, expected=expected_data, label="The returned data.frame should be correct") # dput(returned_object$data)
#   
# })
rm(expected_metadata_column_count)
