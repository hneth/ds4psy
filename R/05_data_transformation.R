## r4ds: Chapter 5: Data transformation 
## Code for http://r4ds.had.co.nz/5_data_transformation.html 
## hn spds uni.kn
## 2018 03 09 ------

## Quotes: ------

## ...

## 5.1 Introduction ------

## 5.1.1 Prerequisites

# In this chapter we’re going to focus on how to use the dplyr package, 
# another core member of the tidyverse. 
# We’ll illustrate the key ideas using data from the nycflights13 package, 
# and use ggplot2 to help us understand the data:

library(nycflights13)
library(tidyverse)

# Note conflicts: 
# dplyr overwrites some functions in base R. 
# If you want to use the base version of these functions after loading dplyr, 
# you’ll need to use their full names: stats::filter() and stats::lag().


?flights

flights
table(flights$dest)

# A tibble. Tibbles are data frames, but slightly tweaked to work better in the tidyverse. 

# Note row of three (or four) letter abbreviations under the column names. 
# These describe the type of each variable:
  
# - int stands for integers.
# - dbl stands for doubles, or real numbers.
# - chr stands for character vectors, or strings.
# - dttm stands for date-times (a date + a time).

# There are three other common types of variables that aren’t used in this dataset:
  
# - lgl stands for logical, vectors that contain only TRUE or FALSE.
# - fctr stands for factors, which R uses to represent categorical variables with fixed possible values.
# - date stands for dates. 


# 5.1.3 dplyr basics ------

# In this chapter you are going to learn the five key dplyr functions that allow you 
# to solve the vast majority of your data manipulation challenges:
  
# - Pick observations by their values (filter()).
# - Reorder the rows (arrange()).
# - Pick variables by their names (select()).
# - Create new variables with functions of existing variables (mutate()).
# - Collapse many values down to a single summary (summarise()).

# These can all be used in conjunction with group_by() which changes the 
# scope of each function from operating on the entire dataset to operating 
# on it group-by-group. 
# These six functions provide the verbs for a language of data manipulation:

# All verbs work similarly:
# - The first argument is a data frame.
# - The subsequent arguments describe what to do with the data frame, 
#   using the variable names (without quotes).
# - The result is a new data frame.


# 5.2 Filter rows with filter() ------

# filter() allows you to subset observations based on their values. 
# The first argument is the name of the data frame. 
# The second and subsequent arguments are the expressions that filter 
# the data frame. For example, we can select all flights on January 1st with:

jan1 <- filter(flights, month == 1, day == 1)
jan1

# Assigning and printing result: Wrap assignment in parentheses:

(dec25 <- filter(flights, month == 12, day == 25))


## 5.2.1 Comparisons ------

# To use filtering effectively, you have to know how to select the 
# observations that you want using the comparison operators. 
# R provides the standard suite: 
# > and >= vs. < and <=  
# != (not equal) vs. == (equal)

## Common problems:

# (1) = vs. ==:
filter(flights, month = 1) # yields error and should be:
filter(flights, month == 1) 

# (2) == vs. near():

?near # compares 2 numbers with tolerance:
.Machine$double.eps^0.5

sqrt(2)^2 == 2     # => FALSE (due to approximate computation)  [test.quest]
near(sqrt(2)^2, 2) # => TRUE (as it should)

## Boolean operators:
## &, |, !, xor() 

# Note:
filter(flights, month == 11 | 12) # finds all flights with month == 1, due to 
                                  # 11 | 12 => TRUE => 1  [test.quest]

# 3 ways to actually select flights from Nov or Dec:

filter(flights, month == 11 | month == 12) 

filter(flights, month %in% c(11, 12)) 

filter(flights, month > 10)  # knowing that range(month) = c(1, 12)
range(flights$month) # check

## De Morgan's law:
# !(x & y) == !x | !y
# !(x | y) == !x & !y 

# Exercise: Select flights that weren’t delayed (on arrival or departure) 
#           by more than two hours:     [test.quest]
  
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)

## Tip: Whenever you start using complicated, multipart expressions in filter(), 
## consider making them explicit variables instead. 
## That makes it much easier to check your work. 
## You’ll learn how to create new variables shortly.

## 5.2.3 Missing values ------

# NA represents an unknown value so missing values are “contagious”: 
# almost any operation involving an unknown value will also be unknown.

NA > 2
NA == 2
NA != 2

NA == NA  # indeed!

## Why is this so?
x <- NA  # Let x be Mary's age. We don't know how old she is.
y <- NA  # Let y be John's age. We don't know how old he is.

x == y   # Are John and Mary the same age?
# We don't know!

# Use is.na() if you want to determine if a value is missing:
is.na(x)

# filter() only includes rows where the condition is TRUE; 
# it excludes both FALSE and NA values. 
# If you want to preserve missing values, ask for them explicitly:
  
df <- tibble(x = c(1, NA, 3))

filter(df, x > 1)             # => excludes 1 and NA
filter(df, is.na(x) | x > 1)  # => excludes only 1 (i.e., includes NA)


## 5.2.4 Exercises ------

## 1. Find all flights that

flights

# a. Had an arrival delay of two or more hours

(a <- filter(flights, arr_delay >= 120))

# b. Flew to Houston (IAH or HOU)

(b <- filter(flights, dest == "IAH" | dest == "HOU"))
(b <- filter(flights, dest %in% c("IAH", "HOU")))

# c. Were operated by United, American, or Delta

flights
airlines

(c <- filter(flights, carrier %in% c("UA", "AA", "DL")))

# d. Departed in summer (July, August, and September)

(d <- filter(flights, month %in% c(7, 8, 9)))

# e. Arrived more than two hours late, but didn’t leave late

(e <- filter(flights, dep_delay < 1 & arr_delay > 120))

# f. Were delayed by at least an hour, but made up over 30 minutes in flight  # [test.quest]

(f <- filter(flights, dep_delay > 60 & (dep_delay - arr_delay) >= 30))

# g. Departed between midnight and 6am (inclusive)

(g <- filter(flights, dep_time > 2359 | dep_time <= 0600))


## 2. Another useful dplyr filtering helper is between(). 
##    What does it do? 

?between

## Can you use it to simplify the code needed to answer the previous challenges?

(g2 <- filter(flights, !between(dep_time, 0601, 2359)))


## 3. How many flights have a missing dep_time? 

(h <- filter(flights, is.na(dep_time)))
nrow(h)

##    What other variables are missing? What might these rows represent?
##    All arrival data. Cancelled flights?
  
## 4. Why is NA ^ 0 not missing?

NA ^ 0

##    Why is NA | TRUE not missing? 

NA | TRUE

##    Why is FALSE & NA not missing? 

FALSE & NA 

##    Can you figure out the general rule? (NA * 0 is a tricky counterexample!)

NA * 0

## +++ here now +++ ------ 


## Appendix: Additional resources on dplyr: ------

## Books: 

# 1. ggplot2 book by Hadley Wickham:  
#    ggplot2: Elegant Graphics for Data Analysis (Use R!) 2nd ed. 2016 Edition 
#    https://amzn.com/331924275X. 

# 2. R Graphics Cookbook by Winston Chang: 
#    Parts are available at http://www.cookbook-r.com/Graphs/ 

# 3. Graphical Data Analysis with R, by Antony Unwin
#    https://www.amazon.com/dp/1498715230/ref=cm_sw_su_dp 


## Others:

# - See ggplot2 cheatsheet at https://www.rstudio.com/resources/cheatsheets/

# - ggplot2 extensions: https://www.ggplot2-exts.org
#   Notable extenstions include: cowplot, ggmosaic. 


## ------
## eof.