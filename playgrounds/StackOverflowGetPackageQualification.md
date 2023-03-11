Asked 2013-01-19
https://stackoverflow.com/questions/21224800/using-rs-get-function-while-qualifying-with-the-package

I'd like to assign a function to variable, using a character.  The `get()` function in the `base` package does *almost* exactly what I want.  For example,

valueReadFromFile <- "median"
ds <- data.frame(X=rnorm(10), Y=rnorm(10))
dynamicFunction <- get(valueReadFromFile)
dynamicFunction(ds$X)

However, I want to qualify the function with its package, so that I don't have to worry about (a) loading the function's package with `library()`, or (b) calling the wrong function in a different package.

Is there a robust, programmatic way I can qualify a function's name with its package using `get()` (or some similar function)?  The following code doesn't work, presumably because `get()` doesn't know how to interpret the package name.

require(scales) #Has functions called `alpha()` and `rescale()`
require(psych) #Also has functions called `alpha()` and `rescale()`

dynamicFunction1 <- get("scales::alpha")
dynamicFunction2 <- get("psych::alpha")
