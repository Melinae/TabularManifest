library(testthat)
library(TabularManifest)

packages <- utils::installed.packages()
testthatVersion <- packages[packages[, 1]=="testthat", "Version"]
message("testthat package version: ", testthatVersion)

if(  testthatVersion >= "0.8" ) {
  # But this is working in the reverse way for me (the old way works for the new structure, but not the new way.)
  testthat::test_check("TabularManifest") #The new way: when tests are located in `./tests/testthat/`
#   testthat::test_package("TabularManifest") #The old way: when tests are located in `./inst/tests/`

}
rm(packages)


# find_test_dir <- function(path) {
#   testthat <- file.path(path, "tests", "testthat")
#   if (file.exists(testthat)) return(testthat)
#
#   inst <- file.path(path, "inst", "tests")
#   if (file.exists(inst)) return(inst)
#
#   stop("No testthat directories found in ", path, call. = FALSE)
# }
#
#   devtools::test()
# pkg = "."
# pkg <- as.package(pkg)
# test_path <- find_test_dir(pkg$path)
# test_files <- dir(test_path, "^test.*\\.[rR]$")
#
#
# devtools::find_rtools
