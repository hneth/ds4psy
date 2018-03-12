## r4ds: Chapter 5: Data transformation 
## Code for http://r4ds.had.co.nz/5_data_transformation.html 
## hn spds uni.kn
## 2018 03 12 ------


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


## 5.1.3 dplyr basics ------

# In this chapter you are going to learn the five key dplyr functions that allow you 
# to solve the vast majority of your data manipulation challenges:
  
# 1. Pick observations by their values (filter()).
# 2. Reorder the rows (arrange()).
# 3. Pick variables by their names (select()).
# 4. Create new variables with functions of existing variables (mutate()).
# 5. Collapse many values down to a single summary (summarise()).

# These can all be used in conjunction with group_by() which changes the 
# scope of each function from operating on the entire dataset to operating 
# on it group-by-group. 
# These six functions provide the verbs for a language of data manipulation:

# All verbs work similarly:
# 
# - The first argument is a data frame.
# - The subsequent arguments describe what to do with the data frame, 
#   using the variable names (without quotes).
# - The result is a new data frame.





## 5.2 Filter rows with filter() ------

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

# 1. How could you use arrange() to sort all missing values to the start? (Hint: use is.na()).

flights
arrange(flights, !is.na(dep_time))

# 2. Sort flights to find the most delayed flights. Find the flights that left earliest.

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
## - Plot the relationship between both (distance and time).

flights
(farthest <- filter(flights, origin == "JFK" & dest == "HNL")) # => 342
mean(farthest$air_time)
table(farthest$carrier)

?airlines
filter(airlines, carrier == "HA")



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

## select vs. rename:

# select() can be used to rename variables, but it’s rarely useful 
# because it drops all of the variables not explicitly mentioned. 
# Instead, use rename(), which is a variant of select() that 
# keeps all the variables that aren’t explicitly mentioned:

?rename

# flights$tailnum
rename(flights, tail_num = "tailnum")

# head(iris)
# rename(iris, petal_length = Petal.Length)


## everything:

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

## Note that you can refer to columns that you’ve just created:
  
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours)

## If you only want to keep the new variables, use transmute():
  
transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours)



## 5.5.1 Useful creation functions

## There are many functions for creating new variables that you can use with
## mutate(). The key property is that the function must be vectorised: it must
## take a vector of values as input, return a vector with the same number of
## values as output.

## 1. Arithmetic operators: +, -, *, /, ^.

## 2. Modular arithmetic: %/% (integer division) and %% (remainder), where 

x <- runif(1, min = 101, max = 1000)
y <- runif(1, min = 1, max = 100)
x == y * (x %/% y) + (x %% y)  ## [test.quest]: explain why OR mc == 0, 1, x, y.

transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100
          )

## Logs: log(), log2(), log10(). 

## Logarithms are an incredibly useful transformation for dealing with data that
## ranges across multiple orders of magnitude. They also convert multiplicative
## relationships to additive, a feature we’ll come back to in modelling.

## All else being equal, use log2() because it’s easy to interpret: 
## A difference of 1 on the log scale corresponds to doubling on the original
## scale and a difference of -1 corresponds to halving.

## 3. Offsets: lead() and lag() allow you to refer to leading or lagging values.

## This allows you to compute running differences (e.g. x - lag(x)) 
## or find when values change (x != lag(x)). 
## They are most useful in conjunction with group_by(), which you’ll learn about
## shortly.

(x <- 1:10)

lag(x)  # value before current value
lead(x) # value behind current value

## 4. Cumulative and rolling aggregates: 

## R provides functions for running sums, products, mins and maxes: 
## cumsum(), cumprod(), cummin(), cummax(); and dplyr provides cummean() for
## cumulative means. 

## If you need rolling aggregates (i.e. a sum computed over a rolling window),
## try the RcppRoll package.

x
cumsum(x)
cummean(x)

## 5. Logical comparisons: <, <=, >, >=, != 

## 6. Ranking: 

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

## summarise() is not terribly useful unless we pair it with group_by(). 
## This changes the unit of analysis from the complete dataset to individual groups. 
## Then, when you use the dplyr verbs on a grouped data frame they’ll be
## automatically applied “by group”.  For example, if we applied exactly the same
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
  geom_smooth(se = FALSE)

## Together group_by() and summarise() provide one of the tools that we’ll use
## most commonly when working with dplyr: grouped summaries.

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

delay <- filter(delay, count > 20, dest != "HNL")  # filter to rare points and outlier HNL

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


## 5.6.2 Missing values ----- 

## All aggregation functions have an na.rm argument 
## which removes the missing values prior to computation:

flights %>% 
  group_by(year, month, day) %>% 
  summarise(count = n(),
            mean = mean(dep_delay))

## => yields many missing values (as mean of any set of values containing NA returns NA). 

flights %>% 
  group_by(year, month, day) %>% 
  summarise(count = n(),                            # count n (including NAs)
            n_is_NA = sum(is.na(dep_delay)),        # count n of NAs
            n_not_NA = sum(!is.na(dep_delay)),      # count n of non-NAs
            mean = mean(dep_delay, na.rm = TRUE)    # mean of dep_delay that are not NA
            )

## Note that count is the same in both cases. How to count number of NAs?

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
## count (n()), or a count of non-missing values (sum(!is.na(x))).

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

## The story is actually a little more nuanced ----

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

## Characteristic shape: variation decreases as the sample size increases. 

## filter out the groups with the smallest numbers of observations:

delays %>% 
  filter(n > 20) %>% 
  ggplot(mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10) +
  theme_light()

## RStudio tip: a useful keyboard shortcut is Cmd/Ctrl + Shift + P. 
## This resends the previously sent chunk from the editor to the console. This
## is very convenient when you’re (e.g.) exploring the value of n in the example
## above.

## A common variation of this type of pattern: ----

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
# opportunities to hit the ball (ab).  
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