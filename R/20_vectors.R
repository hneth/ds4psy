## r4ds: Chapter 20: 
## Code for http://r4ds.had.co.nz/vectors.html 
## hn spds uni.kn
## 2018 05 21 ------


## Topics: -----



## Quotes: ------





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