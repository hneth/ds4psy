## r4ds: Chapter 5: Data transformation 
## Code for http://r4ds.had.co.nz/transform.html 
## hn spds uni.kn
## 2018 06 23 ------

## Note: dplyr implements a grammar of data transformation.
##       This chapter concerns transformations involving a single table
##       and 6 verbs for different actions: 
##       - selecting rows (filter) or columns (select)
##       - arranging rows (arrange)
##       - creating new columns/variables (mutate, transmute)
##       - aggregation via grouped summaries (group_by and summarise)



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

# A tibble: Tibbles are data frames, 
# but slightly tweaked to work better in the tidyverse. 

# Note row of three (or four) letter abbreviations under the column names. 
# These describe the type of each variable:
  
# - int stands for integers.
# - dbl stands for doubles, or real numbers.
# - chr stands for character vectors, or strings.
# - dttm stands for date-times (a date + a time).

# There are 3 other common types of variables that aren’t used in this dataset:
  
# - lgl stands for logical, vectors that contain only TRUE or FALSE.
# - fctr stands for factors, which R uses to represent categorical variables with fixed possible values.
# - date stands for dates. 


## 5.1.3 dplyr basics ------

# In this chapter you are going to learn the five key dplyr functions that allow you 
# to solve the vast majority of your data manipulation challenges:
  
# 1. Pick observations by their values (filter()).
# 2. Reorder the rows (arrange()).
# 3. Pick variables by their names (select()).
# 4. Create new variables with functions of existing variables (mutate(), transmute()).
# 5. Collapse many values down to a single summary (summarise()).
# 6. These can all be used in conjunction with group_by() which changes the 
#    scope of each function from operating on the entire dataset to operating 
#    on it group-by-group. 

# These 6 functions provide the verbs for a language of data manipulation:

# All verbs work similarly:
# 
# - The 1st argument is a data frame.
# - The subsequent arguments describe what to do with the data frame, 
#   using the variable names (_without_ quotes).
# - The result is a new data frame.




## 5.2 Filter rows with filter() ------

# filter() allows you to subset observations based on their values. 
# The first argument is the name of the data frame. 
# The second and subsequent arguments are the expressions that filter 
# the data frame. For example, we can select all flights on January 1st with:

jan1 <- filter(flights, month == 1, day == 1)
jan1

# Assigning _and_ printing result: Wrap assignment in parentheses:

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
filter(flights, arr_delay <= 120 & dep_delay <= 120)

## Tip: Whenever you start using complicated, multipart expressions in filter(), 
##      consider making them explicit variables instead. 
##      That makes it much easier to check your work. 
##      You’ll learn how to create new variables shortly.


## 5.2.3 Missing values ------

# NA represents an unknown value so missing values are “contagious”: 
# almost any operation involving an unknown value will also be unknown.

NA > 2
NA == 2
NA != 2

NA == NA      # indeed!
near(NA, NA)  # same

## Why is this so?  [test.quest]
x <- NA  # Let x be Mary's age. We don't know how old she is.
y <- NA  # Let y be John's age. We don't know how old he is.

x == y   # Are John and Mary the same age?
# Answer: We don't know!

# Use is.na() if you want to determine if a value is missing:
is.na(x)

# filter() only includes rows where the condition is TRUE; 
# it excludes _both_ FALSE and NA values. [test.quest]
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

?between # a shortcut for x >= left & x <= right.

# Examples: 
x <- rnorm(1000)
z <- round(runif(1000, min = -3, max = +3), 0)

hist(x)
hist(z)

y <- x[between(x, -1, 1)]
range(y)

z2 <- z[between(z, -1, 1)]
range(z2) # => between interprets boundaries inclusive (<= and >=)


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





## 5.3 Arrange rows with arrange() ------

## arrange() works similarly to filter() except that 
## instead of selecting rows, it changes their order. 
## It takes a data frame and a set of column names 
## (or more complicated expressions) to order by. 

## If you provide more than one column name, 
## each additional column will be used to break ties 
## in the values of preceding columns:
  
arrange(flights, year, month, day)

## Use desc() to re-order by a column in descending order:
  
arrange(flights, desc(arr_delay))

at <- arrange(flights, desc(air_time)) 
at$air_time

## Missing values are always sorted to the end:

df <- tibble(x = c(5, 2, NA))

arrange(df, x)
arrange(df, desc(x))


## 5.3.1 Exercises ------

# 1. How could you use arrange() to sort all missing values to the start? 
#    (Hint: use is.na()).

flights
arrange(flights, !is.na(dep_time))

# 2. Sort flights to find the most delayed flights. 
#    Find the flights that left earliest.

(most_delay <- arrange(flights, desc(dep_delay)))
(earliest <- arrange(flights, dep_time))

# 3. Sort flights to find the fastest flights:
# a) fastest = shortest:
(fastest <- arrange(flights, air_time))

# b) fastest = min arr_delay:
(faster_than_schedule <- arrange(flights, arr_delay))

## [test.quest]: From where to where did the 3 fastest flights go to?
fastest # from EWR to BDL
filter(airports, faa == "EWR" | faa == "BDL")

# 4. Which flights travelled the longest? Which travelled the shortest?

# time: 
(longest <-  arrange(flights, desc(air_time)))
(shortest <-  arrange(flights, air_time))

# distance:
(farthest <- arrange(flights, desc(distance)))

filter(airports, faa == "JFK" | faa == "HNL")

## [test.quest]: 
## - What is the distance of the farthest flight (in terms of miles)?
## - Is the farthest flight (in terms of miles) also the longest (in terms of time)?
## - How many instances of the farthest flight are in the data? 
## - What is their average duration?
## - Which carrier(s) conducted these flights?
## - Plot the relationship between both (distance and air_time).

flights
(by_distance <- arrange(flights, desc(distance)))
(farthest <- filter(flights, origin == "JFK" & dest == "HNL")) # => 342
mean(farthest$air_time)
table(farthest$carrier)

?airlines
filter(airlines, carrier == "HA")

f <- flights %>% 
  filter(!is.na(distance) & !is.na(air_time)) %>% # both exist
  group_by(distance) %>%
  summarise(n = n(),
            not_NA = sum(!is.na(air_time)),
            mn_at = mean(air_time),
            md_at = median(air_time))
# f

ggplot(f, aes(x = distance, y = mn_at)) +
  geom_point(alpha = 1/3)

## From the plot: 
## (a) 2 outliers with distance > 4000:
flights %>% 
  filter(distance > 4000, is.na(dep_time)) %>%
  # group_by(carrier, tailnum) %>%
  summarise(count = n(),
            count_NA = sum(is.na(dep_time)))

# => 707 flights, 2 NA
# Which 2 did not take place?

flights %>% 
  filter(distance > 4000, is.na(dep_time))

# Why? Unusual weather conditions? 
?weather
weather %>% 
  filter(origin == "EWR" & month == 2 & day == 10 & hour > 10)

weather %>%
  filter(origin == "EWR") %>%
  group_by(month, day) %>%
  summarise(n = n(),
            mn_wind = mean(wind_speed, na.rm = TRUE),
            mn_rain = mean(precip, na.rm = TRUE)) %>%
  arrange(desc(mn_rain))

## (b) 1 outlier with between(distance, 3000, 4000):
flights %>% 
  filter(between(distance, 3000, 4000))

# => Only 8 flights to from EWR to ANC (Anchorage).
# Compute mean arrival delay...




## 5.4 Select columns with select() ------

# It’s not uncommon to get datasets with hundreds or even thousands of
# variables. In this case, the first challenge is often narrowing in on the
# variables you’re actually interested in.

# select() allows you to rapidly zoom in on a useful subset using operations
# based on the names of the variables.

# select() is not terribly useful with the flights data because we only have 
# 19 variables, but you can still get the general idea:

select(flights, year, month, day)  # select columns by name
select(flights, year:day)          # select all columns between year and day (inclusive)
select(flights, -(year:day))       # select all columns except those from year to day (inclusive)

## select() helper functions: starts_with(), ends_with(), contains(), matches() ----

# There are a number of helper functions you can use within select():
#   
# - starts_with("abc"): matches names that begin with “abc”.

select(flights, starts_with("dep"))

# - ends_with("xyz"):   matches names that end with “xyz”.

select(flights, ends_with("time"))

# - contains("ijk"):    matches names that contain “ijk”.

select(flights, contains("arr"))

# - matches("(.)\\1"):  selects variables that match a regular expression. 
#                       This one matches any variables that contain repeated characters. 
#                       You’ll learn more about regular expressions in strings.

select(flights, matches("(.)\\1"))

# - num_range("x", 1:3) matches x1, x2 and x3.
# 
# See ?select for more details.

?select

# See "Scoped selection and renaming"

## select vs. rename: ----

# select() can be used to rename variables, but it’s rarely useful 
# because it _drops_ all of the variables not explicitly mentioned. 
# Instead, use rename(), which is a variant of select() that 
# _keeps_ all the variables that aren’t explicitly mentioned:

?rename

flights$tailnum
(df <- rename(flights, tail_num = tailnum))
flights$tailnum
df$tailnum # no longer exists
all.equal(flights$tailnum, df$tail_num) #  => TRUE

# head(iris)
# rename(iris, petal_length = Petal.Length)


## select() with everything(): ---- 

# Another option is to use select() in conjunction with the everything() helper.
# This is useful if you have a handful of variables you’d like to move to the
# start of the data frame: 

select(flights, time_hour, air_time, everything())


## 5.4.1 Exercises ------

flights

# 1. Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time, and arr_delay from flights.

select(flights, dep_time, dep_delay, arr_time, arr_delay)
select(flights, dep_time, dep_delay:arr_time, arr_delay)
select(flights, contains("time"), contains("delay"), -contains("sched"), -contains("air"), -contains("hour"))


# 2. What happens if you include the name of a variable multiple times in a select() call?

select(flights, dep_time, arr_time, dep_time, arr_time)  # each unique variable is only included once:


# 3. What does the one_of() function do? Why might it be helpful in conjunction with this vector?
   
vars <- c("year", "month", "day", "dep_delay", "arr_delay", "something_else")

?one_of # allows providing a vector of variable names to a select call:

select(flights, one_of(vars))


# 4. Does the result of running the following code surprise you? 
# How do the select helpers deal with case by default? 
# How can you change that default?
  
select(flights, contains("TIME"))  # yes, this is surprising, as R typically is case sensitive.  But here: ignore.case = TRUE by default.
select(flights, contains("TIME", ignore.case = FALSE))







## 5.5 Add new variables with mutate() ------

## mutate() adds new columns that are functions of existing columns.
## mutate() always adds new columns at the end of the dataset.

## Create a narrower dataset from flights:

flights_sml <- select(flights, 
                      year:day, 
                      ends_with("delay"), 
                      distance, 
                      air_time)

flights_sml

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60)

## Note that we can refer to columns that we’ve just created:
  
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours)

## Using transmute() only keeps the new variables:
  
transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours)


## 5.5.1 Useful creation functions -----

## There are many functions for creating new variables that you can use with
## mutate(). The key property is that the function must be vectorised: it must
## take a vector of values as input, return a vector with the same number of
## values as output.

## 1. Arithmetic operators: +, -, *, /, ^ ----

## 2. Modular arithmetic: %/% (integer division) and %% (remainder) ----

x <- runif(1, min = 101, max = 1000)
y <- runif(1, min = 1, max = 100)
x == y * (x %/% y) + (x %% y)  ## [test.quest]: explain why OR mc == 0, 1, x, y.

transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100
          )

## 3. Logs: log(), log2(), log10(). ----

## Logarithms are an incredibly useful transformation for dealing with data that
## ranges across multiple orders of magnitude. They also convert multiplicative
## relationships to additive, a feature we’ll come back to in modelling.

## All else being equal, use log2() because it’s easy to interpret: 
## A difference of 1 on the log scale corresponds to doubling on the original
## scale and a difference of -1 corresponds to halving.

## 4. Offsets: lead() and lag() allow you to refer to leading or lagging values. ----

## This allows us to compute running differences (e.g. x - lag(x)) 
## or find when values change (x != lag(x)). 

## They are most useful in conjunction with group_by(), 
## which we’ll learn about shortly.

(x <- 1:10)

lag(x)  # value before current value
lead(x) # value behind current value

## 5. Cumulative and rolling aggregates: ----

## R provides functions for running sums, products, mins and maxes: 
## cumsum(), cumprod(), cummin(), cummax(); and dplyr provides cummean() for
## cumulative means. 

## If we need rolling aggregates (i.e., a sum computed over a rolling window),
## try the RcppRoll package.

x
cumsum(x)
cummean(x)

## 6. Logical comparisons: <, <=, >, >=, != ----

## 7. Ranking: ----

## There are a number of ranking functions, but start with min_rank(). 
## It does the most usual type of ranking (e.g. 1st, 2nd, 2nd, 4th). 
## The default gives smallest values the small ranks; use desc(x) to give the
## largest values the smallest ranks.

y <- c(1, 2, 2, NA, 3, 4)

min_rank(y)
min_rank(desc(y))

## If min_rank() doesn’t do what you need, look at the variants: 
## row_number(), dense_rank(), percent_rank(), cume_dist(), ntile(). 
## See their help pages for more details.

row_number(y)
dense_rank(y)
percent_rank(y)
cume_dist(y)


## 5.5.2 Exercises ------
 
## 1. Currently dep_time and sched_dep_time are convenient to look at, but hard
## to compute with because they’re not really continuous numbers. Convert them
## to a more convenient representation of number of minutes since midnight.

transmute(flights,
          dep_time,
          sched_dep_time,
          dep_time_min = (dep_time %/% 100) * 60 + (dep_time %% 100), 
          sched_dep_time_min = (sched_dep_time %/% 100) * 60 + (sched_dep_time %% 100)
          )

## 2. Compare air_time with arr_time - dep_time. What do you expect to see? 
## What do you see? What do you need to do to fix it?

transmute(flights,
          dep_time,
          arr_time,
          sched_dep_time,
          sched_arr_time, 
          air_time,
          air_time_2 = (arr_time - dep_time),
          arr_time_min = (arr_time %/% 100) * 60 + (arr_time %% 100), 
          dep_time_min = (dep_time %/% 100) * 60 + (dep_time %% 100), 
          sched_dep_time_min = (sched_dep_time %/% 100) * 60 + (sched_dep_time %% 100),
          sched_arr_time_min = (sched_arr_time %/% 100) * 60 + (sched_arr_time %% 100),
          air_time_3 = (arr_time_min - dep_time_min),
          air_time_4 = (sched_arr_time_min - sched_dep_time_min)
          )

# ???
   
## 3. Compare dep_time, sched_dep_time, and dep_delay. 
## How would you expect those three numbers to be related?

transmute(flights,
          dep_time,
          sched_dep_time,
          dep_delay,
          dep_time_min = (dep_time %/% 100) * 60 + (dep_time %% 100), 
          sched_dep_time_min = (sched_dep_time %/% 100) * 60 + (sched_dep_time %% 100),
          dep_delay_2 = dep_time_min - sched_dep_time_min,
          same = near(dep_delay, dep_delay_2)
          )

## 4. Find the 10 most delayed flights using a ranking function. 
## How do you want to handle ties? Carefully read the documentation for min_rank().

?min_rank

t <- mutate(flights, 
           delay_rank = min_rank(desc(dep_delay))  # add rank of dep_delay (descending)
           )
t <- select(t, delay_rank, everything())  # put delay_rank to front
arrange(t, delay_rank)  # sort t by delay rank

## Directly: 
arrange(flights, desc(dep_delay))  # sort flights by (descending) dep_delay 


## 5. What does 1:3 + 1:10 return? Why?
1:3 + 1:10  # due to recycling shorter object (see warning):

## 6. What trigonometric functions does R provide?
?sin






## 5.6 Grouped summaries with summarise() ------

## The last key verb is summarise(). 
## It collapses a data frame to a single row:

(md <- summarise(flights, delay = mean(dep_delay, na.rm = TRUE)))

md == mean(flights$dep_delay, na.rm = TRUE)

## summarise() is not terribly useful unless we pair it with group_by()
## (and vice versa: group_by makes only sense with summarise). 

## group_by() changes the unit of analysis from the complete dataset to individual groups. 
## When you use the dplyr verbs on a grouped data frame they’ll be
## automatically applied "by group".  For example, if we apply exactly the same
## code to a data frame grouped by date, we get the average delay per date:

flights
  
by_day <- group_by(flights, year, month, day)
by_day

summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

## [test.quest] ggplot: plot curve of average delay per day/week/month

by_month <- group_by(flights, month)
by_month
month_delay <- summarise(by_month, 
                         count = n(),
                         delay = mean(dep_delay, na.rm = TRUE)
)
  
ggplot(month_delay, mapping = aes(x = month, y = delay)) +
  geom_point(aes(size = count), color = "firebrick", alpha = 1/2) +
  geom_smooth(se = FALSE) +
  scale_x_continuous(name = "Month", breaks = 1:12) + 
  theme_bw()

## Together group_by() and summarise() provide one of the tools 
## that we’ll use most commonly when working with dplyr: 
## grouped summaries.

## 5.6.1 Combining multiple operations with the pipe -----

## Imagine that we want to explore the relationship between the distance and
## average delay for each location. Using what you know about dplyr, you might
## write code like this:
  
by_dest <- group_by(flights, dest)  # group flights by dest

delay <- summarise(by_dest,
                   count = n(),                           # count n
                   dist = mean(distance, na.rm = TRUE),   # mean dist
                   delay = mean(arr_delay, na.rm = TRUE)  # mean delay
                   )

delay <- filter(delay, count > 20, dest != "HNL")  # filter out rare points and outlier HNL

delay

# It looks like delays increase with distance up to ~750 miles 
# and then decrease. Maybe as flights get longer there's more 
# ability to make up delays in the air?

ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

## As we're not interested in the intermediate results, 
## we could rewrite the same by using the pipe:

delays <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 20, dest != "HNL")

## Read the pipe as "then".

## Behind the scenes, x %>% f(y) turns into f(x, y), 
## and x %>% f(y) %>% g(z) turns into g(f(x, y), z), etc. 


## 5.6.2 Missing values (in grouped summaries) ----- 

## All aggregation functions have an na.rm argument 
## which removes the missing values prior to computation:

flights %>% 
  group_by(year, month, day) %>% 
  summarise(count = n(),
            mean = mean(dep_delay))

## => yields many missing values (as mean of any set of values containing NA returns NA). 

## (1) Removing NA values: ---- 

flights %>% 
  group_by(year, month, day) %>% 
  summarise(count = n(),                            # count n (including NAs)
            mean = mean(dep_delay, na.rm = TRUE)    # means of dep_delay values that are not NA
            )

## Note that the count computed by n() is the same in both cases. 
## How to count number of NAs?

## (2) Counting NA values: ----

flights %>% 
  group_by(year, month, day) %>% 
  summarise(count = n(),                            # count n (including NAs)
            n_is_NA = sum(is.na(dep_delay)),        # count n of NAs
            n_not_NA = sum(!is.na(dep_delay)),      # count n of non-NAs
            mean = mean(dep_delay, na.rm = TRUE)    # means of dep_delay values that are not NA
  )

## (3) Subsetting data by filtering out NA values: ----

## Subset of flights not cancelled: 
not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(count = n(),
            n_is_NA = sum(is.na(dep_delay)), 
            n_not_NA = sum(!is.na(dep_delay)), 
            mean = mean(dep_delay)
            )

## Note that using the subset not_cancelled has decreased 
## the count to previous value of n_not_NA!


## 5.6.3 Counts ----

## Whenever you do any aggregation, it’s always a good idea to include either a
## count (n()), and a count of non-missing values (sum(!is.na(x))).

## Look at planes (identified by their tail number) 
## that have the highest average delays:

delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay)
  )

ggplot(data = delays, mapping = aes(x = delay)) + 
  geom_freqpoly(binwidth = 10)

## Wow, there are some planes that have an average delay of 5 hours (300 minutes)!

## The story is actually a little more nuanced:

## We can get more insight if we draw a scatterplot of 
## number of flights vs. average delay:
  
delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )

ggplot(data = delays, mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10) +
  theme_light()

## Characteristic shape: Variation decreases as the sample size increases. 

## filter out the groups with the smallest numbers of observations:

delays %>% 
  filter(n > 20) %>% 
  ggplot(mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10) +
  theme_light()

## RStudio tip: a useful keyboard shortcut is Cmd/Ctrl + Shift + P. 
## This resends the previously sent chunk from the editor to the console. 
## This is very convenient when you’re (e.g.) exploring the value of n 
## in this example.

## A common variation of this type of pattern: Means as a function of N. 

## Let’s look at how the average performance of batters in baseball is related
## to the number of times they’re at bat (using data from the Lahman
## package to compute the batting average (number of hits / number of attempts)
## of every major league baseball player)

# When plotting the skill of the batter (measured by the batting average, ba)
# against the number of opportunities to hit the ball (measured by at bat, ab),
# you see two patterns:

# install.packages('Lahman')

batting <- as_tibble(Lahman::Batting)

batters <- batting %>% 
  group_by(playerID) %>% 
  summarise(
    count = n(),
    not_NA = sum(!is.na(AB)), 
    ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    ab = sum(AB, na.rm = TRUE)
  )

batters %>% 
  filter(ab > 100) %>% 
  ggplot(mapping = aes(x = ab, y = ba)) +
  geom_point(alpha = 1/5) + 
  geom_smooth(se = FALSE) + 
  theme_light()


# 1. As above, the variation in our aggregate decreases as we get more data points.

# 2. There’s a positive correlation between skill (ba) and 
#    opportunities to hit the ball (ab).  
# This is because teams control who gets to play, and obviously they 
# pick their best players.

# This also has important implications for ranking: 

# If you naively sort on desc(ba), the people with the best batting averages 
# are clearly lucky, not skilled:

batters %>% 
  arrange(desc(ba))

batters %>% 
  filter(ab > 30) %>%
  arrange(desc(ba))

# You can find a good explanation of this problem at 
# http://varianceexplained.org/r/empirical_bayes_baseball/ and 
# http://www.evanmiller.org/how-not-to-sort-by-average-rating.html 


## 5.6.4 Useful summary functions -----

## Just using means, counts, and sum can get you a long way, but R provides many
## other useful summary functions:

## (1) Measures of location: mean(x), median(x) ----

## Tip: Combine aggregation with logical subsetting

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    avg_delay1 = mean(arr_delay),
    avg_delay2 = mean(arr_delay[arr_delay > 0]) # the average positive delay
  )

## (2) Measures of variability/spread: sd(x), IQR(x), mad(x) ----

# Why is distance to some destinations more variable than to others?

not_cancelled %>% 
  group_by(dest) %>% 
  summarise(distance_sd = sd(distance)) %>% 
  arrange(desc(distance_sd))

## (3) Measures of rank: min(x), quantile(x, 0.25), max(x) ----

# When do the first and last flights leave each day?

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first = min(dep_time),
    last = max(dep_time)
    )

## (4) Measures of position: first(x), nth(x, 2), last(x) ----

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first_dep = first(dep_time), 
    last_dep = last(dep_time)
  )

# These functions are complementary to filtering on ranks. 
# Filtering gives you all variables, with each observation 
# in a separate row:
  
not_cancelled %>% 
  group_by(year, month, day) %>% 
  mutate(r = min_rank(desc(dep_time))) %>% 
  filter(r %in% range(r))


## (5) Counts: ----
## We’ve seen n(), which takes no arguments, 
## and returns the size of the current group. 
## To count the number of non-missing values, 
## use sum(!is.na(x)). 
## To count the number of distinct (unique) values, use n_distinct(x).

# Which destinations have the most carriers?

not_cancelled %>% 
  group_by(dest) %>% 
  summarise(carriers = n_distinct(carrier)) %>% 
  arrange(desc(carriers))

# Counts are so useful that dplyr provides a simple helper if all you want is a
# count:

not_cancelled %>% 
  count(dest)

# You can optionally provide a weight variable. 
# For example, you could use this to “count” (sum) 
# the total number of miles a plane flew:
  
not_cancelled %>% 
  count(tailnum, wt = distance)


## (+) Sums and proportions of logical values: sum(x > 10), mean(y == 0) ----

## When used with numeric functions, TRUE is converted to 1 and FALSE to 0. 

## This makes sum() and mean() very useful: 
## sum(x) gives the number of TRUEs in x, 
## and mean(x) gives the proportion.

# How many flights left before 5am? 
# (these usually indicate delayed flights from the previous day)

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(n_early = sum(dep_time < 500))


# What _proportion_ of flights are delayed by more than an hour?

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(hour_perc = mean(arr_delay > 60))


## 5.6.5 Grouping by multiple variables ------

daily <- group_by(flights, year, month, day)

(per_day   <- summarise(daily, flights = n()))
(per_month <- summarise(per_day, flights = sum(flights)))
(per_year <- summarise(per_month, flights = sum(flights)))

## Be careful when progressively rolling up summaries: it’s OK for sums and
## counts, but you need to think about weighting means and variances, and it’s
## not possible to do it exactly for rank-based statistics like the median. 
## In other words, the sum of groupwise sums is the overall sum, but the median
## of groupwise medians is not the overall median.



## 5.6.6 Ungrouping ------

daily # grouped (above)

## If you need to remove grouping, and return to operations on ungrouped data,
## use ungroup(): 

daily %>% 
  ungroup() %>%             # no longer grouped by date
  summarise(flights = n())  # all flights


## 5.6.7 Exercises ------

# 1. Brainstorm at least 5 different ways to assess the typical delay
#    characteristics of a group of flights. Consider the following scenarios:

?flights

## The question concerns distributional characteristics of a flight.

## What defines a "flight"?

## (a) same carrier and flight number:

arrange(flights, carrier, flight)

flights %>%
  group_by(carrier, flight) %>%
  summarise(count = n(),
            n_not_NA = sum(!is.na(dep_delay)), 
            mn_dep_delay = mean(dep_delay, na.rm = TRUE),
            sd_dep_delay = sd(dep_delay, na.rm = TRUE),
            mn_arr_delay = mean(arr_delay, na.rm = TRUE),
            sd_arr_delay = sd(arr_delay, na.rm = TRUE)
            ) %>%
  arrange(desc(count))


## (b) same origin and destination:

arrange(flights, origin, dest)

flights %>%
  group_by(origin, dest) %>%
  summarise(count = n(),
            n_not_NA = sum(!is.na(dep_delay)), 
            mn_dep_delay = mean(dep_delay, na.rm = TRUE),
            sd_dep_delay = sd(dep_delay, na.rm = TRUE),
            mn_arr_delay = mean(arr_delay, na.rm = TRUE),
            sd_arr_delay = sd(arr_delay, na.rm = TRUE)
  ) %>%
  arrange(desc(count))

# Which is more important: arrival delay or departure delay?
#
# Arrival delay seems more important, as it crucially impacts 
# subsequent flights and travel plans.

#  a. A flight is always 10 minutes late.

flights_s <- select(flights, 
                    year:day,
                    arr_delay,
                    carrier:tailnum)

mutate(flights_s,
       late10 = (arr_delay >= 10)
       )

#  b. A flight is 15 minutes early 50% of the time, and 15 minutes late 50% of the time.

#  c. A flight is 30 minutes early 50% of the time, and 30 minutes late 50% of the time.
 
#  d. 99% of the time a flight is on time. 1% of the time it’s 2 hours late.



  
#  2. Come up with another approach that will give you the same output as
# (a)
not_cancelled %>% 
  count(dest) 

# without using count():

not_cancelled %>% 
  group_by(dest) %>% 
  summarise(count = n())


# (b)
not_cancelled %>% 
  count(tailnum, wt = distance)

## Note: 
# ?count
#  wt ... - If omitted, will count the number of rows. 
#         - If specified, will perform a "weighted" tally by summing the (non-missing) 
#           values of variable wt.

# without using count():
not_cancelled %>% 
  group_by(tailnum) %>%
  summarise(n = sum(distance))

# From 
# https://jrnold.github.io/r4ds-exercise-solutions/data-transformation.html#exercise-2-9

not_cancelled %>%
  group_by(tailnum) %>%
  tally(distance)

# [test.quest]: Do the reverse: 
# a) replace count by (group_by + summarise)
# b) replace (group_by + summarise) by count + wt.


# 3. Our definition of cancelled flights (is.na(dep_delay) | is.na(arr_delay) )
#    is slightly suboptimal. Why? Which is the most important column?

not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

nrow(not_cancelled)

cancelled <- flights %>%
  filter(is.na(dep_delay) | is.na(arr_delay))

nrow(cancelled) # => 9430
nrow(not_cancelled) + nrow(cancelled) == nrow(flights) # is TRUE (as it should)

# But:
cancel_dep <- flights %>%
  filter(is.na(dep_delay))

cancel_arr <- flights %>%
  filter(is.na(arr_delay))

nrow(cancel_dep) # => 8255
nrow(cancel_arr) # => 9430

# => There are flights with a departure delay value but no arrival delay value (arr_delay = NA):

no_arr_delay <- flights %>%
  filter(!is.na(dep_delay) & is.na(arr_delay))

no_arr_delay
nrow(no_arr_delay)

# Perhaps require that arr_time is also NA?

# Also: See 
# https://jrnold.github.io/r4ds-exercise-solutions/data-transformation.html#exercise-3-9

# If a flight never departs, then it won’t arrive. 
# A flight could also depart and not arrive if it crashes, 
# or if it is redirected and lands in an airport other than its intended destination.

# The more important column is arr_delay, which indicates the amount of delay in arrival.

filter(flights, !is.na(dep_delay), is.na(arr_delay)) %>%
  select(dep_time, arr_time, sched_arr_time, dep_delay, arr_delay)


# 4. Look at the number of cancelled flights per day. Is there a pattern? 
#    Is the proportion of cancelled flights related to the average delay?

cancelled <- flights %>% 
  filter(is.na(dep_delay), is.na(arr_delay))

cancelled %>%
  group_by(month, day) %>%
  summarise(n = n(),
            n_not_NA = sum(!is.na(day)))

## Better solution:  Create 2 variables (per day):
# - number (or proportion) of cancelled flights
# - average delay of non-cancelled flights

flights %>%
  mutate(cancelled = (is.na(dep_delay) & is.na(arr_delay))) %>%
  group_by(month, day) %>%
  summarise(n = n(),
            n_not_NA = sum(!is.na(dep_delay)),
            n_is_NA  = sum(is.na(dep_delay)), 
            n_cancelled = sum(cancelled), 
            cancelled_prop = sum(cancelled)/n,
            mn_dep_delay = mean(dep_delay, na.rm = TRUE)
            ) %>%
  ggplot(aes(x = mn_dep_delay, y = cancelled_prop)) +
  geom_point(aes(size = n_cancelled), alpha = 1/3) +
  geom_smooth() + 
  theme_bw()
  
# [test.quest]: Zoom in on 2 outliers with >50% of cancelled flights.
flights %>%
  mutate(cancelled = (is.na(dep_delay) & is.na(arr_delay))) %>%
  group_by(month, day) %>%
  summarise(n = n(),
            n_not_NA = sum(!is.na(dep_delay)),
            n_is_NA  = sum(is.na(dep_delay)), 
            n_cancelled = sum(cancelled), 
            cancelled_prop = sum(cancelled)/n,
            mn_dep_delay = mean(dep_delay, na.rm = TRUE)
  ) %>%
  arrange(desc(cancelled_prop))

# Any special weather conditions?
weather %>%
  # filter(month == 2, between(day, 1, 15)) %>%
  group_by(month, day) %>%
  summarise(n = n(),
            mn_temp = mean(temp, na.rm = TRUE),
            mn_wind = mean(wind_speed, na.rm = TRUE),
            mn_gust = mean(wind_gust, na.rm = TRUE),
            mn_rain = mean(precip, na.rm = TRUE)
            ) %>%
  arrange(desc(mn_rain))
# => No obvious weather extremes. 


# 5. Which carrier has the worst delays? Challenge: can you disentangle the
# effects of bad airports vs. bad carriers? Why/why not? (Hint: think about
# flights %>% group_by(carrier, dest) %>% summarise(n()))

flights %>% 
  group_by(carrier, dest) %>%
  summarise(n = n(),
            n_is_NA  = sum(is.na(arr_delay)), 
            mn_delay = mean(arr_delay, na.rm = TRUE),
            sd_delay = sd(arr_delay, na.rm = TRUE)
            ) %>% 
  filter(n >= 10) %>%
  arrange(desc(mn_delay))
  
# worst carriers:
flights %>% 
  group_by(carrier) %>%
  summarise(n = n(),
            n_is_NA  = sum(is.na(arr_delay)), 
            mn_delay = mean(arr_delay, na.rm = TRUE),
            sd_delay = sd(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(n >= 1) %>%
  arrange(desc(mn_delay))

airlines %>%
  filter(carrier %in% c("F9", "FL", "EV"))

# worst destinations:
flights %>% 
  group_by(dest) %>%
  summarise(n = n(),
            n_is_NA  = sum(is.na(arr_delay)), 
            mn_delay = mean(arr_delay, na.rm = TRUE),
            sd_delay = sd(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(n >= 1) %>%
  arrange(desc(mn_delay))

airports %>%
  filter(faa %in% c("CAE", "TUL", "OKC"))
  

# 6. What does the sort argument to count() do.  
#    When might you use it?

?count
# => sort	if TRUE will sort output in descending order of n

flights %>%
  group_by(origin) %>%
  count(sort = TRUE)

flights %>% 
  filter(origin == "LGA") %>%
  group_by(dest) %>%
  count(sort = TRUE)




## 5.7 Grouped mutates (and filters) ------

flights_sml <- select(flights, 
                      year:day, 
                      ends_with("delay"), 
                      distance, 
                      air_time)

# Grouping is most useful in conjunction with summarise(), 
# but we can also do convenient operations with mutate() and filter():
  
# (1) Find the best/worst members of each group: ---- 
  
flights_sml %>% 
  group_by(year, month, day) %>%
  filter(rank(desc(arr_delay)) <= 3)  # finds the 3 worst for each day (Note use of "rank")

# (2) Find all groups bigger than a threshold: ---- 

popular_dests <- flights %>% 
  group_by(dest) %>% 
  filter(n() > 365)

# Note that solution is implicit (does not show result).
length(unique(popular_dests$dest)) # => 77

# Alternative/explicit solution: 
flights %>% 
  group_by(dest) %>% 
  summarise(n = n(),
            n_not_NA = sum(!is.na(arr_time))) %>%
  mutate(prop = round(n/sum(n) * 100, 3)) %>%
  arrange(rank(desc(n))) %>%
  filter(n > 365)


## [test.quest]: Rare destinations?
  
# Implicit solution:
rare_dests <- flights %>% 
  group_by(dest) %>% 
  filter(n() < 10) # fewer than 10 flights
rare_dests$dest

# Alternative/explicit solution: 
flights %>% 
  group_by(dest) %>% 
  summarise(n = n(),
            n_not_NA = sum(!is.na(arr_time))) %>%
  mutate(prop = round(n/sum(n) * 100, 3)) %>%
  arrange(rank(n))

# [test.quest]: Dest. with fewer than .01% of flights?            

# (3) Standardise to compute per group metrics: ---- 
  
popular_dests %>% 
  filter(arr_delay > 0) %>% 
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>% 
  select(year:day, dest, arr_delay, prop_delay)

# A grouped filter is a grouped mutate followed by an ungrouped filter. 
# We generally avoid them except for quick and dirty manipulations: 
# otherwise it’s hard to check that we’ve done the manipulation correctly.

## Window functions: ---- 

# Functions that work most naturally in grouped mutates and filters 
# are known as window functions (vs. the summary functions used for summaries). 
# We can learn more about useful window functions in the corresponding vignette: 

# vignette("window-functions")


## 5.7.1 Exercises ------

# 1. Refer back to the lists of useful mutate and filtering functions. 
#    Describe how each operation changes when you combine it with grouping.

# Summary functions take all values per group, 
# rather than raw values.

# 2. Which plane (tailnum) has the worst on-time record?

#    Decision: Use mean of arr_delay to determine on-time record.

flights %>%
  group_by(tailnum) %>%
  summarise(n = n(),
            n_not_NA = sum(!is.na(arr_delay)),
            mn_delay = mean(arr_delay, na.rm = TRUE)) %>%
  #filter(n_not_NA > 10) %>%  # at least 10 flights
  arrange(desc(mn_delay))

## Which flight is this?
flights %>%
  filter(tailnum %in% c("N844MH", "N337AT"))

# [test.quest]: Which destinations with at least 1000 arrivals has the worst arrival delays?
flights %>%
  group_by(dest) %>%
  summarise(n = n(),
            n_not_NA = sum(!is.na(arr_delay)),
            mn_delay = mean(arr_delay, na.rm = TRUE)) %>%
  filter(n_not_NA > 1000) %>%  # at least 1000 flights
  arrange(desc(mn_delay))

# 3. What time of day should you fly if you want to avoid delays as much as possible?

# (a) Using departure delays:
td <- flights %>%
  group_by(hour) %>%
  summarise(n = n(),
            n_not_NA = sum(!is.na(dep_delay)),
            mn_delay = mean(dep_delay, na.rm = TRUE)) %>%
  # filter(n_not_NA > 100) %>%  # at least 100 flights in group
  arrange(mn_delay)
td

# [test.quest]: Plotting relationship:
ggplot(td, aes(x = hour, y = mn_delay)) +
  geom_point() +
  geom_line()

# Note that corresponding raw data plot is a mess: 
ggplot(flights, aes(x = hour, y = arr_delay)) +
  geom_point(alpha = 1/5) +
  geom_smooth()

# 4. For each destination, compute the total minutes of delay. 
#    For each, flight, compute the proportion of the total delay for its destination.

flights %>%
  group_by(dest) %>%
  summarise(n = n(),
            n_not_NA = sum(!is.na(arr_delay)),
            sum_delay = sum(arr_delay, na.rm = TRUE))

## For flights with positive arr_delay values:
flights %>%
  filter(!is.na(arr_delay), arr_delay > 0) %>%  # an arr_delay exists
  group_by(dest) %>%
  mutate(total_delay = sum(arr_delay),
         prop_delay = arr_delay / sum(arr_delay)) %>%
  select(arr_delay, total_delay, prop_delay, everything()) %>%
  arrange(desc(prop_delay))

# 5. Delays are typically temporally correlated: 
#    even once the problem that caused the initial delay has been resolved, 
#    later flights are delayed to allow earlier flights to leave. 
#    Using lag() explore how the delay of a flight 
#    is related to the delay of the immediately preceding flight.

flights  # are ordered by date and time.
# However, should be done by origin airports:

# From https://jrnold.github.io/r4ds-exercise-solutions/data-transformation.html#exercise-5-5 

# - We want to group by day to avoid taking the lag from the previous day. 
# Also, we want to use departure delay, since this mechanism is relevant for departures.
# Also, we remove missing values both before and after calculating the lag delay.
# (However, it would be interesting to ask the probability or average delay after
#  a cancellation.) 

flights %>%
  filter(origin == "EWR") %>%  # only 1 airport at a time
  group_by(year, month, day) %>%
  filter(!is.na(dep_delay)) %>%
  mutate(lag_delay = lag(dep_delay)) %>%
  filter(!is.na(lag_delay)) %>%
  ggplot(aes(x = dep_delay, y = lag_delay)) +
  geom_point(alpha = 1/3) +
  geom_smooth() + 
  theme_bw()

# 6. Look at each destination. 
#    Can you find flights that are suspiciously fast 
#    (i.e., flights that represent a potential data entry error). 
#    Compute the air time a flight relative to the shortest flight to that destination. 
#    Which flights were most delayed in the air?

# Depends on a definition of "suspiciously fast".
# Here: > 3 SDs faster than mean air_time to this destination.

flights %>%
  group_by(dest) %>%
  mutate(n = n(),  
         n_not_NA = sum(!is.na(air_time)),
         mn_at = mean(air_time, na.rm = TRUE),  # Note: Compute on grouped level!
         sd_at = sd(air_time, na.rm = TRUE)
         ) %>%
  # ungroup() %>%
  select(year:dep_time, arr_time, air_time, carrier, origin, dest, n:sd_at) %>% # individual flights
  mutate(suspect = air_time < (mn_at - 3 * sd_at)) %>%  # Compare air_time of individual flights to grouped variables!
  filter(suspect == TRUE)

# more compact version:
flights %>%
  group_by(dest) %>%
  mutate(n = n(),  
         n_not_NA = sum(!is.na(air_time)),
         mn_at = mean(air_time, na.rm = TRUE),  # Note: Compute on grouped level!
         sd_at = sd(air_time, na.rm = TRUE),
         suspect = air_time < (mn_at - 3 * sd_at)) %>%  # Compare air_time of individual flights to grouped variables!
  select(year:dep_time, arr_time, air_time, carrier, origin, dest, n:sd_at, suspect) %>% # individual flights
  filter(suspect == TRUE)
  
## Important: We compute the mean and SD for each destination (grouped level),
##            but then compare the air_time of individual flights to those means.

# computing mean and sd for combinations of origin and dest:
flights %>%
  group_by(origin, dest) %>%
  mutate(n = n(),  
         n_not_NA = sum(!is.na(air_time)),
         mn_at = mean(air_time, na.rm = TRUE),  # Note: Compute on grouped level!
         sd_at = sd(air_time, na.rm = TRUE),
         suspect = air_time < (mn_at - 3 * sd_at)) %>%  # Compare air_time of individual flights to grouped variables!
  select(year:dep_time, arr_time, air_time, carrier, origin, dest, n:sd_at, suspect) %>% # individual flights
  filter(suspect == TRUE)

#    Which flights were most delayed in the air?
flights %>%
  group_by(dest) %>%
  mutate(n = n(),  
         n_not_NA = sum(!is.na(air_time)),
         mn_at = mean(air_time, na.rm = TRUE),  # Note: Compute on grouped level!
         sd_at = sd(air_time, na.rm = TRUE),
         air_delay = air_time - mn_at) %>%  # Compute air_delay of individual flight to grouped variables!
  select(year:dep_time, arr_time, air_time, carrier, origin, dest, n:air_delay) %>% # individual flights
  arrange(desc(air_delay))

## [test.quest]: Identify outliers based on deviation from group means.
## Using iris data: Sepal.Length more than 2 SDs away from Species mean: 

iris %>%
  group_by(Species) %>%
  mutate(n = n(),  
         n_not_NA = sum(!is.na(Sepal.Length)),
         mn_sl = mean(Sepal.Length, na.rm = TRUE),
         sd_sl = sd(Sepal.Length, na.rm = TRUE),
         outlier = (abs(Sepal.Length - mn_sl) > 2 * sd_sl)) %>%
  filter(outlier)
  
ggplot(iris, aes(x = Sepal.Length, fill = Species)) +
  facet_wrap(~Species) +
  geom_histogram(binwidth = 0.1) +
  geom_density()


## From
## https://jrnold.github.io/r4ds-exercise-solutions/data-transformation.html#exercise-6-4 

## (a) "fast" as proportion of air_time being faster than med_time

flights %>%
  filter(!is.na(air_time)) %>%
  group_by(dest) %>%
  mutate(med_time = median(air_time),
         fast = (air_time - med_time) / med_time) %>%
  arrange(fast) %>%
  select(air_time, med_time, fast, dep_time, sched_dep_time, arr_time, sched_arr_time)

## (b) Compute a z-score, though mean and SD are affected by outliers:

flights %>%
  filter(!is.na(air_time)) %>%
  group_by(dest) %>%
  mutate(air_time_mean = mean(air_time),
         air_time_sd = sd(air_time),
         z_score = (air_time - air_time_mean) / air_time_sd) %>%
  arrange(z_score) %>%
  select(dest, z_score, air_time_mean, air_time_sd, air_time, dep_time, sched_dep_time, arr_time, sched_arr_time)

## (c) "Fast" as the difference: air_time - min(air_time):

flights %>%
  filter(!is.na(air_time)) %>%
  group_by(dest) %>%
  mutate(air_time_diff = air_time - min(air_time)) %>%
  arrange(desc(air_time_diff)) %>%
  select(dest, year, month, day, carrier, flight, air_time_diff, air_time, dep_time, arr_time)

## (d) "Fast" as the difference: air_time - mean(air_time):

flights %>%
  filter(!is.na(air_time)) %>%
  group_by(dest) %>%
  mutate(air_time_bonus = mean(air_time) - air_time) %>%
  arrange(desc(air_time_bonus)) %>%
  select(dest, year, month, day, carrier, flight, air_time_bonus, air_time, dep_time, arr_time)


# 7. Find all destinations that are flown by at least 2 carriers. 
#    Use that information to rank the carriers.

flights %>%
  group_by(dest, carrier) %>%
  count(carrier) %>% 
  group_by(carrier) %>%
  count(sort = TRUE)

airlines %>%
  filter(carrier == "EV")

# 8. For each plane, count the number of flights 
#    before the first delay of greater than 1 hour.


## Appendix: Additional resources on dplyr: ------

## Basic of dplyr: 
vignette("dplyr")
vignette("window-functions")

## More advanced uses of dplyr:
vignette("two-table")
vignette("programming")


## Others:

# - See dplyr cheatsheet at https://www.rstudio.com/resources/cheatsheets/

## +++ here now +++ ------ 

## Ideas for test questions [test.quest]: ------

# Compute true_travel_time (from dep_time and arr_time) and 
# plot its relationship to air_time.

# Use data set "weather" for questions that require 
# filter, arrange, group_by, summarise (count, NAs, means, medians)

## Aggregation examples: -----

## (1) Average temperature per month: (used in class)

weather %>%
  # group_by(origin, month) %>%
  group_by(month) %>%
  summarise(n = n(),
            n_not_NA = sum(!is.na(temp)), 
            mn_temp = mean(temp, na.rm = TRUE)) %>%
  ggplot(aes(x = month, y = mn_temp)) +
  geom_point() +
  geom_line() +
  scale_x_continuous(breaks = 1:12) +
  theme_bw()

# (2) Average precipitation (by origin and month):
weather %>%
  group_by(origin, month) %>%
  summarise(n = n(),
            n_not_NA = sum(!is.na(precip)), 
            mn_precip = mean(precip, na.rm = TRUE)) %>%
  ggplot(aes(x = month, y = mn_precip, color = origin)) +
  geom_point() +
  geom_line() +
  # geom_bar(aes(fill = origin), stat = "identity", position = "dodge") +
  scale_x_continuous(breaks = 1:12) +
  theme_bw()


## Scenario involving family dynasties (e.g., Games of thrones, Lord of the Rings, Harry Potter, Star Wars, ...)

{ ## Starwars scenario:  
  
  
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
  
  # Analogy: Scenario involving patients/doctors/insurances/pharma ... 
  
  }

## Identifying outliers: ---- 
## Identify and contrast overall (population-level) vs. within-group outliers. 

{
  ## Generate data: 
  set.seed(123)
  n <- 1000
  id <- paste0("p.", 1:n) # paste0(sample(LETTERS, 1), sample(LETTERS, 1))
  sex <- sample(x = c(0, 1), size = n, replace = TRUE)
  height <- rep(NA, n)
  noise <- round(rnorm(n, mean = 0, sd = 11), 0)
  height[sex == 0] <- 169 + noise[sex == 0]
  height[sex == 1] <- 181 + noise[sex == 1]
  
  data <- as_tibble(data_frame(id, factor(sex), height))
  names(data) <- c("id", "sex", "height")
  # data
  mean(data$height) # => 175.051
  
  ## Definition: Outlier  
  
  # Define an "outlier" as someone deviating by more than 2 SD in some metric 
  # from the mean of a reference group. 
  crit <- 2
  
  ## Compute 2 types of outliers:
  ## (a) relative to overall mean and SD 
  ## (b) relative to specific group mean and SD 
  
  data_out <- data %>%
    mutate(mn_height = mean(height),      # (a) overall:
           sd_height = sd(height),
           out_height = abs(height - mn_height) > (crit * sd_height)) %>%
    group_by(sex) %>% 
    mutate(mn_sex_height = mean(height),  # (b) by sex:
           sd_sex_height = sd(height),
           out_sex_height = abs(height - mn_sex_height) > (crit * sd_sex_height))
  
  # (1) Identify outliers relative to entire population AND to own group (sex):
  out_1 <- data_out %>%
    filter(out_height & out_sex_height)
  out_1
  
  # (2) Identify people (men and women) who are _not_ outliers relative to the entire population
  #     but _are_ outliers relative to their own sex.
  #     (As men are taller than women on average, these are tall women and small men). 
  out_2 <- data_out %>%
    filter(!out_height & out_sex_height)
  out_2
  
  
  ## Visualizations: -----
  
  # (a) All data: 
  # ?geom_density
  
  p <- ggplot(data) +
    geom_density(aes(x = height), fill = "forestgreen", alpha = 2/3) +
    geom_density(aes(x = height, fill = factor(sex)), alpha = 1/4) +
    theme_bw()
  
  p <- ggplot(data) +
    facet_wrap(~sex) + 
    geom_histogram(aes(x = height, binwidth = 10, fill = factor(sex)), alpha = 1/4) +
    #geom_histogram(aes(x = height), binwidh = 10, fill = "forestgreen", alpha = 2/3) +
    theme_bw()
  
  ## (b) 2 types of outliers:
  ggplot(out_1, aes(x = sex, y = height, color = sex)) +
    geom_violin() + 
    geom_jitter()
  
  ggplot(out_2, aes(x = sex, y = height, color = sex)) +
    geom_violin() + 
    geom_jitter()
  
}

## ------
## eof.