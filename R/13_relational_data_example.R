## r4ds: Example for Chapter 13: Relational data
## Example for http://r4ds.had.co.nz/relational-data.html
## hn spds uni.kn
## 2018 06 06 ------

## Available online at 
## http://rpository.com/ds4psy/R/13_relational_data_example.R 

## [see Book chapter 10: "Relational data with dplyr"] 

## Note: dplyr implements a grammar of data transformation.
##       This chapter concerns transformations involving multiple tables
##       that are linked by keys that define relations.


## 13.1 Introduction ------

# Most real-world data analyses involve more than a single table of data. 

# Typically we have many tables of data, and we must combine them 
# to answer the questions that we’re interested in. 

# Collectively, multiple tables of data are called "relational data" because it is 
# the relations between tables, not just the individual datasets, that are important.

# _Relations_ are always defined between a pair of tables. 
# All other relations are built up from this simple idea: 
# the relations of three or more tables are always a property of the relations between each pair. 

# To work with relational data we need tools (or verbs) that work with pairs of tables. 

# There are 3 families of tools (verbs) designed to work with relational data:

# 1. Mutating joins: 
#    Add new variables to a table from matching observations in another table.

# 2. Filtering joins:
#    Filter observations from one table based on whether or not 
#    they match an observation in another table.

# 3. Set operations:
#    Combine or distinguish observations from tables as if they were set elements.


## In class example: ------ 

# We explore relational data using the 2-table verbs from dplyr:
library(tidyverse) # includes: library(dplyr)

## A typical case of using join-commands on people data with 2 measurements:

## Reading in data tables: ------ 

## From online file:
data_t1 <- read_csv(file = "http://rpository.com/ds4psy/data/data_t1.csv")
data_t2 <- read_csv(file = "http://rpository.com/ds4psy/data/data_t2.csv")

## From local file:
# data_t1 <- as_tibble(read.csv(file = "data/data_t1.csv"))
# data_t2 <- as_tibble(read.csv(file = "data/data_t2.csv"))


## Combining both tables: ------ 

## View data:
data_t1  # => 20 cases (people with 2 dependent variables)
data_t2  # => 20 cases (people with 2 dependent variables)

## Sort both by name:
data_t1 %>% arrange(name)
data_t2 %>% arrange(name)  # => same people, but different NA values




## (A) Simple case: Both tables have identical names: ----- 

## 1. Mutating joins: ----

m1a <- left_join(data_t1, data_t2, by = "name")
m1a

m1b <- left_join(data_t1, data_t2, by = c("name", "gender"))
m1b

all.equal(m1a, m1b)  # => m1a contains gender twice: gender.x vs. gender.y
m1 <- m1b

m2 <- right_join(data_t2, data_t1, by = c("name", "gender"))
m2

m3 <- full_join(data_t1, data_t2, by = c("name", "gender"))
m3

m4 <- inner_join(data_t1, data_t2, by = c("name", "gender"))
m4

## Show equality:   
all.equal(m1, m2)  # => TRUE
all.equal(m1, m3)  # => TRUE
all.equal(m1, m4)  # => TRUE



## 2. Filtering joins: ----  

f1 <- semi_join(data_t1, data_t2, by = c("name", "gender"))
f1 # => variables/columns from data_t2 dropped.

f2 <- anti_join(data_t1, data_t2, by = c("name", "gender"))
f2 # => 0 cases (rows) left.


## 3. Set operations: ---- 

# union(data_t1, data_t2)      # => ERROR due to different variables (columns). 
# intersect(data_t1, data_t2)  # => ERROR due to different variables (columns). 



## (B) Different cases in both tables: ------ 

## See what changes, when cases (i.e., rows) differ: 

## Data:
set.seed(7)  # for replicability
data_t3 <- data_t1[sample(1:(nrow(data_t1) - 2)), ] # remove 2 random rows
data_t4 <- data_t2[sample(1:(nrow(data_t2) - 4)), ] # remove 4 random rows

# Check which name differs:
data_t3 %>% arrange(name) # => 18 people left
data_t4 %>% arrange(name) # => 16 people left

## Joining tables with different cases: 
m4 <- left_join(data_t3, data_t4, by = c("name", "gender")) %>% arrange(name)
m4 # => 18 people (from data_t3) left, additional NA values in like_2 and bnt_2

m5 <- left_join(data_t4, data_t3, by = c("name", "gender")) %>% arrange(name)
m5 # => 16 people (from data_t4) left, additional NA values in like_1 and bnt_1

m6 <- inner_join(data_t3, data_t4, by = c("name", "gender")) %>% arrange(name)
m6 # => 15 people left (which were present in both tables)

m7 <- semi_join(data_t3, data_t4, by = c("name", "gender")) %>% arrange(name)
m7 # => 15 people left (which were present in both tables), but only columns from data_t3


## ------
## eof.