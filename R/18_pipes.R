## r4ds: Chapter 18: 
## Code for http://r4ds.had.co.nz/pipes.html#pipes 
## hn spds uni.kn
## 2018 05 12 ------


# Programming with pipes:
#  Learn how to use the pipe, %>%, how it works, 
#  what the alternatives are, and when not to use it.



## 18.1 Introduction ------ 

# Pipes are a powerful tool for clearly expressing a sequence of multiple operations. 
# So far, you’ve been using them without knowing how they work, 
# or what the alternatives are. 

# In this chapter, we explore the pipe in more detail. 
# We’ll learn 
# - the alternatives to the pipe, 
# - when we should _not_ use the pipe, and 
# - some useful related tools.


## 18.1.1 Prerequisites ----- 

# The pipe, %>%, comes from the magrittr package by Stefan Milton Bache. 
# Packages in the tidyverse load %>% automatically and implicitly. 
# Here, we’re focussing on piping and aren’t loading any other packages, 
# so we will load it explicitly:

library(magrittr)



## 18.2 Piping alternatives ------

## 4 ways to make a sequence of manipulations to an object (e.g., data):

# 1. Save each intermediate step as a new object.
# 2. Overwrite the original object many times.
# 3. Compose functions.
# 4. Use the pipe.

## Example:

# Little bunny Foo Foo
# Went hopping through the forest
# Scooping up the field mice
# And bopping them on the head

# foo_foo <- little_bunny()


## 18.2.1 Intermediate steps ----- 

# foo_foo_1 <- hop(foo_foo, through = forest)
# foo_foo_2 <- scoop(foo_foo_1, up = field_mice)
# foo_foo_3 <- bop(foo_foo_2, on = head)

# - Names are redundant.
# - Suffixes get confusing.
# - But: R does not duplicate shared data:

## Demo: R does not copy shared data ---- 

## (A) 
# Add a new column to ggplot2::diamonds:
diamonds <- ggplot2::diamonds
diamonds2 <- diamonds %>% 
    dplyr::mutate(price_per_carat = price / carat)

## Using the pryr package to ask for object_size of multiple objects:
install.packages('pryr')

# use pryr::object_size() here, not the built-in object.size(), 
# which only takes a single object so it can’t compute how data 
# is shared across multiple objects.)

pryr::object_size(diamonds)
#> 3.46 MB

pryr::object_size(diamonds2)
#> 3.89 MB

pryr::object_size(diamonds, diamonds2)
#> 3.89 MB

# Thus, R realised common parts of and did not copy shared data columns.

# Variables will only get copied if we modify one of them. In the following
# example, we modify a single value in diamonds$carat. That means the carat
# variable can no longer be shared between the two data frames, and a copy must
# be made. The size of each data frame is unchanged, but the collective size
# increases:

## (B)
# Changing a column in original data set: 
diamonds$carat[1] <- NA

pryr::object_size(diamonds)
#> 3.46 MB

pryr::object_size(diamonds2)
#> 3.89 MB

pryr::object_size(diamonds, diamonds2)
#> 4.32 MB


## 18.2.2 Overwrite the original ----- 

# Instead of creating intermediate objects at each step, 
# we could overwrite the original object:
  
# foo_foo <- hop(foo_foo, through = forest)
# foo_foo <- scoop(foo_foo, up = field_mice)
# foo_foo <- bop(foo_foo, on = head)

# 2 problems:
  
# - Debugging is painful: if we make a mistake we’ll need to 
#   re-run the complete pipeline from the beginning.

# - The repetition of the object being transformed (we’ve written foo_foo 6 times!) 
#   obscures what’s changing on each line.


## 18.2.3 Function composition -----

# Another approach is to abandon assignment and just string the function calls together:
  
# bop(
#   scoop(
#     hop(foo_foo, through = forest),
#     up = field_mice
#   ), 
#   on = head
# )

# This code is hard for a human to consume: 
# We have to read from inside-out, from right-to-left, 
# and that the arguments end up spread far apart 
# (aka the "dagwood sandwhich problem"). 



## 18.2.4 The pipe ----- 

## Advantages: ---- 

# foo_foo %>%
#   hop(through = forest) %>%
#   scoop(up = field_mouse) %>%
#   bop(on = head)

# - Using the pipe focuses on verbs, rather than nouns. 
# - This can be read sequentially 
#   like a set of imperative actions.


## How the pipe works: ----

# The pipe works by performing a “lexical transformation”: 
# behind the scenes, magrittr reassembles the code in the pipe 
# to a form that works by overwriting an intermediate object. 

# When you run a pipe like the one above, 
# magrittr does something like this:
  
# my_pipe <- function(.) {
#   . <- hop(., through = forest)
#   . <- scoop(., up = field_mice)
#   bop(., on = head)
# }
# 
# my_pipe(foo_foo)

## When the pipe does not work: ---- 

# This way of working implies that the pipe won’t work 
# for 2 classes of functions:
  
# 1. Functions that use the current environment. For example, assign() will
# create a new variable with the given name in the current environment:
  
assign("x", 10)
x
#> [1] 10

"x" %>% assign(100)
x
#> [1] 10

# The use of assign with the pipe does not work because it assigns it to a
# temporary environment used by %>%. If you do want to use assign with the pipe,
# you must be explicit about the environment:
  
env <- environment()
"x" %>% assign(100, envir = env)
x
#> [1] 100

# Other functions with this problem include get() and load().

# 2. Functions that use lazy evaluation. 

# In R, function arguments are only computed when the function uses them, 
# not prior to calling the function. The pipe computes each element in turn, 
# so you can’t rely on this behavior.

# One place that this is a problem is tryCatch(), 
# which lets you capture and handle errors:
  
tryCatch(stop("!"), error = function(e) "An error")
#> [1] "An error"

stop("!") %>% 
  tryCatch(error = function(e) "An error")
#> Error in eval(lhs, parent, parent): !

# There are a relatively wide class of functions with this behavior, 
# including try(), suppressMessages(), and suppressWarnings() 
# in base R.



## 18.3 When not to use the pipe ------

# The pipe is a powerful tool, but it’s not the only tool at your disposal, 
# and it doesn’t solve every problem! 
# Pipes are most useful for rewriting a fairly short linear sequence of operations. 

# You should reach for another tool when:
  
# 1. Your pipes are longer than (say) ten steps. 
#    In that case, create intermediate objects with meaningful names. 
#    That will make debugging easier, because you can more easily check 
#    the intermediate results, and it makes it easier to understand your code, 
#    because the variable names can help communicate intent.

# 2. You have multiple inputs or outputs. 
#    If there isn’t one primary object being transformed, 
#    but two or more objects being combined together, don’t use the pipe.

# 3. You are starting to think about a directed graph with a 
#    complex dependency structure. 
#    Pipes are fundamentally linear and expressing complex relationships 
#    with them will typically yield confusing code.



## 18.4 Other tools from magrittr ------

# All packages in the tidyverse automatically make %>% available for you, so you
# don’t normally load magrittr explicitly. However, there are some other useful
# tools inside magrittr that you might want to try out:

## 1. The %T>%-operator (T-pipe) for side effects: ----  

# When working with more complex pipes, it’s sometimes useful to call a function
# for its side-effects. Maybe you want to print out the current object, or plot
# it, or save it to disk. Many times, such functions don’t return anything,
# effectively terminating the pipe.

# To work around this problem, you can use the “tee” pipe. %T>% works like %>%
# except that it returns the left-hand side instead of the right-hand side. 
# It’s called “tee” because it’s like a literal T-shaped pipe: 

rnorm(100) %>%
  matrix(ncol = 2) %>%
  plot() %>%
  str()
#>  NULL

rnorm(100) %>%
  matrix(ncol = 2) %T>%
  plot() %>%
  str()
#>  num [1:50, 1:2] -0.387 -0.785 -1.057 -0.796 -1.756 ...


## 2. The %$%-operator (%$%) for exploding vectors: ---- 

# If you’re working with functions that don’t have a data frame based API
# (i.e. you pass them individual vectors, not a data frame 
#  and expressions to be evaluated in the context of that data frame), 
# you might find %$% useful. 

# It “explodes” out the variables in a data frame so that you can refer to them
# explicitly. This is useful when working with many functions in base R:
  
mtcars %$%
  cor(disp, mpg)


## 3. The %<>%-operator for assignment: ---- 

# For assignment magrittr provides the %<>% operator 
# which allows you to replace code like:

mtcars <- mtcars %>% 
  transform(cyl = cyl * 2)

# with: 

mtcars %<>% transform(cyl = cyl * 2)

# I’m not a fan of this operator because I think assignment is such a special
# operation that it should always be clear when it’s occurring. 
# In my opinion, a little bit of duplication 
# (i.e. repeating the name of an object twice) 
# is fine in return for making assignment more explicit.



## +++ here now +++ ------


## Appendix ------

## Web:  

# Cheatsheets: 
# See Base-R and Advanced-R at  
# https://www.rstudio.com/resources/cheatsheets/

## Documentation: ----- 

## Links to many books, manuals and scripts:
## https://www.r-project.org/doc/bib/R-books.html 
## https://cran.r-project.org/manuals.html
## https://bookdown.org/ 


## ------
## eof.