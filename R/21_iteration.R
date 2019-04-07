## r4ds: Chapter 21: 
## Code for https://r4ds.had.co.nz/iteration.html
## hn spds uni.kn
## 2019 04 05 ------


## 20 Vectors 

## 21.1 Introduction ------ 

# Beyond functions (Ch. 19), iteration/loops are another way of avoiding duplication of code. 

# Practical goal: Repeatedly applying the same actions to different but similar data. 

# Theory: Distinguish between 2 important iteration paradigms: 

# (1) Imperative programming: 
# Tools: for loops and while loops, 
# +:     explicit iteration very explicit
# -:     verbose, and require quite a bit of bookkeeping code that is duplicated for every for loop. 

# (2) Functional programming (FP): 
# Tools: map functions extract duplicated code, each common for loop pattern gets its own function. 

# Mastering the vocabulary of FP, we can solve common iteration problems  
# with less code, more ease, and fewer errors.

## 21.1.1 Prerequisites ----- 

# Base R data structures, 
# + functions from the purrr package 
# (to avoid some inconsistencies in base R):

library(tidyverse)  # purrr

## 21.2 For loops ------ 

# ToDo

## 21.3 For loops variations ------

# ToDo 

## 21.4 For loops vs. functionals ------

# Motivating functional programming:

# Data:
set.seed(1)  # for reproducible results

df <- tibble(a = rnorm(10),
             b = rnorm(10),
             c = rnorm(10),
             d = rnorm(10)
)

# df

# Goal 1: Mean of every column:

# loop:
output <- vector("double", length(df))

# for loop over columns i: 
for (i in seq_along(df)) {
  
  output[[i]] <- mean(df[[i]])
  
}

output

# Goal 2: Generalization to summary of every column 
#         (i.e., apply some function to every column):

# Key: Using functions as an argument of a function:

col_summary <- function(data, fun) {
  
  out <- vector("double", length(data)) # Note: length(df)  # => 4
  
  for (i in seq_along(data)) {
    
    out[i] <- fun(data[[i]])  # !!!
    
  }
  
  out
  
}

# Repeat use of col_mean (from above): 
col_summary(df, fun = mean) # Note: same functionality/results as above.

# New uses: 
col_summary(df, fun = median)
col_summary(df, fun = sd)

# The idea of passing a _function_ as an _argument_ to another _function_ is an extremely powerful idea, 
# and it’s one of the behaviors that makes R a _functional programming language_.

## Replacing loops by `apply` and `purrr`: ------ 


## (1) Using `apply`: ---- 

# See
# ?apply # to check arguments and usage

# Example: Using `base::apply` to solve the problem above:
  
dim(df)  # 10 rows, 4 columns:

# apply FUN to columns:
apply(X = df, MARGIN = 2, FUN = mean)    # mean of every column
apply(X = df, MARGIN = 2, FUN = median)  # median of every column
apply(X = df, MARGIN = 2, FUN = sd)      # SD of every column

# apply FUN to rows:
apply(X = df, MARGIN = 1, FUN = mean)    # mean of every row
apply(X = df, MARGIN = 1, FUN = median)  # median of every row
apply(X = df, MARGIN = 1, FUN = sd)      # SD of every row


## (2) Using `purrr`: ---- 

# The `purrr` package provides modern and more consistent versions of `apply`. 
# 
# The main goal of using `purrr` functions (instead of `for` loops) is to allow breaking common list manipulation challenges into independent pieces. 
# 
# This strategy involves 2 steps, each of which scales down the problem: 
#   
# 1. Solving the problem for a _single element_ of the list.  
# Once we’ve solved that problem, `purrr` takes care of generalising the solution to every element in the list.
# 
# 2. Breaking a complex problem down into _smaller sub-problems_ that allow us to advance towards a solution.  
# With `purrr`, we get many small pieces that we can compose together with the pipe (`%>%`).
# 
# This scaling-down strategy makes it easier to solve new problems and to understand our solutions to old problems when we re-read older code.


# 21.4.1 Exercises

# 1. Read the documentation for apply(). 
#    In the 2d case, what two for loops does it generalise over?

# Solution: 
# - MARGIN = 1   corresponds to   for (i in 1:nrow(df))
# - MARGIN = 2   corresponds to   for (i in 1:ncol(df))

# 2. Adapt col_summary() so that it only applies to numeric columns. 
#    You might want to start with an is_numeric() function that returns a logical vector that has a TRUE corresponding to each numeric column.

df
is.numeric(df[, 1])  # why FALSE?
is_double(df)
is.double(df[, 1:ncol(df)])  # why FALSE?

# Note:
# length(df)  # 4



## `map` functions: ----

# The pattern of looping over a vector, doing something to each element and saving the results is so common that the `purrr` package provides a family of functions for it. 
# There is a function for each type of output:
#   
# - `map()` makes a _list_.
# - `map_lgl()` makes a _logical vector_.
# - `map_int()` makes an _integer vector_.
# - `map_dbl()` makes a _double vector_.
# - `map_chr()` makes a _character vector_.
# 
# Each function takes a vector as input, applies a function to each element, and then returns a new vector that’s the same length (and has the same names) as the input.  
# The type of the output vector is determined by the suffix to the map function.


# Using map on the above example (with doubles as output):

map_dbl(df, mean)
map_dbl(df, median)
map_dbl(df, sd)

# Note: Without the suffix, 
# map(df, sd)
# returns a list of 4 elements. 

# With `map`, our focus is on the function/operation, not the bookkeeping.
# This is even more obvious when using the pipe:

df %>% map_dbl(mean)
df %>% map_dbl(median)
df %>% map_dbl(sd)

# There are a few differences between map_*() and col_summary():
  
# 1. All purrr functions are implemented in C. 
#    This makes them a little faster at the expense of readability.

# 2. The second argument, .f, the function to apply, can be a formula, 
#    a character vector, or an integer vector. 
#    We’ll learn about those handy shortcuts in the next section.

# 3. map_*() uses … ([dot dot dot]) to pass along 
#    additional arguments to .f each time it’s called:
  
map_dbl(df, mean, trim = 0.5)

# 4. The map functions preserve names:
  
z <- list(x = 1:3, y = 4:5)
map_int(z, length)







## +++ here now +++ ------



## Appendix ------

## Web:  

# Best practices for scientific computing:
# - http://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1001745

# Advanced R:
# Book at http://adv-r.had.co.nz/. 
# Chapter on Functions: http://adv-r.had.co.nz/Functions.html 

# Nice R code:
# - https://nicercode.github.io/ 
# - https://nicercode.github.io/blog/2013-04-05-why-nice-code/ 
# - https://nicercode.github.io/guides/functions/

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