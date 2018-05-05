## r4ds: Chapter 16: 
## Code for http://r4ds.had.co.nz/dates-and-times.html  
## hn spds uni.kn
## 2018 05 05 ------

## [see Book chapter 1x: "..."]

## Note: forcats is not part of the core tidyverse. 



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

## +++ here now +++ ------

## 16.3.1 Getting components ----- 
## 16.3.2 Rounding ----- 
## 16.3.3 Setting components ----- 
## 16.3.4 Exercises -----



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