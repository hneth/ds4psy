## r4ds: Chapter 13: Relational data
## Code for http://r4ds.had.co.nz/relational-data.html
## hn spds uni.kn
## 2018 03 31 ------

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

# ad c: nasaweather::atmos
# ad d: fueleconomy::vehicles

# ad e: ggplot2::diamonds
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

# Definition: A _mutating join_ allows you to combine variables from two tables. 
# It first matches observations by their keys, then copies across variables 
# from one table to the other.

# Like mutate(), the join functions add variables to the right, 
# so if you have a lot of variables already, the new variables won’t get printed out. 

# For these examples, we’ll make it easier to see what’s going on in the examples 
# by creating a narrower dataset:

flights

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

# The result of joining airlines to flights2 is an additional variable: "name". 
# This why we call this type of join a "mutating join". 

# In this case, we could get to the same place using mutate() and R’s base subsetting:
  
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

y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  4, "y3")

# Distinguish:
# a) key variables: used to match tables 
# b) value variables: carried along

# A "join" is a way of connecting each row in x to zero, one, or more rows in y, 
# based on the match or mismatch of the specified key variables. 

# (Note the diagram to view potential matches as an intersection of a pair of lines.)

## 13.4.2 Inner join -----

# The simplest type of join is the inner join. 

# An "inner join" matches pairs of observations whenever their keys are equal:

x %>% 
  inner_join(y, by = "key")

# OR: 
inner_join(x, y, by = "key")

# See diagram at http://r4ds.had.co.nz/relational-data.html#inner-join 

# The most important property of an inner join is that 
# unmatched rows are not included in the result. 

# This means that generally inner joins are usually NOT appropriate 
# for use in analysis because it’s too easy to lose observations.


## 13.4.3 3 Outer joins -----

# An inner join keeps observations that appear in both tables. 
# An outer join keeps observations that appear in at least one of the tables. 

# There are 3 types of outer joins:
  
# 1. A _left join_ keeps all observations in x.
# 2. A _right join_ keeps all observations in y.
# 3. A _full join_ keeps all observations in x and y.

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
# you use this whenever you look up additional data from another table, 
# because it preserves the original observations even when there isn’t a match. 

# The left join should be your default join: 
# use it unless you have a strong reason to prefer one of the others.
# [test.quest]


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

y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2")

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
 
# 2. Add the location of the origin and destination (i.e. the lat and lon) to flights.

# 3. Is there a relationship between the age of a plane and its delays?
   
# 4. What weather conditions make it more likely to see a delay?

# 5. What happened on June 13 2013? 
#    Display the spatial pattern of delays, and then 
#    use Google to cross-reference with the weather.


## +++ here now +++ ------


## 13.5 Filtering joins ------

## 13.6 Join problems ------

## 13.7 Set operations ------

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


## Ideas for test questions [test.quest]: ------

# - Scenario involving family dynasties (e.g., Games of thrones, Lord of the Rings, Harry Potter, Star Wars, ...)

?dplyr::starwars

starwars %>%
  group_by(species) %>%
  count() %>%
  arrange(desc(n))

# What is the name, species, and homeworld of the Star Wars characters
# with the 10 highest BMI values?
# Note: BMI := weight (in kg) / ((height (in cm) / 100)  ^ 2

starwars %>% 
  mutate(bmi = mass / ((height / 100)  ^ 2)) %>%
  # select(name:mass, bmi) %>%
  select(name, species, homeworld, bmi, films, everything()) %>% 
  arrange(desc(bmi))

# - Scenario involving patients/doctors/insurances/pharma ... 


## ------
## eof.