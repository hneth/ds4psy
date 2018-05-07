## r4ds: Chapter 16: 
## Code for http://r4ds.had.co.nz/dates-and-times.html  
## hn spds uni.kn
## 2018 05 07 ------

## [see Book chapter 1x: "..."]


## 16.1 Introduction ------

## 16.1.1 Prerequisites 

# This chapter will focus on the lubridate package. 
# lubridate is not part of the core tidyverse, so we need to load it explicitly:

library(tidyverse)
library(lubridate)

library(nycflights13) # data

## 16.2 Creating date/times ------ 

# In this chapter we are only going to focus on dates and date-times as R
# doesn’t have a native class for storing times. If you need one, you can use
# the hms package.

# You should always use the simplest possible data type that works for your
# needs. That means if you can use a date instead of a date-time, you should.
# Date-times are substantially more complicated because of the need to handle
# time zones, which we’ll come back to at the end of the chapter.

today() # current date
now()   # current date and time

# There are three types of date/time data that refer to an instant in time:

# 1. A date. 
#    Tibbles print this as <date>.

# 2. A time within a day. 
#    Tibbles print this as <time>.

# 3. A date-time is a date plus a time: 
#    it uniquely identifies an instant in time 
#    (typically to the nearest second). 
#    Tibbles print this as <dttm>. 
#    Elsewhere in R these are called POSIXct, 
#    but that’s not a very useful name.

# But note: 
typeof(flights$time_hour) # => "double"
typeof(today())           # => "double"
typeof(now())             # => "double"


# Typically, here are 3 ways we’re likely to create a date/time:
  
# 1. From a string.
# 2. From individual date-time components.
# 3. From an existing date/time object.

# They work as follows:

## 16.2.1 From strings (denoting ymd hms) ----- 

# (1) readr: ---- 

# In chapter 11 (on data import using readr) we encountered
# - readr::parse_date()
# - readr::parse_time()
# - readr::parse_datetime()

# See http://r4ds.had.co.nz/data-import.html#readr-datetimes
# e.g., 
readr::parse_datetime(flights$time_hour)

# (2) lubridate: ---- 

# Alternatively, use the helpers provided by lubridate:

## (a) Creating dates: 

ymd("2018-01-31")
mdy("January 31st, 2018")
dmy("31-Jan-2018")
dmy("31. Jan. 2018")

# These functions also take unquoted numbers. 
# This is the most concise way to create a single date/time object, 
# as you might need when filtering date/time data. 
# ymd() is short and unambiguous:
  
ymd(20180131)

# ymd() and friends create dates. 

## (b) Creating date-time:

# To create a date-time, add an underscore 
# and one or more of “h”, “m”, and “s” 
# to the name of the parsing function:
  
ymd_hms("2018-01-31 23:53:57")
mdy_hm("01/31/2018 09:22")

# You can also force the creation of a date-time from a date by supplying a timezone:
  
ymd(20170131, tz = "UTC")


## 16.2.2 From individual components (multiple variables) -----

# Instead of a single string, we often have the individual components 
# of the date-time spread across multiple columns. 
# This is what we have in the flights data:
  
flights %>% 
  select(year, month, day, hour, minute)

# To create a date/time from this sort of input, use 
# - make_date() for dates, or 
# - make_datetime() for date-times:

flights %>% 
  select(year, month, day, hour, minute) %>% 
  mutate(cur_date = make_date(year, month, day), 
         departure = make_datetime(year, month, day, hour, minute))


# Example: 
# Let’s do the same thing for each of the 4 time columns in flights: 

# The times are represented in a slightly odd format, 
# so we use modulus arithmetic to pull out the hour and minute components. 

# Once we’ve created the date-time variables, 
# we focus in on the variables we’ll explore in the rest of the chapter.

make_datetime_100 <- function(year, month, day, time) {
  make_datetime(year, month, day, time %/% 100, time %% 100)
}

flights_dt <- flights %>% 
  filter(!is.na(dep_time), !is.na(arr_time)) %>% 
  mutate(
    dep_time = make_datetime_100(year, month, day, dep_time),
    arr_time = make_datetime_100(year, month, day, arr_time),
    sched_dep_time = make_datetime_100(year, month, day, sched_dep_time),
    sched_arr_time = make_datetime_100(year, month, day, sched_arr_time)
  ) %>% 
  select(origin, dest, ends_with("time"), ends_with("delay"))

flights_dt

# With this data, we can visualise the distribution 
# of departure times across the year:

sec_per_day <- 60 * 60 * 24
sec_per_day # => 86400 

flights_dt %>% 
  ggplot(aes(dep_time)) + 
  geom_freqpoly(binwidth = 86400) # 86400 seconds = 1 day

# Or within a single day:
  
flights_dt %>% 
  filter(dep_time < ymd(20130102)) %>% 
  ggplot(aes(dep_time)) + 
  geom_freqpoly(binwidth = 60 * 10) # 600 seconds = 10 minutes

## Some particular date: 
# dt <- flights_dt$dep_time[10000]
# as_date(dt) # yields the date of some date-time dt

flights_dt %>% 
  filter(as_date(dep_time) == ymd(20130713)) %>% 
  ggplot(aes(dep_time)) + 
  geom_freqpoly(binwidth = 60 * 10) # 600 seconds = 10 minutes

# Note that when you use date-times in a numeric context (like in a histogram), 
# 1 means 1 second, so a binwidth of 86400 means one day. 
# For dates, 1 means 1 day.


## 16.2.3 From other types (switching between date and date-time) ----- 

# To switch between a date-time and a date, we can use 
# as_datetime() and as_date():

as_datetime(today()) # => the date & time zone (as no time is given)
as_datetime(now())   # => the date & time & time zone (as time given)

as_date(now())   # => only the date
as_date(today()) # => the same date

# Sometimes we'll get date/times as numeric offsets 
# from the “Unix Epoch”, 1970-01-01. 
# If the offset is 
# - in seconds, use as_datetime(); 
# - if it’s in days, use as_date():

as_datetime((60 * 60 * 24 * 3) + (60 * 60 * 10)) # 3 days + 10 hours
# "1970-01-04 10:00:00 UTC"

as_date((365 * 10 + 2)) # 10 years (+ 2 leap years!) later


## 16.2.4 Exercises ----- 

# 1. What happens if you parse a string that contains invalid dates?
  
ymd(c("2010-10-10", "bananas", "2018/05/21"))

# The 2nd string fails to parse and yields NA, 
# but the others are correctly parsed into dates.

# 2. What does the tzone argument to today() do? 
#    Why is it important?

# ?today()

# tzone	takes a character vector specifying which time zone we would like to
# find the current date of. 
# Defaults to the system time zone set on our computer.
Sys.timezone()

today()
today(tzone = "GMT")
today() == today("GMT") # not always true

# 3. Use the appropriate lubridate function 
#    to parse each of the following dates:

d1 <- "January 1, 2010"
d2 <- "2015-Mar-07"
d3 <- "06-Jun-2017"
d4 <- c("August 19 (2015)", "July 1 (2015)")
d5 <- "12/30/14" # Dec 30, 2014

mdy(d1)
ymd(d2)
dmy(d3)
mdy(d4)
mdy(d5)


## 16.3 Date-time components ------ 

# Now that you know how to get date-time data into R’s date-time data structures, 
# let’s explore what we can do with them. 
# 1. Accessor functions that let us get and set individual components. 
# 2. Arithmetic with date-times.


## 16.3.1 Getting components ----- 

# We can pull out individual parts of the date with 8 accessor functions: 
# year(), month(), 
# mday() (day of the month), yday() (day of the year), wday() (day of the week), 
# hour(), minute(), and second().

datetime <- ymd_hms("2018-01-31 10:58:56")

year(datetime)
month(datetime)
mday(datetime)
yday(datetime)
wday(datetime)
hour(datetime)
minute(datetime)

# For month() and wday() we can set label = TRUE 
# to return the abbreviated name of the month or day of the week. 
# By contrast, abbr = FALSE returns the full name:

month(datetime) # => numeric
month(datetime, label = TRUE, abbr = TRUE)  # short label
month(datetime, label = TRUE, abbr = FALSE) # long label

wday(datetime) # => numeric
wday(datetime, label = TRUE, abbr = TRUE)   # short label
wday(datetime, label = TRUE, abbr = FALSE)  # long label


## Examples: ----

# (1) wday: 
# We can use wday() to see that more flights depart 
# during the week than on the weekend:
  
flights_dt %>% 
  mutate(wday = wday(dep_time, label = TRUE)) %>%  # get wday from dep_time
  ggplot(aes(x = wday)) +
  geom_bar(aes(fill = wday))

# (2) minute:
# There’s an interesting pattern if we look at the average departure delay 
# by minute within the hour. 
# It looks like flights leaving in minutes 20-30 and 50-60 have much lower delays 
# than the rest of the hour!
  
dp_tm_min <- flights_dt %>% 
  mutate(minute = minute(dep_time)) %>% 
  group_by(minute) %>% 
  summarise(
    mn_dep_delay = mean(dep_delay, na.rm = TRUE),
    mn_arr_delay = mean(arr_delay, na.rm = TRUE),
    n = n())
dp_tm_min

ggplot(dp_tm_min, aes(x = minute)) +
    geom_line(aes(y = mn_dep_delay), color = "green3") +
    geom_line(aes(y = mn_arr_delay), color = "red3")


# Interestingly, if we look at the _scheduled_ departure time 
# we don’t see such a strong pattern:
  
sched_dp_tm_min <- flights_dt %>% 
  mutate(minute = minute(sched_dep_time)) %>% 
  group_by(minute) %>% 
  summarise(
    mn_dep_delay = mean(dep_delay, na.rm = TRUE),
    mn_arr_delay = mean(arr_delay, na.rm = TRUE),
    n = n())
sched_dp_tm_min

ggplot(sched_dp_tm_min, aes(x = minute)) +
  geom_line(aes(y = mn_dep_delay), color = "green3") +
  geom_line(aes(y = mn_arr_delay), color = "red3")

# So why do we see that pattern with the _actual_ departure times? 
# Well, like much data collected by humans, there’s a strong bias 
# towards flights leaving at “nice” departure times. 
# Always be alert for this sort of pattern whenever 
# you work with data that involves human judgement!

# Frequency of scheduled departure times:
ggplot(sched_dp_tm_min, aes(minute, n)) +
  geom_line()

# Contrast this with the frequency of actual departure times:
ggplot(dp_tm_min, aes(minute, n)) +
  geom_line()


## 16.3.2 Rounding ----- 

# An alternative approach to plotting individual components 
# is to round the date to a nearby unit of time, with 
# - floor_date(), 
# - round_date(), and 
# - ceiling_date(). 

# Each function takes 
# - a vector of dates to adjust and then 
# - the name of the unit round down (floor), round up (ceiling), or round to. 

# This, for example, allows us to plot the number of flights per week:
  
flights_dt %>% 
  count(week = floor_date(dep_time, "week")) %>% 
  ggplot(aes(week, n)) +
  geom_line()

# Computing the difference between a rounded and unrounded date 
# can be particularly useful.


## 16.3.3 Setting components ----- 

## (1) Setting year/month/hour: ----

# We can also use each accessor function to set the components of a date/time:
  
(datetime <- ymd_hms("2016-07-08 12:34:56"))
#> [1] "2016-07-08 12:34:56 UTC"

year(datetime) <- 2020  # set year of datetime
datetime
#> [1] "2020-07-08 12:34:56 UTC"

month(datetime) <- 01  # set month of datetime
datetime
#> [1] "2020-01-08 12:34:56 UTC"

hour(datetime) <- hour(datetime) + 1  # increment hour of datetime
datetime 
#> [1] "2020-01-08 13:34:56 UTC"

# (2) update: ---- 
# Alternatively, rather than modifying in place, 
# we can create a new date-time with update(). 

# This also allows us to set multiple values at once: 
update(datetime, year = 2020, month = 2, mday = 2, hour = 2)
#> [1] "2020-02-02 02:34:56 UTC"

# If values are too big, they will roll-over:
  
ymd("2015-02-01") %>% 
  update(mday = 30)
#> [1] "2015-03-02"

ymd("2015-02-01") %>% 
  update(hour = 25)
#> [1] "2015-02-02 01:00:00 UTC"

# We can use update() to show the distribution of flights 
# across the course of the day for every day of the year:

flights_dt %>% 
  mutate(dep_hour = update(dep_time, yday = 1)) %>% 
  ggplot(aes(dep_hour)) +
  geom_freqpoly(binwidth = 300)

# Setting larger components of a date to a constant 
# is a powerful technique that allows us to explore 
# patterns in the smaller components.


## 16.3.4 Exercises -----

# 1. How does the distribution of flight times within a day 
#    change over the course of the year?

flights_dt

dep_time_month <- flights_dt %>%
  filter(!is.na(dep_time)) %>%
  mutate(month = month(dep_time)) %>%
  group_by(month) %>%
  mutate(hour = hour(dep_time)) %>%
  group_by(month, hour) %>%
  summarize(n = n())
#  dep_time_month

ggplot(dep_time_month, aes(x = hour, y = n)) +
  facet_wrap(~month) + 
  geom_line(aes(color = month))

# From
# https://jrnold.github.io/r4ds-exercise-solutions/dates-and-times.html#date-time-components 

flights_dt %>%
  mutate(time = hour(dep_time) * 100 + minute(dep_time),
         month = as.factor(month(dep_time))) %>%
  ggplot(aes(x = time, group = month, color = month)) +
  geom_freqpoly(binwidth = 100)

# 2. Compare dep_time, sched_dep_time and dep_delay. 
#    Are they consistent? Explain your findings.

del_dif <- flights_dt %>%
  mutate(ad_t_h = hour(dep_time),   # actual departure time hour
         ad_t_m = minute(dep_time),
         sd_t_h = hour(sched_dep_time),   # scheduled departure time hour
         sd_t_m = minute(sched_dep_time),
         my_dep_delay = (((ad_t_h * 60) + ad_t_m) - ((sd_t_h * 60) + sd_t_m)), 
         delay_diff = my_dep_delay - dep_delay
         ) %>%
  select(ad_t_h, ad_t_m, dep_time, sd_t_h, sd_t_m, sched_dep_time, my_dep_delay, dep_delay, delay_diff) %>%
  filter(delay_diff != 0)

del_dif # 1234 flights with discrepancies.
unique(del_dif$delay_diff) # All delay_diff values are -1440

# Note: 
60*24 # 1440 (i.e., 24 hours are 1440 minutes).
# => Flights that were delayed to the next day;
#    For these flights, the departure _dates_ are erroneous, as they should be incremented to the next day.   
#    However, the values of the dep_delay variable are correct!

ggplot(del_dif, aes(dep_delay, my_dep_delay)) +
  geom_abline(intercept = -(24*60), slope = 1, linetype = 2, color = "green3") +  # y = x - 1440
  geom_point(alpha = 1/3) +
  theme_bw()

## Shorter solution from
# https://jrnold.github.io/r4ds-exercise-solutions/dates-and-times.html#exercise-2-46 

# If they are consistent, then dep_time = sched_dep_time + dep_delay.

flights_dt %>%
  mutate(dep_time_2 = sched_dep_time + dep_delay * 60) %>%
  filter(dep_time_2 != dep_time) %>%
  select(dep_time_2, dep_time, sched_dep_time, dep_delay)

# There exist discrepancies. It looks like there are mistakes in the dates.
# These are flights in which the actual departure time is on the next day
# relative to the scheduled departure time. 

# We forgot to account for this when creating the date-times. The code would
# have had to check if the departure time is BEFORE the scheduled departure
# time (by an unreasonable amount). 

# Alternatively, simply adding the delay time to the scheduled departure time 
# is more robust because it will automatically account for crossing into the next day.

# 3. Compare air_time with the duration between the departure and arrival.
#    Explain your findings. (Hint: Consider the location of the airport.)

at <- flights_dt %>%
  mutate(air_time_2 = arr_time - dep_time,
         air_time_3 = sched_arr_time - sched_dep_time,
         diff = air_time_2 - air_time) %>%
  select(origin, dest, dep_time, arr_time, air_time_2, air_time_3, air_time, diff) 
at

ggplot(at, aes(x = air_time, y = air_time_2)) +
  geom_point(size = 1/4, alpha = 1/4) + 
  geom_abline(intercept = 0, slope = 1, linetype = 2, color = "green3") +  # y = x
  geom_abline(intercept = -60, slope = 1, linetype = 2, color = "red3") +  # y = x - 60
  geom_abline(intercept = -120, slope = 1, linetype = 2, color = "gold") +  # y = x - 120
  geom_abline(intercept = -180, slope = 1, linetype = 2, color = "steelblue3") +  # y = x - 180
  theme_bw()
# => plot shows clusters at different time zones,
#    and arriving on the next day (with negative diff values).

# 4. How does the average delay time change over the course of a day? 
#    Should you use dep_time or sched_dep_time? Why?

flights_dt %>%
  filter(!is.na(dep_delay)) %>%
  mutate(hour = hour(sched_dep_time)) %>% # use scheduled time, as this does not yet include delay
  group_by(hour) %>%
  summarise(n = n(),
            mn_delay = mean(dep_delay)) %>%
  ggplot(aes(x = hour, y = mn_delay)) +
  geom_point() + 
  geom_line() +
  geom_smooth() + 
  theme_bw()

# Similar solution from 
# https://jrnold.github.io/r4ds-exercise-solutions/dates-and-times.html#exercise-3-34 
# Use sched_dep_time because that is the relevant metric for someone scheduling a flight. 
# Also, using dep_time will always bias delays to later in the day since delays 
# will push flights later.

flights_dt %>%
  mutate(sched_dep_hour = hour(sched_dep_time)) %>%
  group_by(sched_dep_hour) %>%
  summarise(dep_delay = mean(dep_delay)) %>%
  ggplot(aes(y = dep_delay, x = sched_dep_hour)) +
  geom_point() +
  geom_smooth()

# 5. On what day of the week should you leave if you want to minimise the chance of a delay?

## +++ here now +++ ------


# 6. What makes the distribution of diamonds$carat and flights$sched_dep_time similar?
  
# 7. Confirm my hypothesis that the early departures of flights 
#    in minutes 20-30 and 50-60 are caused by scheduled flights 
#    that leave early. 
#    Hint: create a binary variable that tells you whether or not a flight was delayed.




## Appendix ------

## Web:  

# cheatsheets: 
# 

## Documentation: ----- 

# Vignettes of R packages: 

## Related tools:

## Ideas for test questions [test.quest]: ------

## Multiple choice [MC] questions: -----

## Practical questions: ----- 

## ------
## eof.