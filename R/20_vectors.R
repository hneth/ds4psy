## r4ds: Chapter 20: 
## Code for http://r4ds.had.co.nz/vectors.html 
## hn spds uni.kn
## 2018 06 08 ------


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
  
# 1. Its type, which you can determine with typeof(): 

typeof(letters)
#> [1] "character"

typeof(1:10)
#> [1] "integer"

typeof(1:10 > 3)
#> [1] "logical" 

# 2. Its length, which you can determine with length(): 

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

# We can also create them by hand with c():
  
c(TRUE, TRUE, FALSE, NA)
#> [1]  TRUE  TRUE FALSE    NA


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

?round()

x <- -100:99 + .5
x
mean(x) # => 0

mean(round(x))   # preserves mean (in this case)
mean(ceiling(x)) # rounds up
mean(floor(x))   # rounds down
mean(trunc(x))   # drops decimal (and happens to preserve mean in this case)


# 5. What functions from the readr package allow you to turn a string 
#    into logical, integer, and double vector?

# library(tidyverse)
# ?readr

# parse_logical(x, na = c("", "NA"), locale = default_locale())
# parse_integer(x, na = c("", "NA"), locale = default_locale())
# parse_double(x, na = c("", "NA"), locale = default_locale())

s <- c("A", "B", "C", "TRUE", "FALSE", NA, 1, 2, 3, 1/2, sqrt(2))

parse_logical(s)
parse_integer(s)
parse_double(s)


## 20.4 Using atomic vectors ------ 

# Now that you understand the different types of atomic vector, 
# it’s useful to review some of the important tools for working with them. 
# These include:
  
# 1. How to convert from one type to another, 
#    and when that happens automatically: Coercion. 
#
# 2. How to tell if an object is a specific type of vector: Test functions. 
#
# 3. What happens when you work with vectors of different lengths: Recycling. 
#
# 4. How to name the elements of a vector: Naming.
#
# 5. How to pull out elements of interest: Subsetting. 


## 20.4.1 Coercion ----- 

# There are 2 ways to convert, or coerce, one type of vector to another:
  
# 1. Explicit coercion happens when we call a function like 
#    as.logical(), as.integer(), as.double(), or as.character(). 

#    Whenever we find ourselves using explicit coercion, 
#    we should always check whether we can make the fix upstream, 
#    so that the vector never had the wrong type in the first place. 
#    For example, we may need to tweak our readr col_types specification. 

# 2. Implicit coercion happens when we use a vector in a specific context 
#    that expects a certain type of vector. 
#    For example, when we use a logical vector with a numeric summary function, 
#    or when we use a double vector where an integer vector is expected.

# As explicit coercion is used relatively rarely, and is largely easy to understand, 
# we’ll focus on implicit coercion here:

# We’ve already seen the most important type of implicit coercion: 
# using a logical vector in a numeric context. 
# In this case TRUE is converted to 1 and FALSE converted to 0. 
# That means the sum of a logical vector is the number of trues, 
# and the mean of a logical vector is the proportion of trues:

x <- 1:30
y <- x > 10
sum(y)  # how many are greater than 10?
#> [1] 20

mean(y) # what proportion are greater than 10?
#> [1] 0.6667


# We may see some code (typically older) that relies on implicit coercion 
# in the opposite direction, from integer to logical:

if (length(x)) {
  # do something
}

# In this case, 0 is converted to FALSE and everything else is converted to TRUE. 
# This makes it harder to understand our code, and we don’t recommend it. 
# Instead be explicit: length(x) > 0.

# It’s also important to understand what happens when we try and create a vector 
# containing multiple types with c(): 
# The most complex type always wins.

typeof(c(TRUE, 1L))
#> [1] "integer"

typeof(c(1L, 1.5))
#> [1] "double"

typeof(c(1.5, "a"))
#> [1] "character"

# An atomic vector can not have a mix of different types because the type 
# is a property of the complete vector, not the individual elements. 

# If we need to mix multiple types in the same vector, we should use a list, 
# which we’ll learn about shortly.

## 20.4.2 Test functions ----- 

# Sometimes we want to do different things based on the type of vector. 
# One option is to use typeof(). 
# Another is to use a test function which returns a TRUE or FALSE. 

# Base R provides many functions like is.vector() and is.atomic(), 
# but they often returns surprising results. Instead, it’s safer to
# use the is_* functions provided by purrr, which are summarised here:

# function:  	lgl 	int 	dbl 	chr 	list
# -----------------------------------------
# is_logical() 	x 				
# is_integer() 		x 			
# is_double() 			x 		
# is_numeric() 		x 	x 		
# is_character() 				x 	
# is_atomic() 	x 	x 	x 	x 	
# is_list() 					x
# is_vector()

# library(tidyverse)
is.logical(1:2 > 1) # => TRUE

is_logical(1:2 > 1) # => TRUE
is_logical(1:2)     # => FALSE

is_integer(1:2)     # => TRUE
is_double(1:2)      # => FALSE

is_double(1/2)      # => TRUE
is_numeric(1/2)     # => TRUE (Warning: Deprecated)

is_character(1/2)   # => FALSE
is_character("AB")  # => TRUE

is_atomic(1/2)      # => TRUE
is_list(1/2)        # => FALSE
is_vector(1/2)      # => TRUE

# Each predicate also comes with a “scalar” version, like is_scalar_atomic(), 
# which checks that the length is 1. This is useful, for example, 
# if we want to check that an argument to our function is a single logical value.

## 20.4.3 Scalars and recycling rules -----

# In addition to coercing the types of vectors, R will also implicitly 
# coerce the length of vectors. This is called vector recycling, 
# because the shorter vector is repeated, or recycled, to the same length 
# as the longer vector.

# This is most useful when mixing vectors and “scalars”
# (R doesn’t actually have scalars: instead, a single number is a vector of length 1.)  
# Because there are no scalars, most built-in functions are vectorised, 
# meaning that they will operate on a vector of numbers. 
# That’s why, for example, this code works:
  
sample(10) + 100
#>  [1] 109 108 104 102 103 110 106 107 105 101

runif(10) > 0.5
#>  [1]  TRUE  TRUE FALSE  TRUE  TRUE  TRUE FALSE  TRUE  TRUE  TRUE

# In R, basic mathematical operations work with vectors. 
# That means that we should never need to perform explicit iteration 
# when performing simple mathematical computations.

# It’s intuitive what should happen if we add 2 vectors of the same length, 
# or a vector and a “scalar”.
# But what happens if we add two vectors of different lengths?
  
1:10 + 1:2
#> [1]  2  4  4  6  6  8  8 10 10 12

# => R will expand the shortest vector to the same length as the longest, 
#    so called recycling. 

# Recycling is silent except when the length of the longer is not an integer multiple 
# of the length of the shorter:
  
1:10 + 1:3
#> Warning in 1:10 + 1:3: longer object length is not a multiple of shorter
#> object length
#>  [1]  2  4  6  5  7  9  8 10 12 11

# While vector recycling can be used to create very succinct, clever code, 
# it can also silently conceal problems. 
# For this reason, the vectorised functions in tidyverse 
# throw errors when we recycle anything other than a scalar. 

# If we do want to recycle, we need to do it explicitly with rep():
  
tibble(x = 1:4, y = 1:2)
#> Error: Variables must be length 1 or 4, not 2 
#> Problem variables: 'y'

tibble(x = 1:4, y = rep(1:2, 2))
#> # A tibble: 4 × 2
#>       x     y
#>   <int> <int>
#> 1     1     1
#> 2     2     2
#> 3     3     1
#> 4     4     2

tibble(x = 1:4, y = rep(1:2, each = 2))
#> # A tibble: 4 × 2
#>       x     y
#>   <int> <int>
#> 1     1     1
#> 2     2     1
#> 3     3     2
#> 4     4     2


## 20.4.4 Naming vectors ----- 

# All types of vectors can be named. 

# (1) We can name them during creation with c():
  
c(x = 1, y = 2, z = 4)
#> x y z 
#> 1 2 4

# (2) Or after the fact with purrr::set_names():
  
purrr::set_names(1:3, c("a", "b", "c"))
#> a b c 
#> 1 2 3

# Named vectors are most useful for subsetting, 
# described next.


## 20.4.5 Subsetting ----- 

# So far we’ve used dplyr::filter() to filter the rows in a tibble. 
# filter() only works with tibble, so we’ll need new tool for vectors: [. 

# [ is the subsetting function, and is called x[a]. 

# There are 4 types of things that you can subset a vector with:
                                                                                                                                              
# 1. A numeric vector containing only integers. 
#    The integers must either be all positive, all negative, or zero:

# Subsetting with positive integers keeps the elements at those positions:
x <- c("one", "two", "three", "four", "five")                                                                                                                             
x[c(3, 2, 5)]

# By repeating a position, you can actually make a longer output than input:
x[c(1, 1, 5, 5, 5, 2)]

# Negative values drop the elements at the specified positions:
x[c(-1, -3, -5)]

# Mixing positive and negative values yields an error:
x[c(1, -1)]

# The error message mentions subsetting with zero, which returns no values:
x[0]

# 2. Subsetting with a logical vector keeps all values corresponding to a TRUE value. 
#    This is most often useful in conjunction with the comparison functions:

x <- c(10, 3, NA, 5, 8, 1, NA)

# All non-missing values of x: 
x[!is.na(x)]
#> [1] 10  3  5  8  1

# All even (or missing!) values of x: 
x[x %% 2 == 0]
#> [1] 10 NA  8 NA

# 3. Named vectors can be subset with a character vector:

x <- c(abc = 1, def = 2, xyz = 5)
x[c("xyz", "def")]
#> xyz def 
#>   5   2

# The simplest type of subsetting is nothing, x[], which returns the complete x. 
# This is not useful for subsetting vectors, but it is useful when subsetting matrices 
# (and other high dimensional structures) because it lets you select 
# all the rows or all the columns, by leaving that index blank. 
# For example, if x is 2d, x[1, ] selects the first row and all the columns, 
# and x[, -1] selects all rows and all columns except the first.

# To learn more about the applications of subsetting, 
# read the “Subsetting” chapter of Advanced R: 
# http://adv-r.had.co.nz/Subsetting.html#applications.


## [ vs. [[: 

# There is an important variation of [ called [[. 
# [[ only ever extracts a single element, and always drops names. 
# It’s a good idea to use it whenever you want to make it clear 
# that you’re extracting a single item, as in a for loop. 

# The distinction between [ and [[ is most important for lists, 
# as we’ll see shortly.                                                                                                                                                                                                                                                          20.4.6 Exercises

## 20.4.6 Exercises ----- 



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