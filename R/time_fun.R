## time_fun.R | ds4psy
## hn | uni.kn | 2020 07 10 
## ---------------------------

## Functions for date and time objects. 

## (0) Time helper/utility functions: ----------


## (A) Class of date/time object: ------ 

# is_Date: -----

is_Date <- function(date){
  inherits(date, "Date")  
}

# is_POSIXt: -----

is_POSIXt <- function(time){
  inherits(time, "POSIXt")  
}

# is_POSIXct: -----

is_POSIXct <- function(time){
  inherits(time, "POSIXct")  
}

# is_POSIXlt: -----

is_POSIXlt <- function(time){
  inherits(time, "POSIXlt")  
}

# is_difftime: -----

is_difftime <- function(time){
  inherits(time, "difftime")  
}

# is_date_time: -----

is_date_time <- function(dt){
  is_Date(dt) | is_POSIXt(dt) | is_difftime(dt)
}


## (B) Parsing "Date" from non-dates: ------  

# date_frms_*: Standard date formats: ------

sps <- c("", "-", "/", ".", " ")  # separators

# Ymd: 
df_Ym <- paste0("%Y", sps, "%m", sps, "%d")
df_Yb <- paste0("%Y", sps, "%b", sps, "%d")
df_YB <- paste0("%Y", sps, "%B", sps, "%d")

# ymd:
df_ym <- paste0("%y", sps, "%m", sps, "%d")
df_yb <- paste0("%y", sps, "%b", sps, "%d")
df_yB <- paste0("%y", sps, "%B", sps, "%d")

# dmY:
df_mY <- paste0("%d", sps, "%m", sps, "%Y")
df_bY <- paste0("%d", sps, "%b", sps, "%Y")
df_BY <- paste0("%d", sps, "%B", sps, "%Y")

# dmy:
df_my <- paste0("%d", sps, "%m", sps, "%y")
df_by <- paste0("%d", sps, "%b", sps, "%y")
df_By <- paste0("%d", sps, "%B", sps, "%y")

# combine: 
date_frms_Ymd <- c(df_Ym, df_Yb, df_YB)
date_frms_ymd <- c(df_ym, df_yb, df_yB)
date_frms_dmY <- c(df_mY, df_bY, df_BY)
date_frms_dmy <- c(df_my, df_by, df_By)


# date_from_string: Parse a string into "Date": ------ 

date_from_string <- function(x, ...){
  
  # 1. Preparation:
  
  if (is_Date(x)){ return(x) }
  
  if (!is.character(x)){
    
    # message("date_from_string: Coercing x into a character string.")
    
    x <- as.character(x)
    
  }
  
  dt <- NA
  
  # 2. Aim to detect date format:
  # Heuristic: Consider 1st item: Position of 4-digit year (yyyy)? 
  x_1 <- x[1]
  
  if (grepl(x = x_1, pattern = "^(\\d\\d\\d\\d)")){ # yyyy first:
    
    date_frms <- date_frms_Ymd
    
  } else if (grepl(x = x_1, pattern = "(\\d\\d\\d\\d)$")){ # yyyy at end:
    
    date_frms <- date_frms_dmY
    
  } else { 
    
    date_frms <- c(date_frms_ymd, date_frms_dmy)  # => prefer yy first.
    
  }
  
  # 3. Parse as.Date(x):
  dt <- as.Date(x, tryFormats = date_frms, ...)
  
  return(dt)
  
} # date_from_string end. 

# ## Check:
# date_from_string("2010-08-12")
# date_from_string("12.08.2010")
# date_from_string("12 Aug 2010")
# date_from_string("12 August 2010")
# 
# # Note preference for year first:
# date_from_string("10-8-12")  # "2010-08-12"
# date_from_string("12-8-10")  # "2012-08-10"
# 
# # Note some flexibility:
# date_from_string(Sys.Date())  # dates are returned as is
# date_from_string("20100812")  # no separators (Y first)
# date_from_string(20100812)    # coercing numbers into strings
#
# # for vectors:
# date_from_string(c("10-8-12", "12-8-10"))
# date_from_string(c(20100812, 20120810))
# 
# # (!) NOT accounted for:
# date_from_string("August 10, 2010")  # mdY
# # but providing format works:
# date_from_string("August 10, 2010", format = "%B %d, %Y") 
# 
# date_from_string("12.8")  # no year
# # but providing formats works: 
# date_from_string("12.8", format = "%d.%m")
# date_from_string("12.8", format = "%m.%d")
# 
# date_from_string(c("12-8-2010", "12-Aug-10"))  # mix of formats
# date_from_string(c("2010-8-12", "12-8-2010"))  # mix of orders


# date_from_nonDate: Parse non-Date into "Date" object(s): ------ 

date_from_nonDate <- function(x){
  
  dt <- NA
  
  # 1. Coerce numeric x that are NOT date-time objects into character strings:
  if (!is_date_time(x) & is.numeric(x)){
    # message('date_from_nonDate: Coercing x from "number" into "character"...')    
    x <- as.character(x)
  }
  
  # 2. Aim to coerce character string inputs x into "Date": 
  if (is.character(x)){
    # message('date_from_nonDate: Aiming to parse x from "character" as "Date"...')
    dt <- date_from_string(x)
  }
  
  # 3. Coerce "POSIXt" inputs into "Date":
  if (is_POSIXt(x)){
    # message('date_from_nonDate: Coercing x from "POSIXt" into "Date"...')
    dt <- as.Date(x)
  }
  
  # 4. Note if dt is still no "Date": ---- 
  if (!is_Date(dt)){
    
    message('date_from_nonDate: Failed to parse x as "Date"...')
    
  }
  
  return(dt)
  
} # date_from_nonDate end. 

# # Check:
# date_from_nonDate(20100612)    # number
# date_from_nonDate("20100612")  # string
# date_from_nonDate(as.POSIXct("2010-06-10 12:30:45", tz = "UTC"))
# date_from_nonDate(as.POSIXlt("2010-06-10 12:30:45", tz = "UTC"))
# 
# # Note errors for:
# date_from_nonDate(123)
# date_from_nonDate("ABC")



## (1) cur_ functions: ---------- 

# 90% of all use cases are covered by 2 functions that ask for the _current_ date or time:
# - `cur_date()`: in 2 different orders (optional sep)
# - `cur_time()`: with or without seconds (optional sep)

# cur_date: A relaxed version of Sys.time() ------ 

#' Current date (in yyyy-mm-dd or dd-mm-yyyy format). 
#'
#' \code{cur_date} provides a relaxed version of 
#' \code{Sys.time()} that is sufficient for most purposes. 
#' 
#' By default, \code{cur_date} returns \code{Sys.Date} 
#' as a character string (using current system settings and 
#' \code{sep} for formatting).  
#' If \code{as_string = FALSE}, a "Date" object is returned.  
#'  
#' Alternatively, consider using \code{Sys.Date} 
#' or \code{Sys.time()} to obtain the "%Y-%m-%d" (or "%F")     
#' format according to the ISO 8601 standard. 
#' 
#' For more options, see the documentations of the  
#' \code{date} and \code{Sys.Date} functions of \strong{base} R   
#' and the formatting options for \code{Sys.time()}. 
#' 
#' @param rev Boolean: Reverse from "yyyy-mm-dd" to "dd-mm-yyyy" format?    
#' Default: \code{rev = FALSE}. 
#' 
#' @param as_string Boolean: Return as character string? 
#' Default: \code{as_string = TRUE}. 
#' If \code{as_string = FALSE}, a "Date" object is returned. 
#' 
#' @param sep Character: Separator to use. 
#' Default: \code{sep = "-"}. 
#' 
#' @return A character string or object of class "Date". 
#' 
#' @examples
#' cur_date()
#' cur_date(sep = "/")
#' cur_date(rev = TRUE)
#' cur_date(rev = TRUE, sep = ".")
#' 
#' # return a "Date" object:
#' from <- cur_date(as_string = FALSE)
#' class(from)
#' 
#' @family date and time functions
#' 
#' @seealso 
#' \code{what_date()} function to print dates with more options; 
#' \code{date()} and \code{today()} functions of the \strong{lubridate} package; 
#' \code{date()}, \code{Sys.Date()}, and \code{Sys.time()} functions of \strong{base} R. 
#'
#' @export 

cur_date <- function(rev = FALSE, as_string = TRUE, sep = "-"){
  
  # Get system date: 
  # d <- Sys.time() # current time (optimizing options)
  d <- Sys.Date()  # current date (satisficing solution) 
  
  # Format instruction string:   
  if (rev){
    fmt <- paste("%d", "%m", "%Y", sep = sep, collapse = "")  # using sep
  } else {
    fmt <- paste("%Y", "%m", "%d", sep = sep, collapse = "")  # using sep
  }
  
  # ## Side effect and invisible return: 
  # # Print formatted d (as side effect): 
  # print(format(d, fmt))  # as string
  # # cat(format(d, fmt))  # no string
  # 
  # # Return Date object:
  # invisible(d)
  
  if (as_string){
    return(format(d, format = fmt))  # formatted string
    # return(print(format(d, fmt)))  # print string
    # return(cat(format(d, fmt)))    # no string
  } else {
    return(d)  # as Date
  }
  
}  # cur_date end. 

# ## Check:
# cur_date()
# cur_date(sep = "/")
# cur_date(rev = TRUE)
# cur_date(rev = TRUE, sep = ".")


# cur_time: A satisficing version of Sys.time() ------

#' Current time (in hh:mm or hh:mm:ss format).  
#'
#' \code{cur_time} provides a satisficing version of 
#' \code{Sys.time()} that is sufficient for most purposes. 
#' 
#' By default, \code{cur_time} returns a 
#' \code{Sys.time()} as a character string 
#' (in "%H:%M" or "%H:%M:%S" format) 
#' using current system settings. 
#' If \code{as_string = FALSE}, a "POSIXct" 
#' (calendar time) object is returned. 
#' 
#' For a time zone argument, 
#' see the \code{\link{what_time}} function, 
#' or the \code{now()} function of 
#' the \strong{lubridate} package. 
#' 
#' @param seconds Boolean: Show time with seconds?    
#' Default: \code{seconds = FALSE}. 
#' 
#' @param as_string Boolean: Return as character string? 
#' Default: \code{as_string = TRUE}. 
#' If \code{as_string = FALSE}, a "POSIXct" object is returned. 
#' 
#' @param sep Character: Separator to use. 
#' Default: \code{sep = ":"}. 
#' 
#' @return A character string or object of class "POSIXct". 
#' 
#' @examples
#' cur_time() 
#' cur_time(seconds = TRUE)
#' cur_time(sep = ".")
#' 
#' # return a "POSIXct" object:
#' t <- cur_time(as_string = FALSE)
#' format(t, "%T %Z")
#' 
#' @family date and time functions
#' 
#' @seealso 
#' \code{what_time()} function to print times with more options;  
#' \code{now()} function of the \strong{lubridate} package; 
#' \code{Sys.time()} function of \strong{base} R. 
#' 
#' @export 

cur_time <- function(seconds = FALSE, as_string = TRUE, sep = ":"){
  
  # Current time: 
  t <- Sys.time()
  
  # Format instruction string: 
  if (seconds) {
    fmt <- paste("%H", "%M", "%S", sep = sep, collapse = "")  # %S and using sep
  } else {
    fmt <- paste("%H", "%M",       sep = sep, collapse = "")  # no %S, using sep
  }
  
  # ## Side effect and invisible return:   
  # # Print formatted t (as side effect): 
  # print(format(t, fmt))  # as string
  # # cat(format(t, fmt))  # no string
  # 
  # # Return POSIXct object:
  # invisible(t)
  
  if (as_string){
    return(format(t, format = fmt))  # formatted string
    # return(print(format(t, fmt)))  # print string
    # return(cat(format(t, fmt)))    # no string
  } else {
    return(t)  # as POSIXct
  }
  
}  # cur_time end. 

## Check:
# cur_time()
# cur_time(seconds = TRUE)
# cur_time(sep = ".")


# cur_date_time: Combining cur_date and cur_time: ------ 

# ToDo?  Or just call cur_date() AND cur_time()? 




## (2) what_ functions: ---------- 

# Motivation: The R base function date()  
# returns date as "Wed Aug 21 19:43:22 2019", 
# which is more than we usually want.

# Some simpler variants following a simple heuristic: 
# What is it that we _usually_ want to hear as `x` when asking 
# "What `x` is it today?" or "What `x` is it right now?"

# About 5% are covered by 4 additional functions that ask `what_` questions
# about the position of some temporal unit in some larger continuum of time:
# 
# - `what_time()`:  more versatile version of cur_time() (accepting a when argument)
# - `what_date()`:  more versatile version of cur_date() (accepting a when argument)
# - `what_wday()`  : as name (weekday, abbr or full), OR as number (in units of week, month, or year; as char or as integer)  
# - `what_week()` : only as number (in units of month, or year); return as char or as integer   
# - `what_month()`: as name (abbr or full) OR as number (as char or as integer)  
# - `what_year()` : only as number (abbr or full), return as char or as integer
#  
# All of these functions 
# - take some "point in time" time as input (as a "when" argument),
#   which defaults to now (i.e., Sys.time()) but can also be a vector.
# - return a character string (which can easily be converted into a number), unless specifically asking for numeric output

# what_time: More versatile version of cur_time(), allowing for a when vector: ------ 

#' What time is it?  
#'
#' \code{what_time} provides a satisficing version of 
#' \code{Sys.time()} that is sufficient for most purposes. 
#' 
#' By default, \code{what_time} prints a simple version of 
#' \code{when} or \code{Sys.time()} 
#' as a character string (in "%H:%M" or "%H:%M:%S" format) 
#' using current default system settings.  
#' If \code{as_string = FALSE}, a "POSIXct" 
#' (calendar time) object is returned.
#' 
#' The \code{tz} argument allows specifying time zones 
#' (see \code{Sys.timezone()} for current setting 
#' and \code{OlsonNames()} for options.) 
#' 
#' However, \code{tz} is merely used to represent the 
#' times provided to the \code{when} argument. 
#' Thus, there currently is no active conversion 
#' of times into other time zones 
#' (see the \code{now} function of \strong{lubridate} package).
#' 
#' @param when Time (as a scalar or vector).    
#' Default: \code{when = NA}. 
#' Returning \code{Sys.time()}, if \code{when = NA}.
#' 
#' @param seconds Boolean: Show time with seconds?    
#' Default: \code{seconds = FALSE}. 
#' 
#' @param as_string Boolean: Return as character string? 
#' Default: \code{as_string = TRUE}. 
#' If \code{as_string = FALSE}, a "POSIXct" object is returned. 
#' 
#' @param sep Character: Separator to use. 
#' Default: \code{sep = ":"}. 
#' 
#' @param tz Time zone.
#' Default: \code{tz = ""} (i.e., current system time zone,  
#' see \code{Sys.timezone()}). 
#' Use \code{tz = "UTC"} for Coordinated Universal Time. 
#' 
#' @return A character string or object of class "POSIXct". 
#' 
#' @examples
#' what_time()  
#' 
#' # with vector (of "POSIXct" objects): 
#' tm <- c("2020-02-29 01:02:03", "2020-12-31 14:15:16")
#' what_time(tm)
#' 
#' # with time zone: 
#' ts <- ISOdate(2020, 12, 24, c(0, 12))  # midnight and midday UTC
#' t1 <- what_time(when = ts, tz = "US/Hawaii")
#' t1
#' 
#' # return "POSIXct" object(s):
#' t2 <- what_time("2020-02-29 12:30:45", as_string = FALSE, tz = "US/Hawaii")
#' format(t2, "%T %Z (UTF %z)")
#' 
#' @family date and time functions
#' 
#' @seealso 
#' \code{cur_time()} function to print the current time; 
#' \code{cur_date()} function to print the current date; 
#' \code{now()} function of the \strong{lubridate} package; 
#' \code{Sys.time()} function of \strong{base} R. 
#' 
#' @export

what_time <- function(when = NA, seconds = FALSE, as_string = TRUE, sep = ":", tz = ""){
  
  # Check when argument: 
  if (all(is.na(when))){
    t <- Sys.time()  # use current time
  } else {
    t <- as.POSIXct(when, tz = tz)  # as POSIXct (with passive tz)
  }
  
  # Convert into time zone tz: 
  if (tz != ""){
    message("ToDo: Actively convert time(s) t into specified tz?")
  }
  
  # Format instruction string: 
  if (seconds) {
    fmt <- paste("%H", "%M", "%S", sep = sep, collapse = "")  # %S and using sep
  } else {
    fmt <- paste("%H", "%M",       sep = sep, collapse = "")  # no %S, using sep
  }
  
  # ## Side effect and invisible return:   
  # # Print formatted t (as side effect): 
  # print(format(t, fmt))  # as string
  # # cat(format(t, fmt))  # no string
  # 
  # # Return POSIXct object:
  # invisible(t)
  
  if (as_string){
    return(format(t, format = fmt))  # formatted string
    # return(print(format(t, fmt)))  # print string
    # return(cat(format(t, fmt)))    # no string
  } else {
    return(t)  # as POSIXct
  }
  
}  # what_time end.

# # Check:
# what_time()  
#
# # with vector (of POSIXct objects):
# ts <- c("2020-02-29 01:02:03", "2020-12-31 14:15:16")
# what_time(ts)
# 
# # with time zone:
# t1 <- what_time(ts, seconds = TRUE, sep = "_", tz = "UTC")
# t1
# 
# # returns POSIXct objects:
# t2 <- what_time("2020-02-29 12:30:45", tz = "US/Pacific")
# format(t2, "%T %Z")


# what_date: More versatile version of cur_date(), allowing for a when vector: ------

#' What date is it?  
#'
#' \code{what_date} provides a satisficing version of 
#' \code{Sys.Date()} that is sufficient for most purposes. 
#' 
#' By default, \code{what_date} returns either 
#' \code{Sys.Date()} or the dates provided by \code{when} 
#' as a character string (using current system settings and 
#' \code{sep} for formatting).  
#' If \code{as_string = FALSE}, a "Date" object is returned. 
#' 
#' The \code{tz} argument allows specifying time zones 
#' (see \code{Sys.timezone()} for current setting 
#' and \code{OlsonNames()} for options.) 
#' 
#' However, \code{tz} is merely used to represent the 
#' dates provided to the \code{when} argument. 
#' Thus, there currently is no active conversion 
#' of dates into other time zones 
#' (see the \code{today} function of \strong{lubridate} package).
#' 
#' @param when Date(s) (as a scalar or vector).    
#' Default: \code{when = NA}. 
#' Using \code{as.Date(when)} to convert strings into dates, 
#' and \code{Sys.Date()}, if \code{when = NA}.
#' 
#' @param rev Boolean: Reverse date (to %d-%m-%Y)?    
#' Default: \code{rev = FALSE}. 
#' 
#' @param as_string Boolean: Return as character string? 
#' Default: \code{as_string = TRUE}. 
#' If \code{as_string = FALSE}, a "Date" object is returned. 
#' 
#' @param sep Character: Separator to use. 
#' Default: \code{sep = "-"}. 
#' 
#' @param month_form Character: Month format. 
#' Default: \code{month_form = "m"} for numeric month (01-12). 
#' Use \code{month_form = "b"} for short month name 
#' and \code{month_form = "B"} for full month name (in current locale).  
#' 
#' @param tz Time zone.
#' Default: \code{tz = ""} (i.e., current system time zone,  
#' see \code{Sys.timezone()}). 
#' Use \code{tz = "UTC"} for Coordinated Universal Time. 
#' 
#' @return A character string or object of class "Date". 
#'  
#' @examples
#' what_date()  
#' what_date(sep = "/")
#' what_date(rev = TRUE)
#' what_date(rev = TRUE, sep = ".")
#' what_date(rev = TRUE, sep = " ", month_form = "B")
#' 
#' # with "POSIXct" times:
#' what_date(when = Sys.time())
#' 
#' # with time vector (of "POSIXct" objects):
#' ts <- c("1969-07-13 13:53 CET", "2020-12-31 23:59:59")
#' what_date(ts)
#' what_date(ts, rev = TRUE, sep = ".")
#' what_date(ts, rev = TRUE, month_form = "b")
#' 
#' # with time zone: 
#' ts <- ISOdate(2020, 12, 24, c(0, 12))  # midnight and midday UTC
#' what_date(when = ts, tz = "US/Hawaii")
#' 
#' # return a "Date" object:
#' dt <- what_date(as_string = FALSE)
#' class(dt)
#' 
#' @family date and time functions
#' 
#' @seealso 
#' \code{what_wday()} function to obtain (week)days; 
#' \code{what_time()} function to obtain times; 
#' \code{cur_time()} function to print the current time; 
#' \code{cur_date()} function to print the current date; 
#' \code{now()} function of the \strong{lubridate} package; 
#' \code{Sys.time()} function of \strong{base} R. 
#' 
#' @export

what_date <- function(when = NA, rev = FALSE, as_string = TRUE, sep = "-", 
                      month_form = "m", tz = ""){
  
  # Check when argument: 
  if (all(is.na(when))){
    
    # Get system date: 
    # d <- Sys.time() # current time (optimizing options)
    d <- Sys.Date()  # current date (satisficing solution) 
    
  } else {
    d <- as.Date(when, tz = tz)  # as Date (with passive tz) 
  }
  
  # Convert into time zone tz: 
  if (tz != ""){
    message("ToDo: Actively convert date(s) d into specified tz?")
  }
  
  # Format instruction string:
  if (substr(month_form, 1, 1) != "%") {
    month_form <- paste0("%", month_form)  # add % prefix
  }
  
  if (rev){
    fmt <- paste("%d", month_form, "%Y", sep = sep, collapse = "")  # using sep
  } else {
    fmt <- paste("%Y", month_form, "%d", sep = sep, collapse = "")  # using sep
  }
  
  # ## Side effect and invisible return:   
  # # Print formatted d (as side effect): 
  # print(format(d, fmt))  # as string
  # # cat(format(d, fmt))  # no string
  # 
  # # Return Date object:
  # invisible(d)
  
  if (as_string){
    return(format(d, format = fmt))  # formatted string
    # return(print(format(d, fmt)))  # print string
    # return(cat(format(d, fmt)))    # no string
  } else {
    return(d)  # as Date
  }
  
}  # what_date end. 

# ## Check:
# what_date()
# what_date(sep = "/")
# what_date(rev = TRUE)
# what_date(rev = TRUE, sep = ".")
# what_date(rev = TRUE, sep = " ", month_form = "B")
# 
# # with vector (of POSIXct times):
# ds <- c("2020-01-15 01:02:03 CET", "2020-12-31 14:15:16")
# what_date(ds)
# what_date(ds, rev = TRUE, sep = ".")
# what_date(ds, rev = TRUE, month_form = "b")


## what_day_alt: What day is it? (OLD/ORG version: name or number) ------ 
## what_day_alt: as name (weekday, abbr or full), OR as number (in units of week, month, or year; as char or as integer) 

# What day is it? (alternative OLD/ORG version)
#
# \code{what_day_alt} provides a satisficing version of
# to determine the day corresponding to a given date.
#
# \code{what_day_alt} returns the day
# of \code{when} or \code{Sys.Date()}
# (as a name or number).
#
# @param when Date (as a scalar or vector).
# Default: \code{when = NA}.
# Using \code{as.Date(when)} to convert strings into dates,
# and \code{Sys.Date()}, if \code{when = NA}.
#
# @param unit Character: Unit of day?
# Possible values are \code{"week", "month", "year"}.
# Default: \code{unit = "week"} (for day within week).
#
# @param abbr Boolean: Return abbreviated?
# Default: \code{abbr = FALSE}.
#
# @param as_integer Boolean: Return as integer?
# Default: \code{as_integer = FALSE}.
# 
# @examples
# what_day_alt()
# what_day_alt(abbr = TRUE)
# what_day_alt(as_integer = TRUE)
# 
# # Work with vectors (when as characters):
# ds <- c("2020-01-01", "2020-02-29", "2020-12-24", "2020-12-31")
# what_day_alt(when = ds)
# what_day_alt(when = ds, unit = "month", as_integer = TRUE)
# what_day_alt(when = ds, unit = "year", as_integer = TRUE)
#
#
# @family date and time functions
#
# @seealso
# \code{what_day()} for a simpler version (only weekdays);
# \code{what_date()} function to obtain dates;
# \code{what_time()} function to obtain times;
# \code{cur_time()} function to print the current time;
# \code{cur_date()} function to print the current date;
# \code{Sys.time()} function of \strong{base} R.
# 
# @export

# what_day_alt <- function(when = Sys.time(), unit = "week", abbr = FALSE, as_integer = FALSE){
#   
#   # Robustness:
#   unit <- substr(tolower(unit), 1, 1)  # use only 1st letter of string
#   
#   # Convert when into objects of class "Date" representing calendar dates:
#   if ( any(class(when) != "Date") & !("POSIXct" %in% class(when)) ) {
#     message(paste0("what_day_alt: Using as.Date() to convert 'when' into class 'Date'."))
#     when <- as.Date(when)
#   }
#   
#   # Verify date/time input:
#   if ( any(class(when) != "Date") & !("POSIXct" %in% class(when)) ) {
#     message(paste0("what_day_alt: when must be of class 'Date' or 'POSIXct'."))
#     message(paste0("Currently, class(when) = ", class(when), ".")) 
#     return(when)
#   }
#   
#   # initialize:
#   d <- as.character(NA) 
#   
#   # get day d (as char):
#   if (unit == "w"){  # unit "week": 
#     
#     if (as_integer){
#       
#       # Weekday as a decimal number (1–7, Mon=1): 
#       d  <- format(when, "%u")  # WARN: r-devel-linux-x86_64-debian-clang!
#       
#     } else {
#       
#       if (abbr){
#         d  <- format(when, "%a")  # Abbreviated weekday name in the current locale on this platform.
#       } else {
#         d  <- format(when, "%A")  # Full weekday name in the current locale.
#       }
#       
#     }
#     
#   } else if (unit == "m") {  # unit "month": 
#     
#     # Day of the month as decimal number (01–31): 
#     d  <- format(when, "%d")  # WARN: r-devel-linux-x86_64-debian-clang!
#     
#     
#   } else if (unit == "y") {  # unit "year": 
#     
#     # Day of year as decimal number (001–366): 
#     d  <- format(when, "%j")  # WARN: r-devel-linux-x86_64-debian-clang!
#     
#   } else {  # some other unit: 
#     
#     message("Unknown unit. Using unit = 'month':")
#     
#     # Day of the month as decimal number (01–31):
#     d  <- format(when, "%d")  # WARN: r-devel-linux-x86_64-debian-clang!
#     
#   } 
#   
#   # as char or integer:
#   if (as_integer) {
#     as.integer(d)
#   } else {
#     d
#   }
#   
# }  # what_day_alt end. 

# ## Check:
# what_day_alt()
# what_day_alt(abbr = TRUE)
# what_day_alt(as_integer = TRUE)
# 
# # Other dates/times:
# d1 <- as.Date("2020-02-29")
# what_day_alt(when = d1)
# what_day_alt(when = d1, unit = "month", as_integer = TRUE)
# what_day_alt(when = d1, unit = "year", as_integer = TRUE)
# 
# # Work with vectors (when as characters):
# ds <- c("2020-01-01", "2020-02-29", "2020-12-24", "2020-12-31")
# what_day_alt(when = ds)
# what_day_alt(when = ds, unit = "month", as_integer = TRUE)
# what_day_alt(when = ds, unit = "year", as_integer = TRUE)
# 
# # Note: Errors
# what_day_alt(when = d1, unit = "asdf")
# what_day_alt(when = "now")
# what_day_alt(when = 123)


### Simplified version: Providing only the weekday (as a name): 

# what_wday: What day is it? (name, NOT number) ------ 
# what_wday: as name (weekday, abbr or full), NOT as number (in units of week, month, or year; as char or as integer) 

#' What day of the week is it?  
#'
#' \code{what_wday} provides a satisficing version of 
#' to determine the day of the week  
#' corresponding to a given date.
#' 
#' \code{what_wday} returns the name of the weekday  
#' of \code{when} or of \code{Sys.Date()} 
#' (as a character string).
#' 
#' @param when Date (as a scalar or vector).    
#' Default: \code{when = Sys.Date()}. 
#' Aiming to convert \code{when} into "Date"  
#' if a different object class is provided. 
#' 
#' @param abbr Boolean: Return abbreviated?  
#' Default: \code{abbr = FALSE}. 
#' 
#' @examples
#' what_wday()
#' what_wday(abbr = TRUE)
#' 
#' what_wday(Sys.Date() + -1:1)  # Date (as vector)
#' what_wday(Sys.time())         # POSIXct
#' what_wday("2020-02-29")       # string (of valid date)
#' what_wday(20200229)           # number (...)
#' 
#' # date vector (as characters):
#' ds <- c("2020-01-01", "2020-02-29", "2020-12-24", "2020-12-31")
#' what_wday(when = ds)
#' what_wday(when = ds, abbr = TRUE)
#' 
#' # time vector (strings of POSIXct times):
#' ts <- c("1969-07-13 13:53 CET", "2020-12-31 23:59:59")
#' what_wday(ts)
#' 
#' @family date and time functions
#' 
#' @seealso 
#' \code{what_date()} function to obtain dates; 
#' \code{what_time()} function to obtain times; 
#' \code{cur_time()} function to print the current time; 
#' \code{cur_date()} function to print the current date; 
#' \code{now()} function of the \strong{lubridate} package; 
#' \code{Sys.time()} function of \strong{base} R. 
#' 
#' @export

what_wday <- function(when = Sys.Date(), abbr = FALSE){
  
  ## Robustness:
  # unit <- substr(tolower(unit), 1, 1)  # use only 1st letter of string
  
  # ## OLD code:   
  # # Convert when into objects of class "Date" representing calendar dates:
  # if ( any(class(when) != "Date") & !("POSIXct" %in% class(when)) ) {
  #   message(paste0("what_wday: Using as.Date() to convert 'when' into class 'Date'."))
  #   when <- as.Date(when)
  # }
  # 
  # # Verify date/time input:
  # if ( any(class(when) != "Date") & !("POSIXct" %in% class(when)) ) {
  #   message(paste0("what_wday: when must be of class 'Date' or 'POSIXct'."))
  #   message(paste0("Currently, class(when) = ", class(when), ".")) 
  #   return(when)
  # }
  
  ## NEW code: 
  if (!is_Date(when)){
    # message('what_wday: Aiming to parse "when" as "Date"...')
    when <- date_from_nonDate(when)
  }
  
  if (!is_Date(when)){
    message(paste0('what_wday: "when" must be of class "Date".'))
    return(when)
  }
  
  # print(when)  # debugging
  
  ## initialize:
  d <- as.character(NA) 
  
  ## get day d (as char):
  # if (unit == "w"){  # unit "week": 
  
  # if (as_integer){
  
  # d  <- format(when, "%u")  # Weekday as a decimal number (1–7, Monday is 1).
  
  # } else {
  
  if (abbr){
    d  <- format(when, format = "%a")  # Abbreviated weekday name in the current locale on this platform.
  } else {
    d  <- format(when, format = "%A")  # Full weekday name in the current locale.
  }
  
  #}
  
  # } else if (unit == "m") {  # unit "month": 
  
  # d  <- format(when, "%d")  # Day of the month as decimal number (01–31).
  
  
  # } else if (unit == "y") {  # unit "year": 
  
  # d  <- format(when, "%j")  # Day of year as decimal number (001–366).
  
  # } else {  # some other unit: 
  
  # message("Unknown unit. Using unit = 'month':")
  # d  <- format(when, "%d")  # Day of the month as decimal number (01–31).
  
  # } 
  
  ## as char or integer:
  # if (as_integer) {
  #  as.integer(d)
  # } else {
  d
  # }
  
}  # what_wday end. 

# ## Check:
# what_wday()
# what_wday(abbr = TRUE)
# 
# # Other dates/times:
# d1 <- as.Date("2020-02-29")
# what_wday(when = d1)
# what_wday(when = d1, abbr = TRUE)
# 
# # Work with vectors (when as characters):
# ds <- c("2020-01-01", "2020-02-29", "2020-12-24", "2020-12-31")
# what_wday(when = ds)
# what_wday(when = ds, abbr = TRUE)
# 
# # Note: Errors
# what_wday(when = "now")
# what_wday(when = 123)


# what_week: What week is it? (number only) ------ 

#' What week is it?  
#'
#' \code{what_week} provides a satisficing version of 
#' to determine the week corresponding to a given date.
#' 
#' \code{what_week} returns the week   
#' of \code{when} or \code{Sys.Date()} 
#' (as a name or number).
#' 
#' @param when Date (as a scalar or vector).    
#' Default: \code{when = Sys.Date()}. 
#' Using \code{as.Date(when)} to convert strings into dates 
#' if a different \code{when} is provided. 
#' 
#' @param unit Character: Unit of week?
#' Possible values are \code{"month", "year"}. 
#' Default: \code{unit = "year"} (for week within year). 
#' 
#' @param as_integer Boolean: Return as integer? 
#' Default: \code{as_integer = FALSE}. 
#' 
#' @examples
#' what_week()
#' what_week(as_integer = TRUE)
#' 
#' # Other dates/times:
#' d1 <- as.Date("2019-08-23")
#' what_week(when = d1, unit = "year")
#' what_week(when = d1, unit = "month")
#' 
#' what_week(Sys.time())  # with POSIXct time 
#' 
#' # with date vector (as characters):
#' ds <- c("2020-01-01", "2020-02-29", "2020-12-24", "2020-12-31")
#' what_week(when = ds)
#' what_week(when = ds, unit = "month", as_integer = TRUE)
#' what_week(when = ds, unit = "year", as_integer = TRUE)
#'
#' # with time vector (strings of POSIXct times):
#' ts <- c("2020-12-25 10:11:12 CET", "2020-12-31 23:59:59")
#' what_week(ts)
#'
#' @family date and time functions
#' 
#' @seealso 
#' \code{what_wday()} function to obtain (week)days; 
#' \code{what_date()} function to obtain dates; 
#' \code{cur_time()} function to print the current time; 
#' \code{cur_date()} function to print the current date; 
#' \code{now()} function of the \strong{lubridate} package; 
#' \code{Sys.time()} function of \strong{base} R. 
#' 
#' @export

what_week <- function(when = Sys.Date(), unit = "year", as_integer = FALSE){
  
  # Robustness:
  unit <- substr(tolower(unit), 1, 1)  # use only 1st letter of string
  
  # Convert when into objects of class "Date" representing calendar dates:
  if ( any(class(when) != "Date") & !("POSIXct" %in% class(when)) ) {
    message(paste0("what_week: Using as.Date() to convert 'when' into class 'Date'."))
    when <- as.Date(when)
  }
  
  # Verify date/time input:
  if ( any(class(when) != "Date") & !("POSIXct" %in% class(when)) ) {
    message(paste0("what_week: when must be of class 'Date' or 'POSIXct'."))
    message(paste0("Currently, class(when) = ", class(when), ".")) 
    return(when)
  }
  
  # initialize:
  w <- NA
  
  # get week w (as char):
  if (unit == "m"){  # unit "month": 
    
    # Searching nr. of week corresponding to current time in current month?
    # Sources: Adapted from a discussion at 
    # <https://stackoverflow.com/questions/25199851/r-how-to-get-the-week-number-of-the-month>
    
    # desired date:
    d_des <- as.Date(when)
    wk_2  <- as.numeric(format(d_des, "%V"))  # corresponding week (01--53) as defined in ISO 8601 (week starts Monday)
    
    # date of 1st day in corresponding month:
    d_1st <- as.Date(cut(d_des, "month"))     # date of 1st day in corresponding month
    wk_1  <- as.numeric(format(d_1st, "%V"))  # corresponding week (01--53) as defined in ISO 8601 (week starts on Monday)
    
    # difference: 
    w <- (wk_2 - wk_1) + 1  # as number
    w <- as.character(w)    # as character
    
  } else if (unit == "y") {  # unit "year": 
    
    w <- format(when, format = "%V")  # %V: week of the year as decimal number (01--53) as defined in ISO 8601 (week starts on Monday)
    
  } else {  # some other unit: 
    
    message("Unknown unit. Using unit = 'year':")
    w <- format(when, format = "%V")  # %V: week of the year as decimal number (01--53) as defined in ISO 8601 (week starts on Monday)
    
  } 
  
  # as char or integer:
  if (as_integer) {
    as.integer(w)
  } else {
    w
  }
  
}  # what_week end. 

# ## Check:
# what_week()
# what_week(as_integer = TRUE)
# 
# # Other dates/times:
# d1 <- as.Date("2019-08-23")
# what_week(when = d1, unit = "year")
# what_week(when = d1, unit = "month")
# 
# # Week nr. (in month):
# d2 <- as.Date("2019-06-23")  # Sunday of 4th week in June 2019.
# what_week(when = d2, unit = "month")
# d3 <- as.Date("2019-06-24")  # Monday of 5th week in June 2019.
# what_week(when = d3, unit = "month")
# 
# # Work with vectors (when as characters):
# ds <- c("2020-01-01", "2020-02-29", "2020-12-24", "2020-12-31")
# what_week(when = ds)
# what_week(when = ds, unit = "month", as_integer = TRUE)
# what_week(when = ds, unit = "year", as_integer = TRUE)
# 
# ## Note: Errors
# # what_week(when = d1, unit = "asdf")
# # what_week(when = "now")
# # what_week(when = 123)



# what_month: What month is it? (name or number) ------ 
# - `what_month()`: as name (abbr or full) OR as number (as char or as integer)

#' What month is it?  
#'
#' \code{what_month} provides a satisficing version of 
#' to determine the month corresponding to a given date.
#' 
#' \code{what_month} returns the month    
#' of \code{when} or \code{Sys.Date()} 
#' (as a name or number).
#' 
#' @param when Date (as a scalar or vector).    
#' Default: \code{when = NA}. 
#' Using \code{as.Date(when)} to convert strings into dates, 
#' and \code{Sys.Date()}, if \code{when = NA}.
#' 
#' @param abbr Boolean: Return abbreviated?  
#' Default: \code{abbr = FALSE}. 
#' 
#' @param as_integer Boolean: Return as integer? 
#' Default: \code{as_integer = FALSE}. 
#' 
#' @examples
#' what_month()
#' what_month(abbr = TRUE)
#' what_month(as_integer = TRUE)
#' 
#' # with date vector (as characters):
#' ds <- c("2020-01-01", "2020-02-29", "2020-12-24", "2020-12-31")
#' what_month(when = ds)
#' what_month(when = ds, abbr = TRUE, as_integer = FALSE)
#' what_month(when = ds, abbr = TRUE, as_integer = TRUE)
#' 
#' # with time vector (strings of POSIXct times):
#' ts <- c("2020-02-29 10:11:12 CET", "2020-12-31 23:59:59")
#' what_month(ts)
#'         
#' @family date and time functions
#' 
#' @seealso 
#' \code{what_week()} function to obtain weeks; 
#' \code{what_date()} function to obtain dates; 
#' \code{cur_time()} function to print the current time; 
#' \code{cur_date()} function to print the current date; 
#' \code{now()} function of the \strong{lubridate} package; 
#' \code{Sys.time()} function of \strong{base} R. 
#' 
#' @export

what_month <- function(when = Sys.Date(), abbr = FALSE, as_integer = FALSE){
  
  # Convert when into objects of class "Date" representing calendar dates:
  if ( any(class(when) != "Date") & !("POSIXct" %in% class(when)) ) {
    message(paste0("what_month: Using as.Date() to convert 'when' into class 'Date'."))
    when <- as.Date(when)
  }
  
  # Verify date/time input:
  if ( any(class(when) != "Date") & !("POSIXct" %in% class(when)) ) {
    message(paste0("what_month: when must be of class 'Date' or 'POSIXct'."))
    message(paste0("Currently, class(when) = ", class(when), ".")) 
    return(when)
  }
  
  # initialize:
  m <- NA
  
  # get month m (as char):
  
  if (as_integer) {
    
    m <- format(when, format = "%m")
    m <- as.integer(m)
    
  } else { # month name (as character):
    
    if (abbr){
      
      m <- format(when, format = "%b")  # Abbreviated month name in the current locale on this platform. 
      
    } else {
      
      m <- format(when, format = "%B")  # Full month name in the current locale. 
      
    }
    
  }
  
  return(m)
  
}  # what_month end. 

# ## Check:
# what_month()
# what_month(abbr = TRUE)
# what_month(as_integer = TRUE)
# 
# # Other dates/times:
# d1 <- as.Date("2020-02-29")
# what_month(when = d1)
# what_month(when = d1, abbr = TRUE)
# what_month(when = d1, as_integer = TRUE)
# 
# # Work with vectors (when as characters):
# ds <- c("2020-01-01", "2020-02-29", "2020-12-24", "2020-12-31")
# what_month(when = ds)
# what_month(when = ds, abbr = TRUE, as_integer = FALSE)
# what_month(when = ds, abbr = TRUE, as_integer = TRUE)
# 
# ## Note: Errors
# # what_month(when = "now")
# # what_month(when = 123)



# what_year: What year is it? ------ 

#' What year is it?  
#'
#' \code{what_year} provides a satisficing version of 
#' to determine the year corresponding to a given date.
#' 
#' \code{what_year} returns the year     
#' of \code{when} or \code{Sys.Date()} 
#' (as a name or number).
#' 
#' @param when Date (as a scalar or vector).    
#' Default: \code{when = NA}. 
#' Using \code{as.Date(when)} to convert strings into dates, 
#' and \code{Sys.Date()}, if \code{when = NA}.
#' 
#' @param abbr Boolean: Return abbreviated?  
#' Default: \code{abbr = FALSE}. 
#' 
#' @param as_integer Boolean: Return as integer? 
#' Default: \code{as_integer = FALSE}. 
#' 
#' @examples
#' what_year()
#' what_year(abbr = TRUE)
#' what_year(as_integer = TRUE)
#' 
#' # with date vectors (as characters):
#' ds <- c("2020-01-01", "2020-02-29", "2020-12-24", "2020-12-31")
#' what_year(when = ds)
#' what_year(when = ds, abbr = TRUE, as_integer = FALSE)
#' what_year(when = ds, abbr = TRUE, as_integer = TRUE)
#' 
#' # with time vector (strings of POSIXct times):
#' ts <- c("2020-02-29 10:11:12 CET", "2020-12-31 23:59:59")
#' what_year(ts)
#'
#' @family date and time functions
#' 
#' @seealso 
#' \code{what_week()} function to obtain weeks; 
#' \code{what_month()} function to obtain months; 
#' \code{cur_time()} function to print the current time; 
#' \code{cur_date()} function to print the current date; 
#' \code{now()} function of the \strong{lubridate} package; 
#' \code{Sys.time()} function of \strong{base} R. 
#' 
#' @export

what_year <- function(when = Sys.Date(), abbr = FALSE, as_integer = FALSE){
  
  # Convert when into objects of class "Date" representing calendar dates:
  if ( any(class(when) != "Date") & !("POSIXct" %in% class(when)) ) {
    message(paste0("what_year: Using as.Date() to convert 'when' into class 'Date'."))
    when <- as.Date(when)
  }
  
  # Verify date/time input:
  if ( any(class(when) != "Date") & !("POSIXct" %in% class(when)) ) {
    message(paste0("what_year: when must be of class 'Date' or 'POSIXct'."))
    message(paste0("Currently, class(when) = ", class(when), ".")) 
    return(when)
  }
  
  # initialize:
  y <- NA
  
  # get year y:
  if (abbr){ 
    y <- format(when, format = "%y") 
  } else { 
    y <- format(when, format = "%Y") 
  } 
  
  # as char or integer:
  if (as_integer) {
    as.integer(y)
  } else {
    y
  }
  
}  # what_year end. 

# ## Check:
# what_year()
# what_year(abbr = TRUE)
# what_year(as_integer = TRUE)
# 
# # other dates/times:
# dt <- as.Date("1987-07-13")
# what_year(when = dt, abbr = TRUE, as_integer = TRUE)
# 
# # Work with vectors (when as characters):
# ds <- c("2020-01-01", "2020-02-29", "2020-12-24", "2020-12-31")
# what_year(when = ds)
# what_year(when = ds, abbr = TRUE, as_integer = FALSE)
# what_year(when = ds, abbr = TRUE, as_integer = TRUE)
# 
# # Note: Errors
# what_year("2020-01-01")
# what_year(2020-01-01)




## (3) Time zones and temporal idiosyncracies: ---------- 
# change_time: ------ 

# Task 2: Take a Change time zone AND actual time, without changing represented time (i.e., time display): 

#' Change time and time zone (without changing time display).  
#'
#' \code{change_time} changes the time and time zone  
#' without changing the time display.
#' 
#' \code{change_time} expects inputs to \code{time} 
#' to be local time(s) (of the "POSIXlt" class) 
#' and a valid time zone argument \code{tz} (as a string)
#' and returns the same time display (but different actual times) 
#' as calendar time(s) (of the "POSIXct" class). 
#' 
#' @param time Time (as a scalar or vector).    
#' If \code{time} is not a local time (of the "POSIXlt" class) 
#' the function first tries coercing \code{time} into "POSIXlt" 
#' without changing the time display.
#' 
#' @param tz Time zone (as character string).   
#' Default: \code{tz = ""} 
#' (i.e., current system time zone, \code{Sys.timezone()}). 
#' See \code{OlsonNames()} for valid options. 
#' 
#' @return A calendar time of class "POSIXct". 
#' 
#' @examples
#' change_time(as.POSIXlt(Sys.time()), tz = "UTC")
#' 
#' # from "POSIXlt" time:
#' t1 <- as.POSIXlt("2020-07-01 10:00:00", tz = "Europe/Berlin")
#' change_time(t1, "NZ")
#' change_time(t1, "US/Pacific")
#' 
#' # from "POSIXct" time:
#' tc <- as.POSIXct("2020-07-01 12:00:00", tz = "UTC")
#' change_time(tc, "NZ")
#' 
#' # from "Date":
#' dt <- as.Date("2020-12-31", tz = "US/Hawaii")
#' change_time(dt, tz = "NZ")
#' 
#' # from time "string":
#' ts <- "2020-12-31 20:30:45"
#' change_time(ts, tz = "US/Pacific")
#' 
#' # from other "string" times:
#' tx <- "7:30:45"
#' change_time(tx, tz = "Asia/Calcutta")
#' ty <- "1:30"
#' change_time(ty, tz = "Europe/London")
#' 
#' # convert into local times:
#' change_tz(change_time(t1, "NZ"), tz = "UTC")
#' change_tz(change_time(t1, "Europe/Berlin"), tz = "UTC")
#' change_tz(change_time(t1, "US/Eastern"), tz = "UTC")
#' 
#' # with vector of "POSIXlt" times:
#' t2 <- as.POSIXlt("2020-12-31 23:59:55", tz = "US/Pacific")
#' tv <- c(t1, t2)  
#' tv # uses tz of t1
#' change_time(tv, "US/Pacific")
#'  
#' @family date and time functions
#' 
#' @seealso 
#' \code{\link{change_tz}} function which preserves time but changes time display; 
#' \code{Sys.time()} function of \strong{base} R. 
#' 
#' @export

change_time <- function(time, tz = ""){
  
  time_display <- NA
  out <- NA
  
  if (!is_POSIXlt(time)){ # For any other time object:
    
    message('change_time: Coercing time to "POSIXlt" without changing time display...')
    
    # A: Determine time_display: 
    if (is_POSIXct(time)){
      
      message('change_time: Parsing time from "POSIXct" as "%Y-%m-%d %H:%M:%S"...')
      time_display <- strptime(time, format = "%Y-%m-%d %H:%M:%S")
      
    } else if (is_Date(time)){
      
      message('change_time: Parsing time from "Date" as "%Y-%m-%d"...')      
      time_display <- strptime(time, format = "%Y-%m-%d")
      
    } else if (is.character(time)){
      
      # Get time_display by parsing date-time string (using standard formats):
      if (grepl(x = time, pattern = ".*(-).*( ).*(:).*(:).*")) { # date + full time:
        
        message('change_time: Parsing date-time from string as "%Y-%m-%d %H:%M:%S"...')
        time_display <- strptime(time, format = "%Y-%m-%d %H:%M:%S")
        
      } else if (grepl(x = time, pattern = ".*(-).*( ).*(:).*")) { # date + H:M time:
        
        message('change_time: Parsing date-time from string as "%Y-%m-%d %H:%M"...')
        time_display <- strptime(time, format = "%Y-%m-%d %H:%M")
        
      } else if (grepl(x = time, pattern = ".*(:).*(:).*")) { # H:M:S time:
        
        message('change_time: Parsing time (with default date) from string as "%H:%M:%S"...')
        time_display <- strptime(time, format = "%H:%M:%S")
        
      } else if (grepl(x = time, pattern = ".*(:).*")) { # H:M time:
        
        message('change_time: Parsing time (with default date) from string as "%H:%M"...')
        time_display <- strptime(time, format = "%H:%M")
        
      } else {
        
        message('change_time: Failed to parse time string.')
        
      }
      
    } else {
      
      message('change_time: Cannot parse time display.')
      
    }
    
    # B. Convert time_display into POSIXlt: 
    # print(paste0("time_display = ", time_display))  # debugging
    time <- as.POSIXlt(time_display, tz = tz)
    
  } # if (!is_POSIXlt(time)) end.
  
  # Convert from POSIXlt to POSIXct with tz:  
  out <- as.POSIXct(time, tz = tz)
  
  return(out)  
  
} # change_time end.

# # Check:
# change_time(as.POSIXlt(Sys.time()), tz = "UTC")
# 
# # from "POSIXlt" time:
# (t1 <- as.POSIXlt("2020-07-01 10:00:00", tz = "Europe/Berlin"))
# change_time(t1, "NZ")
# change_time(t1, "Europe/Berlin")
# change_time(t1, "US/Eastern")
# 
# # from "Date":
# dt <- as.Date("2020-12-31", tz = "US/Hawaii")
# change_time(dt, tz = "NZ")
# 
# # from time "string":
# ts <- "2020-12-31 20:30:45"
# change_time(ts, tz = "US/Pacific")
# 
# # from other "string" times:
# tx <- "7:30:45"
# change_time(tx, tz = "Asia/Calcutta")
# ty <- "1:30"
# change_time(ty, tz = "Europe/London")
# 
# # convert into local times:
# change_tz(change_time(t1, "NZ"), tz = "UTC")
# change_tz(change_time(t1, "Europe/Berlin"), tz = "UTC")
# change_tz(change_time(t1, "US/Eastern"), tz = "UTC")
# 
# # from "POSIXct" time:
# (tc <- as.POSIXct("2020-07-01 12:00:00", tz = "UTC"))
# change_time(tc, "NZ")
# 
# # with vector of "POSIXlt" times:
# t2 <- as.POSIXlt("2020-12-31 23:59:55", tz = "US/Pacific")
# tv <- c(t1, t2)  
# tv # uses tz of t1
# change_time(tv, "US/Pacific")


# change_tz: ------ 

# Task 1: Change nominal time to time zone, without changing actual time.

#' Change time zone (without changing represented time).  
#'
#' \code{change_tz} changes the nominal time zone (i.e., the time display) 
#' without changing the actual time.
#' 
#' \code{change_tz} expects inputs to \code{time} 
#' to be calendar time(s) (of the "POSIXct" class) 
#' and a valid time zone argument \code{tz} (as a string)
#' and returns the same time(s) as local time(s) 
#' (of the "POSIXlt" class). 
#' 
#' @param time Time (as a scalar or vector).    
#' If \code{time} is not a calendar time (of the "POSIXct" class) 
#' the function first tries coercing \code{time} into "POSIXct" 
#' without changing the denoted time.
#' 
#' @param tz Time zone (as character string).   
#' Default: \code{tz = ""} 
#' (i.e., current system time zone, \code{Sys.timezone()}). 
#' See \code{OlsonNames()} for valid options. 
#' 
#' @return A local time of class "POSIXlt". 
#' 
#' @examples
#' change_tz(Sys.time(), tz = "NZ")
#' change_tz(Sys.time(), tz = "US/Hawaii")
#' 
#' # from "POSIXct" time:
#' tc <- as.POSIXct("2020-07-01 12:00:00", tz = "UTC")
#' change_tz(tc, "Australia/Melbourne")
#' change_tz(tc, "Europe/Berlin")
#' change_tz(tc, "US/Pacific")
#' 
#' # from "POSIXlt" time:
#' tl <- as.POSIXlt("2020-07-01 12:00:00", tz = "UTC")
#' change_tz(tl, "Australia/Melbourne")
#' change_tz(tl, "Europe/Berlin")
#' change_tz(tl, "US/Pacific")
#' 
#' # from "Date":
#' dt <- as.Date("2020-12-31")
#' change_tz(dt, "NZ")
#' change_tz(dt, "US/Hawaii")  # Note different date!
#' 
#' # with a vector of "POSIXct" times:
#' t2 <- as.POSIXct("2020-12-31 23:59:55", tz = "US/Pacific")
#' tv <- c(tc, t2)
#' tv  # Note: Both times in tz of tc
#' change_tz(tv, "US/Pacific")
#' 
#' 
#' @family date and time functions
#' 
#' @seealso 
#' \code{\link{change_time}} function which preserves time display but changes time; 
#' \code{Sys.time()} function of \strong{base} R. 
#' 
#' @export

change_tz <- function(time, tz = ""){
  
  out <- NA
  
  if (!is_POSIXct(time)){
    
    message('change_tz: Coercing time to "POSIXct" without changing represented time...')
    time <- as.POSIXct(time)
    
  }
  
  # print(paste0("change_tz: time = ", format(time, "%F %T %Z"))) # debugging
  
  # convert nominal time (to POSIXlt):
  out <- as.POSIXlt(time, tz = tz)
  
  return(out)
  
} # change_tz end.

# # Check:
# change_tz(Sys.time(), tz = "NZ")
# change_tz(Sys.time(), tz = "US/Hawaii")
# 
# # from "POSIXct" time:
# tc <- as.POSIXct("2020-07-01 12:00:00", tz = "UTC")
# change_tz(tc, "Australia/Melbourne")
# change_tz(tc, "Europe/Berlin")
# change_tz(tc, "US/Pacific")
# 
# # from "POSIXlt" time:
# tl <- as.POSIXlt("2020-07-01 12:00:00", tz = "UTC")
# change_tz(tl, "Australia/Melbourne")
# change_tz(tl, "Europe/Berlin")
# change_tz(tl, "US/Pacific")
# 
# # from "Date":
# dt <- as.Date("2020-12-31")
# change_tz(dt, "NZ")
# change_tz(dt, "US/Hawaii")  # Note different date!
# # Compare:
# # lubridate::with_tz(dt, tzone = "NZ")         # same result
# # lubridate::with_tz(dt, tzone = "US/Hawaii")  # same result
#  
# # with a vector of "POSIXct" times:
# t2 <- as.POSIXct("2020-12-31 23:59:55", tz = "US/Pacific")
# tv <- c(tc, t2)
# tv  # Note: Both times in tz of tc
# change_tz(tv, "US/Pacific")
# # Compare:
# # lubridate::with_tz(tv, tzone = "US/Pacific")  # same results


# is_leap_year: ------ 

#' Is some year a so-called leap year?
#'
#' \code{is_leap_year} checks whether a given year 
#' (provided as a date or time \code{dt}, 
#' or number/string denoting a 4-digit year)  
#' lies in a so-called leap year (i.e., a year containing a date of Feb-29). 
#' 
#' When \code{dt} is not recognized as "Date" or "POSIXt" object(s), 
#' \code{is_leap_year} aims to parse a string \code{dt} 
#' as describing year(s) in a "dddd" (4-digit year) format,  
#' as a valid "Date" string (to retrieve the 4-digit year "\%Y"), 
#' or a numeric \code{dt} as 4-digit integer(s). 
#' 
#' \code{is_leap_year} then solves the task in two ways:  
#' 1. by verifying the numeric definition of a "leap year", and 
#' 2. by trying to use \code{as.Date()} for defining 
#' a "Date" of Feb-29 in the corresponding year(s). 
#' 
#' @param dt Date or time (scalar or vector). 
#' Numbers or strings with dates are parsed into 
#' 4-digit numbers denoting the year
#' 
#' @examples
#' is_leap_year(2020)
#' (days_this_year <- 365 + is_leap_year(Sys.Date()))
#' 
#' # from dates:
#' is_leap_year(Sys.Date())
#' is_leap_year(as.Date("2022-02-28"))
#' 
#' # from times:
#' is_leap_year(Sys.time())
#' is_leap_year(as.POSIXct("2022-10-11 10:11:12"))
#' is_leap_year(as.POSIXlt("2022-10-11 10:11:12"))
#' 
#' # from non-integers:
#' is_leap_year(2019.5)
#' 
#' # For vectors:
#' is_leap_year(2020:2028)
#' 
#' # with dt as strings:
#' is_leap_year(c("2020", "2021"))
#' is_leap_year(c("2020-02-29 01:02:03", "2021-02-28 01:02"))
#' 
#' # Note: Invalid date string yields error: 
#' # is_leap_year("2021-02-29")
#' 
#' 
#' @family date and time functions
#' 
#' @seealso 
#' \code{leap_year} function of the \strong{lubridate} package. 
#' 
#' @source 
#' See \url{https://en.wikipedia.org/wiki/Leap_year} for definition. 
#' 
#' @export

is_leap_year <- function(dt){
  
  # initialize: 
  y <- NA
  out <- NA
  out_2 <- NA
  
  # Determine y (as integer):
  if (is_Date(dt) | is_POSIXct(dt) | is_POSIXlt(dt)){
    
    y <- as.numeric(format(dt, format = "%Y"))
    
  } else if (is.character(dt)){
    
    if (all(grepl(x = dt, pattern = "^\\d\\d\\d\\d$"))) {
      
      # message('is_leap_year: Parsing string dt as "yyyy")...')      
      y <- as.numeric(dt)
      
    } else {
      
      message('is_leap_year: Coercing string dt into "Date" (to get "%Y")...')
      y <- as.numeric(format(as.Date(dt), format = "%Y"))
      
    }
    
  } else if (is.numeric(dt)){ 
    
    if (all(is.wholenumber(dt))){
      
      y <- dt
      
    } else {
      
      message('is_leap_year: Rounding numeric dt to nearest integer...')
      y <- round(dt, 0)
      
    }} else {
      
      message('is_leap_year: Failed to parse dt into year.')
      
    }
  
  # 2 solutions:
  # 1. Using definition from <https://en.wikipedia.org/wiki/Leap_year>:
  out <- (y %% 4 == 0) & ((y %% 100 != 0) | (y %% 400 == 0))
  # print(out)  # debugging
  
  # 2. Try defining Feb-29 as "Date" (NA if non-existent):
  feb_29 <- paste(as.character(y), "02", "29", sep = "-")
  out_2  <- !is.na(as.Date(feb_29, format = "%Y-%m-%d"))
  # print(out_2)  # debugging
  
  if (!all(out == out_2)){  # Warn of discrepancy: 
    warning("is_leap_year: Two solutions yield different results. Using 1st...")
  }
  
  return(out)
  
} # is_leap_year end. 


# ## Check:
# is_leap_year(2020)
# (days_this_year <- 365 + is_leap_year(Sys.Date()))
# 
# is_leap_year(Sys.Date())
# is_leap_year(as.Date("2022-10-11"))
# 
# is_leap_year(Sys.time())
# is_leap_year(as.POSIXct("2022-10-11 10:11:12"))
# is_leap_year(as.POSIXlt("2022-10-11 10:11:12"))
# 
# is_leap_year(2019.5)
# 
# # For vectors:
# v <- 2020:2028
# is_leap_year(v)
# 
# # with dt as strings:
# is_leap_year("2000")
# is_leap_year(c("2020", "2021"))
# is_leap_year(c("2020-02-29 01:02:03", "2021-02-28 01:02"))
# # Note: Invalid date string would yield error
# # is_leap_year("2021-02-29")



## (4) Compute differences between 2 dates (in various units/periods): ------  

# diff_days: Difference between two dates (in days): ------ 

diff_days <- function(from_date, to_date = Sys.Date(), units = "days", ...){
  
  # Assume that from_date and to_date are valid dates OR times:   
  # (Otherwise, see what_age() function below). 
  
  # Call difftime:
  t_diff <- base::difftime(to_date, from_date, units = units, ...)  # default: units = "days"
  
  n_days <- NA
  
  n_days <- as.numeric(t_diff)
  
  return(n_days)
  
} # diff_days end. 

## Check:
# ds <- Sys.Date() + -2:+2
# diff_days(ds)
#



# 
# last_year <- as.numeric(what_year()) - 1
# 
# paste(last_year, what_month(), what_day(), sep = "-")
#
# +++ here now +++


# what_age/diff_dates: What is someone's age (or some age difference) (in human units): ------

#' What is the age (or difference between dates) in human units? 
#'
#' \code{what_age} provides the difference between two dates 
#' (i.e., from some \code{from_date} to some \code{to_date}) 
#' in human measurement units (periods).
#' 
#' If not specified explicitly, \code{to_date} is set to 
#' today's date (i.e., \code{Sys.Date()}).
#' 
#' If the lengths of \code{from_date} and \code{to_date} differ, 
#' the arguments of \code{to_date} are recycled or 
#' truncated to the length of \code{from_date}. 
#' 
#' @param from_date From date (required, scalar or vector, as "Date"). 
#' Date of birth (DOB), assumed to be of class "Date", 
#' and coerced into "Date" when of class "POSIXt". 
#' 
#' @param to_date To date (optional, scalar or vector, as "Date"). 
#' Default: \code{to_date = Sys.Date()}. 
#' Maximum date/date of death (DOD), assumed to be of class "Date", 
#' and coerced into "Date" when of class "POSIXt". 
#' 
#' @param units Units used to represent output (as "character").
#' Units represent human time periods, rather than 
#' chronological time differences. 
#' Default: \code{units = "y"} for "years". 
#' Available options include:  
#' 
#' \enumerate{
#' 
#'   \item \code{units = "y"}: completed years (default)
#'   
#'   \item \code{units = "ym"}: completed years, months
#'   
#'   \item \code{units = "ymd"}: completed years, months, days
#'   
#'   }
#' 
#' @examples
#' y_100 <- Sys.Date() - (100 * 365.25) + -1:1
#' what_age(y_100)
#' 
#' # with "to_date" argument: 
#' y_050 <- Sys.Date() - (50 * 365.25) + -1:1 
#' what_age(y_100, y_050)
#' 
#' # robustness:
#' days_this_year <- 365 + is_leap_year(Sys.Date())
#' what_age(Sys.time() - (10 * (60 * 60 * 24) * days_this_year)) # for POSIXt times
#' what_age("90-07-11", to_date = "10-07-10")                    # for strings
#' what_age(19900711, to_date = 20100710)                        # for numbers
#' 
#' # recycling "to_date" to length of "from_date":
#' y_050_2 <- Sys.Date() - (50 * 365.25)
#' what_age(y_100, y_050_2)
#' 
#' # Using 'fame' data:
#' dob <- as.Date(fame$DOB, format = "%B %d, %Y")
#' dod <- as.Date(fame$DOD, format = "%B %d, %Y")
#' what_age(dob, dod)  # Note: Deceased people do not age further.
#' 
#' @family date and time functions
#' 
#' @export

what_age <- function(from_date, to_date = Sys.Date(), units = "y"){
  
  # (1) Preparation: ------  
  
  # (a) Handle NA inputs: ----
  
  if (any(is.na(from_date))){
    message('what_age: "from_date" must not be NA...')    
    return(NA)
  }
  
  if (all(is.na(to_date))){
    message('what_age: Changing "to_date" from NA to "Sys.Date()"...')       
    to_date <- Sys.Date()
  }
  
  # (b) Turn non-Date inputs into "Date" objects ---- 
  
  if (!is_Date(from_date)){
    # message('what_age: Aiming to parse "from_date" as "Date"...')
    from_date <- date_from_nonDate(from_date)
  }
  
  if (!is_Date(to_date)){
    # message('what_age: Aiming to parse "to_date" as "Date"...')
    to_date <- date_from_nonDate(to_date)
  }
  
  # (c) Recycle or truncate to_date argument based on from_date: ---- 
  n_from_date <- length(from_date)
  n_to_date   <- length(to_date)
  
  if (n_from_date != n_to_date){  # arguments differ in length:     
    
    if (n_to_date > n_from_date){ # 1. truncate to_date to the length of n_from_date: 
      
      to_date <- to_date[1:n_from_date]
      
    } else { # 2. recycle to_date to the length of n_from_date: 
      
      to_date <- rep(to_date, ceiling(n_from_date/n_to_date))[1:n_from_date]
      
    } # end else. 
  } # end if.
  
  # (d) Replace occasional NA values in to_date by current date: ---- 
  # Axiom: Dead people do not age any further, but 
  #        if to_date = NA, we want to measure until today: 
  set_to_date_NA_to_NOW <- TRUE  # if FALSE: Occasional to_date = NA values yield NA result.
  
  if (set_to_date_NA_to_NOW){
    
    if (!all(is.na(to_date))){  # only SOME to_date values are missing: 
      
      to_date[is.na(to_date)] <- Sys.Date()  # replace those NA values by Sys.Date()
      
    }
  }
  
  # } else { # ALL to_date are NA:
  
  # (e) Verify that from_date and to_date are "Date" objects: ---- 
  if (!is_Date(from_date)){
    message('what_age: "from_date" should be of class "Date"...')    
  }
  
  if (!is_Date(to_date)){
    message('what_age: "to_date" should be of class "Date"...')    
  }
  
  # (2) Main function: ------ 
  
  age <- NA  # initialize  
  
  # from_date elements (DOB):
  bd_year  <- as.numeric(format(from_date, "%Y"))
  bd_month <- as.numeric(format(from_date, "%m"))
  bd_day   <- as.numeric(format(from_date, "%d"))
  
  # to_date elements (DOD, max. date): 
  cur_year  <- as.numeric(format(to_date, "%Y"))
  cur_month <- as.numeric(format(to_date, "%m"))
  cur_day   <- as.numeric(format(to_date, "%d"))
  
  # Compute (completed) year component:  
  full_y <- NA
  
  # bday in this year? (as Boolean): 
  bd_ty <- ifelse((cur_month > bd_month) | ((cur_month == bd_month) & (cur_day >= bd_day)), TRUE, FALSE) 
  # print(bd_ty)
  
  full_y <- (cur_year - bd_year) - (1 * !bd_ty) 
  
  # Compute (completed) month component:
  full_m <- NA
  
  # bday in this month? (as Boolean): 
  bd_tm <- ifelse((cur_day >= bd_day), TRUE, FALSE) 
  # print(bd_tm)
  
  # # Distinguish 2 cases:
  # full_m[bd_ty]  <- (cur_month[bd_ty]  - bd_month[bd_ty])  - !bd_tm[bd_ty]        # 1:  bd_ty
  # full_m[!bd_ty] <- (12 + cur_month[!bd_ty] - bd_month[!bd_ty]) - !bd_tm[!bd_ty]  # 2: !bd_ty
  
  # Combine both cases:
  full_m <- (cur_month - bd_month) + (12 * !bd_ty) - (1 * !bd_tm) 
  
  # Compute (completed) day component:
  age_d <- NA
  ## bday today? (as Boolean): 
  # bd_td <- ifelse((cur_day == bd_day), TRUE, FALSE) 
  
  # +++ here now +++ 
  
  # Idea 1: Local solution: Determine N of days in last month.
  # Then use it to compute difference from bd_day to cur_day 
  
  # Idea 2: Global solution: Use global number of days and subtract all days of full years and months 
  # Need age_days() helper function to compute exact number of days between two dates:
  # age_d <- age_days(from_date = DOB, to_date) - age_days(from_date = DOB, to_date = bday_day_last_month)
  
  # Collect requested age units:
  age <- paste0(full_y, "y ", full_m, "m")
  
  return(age)
  
} # what_age end. 


# ## Check:

# # Months: 
# ms <- Sys.Date() - 366 + seq(from = -100, to = +100, by = 50)
# ms
# what_age(ms)

# y_100 <- Sys.Date() - (100 * 365.25) + -1:1
# y_100
# what_age(y_100)
# 
# # with "to_date" argument:
# y_050 <- Sys.Date() - (50 * 365.25) + -1:1
# y_050
# what_age(y_100, y_050)
#
# # recycling "to_date" to length of "from_date":
# y_050_2 <- Sys.Date() - (50 * 365.25)
# y_050_2
# what_age(y_100, y_050_2)
# 
# # Using 'fame' data:
# dob <- as.Date(fame$DOB, format = "%B %d, %Y")
# dod <- as.Date(fame$DOD, format = "%B %d, %Y")
# what_age(dob, dod)
# 
# # from strings:
# what_age("2000-12-31")
# what_age("90-01-02", to_date = "10-01-01")
#
# # from numbers:
# what_age(20001231)  # turned into character > Date
# what_age(19900711, to_date = 20100710)
# 
# # NAs:
# what_age(from_date = y_100, to_date = NA)
# what_age(from_date = NA, to_date = NA)

## ToDo: 
# - extend to include differences in "months" and "days"
# - add units argument (default = "years", but allowing for months and days). 
# - add n_decimals argument (default of 0).
# - consider renaming what_age() to diff_dates() 


## Done: ----------

# - Provided all what_ functions with a "when" argument that is set to Sys.Date() 
#   or Sys.time() by default, allowing for other dates/times for which question 
#   is answered (e.g., On what day was my birthday?) 
# - change_tz() and change_time() function(s) 
#   for converting time display (in "POSIXct") into local times (in "POSIXlt"), 
#   and vice versa (chaging times, but not time display). 

## ToDo: ----------

# - finish what_age (or date_diff) function. 

# - move time utility/helper functions into separate file.

# - update cur_ and what_ functions to use new helpers
# - re-consider what_day() to returns NUMERIC day in week/month/year.

# - fix ToDo in what_date() (Actively convert...)

# - Return dates/times either as strings (if as_string = TRUE) or 
#   as dates/times (of class "Date"/"POSIXct") in all what_() functions

## eof. ----------------------