## r4ds: Chapter 13: Relational data
## Code for http://r4ds.had.co.nz/relational-data.html
## hn spds uni.kn
## 2018 06 05 ------

## [see Book chapter 10: "Relational data with dplyr"] 

## Note: dplyr implements a grammar of data transformation.
##       This chapter concerns transformations involving multiple tables
##       that are linked by keys that define relations.


## 13.1 Introduction ------

# Most real-world data analyses involve more than a single table of data. 

# Typically you have many tables of data, and you must combine them 
# to answer the questions that you’re interested in. 

# Collectively, multiple tables of data are called "relational data" because it is 
# the relations between tables, not just the individual datasets, that are important.

# _Relations_ are always defined between a pair of tables. 
# All other relations are built up from this simple idea: 
# the relations of three or more tables are always a property of the relations between each pair. 

# Sometimes both elements of a pair can be the same table! 
# This is needed if, for example, you have a table of people, and 
# each person has a reference to their parents (in the same table).

# To work with relational data you need verbs that work with pairs of tables. 

# In which ways can we combine information from 2 or more tables?

# There are 3 families of verbs designed to work with relational data:
  
# 1. Mutating joins:
#    Add new variables to a table from matching observations in another table.

# 2. Filtering joins:
#    Filter observations from one table based on whether or not 
#    they match an observation in another table.

# 3. Set operations:
#    Combine or distinguish observations from tables as if they were set elements.

# The most common place to find relational data is in a 
# relational database management system (or RDBMS), 
# a term that encompasses almost all modern databases. 

# If you’ve used a database before, you’ve almost certainly used SQL. 
# If so, you should find the concepts in this chapter familiar, 
# although their expression in dplyr is a little different. 

# Generally, dplyr is a little easier to use than SQL because 
# dplyr is specialised to do data analysis: 
# It makes common data analysis operations easier, 
# at the expense of making it more difficult to do other things 
# that aren’t commonly needed for data analysis.

# We explore relational data from nycflights13 using the 2-table verbs from dplyr:

library(tidyverse) # includes: library(dplyr)
library(nycflights13)

## 13.2 nycflights13 ------

# Example of relational data:
# nycflights13 contains 4 tibbles that are related to the 
# flights table that we used in Chapter 5: data transformation:

?nycflights13::flights

## Data:                # Description: 
nycflights13::flights   # all 336,776 flights departing from NYC in 2013
nycflights13::airlines  # links carrier codes to airline names
nycflights13::airports  # links faa codes to aiport name, location, and timezone
nycflights13::planes    # links tailnum to plane info (year, make, model, seats, engine)
nycflights13::weather   # links origin and time to weather info

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
  # - Plot all 12 months in 1 plot: 
  
  library(RColorBrewer)
  # display.brewer.all()
  
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

# nycflights13::weather

# => "origin" in weather corresponds to "faa" in airports

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

# - Definition: "Keys" are variables used to connect each pair of tables. 
#   A "key" is a variable (or set of variables) that uniquely identifies an observation. 

# - In simple cases, a single variable is sufficient to identify an observation. 
#   For example, each plane is uniquely identified by its "tailnum". 

# - In other cases, multiple variables may be needed to identify an observation. 
#   For example, to identify an observation in weather 
#   you need 5 variables: year, month, day, hour, and origin (i.e., date, time, and location).

# There are 2 types of keys, that are defined by their _perspective_:
  
# 1. A "primary key" uniquely identifies an observation in its _own_ table. 
#    For example, planes$tailnum is a primary key because 
#    it uniquely identifies each plane in the planes table.

# 2. A "foreign key" uniquely identifies an observation in _another_ table. 
#    For example, the flights$tailnum is a foreign key 
#    because it appears in the flights table where it matches each flight to a unique plane.

# A variable in a table can be _both_ a primary key and a foreign key. 
# For example, "origin" is part of the weather primary key, 
# and is also a foreign key for the airport table.

# Once you’ve identified the primary keys in your tables, 
# it’s good practice to verify that they do indeed 
# uniquely identify each observation. 

# One way to do this is to count() the (set of all) primary keys 
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

# => The table of flights lacks a primary key.

## Defining "surrogate key" and "relation": ---- 

# If a table lacks a primary key, it’s sometimes useful 
# to add a "surrogate key" with mutate() and row_number(). 
# That makes it easier to match observations after some filtering 
# and checking back in with the original data. 
# Adding a unique primary key is called a "surrogate key".

# A "primary key" and the corresponding "foreign key" in another table 
# form a "relation". 


## Types of relations (4): ----

# A _relation_ consists between 2 keys (primary in the current table, foreign in another): 

# 4 types of relations: 

# Relations are typically 1-to-many (a). 
# For example, each flight has one plane, but each plane is used for many flights. 

# In other data, you’ll occasionally see a 1-to-1 relationship (b). 
# You can think of this as a special case of 1-to-many. 

# You can model many-to-many relations (c) with 
# a many-to-1 relation (d) plus a 1-to-many relation (a). 
# For example, in this data there’s a many-to-many relationship between airlines and airports: 
# Each airline flies to many airports; each airport hosts many airlines.


## 13.3.1 Exercises -----

# 1. Add a surrogate key to flights.

f2 <- flights %>%
  mutate(flight_id = row_number()) %>%
  select(flight_id, everything())

glimpse(f2)

# Verify that flight_nr is a primary key
# (i.e., uniquely specifies each observation in flights):

f2 %>%
  count(flight_id) %>%
  filter(n > 1)

# => 0 rows (q.e.d., for a primary key). 
 

# 2. Identify the keys in the following datasets: 

# a. Lahman::Batting
# b. babynames::babynames
# c. nasaweather::atmos
# d. fueleconomy::vehicles
# e. ggplot2::diamonds

# (You might need to install some packages and read some documentation.)

## ad a: 
Lahman::Batting

Lahman::Batting %>%
  count(playerID, yearID, stint) %>%  # primary key?
  filter(n > 1)

## ad b:

# install.packages('babynames') # if not installed yet.
library('babynames')

# ?babynames
bn <- as_tibble(babynames)
bn

# Note: "n" is a variable name in bn. 
# Hence, count creates a new variable "nn".

bn %>% 
  count(year, sex, name) %>%  # primary key?
  filter(nn > 1)
# => 0 rows (q.e.d., for a primary key)

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
  
  bn %>%
    filter(name %in% c("Henny"), sex == "F") %>%
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

## ad c: nasaweather::atmos

# yet ToDo.

## ad d: fueleconomy::vehicles

# install.packages('fueleconomy')
# library('fueleconomy')

# yet ToDo.

## ad e: ggplot2::diamonds
dm <- ggplot2::diamonds
dm # does not seem to have a primary key.

# Confirmation: Count combination of all variables:
dm %>%
  count(carat, cut, color, clarity, depth, price, x, y, z) %>%
  filter(n > 1)

# Note: Some observations appear more than twice:
dm %>%
  count(carat, cut, color, clarity, depth, price, x, y, z) %>%
  filter(n > 2)

# Create a surrogate key:
dm2 <- dm %>%
  mutate(dm_id = row_number()) %>%
  select(dm_id, everything())
dm2

# Verify that key uniquely identifies each observation:
dm2 %>%
  count(dm_id) %>%
  filter(n > 1)
# => 0 rows (q.e.d., for a primary key)

## Another argument:
nrow(dm)

dm %>%
  distinct() %>% 
  nrow()

# => There are some duplicates in dm.

# Using _all_ variables in the data frame, 
# the number of _distinct_ rows is less than the total number of rows, 
# this implies that _no_ combination of variables uniquely identifies the observations.

# 3. Draw a diagram illustrating the connections between the 
#    Batting, Master, and Salaries tables in the Lahman package. 
#    Draw another diagram that shows the relationship between Master, Managers, AwardsManagers.

# See 
# https://jrnold.github.io/r4ds-exercise-solutions/relational-data.html#exercise-4-15
# for a solution that uses the datamodelr package.

## See packages: 
# https://github.com/bergant/datamodelr 
# http://rich-iannone.github.io/DiagrammeR/ 


# 4. How would you characterise the relationship between the 
#    Batting, Pitching, and Fielding tables?

# The Batting, Pitching, and Fielding tables all have a primary key 
# consisting of the playerID, yearID, and stint variables. 
# They all have a 1-1 relationship to each other.



## 13.4 Mutating joins ------

# The first tool to combine a pair of tables is the mutating join. 

# Definition: A _mutating join_ allows you to combine variables from 2 tables. 
# It first matches observations by their keys, then copies across variables 
# from one table to the other. 

# Like mutate(), the join functions add variables to the right, 
# so if you have a lot of variables already, the new variables won’t get printed out. 

# For these examples, we’ll make it easier to see what’s going on in the examples 
# by creating a narrower dataset:

# flights

flights2 <- flights %>% 
  select(year:day, hour, origin, dest, tailnum, carrier)

flights2

# Imagine we want to add the full airline name to the flights2 data.
# We get this name from the name column in the following table: 
airlines

# You can combine the airlines and flights2 data frames with left_join():
flights2 %>%
  select(-origin, -dest) %>% 
  left_join(airlines, by = "carrier")

# The result of joining airlines to flights2 is an additional variable: 
# "name". 
# This why we call this type of join a "mutating join". 

# In this simple case, we could get the same result 
# using mutate() and R’s base subsetting:
  
flights2 %>%
  select(-origin, -dest) %>% 
  mutate(name = airlines$name[match(carrier, airlines$carrier)])

# But this is hard to generalise when you need to match multiple variables, 
# and takes close reading to figure out the overall intent.

## Transition: 

# The following sections explain, in detail, how mutating joins work. 
# You’ll start by learning a useful visual representation of joins. 
# We’ll then use that to explain the 4 mutating join functions: 
# 1 inner join, and 3 outer joins. 

# When working with real data, keys don’t always uniquely identify observations, 
# so next we’ll talk about what happens when there isn’t a unique match. 

# Finally, we’ll learn how to tell dplyr which variables are the keys for a given join.

## 13.4.1 Understanding joins -----

# To learn how joins work, we use a visual representation:
# See diagram of 2 tables, with colored key variables, at 
# http://r4ds.had.co.nz/relational-data.html#understanding-joins 

x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  3, "x3")
x

y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  4, "y3")
y

# Distinguish:
# (a) key variables: used to match tables 
# (b) value variables: carried along

# A "join" is a way of connecting each row in a table x to zero, one, or more rows in table y, 
# based on the match or mismatch of the specified key variables. 

# (Note the diagram to view potential matches as an intersection of a pair of lines.)

## 13.4.2 Inner join -----

# The simplest type of join is the inner join. 

# An "inner join" matches pairs of observations whenever their keys are equal:

x %>% 
  inner_join(., y, by = "key")

# OR (in 1 command): 
inner_join(x, y, by = "key")

# See diagram at http://r4ds.had.co.nz/relational-data.html#inner-join 

# The most important property of an inner join is that 
# unmatched rows are not included in the result. 

# This means that generally inner joins are usually NOT appropriate 
# for use in analysis because it’s too easy to lose observations.

# (To be precise, this is an _inner equijoin_ because the keys are matched 
#  using the equality operator. Since most joins are equijoins 
#  we usually drop that specification.) 

# [test.quest]: Is inner_join symmetrical?

inner_join(x, y, by = "key")
inner_join(y, x, by = "key")

# => Yes, as far as the observations (rows) preserved are concerned,
#    No, as far as the order of variables (columns) is concerned.


## 13.4.3 3 Outer joins -----

# An inner join keeps observations that appear in _both_ tables 
#               (and drops others from both tables). 
# An outer join keeps observations that appear in _at least one_ of the tables. 

# There are 3 types of outer joins:
  
# 1. A _left_  join keeps all observations in x.
# 2. A _right_ join keeps all observations in y.
# 3. A _full_  join keeps all observations in x and y.

# These joins work by adding an additional “virtual” observation to each table. 
# This observation has a key that always matches (if no other key matches), 
# and a value filled with NA.

# Graphically, that looks like: 
# see Diagram at http://r4ds.had.co.nz/relational-data.html#outer-join 

# Computationally:

x %>% 
  left_join(y, by = "key")

x %>% 
  right_join(y, by = "key")

x %>% 
  full_join(y, by = "key")

# The most commonly used join is the left join: 
# Use left_join whenever you look up additional data from another table, 
# because it preserves all original observations even when there is no match. 

# The left join should be your default join: 
# use it unless you have a strong reason to prefer one of the others.
# [test.quest]

## [test.quest]: Symmetry of full_join():
# Symmetry (in the sense of same observations, irrespective of order of columns):
# - left_join and right_join are clearly asymmetrical, but vary the order of tables.
# - full_join is symmetrical (but order determines the order of variables)

full_join(x, y, by = "key")
full_join(y, x, by = "key")

# => Same set of observations (rows), but different order of observations and variables (columns).

## [test.quest]: left_join(x, y) vs. right_join(y, x): 
## What is the relationship between left_join(x, y) and right_join(y, x):

# (a) toy data:
x
y

left_join(x, y, by = "key")
right_join(y, x, by = "key")

# => Same set of observations (rows), but different variable order (columns).

# However:
left_join(x, y, by = "key")  # yields a DIFFERENT result than 
right_join(x, y, by = "key") # !!!


# (b) flights data:
flights3 <- flights2 %>%
  select(-origin, -dest)

left_join(flights3,  airlines, by = "carrier")
right_join(airlines, flights3, by = "carrier")

# => Same set of observations (rows), but 2 different variable orders (columns).


## 13.4.4 Duplicate keys -----

# So far all the diagrams have assumed that the keys are unique. 
# But that’s not always the case. 
# This section explains what happens when the keys are not unique. 

# There are 2 possibilities:
  
# 1. One table has duplicate keys. 
#    This is useful when you want to add in additional information 
#    as there is typically a one-to-many relationship:

x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  2, "x3",
  1, "x4")
x

y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2")
y

left_join(x, y, by = "key")

# Note that I’ve put the key column in a slightly different position in the output. 
# This reflects that the key is a _primary_ key in y and a _foreign_ key in x.

# 2. Both tables have duplicate keys. 
#    This is usually an error because in neither table do the keys 
#    uniquely identify an observation. 

# When you join duplicated keys, you get all possible combinations, 
# the Cartesian product:

x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  2, "x3",
  3, "x4")

y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  2, "y3",
  3, "y4")

left_join(x, y, by = "key")


## 13.4.5 Defining the key columns -----

# So far, the pairs of tables have always been joined by a single variable, 
# and that variable has the same name in both tables. 

# That constraint was encoded by specifying  
# by = "key". 

# You can use other values for by to connect the tables in other ways:
  
# 1. The default, by = NULL, uses all variables that appear in both tables, 
#    the so-called _natural join_. 

# For example, the flights and weather tables match on their common variables: 
# year, month, day, hour and origin.

flights2 %>% left_join(weather)

left_join(flights2, weather)

# 2. A character vector, by = "x". 
# This is like a natural join, but uses only some of the common variables. 

# For example, flights and planes have "year" variables, 
# but they mean different things so we only want to join by "tailnum": 

flights
planes

flights2 %>% 
  left_join(planes, by = "tailnum")

left_join(flights2, planes, by = "tailnum")

# Note that the year variables (which appear in both input data frames, 
# but are not constrained to be equal) are disambiguated in the output with a suffix.


# [test.quest]: What happens if a natural join is attempted?

test <- left_join(flights2, planes) # ==> most plane values are NA.

test %>% 
  filter(!is.na(type)) %>%
  group_by(carrier, type, manufacturer, tailnum) %>%
  count() %>%
  arrange(desc(n))

# 3. A named character vector: by = c("a" = "b"). 
#    This will match variable a in table x to variable b in table y. 
#    The variables from x will be used in the output.

# For example, if we want to draw a map we need to combine the flights data 
# with the airports data which contains the location (lat and long) of each airport.
# Each flight has an origin and destination airport, so we need to specify which
# one we want to join to:

flights2 %>% 
  left_join(airports, c("dest" = "faa"))

flights2 %>% 
  left_join(airports, c("origin" = "faa"))

# Actually, we would want both:

flights2 %>% 
  left_join(airports, c("origin" = "faa")) %>%
  left_join(airports, c("dest" = "faa"))
  

## 13.4.6 Exercises -----

# 1. Compute the average delay by destination, 
#    then join on the airports data frame so you can show 
#    the spatial distribution of delays. 

# Here’s an easy way to draw a map of the United States:
  
airports %>%
  semi_join(flights, c("faa" = "dest")) %>%
  ggplot(aes(lon, lat)) +
  borders("state") +
  geom_point() +
  coord_quickmap()

# (Don’t worry if you don’t understand what semi_join() does 
# — we’ll learn about it next.)

# You might want to use the size or colour of the points to display the average
# delay for each airport.

?flights

flights <- flights %>%
  select(year:dep_time, carrier, flight, origin, dest, dep_delay, arr_delay)

delays <- flights %>%
  group_by(dest) %>%
  summarise(n = n(),
            n_not_NA = sum(!is.na(dep_delay)),
            mn_dep_del = mean(dep_delay, na.rm = TRUE), 
            mn_arr_del = mean(arr_delay, na.rm = TRUE)) %>%
  arrange(desc(mn_arr_del))

delay_airports <- delays %>% 
  left_join(airports, by = c("dest" = "faa"))
# delay_airports

delay_airports %>%
  # semi_join(flights, c("dest" = "dest")) %>%
  ggplot(aes(lon, lat, size = mn_arr_del, color = mn_arr_del)) +
  borders("state") +
  geom_point() +
  coord_quickmap() + 
  theme_light()
            

# 2. Add the location of the origin and destination (i.e., the lat and lon) to flights.

flights2 %>%
  left_join(airports, by = c("origin" = "faa")) %>%
  left_join(airports, by = c("dest" = "faa")) 

# 3. Is there a relationship between the age of a plane and its delays?

planeage <- planes %>%
  mutate(age = 2013 - year) %>%
  select(tailnum, age)

delay_age <- flights %>% 
  left_join(planeage, by = "tailnum") %>%
  group_by(age) %>%
  summarise(n = n(),
            n_non_NA = sum(!is.na(dep_delay)),
            mn_dep_del = mean(dep_delay, na.rm = TRUE),
            mn_arr_del = mean(arr_delay, na.rm = TRUE))

# filter(n_non_NA > 100) %>%

ggplot(delay_age, aes(x = age, y = mn_dep_del)) +
   geom_point(aes(size = n_non_NA), color = "steelblue4") + 
   geom_line(color = "steelblue4") +
   labs(title = "Mean departure delay by age of plane",
        x = "Age of plane (in years)", 
        y = "Mean departure delay (in min)") + 
   theme_bw()

ggplot(delay_age, aes(x = age, y = mn_arr_del)) +
  geom_point(aes(size = n_non_NA), color = "forestgreen") + 
  geom_line(color = "forestgreen") +
  labs(title = "Mean departure delay by age of plane",
       x = "Age of plane (in years)", 
       y = "Mean arrival delay (in min)") + 
  theme_bw()

# Interpretation: 
# There appears no linear relationship between age of plane and departure or
# arrival delay (for the first 30 years, for which there seems sufficient data).
# If anything, the relationship seems curvilinear, with maximum delays around 10
# years of age and decreasing for older planes.


# 4. What weather conditions make it more likely to see a delay?

?weather
weather

# Note that weather data is by location ("origin") and 
# "hour" (as integer), which corresponds to  
# "hour" in flights (but dbl).

fw <- flights %>%
  left_join(weather, by = c("origin" = "origin",
                            "year" = "year",
                            "month" = "month",
                            "day" = "day",
                            "hour" = "hour"))
fw

# => Candidate variables for causing delays are 
#    temp, wind_speed, wind_gust, precip, visib

#    As they are all continuous, we will use 
#    cut_interval (cut_width or cut_number) to discretise them.

## (a) dep_delay by "temp":

## raw values:
# ggplot(fw, aes(x = cut_width(temp, 10), y = dep_delay)) +
#  geom_jitter(alpha = 1/4)

## means: 
fw %>% 
  group_by(temp) %>%
  summarise(n = n(),
            not_NA = sum(!is.na(dep_delay)), 
            mn_dep_del = mean(dep_delay, na.rm = TRUE)) %>%
  filter(not_NA >= 100) %>%
  ggplot(aes(x = temp, y = mn_dep_del)) +
  geom_point() +
  geom_smooth() + 
  theme_bw()


## (b) dep_delay by "wind_speed":
  
## raw values:
ggplot(fw, aes(x = cut_width(wind_speed, 5), y = dep_delay)) +
  geom_jitter(alpha = 1/4)

## means: 
fw %>% 
  group_by(wind_speed) %>%
  summarise(n = n(),
            not_NA = sum(!is.na(dep_delay)), 
            mn_dep_del = mean(dep_delay, na.rm = TRUE)) %>%
  filter(not_NA >= 50) %>%
  ggplot(aes(x = wind_speed, y = mn_dep_del)) +
  geom_point() +
  geom_smooth() + 
  theme_bw()

## (c) dep_delay by "precip":

## means: 
fw %>% 
  group_by(precip) %>%
  summarise(n = n(),
            not_NA = sum(!is.na(dep_delay)), 
            mn_dep_del = mean(dep_delay, na.rm = TRUE)) %>%
  filter(not_NA >= 50) %>%
  ggplot(aes(x = precip, y = mn_dep_del)) +
  geom_point() +
  geom_smooth() + 
  theme_bw()


# 5. What happened on June 13 2013? 
#    Display the spatial pattern of delays, and then 
#    use Google to cross-reference with the weather.


## 13.4.7 Other implementations -----

## (1) merge from base R:

# base::merge() can perform all four types of mutating join:
  
#     `dplyr`:     |      `merge`:
# -----------------|------------------------|  
# inner_join(x, y) |	merge(x, y)
# left_join(x, y)  |	merge(x, y, all.x = TRUE)
# right_join(x, y) |	merge(x, y, all.y = TRUE),
# full_join(x, y)  |	merge(x, y, all.x = TRUE, all.y = TRUE)

?merge # to show documentation

# The advantages of the specific dplyr verbs are:

# 1. they more clearly convey the intent of your code: 
#    the difference between the joins is really important 
#    but concealed in the arguments of merge(). 

# 2. dplyr’s joins are considerably faster and 
#    don’t mess with the order of the rows.

## (2) SQL:

# SQL is the inspiration for dplyr’s conventions, so the translation is straightforward:
  
#      dplyr: 	             |               SQL:
# ---------------------------| ------------------------------------------       
# inner_join(x, y, by = "z") | SELECT * FROM x INNER JOIN y USING (z)
# left_join(x, y, by = "z")  | SELECT * FROM x LEFT OUTER JOIN y USING (z)
# right_join(x, y, by = "z") | SELECT * FROM x RIGHT OUTER JOIN y USING (z)
# full_join(x, y, by = "z")  | SELECT * FROM x FULL OUTER JOIN y USING (z)

# Note that “INNER” and “OUTER” are optional, and often omitted.

# Joining different variables between the tables, 
# e.g. inner_join(x, y, by = c("a" = "b")) uses a slightly different syntax in SQL: 
#      SELECT * FROM x INNER JOIN y ON x.a = y.b. 

# As this syntax suggests, SQL supports a wider range of join types than dplyr 
# because you can connect the tables using constraints other than equality 
# (sometimes called non-equijoins).



## 13.5 Filtering joins ------

# Filtering joins match observations in the same way as mutating joins, 
# but affect the observations, not the variables. 

# There are 2 types:
  
# 1. semi_join(x, y) keeps all observations in x that have a match in y.
# 2. anti_join(x, y) drops all observations in x that have a match in y.

# ad 1.: semi_join: -----

# Semi-joins are useful for matching filtered summary tables back to the original rows. 
# For example, imagine you’ve found the top ten most popular destinations:

top_dest <- flights %>%
  count(dest, sort = TRUE) %>%
  head(10)

top_dest

# Now you want to find each flight that went to one of those destinations. 
# (a) You could construct a filter yourself:
  
flights %>% 
  filter(dest %in% top_dest$dest)

# However, it’s difficult to extend that approach to multiple variables. 
# For example, imagine that you’d found the 10 days with highest average delays. 
# How would you construct the filter statement that used the variables 
# "year", "month", and "day" to match it back to flights?
  
# Instead you can use a semi-join, which connects the 2 tables like a mutating join, 
# but instead of adding new columns, only keeps the rows in x that have a match in y:

flights %>% 
  semi_join(top_dest)

# Note that columns of y are dropped! 

# For a diagram that graphically shows a semi_join, see
# http://r4ds.had.co.nz/relational-data.html#filtering-joins 

# - Only the existence of a match is important; 
#   it doesn’t matter which observation is matched. 

# - This implies that filtering joins never duplicate rows like mutating joins do. 


# ad 2.: anti_join: -----

# - An anti-join is the inverse of a semi-join. 
#   Note & [test.quest] MC: The inverse of semi_join is NOT full_join!

# An anti-join keeps the rows that don’t have a match:

# Use: 
# Anti-joins are useful for diagnosing join mismatches. 

# For example, when connecting flights and planes, 
# you might be interested to know that there are many flights 
# that don’t have a match in planes:

flights %>%
  anti_join(planes, by = "tailnum") %>%
  count(tailnum, sort = TRUE)

# [test.quest]:
# Do semi_join and anti_join add up to all cases?

f_semi <- flights %>%
  semi_join(planes, by = "tailnum")

f_anti <- flights %>%
  anti_join(planes, by = "tailnum")

nrow(f_semi) + nrow(f_anti) == nrow(flights) # ==> TRUE (q.e.d.).


## 13.5.1 Exercises -----

# 1. What does it mean for a flight to have a missing tailnum? 
#    What do the tail numbers that don’t have a matching record in planes have in common? 
#    (Hint: one variable explains ~90% of the problems.)

missing_tailnumber <- flights %>%
  anti_join(planes, by = "tailnum")

missing_tailnumber %>%
  count(carrier, sort = TRUE) %>%
  left_join(airlines, by = "carrier")


# 2. Filter flights to only show flights with planes 
#    that have flown at least 100 flights.

freq_planes <- flights %>%
  #group_by(tailnum) %>%
  count(tailnum, sort = TRUE) %>%
  filter(n >= 100 & !is.na(tailnum))
freq_planes

flights %>%
  semi_join(freq_planes, by = "tailnum")


# 3. Combine fueleconomy::vehicles and fueleconomy::common to find 
#    only the records for the most common models.

library(fueleconomy)

vehicles
common

vehicles %>%
  semi_join(common, by = c("make", "model"))

# => 14,531 vehicles left.


# 4. Find the 48 hours (over the course of the whole year) that have the worst delays. 
#    Cross-reference it with the weather data. Can you see any patterns?

# yet ToDo.

# 5. What does anti_join(flights, airports, by = c("dest" = "faa")) tell you?
#    What does anti_join(airports, flights, by = c("faa" = "dest")) tell you?

anti_join(flights, airports, by = c("dest" = "faa"))

# yields 7,592 flights with destinations that are not listed in airports:

anti_join(airports, flights, by = c("faa" = "dest"))

# yields 1,357 airports to which there are no flights (from NYC in 2013).


# 6. You might expect that there’s an implicit relationship between plane and airline, 
#    because each plane is flown by a single airline. 
#    Confirm or reject this hypothesis using the tools you’ve learned above.

# yet ToDo.



## 13.6 Join problems ------

# The data in this chapter has been cleaned up so that 
# we encounter as few problems as possible. 

# Real data is unlikely to be so nice, so here are a few things 
# that we should do to make our joins go smoothly:

## 1. Identify primary keys:

# Start by identifying the variables that form the primary key in each table. 

# We should usually do this based on our understanding of the data, 
# not empirically by looking for a combination of variables that give 
# a unique identifier. 

# If we only look for variables without thinking about what they mean, 
# we might get (un)lucky and find a combination that’s unique in 
# our current data but the relationship might not be true in general.

# For example, the altitude and longitude uniquely identify each airport, 
# but they are not good identifiers:

airports %>% 
  count(alt, lon) %>% 
  filter(n > 1)

## 2. Missing key values:

#    Check that none of the variables in the primary key are missing. 
#    If a value is missing then it can’t identify an observation!
  
## 3. Foreign keys:

#    Check that your foreign keys match primary keys in another table. 
#    The best way to do this is with an anti_join(). 
#    It’s common for keys not to match because of data entry errors. 
#    Fixing these is often a lot of work.

# If you do have missing keys, you need to be thoughtful about your use of
# inner vs. outer joins, carefully considering whether or not you want to drop
# rows that lack a match.

# Be aware that simply checking the number of rows before and after the join is
# not sufficient to ensure that your join has gone smoothly.  
# If you have an inner join with duplicate keys in both tables, 
# you might get unlucky as the number of dropped rows might exactly 
# equal the number of duplicated rows. 



## 13.7 Set operations (3) ------

# The 3rd and final type of two-table verb are the set operations
# (after mutating joins and filter joins). 

# Generally, we use these the least frequently, 
# but they are occasionally useful when we want to break 
# a single complex filter into simpler pieces. 

# All these operations work with a complete row, 
# comparing the values of every variable. 

# These expect the x and y inputs to have the same variables, 
# and treat the observations like sets:
  
# 1. intersect(x, y): return only observations in both x and y.
# 2. union(x, y):     return all unique observations in x and/or y.
# 3. setdiff(x, y):   return observations in x, but not in y.

# Note: 
# a) Symmetry: 1. and 2. are symmetrical, 3. is asymmetrical. [test.quest]
# b) Duplicates: What happens with duplicates?

## Examples:

# Given this simple data:
  
df1 <- tribble(
    ~x, ~y,
    1,  1,
    2,  1
  )

df2 <- tribble(
  ~x, ~y,
  1,  1,
  1,  2
)

# The 4 possibilities are:

                     # Notes:
intersect(df1, df2)  # b) duplicate is removed!
intersect(df2, df1)  # a) symmetrical

union(df1, df2)      # b) duplicate is removed!
union(df2, df1)      # b) symmetrical (but different order of rows)

setdiff(df1, df2)    # b) not symmetrical: order matters!
setdiff(df2, df1)



## Appendix ------

# See 

## Documentation: 

# dplyr: Two-table verbs vignette: [dplyr::two-table]()	
# - vignette("two-table", package = "dplyr")
# - https://cran.r-project.org/web/packages/dplyr/vignettes/two-table.html


## R packages: 
# https://github.com/bergant/datamodelr 

## Web: 

# - http://www.rpubs.com/williamsurles/293454

# - Data Wrangling Cheatsheet: https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf 



## +++ here now +++ ------

## Ideas for test questions [test.quest]: ------

## Multiple choice [MC] questions: -----

# (+) Which of the following join types are _symmetrical_ (in the sense of yielding 
#     the same set of observations for join(x, y) and join(y, x), 
#     but may vary in the order of variables (columns)):

# - inner_join(x, y) (TRUE)
# - left_join(x, y)
# - right_join(x, y)
# - full_join(x, y)  (TRUE)
# - semi_join(x, y)
# - anti_join(x, y)
# - intersect(x, y)  (TRUE)
# - union(x, y)      (TRUE)
# - setdiff(x, y)


# (+) Which of the following join types is the default and most commonly used one, 
#     as it preserves original observations in x even when there is no match with y?

# - `full_join(x, y)`
# - `inner_join(x, y)` 
# - `semi_join(x, y)` 
# - `left_join(x, y)` (TRUE)
# - `right_join(x, y)`


# (+) Which of the following yields the same result (i.e., the same set of obervations) 
#     as left_join(x, y)?

# - anti_join(x, y)
# - anti_join(y, x)
# - semi_join(x, y)
# - semi_join(y, x)
# - right_join(x, y)
# - right_join(y, x)  (TRUE)
# - setdiff(x, y)
# - setdiff(y, x)


# (+) Which of the following is the _inverse_ of an `anti-join`?

# - `full_join`
# - `inner_join` 
# - `semi_join` (TRUE)
# - `left_join`
# - `right_join`


## Practical questions: ----- 

## Utility functions: -----
{
  ## Function to replace a random amount of vector elements by NA values:  
  add_NAs <- function(vec, amount){
    
    stopifnot((is.vector(vec)) & (amount >= 0) & (amount <= length(vec)))
    
    out <- vec
    n <- length(vec)
    
    amount2 <- ifelse(amount < 1, round(n * amount, 0), amount) # turn amount prop into n
    
    out[sample(x = 1:n, size = amount2, replace = FALSE)] <- NA
    
    return(out)
    
  }
  
  ## Check:
  # add_NAs(1:10, 0)
  # add_NAs(1:10, 3)
  # add_NAs(1:10, .5)
  # add_NAs(letters[1:10], 3)
  
  ## Generalization: Replace a random amount of vector elements by what: 
  add_whats <- function(vec, amount, what = NA){
    
    stopifnot((is.vector(vec)) & (amount >= 0) & (amount <= length(vec)))
    
    out <- vec
    n <- length(vec)
    
    amount2 <- ifelse(amount < 1, round(n * amount, 0), amount) # turn amount prop into n
    
    out[sample(x = 1:n, size = amount2, replace = FALSE)] <- what
    
    return(out)
    
  }
  
  ## Check:
  # add_whats(1:10, 3) # default: what = NA
  # add_whats(1:10, 3, what = 99)
  # add_whats(1:10, .5, what = "ABC")
}

## Generate data: ----- 
{
  library(tidyverse)
  n <- 20      # [n]umber of participants
  set.seed(42)  # for replicability
  
  ## Demographics: -----
  
  ## Generate random initials: ----
  r_initials <- function(n) {
    
    stopifnot(is.numeric(n), n > 0) # check conditions
    
    initials <- rep("N.N", n) # initialize output vector
    
    for (i in 1:n) {
      initials[i] <- paste0(paste(sample(LETTERS, 1), sample(LETTERS, 1), sep = "."), ".")
    }
    return(initials)
  }
  
  ## Check:
  # r_initials(100)
  # length(LETTERS)^2 # => 676 possible sequences
  # length(unique(r_initials(10000))) # => 676 
  initials <- r_initials(n)
  
  ## Sex/gender: 
  sex <- sample(x = c(0, 1), size = n, prob = c(.54, .46), replace = TRUE)
  sex <- factor(sex, labels = c("female", "male"))
  
  ## Likert-scale rating:
  like <- sample(x = 1:7, size = n, prob = c(.03, .08, .23, .28, .19, .12, .07), replace = TRUE)
  like <- add_NAs(like, amount = .05)  # add 5% NA values
  
  ## BNT score:
  bnt <- sample(x = 1:4, size = n, prob = c(.33, .15, .14, .38), replace = TRUE)
  bnt[is.na(like)] <- NA             # when like is NA, make bnt NA as well
  bnt <- add_NAs(bnt, amount = .05)  # add 2% additional NA values
  
  ## Assemble data set at t1:
  data_t1 <- tibble(name = initials,
                    gender = sex, 
                    like = like,
                    bnt = bnt)
  data_t1 <- data_t1[sample(1:nrow(data_t1)), ]  # randomize rows
  data_t1
  
  
  set.seed(33)  # for replicability  
  
  ## Likert-scale rating:
  like <- sample(x = 1:7, size = n, prob = c(.03, .08, .23, .28, .19, .12, .07), replace = TRUE)
  like <- add_NAs(like, amount = .05)  # add 5% NA values
  
  ## BNT score:
  bnt <- sample(x = 1:4, size = n, prob = c(.33, .15, .14, .38), replace = TRUE)
  bnt[is.na(like)] <- NA             # when like is NA, make bnt NA as well
  bnt <- add_NAs(bnt, amount = .04)  # add 2% additional NA values
  
  ## Assemble data set at t1:
  data_t2 <- tibble(name = initials,
                    gender = sex, 
                    like = like,
                    bnt = bnt)
  data_t2 <- data_t2[sample(1:nrow(data_t2)), ]  # randomize rows
}

## Combine both tables: 
data_t1
data_t2

# +++ here now +++

## (none yet)

## ------
## eof.