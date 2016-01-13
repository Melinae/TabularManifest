require(devtools)
devtools::create(  path=file.path(getwd(), "seed"), check=TRUE, description=list(
  "Title"= "Tabular Manifest",
  "Description"="Assists the manipulation and exploration of wide datasets with tabular configuration files",
  "Date"="2014-01-15",
  "Author"= "Will Beasley",
  "Maintainer"="'Will Beasley' <wibeasley@hotmail.com>"
))

add_travis(pkg = ".")
