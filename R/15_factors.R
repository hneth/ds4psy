## r4ds: Chapter 15: Factors
## Code for http://r4ds.had.co.nz/factors.html 
## hn spds uni.kn
## 2018 04 15 ------

## [see Book chapter 1x: "..."]

## Note: forcats is not part of the core tidyverse. 



## 15.1 Introduction ------

# In R, factors are used to work with _categorical_ variables, 
# variables that have a fixed and known set of possible values. 
# They are also useful when you want to display character vectors 
# in a non-alphabetical order.

# Historically, factors were much easier to work with than characters. 
# As a result, many of the functions in base R automatically convert 
# characters to factors. This means that factors often crop up in places 
# where they’re not actually helpful. 

# Fortunately, you don’t need to worry about that in the tidyverse, 
# and can focus on situations where factors are genuinely useful.

# Historical context on factors: 
# stringsAsFactors: An unauthorized biography by Roger Peng, 
# https://simplystatistics.org/2015/07/24/stringsasfactors-an-unauthorized-biography/ 
# and 
# stringsAsFactors = <sigh> by Thomas Lumley.
# http://notstatschat.tumblr.com/post/124987394001/stringsasfactors-sigh


## 15.1.1 Prerequisites 

# This chapter will focus on the forcats package, 
# which provides tools for dealing with categorical variables 
# (and is an anagram of factors). 
# forcats is not part of the core tidyverse, so we need to load it explicitly:

library(tidyverse)
library(forcats)


# 15.2 Creating factors ------

# Imagine a variable that records month:
x1 <- c("Dec", "Apr", "Jan", "Mar")

# Using a string (i.e., variables of text information) to record this variable 
# creates 2 problems:

# 1. There are only 12 possible months (i.e., a fixed set of values), 
#    and there’s nothing saving you from typos:
x2 <- c("Dec", "Apr", "Jam", "Mar")

# 2. It doesn’t sort in a useful way:
sort(x1) # sorts alphabetically 


# You can fix both of these problems with a factor. 
# To create a factor you start by creating a list of the valid levels:
  
month_levels <- c(
    "Jan", "Feb", "Mar", "Apr", "May", "Jun", 
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    )

# Now you can create a factor:
y1 <- factor(x1, levels = month_levels)
y1

# And any values NOT in the set (of levels) 
# will be silently converted to NA:
y2 <- factor(x2, levels = month_levels)
y2

# If you want a warning, you can use readr::parse_factor():
y2 <- parse_factor(x2, levels = month_levels)

# If you omit the levels argument, they’ll be taken 
# from the data in alphabetical order:
factor(x1)

# Sometimes you’d prefer that the order of the levels 
# match the order of the first appearance in the data. 
# You can do that 
# (a) when creating the factor 
#     by setting levels to unique(x), or 
# (b) after the fact(or), 
#     with fct_inorder():

f1 <- factor(x1, levels = unique(x1))  # sets levels to order of appearance 
f1

f2 <- x1 %>% factor() %>% fct_inorder() # creates factor and then fixes order of levels
f2

all.equal(f1, f2)  # => TRUE


# To access the set of valid levels directly, 
# use levels():
levels(f2)


## 15.3 General Social Survey ------ 

# For the rest of this chapter, we’re going to focus on 
forcats::gss_cat

# It’s a sample of data from the General Social Survey, 
# which is a long-running US survey conducted by the 
# independent research organization NORC at the University of Chicago.
# http://gss.norc.org/

gss_cat
glimpse(gss_cat)

?gss_cat # provides info on package data


## +++ here now +++ ------




## Appendix ------

## Web: Regex cheatsheets: 
#  https://www.rstudio.com/wp-content/uploads/2016/09/RegExCheatsheet.pdf

## Documentation: ----- 

# For more historical context on factors, read 
# stringsAsFactors: An unauthorized biography by Roger Peng, 
# https://simplystatistics.org/2015/07/24/stringsasfactors-an-unauthorized-biography/ 
# and 
# stringsAsFactors = <sigh> by Thomas Lumley.
# http://notstatschat.tumblr.com/post/124987394001/stringsasfactors-sigh

# Vignettes of R packages: 

## Related tools:

## Ideas for test questions [test.quest]: ------

## Multiple choice [MC] questions: -----

## Practical questions: ----- 

## ------
## eof.