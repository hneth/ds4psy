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
  
# 1. Mutating joins:
#    Add new variables to a table from matching observations in another table.

# 2. Filtering joins:
#    Filter observations from one table based on whether or not 
#    they match an observation in another table.

# 3. Set operations:
#    treat observations as if they were set elements.

# The most common place to find relational data is in a 
# relational database management system (or RDBMS), 
# a term that encompasses almost all modern databases. 

# If you’ve used a database before, you’ve almost certainly used SQL. 
# If so, you should find the concepts in this chapter familiar, 
# although their expression in dplyr is a little different. 

# Generally, dplyr is a little easier to use than SQL because 
# dplyr is specialised to do data analysis: 
# it makes common data analysis operations easier, 
# at the expense of making it more difficult to do other things 
# that aren’t commonly needed for data analysis.

# We explore relational data from nycflights13 using the two-table verbs from dplyr:

library(tidyverse) # includes: library(dplyr)
library(nycflights13)

## 13.2 nycflights13 ------

# Example of relational data:
# nycflights13 contains 4 tibbles that are related to the 
# flights table that we used in Chapter 5: data transformation:

?nycflights13::flights

nycflights13::flights  # all 336,776 flights departing from NYC in 2013
nycflights13::airlines # links carrier codes to airline names
nycflights13::airports # links faa codes to aiport name, location, and timezone
nycflights13::planes   # links tailnum to plane info (year, make, model, seats, engine)
nycflights13::weather  # links origin and time to weather info

# [test.quest]: Daily temperature curves in 3 NYC airports by month
{
  # Using only data from nycflights13::weather 
  # Tools to know: dplyr (group_by, summarise, mutate), ggplot (facet_wrap, geom_line)
  
  # Compute average temperature (in degrees celsius) 
  # for each hour, month, and airport.
  
  # To convert temperatures in degrees Fahrenheit to Celsius:
  # subtract 32 and multiply by 5/9.
  
  wt <- nycflights13::weather %>% 
    group_by(origin, month, hour) %>%
    summarise(n_count = n(),
              n_non_NA = sum(!is.na(temp)),
              mn_temp = mean(temp, na.rm = TRUE),
              sd_temp = sd(temp, na.rm = TRUE)
    ) %>%
    mutate(mn_temp_c = (mn_temp - 32) * 5/9)
  
  # 1st version: 
  ggplot(wt, aes(x = hour, y = mn_temp_c, color = origin)) +
    facet_wrap(~month) +
    # geom_point() +
    geom_line(size = 1) +
    theme_bw()
  
  # Note: 
  # - Similar curves on all 3 airports (which is to be expected):
  #   JFK seems a little colder at night (from April to July)
  # - Differentiating by origin is not very useful --- collapse across origins.
  # - Plot all 12 months in 1 plot.
  
  library(RColorBrewer)
  display.brewer.all()
  
  # ?brewer.pal
  season.cols <- c(brewer.pal(3,"Greens"), brewer.pal(6,"OrRd"), brewer.pal(3, "Blues"))
  
  # 2nd version:
  ggplot(wt, aes(x = hour, y = mn_temp_c, color = factor(month))) +
    facet_wrap(~origin) +
    # geom_point() +
    geom_line(aes(group = month), size = 1.5) +
    scale_color_manual(values = season.cols) +
    theme_bw()
  
  # ?brewer
  
  # Interpretation: 
  # - All 3 locations show similar pattern (which is to be expected)
  # - Daily temperature wave has interesting shape: 
  #   Declines up to 10am, then rises until about 18/20.
  
}

# A diagram shows the relationships between the different tables:
# See http://r4ds.had.co.nz/relational-data.html#nycflights13-relational 
# and http://r4ds.had.co.nz/relational-data.html#exercises-26 Exercise 2

## 13.2.1 Exercises -----

# 1. Imagine you wanted to draw (approximately) the route 
#    each plane flies from its origin to its destination. 
#  - What variables would you need? 
#  - What tables would you need to combine?


## +++ here now +++ ------

# 2. I forgot to draw the relationship between weather and airports. What is the
# relationship and how should it appear in the diagram?
   
# 3. weather only contains information for the origin (NYC) airports. If it
# contained weather records for all airports in the USA, what additional
# relation would it define with flights?
   
# 4. We know that some days of the year are “special”, and fewer people than
# usual fly on them. How might you represent that data as a data frame? What
# would be the primary keys of that table? How would it connect to the existing
# tables?
   
  




## 13.3 Keys ------

## 13.4 Mutating joins ------

## 13.5 Filtering joins ------

## 13.6 Join problems ------

## 13.7 Set operations ------

## Appendix ------

# See 

# dplyr: Two-table verbs vignette: [dplyr::two-table]()	
# - vignette("two-table", package = "dplyr")
# - https://cran.r-project.org/web/packages/dplyr/vignettes/two-table.html

# Web: 
# - http://www.rpubs.com/williamsurles/293454

# - Data Wrangling Cheatsheet: https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf 


## Ideas for test questions [test.quest]: ------

# - Scenario involving family dynasties (e.g., Games of thrones, Lord of the Rings, Harry Potter, Star Wars, ...)
# - Scenario involving patients/doctors/insurances/pharma: 


## ------
## eof.