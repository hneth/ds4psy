## time_fun.R | ds4psy
## hn | uni.kn | 2020 07 11
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
# # fame data (with format string):
# date_from_string(fame$DOB, format = "%B %d, %Y")
# 
# # (!) NOT accounted for:
# date_from_string("August 10, 2010")  # BdY
# # but works with format string: 
# date_from_string("August 10, 2010", format = "%B %d, %Y") 
# 
# date_from_string("12.8")  # no year
# # but providing formats works: 
# date_from_string("12.8", format = "%d.%m")
# date_from_string("12.8", format = "%m.%d")
# 
# date_from_string(c("12-8-2010", "12-Aug-10"))  # mix of formats
# date_from_string(c("2010-8-12", "12-8-2010"))  # mix of orders


# date_from_non_Date: Parse non-Date into "Date" object(s): ------ 

date_from_non_Date <- function(x, ...){
  
  dt <- NA
  
  # 1. Coerce numeric x that are NOT date-time objects into character strings:
  if (!is_date_time(x) & is.numeric(x)){
    # message('date_from_non_Date: Coercing x from "number" into "character".')    
    x <- as.character(x)
  }
  
  # 2. Aim to coerce character string inputs x into "Date": 
  if (is.character(x)){
    # message('date_from_non_Date: Aiming to parse x from "character" as "Date".')
    dt <- date_from_string(x, ...)
  }
  
  # 3. Coerce "POSIXt" inputs into "Date":
  if (is_POSIXt(x)){
    # message('date_from_non_Date: Coercing x from "POSIXt" into "Date".')
    dt <- as.Date(x, ...) 
  }
  
  # 4. Note if dt is still no "Date": ---- 
  if (!is_Date(dt)){
    
    message('date_from_non_Date: Failed to parse x as "Date".')
    
  }
  
  return(dt)
  
} # date_from_non_Date end. 

# # Check:
# date_from_non_Date(20100612)    # number
# date_from_non_Date("20100612")  # string
# date_from_non_Date(as.POSIXct("2010-06-10 12:30:45", tz = "UTC"))
# date_from_non_Date(as.POSIXlt("2010-06-10 12:30:45", tz = "UTC"))
# 
# # fame data (with format string):
# date_from_non_Date(fame$DOB, format = "%B %d, %Y")
# 
# # Note errors for:
# date_from_non_Date(123)
# date_from_non_Date("ABC")





## (C) Temporal idiosyncracies: ------ 

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
#' \code{is_leap_year} then solves the task 
#' by verifying the numeric definition of a "leap year" 
#' (see \url{https://en.wikipedia.org/wiki/Leap_year}). 
#' 
#' An alternative solution that tried using  
#' \code{as.Date()} for defining a "Date" of Feb-29 
#' in the corresponding year(s) was removed, 
#' as it evaluated \code{NA} values as \code{FALSE}.
#' 
#' @param dt Date or time (scalar or vector). 
#' Numbers or strings with dates are parsed into 
#' 4-digit numbers denoting the year. 
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
  
  # print(dt)  # debugging 
  
  # initialize: 
  y <- NA
  out_1 <- NA
  out_2 <- NA
  
  # Determine y (as integer):
  if (is_Date(dt) | is_POSIXct(dt) | is_POSIXlt(dt)){
    
    y <- as.numeric(format(dt, format = "%Y"))
    
  } else if (is.character(dt)){
    
    if (all(grepl(x = dt, pattern = "^\\d\\d\\d\\d$"))) {
      
      # message('is_leap_year: Parsing string dt as "yyyy").')      
      y <- as.numeric(dt)
      
    } else {
      
      message('is_leap_year: Coercing string dt into "Date" (to get "%Y").')
      y <- as.numeric(format(as.Date(dt), format = "%Y"))
      
    }
    
  } else if (is.numeric(dt)){ 
    
    if (all(is.wholenumber(dt))){
      
      y <- dt
      
    } else {
      
      message('is_leap_year: Rounding numeric dt to nearest integer.')
      y <- round(dt, 0)
      
    }} else {
      
      message('is_leap_year: Failed to parse dt into year.')
      
    }
  
  if (any(is.na(y))){
    message('is_leap_year: Some y values are NA.')  # notify user
  }
  
  # Use 2 solutions:
  # 1. Using definition from <https://en.wikipedia.org/wiki/Leap_year>:
  out_1 <- (y %% 4 == 0) & ((y %% 100 != 0) | (y %% 400 == 0))
  # print(out_1)  # debugging
  
  # # 2. Try defining Feb-29 as "Date" (NA if non-existent):
  # feb_29 <- paste(y, "02", "29", sep = "-")
  # out_2  <- !is.na(as.Date(feb_29, format = "%Y-%m-%d"))  # ERROR: y = NA becomes FALSE
  # # print(out_2)  # debugging
  
  # if (!all.equal(out_1, out_2)){  # Warn of discrepancy: 
  #   warning("is_leap_year: Two solutions yield different results. Using 1st.")
  # }
  
  return(out_1)
  
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
# is_leap_year("2021-02-29")



# MONTH_DAYS: Define a CONSTANT for days in TYPICAL month (no leap year): ------  
MONTH_DAYS <- c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31) 
# sum(MONTH_DAYS)  # 365
names(MONTH_DAYS) <- base::month.abb

# days_in_month: Get number of days in a given month (based on date): ------

# Note: Requires "Date" (rather than only month name/nr.) to check for leap years. 

#' How many days are in a month (of given date)? 
#'
#' \code{days_in_month} computes the number of days in the months of 
#' given dates (provided as a date or time \code{dt}, 
#' or number/string denoting a 4-digit year). 
#' 
#' The function requires \code{dt} as "Dates", 
#' rather than month names or numbers, 
#' to check for leap years (in which February has 29 days). 
#'
#' @param dt Date or time (scalar or vector). 
#' Default: \code{dt = Sys.Date()}. 
#' Numbers or strings with dates are parsed into 
#' 4-digit numbers denoting the year. 
#' 
#' @param ... Other parameters (passed to \code{as.Date()}). 
#' 
#' @return A named (numeric) vector. 
#' 
#' @examples
#' days_in_month() 
#' 
#' # Robustness: 
#' days_in_month(Sys.Date())    # Date
#' days_in_month(Sys.time())    # POSIXct
#' days_in_month("2020-07-01")  # string
#' days_in_month(20200901)      # number
#' days_in_month(c("2020-02-10 01:02:03", "2021-02-11", "2024-02-12"))  # vectors of strings
#' 
#' # For leap years:
#' ds <- as.Date("2020-02-20") + (365 * 0:4)  
#' days_in_month(ds)  # (2020/2024 are leap years)
#' 
#' @family date and time functions
#' 
#' @seealso 
#' \code{\link{is_leap_year}} function to check for leap years. 
#' 
#' @export

days_in_month <- function(dt = Sys.Date(), ...){
  
  if (!is_Date(dt)){ dt <- date_from_non_Date(dt, ...) }
  
  month_nr <- as.numeric(format(dt, format = "%m"))
  # message(paste(month_nr, collapse = " "))
  
  nr_days <- MONTH_DAYS[month_nr]
  # message(paste(nr_days, collapse = " "))
  
  # special case: Feb. of leap year has 29 days: 
  nr_days[(month_nr == 2) & (is_leap_year(dt))] <- 29 
  
  return(nr_days)
  
} # days_in_month end. 

# ## Check:
# days_in_month(Sys.Date())    # Date
# days_in_month(Sys.time())    # POSIXct
# days_in_month("2020-07-01")  # string
# days_in_month(20200901)      # number
# days_in_month(c("2020-02-10 01:02:03", "2021-02-11", "2024-02-12"))  # vectors of strings
# 
# # # leap years:
# ds <- as.Date("2020-02-20") + (365 * 0:4)  # 2020 and 2024 are leap years
# ds
# days_in_month(ds)


# days_last_month: Get number of days in a PRECEDING month (based on date): ------

days_last_month <- function(dt, ...){
  
  out <- NA
  
  # (a) Handle inputs:   
  if (!is_Date(dt)){ dt <- date_from_non_Date(dt, ...) }
  
  # (b) Get dt elements: 
  year_nr  <- as.numeric(format(dt, format = "%Y"))
  month_nr <- as.numeric(format(dt, format = "%m"))
  
  # (c) Main processing: 
  last_month_nr <- (month_nr - 1)          # reduce month_nr by 1
  
  # Handle special case: Dec becomes Jan of preceding year: 
  last_month_nr[last_month_nr == 0] <- 12  # Dec <- Jan
  year_nr[last_month_nr == 12] <- (year_nr[last_month_nr == 12] - 1)  # preceding year!
  
  # Construct as date: 
  # Heuristic: A 15. day exists for all months, but cannot be mistaken for month_nr: 
  mid_last_month <- paste(year_nr, last_month_nr, "15", sep = "-")
  dt_last_month <- as.Date(mid_last_month, format = "%Y-%m-%d")
  
  # message(paste(dt_last_month, collapse = " "))  # debugging
  
  # Get days_in_month() for dates of dt_last_month: 
  out <- days_in_month(dt_last_month) 
  
  # (d) Output:  
  return(out)
  
} # days_last_month end. 

## Check:
# days_last_month(as.Date("2020-01-10"))
# 
# (dts <- as.Date("2020-01-15") + 30 * 0:12)
# days_in_month(dts)
# days_last_month(dts)
# 
# days_last_month(c("2020-01-10", "2020-02-11", "2020-03-12"))  # vectors of strings


# bday_eq_last_month: Get closest equivalent to bday in last month: ------ 

# Helper function bday_eq_last_month(to_date, bday): 
# Get closest equivalent to bday in last month (e.g., 
# - 28.02. if bday on 30.03 and no leap year,
# - 30.11 for bday on 31.12, etc.)

bday_eq_last_month <- function(dt, bday, ...){
  
  # (a) Handle inputs:
  if (!is_Date(dt)){ dt <- date_from_non_Date(dt, ...) }
  
  if (length(dt) > length(bday)){
    
    bday <- rep(bday, length.out = length(dt))  # recycle bday
    
  }
  
  # (b) Get dt elements:
  year_nr  <- as.numeric(format(dt, format = "%Y"))
  month_nr <- as.numeric(format(dt, format = "%m"))
  
  # (c) Main processing: 
  last_month_nr <- (month_nr - 1)          # reduce month_nr by 1
  
  # Handle special case: Dec becomes Jan of preceding year: 
  last_month_nr[last_month_nr == 0] <- 12  # Dec <- Jan!
  year_nr[last_month_nr == 12] <- (year_nr[last_month_nr == 12] - 1)  # preceding year!
  
  # How many days were there last month?
  max_day_last_month <- days_last_month(dt)
  
  day_nr <- rep(NA, length(dt))
  
  # Distinguish 2 cases:
  day_nr[max_day_last_month >= bday] <- bday[max_day_last_month >= bday]  # 1. bday exists in last month; OR 
  day_nr[max_day_last_month < bday]  <- max_day_last_month[max_day_last_month < bday]  # 2. take max_day_last_month instead.
  
  # Construct as date: 
  bd_last_month <- paste(year_nr, last_month_nr, day_nr, sep = "-")
  dt_last_month <- as.Date(bd_last_month, format = "%Y-%m-%d")
  
  # message(dt_last_month)  # debugging
  
  # (d) Output:   
  return(dt_last_month)
  
} # bday_eq_last_month end. 

## Check:
# bday_eq_last_month("2020-01-01", bday = 31)
# bday_eq_last_month("2020-12-01", bday = 31)
# 
# bday_eq_last_month("2020-03-01", bday = 29)  # 2020 is leap year
# bday_eq_last_month("2020-03-01", bday = 30)
# bday_eq_last_month("2020-03-01", bday = 31)
# 
# bday_eq_last_month("2021-03-01", bday = 29)  # 2021 is NO leap year
# bday_eq_last_month("2021-03-01", bday = 30)
# bday_eq_last_month("2021-03-01", bday = 31)
# 
# # For vectors:
# (ds <- paste("2021", 1:12, 15, sep = "-"))  # 2021 is NO leap year
# bday_eq_last_month(ds, bday = 29)
# bday_eq_last_month(ds, bday = 30)
# bday_eq_last_month(ds, bday = 31)


# dt_last_monthly_bd: Get last full-month bday: ------ 

dt_last_monthly_bd <- function(dob, to_date, ...){
  
  # (a) Handle inputs:
  if (!is_Date(dob)){ dob <- date_from_non_Date(dob, ...) }
  if (!is_Date(to_date)){to_date <- date_from_non_Date(to_date, ...) }
  
  N <- length(dob)
  
  if (N > length(to_date)){
    
    to_date <- rep(to_date, length.out = N)  # recycle to_date
    
  }
  
  # (b) Get dt elements:
  dob_y <- as.numeric(format(dob, format = "%Y"))
  dob_m <- as.numeric(format(dob, format = "%m"))
  dob_d <- as.numeric(format(dob, format = "%d"))
  
  tod_y <- as.numeric(format(to_date, format = "%Y"))
  tod_m <- as.numeric(format(to_date, format = "%m"))
  tod_d <- as.numeric(format(to_date, format = "%d"))
  
  # (c) Main processing: 
  bd_this_month <- tod_d >= dob_d  # flag
  
  dt_y <- tod_y
  dt_m <- rep(NA, N)
  
  # # Distinguish 2 cases:
  # dt_m[bd_this_month]  <- tod_m[bd_this_month]
  # dt_m[!bd_this_month] <- tod_m[!bd_this_month] - 1
  # Combine cases:
  dt_m <- tod_m - (1 * !bd_this_month)
  
  # Handle special case: Dec becomes Jan of preceding year: 
  dt_m[dt_m == 0]  <- 12  # Dec <- Jan! 
  dt_y[dt_m == 12] <- dt_y[dt_m == 12] - 1   # preceding year!
  
  # Construct as date: 
  dt_string <- paste(dt_y, dt_m, dob_d, sep = "-")
  dt <- as.Date(dt_string, format = "%Y-%m-%d")
  
  # Handle special case: 
  # Problem: dt is NA for non-existent dates (e.g., Feb 30, June 31, ...)
  
  # # Solution 1: Get LAST day of PRECEDING month:
  # ix <- is.na(dt)
  # dob_d[ix]     <- days_last_month(dt = to_date[ix])  # using days_last_month() helper!
  # dt_string[ix] <- paste(dt_y[ix], dt_m[ix], dob_d[ix], sep = "-")
  # dt[ix] <- as.Date(dt_string[ix], format = "%Y-%m-%d")
  
  # Solution 2: Get FIRST day of CURRENT month, then subtract 1 day:
  ix <- is.na(dt)
  # dob_d[ix]     <- days_last_month(dt = to_date[ix])
  dt_string[ix] <- paste(dt_y[ix], tod_m[ix], "01", sep = "-")
  dt[ix] <- as.Date(dt_string[ix], format = "%Y-%m-%d") - 1
  
  # Note: One could also argue for 1st of current month for these cases???
  
  # (d) Output:   
  return(dt)
  
} # dt_last_monthly_bd end. 

# ## Check:
# (bd <- as.Date("2020-01-28") + 0:4)
# dt_last_monthly_bd(bd, as.Date("2020-03-10"))
# dt_last_monthly_bd(bd, "2021-03-31")
# dt_last_monthly_bd(bd, "2021-03-01")
# 
# # Special cases:
# dt_last_monthly_bd("2020-12-31", "2020-01-01")  # dob > to_date
# dt_last_monthly_bd("2020-03-31", "2020-03-01")  # dob > to_date
# dt_last_monthly_bd("2020-03-31", "2020-03-31")  # dob = to_date


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
    # message('what_wday: Aiming to parse "when" as "Date".')
    when <- date_from_non_Date(when)
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





## (3) Time conversions: ---------- 
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
    
    message('change_time: Coercing time to "POSIXlt" without changing time display.')
    
    # A: Determine time_display: 
    if (is_POSIXct(time)){
      
      message('change_time: Parsing time from "POSIXct" as "%Y-%m-%d %H:%M:%S".')
      time_display <- strptime(time, format = "%Y-%m-%d %H:%M:%S")
      
    } else if (is_Date(time)){
      
      message('change_time: Parsing time from "Date" as "%Y-%m-%d".')      
      time_display <- strptime(time, format = "%Y-%m-%d")
      
    } else if (is.character(time)){
      
      # Get time_display by parsing date-time string (using standard formats):
      if (grepl(x = time, pattern = ".*(-).*( ).*(:).*(:).*")) { # date + full time:
        
        message('change_time: Parsing date-time from string as "%Y-%m-%d %H:%M:%S".')
        time_display <- strptime(time, format = "%Y-%m-%d %H:%M:%S")
        
      } else if (grepl(x = time, pattern = ".*(-).*( ).*(:).*")) { # date + H:M time:
        
        message('change_time: Parsing date-time from string as "%Y-%m-%d %H:%M".')
        time_display <- strptime(time, format = "%Y-%m-%d %H:%M")
        
      } else if (grepl(x = time, pattern = ".*(:).*(:).*")) { # H:M:S time:
        
        message('change_time: Parsing time (with default date) from string as "%H:%M:%S".')
        time_display <- strptime(time, format = "%H:%M:%S")
        
      } else if (grepl(x = time, pattern = ".*(:).*")) { # H:M time:
        
        message('change_time: Parsing time (with default date) from string as "%H:%M".')
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
    
    message('change_tz: Coercing time to "POSIXct" without changing represented time.')
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




## (4) Compute differences between 2 dates/times (in human time units/periods): ------  

# diff_days: Difference between two dates (in days): ------ 

diff_days <- function(from_date, to_date = Sys.Date(), units = "days", as_Date = TRUE, ...){
  
  # Assume that from_date and to_date are valid dates OR times:   
  # (Otherwise, see diff_dates() function below). 
  
  if (as_Date) { # Convert non-Date (e.g., POSIXt) into "Date" objects:
    
    if (!is_Date(from_date)) { from_date <- date_from_non_Date(from_date, ...) }
    
    if (!is_Date(to_date))   { to_date <- date_from_non_Date(to_date, ...) }
    
  }
  
  # print(from_date)  # debugging
  # print(to_date)    # debugging
  
  # Call difftime:
  t_diff <- base::difftime(to_date, from_date, units = units, ...)  # default: units = "days"
  
  n_days <- NA
  
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
# # ## Note: Date vs. time differences:
# t0 <- as.POSIXct("2020-07-10 00:00:01", tz = "UTC")  # start of day
# t1 <- as.POSIXct("2020-07-10 23:59:59", tz = "UTC")  # end of day
# t2 <- t1 + 2  # 2 seconds later (but next date)
# 
# # By default, only Dates are considered:
# diff_days(t0, t1)
# diff_days(t1, t2)
# diff_days(t0, t2)
# 
# # But: Exact time differences:
# diff_days(t0, t1, as_Date = FALSE)
# diff_days(t1, t2, as_Date = FALSE)
# diff_days(t0, t2)


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
#' @param unit Largest measurement unit for representing result. 
#' Units represent human time periods, rather than 
#' chronological time differences. 
#' Default: \code{unit = "y"} for completed years, months, and days. 
#' Available options are: 
#' \enumerate{
#' 
#'   \item \code{unit = "y"}: completed years, months, and days (default)
#'   
#'   \item \code{unit = "m"}: completed months, and days
#'   
#'   \item \code{unit = "d"}: completed days
#'   
#'   }
#'   
#' @param as_character Boolean: Return output as character? 
#' Default: \code{as_character = TRUE}.  
#' If \code{as_character = FALSE}, results are returned 
#' as columns of a data frame and 
#' include \code{from_date} and \code{to_date}. 
#' 
#' @return A character vector or data frame 
#' (with dates and numeric columns).
#' 
#' @examples
#' y_100 <- Sys.Date() - (100 * 365.25) + -1:1
#' diff_dates(y_100)
#' 
#' # with "to_date" argument: 
#' y_050 <- Sys.Date() - (50 * 365.25) + -1:1 
#' diff_dates(y_100, y_050)
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
#' # Using 'fame' data:
#' dob <- as.Date(fame$DOB, format = "%B %d, %Y")
#' dod <- as.Date(fame$DOD, format = "%B %d, %Y")
#' diff_dates(dob, dod)  # Note: Deceased people do not age further.
#' 
#' # Numeric outputs:
#' head(diff_dates(dob, dod, as_character = FALSE))
#' 
#' @family date and time functions
#' 
#' @export

diff_dates <- function(from_date, to_date = Sys.Date(), 
                       unit = "y", as_character = TRUE){
  
  # 1. Handle inputs: ------  
  
  # (a) NA inputs: ----
  
  if (any(is.na(from_date))){
    message('diff_dates: "from_date" must not be NA.')    
    return(NA)
  }
  
  if (all(is.na(to_date))){
    message('diff_dates: Changing "to_date" from NA to "Sys.Date()".')       
    to_date <- Sys.Date()
  }
  
  # (b) Turn non-Date inputs into "Date" objects ---- 
  
  if (!is_Date(from_date)){
    # message('diff_dates: Aiming to parse "from_date" as "Date".')
    from_date <- date_from_non_Date(from_date)
  }
  
  if (!is_Date(to_date)){
    # message('diff_dates: Aiming to parse "to_date" as "Date".')
    to_date <- date_from_non_Date(to_date)
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
    message('diff_dates: "from_date" should be of class "Date".')
    # print(from_date)  # debugging
  }
  
  if (!is_Date(to_date)){
    message('diff_dates: "to_date" should be of class "Date".')
    # print(to_date)    # debugging
  }
  
  # (f) Unit: ----
  unit <- substr(tolower(unit), 1, 1)  # robustness: use abbreviation: y/m/d
  
  if (!unit %in% c("y", "m", "d")){
    message('diff_dates: unit must be "y", "m", or "d". Using "y".')
    unit <- "y"
  }
  
  
  # 2. Main function: ------ 
  
  # (a) initialize: ---- 
  age <- NA    
  full_y <- NA
  full_m <- NA
  full_d <- NA
  
  # (b) Special case: unit == "d" ---- 
  if (unit == "d"){
    
    full_d <- diff_days(from_date = from_date, to_date = to_date)
    
    if (as_character){
      
      age <- paste0(full_d, "d") 
      
    } else { # return as data frame:
      
      age <- data.frame("from_date" = from_date,
                        "to_date" = to_date, 
                        "d" = full_d)
      
    }
    
    return(age)
    
  }
  
  # (c) Other units (y/m): Get date elements ---- 
  
  # from_date elements (DOB):
  bd_year  <- as.numeric(format(from_date, "%Y"))
  bd_month <- as.numeric(format(from_date, "%m"))
  bd_day   <- as.numeric(format(from_date, "%d"))
  
  # to_date elements (DOD, max. date): 
  cur_year  <- as.numeric(format(to_date, "%Y"))
  cur_month <- as.numeric(format(to_date, "%m"))
  cur_day   <- as.numeric(format(to_date, "%d"))
  
  
  # (c1) Completed years: ---- 
  
  # bday this year? (as Boolean): 
  bd_ty <- ifelse((cur_month > bd_month) | ((cur_month == bd_month) & (cur_day >= bd_day)), TRUE, FALSE) 
  # print(bd_ty)
  
  full_y <- (cur_year - bd_year) - (1 * !bd_ty) 
  
  
  # (c2) Completed months: ---- 
  
  # bday this month? (as Boolean): 
  bd_tm <- ifelse((cur_day >= bd_day), TRUE, FALSE) 
  # print(bd_tm)
  
  ## Distinguish 2 cases:
  # full_m[bd_ty]  <- (cur_month[bd_ty]  - bd_month[bd_ty])  - !bd_tm[bd_ty]        # 1:  bd_ty
  # full_m[!bd_ty] <- (12 + cur_month[!bd_ty] - bd_month[!bd_ty]) - !bd_tm[!bd_ty]  # 2: !bd_ty
  
  ## Combine both cases:
  full_m <- (cur_month - bd_month) + (12 * !bd_ty) - (1 * !bd_tm) 
  
  if (unit == "m"){
    
    full_m <- (12 * full_y) + full_m  # express years in months
    
  }
  
  # (c3) Completed days: ---- 
  
  ## bday today? (as Boolean): 
  # bd_td <- ifelse((cur_day == bd_day), TRUE, FALSE) 
  
  # Idea 1: Local solution: Determine the number N of days in last month.
  # Then use this number to compute difference from bd_day to cur_day 
  
  ## Distinguish 2 cases:  
  # full_d[bd_tm]  <- cur_day[bd_tm]  - bd_day[bd_tm]  # 1:  bd_tm
  # full_d[!bd_tm] <- cur_day[!bd_tm] - bd_day[!bd_tm] + days_last_month(to_date[!bd_tm])  # 2: !bd_tm
  
  ## Combine both cases:
  full_d <- cur_day - bd_day + (days_last_month(to_date) * !bd_tm) 
  
  message(paste(full_d, collapse = " "))  # debugging
  
  # Idea 2: Global solution: Use global number of days and subtract all days of full years and months 
  # Use diff_days helper function to compute exact number of days between two dates:
  # age_d <- diff_days(DOB, to_date) - diff_days(DOB, to_date = bday_eq_last_month)
  
  # +++ here now +++ 
  
  # ToDo: Helper function bday_eq_last_month(to_date, bday): 
  #       Get closest equivalent to bday in last month (e.g., 
  #       28.02. if bday on 30.03 and no leap year,
  #       30.11 for bday on 31.12, etc.)
  
  total_days <- diff_days(from_date = from_date, to_date = to_date)
  dt_bday_last_month <- bday_eq_last_month(dt = to_date, bday = bd_day)
  accounted_days <- diff_days(from_date = from_date, to_date = dt_bday_last_month)
  
  full_d_2 <- total_days - accounted_days
  
  message(paste(full_d_2, collapse = " "))  # debugging
  
  if (!all.equal(full_d, full_d_2)){
    message('diff_dates: 2 alternative solutions for d differ.')
  }
  
  # 3. Output: ------ 
  
  if (as_character){
    
    if (unit == "y"){
      
      age <- paste0(full_y, "y ", full_m, "m ", full_d, "d")
      
    } else if (unit == "m"){
      
      age <- paste0(full_m, "m ", full_d, "d")
      
    }
    
  } else { # return as data frame:
    
    if (unit == "y"){
      
      age <- data.frame("from_date" = from_date,
                        "to_date" = to_date, 
                        "y" = full_y, 
                        "m" = full_m, 
                        "d" = full_d)
      
    } else if (unit == "m"){
      
      age <- data.frame("from_date" = from_date,
                        "to_date" = to_date, 
                        "m" = full_m, 
                        "d" = full_d)
      
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
# # recycling "to_date" to length of "from_date":
# y_050_2 <- Sys.Date() - (50 * 365.25)
# y_050_2
# diff_dates(y_100, y_050_2)
# 
# # Using 'fame' data:
# dob <- as.Date(fame$DOB, format = "%B %d, %Y")
# dob
# dod <- as.Date(fame$DOD, format = "%B %d, %Y")
# dod
# diff_dates(dob, dod)
# diff_dates(dob, dod, unit = "m")
# diff_dates(dob, dod, unit = "d")

## Analyze: Compare results to other methods: 

## (a) lubridate time spans (interval, periods): 
# lubridate::as.period(dob %--% dod, unit = "years")
# lubridate::as.period(lubridate::interval(dob, dod), unit = "years")
# lubridate::as.period(lubridate::interval(dob, dod), unit = "months")
# lubridate::as.period(lubridate::interval(dob, dod), unit = "days")

## (b) base::difftime():
# all.equal(as.numeric(dod - dob), diff_days(dob, dod))
# all.equal(as.numeric(difftime(dod, dob)), diff_days(dob, dod))
# difftime(dod, dob, units = "weeks")  # Note: No "weeks" in diff_dates().

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

# - if from_date is later than to_date: Reverse dates and negate result.
# - add n_decimals argument (default of 0).
#
# - Add exercise to Chapter 10: 
#   Explore the diff_dates() function that computes 
#   the difference between two dates (in human measurement units). 
# - Use result to compute age in years (as number) and months (as number). 
# - Use result to compute age in full weeks (as number). 
# - Use result to add a week entry "Xw" between month m and day d.



## Done: ----------

# - Provided all what_ functions with a "when" argument that is set to Sys.Date() 
#   or Sys.time() by default, allowing for other dates/times for which question 
#   is answered (e.g., On what day was my birthday?) 
# - change_tz() and change_time() function(s) 
#   for converting time display (in "POSIXct") into local times (in "POSIXlt"), 
#   and vice versa (chaging times, but not time display). 

## ToDo: ----------

# - consider moving time utility/helper functions into separate file.

# ad (1) and (2): 
# - update cur_ and what_ functions to use new helpers
# - re-consider what_day() to return NUMERIC day in week/month/year.
# - fix ToDo in what_date() (Actively convert time?)
# - Return dates/times either as strings (if as_string = TRUE) or 
#   as dates/times (of class "Date"/"POSIXct") in all what_() functions

# ad (4): Differences between dates/times:
# - finish diff_dates (or date_diff) function. 
# - consider adding diff_times function (analog to diff_dates, but for date-times, including H:M:S)

## eof. ----------------------