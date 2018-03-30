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
# a: What variables would you need? 
# b: What tables would you need to combine?

# ad a:
# - tailnum from flights
# - lat/lon from airports (origin/dest in flights correspond to faa)

# ad b:
# flights and airports

# We would merge flights with airports twice: 
# once to get the location of the origin airport, and 
# once to get the location of the dest airport.

# 2. I forgot to draw the relationship between weather and airports. 
#    What is the relationship and how should it appear in the diagram?

nycflights13::weather

# "origin" in weather corresponds to "faa" in airports

# 3. weather only contains information for the origin (NYC) airports. 
# If it contained weather records for all airports in the USA, 
# what additional relation would it define with flights?
   
nycflights13::flights$dest # "dest" could be linked to some faa code in weather

# 4. We know that some days of the year are “special”, 
#    and fewer people than usual fly on them. 
#    How might you represent that data as a data frame? 
#    What would be the primary keys of that table? 
#    How would it connect to the existing tables?
   
# Create a df of holidays and weekdays.
# e.g., a table of 365 rows (1 per day) 
# Key variables: month, day, weekday, holiday (logical), and name of holiday.
# Connect via date: month & day.


## 13.3 Keys ------

## (A) Defining "key": primary vs. foreign ----

# - "Keys" are variables used to connect each pair of tables. 
#   A "key" is a variable (or set of variables) that uniquely identifies an observation. 

# - In simple cases, a single variable is sufficient to identify an observation. 
#   For example, each plane is uniquely identified by its tailnum. 

# - In other cases, multiple variables may be needed to identify an observation. 
#   For example, to identify an observation in weather 
#   you need 5 variables: year, month, day, hour, and origin (i.e., date, time, and location).

# There are 2 types of keys:
  
# 1. A "primary key" uniquely identifies an observation in its _own_ table. 
#    For example, planes$tailnum is a primary key because 
#    it uniquely identifies each plane in the planes table.

# 2. A "foreign key" uniquely identifies an observation in _another_ table. 
#    For example, the flights$tailnum is a foreign key 
#    because it appears in the flights table where it matches each flight to a unique plane.

# A variable in a table can be both a primary key and a foreign key. 
# For example, "origin" is part of the weather primary key, 
# and is also a foreign key for the airport table.

# Once you’ve identified the primary keys in your tables, 
# it’s good practice to verify that they do indeed 
# uniquely identify each observation. 

# One way to do that is to count() the primary keys 
# and look for entries where n is greater than 1:

planes %>% 
  count(tailnum) %>% 
  filter(n > 1)

# => 0 rows (q.e.d., for a primary key)

weather %>% 
  count(year, month, day, hour, origin) %>% 
  filter(n > 1)

# => 0 rows (q.e.d., for a primary key)

# Sometimes a table doesn’t have an explicit primary key: 
# each row is an observation, but no combination of variables 
# reliably identifies it. 

# For example, what’s the primary key in the flights table? 
# You might think it would be the date plus the flight or tail number, 
# but neither of those are unique:

flights %>%
  count(year, month, day, flight) %>%
  filter(n > 1)

# => lots of duplicates (29,768)

flights %>%
  count(year, month, day, tailnum) %>%
  filter(n > 1)

# => lots of duplicates (64,928)

flights %>%
  count(year, month, day, flight, tailnum) %>%
  filter(n > 1)

# => still some duplicates (though only 11)

# The table of flights lacks a primary key.

## Defining "surrogate key" and "relation": ---- 

# If a table lacks a primary key, it’s sometimes useful 
# to add a "surrogate key" with mutate() and row_number(). 
# That makes it easier to match observations after some filtering 
# and checking back in with the original data. 
# Adding a unique primary key is called a "surrogate key".

# A "primary key" and the corresponding "foreign key" in another table 
# form a "relation". 

## Types of relations (4): ----

# Relations are typically 1-to-many (a). 
# For example, each flight has one plane, but each plane has many flights. 

# In other data, you’ll occasionally see a 1-to-1 relationship (b). 
# You can think of this as a special case of 1-to-many. 

# You can model many-to-many relations (c) with 
# a many-to-1 relation (d) plus a 1-to-many relation (a). 
# For example, in this data there’s a many-to-many relationship between airlines and airports: 
# Each airline flies to many airports; each airport hosts many airlines.


## 13.3.1 Exercises -----

# 1. Add a surrogate key to flights.

f2 <- flights %>%
  mutate(flight_nr = row_number()) %>%
  select(flight_nr, everything())

# Verify that flight_nr is a primary key
# (i.e., uniquely specifies each observation in flights):

f2 %>%
  count(flight_nr) %>%
  filter(n > 1)

# => 0 rows (q.e.d., for a primary key)
 

# 2. Identify the keys in the following datasets: 

# a. Lahman::Batting
# b. babynames::babynames
# c. nasaweather::atmos
# d. fueleconomy::vehicles
# e. ggplot2::diamonds

# (You might need to install some packages and read some documentation.)

# ad a: 
Lahman::Batting

Lahman::Batting %>%
  count(playerID, yearID, stint) %>%  # primary key?
  filter(n > 1)

# ad b:

# install.packages('babynames')
library('babynames')

?babynames
bn <- as_tibble(babynames)
bn

# Note: "n" is a variable name in bn. 
# Hence, count creates a new variable "nn".

bn %>% 
  count(year, sex, name) %>%  # primary key?
  filter(nn > 1)

# [test.quest]: Explore babynames: 
{
  ## Data used: babynames::babynames
  ## To know: dplyr, ggplot 
  
  ## Data: 
  # install.packages('babynames')
  # library('babynames')
  
  # ?babynames
  bn <- as_tibble(babynames)
  bn
  
  # Determine most popular names:
  bn %>%
    group_by(name, sex) %>%
    summarise(n_cases = n(),
              sum = sum(n)
    ) %>%
    arrange(desc(sum)) %>%
    print(n = 30)
  
  # "Alma":
  bn %>%
    filter(name %in% c("Alma")) %>%
    ggplot(aes(x = year, y = n, color = sex)) +
    geom_line()
  
  # "Ada" vs. "Ava":
  bn %>%
    filter(name %in% c("Ada", "Ava") & sex == "F") %>%
    ggplot(aes(x = year, y = n, color = name)) +
    geom_line()
  
  # Compare "Alma" with "Ada", "Ava", and "Maria":
  bn %>%
    filter(name %in% c("Ada", "Alma", "Ava", "Maria")) %>%
    ggplot(aes(x = year, y = n, color = name)) +
    facet_wrap(~sex) + 
    geom_line()
  
  # Compare "Teresa" with "Theresa":
  bn %>%
    filter(name %in% c("Teresa", "Theresa"), sex == "F") %>%
    ggplot(aes(x = year, y = n, color = name)) +
    geom_line()
  
  # Compare "Hans" with variants: 
  bn %>%
    filter(name %in% c("Hans", "Jack", "John", "James"), sex == "M") %>%
    ggplot(aes(x = year, y = n, color = name)) +
    geom_line()
  
  # Compare "Jetta" with "Ruby":
  bn %>% 
    filter(name %in% c("Jetta", "Ruby"), sex == "F") %>% 
    ggplot(aes(x = year, y = n, color = name)) +
    geom_line()
  
  # Frequency of "Jetta" since 1970:
  bn %>%
    filter(year >= 1970, name %in% c("Jetta")) %>% 
    ggplot(aes(x = year, y = n, color = name)) +
    geom_line()
  
  # This suggest a possible influence of the Volkswagen model 
  # of the same name, manufactured since 1979, 
  # see https://en.wikipedia.org/wiki/Volkswagen_Jetta 
  # however:
  
  bn %>%
    filter(name %in% c("Jetta"), sex == "F") %>% 
    ggplot(aes(x = year, y = n, color = name)) +
    geom_line()
  
  # even more popular in 1920s and 1950s, hence not only source of influence.
  
  }

## +++ here now +++ ------



# 3. Draw a diagram illustrating the connections between the 
#    Batting, Master, and Salaries tables in the Lahman package. 
#    Draw another diagram that shows the relationship between Master, Managers, AwardsManagers.

# 4. How would you characterise the relationship between the 
#    Batting, Pitching, and Fielding tables?



  
  


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