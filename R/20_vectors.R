## r4ds: Chapter 20: 
## Code for http://r4ds.had.co.nz/vectors.html 
## hn spds uni.kn
## 2018 05 21 ------


## 20 Vectors 

## 20.1 Introduction ------ 

# So far this book has focussed on tibbles and packages that work with them. 
# But as we start to write our own functions, and dig deeper into R, 
# we need to learn about vectors, the objects that underlie tibbles. 

# Someone learning R in a more traditional way is probably already familiar with vectors, 
# as most R resources start with vectors and work their way up to data frames and tibbles. 

# I think it’s better to start with tibbles because they’re immediately useful, 
# and then work your way down to the underlying components.

# Vectors are particularly important as most of the functions we will write 
# will work with vectors. It is possible to write functions that work with tibbles 
# (like ggplot2, dplyr, and tidyr), but the tools we need to write such functions 
# are currently idiosyncratic and immature. 

# I am working on a better approach, https://github.com/hadley/lazyeval, 
# but it will not be ready in time for the publication of the book. 
# Even when complete, you’ll still need you understand vectors, 
# it’ll just make it easier to write a user-friendly layer on top.


## 20.1.1 Prerequisites ----- 

# Base R data structures, 
# + a handful of functions from the purrr package 
# (to avoid some inconsistencies in base R):

library(tidyverse)


## 20.2 Vector basics

# There are 2 types of vectors:
  
# A - Atomic vectors, of which there are 6 types: 

# 1. logical, 
# 2. integer, 
# 3. double, 
# 4. character, 
# 5. complex, and 
# 6. raw. 

# Integer and double vectors are collectively known as numeric vectors.

# B - Lists, which are sometimes called recursive vectors 
#     because lists can contain other lists.

# The chief difference between atomic vectors and lists is that 
# - atomic vectors are homogeneous, while 
# - lists can be heterogeneous. 

# There’s one other related object: NULL. 
# NULL is often used to represent the absence of a vector (as opposed to NA which is used to represent the absence of a value in a vector). 
# NULL typically behaves like a vector of length 0. 

# Figure 20.1 summarises the interrelationships: 
# http://r4ds.had.co.nz/vectors.html#fig:datatypes


# Every vector has 2 key properties:
  
# 1. Its type, which you can determine with typeof().

typeof(letters)
#> [1] "character"

typeof(1:10)
#> [1] "integer"

# 2. Its length, which you can determine with length().

x <- list("a", "b", 1:10)
length(x)

# Vectors can also contain arbitrary additional metadata in the form of
# attributes. These attributes are used to create augmented vectors 
# which build on additional behaviour. 

# There are 3 important types of augmented vector:
  
# 1. Factors are built on top of integer vectors. 
# 2. Dates and date-times are built on top of numeric vectors. 
# 3. Data frames and tibbles are built on top of lists. 

# This chapter will introduce us to these important vectors 
# from simplest to most complicated. 

# We’ll start with atomic vectors, then build up to lists, 
# and finish off with augmented vectors.

## 20.3 Important types of atomic vector ------ 

# The 4 most important types of atomic vector are 
# logical, integer, double, and character. 

# Raw and complex are rarely used during a data analysis, 
# so I won’t discuss them here.

## 20.3.1 Logical ----- 

# Logical vectors are the simplest type of atomic vector 
# because they can take only three possible values: 
# FALSE, TRUE, and NA. 

# Logical vectors are usually constructed with comparison operators, 
# as described in 5.2.1. comparisons: http://r4ds.had.co.nz/transform.html#comparisons 

1:10 %% 3 == 0
#>  [1] FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE

# You can also create them by hand with c():
  
c(TRUE, TRUE, FALSE, NA)


## 20.3.2 Numeric ----- 

# Integer and double vectors are known collectively as numeric vectors. 

# In R, numbers are doubles by default. 
# To make an integer, place an L after the number:
  
typeof(1)
#> [1] "double"

typeof(1L)
#> [1] "integer"

1.5L
#> [1] 1.5 + Warning 

# The distinction between integers and doubles is not usually important, 
# but there are 2 important differences that you should be aware of:
  
# 1. Doubles are approximations. 
#    Doubles represent floating point numbers that can not always be 
#    precisely represented with a fixed amount of memory. 
#    This means that you should consider all doubles to be approximations. 
#    For example, what is square of the square root of two?
  
x <- sqrt(2) ^ 2
x
#> [1] 2

x - 2
#> [1] 4.44e-16

# This behavior is common when working with floating point numbers: 
# Most calculations include some approximation error. 

# Instead of comparing floating point numbers using ==, 
# we should use dplyr::near() which allows for some numerical tolerance:

2 == sqrt(2) ^ 2             # => FALSE
dplyr::near(2, sqrt(2) ^ 2)  # => TRUE

# Integers have 1 special value: NA, 
# while doubles have 4 special values: 
# NA, NaN, Inf and -Inf. 

# The 3 special values NaN, Inf and -Inf can arise during division:
  
c(-1, 0, 1) / 0
#> [1] -Inf  NaN  Inf

# Avoid using == to check for these other special values. 
# Instead use the helper functions 
# - is.finite(), 
# - is.infinite(), and 
# - is.nan():

is.finite(c(-1, 0, 1) / 0)   # => FALSE FALSE FALSE
is.infinite(c(-1, 0, 1) / 0) # => TRUE FALSE TRUE
is.nan(c(-1, 0, 1) / 0)      # => FALSE TRUE FALSE 
is.na(c(-1, 0, 1) / 0)       # => FALSE TRUE FALSE 


## 20.3.3 Character ----- 

# Character vectors are the most complex type of atomic vector, 
# because each element of a character vector is a string, 
# and a string can contain an arbitrary amount of data.

# You’ve already learned a lot about working with strings in 
# Ch. 14 strings: http://r4ds.had.co.nz/strings.html#strings

# Here we discuss one important feature of the underlying string 
# implementation: R uses a global string pool. 
# This means that each unique string is only stored in memory once, 
# and every use of the string points to that representation. 

# This reduces the amount of memory needed by duplicated strings. 
# You can see this behaviour in practice with pryr::object_size():
  
x <- "This is a reasonably long string."
pryr::object_size(x)
#> 136 B

y <- rep(x, 1000)
pryr::object_size(y)
#> 8.13 kB

# y doesn’t take up 1,000x as much memory as x, 
# because each element of y is just a pointer to that same string. 
# A pointer is 8 bytes, so 1000 pointers to a 136 B string is 
# 8 * 1000 + 136 = 8.13 kB.


## 20.3.4 Missing values ----- 

# Note that each type of atomic vector has its own missing value:
  
NA            # logical
#> [1] NA

NA_integer_   # integer
#> [1] NA

NA_real_      # double
#> [1] NA

NA_character_ # character
#> [1] NA

# Normally you don’t need to know about these different types because you can
# always use NA and it will be converted to the correct type using the implicit
# coercion rules described next. 

# However, there are some functions that are strict about their inputs, 
# so it’s useful to have this knowledge sitting in your back pocket 
# so you can be specific when needed.


## 20.3.5 Exercises ----- 

# 1. Describe the difference between is.finite(x) and !is.infinite(x).

# Both return the same values for most numbers:

is.finite(99^99)    # => TRUE
!is.infinite(99^99) # => TRUE

is.finite(1/0)     # => FALSE
!is.infinite(1/0)  # => FALSE

is.finite(-1/0)    # => FALSE
!is.infinite(-1/0) # => FALSE

# But not for NA and NaN: 

is.finite(NA)     # => FALSE
!is.infinite(NA)  # => TRUE

is.finite(NaN)    # => FALSE
!is.infinite(NaN) # => TRUE

# From https://jrnold.github.io/r4ds-exercise-solutions/vectors.html 

x <- c(0, NA, NaN, Inf, -Inf)
is.finite(x)
#> [1]  TRUE FALSE FALSE FALSE FALSE

!is.infinite(x)
#> [1]  TRUE  TRUE  TRUE FALSE FALSE

# is.finite considers only a number to be finite, 
# and considers missing (NA), not a number (NaN), 
# and positive and negative infinity to be not finite. 

# However, since is.infinite only considers Inf and -Inf to be infinite, 
# !is.infinite considers 0 as well as missing and not-a-number to be not infinite.

# So NA and NaN are neither finite or infinite. Mind blown.


# 2. Read the source code for dplyr::near() 
#    (Hint: to see the source code, drop the ()). How does it work?

dplyr::near

# Source code:
function (x, y, tol = .Machine$double.eps^0.5) {
  abs(x - y) < tol
}
<environment: namespace:dplyr>
  
# near() return TRUE iff absolute deviation of x and y is below tolerance tol. 
  
# 3. A logical vector can take 3 possible values. 
#    How many possible values can an integer vector take? 
#    How many possible values can a double take? 
#    (Use Google to do some research.)

.Machine

# 4. Brainstorm at least four functions that allow you to 
#    convert a double to an integer. 
#    How do they differ? Be precise.

# 5. What functions from the readr package allow you to turn a string 
#    into logical, integer, and double vector?
  



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