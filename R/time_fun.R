## time_fun.R | ds4psy
## hn | uni.kn | 2020 04 18
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
#' \code{cur_date} returns \code{Sys.time()} 
#' (in "%Y-%m-%d" or "%d-%m-%Y" format) 
#' using current system settings.
#'  
#' By default, this corresponds to the "%Y-%m-%d" (or "%F")     
#' format used as the ISO 8601 standard. 
#' 
#' For more options, see the 
#' \code{date()} and \code{Sys.Date()} functions of \strong{base} R 
#' and the plethora of formatting options for \code{Sys.time()}. 
#' 
#' @param rev Boolean: Reverse from "yyyy-mm-dd" to "dd-mm-yyyy" format?    
#' Default: \code{rev = FALSE}. 
#' 
#' @param sep Character: Separator to use. 
#' Default: \code{sep = "-"}. 
#' 
#' @examples
#' cur_date()
#' cur_date(sep = "/")
#' cur_date(rev = TRUE)
#' cur_date(rev = TRUE, sep = ".")
#' 
#' @family date and time functions
#' 
#' @seealso 
#' \code{date()} and \code{today()} functions of the \strong{lubridate} package; 
#' \code{date()}, \code{Sys.Date()}, and \code{Sys.time()} functions of \strong{base} R. 
#'
#' @export 

cur_date <- function(rev = FALSE, sep = "-"){
  
  # Current time: 
  d <- Sys.time()
  
  # Formatting instruction string:   
  if (rev){
    fmt <- paste("%d", "%m", "%Y", sep = sep, collapse = "")  # using sep
  } else {
    fmt <- paste("%Y", "%m", "%d", sep = sep, collapse = "")  # using sep
  }
  
  # Return formatted d: 
  format(d, fmt)   
  
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
#' \code{cur_time} returns \code{Sys.time()}  
#' (in "%H:%M" or "%H:%M:%S" format) 
#' using current system settings.
#' 
#' For a time zone argument, 
#' see the \code{now()} function of 
#' the \strong{lubridate} package. 
#' 
#' @param seconds Boolean: Show time with seconds?    
#' Default: \code{seconds = FALSE}. 
#' 
#' @param sep Character: Separator to use. 
#' Default: \code{sep = ":"}. 
#' 
#' @examples
#' cur_time() 
#' cur_time(seconds = TRUE)
#' cur_time(sep = ".")
#' 
#' @family date and time functions
#' 
#' @seealso 
#' \code{now()} function of the \strong{lubridate} package; 
#' \code{Sys.time()} function of \strong{base} R. 
#' 
#' @export 

cur_time <- function(seconds = FALSE, sep = ":"){
  
  # Current time: 
  t <- Sys.time()
  
  # Formatting instruction string: 
  if (seconds) {
    fmt <- paste("%H", "%M", "%S", sep = sep, collapse = "")  # %S and using sep
  } else {
    fmt <- paste("%H", "%M",       sep = sep, collapse = "")  # no %S, using sep
  }
  
  # Return formatted t: 
  format(t, fmt)   
  
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
#' \code{what_time} returns either a simple version of 
#' \code{when} or \code{Sys.time()}  
#' (in "%H:%M" or "%H:%M:%S" format) 
#' using current system settings.
#' 
#' @param when Time (as a scalar or vector).    
#' Default: \code{when = NA}. 
#' Returning \code{Sys.time()}, if \code{when = NA}.
#' 
#' @param seconds Boolean: Show time with seconds?    
#' Default: \code{seconds = FALSE}. 
#' 
#' @param sep Character: Separator to use. 
#' Default: \code{sep = ":"}. 
#' 
#' @examples
#' what_time()  
#' 
#' # with vector (of times): 
#' ts <- c("2020-01-14 01:02:03 CET", "2020-12-31 14:15:16")
#' what_time(ts)
#' what_time(ts, seconds = TRUE, sep = "_")
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

what_time <- function(when = NA, seconds = FALSE, sep = ":"){
  
  # Check when argument: 
  if (all(is.na(when))){
    t <- Sys.time()  # use current time
  } else {
    t <- as.POSIXct(when)  # convert into POSIXct
  }
  
  # Formatting instruction string: 
  if (seconds) {
    fmt <- paste("%H", "%M", "%S", sep = sep, collapse = "")  # %S and using sep
  } else {
    fmt <- paste("%H", "%M",       sep = sep, collapse = "")  # no %S, using sep
  }
  
  # Return formatted t: 
  format(t, fmt)   
  
}  # what_time end.

# # Check:
# what_time()  
# # with vector (of times): 
# ts <- c("2020-01-14 01:02:03 CET", "2020-12-31 14:15:16")
# what_time(ts)
# what_time(ts, seconds = TRUE, sep = "_")


# what_date: More versatile version of cur_date(), allowing for a when vector: ------

#' What date is it?  
#'
#' \code{what_date} provides a satisficing version of 
#' \code{Sys.Date()} that is sufficient for most purposes. 
#' 
#' \code{what_date} returns either a simple version of 
#' \code{when} or \code{Sys.Date()}  
#' (in %Y-%m-%d format) 
#' using current system settings.
#' 
#' @param when Date (as a scalar or vector).    
#' Default: \code{when = NA}. 
#' Using \code{as.Date(when)} to convert strings into dates, 
#' and \code{Sys.Date()}, if \code{when = NA}.
#' 
#' @param rev Boolean: Reverse date (to %d-%m-%Y)?    
#' Default: \code{rev = FALSE}. 
#' 
#' @param sep Character: Separator to use. 
#' Default: \code{sep = "-"}. 
#' 
#' @param month_form Character: Month format. 
#' Default: \code{month_form = "m"} for numeric month (01-12). 
#' Use \code{month_form = "b"} for short month name 
#' and \code{month_form = "B"} for full month name (in current locale).  
#'  
#' @examples
#' what_date()  
#' what_date(sep = "/")
#' what_date(rev = TRUE)
#' what_date(rev = TRUE, sep = ".")
#' what_date(rev = TRUE, sep = " ", month_form = "B")
#' 
#' # with vector (of dates):
#' ds <- c("2020-01-15 01:02:03 CET", "2020-12-31 14:15:16")
#' what_date(ds)
#' what_date(ds, rev = TRUE, sep = ".")
#' what_date(ds, rev = TRUE, month_form = "b")
#' 
#' @family date and time functions
#' 
#' @seealso 
#' \code{what_day()} function to obtain days; 
#' \code{what_time()} function to obtain times; 
#' \code{cur_time()} function to print the current time; 
#' \code{cur_date()} function to print the current date; 
#' \code{now()} function of the \strong{lubridate} package; 
#' \code{Sys.time()} function of \strong{base} R. 
#' 
#' @export

what_date <- function(when = NA, rev = FALSE, sep = "-", month_form = "m"){
  
  # Check when argument: 
  if (all(is.na(when))){
    d <- Sys.time()  # use current time
  } else {
    d <- as.Date(when)  # convert into Date 
  }
  
  if (substr(month_form, 1, 1) != "%") {
    month_form <- paste0("%", month_form)  # add % prefix
  }
  
  # Formatting instruction string:   
  if (rev){
    fmt <- paste("%d", month_form, "%Y", sep = sep, collapse = "")  # using sep
  } else {
    fmt <- paste("%Y", month_form, "%d", sep = sep, collapse = "")  # using sep
  }
  
  # Return formatted d: 
  format(d, fmt)   
  
}  # what_date end. 

# ## Check:
# what_date()
# what_date(sep = "/")
# what_date(rev = TRUE)
# what_date(rev = TRUE, sep = ".")
# what_date(rev = TRUE, sep = " ", month_form = "B")
# 
# # with vector (of dates):
# ds <- c("2020-01-15 01:02:03 CET", "2020-12-31 14:15:16")
# what_date(ds)
# what_date(ds, rev = TRUE, sep = ".")
# what_date(ds, rev = TRUE, month_form = "b")


# what_day: What day is it? (name or number) ------ 
# what_day: as name (weekday, abbr or full), OR as number (in units of week, month, or year; as char or as integer) 

#' What day is it?  
#'
#' \code{what_day} provides a satisficing version of 
#' to determine the day corresponding to a given date.
#' 
#' \code{what_day} returns the day  
#' of \code{when} or \code{Sys.Date()} 
#' (as a name or number).
#' 
#' @param when Date (as a scalar or vector).    
#' Default: \code{when = NA}. 
#' Using \code{as.Date(when)} to convert strings into dates, 
#' and \code{Sys.Date()}, if \code{when = NA}.
#' 
#' @param unit Character: Unit of day?
#' Possible values are \code{"week", "month", "year"}. 
#' Default: \code{unit = "week"} (for day within week). 
#' 
#' @param abbr Boolean: Return abbreviated?  
#' Default: \code{abbr = FALSE}. 
#' 
#' @param as_integer Boolean: Return as integer? 
#' Default: \code{as_integer = FALSE}. 
#' 
#' @examples
#' what_day()
#' what_day(abbr = TRUE)
#' what_day(as_integer = TRUE)
#' 
#' # Work with vectors (when as characters):
#' ds <- c("2020-01-01", "2020-02-29", "2020-12-24", "2020-12-31")
#' what_day(when = ds)
#' what_day(when = ds, unit = "month", as_integer = TRUE)
#' what_day(when = ds, unit = "year", as_integer = TRUE)
#'
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

what_day <- function(when = Sys.time(), unit = "week", abbr = FALSE, as_integer = FALSE){
  
  # Robustness:
  unit <- substr(tolower(unit), 1, 1)  # use only 1st letter of string
  
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
  
  # initialize:
  d <- NA
  
  # get day d (as char):
  if (unit == "w"){  # unit "week": 
    
    if (as_integer){
      
      d  <- format(when, "%u")  # Weekday as a decimal number (1–7, Monday is 1).
      
    } else {
      
      if (abbr){
        d  <- format(when, "%a")  # Abbreviated weekday name in the current locale on this platform.
      } else {
        d  <- format(when, "%A")  # Full weekday name in the current locale.
      }
      
    }
    
  } else if (unit == "m") {  # unit "month": 
    
    d  <- format(when, "%d")  # Day of the month as decimal number (01–31).
    
    
  } else if (unit == "y") {  # unit "year": 
    
    d  <- format(when, "%j")  # Day of year as decimal number (001–366).
    
  } else {  # some other unit: 
    
    message("Unknown unit. Using unit = 'month':")
    d  <- format(when, "%d")  # Day of the month as decimal number (01–31).
    
  } 
  
  # as char or integer:
  if (as_integer) {
    as.integer(d)
  } else {
    d
  }
  
}  # what_day end. 

# ## Check:
# what_day()
# what_day(abbr = TRUE)
# what_day(as_integer = TRUE)
# 
# # Other dates/times:
# d1 <- as.Date("2020-02-29")
# what_day(when = d1)
# what_day(when = d1, unit = "month", as_integer = TRUE)
# what_day(when = d1, unit = "year", as_integer = TRUE)
# 
# # Work with vectors (when as characters):
# ds <- c("2020-01-01", "2020-02-29", "2020-12-24", "2020-12-31")
# what_day(when = ds)
# what_day(when = ds, unit = "month", as_integer = TRUE)
# what_day(when = ds, unit = "year", as_integer = TRUE)
# 
# # Note: Errors
# what_day(when = d1, unit = "asdf")
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
#' Default: \code{when = NA}. 
#' Using \code{as.Date(when)} to convert strings into dates, 
#' and \code{Sys.Date()}, if \code{when = NA}.
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
#' # Work with vectors (when as characters):
#' ds <- c("2020-01-01", "2020-02-29", "2020-12-24", "2020-12-31")
#' what_week(when = ds)
#' what_week(when = ds, unit = "month", as_integer = TRUE)
#' what_week(when = ds, unit = "year", as_integer = TRUE)
#'  
#' @family date and time functions
#' 
#' @seealso 
#' \code{what_day()} function to obtain days; 
#' \code{what_date()} function to obtain dates; 
#' \code{cur_time()} function to print the current time; 
#' \code{cur_date()} function to print the current date; 
#' \code{now()} function of the \strong{lubridate} package; 
#' \code{Sys.time()} function of \strong{base} R. 
#' 
#' @export

what_week <- function(when = Sys.time(), unit = "year", as_integer = FALSE){
  
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
#' # Work with vectors (when as characters):
#' ds <- c("2020-01-01", "2020-02-29", "2020-12-24", "2020-12-31")
#' what_month(when = ds)
#' what_month(when = ds, abbr = TRUE, as_integer = FALSE)
#' what_month(when = ds, abbr = TRUE, as_integer = TRUE)
#' 
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

what_month <- function(when = Sys.time(), abbr = FALSE, as_integer = FALSE){
  
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
#' # Work with vectors (when as characters):
#' ds <- c("2020-01-01", "2020-02-29", "2020-12-24", "2020-12-31")
#' what_year(when = ds)
#' what_year(when = ds, abbr = TRUE, as_integer = FALSE)
#' what_year(when = ds, abbr = TRUE, as_integer = TRUE)
#' 
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

what_year <- function(when = Sys.time(), abbr = FALSE, as_integer = FALSE){
  
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

## Done: ----------

# - Provided all what_ functions with a "when" argument that is set to Sys.time() by default.
#   This allows providing other time points for which the question is answered. 
#   e.g., On what day was my birthday? 

## ToDo: ----------


## eof. ----------------------