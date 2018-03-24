## r4ds: Chapter 12: Tidy data  
## Code for http://r4ds.had.co.nz/tidy-data.html
## hn spds uni.kn
## 2018 03 24 ------

## Quotes: ------

## “Happy families are all alike; every unhappy family is unhappy in its own way.” 
##  Leo Tolstoy

## “Tidy datasets are all alike, but every messy dataset is messy in its own way.” 
##  Hadley Wickham


## 12.1 Introduction ------

# In this chapter, we learn a consistent way to organise data (in R)  
# -- an organisation called "tidy" data. 

# Getting data into this format requires some work, 
# but that work pays off in the long term. 

# The tidyr package addresses practical problems.
# For more theory, see the Tidy Data paper published in the Journal of Statistical Software
# at http://www.jstatsoft.org/v59/i10/paper. 

# In this chapter we’ll focus on tidyr, a package that provides tools that help tidying up messy datasets. 
# tidyr is a core member of the tidyverse: 

library(tidyverse)


## 12.2 Tidy data (Definition and Motivation) ------

# Data can be represented in multiple ways. 

# Example of the same data organised in 4 different ways:

table1
table2
table3
table4a
table4b
table5

# See 
?table1 # for semantics and source of data

# These are all representations of the same underlying data, 
# but they are not equally easy to use. 

# Note: What is "easy" or "hard" depends not just on the data (and its format), 
#       but also on (its degree of fit/match to) the task and methods/tools.

# One dataset, the tidy dataset, will be much easier to work with inside the tidyverse.


## Definition: There are 3 interrelated rules which make a dataset "tidy":

# 1. Each variable must have its own column.
# 2. Each observation must have its own row.
# 3. Each value must have its own cell.

# Figure 12.1 shows the rules visually: 
# http://r4ds.had.co.nz/tidy-data.html#fig:tidy-structure 

# These three rules are interrelated because it’s impossible to only satisfy 2 of the 3. 
# That interrelationship leads to an even simpler set of practical instructions:

# A. Put each dataset in a tibble.
# B. Put each variable in a column.

# In the above example, only table1 is tidy. 
# It’s the only representation in which each column is a variable.
# (Note that you need to interpret the semantics of the variables 
#  to make and understand this statement.)


## Advantages of tidy data:

# 1. Consistency: Consistent data structures make it easier to learn the tools 
#    that work with it because they have an underlying uniformity.

# 2. Vectorization: Placing variables in columns allows R’s vectorised nature to shine. 
#    For instance, mutate and summary functions (and most built-in R functions) work with vectors of values. 
#    That makes transforming tidy data feel particularly natural.

# 3. Matching data and tools: 
#    dplyr, ggplot2, and other packages are designed to work with tidy data.


## Examples of working with tidy table1:

table1

# (a) Compute expected rate per 10,000 people: 
table1 %>% 
  mutate(per_10k = (cases / population) * 10000)

# (b) # Compute number of cases expected per year:
table1 %>% 
  count(year, wt = cases)

# Compute number of cases expected per country:
table1 %>% 
  count(country, wt = cases)

# by country and year (as in original table1):
table1 %>% 
  group_by(country) %>%
  count(year, wt = cases)

# Visualise changes over time: 
library(ggplot2)

ggplot(table1, aes(year, cases, group = country, color = country)) + 
  geom_line(aes(linetype = country), size = 1) + 
  geom_point(aes(shape = country), size = 3) + 
  theme_light()


## [test.quest]: Make a corresponding bar chart: 

# ?geom_bar

ggplot(table1, aes(x = year, y = cases)) + 
  geom_bar(aes(fill = country), stat = "identity", position = "dodge") + 
  theme_light()


## 12.2.1 Exercises -----

# 1. Using prose, describe how the variables and observations 
#    are organised in each of the sample tables.

table1  # is tidy (3 criteria), but also in long format 
table2  # is table1 in long format (type - count)
table3  # combines cases/population into rate
table4a # contains cases in wide format
table4b # contains populations in wide format 
table5  # splits year of table3 into 2 variables (century, year)

# 2. Compute the rate for (a) table2, and (b) table4a + table4b. 
#    You will need to perform four operations:
#    a. Extract the number of TB cases per country per year.
#    b. Extract the matching population per country per year.
#    c. Divide cases by population, and multiply by 10000.
#    d. Store back in the appropriate place.


# (a) from table2: 
table2

cases <- table2 %>%
  filter(type == "cases") %>%
  group_by(country, year)
cases

population <- table2 %>%
  filter(type == "population") %>%
  group_by(country, year)
population

rate <- cases$count/population$count * 10000
rate # contains desired rates

# ???: How to add column(s) to an existing tibble with dplyr?
mutate(cases, 
       rate = rate) # does not work... 

# (b) from table4a and table4b: 

table4a # contains cases
table4b # contains populations

table4c <- table4a[, -1]/table4b[, -1] * 10000
table4c # contains desired rates

# 3. Which representation is easiest to work with? Which is hardest? Why?

#    Answer: This (generally) depends on the type of task and tools.
  
# 4. Recreate the plot showing change in cases over time using table2 
#    instead of table1. What do you need to do first?

cases <- filter(table2, type == "cases")  # 1. filter to remove population counts 
cases

ggplot(cases, aes(x = year, y = count, group = country, color = country)) +
  geom_line(aes(linetype = country), size = 1) + 
  geom_point(aes(shape = country), size = 3) + 
  theme_light()


## 12.3 Spreading and gathering ------

# Why is data not always tidy?  
# 2 main reasons:

# 1. Ignorance:  Most people aren’t familiar with the principles of tidy data. 
# 2. Other priorities: Ensure easy of entry, 
#    particular methods require particular (e.g., wide or long) formats.

# This means for most real analyses, you’ll need to do some tidying. 

# Step 1: Figure out what the variables and observations are. 
# Sometimes this is easy; otherwise consult whoever generated the data. 

# Step 2: Resolve one of two common problems:
# a. One variable might be spread across multiple columns.
# b. One observation might be scattered across multiple rows.

# Typically a dataset will only suffer from one of these problems; 
# it’ll only suffer from both if you’re really unlucky! 

# To fix these problems, you’ll need the two most important functions in tidyr: 
# - gather() and 
# - spread().


## 12.3.1 Gathering -----

# A common problem is a dataset where some of the column names are  
# NOT names of variables, but values of a variable. 

# Consider table4a: 
# the column names 1999 and 2000 represent values of the year variable, 
# and each row represents 2 observations, not 1:

table4a

# Note: This is common in the wide format which some programs require 
#       (to show each case/observation in 1 row, and multiple measurements in columns).





## +++ here now +++ ------



## [test.quest]:

## (1) Understand, redo, and improve on 
##     http://www.sharpsightlabs.com/blog/us-metro-gdp/


## Appendix ------

# See 

vignette("tidy-data")
?tidyr # and http://tidyr.tidyverse.org 

# This chapter provided a practical introduction to tidy data and the tidyr package. 

# To learn more about the underlying theory, see the Tidy Data paper 
# in the Journal of Statistical Software: http://www.jstatsoft.org/v59/i10/paper.

## ------
## eof.