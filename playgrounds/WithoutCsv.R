#http://stackoverflow.com/questions/21224800/using-rs-get-function-while-qualifying-with-the-package

rm(list=ls(all=TRUE))
require(TabularManifest)
require(datasets)
require(scales)

#ds_observed <- beaver1
ds_observed <- InsectSprays
ds_manifest <- TabularManifest::create_manifest_explore_univariate(ds, write_to_disk=FALSE)

# get_with_package <- function( qualified_function ) {
#   #TODO: write regex so that it accommodates a period in the variable name.
# #   if( !grepl("^(\\w+)::(\\w+)$", qualified_function, perl=TRUE) )
# #     stop("The function name should be qualified with it's package. For instance, pass `scales::comma` instead of simply `comma`.")
#   split_function <- strsplit(qualified_function, split="::")[[1]]
#   fx <- getExportedValue(split_function[1], split_function[2])
#   return( fx )
# }
# get_with_package("scales::comma")
# 
# for( variable_index in seq_len(nrow(ds_manifest)) ) {  
# # for( variable_index in 2 ) {  
#   variable_name <- ds_manifest[variable_index, "variable_name"]
#   should_graph <- ds_manifest[variable_index, "should_graph"]
#   remark <- ds_manifest[variable_index, "remark"]
#   graphing_fx <- get(ds_manifest[variable_index, "graph_function"])
# #   x_label_string <- ds_manifest[variable_index, "x_label_format"]
# #   x_label_split <- strsplit(x_label_string, split="::")[[1]]
# #   x_label_fx <- getExportedValue(x_label_split[1], x_label_split[2])
#   x_label_fx <- get_with_package(ds_manifest[variable_index, "x_label_format"])
# 
#   
#   bin_width <- ds_manifest[variable_index, "bin_width"]
#   if( should_graph ) {
#     graphing_fx(ds_observed=ds, variable_name=variable_name, bin_width=bin_width)
#   }
# }

# construct_graph <- function( variable_index ) {
#   variable_name <- ds_manifest[variable_index, "variable_name"]
#   should_graph <- ds_manifest[variable_index, "should_graph"]
#   remark <- ds_manifest[variable_index, "remark"]
#   graphing_fx <- get(ds_manifest[variable_index, "graph_function"])
#   x_label_fx <- get_with_package(ds_manifest[variable_index, "x_label_format"])
#   
#   bin_width <- ds_manifest[variable_index, "bin_width"]
#   if( should_graph ) 
#     g <- graphing_fx(ds_observed=ds, variable_name=variable_name, bin_width=bin_width)
#   else
#     g <- NULL
#   
#   return(list(variable_name=variable_name, graph=g, remark=remark))
# }
# 
# graph_list <- lapply(X=seq_len(nrow(ds_manifest)), construct_graph)
# 
# graph_list[[2]]$graph


# construct_graph_univariate <- function( variable_name, ds_metadata, ds_observed ) {
#   ds_for_variable <- ds_metadata[ds_metadata$variable_name==variable_name, ]
#   variable_name <- ds_for_variable$variable_name
#   should_graph <- ds_for_variable$should_graph
#   remark <- ds_for_variable$remark
#   graphing_fx <- get(ds_for_variable$graph_function)
#   x_label_fx <- get_with_package(ds_for_variable$x_label_format)
#   
#   bin_width <- ds_for_variable$bin_width
#   if( should_graph ) 
#     g <- graphing_fx(ds_observed=ds_observed, variable_name=variable_name, bin_width=bin_width)
#   else
#     g <- NULL
#   
#   return(list(variable_name=variable_name, graph=g, remark=remark))
# }

# graph_list <- lapply(X=ds_manifest$variable_name, FUN=construct_graph_univariate, ds_metadata=ds_manifest, ds_observed=ds_observed)


rnorm(1)
set.seed(3)
rnorm(1)
rnorm(1)
set.seed(NULL)
rnorm(1)
rnorm(1)
set.seed(3)
rnorm(1)
rnorm(1)

# # round(1234.4578, -1)
# # -log10(scales:::precision(ds$day*1))+1
# sapply(ds, FUN=function(x){1-log10(scales:::precision(x))})
# # scales:::precision(ds$temp*100)
# # ds$temp
# 
# dynamicFunction1 <- get("alpha", envir=as.environment("package:scales"))
# dynamicFunction2 <- get("alpha", as.environment("package:psych"))
# 
# dynamicFunction1 <- `::`('scales', 'alpha')
# dynamicFunction2 <- `::`('psych', 'alpha')
# 
# dynamicFunction1 <-  getExportedValue('scales', 'alpha')
# dynamicFunction2 <-  getExportedValue('psych', 'alpha')
# 
# 
# gsub("^(\\w*)*(::)*(\\w+)$", replacement="\\3", c("comma", "scales::comma"), perl=T)
# 
# split_values <- strsplit("scales::comma", "::")
# split_values[[1]][1]
# strsplit("comma", "::")
