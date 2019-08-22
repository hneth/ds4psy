## time_fun.R | ds4psy
## hn | uni.kn | 2019 08 22
## ---------------------------

## Functions for date and time objects. 

# Note: The R base function 
# date()  # returns date as "Wed Aug 21 19:43:22 2019", 
# which is more than we usually want.

# Some simpler variants following a simple heuristic: 
# What is it that we _usually_ want to hear as `x` when asking 
# "What `x` is it today?" or "What `x` is it right now?"


## (1) CUR_ functions: ---------- 

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
  t <- Sys.time()
  
  # Formatting instruction string:   
  if (rev){
    fmt <- paste("%d", "%m", "%Y", sep = sep, collapse = "")  # using sep
  } else {
    fmt <- paste("%Y", "%m", "%d", sep = sep, collapse = "")  # using sep
  }
  
  # Return formatted t: 
  format(t, fmt)   
  
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



## (2) WHAT_ functions: ---------- 

# About 5% are covered by 4 additional functions that ask `what_` questions
# about the position of some temporal unit in some larger continuum of time:
# 
# - `what_day()`  : as name (weekday, abbr or full), OR as number (in units of week, month, or year; as char or as integer)  
# - `what_week()` : only as number (in units of month, or year); return as char or as integer   
# - `what_month()`: as name (abbr or full) OR as number (as char or as integer)  
# - `what_year()` : only as number (abbr or full), return as char or as integer
#  
# All of these take some "point in time" time as input,
# which defaults to now (i.e., Sys.time()) but can also be a vector.

# what_year: What year is it? (number only) ------ 

what_year <- function(time = Sys.time(), abbr = FALSE, as_integer = FALSE){
  
  # Check time input:
  # ToDo 
  
  # initialize:
  y <- NA
  
  # get year y:
  if (abbr){ 
    y <- format(time, "%y") 
  } else { 
    y <- format(time, "%Y") 
  } 
  
  # as char or integer:
  if (as_integer) {
    as.integer(y)
  } else {
    y
  }
  
}  # what_year end. 

## Check:
# what_year()
# what_year(abbr = TRUE)
# what_year(as_integer = TRUE)
# 
# # other dates/times:
# dt <- as.Date("1987-07-13")
# what_year(time = dt, abbr = TRUE, as_integer = TRUE)



# what_week: What week is it? (number only) ------ 

what_week <- function(time = Sys.time(), unit = "year", as_integer = FALSE){
  
  # Robustness:
  unit <- substr(tolower(unit), 1, 1)  # use only 1st letter of string
  
  # Check time input:
  # ToDo 
  
  # initialize:
  w <- NA
  
  # get week w (as char):
  if (unit == "m"){  # unit "month": 
    
    # Searching nr. of week corresponding to current time in current month?
    # Sources: Adapted from a discussion at 
    # <https://stackoverflow.com/questions/25199851/r-how-to-get-the-week-number-of-the-month>
    
    # current date:
    d_now <- as.Date(time)
    wk_n  <- as.numeric(format(d_now, "%V"))  # corresponding week (01--53) as defined in ISO 8601 (week starts Monday)
    
    # date of 1st in month:
    d_1st <- as.Date(cut(d_now, "month"))
    wk_1  <- as.numeric(format(d_1st, "%V"))  # corresponding week (01--53) as defined in ISO 8601 (week starts on Monday)
    
    # difference: 
    w <- (wk_n - wk_1) + 1  # as number
    w <- as.character(w)    # as character
    
  } else if (unit == "y") {  # unit "year": 
    
    w <- format(time, "%V")  # %V: week of the year as decimal number (01--53) as defined in ISO 8601 (week starts on Monday)
    
  } else {  # some other unit: 
    
    message("Unknown unit. Using unit = 'year' instead:")
    w <- format(time, "%V")  # %V: week of the year as decimal number (01--53) as defined in ISO 8601 (week starts on Monday)
    
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
# # other dates/times:
# d1 <- as.Date("2019-08-23")
# what_week(time = d1, unit = "year")
# 
# # Week nr. (in month):
# d2 <- as.Date("2019-06-23") # Sunday of 4th week in June 2019.
# what_week(time = d2, unit = "month")
# d3 <- as.Date("2019-06-24") # Monday of 5th week in June 2019.
# what_week(time = d3, unit = "month")




## OLDER code: ---------- 

# cur_weekday: What day of the week is it today? ------

cur_weekday <- function(abbr = FALSE, as_integer = FALSE){
  
  t <- Sys.time()
  
  if (as_integer){
    
    as.integer(format(t, "%u"))  # Monday is 1
    
  } else {
    
    if (abbr) {
      
      format(t, "%a")        
      
    } else {
      
      format(t, "%A")       
      
    }
    
  }
  
}  # cur_weekday end.

## Check:
# cur_weekday()
# cur_weekday(abb = TRUE)
# cur_weekday(as_integer = TRUE)
# cur_weekday(abb = TRUE, as_integer = TRUE)


# cur_month_name: The name of the current month: ------ 

cur_month_name <- function(abb = FALSE){
  
  if (abb){
    
    format(Sys.time(), "%b")  
    
  } else {
    
    format(Sys.time(), "%B")  
    
  }
  
}  # cur_monthname end. 

## Check:
# month_name()
# month_name(abb = TRUE)


# cur_month_nr: The number of the current month: ------ 

cur_month_nr <- function(as_integer = FALSE){
  
  mc <- format(Sys.time(), "%m")
  
  if (as_integer) {
    
    as.integer(mc)
    
  } else {
    
    mc
    
  }
  
}

## Check:
# cur_month_nr()
# cur_month_nr(as_integer = TRUE)



## ToDo: ----------

# - provide all functions with a "time" argument that is set to Sys.time() by default.
#   This allows providing other time points for which the question is answered. 
#   e.g., On what day was my birthday? 

# - add what_date() and what_time() as simple wrappers to cur_date() and cur_time()

## eof. ----------------------