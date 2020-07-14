## time_fun.R | ds4psy
## hn | uni.kn | 2020 07 14
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
  
  # 0. Initialize: 
  dt <- NA
  
  # 1. Prepare: ---- 
  
  if (is_Date(x)){ return(x) }  # fast exit
  
  if (!is.character(x)){
    
    # message("date_from_string: Coercing x into a character string.")
    
    x <- as.character(x)
    
  }
  
  # 2. Aim to identify date format: ---- 
  
  x_1 <- x[1]  # Heuristic: Check 1st item: Position of 4-digit year (yyyy)? 
  
  if (grepl(x = x_1, pattern = "^(\\d\\d\\d\\d)")){ # yyyy first:
    
    date_frms <- date_frms_Ymd
    
  } else if (grepl(x = x_1, pattern = "(\\d\\d\\d\\d)$")){ # yyyy at end:
    
    date_frms <- date_frms_dmY
    
  } else { # year is yy:  
    
    date_frms <- c(date_frms_ymd, date_frms_dmy)  # => prefer yy first.
    
  }
  
  # 3. Main: Parse x as.Date(x) using date_frms: ---- 
  dt <- as.Date(x, tryFormats = date_frms, ...)
  
  # 4. Output: 
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


# date_from_noDate: Parse non-Date into "Date" object(s): ------ 

date_from_noDate <- function(x, ...){
  
  # 0. Initialize: 
  dt <- NA
  
  # 1. Prepare: ---- 
  
  if (is_Date(x)){ return(x) }  # fast exit
  
  # Coerce numeric x that are NOT date-time objects into character strings:
  if (!is_date_time(x) & is.numeric(x)){
    # message('date_from_noDate: Coercing x from "number" into "character".')    
    x <- as.character(x)
  }
  
  # 2. Main: Coerce non-Date objects into "Date" objects: ---- 
  
  # A. Aim to coerce character string inputs x into "Date": 
  if (is.character(x)){
    # message('date_from_noDate: Aiming to parse x from "character" as "Date".')
    dt <- date_from_string(x, ...)
  }
  
  # B. Coerce "POSIXt" inputs into "Date":
  if (is_POSIXt(x)){
    # message('date_from_noDate: Coercing x from "POSIXt" into "Date".')
    dt <- as.Date(x, ...) 
  }
  
  # 3. Verify "Date": ---- 
  if (!is_Date(dt)){
    
    message('date_from_noDate: Failed to parse x as "Date".')
    
  }
  
  # 4. Output: 
  return(dt)
  
} # date_from_noDate end. 

# # Check:
# date_from_noDate(20100612)    # number
# date_from_noDate("20100612")  # string
# date_from_noDate(as.POSIXct("2010-06-10 12:30:45", tz = "UTC"))
# date_from_noDate(as.POSIXlt("2010-06-10 12:30:45", tz = "UTC"))
# 
# # fame data (with format string):
# date_from_noDate(fame$DOB, format = "%B %d, %Y")
# 
# # Note errors for:
# date_from_noDate(123)
# date_from_noDate("ABC")


# time_from_string: Parse a string into "POSIXt" (without tz): ------

time_from_string <- function(x, tz = "", ...){
  
  # 0. Initialize: 
  t <- NA
  
  # 1. Prepare: ---- 
  
  if (is_POSIXt(x)){ return(x) }  # fast exit
  
  if (!is.character(x)){
    
    # message("time_from_string: Coercing x into a character string.")
    x <- as.character(x)
    
  }
  
  # 2. Main: Convert x into POSIXct: ---- 
  t <- as.POSIXct(x, 
                  tz = tz, # Note: tz = "" by default. 
                  tryFormats = c(# format strings:
                    # y: yy
                    "%y%m%d%H%M%OS",
                    "%y-%m-%d %H:%M:%OS",
                    "%y/%m/%d %H:%M:%OS",
                    "%y-%m-%d %H.%M.%OS",
                    "%y/%m/%d %H.%M.%OS",
                    "%y%m%d%H%M",
                    "%y-%m-%d %H:%M",
                    "%y/%m/%d %H:%M",
                    "%y-%m-%d %H.%M",
                    "%y/%m/%d %H.%M",
                    "%y%m%d",
                    "%y-%m-%d",
                    "%y/%m/%d",
                    # Y: yyyy 
                    "%Y%m%d%H%M%OS",
                    "%Y-%m-%d %H:%M:%OS",
                    "%Y/%m/%d %H:%M:%OS",
                    "%Y-%m-%d %H.%M.%OS",
                    "%Y/%m/%d %H.%M.%OS",
                    "%Y%m%d%H%M",
                    "%Y-%m-%d %H:%M",
                    "%Y/%m/%d %H:%M",
                    "%Y-%m-%d %H.%M",
                    "%Y/%m/%d %H.%M",
                    "%Y%m%d",
                    "%Y-%m-%d",
                    "%Y/%m/%d",
                    # no date:
                    "%H%M%OS",
                    "%H:%M:%OS",
                    "%H.%M.%OS",
                    "%H%M",
                    "%H:%M",
                    "%H.%M"),
                  optional = FALSE, 
                  ...)
  
  # 3. Output: 
  return(t)
  
} # time_from_string end. 

# ## Check:
# # from character:
# time_from_string(c("2020-01-01 10:30:45", "2020-06-30 22:30:50"))
# time_from_string(c("2020/01/01 10.30.45", "2020/06/30 22.30.50"))
# time_from_string(c("20-01-01 10:30", "20-06-30 22:30"))
# 
# # # from numeric:
# time_from_string(201005103045)  # date-time
# time_from_string(201005)        # date
# time_from_string(1030)          # time (today)
#
# # with format:
# time_from_string(c("6|8|10 10<30<45"), format = "%m|%d|%y %H<%M<%S")
# time_from_string(c("June 8, 2010, 10-30"), format = "%B %d, %Y, %H-%M")
# 
# # with tz: 
# time_from_string(c("20-01-01 10:30:45", "20-06-30 22:30:50"), tz = "NZ")


# time_from_noPOSIXt: Parse non-time into "POSIXt" object(s): ------ 

time_from_noPOSIXt <- function(x, tz = "", ...){
  
  # 0. Initialize: 
  t <- NA
  
  # 1. Prepare: ---- 
  
  if (is_POSIXt(x)){ return(x) }  # fast exit
  
  # Coerce numeric x that are NOT date-time objects into character strings:
  if (!is_date_time(x) & is.numeric(x)){
    
    # message('time_from_noPOSIXt: Coercing x from "number" into "character".')    
    x <- as.character(x)
    
  }
  
  # 2. Main: Coerce non-time objects into "POSIXct" objects: ---- 
  
  # A. Aim to coerce character string inputs x into "POSIXct": 
  if (is.character(x)){
    
    # message('time_from_noPOSIXt: Aiming to parse x from "character" as "POSIXct".')   
    t <- time_from_string(x, tz = tz, ...)  # Note: tz = "" by default. 
    
  }
  
  # B. Coerce "Date" inputs into "POSIXct" objects:
  if (is_Date(x)){
    
    # message('time_from_noPOSIXt: Coercing x from "Date" into "POSIXct".')      
    t <- as.POSIXct(x, tz = tz, ...)  # Note: tz = "" by default. 
    
  }
  
  # 3. Verify "POSIXct": ---- 
  if (!is_POSIXct(t)){
    
    message('time_from_noPOSIXt: Failed to parse x as "POSIXct".')
    
  }
  
  # # +. Convert from POSIXct to POSIXlt with tz:  
  # t <- as.POSIXlt(t, tz = tz, ...)  # Note: tz = "" by default. 
  
  # 4. Output: 
  return(t)  
  
} # time_from_noPOSIXt end. 

# ## Check:
# # POSIXt returned as is:
# is_POSIXct(time_from_noPOSIXt(Sys.time() + 0:2))
# is_POSIXlt(time_from_noPOSIXt(as.POSIXlt(Sys.time() + 0:2))) 
# 
# # from "Date":
# time_from_noPOSIXt(Sys.Date() + seq(0, 720, by = 180))  # note tz changes
# 
# # from character:
# time_from_noPOSIXt(c("2020-01-01 10:30:45", "2020-06-30 22:30:50"))
# time_from_noPOSIXt(c("2020/01/01 10.30.45", "2020/06/30 22.30.50"))
# time_from_noPOSIXt(c("20-01-01 10:30", "20-06-30 22:30"))
# 
# # # from numeric:
# time_from_noPOSIXt(201005103045)  # date-time
# time_from_noPOSIXt(201005)        # date
# time_from_noPOSIXt(1030)          # time (today)
# 
# # with format:
# time_from_noPOSIXt(c("6|8|10 10<30<45"), format = "%m|%d|%y %H<%M<%S")
# time_from_noPOSIXt(c("June 8, 2010, 10-30"), format = "%B %d, %Y, %H-%M")
# 
# # with tz:
# time_from_noPOSIXt(c("20-01-01 10:30:45", "20-06-30 22:30:50"), tz = "NZ")


# +++ here now +++ 


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
  
  if (!is_Date(dt)){ dt <- date_from_noDate(dt, ...) }
  
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
  if (!is_Date(dt)){ dt <- date_from_noDate(dt, ...) }
  
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

# bday_eq_last_month <- function(dt, bday, ...){
#   
#   # (a) Handle inputs:
#   if (!is_Date(dt)){ dt <- date_from_noDate(dt, ...) }
#   
#   if (length(dt) > length(bday)){
#     
#     bday <- rep(bday, length.out = length(dt))  # recycle bday
#     
#   }
#   
#   # (b) Get dt elements:
#   year_nr  <- as.numeric(format(dt, format = "%Y"))
#   month_nr <- as.numeric(format(dt, format = "%m"))
#   
#   # (c) Main processing: 
#   last_month_nr <- (month_nr - 1)          # reduce month_nr by 1
#   
#   # Handle special case: Dec becomes Jan of preceding year: 
#   last_month_nr[last_month_nr == 0] <- 12  # Dec <- Jan!
#   year_nr[last_month_nr == 12] <- (year_nr[last_month_nr == 12] - 1)  # preceding year!
#   
#   # How many days were there last month?
#   max_day_last_month <- days_last_month(dt)
#   
#   day_nr <- rep(NA, length(dt))
#   
#   # Distinguish 2 cases:
#   day_nr[max_day_last_month >= bday] <- bday[max_day_last_month >= bday]  # 1. bday exists in last month; OR 
#   day_nr[max_day_last_month < bday]  <- max_day_last_month[max_day_last_month < bday]  # 2. take max_day_last_month instead.
#   
#   # Construct as date: 
#   bd_last_month <- paste(year_nr, last_month_nr, day_nr, sep = "-")
#   dt_last_month <- as.Date(bd_last_month, format = "%Y-%m-%d")
#   
#   # message(dt_last_month)  # debugging
#   
#   # (d) Output:   
#   return(dt_last_month)
#   
# } # bday_eq_last_month end. 

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
  if (!is_Date(dob)){ dob <- date_from_noDate(dob, ...) }
  if (!is_Date(to_date)){to_date <- date_from_noDate(to_date, ...) }
  
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
  # dt_m[bd_this_month]  <- tod_m[bd_this_month]       # 1.  bd_this_month
  # dt_m[!bd_this_month] <- tod_m[!bd_this_month] - 1  # 2. !bd_this_month
  # Combine cases:
  dt_m <- tod_m - (1 * !bd_this_month)
  
  # Handle special case: Dec becomes Jan of preceding year: 
  dt_m[dt_m == 0]  <- 12  # Dec <- Jan! 
  ix_1 <- (dt_m == 12) & (!bd_this_month) 
  dt_y[ix_1] <- dt_y[ix_1] - 1   # preceding year!
  
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
  ix_2 <- is.na(dt)
  # dob_d[ix]     <- days_last_month(dt = to_date[ix])
  dt_string[ix_2] <- paste(dt_y[ix_2], tod_m[ix_2], "01", sep = "-")
  dt[ix_2] <- as.Date(dt_string[ix_2], format = "%Y-%m-%d") - 1
  
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
# # Birthday on Feb. 29 of leap year: 
# dt_last_monthly_bd("2020-02-29", "2021-03-01")
#
# # Case with errors:
# (bd <- as.Date(fame$DOB[35], format = "%B %d, %Y"))
# (dd <- as.Date(fame$DOD[35], format = "%B %d, %Y"))
# dt_last_monthly_bd(bd, dd)  # seems ok.
# 
# # Special cases:
# dt_last_monthly_bd(dob = "2020-12-31", "2020-01-01")  # dob > to_date
# dt_last_monthly_bd(dob = "2020-03-31", "2020-03-01")  # dob > to_date
# dt_last_monthly_bd(dob = "2020-03-31", "2020-03-31")  # dob = to_date



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
  
  # 1. Check when argument: 
  if (all(is.na(when))){
    
    t <- Sys.time()  # use current time
    
  } else { # interpret when:
    
    t <- as.POSIXct(when, tz = tz)  # Note: tz = "" by default. 
    
  }
  
  # 2. Verify class: 
  if (!is_POSIXt(t)){
    message(paste0('what_time: "t" is not of class "POSIXt".'))
    # return(t)
  }
  
  # 3. Convert into time zone tz:
  if (tz != ""){
    
    message("Converting time(s) into tz.")
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
    when <- date_from_noDate(when)
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

# diff_days: Difference between two dates (in days): ------ 

diff_days <- function(from_date, to_date = Sys.Date(), units = "days", as_Date = TRUE, ...){
  
  # Assume that from_date and to_date are valid dates OR times:   
  # (Otherwise, see diff_dates() function below). 
  
  if (as_Date) { # Convert non-Date (e.g., POSIXt) into "Date" objects:
    
    if (!is_Date(from_date)) { from_date <- date_from_noDate(from_date, ...) }
    
    if (!is_Date(to_date))   { to_date <- date_from_noDate(to_date, ...) }
    
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
#' Characteristics and features:
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
#'   the arguments of \code{to_date} are recycled or 
#'   truncated to the length of \code{from_date}. 
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
#' Default: \code{unit = "y"} for completed years, months, and days. 
#' Options available: 
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
#' as columns of a data frame 
#' and include \code{from_date} and \code{to_date}. 
#' 
#' @return A character vector or a data frame 
#' with dates, sign, and numeric columns for units.
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
#' f_d <- sample_date(10)
#' t_d <- sample_date(10)
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
    from_date <- date_from_noDate(from_date)
  }
  
  if (!is_Date(to_date)){
    # message('diff_dates: Aiming to parse "to_date" as "Date".')
    to_date <- date_from_noDate(to_date)
  }
  
  # (c) Recycle or truncate to_date argument based on from_date: ---- 
  n_from <- length(from_date)
  n_to   <- length(to_date)
  
  if (n_from != n_to){  # arguments differ in length:     
    
    if (n_to > n_from){ # 1. truncate to_date to the length of n_from: 
      
      to_date <- to_date[1:n_from]
      
    } else { # 2. recycle to_date to the length of n_from: 
      
      to_date <- rep(to_date, ceiling(n_from/n_to))[1:n_from]
      
    } # end else. 
  } # end if.
  
  # (d) Replace intermittent NA values in to_date by current date: ---- 
  # Axiom: Dead people do not age any further, but 
  #        if to_date = NA, we want to measure until today: 
  set_to_date_NA_to_NOW <- TRUE  # if FALSE: Occasional to_date = NA values yield NA result.
  
  if (set_to_date_NA_to_NOW){
    
    if (!all(is.na(to_date))){  # only SOME to_date values are missing: 
      
      to_date[is.na(to_date)] <- Sys.Date()  # replace those NA values by Sys.Date()
      
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
  
  
  # (f) If from_date > to_date: Swap dates and negate sign:
  
  from_date_org <- from_date  # store original orders
  to_date_org   <- to_date    # (to list in outputs)
  
  ix_rev <- (from_date > to_date)       # ix of cases to reverse 
  from_date_temp <- from_date[ix_rev]   # temporary storage
  
  from_date[ix_rev] <- to_date[ix_rev]  # from_date by to_date
  to_date[ix_rev]   <- from_date_temp   # to_date by from_date
  
  sign <- rep("", n_from)  # initialize (as character)
  sign[ix_rev] <- "-"      # negate sign (character)
  
  # message(sign)  # debugging
  
  
  # (g) Unit: ----
  unit <- substr(tolower(unit), 1, 1)  # robustness: use abbreviation: y/m/d
  
  if (!unit %in% c("y", "m", "d")){
    message('diff_dates: unit must be "y", "m", or "d". Using "y".')
    unit <- "y"
  }
  
  
  # 2. Main function: ------ 
  
  # (a) initialize:  
  age <- NA
  full_y <- NA
  full_m <- NA
  full_d <- NA
  
  
  # (b) Special case: unit == "d" ---- 
  
  if (unit == "d"){
    
    # Use diff_days() helper/utility function: 
    full_d <- diff_days(from_date = from_date, to_date = to_date)
    
    if (as_character){
      
      age <- paste0(sign, full_d, "d") 
      
    } else { # return as data frame:
      
      age <- data.frame("from_date" = from_date_org,
                        "to_date"   = to_date_org, 
                        "neg" = sign,  # negation sign? 
                        "d" = full_d)
      
    }
    
    return(age)
    
  }
  
  # (c) Other units (y/m): Get date elements ---- 
  
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
  # full_d[bd_tm]  <- to_d[bd_tm]  - bd_d[bd_tm]  # 1:  bd_tm: days since bd_tm
  # full_d[!bd_tm] <- to_d[!bd_tm] - bd_d[!bd_tm] + days_last_month(to_date[!bd_tm])  # 2: !bd_tm
  
  ## Combine cases:
  dlm_to <- days_last_month(to_date)
  # full_d <- to_d - bd_d + (dlm_to * !bd_tm)  # ERROR: See diverging cases below.  
  
  ## Bug FIX: If bday would have been after the maximum day of last month:
  ix_2_fix <- !bd_tm & (bd_d > dlm_to)  # ix of cases to fix:
  # full_d[ix_2_fix] <- to_d[ix_2_fix]    # full_d <- to_d for these cases
  
  ## ALL-in-ONE: 
  full_d <- to_d - bd_d + (dlm_to * !bd_tm) + ((bd_d - dlm_to) * ix_2_fix)
  
  # message(paste(full_d, collapse = " "))  # debugging
  
  
  # s_2: GLOBAL solution: Start from total number of days and 
  #      subtract all days of full years and months already accounted for.   
  #      Use diff_days() helper function to compute exact number of days between two dates:
  #      full_d_2 <- total_days              - accounted_days   
  #                = diff_days(DOB, to_date) - diff_days(DOB, to_date = dt_bday_last_month(to_date))
  
  # Use diff_days() helper/utility function: 
  total_days <- diff_days(from_date = from_date, to_date = to_date)
  
  # Use dt_bday_last_month() helper/utility function: 
  dt_bday_last_month <- dt_last_monthly_bd(dob = from_date, to_date = to_date)
  accounted_days <- diff_days(from_date = from_date, to_date = dt_bday_last_month)
  
  full_d_2 <- total_days - accounted_days
  
  # message(paste(full_d_2, collapse = " "))  # debugging
  
  
  # s+3: Verify equality of both solutions: 
  if (!all(full_d == full_d_2)){
    
    warning('diff_dates: 2 solutions for full_d yield different results.')
    
    ix_diff <- full_d != full_d_2  # Diagnostic info for debugging: 
    
    message(paste(which(ix_diff),     collapse = " "))
    message(paste(from_date[ix_diff], collapse = " "))    
    message(paste(to_date[ix_diff],   collapse = " "))
    message(paste("y:", full_y[ix_diff], collapse = " "))    
    message(paste("m:", full_m[ix_diff], collapse = " "))    
    message(paste("d 1:", full_d[ix_diff],   collapse = " "))    
    message(paste("d_2:", full_d_2[ix_diff], collapse = " "))
    
  }
  
  
  # 3. Output: ------ 
  
  if (as_character){
    
    if (unit == "y"){
      
      age <- paste0(sign, full_y, "y ", full_m, "m ", full_d, "d")
      
    } else if (unit == "m"){
      
      age <- paste0(sign, full_m, "m ", full_d, "d")
      
    }
    
  } else { # return as data frame:
    
    if (unit == "y"){
      
      age <- data.frame("from_date" = from_date_org,
                        "to_date"   = to_date_org, 
                        "neg" = sign,  # negation sign? 
                        "y" = full_y, 
                        "m" = full_m, 
                        "d" = full_d)
      
    } else if (unit == "m"){
      
      age <- data.frame("from_date" = from_date_org,
                        "to_date"   = to_date_org, 
                        "neg" = sign,  # negation sign? 
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


## Check consistency (of 2 solutions):

## Test with random date samples:
# from <- sample_date(100)
# to   <- sample_date(100)
# diff_dates(from, to, as_character = TRUE)
# 
# # +++ here now +++
# 
# # Check possibly diverging cases:
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

# ad (0):
# - consider making date and time parser functions (date_from_noDate/time_from_noPOSIX) available to users by export.   
# - consider creating corresponding time parser function time_from_noPOSIXt(). 
# - consider making test functions is_Date / is_POSIXt available to users by export. 
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