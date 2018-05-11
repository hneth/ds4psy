## r4ds: Chapter 18: 
## Code for http://r4ds.had.co.nz/pipes.html#pipes 
## hn spds uni.kn
## 2018 05 11 ------






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

# Demo: R does not copy shared data ---- 

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


## 18.2.4 Use the pipe ----- 



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