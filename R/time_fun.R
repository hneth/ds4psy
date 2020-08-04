## time_fun.R | ds4psy
## hn | uni.kn | 2020 08 04
## ---------------------------

## Main functions for date and time objects. 

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
  
  # 0. Initialize: 
  d <- NA  
  
  # 1. Get system date: 
  # d <- Sys.time() # current time (optimizing options)
  d <- Sys.Date()  # current date (satisficing solution) 
  
  # 2. Format instruction string:   
  if (rev){
    
    fmt <- paste("%d", "%m", "%Y", sep = sep, collapse = "")  # using sep
    
  } else {
    
    fmt <- paste("%Y", "%m", "%d", sep = sep, collapse = "")  # using sep
  }
  
  # 3. Output: 
  
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
  
} # cur_date end. 

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
  
  # 0. Initialize: 
  t <- NA
  
  # 1. Current time: 
  t <- Sys.time()
  
  # 2. Format instruction string: 
  if (seconds) {
    
    fmt <- paste("%H", "%M", "%S", sep = sep, collapse = "")  # %S and using sep
    
  } else {
    
    fmt <- paste("%H", "%M",       sep = sep, collapse = "")  # no %S, using sep
  }
  
  # 3. Output: 
  
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
#' t1  # time display changed, due to tz
#' 
#' # return "POSIXct" object(s):
#' # Same time in differen tz:
#' t2 <- what_time(as.POSIXct("2020-02-29 10:00:00"), as_string = FALSE, tz = "US/Hawaii")
#' format(t2, "%F %T %Z (UTF %z)")
#' # from string:
#' t3 <- what_time("2020-02-29 10:00:00", as_string = FALSE, tz = "US/Hawaii")
#' format(t3, "%F %T %Z (UTF %z)")
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
  
  # 0. Initialize:
  t <- NA
  
  # 1. Check when argument: 
  if (all(is.na(when))){
    
    t <- Sys.time()  # use current time
    
  } else { # interpret when:
    
    if (!is_POSIXct(when)){    
      
      t <- time_from_noPOSIXt(when)
      
      # # same time display in different tz (i.e., different time): 
      # t <- time_from_noPOSIXt(when, tz = tz)
      
    } else {
      
      t <- when  # copy
      
    }
  }
  
  # 2. Verify class: 
  if (!is_POSIXt(t)){
    message(paste0('what_time: "t" is not of class "POSIXt".'))
    # return(t)
  }
  
  # 3. Change time display into time zone tz:
  if (tz != ""){
    
    message("Changing tz (but keeping original time).")
    t <- change_tz(t, tz = tz)
    
  }
  
  # 4. Format output:
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
  
  # 5. Output: 
  if (as_string){
    
    return(format(t, format = fmt))  # formatted string
    # return(print(format(t, fmt)))  # print string
    # return(cat(format(t, fmt)))    # no string
    
  } else {
    
    return(t)  # as POSIXt
    
  }
  
} # what_time end.

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
#' # return a "Date" object:
#' dt <- what_date(as_string = FALSE)
#' class(dt)
#' 
#' # with time zone: 
#' ts <- ISOdate(2020, 12, 24, c(0, 12))  # midnight and midday UTC
#' what_date(when = ts, tz = "US/Hawaii", as_string = FALSE)
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

what_date <- function(when = NA, rev = FALSE, as_string = TRUE, 
                      sep = "-", month_form = "m", tz = ""){
  
  # 0. Initialize: 
  d <- NA
  
  # 1. Check when argument: 
  if (all(is.na(when))){
    
    # d <- Sys.time() # current time (optimizing options)
    d <- Sys.Date()  # current date (satisficing solution) 
    
  } else {  
    
    # interpret when: 
    if (!is_Date(when)){
      # message('what_date: Aiming to parse "when" as "Date".')
      d <- date_from_noDate(when, tz = tz)
    } else {
      d <- as.Date(when, tz = tz)  # as Date (with passive tz) 
    }
    
  }
  
  # 2. Verify class: 
  if (!is_Date(d)){
    message(paste0('what_date: "d" is not of class "Date".'))
    # return(d)
  }
  
  # 3. Convert into time zone tz:
  if (tz != ""){
    
    message("Converting date(s) into tz.")
    d <- change_tz(d, tz = tz)
    
  }
  
  # 4. Format output:
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
  
  # 5. Output: 
  if (as_string){
    
    return(format(d, format = fmt))  # formatted string
    # return(print(format(d, fmt)))  # print string
    # return(cat(format(d, fmt)))    # no string
    
  } else {
    
    return(d)  # as Date
    
  }
  
} # what_date end. 

# ## Check:
# what_date()
# what_date(as_string = FALSE)
#
# what_date(sep = "/")
# what_date(rev = TRUE)
# what_date(rev = TRUE, sep = ".")
# what_date(rev = TRUE, sep = " ", month_form = "B")
# 
# what_date(c("2020-01-01", "2020-12-31"), tz = "Australia/Sydney", as_string = FALSE)
# ds <- c("2020-01-15 01:02:03 NZ", "2020-12-31 14:15:16")  # POSIXct
# what_date(ds, tz = "NZ", as_string = FALSE)
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
#' what_wday(20200229)           # number (of valid date)
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
#' # fame data:
#' greta_dob <- as.Date(fame[grep(fame$name, pattern = "Greta") , ]$DOB, "%B %d, %Y")
#' what_wday(greta_dob)  # Friday, of course.
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
  
  # 0. Initialize:
  d <- as.character(NA) 
  
  # 1. Handle inputs: 
  if (!is_Date(when)){
    # message('what_wday: Aiming to parse "when" as "Date".')
    when <- date_from_noDate(when)
  }
  
  if (!is_Date(when)){
    
    message(paste0('what_wday: "when" must be of class "Date".'))
    return(when)
    
  }
  
  # 2. Main: weekday d (as char):
  
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
  
  # 3. Output: 
  ## as char or integer:
  # if (as_integer) {
  #  as.integer(d)
  # } else {
  d
  # }
  
} # what_wday end. 

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
# 
# Bday of Greta Thunberg?
# greta_dob <- as.Date(fame[grep(fame$name, pattern = "Greta") , ]$DOB, "%B %d, %Y")
# what_wday(greta_dob)  # Friday, of course.


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
#' d1 <- as.Date("2020-12-24")
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
  
  # 0. Initialize:
  w <- NA
  
  # 1. Handle inputs: 
  if (!is_Date(when)){
    
    # message('what_wday: Aiming to parse "when" as "Date".')
    when <- date_from_noDate(when)
    
  }
  
  if (!is_Date(when)){
    
    message(paste0('what_wday: "when" must be of class "Date".'))
    return(when)
    
  }
  
  # Robustness:
  unit <- substr(tolower(unit), 1, 1)  # use only 1st letter of string
  
  
  # 2. Main: Get week w (as char):
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
  
  # 3. Output (as char or integer):
  if (as_integer) {
    
    return(as.integer(w))
    
  } else {
    
    return(w)
    
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
  
  # 0. Initialize:
  m <- NA
  
  # 1. Handle inputs: 
  if (!is_Date(when)){
    
    # message('what_wday: Aiming to parse "when" as "Date".')
    when <- date_from_noDate(when)
    
  }
  
  if (!is_Date(when)){
    
    message(paste0('what_wday: "when" must be of class "Date".'))
    return(when)
    
  }
  
  # 2. Main: Get month m (as char):
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
  
  # 3. Output (as char or integer):
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
  
  # 0. Initialize:
  y <- NA
  
  # 1. Handle inputs: 
  if (!is_Date(when)){
    
    # message('what_wday: Aiming to parse "when" as "Date".')
    when <- date_from_noDate(when)
    
  }
  
  if (!is_Date(when)){
    
    message(paste0('what_wday: "when" must be of class "Date".'))
    return(when)
    
  }
  
  # 2. Main: Get year y:
  if (abbr){ 
    
    y <- format(when, format = "%y") 
    
  } else { 
    
    y <- format(when, format = "%Y") 
    
  } 
  
  # 3. Output (as char or integer):
  if (as_integer) {
    
    return(as.integer(y))
    
  } else {
    
    return(y)
    
  }
  
} # what_year end. 

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



## (3) Time conversions: ---------- 


# change_time: ------ 

# Task 2: Change time zone AND actual time, without changing represented time (i.e., time display): 

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
#' t1 <- as.POSIXlt("2020-01-01 10:20:30", tz = "Europe/Berlin")
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
#' (l1 <- as.POSIXlt("2020-06-01 10:11:12"))
#' change_tz(change_time(l1, "NZ"), tz = "UTC")
#' change_tz(change_time(l1, "Europe/Berlin"), tz = "UTC")
#' change_tz(change_time(l1, "US/Eastern"), tz = "UTC")
#' 
#' # with vector of "POSIXlt" times:
#' (l2 <- as.POSIXlt("2020-12-31 23:59:55", tz = "US/Pacific"))
#' (tv <- c(l1, l2))              # uses tz of l1
#' change_time(tv, "US/Pacific")  # change time and tz
#'  
#' @family date and time functions
#' 
#' @seealso 
#' \code{\link{change_tz}} function which preserves time but changes time display; 
#' \code{Sys.time()} function of \strong{base} R. 
#' 
#' @export

change_time <- function(time, tz = ""){
  
  # 0. Initialize: 
  ct <- NA
  t_display <- NA
  
  # 1. Need local time "POSIXlt" input: 
  # If NOT:
  # A. Parse time to get t_display:   
  # B. Convert t_display into "POSIXlt" 
  
  if (!is_POSIXlt(time)){
    
    # message('change_time: Coercing time to "POSIXlt" with SAME time display.')
    
    # A: Get t_display from various date-time objects:  
    if (is_POSIXct(time)){
      
      # message('change_time: Parsing time from "POSIXct" as "%Y-%m-%d %H:%M:%S".')
      t_display <- strptime(time, format = "%Y-%m-%d %H:%M:%S")
      
    } else if (is_Date(time)){
      
      # message('change_time: Parsing time from "Date" as "%Y-%m-%d".')      
      t_display <- strptime(time, format = "%Y-%m-%d")
      
    } else if (is.character(time)){
      
      # Get t_display by parsing date-time string (using standard formats):
      if (grepl(x = time, pattern = ".*(-).*( ).*(:).*(:).*")) { # date + full time:
        
        # message('change_time: Parsing date-time from string as "%Y-%m-%d %H:%M:%S".')
        t_display <- strptime(time, format = "%Y-%m-%d %H:%M:%S")
        
      } else if (grepl(x = time, pattern = ".*(-).*( ).*(:).*")) { # date + H:M time:
        
        # message('change_time: Parsing date-time from string as "%Y-%m-%d %H:%M".')
        t_display <- strptime(time, format = "%Y-%m-%d %H:%M")
        
      } else if (grepl(x = time, pattern = ".*(:).*(:).*")) { # H:M:S time:
        
        # message('change_time: Parsing time (with default date) from string as "%H:%M:%S".')
        t_display <- strptime(time, format = "%H:%M:%S")
        
      } else if (grepl(x = time, pattern = ".*(:).*")) { # H:M time:
        
        # message('change_time: Parsing time (with default date) from string as "%H:%M".')
        t_display <- strptime(time, format = "%H:%M")
        
      } else {
        
        message('change_time: Failed to parse time string.')
        
      }
      
    } else {
      
      message('change_time: Cannot parse time display.')
      
    } # various time classes end.
    
    # B. Convert t_display into POSIXlt: 
    # print(paste0("t_display = ", t_display))  # debugging
    time <- as.POSIXlt(t_display, tz = tz)  # Note: tz = "" by default. 
    
  } # if (!is_POSIXlt(time)) end.
  
  # 2. Main: Convert time from POSIXlt to POSIXct with tz:  
  ct <- as.POSIXct(time, tz = tz)  # Note: tz = "" by default. 
  
  # 3. Output: 
  return(ct)  
  
} # change_time end.

# ## Check:
# change_time(as.POSIXlt(Sys.time()), tz = "NZ")
# # 
# # # from "POSIXlt" time:
# (t1 <- as.POSIXlt("2020-01-10 10:20:30", tz = "Europe/Berlin"))
# change_time(t1, "NZ")
# change_time(t1, "Europe/Berlin")
# change_time(t1, "US/Eastern")
# 
# from "Date":
# dt <- as.Date("2020-12-31", tz = "US/Hawaii")
# format(dt, "%F %T %Z")  # Note: tz ignored.
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
#' @family date and time functions
#' 
#' @seealso 
#' \code{\link{change_time}} function which preserves time display but changes time; 
#' \code{Sys.time()} function of \strong{base} R. 
#' 
#' @export

change_tz <- function(time, tz = ""){
  
  # 0. Initialize: 
  out <- NA
  
  # 1. Parse time: 
  if (!is_POSIXct(time)){
    
    # message('change_tz: Coercing time to "POSIXct" without changing represented time.')
    
    time <- as.POSIXct(time)  # Note: tz = "" by default. 
    
  }
  
  # print(paste0("change_tz: time = ", format(time, "%F %T %Z"))) # debugging
  
  # 2. Main: Convert nominal time (to POSIXlt):
  out <- as.POSIXlt(time, tz = tz)  # Note: tz = "" by default. 
  
  # 3. Output: 
  return(out)
  
} # change_tz end.

# # Check:
# change_tz(Sys.time(), tz = "NZ")
# change_tz(Sys.time(), tz = "US/Hawaii")
# 
# # from "POSIXct" time:
# tc <- as.POSIXct("2020-07-01 12:30:00", tz = "UTC")
# change_tz(tc, "NZ")  # Note: Date effect!
# change_tz(tc, "Australia/Melbourne")
# change_tz(tc, "Europe/Berlin")
# change_tz(tc, "US/Pacific")
# 
# # from "POSIXlt" time:
# tl <- as.POSIXlt("2020-07-01 12:30:00", tz = "UTC")
# change_tz(tl, "NZ")  # Note: Date effect!
# change_tz(tl, "Australia/Melbourne")
# change_tz(tl, "Europe/Berlin")
# change_tz(tl, "US/Pacific")
# 
# # from "Date":
# dt <- as.Date("2020-12-31")
# change_tz(dt, "NZ")
# change_tz(dt, "US/Hawaii")  # Note different date!
# # Compare:
# lubridate::with_tz(dt, tzone = "NZ")         # same result
# lubridate::with_tz(dt, tzone = "US/Hawaii")  # same result
# 
# # with a vector of "POSIXct" times:
# (t2 <- as.POSIXct("2020-12-31 23:59:55", tz = "US/Pacific"))
# (tv <- c(tc, t2))  # Note: Both times in tz of tc
# change_tz(tv, "US/Pacific")
# # Compare:
# lubridate::with_tz(tv, tzone = "US/Pacific")  # same results



## (4) Compute differences between 2 dates/times (in human time units/periods): ------  

# diff_days: Difference between two dates (in days, with optional decimals): ------ 

diff_days <- function(from_date, to_date = Sys.Date(), units = "days", as_Date = TRUE, ...){
  
  # 0. Initialize:
  n_days <- NA
  
  # 1. Handle inputs: Assume/convert times into 2 "Date" objects 
  if (as_Date) { # Convert non-Date (e.g., POSIXt) into "Date" objects:
    
    if (!is_Date(from_date)) { from_date <- date_from_noDate(from_date, ...) }
    
    if (!is_Date(to_date))   { to_date <- date_from_noDate(to_date, ...) }
    
  }
  
  # 2. Main: Use difftime:
  t_diff <- base::difftime(to_date, from_date, units = units, ...)  # default: units = "days"
  
  # 3. Output:
  n_days <- as.numeric(t_diff)
  
  return(n_days)
  
} # diff_days end. 

# ## Check:
# ds <- Sys.Date() + -2:+2
# diff_days(ds)
# 
# one_year_ago <- Sys.Date() - (365 + is_leap_year(Sys.Date()))
# diff_days(one_year_ago)
# 
# ## Note: "Date" objects with DECIMALS are possible:
# (d1 <- Sys.Date())
# (d2 <- Sys.Date() + 1.75)
# diff_days(d1, d2)
# 
# ## Note: Date vs. time differences:
# t0 <- as.POSIXct("2020-07-10 00:00:01", tz = "UTC")  # start of day
# t1 <- as.POSIXct("2020-07-10 23:59:59", tz = "UTC")  # end of day
# t2 <- t1 + 2  # 2 seconds after t1 (but next date)
# 
# # By default, only Dates are considered:
# diff_days(t0, t1)
# diff_days(t1, t2)
# diff_days(t0, t2)
# 
# # Other units: as_Date must be FALSE:
# diff_days(t0, t1, units = "secs", as_Date = FALSE)
# diff_days(t1, t2, units = "secs", as_Date = FALSE)
# diff_days(t0, t2, units = "secs", as_Date = FALSE)
# 
# diff_days(t0, t1, units = "weeks", as_Date = FALSE)
# diff_days(t1, t2, units = "hours", as_Date = FALSE)
# diff_days(t0, t2, units = "mins", as_Date = FALSE)
# 
# # Exact time differences (with decimals):
# diff_days(t0, t1, as_Date = FALSE)
# diff_days(t1, t2, as_Date = FALSE)
# diff_days(t0, t2, as_Date = FALSE)


# diff_dates: Compute date difference (i.e., age) in human units: ------

#' Get the difference between two dates (in human units).  
#'
#' \code{diff_dates} computes the difference between two dates 
#' (i.e., from some \code{from_date} to some \code{to_date}) 
#' in human measurement units (periods).
#' 
#' \code{diff_dates} answers questions like 
#' "How much time has elapsed between two dates?" 
#' or "How old are you?" in human time periods 
#' of (full) years, months, and days. 
#' 
#' Key characteristics:
#' 
#' \itemize{
#' 
#'   \item If \code{to_date} or \code{from_date} are not "Date" objects, 
#'   \code{diff_dates} aims to coerce them into "Date" objects. 
#' 
#'   \item If \code{to_date} is missing (i.e., \code{NA}), 
#'   \code{to_date} is set to today's date (i.e., \code{Sys.Date()}).
#'   
#'   \item If \code{to_date} is specified, any intermittent missing values 
#'   (i.e., \code{NA}) are set to today's date (i.e., \code{Sys.Date()}). 
#'   Thus, dead people (with both birth dates and death dates specified) 
#'   do not age any further, but people still alive (with \code{is.na(to_date)}, 
#'   are measured to today's date (i.e., \code{Sys.Date()}). 
#' 
#'   \item If \code{to_date} precedes \code{from_date} (i.e., \code{from_date > to_date}) 
#'   computations are performed on swapped days and 
#'   the result is marked as negative (by a character \code{"-"}) in the output.
#' 
#'   \item If the lengths of \code{from_date} and \code{to_date} differ, 
#'   the shorter vector is recycled to the length of the longer one. 
#' 
#' }
#' 
#' By default, \code{diff_dates} provides output as (signed) character strings. 
#' For numeric outputs, use \code{as_character = FALSE}. 
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
#' @param unit Largest measurement unit for representing results. 
#' Units represent human time periods, rather than 
#' chronological time differences. 
#' Default: \code{unit = "years"} for completed years, months, and days. 
#' Options available: 
#' \enumerate{
#' 
#'   \item \code{unit = "years"}: completed years, months, and days (default)
#'   
#'   \item \code{unit = "months"}: completed months, and days
#'   
#'   \item \code{unit = "days"}: completed days
#'   
#'   }
#' Units may be abbreviated. 
#'   
#' @param as_character Boolean: Return output as character? 
#' Default: \code{as_character = TRUE}.  
#' If \code{as_character = FALSE}, results are returned 
#' as columns of a data frame 
#' and include \code{from_date} and \code{to_date}. 
#' 
#' @return A character vector or data frame 
#' (with dates, sign, and numeric columns for units).
#' 
#' @examples
#' y_100 <- Sys.Date() - (100 * 365.25) + -1:1
#' diff_dates(y_100)
#' 
#' # with "to_date" argument: 
#' y_050 <- Sys.Date() - (50 * 365.25) + -1:1 
#' diff_dates(y_100, y_050)
#' diff_dates(y_100, y_050, unit = "d") # days (with decimals)
#' 
#' # Time unit and output format:
#' ds_from <- as.Date("2010-01-01") + 0:2
#' ds_to   <- as.Date("2020-03-01")  # (2020 is leap year)
#' diff_dates(ds_from, ds_to, unit = "y", as_character = FALSE)  # years
#' diff_dates(ds_from, ds_to, unit = "m", as_character = FALSE)  # months
#' diff_dates(ds_from, ds_to, unit = "d", as_character = FALSE)  # days
#' 
#' # Robustness:
#' days_cur_year <- 365 + is_leap_year(Sys.Date())
#' diff_dates(Sys.time() - (1 * (60 * 60 * 24) * days_cur_year))  # for POSIXt times
#' diff_dates("10-08-11", "20-08-10")   # for strings
#' diff_dates(20200228, 20200301)       # for numbers (2020 is leap year)
#' 
#' # Recycling "to_date" to length of "from_date":
#' y_050_2 <- Sys.Date() - (50 * 365.25)
#' diff_dates(y_100, y_050_2)
#' 
#' # Note maxima and minima: 
#' diff_dates("0000-01-01", "9999-12-31")  # max. d + m + y
#' diff_dates("1000-06-01", "1000-06-01")  # min. d + m + y
#' 
#' # If from_date == to_date:
#' diff_dates("2000-01-01", "2000-01-01")
#' 
#' # If from_date > to_date:
#' diff_dates("2000-01-02", "2000-01-01")  # Note negation "-"
#' diff_dates("2000-02-01", "2000-01-01", as_character = TRUE)
#' diff_dates("2001-02-02", "2000-02-02", as_character = FALSE)
#' 
#' # Test random date samples:
#' f_d <- sample_date(size = 10)
#' t_d <- sample_date(size = 10)
#' diff_dates(f_d, t_d, as_character = TRUE)
#' 
#' # Using 'fame' data:
#' dob <- as.Date(fame$DOB, format = "%B %d, %Y")
#' dod <- as.Date(fame$DOD, format = "%B %d, %Y")
#' head(diff_dates(dob, dod))  # Note: Deceased people do not age further.
#' head(diff_dates(dob, dod, as_character = FALSE))  # numeric outputs
#' 
#' @family date and time functions
#' 
#' @seealso 
#' Time spans (\code{interval} \code{as.period}) in the \strong{lubridate} package. 
#' 
#' @export

diff_dates <- function(from_date, to_date = Sys.Date(), 
                       unit = "years", as_character = TRUE){
  
  # 0. Initialize: 
  today <- Sys.Date()  # (do only once)
  age   <- NA
  
  # 1. Handle inputs: ------  
  
  # (a) NA inputs: ----
  
  if (any(is.na(from_date))){
    message('diff_dates: "from_date" must not be NA.')    
    return(NA)
  }
  
  if (all(is.na(to_date))){
    message('diff_dates: Changing "to_date" from NA to "Sys.Date()".')       
    to_date <- today 
  }
  
  # (b) Turn non-Date inputs into "Date" objects ---- 
  
  if (!is_Date(from_date)){
    # message('diff_dates: Aiming to parse "from_date" as "Date".')
    from_date <- date_from_noDate(from_date)
  }
  
  if (!is_Date(to_date)){
    # message('diff_dates: Aiming to parse "to_date" as "Date".')
    to_date <- date_from_noDate(to_date)
  }
  
  # (c) Recycle shorter date vector to length of longer one: ----
  aligned_v  <- align_vector_pair(v1 = from_date, v2 = to_date)
  from_date <- aligned_v[[1]]
  to_date   <- aligned_v[[2]]
  
  ## WAS: 
  # (c) Recycle or truncate to_date argument based on from_date: 
  # to_date <- align_vector_length(v_fixed = from_date, v_change = to_date)
  
  # Note: from_date and to_date now have the same length: 
  n_dates <- length(from_date)
  
  # (d) Replace intermittent NA values in to_date by current date: ---- 
  # Axiom: Dead people do not age any further, but 
  #        if to_date = NA, we want to measure until today: 
  set_to_date_NA_to_NOW <- TRUE  # if FALSE: Occasional to_date = NA values yield NA result.
  
  if (set_to_date_NA_to_NOW){
    
    if (!all(is.na(to_date))){  # only SOME to_date values are missing: 
      
      to_date[is.na(to_date)] <- today  # replace those NA values by today = Sys.Date()
      
    }
  }
  
  # (e) Verify that from_date and to_date are "Date" objects: ---- 
  if (!is_Date(from_date)){
    message('diff_dates: "from_date" should be of class "Date".')
    # print(from_date)  # debugging
  }
  
  if (!is_Date(to_date)){
    message('diff_dates: "to_date" should be of class "Date".')
    # print(to_date)    # debugging
  }
  
  
  # (f) For cases of (from_date > to_date): Swap dates and negate sign:
  
  from_date_org <- from_date  # store original orders
  to_date_org   <- to_date    # (to list in outputs)
  
  ix_swap <- (from_date > to_date)       # ix of cases to swap 
  from_date_temp <- from_date[ix_swap]   # temporary storage
  
  from_date[ix_swap] <- to_date[ix_swap] # from_date by to_date
  to_date[ix_swap]   <- from_date_temp   # to_date by from_date
  
  sign <- rep("", n_dates)  # initialize (as character)
  sign[ix_swap] <- "-"      # negate sign (character)
  
  # message(sign)  # debugging
  
  
  # (g) Unit: ----
  unit <- substr(tolower(unit), 1, 1)  # robustness: use only 1st letter: y/m/d
  
  if (!unit %in% c("y", "m", "d")){
    message('diff_dates: unit must be "year", "month", or "day". Using "year".')
    unit <- "y"
  }
  
  
  # 2. Main function: ------ 
  
  # (a) initialize other variables: 
  full_y <- NA
  full_m <- NA
  full_d <- NA
  full_d_1 <- NA
  full_d_2 <- NA
  
  # (b) Special case: unit == "d" ---- 
  
  if (unit == "d"){
    
    # Use diff_days() helper/utility function: 
    full_d <- diff_days(from_date = from_date, to_date = to_date)
    
    if (as_character){
      
      age <- paste0(sign, full_d, "d") 
      
    } else { # return a data frame:
      
      age <- data.frame("from_date" = from_date_org,
                        "to_date"   = to_date_org, 
                        "neg" = sign,  # negation sign? 
                        "d" = full_d, 
                        row.names = 1:n_dates) 
    }
    
    return(age)
    
  }
  
  # (c) All other units (y/m): Get date elements ---- 
  
  # from_date elements (DOB):
  bd_y <- as.numeric(format(from_date, "%Y"))
  bd_m <- as.numeric(format(from_date, "%m"))
  bd_d <- as.numeric(format(from_date, "%d"))
  
  # to_date elements (DOD, max. date): 
  to_y <- as.numeric(format(to_date, "%Y"))
  to_m <- as.numeric(format(to_date, "%m"))
  to_d <- as.numeric(format(to_date, "%d"))
  
  
  # (c1) Completed years: 
  
  # bday this year? (as Boolean): 
  bd_ty <- ifelse((to_m > bd_m) | ((to_m == bd_m) & (to_d >= bd_d)), TRUE, FALSE) 
  # print(bd_ty)
  
  full_y <- (to_y - bd_y) - (1 * !bd_ty)
  
  
  # (c2) Completed months: 
  
  # bday this month? (as Boolean): 
  bd_tm <- ifelse((to_d >= bd_d), TRUE, FALSE) 
  # print(bd_tm)
  
  ## Distinguish 2 cases:
  # full_m[bd_ty]  <- (to_m[bd_ty]  - bd_m[bd_ty])  - !bd_tm[bd_ty]        # 1:  bd_ty
  # full_m[!bd_ty] <- (12 + to_m[!bd_ty] - bd_m[!bd_ty]) - !bd_tm[!bd_ty]  # 2: !bd_ty
  
  ## Combine both cases:
  full_m <- (to_m - bd_m) + (12 * !bd_ty) - (1 * !bd_tm) 
  
  if (unit == "m"){
    
    full_m <- (12 * full_y) + full_m  # express years in months
    
  }
  
  
  # (c3) Completed days: 
  
  ## bday today? (as Boolean): 
  # bd_td <- ifelse((to_d == bd_d), TRUE, FALSE) 
  
  # Use 2 solutions:
  
  # s_1: LOCAL solution: Determine the number N of days in last month.
  #      Then use this number to compute difference from bd_d to to_d 
  
  ## Distinguish 2 cases:  
  # full_d_1[bd_tm]  <- to_d[bd_tm]  - bd_d[bd_tm]  # 1:  bd_tm: days since bd_tm
  # full_d_1[!bd_tm] <- to_d[!bd_tm] - bd_d[!bd_tm] + days_last_month(to_date[!bd_tm])  # 2: !bd_tm
  
  ## Combine cases:
  dlm_to <- days_last_month(to_date)
  # full_d_1 <- to_d - bd_d + (dlm_to * !bd_tm)  # ERROR: See diverging cases below.  
  
  ## Bug FIX: If bday would have been after the maximum day of last month:
  ix_2_fix <- !bd_tm & (bd_d > dlm_to)  # ix of cases to fix:
  # full_d_1[ix_2_fix] <- to_d[ix_2_fix]    # full_d <- to_d for these cases
  
  ## ALL-in-ONE: 
  full_d_1 <- to_d - bd_d + (dlm_to * !bd_tm) + ((bd_d - dlm_to) * ix_2_fix)
  
  # message(paste(full_d, collapse = " "))  # debugging
  
  
  # s_2: GLOBAL solution: Start from total number of days and 
  #      subtract all days of full years and months already accounted for.   
  #      Use diff_days() helper function to compute exact number of days between two dates:
  #      full_d_2 <- total_days              - accounted_days   
  #                = diff_days(DOB, to_date) - diff_days(DOB, to_date = dt_bday_last_month(to_date))
  
  # Use diff_days() helper/utility function: 
  total_days <- diff_days(from_date = from_date, to_date = to_date)
  
  # Use dt_bday_last_month() helper/utility function (Note: may return decimals):  
  dt_bday_last_month <- dt_last_monthly_bd(dob = from_date, to_date = to_date)
  accounted_days <- diff_days(from_date = from_date, to_date = dt_bday_last_month)
  
  unaccounted_days <- (total_days - accounted_days)  # may contain decimals!
  
  # Only consider completed/full days (as integers): 
  full_d_2 <- floor(unaccounted_days)
  
  # message(paste("total_days = ", total_days, collapse = ", "))          # debugging
  # message(paste("accounted_days = ", accounted_days, collapse = ", "))  # debugging  
  # message(paste("full_d_2 = ", full_d_2, collapse = ", "))              # debugging
  
  
  # s+3: Verify equality of both solutions: ---- 
  if (!all(full_d_1 == full_d_2)){
    
    warning('diff_dates: 2 solutions (full_d_1 vs. full_d_2) yield different results.')
    
    # Diagnostic info (for debugging): 
    ix_diff <- (full_d_1 != full_d_2) 
    if (n_dates > 1){
      message(paste(which(ix_diff),     collapse = ", "))
      message(paste(from_date[ix_diff], collapse = ", "))    
      message(paste(to_date[ix_diff],   collapse = ", "))
    }
    message(paste("y:", full_y[ix_diff], collapse = ", "))    
    message(paste("m:", full_m[ix_diff], collapse = ", "))    
    message(paste("d 1:", full_d_1[ix_diff],   collapse = ", "))    
    message(paste("d_2:", full_d_2[ix_diff], collapse = ", "))
    
  }
  
  # Decision: Use full_d_1 
  full_d <- full_d_1
  
  
  # 3. Output: ------ 
  
  if (as_character){
    
    if (unit == "y"){
      
      age <- paste0(sign, full_y, "y ", full_m, "m ", full_d, "d")
      
    } else if (unit == "m"){
      
      age <- paste0(sign, full_m, "m ", full_d, "d")
      
    }
    
  } else { # return a data frame:
    
    if (unit == "y"){
      
      age <- data.frame("from_date" = from_date_org,
                        "to_date"   = to_date_org, 
                        "neg" = sign,  # negation sign? 
                        "y" = full_y, 
                        "m" = full_m, 
                        "d" = full_d,
                        row.names = 1:n_dates)
      
    } else if (unit == "m"){
      
      age <- data.frame("from_date" = from_date_org,
                        "to_date"   = to_date_org, 
                        "neg" = sign,  # negation sign? 
                        "m" = full_m, 
                        "d" = full_d,
                        row.names = 1:n_dates)
      
    }
  }
  
  return(age)
  
} # diff_dates end. 

# ## Check:
# # Days:
# (ds_from <- as.Date("2010-01-02") + -1:1)
# (ds_to   <- as.Date("2020-03-01"))  # Note: 2020 is leap year.
# diff_dates(from_date = ds_from, to_date = ds_to)
# diff_dates(from_date = ds_from, to_date = ds_to, unit = "m")
# diff_dates(from_date = ds_from, to_date = ds_to, unit = "d")
# 
# # Months: 
# ms <- Sys.Date() - 366 + seq(from = -100, to = +100, by = 50)
# ms
# diff_dates(ms)
# 
# y_100 <- Sys.Date() - (100 * 365.25) + -1:1
# y_100
# diff_dates(y_100)
# 
# # with "to_date" argument:
# y_050 <- Sys.Date() - (50 * 365.25) + -1:1
# y_050
# diff_dates(y_100, y_050)
#
# Recycling vector lengths:
# # # (a) recycling "to_date" to length of "from_date":
# y_050_2 <- Sys.Date() - (50 * 365.25)
# y_050_2
# diff_dates(y_100, y_050_2, as_character = FALSE)
# 
# # (b) recycling "from_date" to length of "to_date":
# to_dates <- paste("2020", 1:12, "15", sep = "-")
# diff_dates(from_date = "2000-01-01", to_dates, as_character = FALSE) 
# 
# # Using 'fame' data:
# (dob <- as.Date(fame$DOB, format = "%B %d, %Y"))
# (dod <- as.Date(fame$DOD, format = "%B %d, %Y"))
# diff_dates(dob, dod, as_character = TRUE)
# diff_dates(dob, dod, unit = "m")
# diff_dates(dob, dod, unit = "d")
# 
# # Extreme cases: 
# # (a) from_date == to_date:
# diff_dates("1000-01-01", "2000-12-31")  # max. d + m
# diff_dates("1000-06-01", "1000-06-01")  # min. d + m + y
# 
# # (b) from_date > to_date: 
# # Reverse result and add negation sign ("-"):
# diff_dates("2000-01-02", "2000-01-03")
# diff_dates("2000-02-01", "2000-01-01", as_character = TRUE)
# diff_dates("2001-02-02", "2000-02-02", as_character = FALSE)
#
# ## Check consistency (of 2 solutions):
# 
# ## Test with random date samples:
# from <- sample_date(size = 100) - 0.11
# to   <- sample_date(size = 100) + 0.22
# diff_dates(from, to, unit = "y", as_character = FALSE)
# diff_dates(from, to, unit = "d", as_character = TRUE)
# 
# ## Test with random TIME samples:
# from <- sample_time(size = 100) - .25
# to   <- sample_time(size = 100) + .25
# diff_dates(from, to, unit = "y", as_character = TRUE)
# diff_dates(from, to, unit = "d", as_character = TRUE)
# 
## Test with date strings:
# from <- "2000-01-01"
# to <- paste("2020", 1:12, "11", sep = "-")
# diff_dates(from, to, unit = "y", as_character = FALSE)
#
#
# # Verify possibly diverging cases:
# 
# # 1:
# dob <- as.Date("1981-05-31")
# dod <- as.Date("1992-05-08")
# diff_dates(dob, dod)
# lubridate::as.period(lubridate::interval(dob, dod), unit = "years")
# 
# # 2:
# dob <- as.Date("1983-07-30")
# dod <- as.Date("1994-03-03")
# diff_dates(dob, dod)
# lubridate::as.period(lubridate::interval(dob, dod), unit = "years")
# 
# # 3:
# dob <- as.Date("1973-10-31")
# dod <- as.Date("1982-12-29")
# diff_dates(dob, dod)
# lubridate::as.period(lubridate::interval(dob, dod), unit = "years")
# 
# # 4:
# dob <- as.Date("1979-07-31")
# dod <- as.Date("1998-07-18")
# diff_dates(dob, dod)
# lubridate::as.period(lubridate::interval(dob, dod), unit = "years")
# 
# # 5:
# dob <- as.Date("1999-05-31")
# dod <- as.Date("1999-10-07")
# diff_dates(dob, dod)
# lubridate::as.period(lubridate::interval(dob, dod), unit = "years")
# 
# ## Analyze: Compare results to other methods: 
# 
# ## (a) lubridate time spans (interval, periods): 
# lubridate::as.period(dob %--% dod, unit = "years")
# 
# lubridate::as.period(lubridate::interval(dob, dod), unit = "years")
# diff_dates(dob, dod, unit = "years")
# 
# lubridate::as.period(lubridate::interval(dob, dod), unit = "months")
# diff_dates(dob, dod, unit = "months")
# 
# lubridate::as.period(lubridate::interval(dob, dod), unit = "days")
# diff_dates(dob, dod, unit = "days")
# 
# ## (b) base::difftime():
# all.equal(as.numeric(dod - dob), diff_days(dob, dod))
# all.equal(as.numeric(difftime(dod, dob)), diff_days(dob, dod))
# difftime(dod, dob, units = "weeks")  # Note: No "weeks" in diff_dates().
# 
# # from strings:
# diff_dates("2000-12-31")
# diff_dates("90-01-02", to_date = "10-01-01")
#
# # from numbers:
# diff_dates(20001231)  # turned into character > Date
# diff_dates(19900711, to_date = 20100710)
# 
# # NAs:
# diff_dates(from_date = y_100, to_date = NA)
# diff_dates(from_date = NA, to_date = NA)



## ToDo: 

# - add n_decimals argument? (default of 0).
#
# - Add exercise to Chapter 10: 
#   Explore the diff_dates() function that computes 
#   the difference between two dates (in human measurement units). 
# - Use result to compute age in years (as a number) and months (as a number). 
# - Use result to compute age in full weeks (as a number). 
# - Use result to add a week entry "Xw" between month m and day d.



# diff_times: Compute time difference (i.e., age) in human units: ------

#' Get the difference between two times (in human units).  
#'
#' \code{diff_times} computes the difference between two times 
#' (i.e., from some \code{from_time} to some \code{to_time}) 
#' in human measurement units (periods).
#' 
#' \code{diff_times} answers questions like 
#' "How much time has elapsed between two dates?" 
#' or "How old are you?" in human time periods 
#' of (full) years, months, and days. 
#' 
#' Key characteristics:
#' 
#' \itemize{
#' 
#'   \item If \code{to_time} or \code{from_time} are not "POSIXct" objects, 
#'   \code{diff_times} aims to coerce them into "POSIXct" objects. 
#' 
#'   \item If \code{to_time} is missing (i.e., \code{NA}), 
#'   \code{to_time} is set to the current time (i.e., \code{Sys.time()}).
#'   
#'   \item If \code{to_time} is specified, any intermittent missing values 
#'   (i.e., \code{NA}) are set to the current time (i.e., \code{Sys.time()}). 
#' 
#'   \item If \code{to_time} precedes \code{from_time} (i.e., \code{from_time > to_time}) 
#'   computations are performed on swapped times and the result is marked 
#'   as negative (by a character \code{"-"}) in the output.
#' 
#'   \item If the lengths of \code{from_time} and \code{to_time} differ, 
#'   the shorter vector is recycled to the length of the longer one. 
#' 
#' }
#' 
#' By default, \code{diff_times} provides output as (signed) character strings. 
#' For numeric outputs, use \code{as_character = FALSE}. 
#' 
#' @param from_time From time (required, scalar or vector, as "POSIXct"). 
#' Origin time, assumed to be of class "POSIXct", 
#' and coerced into "POSIXct" when of class "Date" or "POSIXlt. 
#' 
#' @param to_time To time (optional, scalar or vector, as "POSIXct"). 
#' Default: \code{to_time = Sys.time()}. 
#' Maximum time, assumed to be of class "POSIXct", 
#' and coerced into "POSIXct" when of class "Date" or "POSIXlt". 
#' 
#' @param unit Largest measurement unit for representing results. 
#' Units represent human time periods, rather than 
#' chronological time differences. 
#' Default: \code{unit = "days"} for completed days, hours, minutes, and seconds. 
#' Options available: 
#' \enumerate{
#' 
#'   \item \code{unit = "years"}: completed years, months, and days (default)
#'   
#'   \item \code{unit = "months"}: completed months, and days
#'   
#'   \item \code{unit = "days"}: completed days
#'   
#'   \item \code{unit = "hours"}: completed hours 
#'   
#'   \item \code{unit = "minutes"}: completed minutes
#'   
#'   \item \code{unit = "seconds"}: completed seconds
#'   
#'   }
#' Units may be abbreviated. 
#'   
#' @param as_character Boolean: Return output as character? 
#' Default: \code{as_character = TRUE}.  
#' If \code{as_character = FALSE}, results are returned 
#' as columns of a data frame 
#' and include \code{from_date} and \code{to_date}. 
#' 
#' @return A character vector or data frame 
#' (with times, sign, and numeric columns for units).
#' 
#' @examples
#' t1 <- as.POSIXct("1969-07-13 13:53 CET")  # (before UNIX epoch)
#' diff_times(t1, unit = "years", as_character = TRUE)
#' diff_times(t1, unit = "secs", as_character = TRUE)
#' 
#' @family date and time functions
#' 
#' @seealso 
#' \code{\link{diff_dates}} for date differences;  
#' time spans (an \code{interval} \code{as.period}) in the \strong{lubridate} package. 
#' 
#' @export 

diff_times <- function(from_time, to_time = Sys.time(), 
                       unit = "days", as_character = TRUE){
  
  # 0. Initialize: 
  now <- Sys.time()  # (do only once)
  age <- NA
  
  # 1. Handle inputs: ------  
  
  # (a) NA inputs: 
  
  if (any(is.na(from_time))){
    message('diff_times: "from_time" must not be NA.')    
    return(NA)
  }
  
  if (all(is.na(to_time))){
    message('diff_times: Changing "to_time" from NA to "Sys.time()".')       
    to_time <- now 
  }
  
  # (b) Turn non-Date inputs into "Date" objects 
  
  if (!is_POSIXct(from_time)){
    # message('diff_times: Aiming to parse "from_time" as "POSIXct".')
    from_time <- time_from_noPOSIXt(from_time)
  }
  
  if (!is_POSIXct(to_time)){
    # message('diff_times: Aiming to parse "to_time" as "POSIXct".')
    to_time <- time_from_noPOSIXt(to_time)
  }
  
  
  # (c) Recycle shorter time vector to length of longer one: ----
  aligned_v  <- align_vector_pair(v1 = from_time, v2 = to_time)
  from_time <- aligned_v[[1]]
  to_time   <- aligned_v[[2]]
  
  ## WAS: (c) Recycle or truncate to_time argument based on from_time:  
  # to_time <- align_vector_length(v_fixed = from_time, v_change = to_time)
  
  # Note: from_time and to_time now have the same length: 
  n_times <- length(from_time)
  
  
  # (d) Replace intermittent NA values in to_time by current time: 
  # Axiom: Entities with a given to_time do not age any further, but 
  #        if to_time = NA, we want to measure until now: 
  set_to_time_NA_to_NOW <- TRUE  # if FALSE: Occasional to_time = NA values yield NA result.
  
  if (set_to_time_NA_to_NOW){
    
    if (!all(is.na(to_time))){  # only SOME to_time values are missing: 
      
      to_time[is.na(to_time)] <- now  # replace those NA values by now = Sys.time()
      
    }
  }
  
  # (e) Verify that from_time and to_time are "POSIXct" objects: 
  if (!is_POSIXct(from_time)){
    message('diff_times: "from_time" should be of class "POSIXct".')
    # print(from_time)  # debugging
  }
  
  if (!is_POSIXct(to_time)){
    message('diff_times: "to_time" should be of class "POSIXct".')
    # print(to_time)    # debugging
  }
  
  
  # (f) If from_time > to_time: Swap dates and negate sign:
  
  from_time_org <- from_time  # store original orders
  to_time_org   <- to_time    # (to list in outputs)
  
  ix_swap <- (from_time > to_time)       # ix of cases to swap 
  from_time_temp <- from_time[ix_swap]   # temporary storage
  
  from_time[ix_swap] <- to_time[ix_swap]  # from_time by to_time
  to_time[ix_swap]   <- from_time_temp    # to_time by from_time
  
  sign <- rep("", n_times)  # initialize (as character)
  sign[ix_swap] <- "-"      # negate sign (character)
  
  # message(sign)  # debugging
  
  
  # (g) Unit: 
  unit <- substr(tolower(unit), 1, 2)  # robustness: use only 1st letter: y/m/d
  
  if (!unit %in% c("ye", "mo", "da", "ho", "mi", "se")){
    message('diff_times: unit must be "year", "month", "day", "hour", "min", "sec". Using "day".')
    unit <- "da"
  }
  
  # 2. Main function: ------ 
  
  # (a) initialize other variables: 
  full_y <- NA
  full_m <- NA
  full_d <- NA
  full_d_1 <- NA
  full_d_2 <- NA
  
  full_H <- NA
  full_M <- NA
  full_S <- NA
  
  # (b) total time (in sec): 
  total_time_sec <- diff_days(from_date = from_time, to_date = to_time, units = "sec", as_Date = FALSE) 
  
  # (c) Special case: unit == "sec" ---- 
  
  if (unit == "se"){
    
    # Use diff_days() helper/utility function: 
    full_S <- total_time_sec
    
    if (as_character){
      
      age <- paste0(sign, full_S, "S") 
      
    } else { # return a data frame:
      
      age <- data.frame("from_time" = from_time_org,
                        "to_time"   = to_time_org, 
                        "neg" = sign,  # negation sign? 
                        "S" = full_S,
                        row.names = 1:n_times)
    }
    
    return(age)
    
  }
  
  # (d) All other units (year/month/day/hour/min): Get date elements ---- 
  
  # from_time elements (DOB):
  bd_y <- as.numeric(format(from_time, "%Y"))
  bd_m <- as.numeric(format(from_time, "%m"))
  bd_d <- as.numeric(format(from_time, "%d"))
  
  bd_H <- as.numeric(format(from_time, "%H"))
  bd_M <- as.numeric(format(from_time, "%M"))
  bd_S <- as.numeric(format(from_time, "%S"))
  
  # to_time elements (DOD, max. time): 
  to_y <- as.numeric(format(to_time, "%Y"))
  to_m <- as.numeric(format(to_time, "%m"))
  to_d <- as.numeric(format(to_time, "%d"))
  
  to_H <- as.numeric(format(to_time, "%H"))
  to_M <- as.numeric(format(to_time, "%M"))
  to_S <- as.numeric(format(to_time, "%S"))
  
  
  # (+) Special case: Consider possible time difference due to different time zones:
  tz_diff_mins <- diff_tz(t1 = from_time, t2 = to_time, in_min = TRUE)
  tz_diff_days <- tz_diff_mins / (60 * 24)  # in days
  
  
  # (e) Case: largest unit year/month: ---- 
  if (unit == "ye" || unit == "mo"){
    
    # (e1) Completed years: 
    
    # bday this year? (as Boolean): 
    bd_ty <- ifelse(( (to_m > bd_m) | ((to_m == bd_m) & (to_d > bd_d)) | 
                        ((to_m == bd_m) & (to_d == bd_d) & (to_H > bd_H)) |
                        ((to_m == bd_m) & (to_d == bd_d) & (to_H == bd_H) & (to_M > bd_M)) |
                        ((to_m == bd_m) & (to_d == bd_d) & (to_H == bd_H) & (to_M == bd_M) & (to_S >= bd_S))), TRUE, FALSE) 
    # print(bd_ty)
    
    full_y <- (to_y - bd_y) - (1 * !bd_ty)
    
    
    # (e2) Completed months: 
    
    # bday this month? (as Boolean): 
    bd_tm <- ifelse(((to_d > bd_d) | ((to_d == bd_d) & (to_H > bd_H)) | 
                       ((to_d == bd_d) & (to_H == bd_H) & (to_M > bd_M)) | 
                       ((to_d == bd_d) & (to_H == bd_H) & (to_M == bd_M) & (to_S >= bd_S))), TRUE, FALSE) 
    # print(bd_tm)
    
    ## Distinguish 2 cases:
    # full_m[bd_ty]  <- (to_m[bd_ty]  - bd_m[bd_ty])  - !bd_tm[bd_ty]        # 1:  bd_ty
    # full_m[!bd_ty] <- (12 + to_m[!bd_ty] - bd_m[!bd_ty]) - !bd_tm[!bd_ty]  # 2: !bd_ty
    
    ## Combine both cases:
    full_m <- (to_m - bd_m) + (12 * !bd_ty) - (1 * !bd_tm) 
    
    # Special case: 
    if (unit == "mo"){
      
      full_m <- (12 * full_y) + full_m  # express years in months
      full_y <- 0  # reset years
      
    }
    
    # (e3) Completed days: 
    
    ## Reached bday-time today? (as Boolean): 
    bd_td <- ifelse((to_H > bd_H) | 
                      ((to_H == bd_H) & (to_M > bd_M)) | 
                      ((to_H == bd_H) & (to_M == bd_M) & (to_S >= bd_S)), TRUE, FALSE) 
    
    # Use 2 solutions:
    
    # s_1: LOCAL solution: Determine the number N of days in last month.
    #      Then use this number to compute difference from bd_d to to_d 
    
    ## Distinguish 2 cases:  
    # full_d_1[bd_tm]  <- to_d[bd_tm]  - bd_d[bd_tm]  # 1:  bd_tm: days since bd_tm
    # full_d_1[!bd_tm] <- to_d[!bd_tm] - bd_d[!bd_tm] + days_last_month(to_date[!bd_tm])  # 2: !bd_tm
    
    ## Combine cases:
    dlm_to <- days_last_month(to_time)
    # full_d_1 <- to_d - bd_d + (dlm_to * !bd_tm)  # ERROR: See diverging cases below.  
    
    ## Bug FIX: If bday would have been after the maximum day of last month:
    ix_2_fix <- !bd_tm & (bd_d > dlm_to)  # ix of cases to fix:
    # full_d_1[ix_2_fix] <- to_d[ix_2_fix]  # full_d <- to_d for these cases
    
    ## ALL-in-ONE: 
    full_d_1 <- (to_d - bd_d) + (dlm_to * !bd_tm) + ((bd_d - dlm_to) * ix_2_fix) - (1 * !bd_td)
    
    # s_2: GLOBAL solution: Start from total number of days and 
    #      subtract all days of full years and months already accounted for.   
    #      Use diff_days() helper function to compute exact number of days between two dates:
    #      full_d_2 <- total_days              - accounted_days   
    #                = diff_days(DOB, to_date) - diff_days(DOB, to_date = dt_bday_last_month(to_date))
    
    # Use diff_days() helper/utility function: 
    total_days <- diff_days(from_date = from_time, to_date = to_time, units = "days", as_Date = FALSE)
    
    # Use dt_bday_last_month() helper/utility function (Note: may return decimals):  
    dt_bday_last_month <- dt_last_monthly_bd(dob = from_time, to_date = to_time)  # tz = "" is NO LONGER necessary!!
    
    accounted_days_ym2 <- diff_days(from_date = from_time, to_date = dt_bday_last_month)
    unaccounted_days   <- (total_days - accounted_days_ym2)  # may contain decimals!
    
    # Correction: If tz_diff_mins differ from zero: 
    ix_tz_diff <- (tz_diff_mins != 0)
    unaccounted_days[ix_tz_diff] <- unaccounted_days[ix_tz_diff] + tz_diff_days[ix_tz_diff]
    
    # Only consider completed/full days (as integers): 
    full_d_2 <- floor(unaccounted_days) 
    
    ## Correction: Add 1 day if bd_td is TRUE:
    # full_d_2[bd_td] <- full_d_2[bd_td] + 1   # Problem: Too general (lots of error cases).
    
    debugging_feedback <- FALSE  # TRUE = debugging info
    
    if (debugging_feedback){
      
      message('diff_times debugging info (computing full_d_1 vs. full_d_2):')
      
      # above: 
      message(paste("full_y = ", full_y, collapse = ", "))  # debugging
      message(paste("full_m = ", full_m, collapse = ", "))  # debugging
      message(paste("full_d_1 = ", full_d_1, collapse = ", "))  # debugging
      
      # new:
      message(paste("total_days = ", total_days, collapse = ", "))  # debugging
      message(paste("dt_bday_last_month = ", dt_bday_last_month, collapse = ", "))  # debugging        
      message(paste("accounted_days_ym2 = ", accounted_days_ym2, collapse = ", "))  # debugging        
      message(paste("unaccounted_days = ", unaccounted_days, collapse = ", "))  # debugging        
      message(paste("tz_diff_mins = ", tz_diff_mins, collapse = ", "))  # debugging
      message(paste("tz_diff_days = ", tz_diff_days, collapse = ", "))  # debugging
      
      message(paste("full_d_2 = ", full_d_2, collapse = ", "))  # debugging      
      
    }
    
    # +++ here now +++ 
    
    # s+3: Verify equality of both solutions: ---- 
    
    verify_equality <- TRUE 
    
    if (verify_equality & (!all(full_d_1 == full_d_2))){
      
      message('diff_times: 2 methods for full days yield different results (d_1 vs. d_2):')
      
      # Diagnostic info (for debugging): 
      ix_diff <- (full_d_1 != full_d_2)  
      
      if (n_times > 1){
        message(paste("ix_diff:", which(ix_diff),  collapse = ", "))
        message(paste("from_time:", from_time[ix_diff], collapse = ", "))    
        message(paste("to_time:", to_time[ix_diff],   collapse = ", "))
      }
      message(paste("y:", full_y[ix_diff],  collapse = ", "))    
      message(paste("m:", full_m[ix_diff],  collapse = ", "))    
      message(paste("d_1:", full_d_1[ix_diff], collapse = ", "))    
      message(paste("d_2:", full_d_2[ix_diff], collapse = ", "))
      
    }
    
    # # Decision 1: Go with full_d_1:
    # full_d <- full_d_1
    # Problem: We need accounted_days_ym2 for computing accounted_time_sec! 
    
    # Decision 2: Go with full_d_2.
    full_d <- full_d_2
    
    ## Special case: full_d_2 is negative: 
    if (any(full_d_2 < 0)){
      # message('diff_times: Incrementing month count for negative full day count.')
      ix_neg_days <- (full_d_2 < 0)
      full_m[ix_neg_days] <- full_m[ix_neg_days] + 1  # increment month count 
    }
    
    # Store accounted time (in sec):
    accounted_time_sec <- (accounted_days_ym2 * (24 * 60 * 60)) + (full_d * (24 * 60 * 60))
    
  } # if (unit == "ye" | unit == "mo") end. 
  
  
  # (f) Case: largest unit day: ---- 
  
  if (unit == "da"){
    
    # Use diff_days() helper/utility function: 
    total_days <- diff_days(from_date = from_time, to_date = to_time, units = "days", as_Date = FALSE)
    
    # Only consider completed/full days (as integers): 
    full_d <- floor(total_days)
    
    # accounted_days_d <- full_d
    # unaccounted_days <- total_days - accounted_days_d  # may contain decimals!
    
    # Store accounted time (in sec):
    accounted_time_sec <- (full_d * (24 * 60 * 60))
    
  } # if (unit == "da") end. 
  
  
  # (g) Case: largest unit hour/min: 
  if (unit == "ho" | unit == "mi"){  
    
    accounted_time_sec <- 0 
    
  }
  
  
  # (c4) Remaining time units: ---- 
  
  # Global approach: Determine total time (in sec) and subtract accounted time (in sec): 
  unaccounted_time_sec <- (total_time_sec - accounted_time_sec) 
  
  # Special case: Account for possible tz difference:
  unaccounted_time_sec <- unaccounted_time_sec + (tz_diff_mins * 60)
  
  full_H <- unaccounted_time_sec %/% (60 * 60)
  full_M <- (unaccounted_time_sec - (full_H * (60 * 60))) %/% 60 
  full_S <- (unaccounted_time_sec - (full_H * (60 * 60)) - (full_M * 60)) 
  
  # Special case: 
  if (unit == "mi"){
    
    full_M <- (60 * full_H) + full_M  # express hours in minutes
    full_H <- 0  # reset hours
    
  }
  
  
  # 3. Output: ------ 
  
  if (as_character){
    
    if (unit == "ye"){
      
      age <- paste0(sign, full_y, "y ", full_m, "m ", full_d, "d", 
                    " ", full_H, "H ", full_M, "M ", full_S, "S")
      
    } else if (unit == "mo"){
      
      age <- paste0(sign, full_m, "m ", full_d, "d", 
                    " ", full_H, "H ", full_M, "M ", full_S, "S")
      
    } else if (unit == "da"){
      
      age <- paste0(sign, full_d, "d", 
                    " ", full_H, "H ", full_M, "M ", full_S, "S")
      
    } else if (unit == "ho"){
      
      age <- paste0(sign, full_H, "H ", full_M, "M ", full_S, "S")
      
    } else if (unit == "mi"){
      
      age <- paste0(sign, full_M, "M ", full_S, "S")
      
    }
    
  } else { # return a data frame:
    
    if (unit == "ye"){
      
      age <- data.frame("from_time" = from_time_org,
                        "to_time"   = to_time_org, 
                        "neg" = sign,  # negation sign? 
                        "y" = full_y, 
                        "m" = full_m, 
                        "d" = full_d, 
                        "H" = full_H,
                        "M" = full_M,
                        "S" = full_S,
                        row.names = 1:n_times)
      
    } else if (unit == "mo"){
      
      age <- data.frame("from_time" = from_time_org,
                        "to_time"   = to_time_org, 
                        "neg" = sign,  # negation sign? 
                        "m" = full_m, 
                        "d" = full_d,
                        "H" = full_H,
                        "M" = full_M,
                        "S" = full_S,
                        row.names = 1:n_times)
      
    } else if (unit == "da"){
      
      age <- data.frame("from_time" = from_time_org,
                        "to_time"   = to_time_org, 
                        "neg" = sign,  # negation sign? 
                        "d" = full_d,
                        "H" = full_H,
                        "M" = full_M,
                        "S" = full_S,
                        row.names = 1:n_times)
      
    } else if (unit == "ho"){
      
      age <- data.frame("from_time" = from_time_org,
                        "to_time"   = to_time_org, 
                        "neg" = sign,  # negation sign? 
                        "H" = full_H,
                        "M" = full_M,
                        "S" = full_S,
                        row.names = 1:n_times)
      
    } else if (unit == "mi"){
      
      age <- data.frame("from_time" = from_time_org,
                        "to_time"   = to_time_org, 
                        "neg" = sign,  # negation sign? 
                        "M" = full_M,
                        "S" = full_S,
                        row.names = 1:n_times)
    }
    
  }
  
  return(age)
  
} # diff_times end. 

# ## Check:
# 
# t1 <- as.POSIXct("1969-07-13 13:53 CET")
# t2 <- Sys.time()
# diff_times(t1, t2, unit = "year", as_character = TRUE)
# diff_times(t1, t2, unit = "month", as_character = TRUE)
# diff_times(t1, t2, unit = "day", as_character = TRUE)
# diff_times(t1, t2, unit = "hour", as_character = TRUE)
# diff_times(t1, t2, unit = "min", as_character = TRUE)
# diff_times(t1, t2, unit = "sec", as_character = TRUE)
# 
# # Test with random TIME samples:
# from <- sample_time(size = 100, from = "2020-01-01")
# to   <- sample_time(size = 100, from = "2020-04-01")
# 
# # "year":
# diff_times(from, to, unit = "year", as_character = FALSE)
# lubridate::as.period(lubridate::interval(from, to), unit = "years")
# Note differences in hour counts (due to DST).
# But: diff_times more consistent (see results for unit = "days")!
#
# # "month":
# diff_times(from, to, unit = "month", as_character = TRUE)
# lubridate::as.period(lubridate::interval(from, to), unit = "months")
# # Note differences in hour counts (due to DST).
# # But: diff_times more consistent (see results for unit = "days")!
# 
# # "day":
# diff_times(from, to, unit = "day", as_character = FALSE)
# lubridate::as.period(lubridate::interval(from, to), unit = "day")
# 
# # "hour":
# diff_times(from, to, unit = "hour", as_character = FALSE)
# lubridate::as.period(lubridate::interval(from, to), unit = "hour")
# 
# # "min":
# diff_times(from, to, unit = "min", as_character = TRUE)
# lubridate::as.period(lubridate::interval(from, to), unit = "min")
# 
# # "sec":
# diff_times(from, to, unit = "sec", as_character = TRUE)
# lubridate::as.period(lubridate::interval(from, to), unit = "sec")


# ## Former problems/error cases:
# 
# # A. now resolved:
# 
# # (a)
# t1 <- "2020-05-31 05:41:27"
# t2 <- "2020-07-01 01:29:06"
# diff_times(t1, t2, unit = "year", as_character = FALSE)
# lubridate::as.period(lubridate::interval(t1, t2), unit = "years")
# 
# # Bug fix: Add default argument tz = "" to date_from_noDate() and date_from_string() functions:
# dt_last_monthly_bd(t1, t2)  # "2020-06-30" is correct.
# 
# # (b)
# t1 <- "2020-06-07 01:08:48"
# t2 <- "2020-07-09 22:49:20"
# diff_times(t1, t2, unit = "year", as_character = TRUE)
# lubridate::as.period(lubridate::interval(t1, t2), unit = "years")
# 
# # (c) DST switch (a: spring ahead):
# t1 <- "2020-03-28 12:00:00"  # before DST switch
# t2 <- "2020-03-29 12:00:00"  # after DST switch (on 2020-03-29: 02:00:00 > 03:00:00)
# diff_times(t1, t2, unit = "year", as_character = TRUE)
# lubridate::as.period(lubridate::interval(t1, t2), unit = "years")
# 
# # Solved by using new utility/helper function:
# diff_tz(t1, t2, in_min = TRUE)
# 
# # (d) DST switch (b: fall back):
# t1 <- "2020-10-24 12:00:00"  # before DST switch
# t2 <- "2020-10-25 12:00:00"  # after DST switch (on 2020-10-25: 03:00:00 > 02:00:00)
# diff_times(t1, t2, unit = "year", as_character = TRUE)
# lubridate::as.period(lubridate::interval(t1, t2), unit = "years")
# 
# # Solved by using new utility/helper function:
# diff_tz(t1, t2, in_min = TRUE)
# 
# # (e) Differences between diff_times() and lubridate solution: 
# t1 <- "2020-03-26 23:26:38"
# t2 <- "2020-05-02 19:13:20"
# diff_times(t1, t2, unit = "days", as_character = TRUE)
# lubridate::as.period(lubridate::interval(t1, t2), unit = "days")
# 
# t1 <- "2020-03-05 05:18:25"
# t2 <- "2020-05-24 07:27:05"
# diff_times(t1, t2, unit = "days", as_character = TRUE)
# lubridate::as.period(lubridate::interval(t1, t2), unit = "days")

# +++ here now +++ 

# # B. NOT resolved YET:
# 
# (x) Error/discrepancy case:
# t1 <- "2020-04-23 16:15:22"
# t2 <- "2020-06-23 04:14:54"
# diff_times(t1, t2, unit = "year", as_character = TRUE)
# lubridate::as.period(lubridate::interval(t1, t2), unit = "years")
# 
# dt_last_monthly_bd(t1, t2)  # "2020-06-23" is correct.
# 
# (y) Differences between diff_times() and lubridate solution:
# t1 <- "2020-06-04 08:39:07"
# t2 <- "2020-04-19 09:32:36"
# diff_times(t1, t2, unit = "years", as_character = TRUE)
# lubridate::as.period(lubridate::interval(t1, t2), unit = "years")


## ToDo: 

# - add n_decimals argument? (default of 0).
#
# - Add exercise to Chapter 10: 
#   Explore the diff_dates() function that computes 
#   the difference between two dates (in human measurement units). 
# - Use result to compute age in years (as a number) and months (as a number). 
# - Use result to compute age in full weeks (as a number). 
# - Use result to add a week entry "Xw" between month m and day d.

# - Add advanced exercise to Chapter 10: 
#   Sample random dates/times and compare diff_times() with lubridate solution.
#   Which differences in computed results do occur? 
#   (Distinguish surface differences vs. actual number differences)
#   Can they be explained? 


## Done: ----------

# - Provided all what_ functions with a "when" argument that is set to Sys.Date() 
#   or Sys.time() by default, allowing for other dates/times for which question 
#   is answered (e.g., On what day was my birthday?) 
# - change_tz() and change_time() function(s) 
#   for converting time display (in "POSIXct") into local times (in "POSIXlt"), 
#   and vice versa (changing times, but not time display). 
# - Moved time utility/helper functions into separate file.


## ToDo: ----------

# ad (1) and (2): 
# - update cur_ and what_ functions to use new helpers
# - re-consider what_day() to return NUMERIC day in week/month/year.
# - fix ToDo in what_date() (Actively convert time?)
# - Return dates/times either as strings (if as_string = TRUE) or 
#   as dates/times (of class "Date"/"POSIXct") in all what_() functions

# ad (4): Differences between dates/times:
# - finish and clean up diff_dates (or date_diff) function. 
# - consider adding diff_times function (analog to diff_dates, but for date-times, including H:M:S)

## eof. ----------------------