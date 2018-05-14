## r4ds: Chapter 16: 
## Code for http://r4ds.had.co.nz/dates-and-times.html  
## hn spds uni.kn
## 2018 05 14 ------

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

## (1) readr: ---- 

# In chapter 11 (on data import using readr) we encountered
# - readr::parse_date()
# - readr::parse_time()
# - readr::parse_datetime()

# See http://r4ds.had.co.nz/data-import.html#readr-datetimes
# e.g., 
readr::parse_datetime(flights$time_hour)

## (2) lubridate: ---- 

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

## (2) update: ---- 
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

wd <- flights_dt %>%
  # filter(!is.na(dep_delay), !is.na(arr_delay)) %>%
  mutate(day = wday(sched_dep_time, label = FALSE)) %>%  # treat day as numeric (continuous) variable
  group_by(day) %>%
  summarise(n = n(),
            dep_delay = mean(dep_delay, na.rm = TRUE),
            arr_delay = mean(arr_delay, na.rm = TRUE))
wd
# => Answer: Day 7 (=Saturday!) has the lowest (departure and arrival) delays

ggplot(wd, aes(x = day)) +
  geom_point(aes(y = dep_delay), color = "steelblue") +
  # geom_line(aes(y = dep_delay), color = "steelblue") + 
  geom_smooth(aes(y = dep_delay),  color = "steelblue", fill = "skyblue") + 
  geom_point(aes(y = arr_delay), color = "forestgreen") +
  # geom_line(aes(y = arr_delay), color = "forestgreen") + 
  geom_smooth(aes(y = arr_delay), color = "forestgreen", fill = "green1") +
  # scale_x_continuous() + 
  theme_bw()

# Note that solution of 
# https://jrnold.github.io/r4ds-exercise-solutions/dates-and-times.html#exercise-5-14 
# is wrong: Day 7 in this data denotes Saturday, not Sunday!

# 6. What makes the distribution of diamonds$carat and flights$sched_dep_time similar?

# Distribution of diamonds$carat:
ds <- filter(diamonds, carat < 3.1)
ggplot(ds, aes(x = carat)) + 
  geom_histogram(binwidth = .025, color = "grey50", fill = "gold") + 
  # geom_freqpoly(binwidth = .025, color = "steelblue", size = 1.0) + 
  theme_bw()

# Distribution of flights$sched_dep_time:
# flights
ggplot(flights, aes(x = sched_dep_time)) +
  geom_histogram(binwidth = 25, color = "grey50", fill = "gold") + 
  # geom_freqpoly(binwidth = 25, color = "steelblue", size = 1.0) + 
  scale_x_continuous(breaks = seq(0, 2400, by = 100), labels = seq(0, 2400, by = 100)) +
  theme_bw()

# Zooming in at bottom (with coord_cartesian): 
ggplot(flights, aes(x = sched_dep_time)) +
  geom_histogram(binwidth = 25, color = "grey50", fill = "gold") + 
  # geom_freqpoly(binwidth = 25, color = "steelblue", size = 1.0) + 
  scale_x_continuous(breaks = seq(0, 2400, by = 100), labels = seq(0, 2400, by = 100)) +
  coord_cartesian(ylim = c(0, 100)) + 
  theme_bw()

# Answer: Both patterns seem to be based on a human preference for nice (round) numbers
#         (and a corresponding mechanism to manipulate the measurements).

# 7. Confirm my hypothesis that the early departures of flights 
#    in minutes 20-30 and 50-60 are caused by scheduled flights 
#    that leave early. 
#    Hint: create a binary variable that tells you whether or not a flight was delayed.

# Phenomenon:

flights_dt %>% 
  mutate(minute = minute(dep_time)) %>% 
  group_by(minute) %>% 
  summarise(
    avg_delay = mean(arr_delay, na.rm = TRUE),
    n = n()) %>% 
  ggplot(aes(minute, avg_delay)) +
  geom_line(size = 1, color = "steelblue") + 
  scale_x_continuous(breaks = seq(0, 60, by = 10), labels = seq(0, 60, by = 10)) +
  theme_bw()

# => Average delay of flights is much lower in minutes 20-30 and 50-60.

# Hypothesis: The lower delays are due to scheduled flights leaving early.

# Check 1: Are there fewer or more flights leaving in minutes 20-30 and 50-60?

flights_dt %>% 
  mutate(minute = minute(dep_time)) %>% # minute of actual sched_dep_time 
  group_by(minute) %>% 
  summarise(
    avg_delay = mean(arr_delay, na.rm = TRUE),
    n = n()) %>% 
  ggplot(aes(minute, n)) +
  geom_line(size = 1, color = "steelblue") + 
  geom_point(shape = 21, size = 2, fill = "orange") +
  scale_x_continuous(breaks = seq(0, 60, by = 10), labels = seq(0, 60, by = 10)) +
  theme_bw()

# => There are _more_ flights leaving in these time periods.

# Check 2: What about _scheduled_ flight times?  
#          Are there more or fewer in these periods?
flights_dt %>% 
  mutate(minute = minute(sched_dep_time)) %>%  # minute of sched_dep_time 
  group_by(minute) %>% 
  summarise(
    avg_delay = mean(arr_delay, na.rm = TRUE),
    n = n()) %>% 
  ggplot(aes(minute, n)) +
  geom_line(size = 1, color = "steelblue") + 
  geom_point(shape = 21, size = 2, fill = "orange") +
  scale_x_continuous(breaks = seq(0, 60, by = 10), labels = seq(0, 60, by = 10)) +
  theme_bw()

# => Peaks of scheduled flight frequencies around minutes of 30 and 0/60.

# Both checks support the hypothesis (but do not prove anything yet). 

# To test it, let's distinguish between delayed and non-delayed flights,
#             as well as early vs. non-early flights:
fdt <- flights_dt %>%
  mutate(delay = (dep_time > sched_dep_time),
         early = (dep_time < sched_dep_time)) %>%
  select(early, delay, everything())

# Note: We could add a tolerance threshold dt (e.g., 2 mins) 
#       before judging a flight to be delayed or early.
fdt

# Frequency of _early_ flights by minute of sched_dep_time:
fdt %>% 
  filter(early == TRUE) %>%  # considering ONLY early flights:
  mutate(minute = minute(sched_dep_time)) %>%  # minute of sched_dep_time 
  group_by(minute) %>% 
  summarise(
    avg_delay = mean(arr_delay, na.rm = TRUE),
    n = n()) %>% 
  ggplot(aes(minute, n)) +
  geom_line(size = 1, color = "steelblue") + 
  geom_point(shape = 21, size = 2, fill = "orange") +
  scale_x_continuous(breaks = seq(0, 60, by = 10), labels = seq(0, 60, by = 10)) +
  theme_bw()

# Frequency of _early_ flights by minute of actual dep_time:
fdt %>% 
  filter(early == TRUE) %>%  # considering ONLY early flights:
  mutate(minute = minute(dep_time)) %>%  # minute of actual dep_time 
  group_by(minute) %>% 
  summarise(
    avg_delay = mean(arr_delay, na.rm = TRUE),
    n = n()) %>% 
  ggplot(aes(minute, n)) +
  geom_line(size = 1, color = "steelblue") + 
  geom_point(shape = 21, size = 2, fill = "orange") +
  scale_x_continuous(breaks = seq(0, 60, by = 10), labels = seq(0, 60, by = 10)) +
  theme_bw()

# Result: Both graphs of the frequency of _early_ flights by minute 
#         show that many flights scheduled to depart at round times (30 and 60) 
#         are departing earlier then scheduled, qed.



## 16.4 Time spans ------ 

# Addressing arithmetic with dates (i.e., subtraction, addition, and division). 

# There are 3 important classes representing time spans:
# 1. durations, which represent an exact number of seconds between 2 time points.
# 2. periods,   which represent human units like weeks and months.
# 3. intervals, which represent a starting and ending point.

# Excerpt from http://lubridate.tidyverse.org/ : 
# Lubridate expands the type of mathematical operations 
# that can be performed with date-time objects. 
# 
# It introduces 3 time span classes (borrowed from http://joda.org):
# 
# 1. durations, which measure the exact amount of time between two points
# 2. periods, which accurately track clock times despite leap years, 
#    leap seconds, and day light savings time
# 3. intervals, a protean summary of the time information between two time points. 



## 16.4.1 Durations -----

# Subtracting 2 dates yields a difftime object:
  
h_age <- today() - ymd(19791014)
h_age <- today() - ymd(19690713)
h_age

# A difftime class object records a time span of 
# seconds, minutes, hours, days, or weeks. 
# This ambiguity can make difftimes a little painful to work with, 
# so lubridate provides an alternative which always uses seconds: 
# the duration.

as.duration(h_age)

# Durations come with a bunch of convenient constructors:
  
dseconds(15)
#> [1] "15s"

dminutes(10)
#> [1] "600s (~10 minutes)"

dhours(c(12, 24))
#> [1] "43200s (~12 hours)" "86400s (~1 days)"

ddays(0:5)
#> [1] "0s"                "86400s (~1 days)"  "172800s (~2 days)"
#> [4] "259200s (~3 days)" "345600s (~4 days)" "432000s (~5 days)"

dweeks(3)
#> [1] "1814400s (~3 weeks)"

dyears(1)
#> [1] "31536000s (~52.14 weeks)"

# Durations always record the time span in seconds. 
# Larger units are created by converting minutes, hours, days, weeks, and years 
# to seconds at the standard rate (60 seconds in a minute, 60 minutes in an hour, 
# 24 hours in day, 7 days in a week, 365 days in a year).

# We can add and multiply durations:

2 * dyears(1)
#> [1] "63072000s (~2 years)"

dyears(1) + dweeks(12) + dhours(15)
#> [1] "38847600s (~1.23 years)"

# We can add and subtract durations to and from days:
tomorrow <- today() + ddays(1)
tomorrow

last_year <- today() - dyears(1)
last_year

# However, because durations represent an exact number of seconds, 
# sometimes we might get an unexpected result:
  
one_pm <- ymd_hms("2016-03-12 13:00:00", tz = "America/New_York")
one_pm
#> [1] "2016-03-12 13:00:00 EST"

one_pm + ddays(1)
#> [1] "2016-03-13 14:00:00 EDT" 

# Why is one day after 1pm on March 12, 2pm on March 13?! 

# If we look carefully at the date we might also notice 
# that the time zones have changed. 
# Because of switching to daylight saving time (DST), 
# March 12 only has 23 hours, so if add a full days worth of seconds 
# we end up with a different time.


## 16.4.2 Periods -----

# To solve this problem, lubridate provides periods. 
# Periods are time spans but don’t have a fixed length in seconds, 
# instead they work with “human” times, like days and months. 
# That allows them work in a more intuitive way:

one_pm
#> [1] "2016-03-12 13:00:00 EST"

one_pm + days(1)
#> [1] "2016-03-13 13:00:00 EDT"

# Like durations, periods can be created with a number of friendly 
# constructor functions:

seconds(15)
#> [1] "15S"

minutes(10)
#> [1] "10M 0S"

hours(c(12, 24))
#> [1] "12H 0M 0S" "24H 0M 0S"

days(7)
#> [1] "7d 0H 0M 0S"

months(1:6)
#> [1] "1m 0d 0H 0M 0S" "2m 0d 0H 0M 0S" "3m 0d 0H 0M 0S" "4m 0d 0H 0M 0S"
#> [5] "5m 0d 0H 0M 0S" "6m 0d 0H 0M 0S"

weeks(3)
#> [1] "21d 0H 0M 0S"

years(1)
#> [1] "1y 0m 0d 0H 0M 0S"

# We can add and multiply periods:

10 * (months(6) + days(1))
#> [1] "60m 10d 0H 0M 0S"

days(50) + hours(25) + minutes(2)
#> [1] "50d 25H 2M 0S"

# And of course, we can add periods to dates. 
# Compared to durations, periods are more likely to do what we expect:
  
# A leap year:
ymd("2016-01-01") + dyears(1)
#> [1] "2016-12-31"          (i.e., still 2016!)

ymd("2016-01-01") + years(1)
#> [1] "2017-01-01" (same date in the next year)

# Switching to Daylight Savings Time:
one_pm + ddays(1)
#> [1] "2016-03-13 14:00:00 EDT"  (i.e., exactly 24 hours later)

one_pm + days(1)
#> [1] "2016-03-13 13:00:00 EDT" (i.e., same time on next day)


# Example:
# Let’s use periods to fix an oddity related to our flight dates. 
# Some planes appear to have arrived at their destination 
# before they departed from New York City:

flights_dt %>% 
  filter(arr_time < dep_time) 

# These are overnight flights. 
# Above, we used the same date information for setting 
# both the departure and the arrival times, but these flights 
# arrived on the following day. 

# We can fix this by adding days(1) to the arrival time of each overnight flight: 
flights_dt_2 <- flights_dt %>% 
  mutate(
    overnight = arr_time < dep_time,            # Boolean variable      
    arr_time = arr_time + days(overnight * 1),  # Using overnight as 0 vs. 1! (See Exercise 2 below).
    sched_arr_time = sched_arr_time + days(overnight * 1) # Using overnight as 0 vs. 1!
  )
flights_dt_2


# View overnight flights and check corresponding dates: 
flights_dt_2 %>%
  filter(overnight == TRUE) %>%
  select(dep_time, arr_time, overnight, everything())

# Now all of our flights obey the laws of physics: 
flights_dt_2 %>% 
  filter(overnight, arr_time < dep_time) 


# 16.4.3 Intervals -----

# 1) using durations:
# It’s obvious what dyears(1) / ddays(365) should return: 
dyears(1) / ddays(365)

# one, because durations are always represented by a number of seconds, 
# and a duration of a year is defined as 365 days worth of seconds.

# 2) using periods:
# What should years(1) / days(1) return? 
# This depends on whether we mean a regular or a leap year: 
# - If the year was 2015 it should return 365, 
# - but if it was 2016, it should return 366! 
# There’s not quite enough information for lubridate to give a single clear answer. 
# What it does instead is give an estimate, with a warning:
  
years(1) / days(1)

# If we want a more accurate measurement, we have to use an interval. 

# An interval is a duration with a starting point: 
# that makes it precise so we can determine exactly how long it is:
  
next_year <- today() + years(1)
(today() %--% next_year) / ddays(1)

# To find out how many periods fall into an interval, 
# we need to use integer division:
  
(today() %--% next_year) %/% days(1)

## 16.4.4 Summary ----- 

# How to pick between duration, periods, and intervals? 

# As always, we pick the simplest data structure that solves our problem. 
# - use duration if we only care about physical time; 
# - use period if we need to add human times; 
# - use interval if we need to if figure out how long a span is in human units.

# Figure 16.1 summarises permitted arithmetic operations between the different data types:
# http://r4ds.had.co.nz/dates-and-times.html#fig:dt-algebra


## 16.4.5 Exercises -----

# 1. Why is there months() but no dmonths()?

months(2)  # is a period
# dmonths(2) # would be a duration (in seconds). 
# However, this varies between months (i.e., is specific for every month 
# and even -- for the month of February -- on the year being regular vs. a leap year). 

# 2. Explain days(overnight * 1) to someone who has just started learning R. 
#    How does it work?

# - overnight is computed as a Boolean/logical variable (TRUE vs. FALSE)
# - when calculating with Booleans, TRUE becomes 1 and FALSE becomes 1.
# - thus, days(overnight * 1) is days(0) for overnight being FALSE and 
#                                days(1) for overnight being TRUE. 

# 3. a. Create a vector of dates giving the first day of every month in 2015. 
#    b. Create a vector of dates giving the first day of every month in the current year.

# a. Let's use intervals, as we want human time spans (months) of specific years:
firsts_2015 <- ymd(150101) + months(0:11)

# b. This is tricky: 
cur_year <- year(today())  # gets the current year:
cur_year  # but NOT January 1st.

# Idea: Round today() to the floor of year: 
cur_jan1 <- floor_date(today(), unit = "year") # rounds today's date to the floor of the year (i.e., January 1st)
cur_jan1

firsts_cur <- cur_jan1 + months(0:11)
firsts_cur

# [test.quest]: 
# - Analogously: Getting the first of the current month:
cur_month_1st <- floor_date(today(), unit = "month")
cur_month_1st

# - Getting the weekday of some particular date:
wday(cur_month_1st, label = TRUE)


# 4. Write a function that given your birthday (as a date), 
#    returns how old you are in years.

## (a) complicated solution: 
bday <- ymd(690713)

get_age <- function(bday, tday = today()) {
  
  # Components of birthday: 
  bday_year <- year(bday)
  bday_month <- month(bday)
  bday_mday  <- mday(bday)
  
  # Current year and birthday in current year: 
  cur_year <- year(tday) 
  cur_jan1 <- floor_date(today(), unit = "year") # rounds today's date to the floor of the year (i.e., January 1st)
  # cur_jan1
  
  bday_cur_year <- cur_jan1 + months(bday_month - 1) + days(bday_mday - 1)
  # bday_cur_year
  
  # Compute age:
  if (tday < bday_cur_year) { # no birthday this year yet: 
    age <- (cur_year - bday_year - 1) 
  } else { # including birthday for current year:  
    age <- (cur_year - bday_year)
  }
  
  return(age)
  
}

# Checks: 
get_age(bday)

# with different tday dates:
get_age(bday, tday = ymd(180101)) # before birthday this year
get_age(bday, tday = ymd(180713)) # on birthday this year
get_age(bday, tday = ymd(181231)) # after birthday this year


## (b) Shorter (and more elegant) version:

## Note that: 
bday %--% today() # yields a valid interval

my_age <- function(bday) {
  
  lifetime <- (bday %--% today()) # interval from bday to today() 
  (lifetime %/% years(1))         # integer division (into full years)

}
my_age(bday)


# 5. Why can’t (today() %--% (today() + years(1)) / months(1) work?

# The only problem appears to be the initial parenthesis "(". 
# When dropping the initial "(" it appears to work:             
today() %--% (today() + years(1)) / months(1)
# => 12

# It also works when closing the parentheses after the interval: 
(today() %--% (today() + years(1))) / months(1)
# => 12

# Note that 
today()  # is a valid date, 
years(1) # is a valid period, 
today() %--% (today() + years(1)) # is a valid interval, 
months(1) # is a valid period, 
# and intervals can be divided by periods:
today() %--% (today() + years(1)) / months(1)
# => 12



## 16.5 Time zones ------ 
## http://r4ds.had.co.nz/dates-and-times.html#time-zones 

# Time zones are an enormously complicated topic because of their interaction
# with geopolitical entities. Fortunately we don’t need to dig into all the
# details as they’re not all important for data analysis, but there are a few
# challenges we’ll need to tackle head on.

# The first challenge is that everyday names of time zones tend to be ambiguous.
# For example, if you’re American you’re probably familiar with EST, or Eastern
# Standard Time. However, both Australia and Canada also have EST! 

# To avoid confusion, R uses the international standard IANA time zones. These
# use a consistent naming scheme “/”, typically in the form “<continent>/<city>”
# (there are a few exceptions because not every country lies on a continent).
# Examples include “America/New_York”, “Europe/Paris”, and “Pacific/Auckland”.

# You might wonder why the time zone uses a city, when typically you think of
# time zones as associated with a country or region within a country. 

# This is because the IANA database has to record decades worth of time zone
# rules. In the course of decades, countries change names (or break apart)
# fairly frequently, but city names tend to stay the same. Another problem is
# that name needs to reflect not only to the current behaviour, but also the
# complete history. For example, there are time zones for both
# “America/New_York” and “America/Detroit”. These cities both currently use
# Eastern Standard Time but in 1969-1972 Michigan (the state in which Detroit is
# located), did not follow DST, so it needs a different name.

# It’s worth reading the raw time zone database (available at
# http://www.iana.org/time-zones) just to read some of these stories!
  
# You can find out what R thinks your current time zone is with Sys.timezone():

Sys.timezone()

# (If R doesn’t know, you’ll get an NA.)

# See the complete list of all time zone names with OlsonNames():
length(OlsonNames())
#> [1] 592

# OlsonNames()
head(OlsonNames())

# In R, the time zone is an attribute of the date-time 
# that only controls printing. 
# For example, these 3 objects represent the same instant in time:
  
(x1 <- ymd_hms("2015-06-01 12:00:00", tz = "America/New_York"))
(x2 <- ymd_hms("2015-06-01 18:00:00", tz = "Europe/Copenhagen"))
(x3 <- ymd_hms("2015-06-02 04:00:00", tz = "Pacific/Auckland"))

# Verify their identity by subtraction:
x2 - x1
x3 - x1

# Unless specified differently, lubridate always uses UTC.  [test.quest]

# UTC (Coordinated Universal Time) is the standard time zone 
# used by the scientific community and roughly equivalent to its predecessor 
# GMT (Greenwich Mean Time). 

# UTC does not have DST, which makes a convenient representation for computation. 
# Operations that combine date-times, like c(), will often drop the time zone. 

# In that case, the date-times will display in your local time zone:
x4 <- c(x1, x2, x3)
x4

## Changing time zones: ---- 

# We can change the time zone in 2 ways:

# (1) Keep the time, but change its display ---- 
#     Keep the instant in time the same, and change how it’s displayed. 
#     Use this when the instant is correct, but you want a more natural display: 
x4a <- with_tz(x4, tzone = "Australia/Lord_Howe")
x4a

x4a - x4 # time points remain the same (only display is different)!


# (2) Change the underlying instant in time ---- 
#     Use this when you have an instant that has been labelled with 
#     the incorrect time zone, and you need to fix it: 

x4b <- force_tz(x4, tzone = "Australia/Lord_Howe")
x4b

x4b - x4 # time points have been shifted!



## +++ here now +++ ------



## Appendix ------

## Web:  

# Cheatsheets: 
# Dates and Times (lubridate), see 
# https://www.rstudio.com/resources/cheatsheets/


## Documentation: ----- 

# Vignettes of R packages: 

## Related tools:


## Ideas for test questions [test.quest]: ------

## Multiple choice [MC] questions: -----

## Definitions of 3 time spans:
## - durations 
## - periods
## - intervals

## Practical questions: ----- 

## (A) Getting date components: ---- 

## Determine the month and weekday of some date variable and group cases 
## (e.g., events, flights, people, ...) by month or weekday. 


## (B) Calculating with dates: ---- 

## (1) Birthday calculations:  
## Determine (a) the weekday of your (original) birthday; 
##           (b) the weekday of your birthday this year (so that the code works in any year);  
##       and (c) the weekdays of all of your birthdays so far (including this year).

## Note: Assume that you know your original birthdate (in yymmdd format, e.g. 691307) 
##       and your current age (48). However, assume that you do _not_ know the current year 
##       (or rather: your code should work not only in some particular year, but in _any_ year).

# ad (a): 
bday_0 <- ymd(690713)
# bday_0 <- ymd(750701)
bday_0

# Weekday of this date: 
wday(bday_0, label = TRUE) # Note that label = FALSE would start counting on Sunday (= 1).

# ad (b):
# Determine the current year:
cur_year <- year(floor_date(today(), unit = "year"))

# My birthday this year (by adding months and days to January 1st):
bday_cur <- floor_date(today(), unit = "year") + months(7-1) + days(13-1)
bday_cur

# Alternatively, knowing my current age 
# (AND whether I already celebrated by birthday this year):
age <- 48
bday_cur <- bday_0 + years(age + 1) # to include current birthday (if not yet celebrated this year)
bday_cur

# Weekday of this date: 
wday(bday_cur, label = TRUE)

# ad (c):
# number of birthdays (including current year):
age_cur <- year(bday_cur) - year(bday_0) 
age_cur

# corresponding dates:
bdays <- bday_0 + years(0:age_cur)
bdays

# corresponding weekdays:
wday(bdays, label = TRUE)


## See 
## https://fivethirtyeight.com/features/some-people-are-too-superstitious-to-have-a-baby-on-friday-the-13th/
## for nice day/date effects.


## ------
## eof.