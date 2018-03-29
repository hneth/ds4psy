## r4ds: Chapter 13: Relational data
## Code for http://r4ds.had.co.nz/relational-data.html
## hn spds uni.kn
## 2018 03 29 ------

## [see Book chapter 10: "Relational data with dplyr"] 


## 13.1 Introduction ------

# Most real-world data analyses involve more than a single table of data. 

# Typically you have many tables of data, and you must combine them 
# to answer the questions that you’re interested in. 

# Collectively, multiple tables of data are called "relational data" because it is 
# the relations between tables, not just the individual datasets, that are important.


# Relations are always defined between a pair of tables. 
# All other relations are built up from this simple idea: 
# the relations of three or more tables are always a property of the relations between each pair. 

# Sometimes both elements of a pair can be the same table! 
# This is needed if, for example, you have a table of people, and 
# each person has a reference to their parents.

# To work with relational data you need verbs that work with pairs of tables. 
# There are 3 families of verbs designed to work with relational data:
  
# 1. Mutating joins, which add new variables to one data frame 
#    from matching observations in another.

# 2. Filtering joins, which filter observations from one data frame 
#    based on whether or not they match an observation in the other table.

# 3. Set operations, which treat observations as if they were set elements.

# The most common place to find relational data is in a relational database management system (or RDBMS), a term that encompasses almost all modern databases. If you’ve used a database before, you’ve almost certainly used SQL. If so, you should find the concepts in this chapter familiar, although their expression in dplyr is a little different. Generally, dplyr is a little easier to use than SQL because dplyr is specialised to do data analysis: it makes common data analysis operations easier, at the expense of making it more difficult to do other things that aren’t commonly needed for data analysis.

# We explore relational data from nycflights13 using the two-table verbs from dplyr:

library(tidyverse) # includes: library(dplyr)
library(nycflights13)

## +++ here now +++ ------

## 13.2 nycflights13 ------
## 13.3 Keys ------
## 13.4 Mutating joins ------
## 13.5 Filtering joins ------
## 13.6 Join problems ------
## 13.7 Set operations ------

## [test.quest]: ------



## Appendix ------

# See 

# dplyr: Two-table verbs vignette: [dplyr::two-table]()	
# - vignette("two-table", package = "dplyr")
# - https://cran.r-project.org/web/packages/dplyr/vignettes/two-table.html

# Web: 
# - http://www.rpubs.com/williamsurles/293454

# - Data Wrangling Cheatsheet: https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf 


## ------
## eof.