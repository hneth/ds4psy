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

## 

# purrr package:

# `purrr` provides functions that eliminate the need for many common for loops. 

# The `apply` family of functions in base R (apply(), lapply(), tapply(), etc) 
# solve a similar problem, but purrr is more consistent and thus is easier to learn.

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