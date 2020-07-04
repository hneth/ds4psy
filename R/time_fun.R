## time_fun.R | ds4psy
## hn | uni.kn | 2020 07 04
## ---------------------------

## Functions for date and time objects. 

# Note: The R base function 
# date()  # returns date as "Wed Aug 21 19:43:22 2019", 
# which is more than we usually want.

# Some simpler variants following a simple heuristic: 
# What is it that we _usually_ want to hear as `x` when asking 
# "What `x` is it today?" or "What `x` is it right now?"


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
#' dt <- cur_date(as_string = FALSE)
#' class(dt)
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
    return(format(d, fmt))  # formatted string
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
    return(format(t, fmt))  # formatted string
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

# About 5% are covered by 4 additional functions that ask `what_` questions
# about the position of some temporal unit in some larger continuum of time:
# 
# - `what_time()`:  more versatile version of cur_time() (accepting a when argument)
# - `what_date()`:  more versatile version of cur_date() (accepting a when argument)
# - `what_day()`  : as name (weekday, abbr or full), OR as number (in units of week, month, or year; as char or as integer)  
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
    return(format(t, fmt))  # formatted string
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
#' ts <- c("2020-12-24 01:02:03 CET", "2020-12-31 23:59:59")
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
#' \code{what_day()} function to obtain (week)days; 
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
    return(format(d, fmt))  # formatted string
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

# What day is it? (alternative version)
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

# what_day: What day is it? (name or number) ------ 
# what_day: as name (weekday, abbr or full), OR as number (in units of week, month, or year; as char or as integer) 

#' What day (of the week) is it?  
#'
#' \code{what_day} provides a satisficing version of 
#' to determine the day of the week 
#' corresponding to a given date.
#' 
#' \code{what_day} returns the weekday  
#' of \code{when} or of \code{Sys.Date()} 
#' (as a character string).
#' 
#' @param when Date (as a scalar or vector).    
#' Default: \code{when = Sys.Date()}. 
#' Using \code{as.Date(when)} to convert strings into dates 
#' if a different \code{when} is provided. 
#' 
#' @param abbr Boolean: Return abbreviated?  
#' Default: \code{abbr = FALSE}. 
#' 
#' @examples
#' what_day()
#' what_day(abbr = TRUE)
#' 
#' what_day(when = Sys.time())  # with POSIXct time
#' 
#' # with date vector (as characters):
#' ds <- c("2020-01-01", "2020-02-29", "2020-12-24", "2020-12-31")
#' what_day(when = ds)
#' what_day(when = ds, abbr = TRUE)
#' 
#' # with time vector (strings of POSIXct times):
#' ts <- c("2020-12-25 10:11:12 CET", "2020-12-31 23:59:59")
#' what_day(ts)
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

what_day <- function(when = Sys.Date(), abbr = FALSE){
  
  ## Robustness:
  # unit <- substr(tolower(unit), 1, 1)  # use only 1st letter of string
  
  # Convert when into objects of class "Date" representing calendar dates:
  if ( any(class(when) != "Date") & !("POSIXct" %in% class(when)) ) {
    message(paste0("what_day: Using as.Date() to convert 'when' into class 'Date'."))
    when <- as.Date(when)
  }
  
  # Verify date/time input:
  if ( any(class(when) != "Date") & !("POSIXct" %in% class(when)) ) {
    message(paste0("what_day: when must be of class 'Date' or 'POSIXct'."))
    message(paste0("Currently, class(when) = ", class(when), ".")) 
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
    d  <- format(when, "%a")  # Abbreviated weekday name in the current locale on this platform.
  } else {
    d  <- format(when, "%A")  # Full weekday name in the current locale.
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
  
}  # what_day end. 

# ## Check:
# what_day()
# what_day(abbr = TRUE)
# 
# # Other dates/times:
# d1 <- as.Date("2020-02-29")
# what_day(when = d1)
# what_day(when = d1, abbr = TRUE)
# 
# # Work with vectors (when as characters):
# ds <- c("2020-01-01", "2020-02-29", "2020-12-24", "2020-12-31")
# what_day(when = ds)
# what_day(when = ds, abbr = TRUE)
# 
# # Note: Errors
# what_day(when = "now")
# what_day(when = 123)


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
#' \code{what_day()} function to obtain (week)days; 
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
    
    w <- format(when, "%V")  # %V: week of the year as decimal number (01--53) as defined in ISO 8601 (week starts on Monday)
    
  } else {  # some other unit: 
    
    message("Unknown unit. Using unit = 'year':")
    w <- format(when, "%V")  # %V: week of the year as decimal number (01--53) as defined in ISO 8601 (week starts on Monday)
    
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
    
    m <- format(when, "%m")
    m <- as.integer(m)
    
  } else { # month name (as character):
    
    if (abbr){
      
      m <- format(when, "%b")  # Abbreviated month name in the current locale on this platform. 
      
    } else {
      
      m <- format(when, "%B")  # Full month name in the current locale. 
      
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
    y <- format(when, "%y") 
  } else { 
    y <- format(when, "%Y") 
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



# Time helper functions: Class of date/time object ------

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
#' Default: \code{tz = ""} (i.e., current system time zone,  
#' see \code{Sys.timezone()}). 
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
  
  if (!is_POSIXlt(time)){
    
    message('change_time: Coercing time to "POSIXlt" without changing time display...')
    
    if (is_POSIXct(time)){
      
      message('change_time: Parsing time from "POSIXct" as "%Y-%m-%d %H:%M:%S"...')
      time_display <- strptime(time, "%Y-%m-%d %H:%M:%S")
      
    } else if (is_Date(time)){
      
      message('change_time: Parsing time from "Date" as "%Y-%m-%d"...')      
      time_display <- strptime(time, "%Y-%m-%d")
      
    } else if (is.character(time)){
      
      # Aim to parse date-time string (using standard formats):
      if (grepl(x = time, pattern = ".*(-).*( ).*(:).*(:).*")) { # date + full time:
        
        message('change_time: Parsing time from string as "%Y-%m-%d %H:%M:%S"...')
        time_display <- strptime(time, "%Y-%m-%d %H:%M:%S")
        
      } else if (grepl(x = time, pattern = ".*(-).*( ).*(:).*")) { # date + H:M time:
        
        message('change_time: Parsing time from string as "%Y-%m-%d %H:%M"...')
        time_display <- strptime(time, "%Y-%m-%d %H:%M")
        
      } else if (grepl(x = time, pattern = ".*(:).*(:).*")) { # full time:
        
        message('change_time: Parsing time from string as "%H:%M:%S"...')
        time_display <- strptime(time, "%H:%M:%S")
        
      } else if (grepl(x = time, pattern = ".*(:).*")) { # H:M time:
        
        message('change_time: Parsing time from string as "%H:%M"...')
        time_display <- strptime(time, "%H:%M")
        
      } else {
        
        message('change_time: Failed to parse time string.')
        
      }
      
    } else {
      
      message('change_time: Cannot parse time display.')
      
    }
    
    # print(paste0("time_display = ", time_display))  # debugging
    time <- as.POSIXlt(time_display, tz = tz)
    
  }
  
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
#' Default: \code{tz = ""} (i.e., current system time zone,  
#' see \code{Sys.timezone()}). 
#' See \code{OlsonNames()} for valid options.  
#' 
#' @return A local time of class "POSIXlt". 
#' 
#' @examples
#' change_tz(Sys.time(), tz = "NZ")
#' 
#' # with "POSIXct" time:
#' (t1 <- as.POSIXct("2020-07-01 12:00:00", tz = "UTC"))
#' change_tz(t1, "NZ")
#' change_tz(t1, "Europe/Berlin")
#' change_tz(t1, "US/Eastern")
#' 
#' # with "POSIXlt" time:
#' (tl <- as.POSIXlt("2020-07-01 12:00:00", tz = "UTC"))
#' change_tz(tl, "NZ")
#' 
#' # with vector of "POSIXct" times:
#' t2 <- as.POSIXct("2020-12-31 23:59:55", tz = "US/Pacific")
#' tv <- c(t1, t2)  
#' tv # uses tz of t1
#' change_tz(tv, "US/Pacific")
#' 
#' @family date and time functions
#' 
#' @seealso 
#' \code{\link{change_time}} function which preserves time display but changes time; 
#' \code{Sys.time()} function of \strong{base} R. 
#' 
#' @export

change_tz <- function(time, tz = "", tz_org = ""){
  
  out <- NA
  
  if (!is_POSIXct(time)){
    # message('change_tz: Coercing time to "POSIXct" without changing actual time...')
    # time <- as.POSIXct(time, tz = tz_cur)
    
    message('change_tz: Changing time to "POSIXct" with tz_org...')    
    time <- change_time(time, tz = tz_org, tz_org = tz_org)
  }
  
  print(paste0("change_tz: time = ", time)) # debugging
  
  # convert nominal time (to POSIXlt):
  out <- as.POSIXlt(time, tz = tz)
  
  return(out)
  
}  # change_tz end.

# # Check:
# change_tz(Sys.time(), tz = "NZ")
# 
# # with "POSIXct" time:
# (t1 <- as.POSIXct("2020-07-01 12:00:00", tz = "UTC"))
# change_tz(t1, "NZ")
# change_tz(t1, "Europe/Berlin")
# change_tz(t1, "US/Eastern")
# 
# # with "POSIXlt" time:
# (tl <- as.POSIXlt("2020-07-01 12:00:00", tz = "UTC"))
# change_tz(tl, "NZ")
# 
# # with vector of "POSIXct" times:
# t2 <- as.POSIXct("2020-12-31 23:59:55", tz = "US/Pacific")
# tv <- c(t1, t2)  
# tv # uses tz of t1
# change_tz(tv, "US/Pacific")

# with "Date":
# d <- as.Date("2020-12-31")
# change_tz(d, tz = "NZ", tz_org = "US/Pacific")



# is_leap_year:  ------ 

#' Is date or time in a leap year?   
#'
#' \code{is_leap_year} checks whether a given date or time \code{dt} 
#' is in a so-called leap year (with a date of February 29). 
#' 
#' When \code{dt} is not recognized as date or time object(s), 
#' \code{is_leap_year} aims to interpret it as an integer  
#' that corresponds to a year (in the 4-digit "%Y" format). 
#' 
#' \code{is_leap_year} solves the task in two ways:  
#' 1. by verifying the numeric definition of a "leap year", and 
#' 2. by trying to use \code{as.Date()} for defining 
#' a "Date" of Feb-29 in the corresponding year(s). 
#' 
#' @param dt Date or time (scalar or vector).
#' 
#' @examples
#' # Check:
#' is_leap_year(2020)    # integer
#' is_leap_year("2021")  # character
#' 
#' # from dates:
#' is_leap_year(Sys.Date())
#' is_leap_year(as.Date("2022-10-11"))
#' 
#' # from times: 
#' is_leap_year(Sys.time())
#' is_leap_year(as.POSIXct("2022-10-11 10:11:12"))
#' is_leap_year(as.POSIXlt("2022-10-11 10:11:12"))
#' 
#' # Decimal number: 
#' is_leap_year(2019.5)
#' 
#' # With vectors:
#' v <- 2020:2028
#' is_leap_year(v)
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
    
  } else {  # dt NOT a date/time object: 
    
    if (all(is.wholenumber(dt))){
      
      y <- dt
      
    } else if (is.character(dt)){
      
      message('is_leap_year: Coercing dt from character to numeric...')
      dt <- as.numeric(dt)
      
    } else if (!all(is.wholenumber(dt)) & is.numeric(dt)){
      
      message('is_leap_year: Rounding numeric dt to nearest integer...')
      y <- round(dt, 0)
      
    } else {
      
      message('is_leap_year: Failed to parse dt into year.')
      
    }
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

# # Check:
# is_leap_year(2020)
# is_leap_year("2021")
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


## Done: ----------

# - Provided all what_ functions with a "when" argument that is set to Sys.Date() 
#   or Sys.time() by default, allowing for other dates/times for which question 
#   is answered (e.g., On what day was my birthday?) 
# - change_tz() and change_time() function(s) 
#   for converting time display (in "POSIXct") into local times (in "POSIXlt"), 
#   and vice versa (chaging times, but not time display). 

## ToDo: ----------

# - Return dates/times either as strings (if as_string = TRUE) or 
#   as dates/times (of class "Date"/"POSIXct") in all what_() functions

## eof. ----------------------