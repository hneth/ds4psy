## time_util_fun.R | ds4psy
## hn | uni.kn | 2020 07 24
## ---------------------------

## Utility functions for date and time objects. 

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

date_from_string <- function(x, tz = "", ...){
  
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
  dt <- as.Date(x, tz = tz, tryFormats = date_frms, ...)
  
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
# date_from_string(Sys.time())  # times are returned as dates
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
# # but providing formats works (adding default year):
# date_from_string("12.8", format = "%d.%m")
# date_from_string("12.8", format = "%m.%d")
# 
# date_from_string(c("12-8-2010", "12-Aug-10"))  # mix of formats
# date_from_string(c("2010-8-12", "12-8-2010"))  # mix of orders


# date_from_noDate: Parse non-Date into "Date" object(s): ------ 

date_from_noDate <- function(x, tz = "", ...){
  
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
    dt <- date_from_string(x, tz = tz, ...)
  }
  
  # B. Coerce "POSIXt" inputs into "Date":
  if (is_POSIXt(x)){
    # message('date_from_noDate: Coercing x from "POSIXt" into "Date".')
    dt <- as.Date(x, tz = tz, ...) 
  }
  
  # 3. Verify "Date": ---- 
  if (!is_Date(dt)){
    
    message('date_from_noDate: Failed to parse x as "Date".')
    
  }
  
  # 4. Output: 
  return(dt)
  
} # date_from_noDate end. 

# ## Check:
# date_from_noDate(20100612)    # number
# date_from_noDate("20100612")  # string
# 
# # Note effect of time zones:
# # (a) calendar times (POSIXct):
# date_from_noDate(as.POSIXct("2020-01-01 08:00:00", tz = "NZ"))             # is interpreted as
# date_from_noDate(as.POSIXct("2020-01-01 08:00:00", tz = "NZ"), tz = "")    # NZ time in current time zone!
# date_from_noDate(as.POSIXct("2020-01-01 08:00:00", tz = "NZ"), tz = "NZ")  # NZ time in NZ time zone.
# # (b) local times (POSIXlt): 
# date_from_noDate(as.POSIXlt("2020-01-01 08:00:00", tz = "NZ"))
# 
# # Former problem/error now resolved:
# date_from_noDate(as.POSIXct("2020-07-01 01:29:06"))          # was "2020-06-30" - WHY???
# date_from_noDate(as.POSIXct("2020-07-01 01:29:06"), tz = "") # now "2020-07-01"
# Solution: Add default argument tz = "".
 
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



## (C) Temporal idiosyncracies: ------ 

# diff_tz: Difference between 2 time zones (in "HH:MM" format or as nr. of minutes): ------

#' Get the time zone difference between two times. 
#'
#' \code{diff_tz} computes the time difference 
#' between two times \code{t1} and \code{t2} 
#' that is exclusively due to both times being in 
#' different time zones. 
#' 
#' \code{diff_tz} ignores all differences in nominal times, 
#' but allows adjusting time-based computations 
#' for time shifts that are due to time zone differences 
#' (e.g., different locations, or 
#' changes to/from daylight saving time, DSL),  
#' rather than differences in actual times. 
#' 
#' Internally, \code{diff_tz} determines and contrasts the POSIX 
#' conversion specifications "%Z" and "%z" for both times 
#' (in numeric form). 
#' 
#' If the lengths of \code{t1} and \code{t2} differ, 
#' the arguments of \code{t2} are recycled or 
#' truncated to the length of \code{t1}. 
#' 
#' @param t1 1st time point (required, as "POSIXt").
#'  
#' @param t2 2nd time point (required, as "POSIXt"). 
#' 
#' @param in_min Return time-zone based time 
#' difference in minutes (Boolean)? 
#' Default: \code{in_min = FALSE}. 
#' 
#' @return A character (in "HH:MM" format) or 
#' numeric vector (number of minutes). 
#' 
#' @examples 
#' # Time zones differences:
#' tm <- "2020-01-01 01:00:00"  # nominal time
#' t1 <- as.POSIXct(tm, tz = "NZ")
#' t2 <- as.POSIXct(tm, tz = "Europe/Berlin")
#' t3 <- as.POSIXct(tm, tz = "US/Hawaii")
#' 
#' # as character (in "HH:MM"):
#' diff_tz(t1, t2)
#' diff_tz(t2, t3)
#' diff_tz(t1, t3)
#' 
#' # as numeric (in minutes):
#' diff_tz(t1, t3, in_min = TRUE)
#' 
#' # Compare local times (POSIXlt): 
#' t4 <- as.POSIXlt(Sys.time(), tz = "NZ")
#' t5 <- as.POSIXlt(Sys.time(), tz = "Europe/Berlin")
#' diff_tz(t4, t5)
#' diff_tz(t4, t5, in_min = TRUE)
#' 
#' # DSL shift: Spring ahead (on 2020-03-29: 02:00:00 > 03:00:00):
#' s6 <- "2020-03-29 01:00:00 CET"   # before DSL switch
#' s7 <- "2020-03-29 03:00:00 CEST"  # after DSL switch
#' t6 <- as.POSIXct(s6, tz = "Europe/Berlin")  # CET
#' t7 <- as.POSIXct(s7, tz = "Europe/Berlin")  # CEST
#' 
#' diff_tz(t6, t7)  # 1 hour forwards
#' diff_tz(t6, t7, in_min = TRUE)
#' 
#' @family date and time functions
#' 
#' @seealso 
#' \code{\link{days_in_month}} for the number of days in given months; 
#' \code{\link{is_leap_year}} to check for leap years.  
#' 
#' @export

diff_tz <- function(t1, t2, in_min = FALSE){
  
  # 0. Initialize: 
  n <- length(t1)
  hm_diff <- rep(NA, n) 
  hr_diff <- rep(NA, n)
  mi_diff <- rep(NA, n)
  
  # 1. Handle inputs: ---- 
  if (!is_POSIXct(t1)){
    t1 <- time_from_noPOSIXt(t1)
  }
  
  if (!is_POSIXct(t2)){
    t2 <- time_from_noPOSIXt(t2)
  }
  
  # Recycle or truncate t2 argument based on t1: ---- 
  t2 <- align_vector_length(v_fixed = t1, v_change = t2)
  message(paste0("t2 = ", t2, collapse = " "))  # debugging 
  
  
  # 2. Main: ---- 
  
  # Query t1 and t2:
  tz_1 <- format(t1, "%Z")  # time zone label
  tz_2 <- format(t2, "%Z")  
  
  td_1 <- format(t1, "%z")  # difference from UTC 
  td_2 <- format(t2, "%z")  
  
  
  # Compute difference for different tz:
  
  # # (a) If tz differ: 
  # if ((tz_1 != tz_2) | (td_1 != td_2)){
  #   
  #   # message("Time zones differ. Computing difference t2 - t1:")
  #   
  #   hr_diff <- num_as_char(as.numeric(substr(td_2, 1, 3)) - as.numeric(substr(td_1, 1, 3)), n_pre_dec = 2, n_dec = 0)
  #   mi_diff <- num_as_char(as.numeric(substr(td_2, 4, 5)) - as.numeric(substr(td_1, 4, 5)), n_pre_dec = 2, n_dec = 0)
  #     
  # }
  
  # (b) Vectorized solution:
  ix_diff <- ((tz_1 != tz_2) | (td_1 != td_2))  # identify cases with tz differences
  
  hr_diff[ix_diff] <- as.numeric(substr(td_2[ix_diff], 1, 3)) - as.numeric(substr(td_1[ix_diff], 1, 3))
  mi_diff[ix_diff] <- as.numeric(substr(td_2[ix_diff], 4, 5)) - as.numeric(substr(td_1[ix_diff], 4, 5))
  
  hr_diff[!ix_diff] <- 0 
  mi_diff[!ix_diff] <- 0 
  
  
  # 3. Prepare output: ---- 
  if (in_min){
    
    hm_diff <- (hr_diff * 60) + mi_diff
    
    
  } else {  # return as character (in HH:MM format):
   
    hr_diff <- num_as_char(hr_diff, n_pre_dec = 2, n_dec = 0)
    mi_diff <- num_as_char(mi_diff, n_pre_dec = 2, n_dec = 0)    
     
    hm_diff <- paste0(hr_diff, ":", mi_diff)
  
  }
  
  # 4. Output: 
  return(hm_diff)
  
} # diff_tz end. 


# ## Check:
#  
# ## 1. Time zones differences:
# tm <- "2020-01-01 01:00:00"  # nominal time
# t1 <- as.POSIXct(tm, tz = "NZ")
# t2 <- as.POSIXct(tm, tz = "Europe/Berlin")
# t3 <- as.POSIXct(tm, tz = "US/Hawaii")
# 
# # as character (in "HH:MM"):
# diff_tz(t1, t2)
# diff_tz(t2, t3)
# diff_tz(t1, t3)
# 
# # as numeric (in minutes):
# diff_tz(t1, t2, in_min = TRUE)
# diff_tz(t2, t3, in_min = TRUE)
# diff_tz(t1, t3, in_min = TRUE)
# 
# ## 2. Compare local times (POSIXlt): 
# t1 <- as.POSIXlt(Sys.time(), tz = "NZ")
# t2 <- as.POSIXlt(Sys.time(), tz = "Europe/Berlin")
# diff_tz(t1, t2)
# 
# ## 3. DSL shift: Spring ahead (on 2020-03-29: 02:00:00 > 03:00:00):
# s1 <- "2020-03-29 01:00:00 CET"   # before DSL switch
# s2 <- "2020-03-29 03:00:00 CEST"  # after DSL switch
# t1 <- as.POSIXct(s1, tz = "Europe/Berlin")  # CET
# t2 <- as.POSIXct(s2, tz = "Europe/Berlin")  # CEST
# # format(t1, "%F %T %Z %z")
# # format(t2, "%F %T %Z %z")
# 
# diff_tz(t1, t2)
# diff_tz(t1, t2, in_min = TRUE)
# 
# # (b) Fall back (on 2020-10-25: 03:00:00 > 02:00:00): 
# s3 <- "2020-10-25 01:00:00 CEST"  # before DSL switch
# s4 <- "2020-10-25 03:00:00 CET"   # after DSL switch 
# t3 <- as.POSIXct(s3, tz = "Europe/Berlin")  # CEST
# t4 <- as.POSIXct(s4, tz = "Europe/Berlin")  # CET
# # format(t3, "%F %T %Z %z")
# # format(t4, "%F %T %Z %z")
# 
# diff_tz(t3, t4)
# diff_tz(t3, t4, in_min = TRUE)
# 
# # No differences:
# diff_tz(t1, t4)  # both CET
# diff_tz(t2, t3)  # both CEST
# diff_tz(t1, t4, in_min = TRUE)
# diff_tz(t2, t3, in_min = TRUE)
# 
# ## 4. With vectors:
# t1 <- as.POSIXct("2020-01-01 01:00:00", tz = "Europe/Berlin")
# t2 <- as.POSIXct("2020-06-01 02:22:22", tz = "NZ")
# t3 <- as.POSIXct("2020-01-01 05:55:55", tz = "")
# 
# c(t1, t2, t3)  # Note: CET vs. CEST, NZ is dropped! 
# diff_tz(c(t1, t2, t3), t3)  # Note: only tz/DSL matters
# diff_tz(c(t1, t2, t3), t3, in_min = TRUE)


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
#' @return Boolean vector. 
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
#' \code{\link{days_in_month}} for the number of days in given months; 
#' \code{\link{diff_tz}} for time zone-based time differences; 
#' \code{leap_year} function of the \strong{lubridate} package. 
#' 
#' @source 
#' See \url{https://en.wikipedia.org/wiki/Leap_year} for definition. 
#' 
#' @export

is_leap_year <- function(dt){
  
  # 0. Initialize: 
  y <- NA
  out <- NA
  alt <- NA
  
  # 1. Handle input: Determine y (as integer): ---- 
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
    
    message('is_leap_year: Some year values are NA.')  # notify user
    
  }
  
  # 2. Main: ---- 
  # A. Using definition from <https://en.wikipedia.org/wiki/Leap_year>:
  out <- (y %% 4 == 0) & ((y %% 100 != 0) | (y %% 400 == 0))
  # print(out)  # debugging
  
  # # B. Try defining Feb-29 as "Date" (NA if non-existent):
  # ToDo: Remove NAs and do the following only for non-NA entries:
  # feb_29 <- paste(y, "02", "29", sep = "-")
  # alt  <- !is.na(as.Date(feb_29, format = "%Y-%m-%d"))  # ERROR: y = NA and FALSE both become TRUE
  # # print(alt)  # debugging
  
  # if (!all.equal(out, alt)){  # Warn of discrepancy: 
  #   warning("is_leap_year: Two solutions yield different results. Using 1st.")
  # }
  
  # 3. Output: 
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
# is_leap_year("2021-02-29")


# MONTH_DAYS: Define a CONSTANT for days in TYPICAL month (no leap year): ------  

MONTH_DAYS <- c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31) 

# sum(MONTH_DAYS)  # 365 (no leap year)
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
#' \code{\link{is_leap_year}} to check for leap years; 
#' \code{\link{diff_tz}} for time zone-based time differences; 
#' \code{days_in_month} function of the \strong{lubridate} package.   
#' 
#' @export

days_in_month <- function(dt = Sys.Date(), ...){
  
  # 0. Initialize:
  nr_days <- NA  
  
  # 1. Handle inputs:
  if (!is_Date(dt)){ dt <- date_from_noDate(dt, ...) }
  
  # 2. Main: Look up days, accounting for leap years ---- 
  month_nr <- as.numeric(format(dt, format = "%m"))
  # message(paste(month_nr, collapse = " "))
  
  nr_days <- MONTH_DAYS[month_nr]  # look up days in constant 
  # message(paste(nr_days, collapse = " "))
  
  # Special case: Feb. of leap year has 29 days: 
  nr_days[(month_nr == 2) & (is_leap_year(dt))] <- 29 
  
  # 3. Output: 
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
  
  nr <- NA  # initialize 
  
  # 1. Handle inputs:   
  if (!is_Date(dt)){ dt <- date_from_noDate(dt, ...) }
  
  # 2. Get dt elements: 
  year_nr  <- as.numeric(format(dt, format = "%Y"))
  month_nr <- as.numeric(format(dt, format = "%m"))
  
  # 3. Main processing: ----  
  last_month_nr <- (month_nr - 1)          # reduce month_nr by 1
  
  # Handle special case: Dec becomes Jan of preceding year: 
  last_month_nr[last_month_nr == 0] <- 12  # Dec <- Jan
  year_nr[last_month_nr == 12] <- (year_nr[last_month_nr == 12] - 1)  # preceding year!
  
  # Express as valid date:
  # Heuristic: A 15. day exists for all months, but cannot be mistaken for month_nr: 
  mid_last_month <- paste(year_nr, last_month_nr, "15", sep = "-")
  dt_last_month <- as.Date(mid_last_month, format = "%Y-%m-%d")
  
  # message(paste(dt_last_month, collapse = " "))  # debugging
  
  # Get days_in_month() for dates of dt_last_month: 
  nr <- days_in_month(dt_last_month) 
  
  # 4. Output:  
  return(nr)
  
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
# bday_eq_last_month(ds, bday = 20)
# bday_eq_last_month(ds, bday = 29)
# bday_eq_last_month(ds, bday = 30)
# bday_eq_last_month(ds, bday = 31)


# dt_last_monthly_bd: Get the date of last full-month bday: ------ 

# Question: On which day of last/previous month would one's monthly bday fall?
# Problem: Some days (e.g., 29, 30, 31) do not exist in last month.
# Solution: Use the last/final day of previous month in those cases. 

dt_last_monthly_bd <- function(dob, to_date, ...){
  
  # (a) Handle inputs: ---- 
  if (!is_Date(dob)){ dob <- date_from_noDate(dob, ...) }
  
  if (!is_Date(to_date)){
    # message(paste0("1. to_date = ", to_date))  # debugging 
    to_date <- date_from_noDate(to_date, ...)
    # message(paste0("2. to_date = ", to_date))  # debugging 
  }

  # Recycle or truncate to_date argument based on dob: 
  to_date <- align_vector_length(v_fixed = dob, v_change = to_date)
  
  # (b) Get dt elements:
  dob_y <- as.numeric(format(dob, format = "%Y"))
  dob_m <- as.numeric(format(dob, format = "%m"))
  dob_d <- as.numeric(format(dob, format = "%d"))
  
  tod_y <- as.numeric(format(to_date, format = "%Y"))
  tod_m <- as.numeric(format(to_date, format = "%m"))
  tod_d <- as.numeric(format(to_date, format = "%d"))
  
  # (c) Main processing: ---- 
  bd_this_month <- tod_d >= dob_d  # flag
  
  dt_y <- tod_y
  dt_m <- rep(NA, length(dob))
  
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
# 
# # Former problem/error now resolved:
# t1 <- "2020-05-31 05:41:27"
# t2 <- "2020-07-01 01:29:06"
# dt_last_monthly_bd(t1, t2)  # now: "2020-06-30"
# dt_last_monthly_bd(t1, t2, tz = "")  # now: "2020-06-30"


## Done: ----------

# - Moved time utility/helper functions into separate file.

## ToDo: ----------

# ad (0):
# - consider making class test functions is_Date / is_POSIXt available to users by export. 
# - consider making date and time parser functions (date_from_noDate/time_from_noPOSIX) available to users by export. 

## eof. ----------------------