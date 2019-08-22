## time_fun.R | ds4psy
## hn | uni.kn | 2019 08 21
## ---------------------------

## Functions for date and time objects. 

# Note: The R base function 
# date()  # returns date as "Wed Aug 21 19:43:22 2019", 
# which is more than we usually want.

# Some simpler variants: 



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
  
  t <- Sys.time()
  
  if (seconds) {
    
    fmt <- paste("%H", "%M", "%S", sep = sep, collapse = "") 
    
  } else {
    
    fmt <- paste("%H", "%M", sep = sep, collapse = "") 
    
  }
  
  format(t, fmt)   
  
}

## Check:
# cur_time()
# cur_time(seconds = TRUE)
# cur_time(sep = ".")

# 3. cur_date: A relaxed version of Sys.time() ------ 

# `%F`: Date equivalent to `%Y-%m-%d` (ISO 8601 date format) 

#' Current date (in yyyy-mm-dd format). 
#'
#' \code{cur_date} provides a relaxed version of 
#' \code{Sys.time()} that is sufficient for most purposes. 
#' 
#' \code{cur_date} returns \code{Sys.time()} 
#' (in "%Y-%m-%d" or "%d-%m-%Y" format) 
#' using current system settings.
#'  
#' By default, this corresponds to the "%Y-%m-%d" or "%F"    
#' format used as the ISO 8601 standard. 
#' 
#' For additional options, see the 
#' \code{date()} and \code{Sys.Date()} functions of \strong{base} R 
#' and various formatting options for \code{Sys.time()}. 
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
  
  t <- Sys.time()
  
  if (rev){
    
    fmt <- paste("%d", "%m", "%Y", sep = sep, collapse = "") 
    
  } else {
    
    fmt <- paste("%Y", "%m", "%d", sep = sep, collapse = "")    
    
  }
  
  format(t, fmt)   
  
}  # cur_date end. 

# ## Check:
# cur_date()
# cur_date(sep = "/")
# cur_date(rev = TRUE)
# cur_date(rev = TRUE, sep = ".")


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

## eof. ----------------------