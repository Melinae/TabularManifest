rm(list=ls(all=TRUE))
require(devtools)
options(device = "windows") #http://support.rstudio.org/help/discussions/problems/80-error-in-function-only-one-rstudio-graphics-device-is-permitted

spelling::spell_check_package()
# spelling::update_wordlist()
lintr::lint_package()
# lintr::lint("R/redcap-metadata-coltypes.R")
urlchecker::url_check(); urlchecker::url_update()

devtools::run_examples(); dev.off() #This overwrites the NAMESPACE file too
# devtools::run_examples(, "Go.Rd")
test_results <- devtools::test()
devtools::build_vignettes()

# devtools::build_win(version="R-devel") #CRAN submission policies encourage the development version
devtools::revdep_check(pkg="TabularManifest", recursive=TRUE)
# devtools::release(check=FALSE) #Careful, the last question ultimately uploads it to CRAN, where you can't delete/reverse your decision.
