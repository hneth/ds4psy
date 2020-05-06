## util_fun.R | ds4psy
## hn | uni.kn | 2020 05 06
## ---------------------------

## Utility functions. 

# vrep: A vectorized version of rep: ------

vrep <- Vectorize(rep.int, "times")

## Check:
# vrep(x = 1,   times = 1:3)
# vrep(x = "a", times = 2:4)
## => works, but returns a list.

# num_as_char: Print a number (as character), with n_pre_dec digits prior to decimal sep, and rounded to n_dec digits: ------

#' Convert a number into a character sequence. 
#'
#' \code{num_as_char} converts a number into a character sequence 
#' (of a specific length). 
#' 
#' The arguments \code{n_pre_dec} and \code{n_dec} set a number of desired digits 
#' before and after the decimal separator \code{sep}. 
#' \code{num_as_char} tries to meet these digit numbers by adding zeros to the front 
#' and end of \code{x}. 
#' 
#' \strong{Caveat:} Note that this function illustrates how numbers, 
#' characters, \code{for} loops, and \code{paste()} can be combined 
#' when writing functions. It is not written efficiently or well. 
#' 
#' @param x Number(s) to convert (required, accepts numeric vectors).
#'
#' @param n_pre_dec Number of digits before the decimal separator. 
#' Default: \code{n_pre_dec = 2}. 
#' This value is used to add zeros to the front of numbers. 
#' If the number of meaningful digits prior to decimal separator is greater than 
#' \code{n_pre_dec}, this value is ignored. 
#' 
#' @param n_dec Number of digits after the decimal separator. 
#' Default: \code{n_dec = 2}. 
#' 
#' @param sym Symbol to add to front or back. 
#' Default: \code{sym = 0}. 
#' Using \code{sym = " "} or \code{sym = "_"} can make sense, 
#' digits other than \code{"0"} do not. 
#'
#' @param sep Decimal separator to use.  
#' Default: \code{sep = "."}. 
#'
#' @examples
#' num_as_char(1)
#' num_as_char(10/3)
#' num_as_char(1000/6) 
#' 
#' # rounding down:
#' num_as_char((1.3333), n_pre_dec = 0, n_dec = 0)
#' num_as_char((1.3333), n_pre_dec = 2, n_dec = 0)
#' num_as_char((1.3333), n_pre_dec = 2, n_dec = 1)
#' 
#' # rounding up: 
#' num_as_char(1.6666, n_pre_dec = 1, n_dec = 0)
#' num_as_char(1.6666, n_pre_dec = 1, n_dec = 1)
#' num_as_char(1.6666, n_pre_dec = 2, n_dec = 2)
#' num_as_char(1.6666, n_pre_dec = 2, n_dec = 3)
#' 
#' # Note: If n_pre_dec is too small, actual number is used:
#' num_as_char(11.33, n_pre_dec = 0, n_dec = 1)
#' num_as_char(11.66, n_pre_dec = 1, n_dec = 1)
#' 
#' # Details:
#' num_as_char(1, sep = ",")
#' num_as_char(2, sym = " ")
#' num_as_char(3, sym = " ", n_dec = 0)
#' 
#' # Beware of bad inputs:
#' num_as_char(4, sym = "8")
#' num_as_char(5, sym = "99")
#' 
#' # Works for vectors:
#' num_as_char(1:10/1, n_pre_dec = 1, n_dec = 1)
#' num_as_char(1:10/3, n_pre_dec = 2, n_dec = 2)
#' 
#' 
#' @family utility functions
#'
#' @export 

num_as_char <- function(x, n_pre_dec = 2, n_dec = 2, sym = "0", sep = "."){
  
  # (-) Check inputs:
  if ((!is.na(as.numeric(sym))) && (as.numeric(sym) != 0)) {  # x is numeric, but not 0: 
    message("Setting sym to numeric digits (other than '0') is confusing.")
  }
  if (nchar(sym) > 1) {  # sym contains multiple characters: 
    message("Setting sym to more than 1 character is confusing.")
  }
  
  # (0) round x: 
  x_rounded <- round(x, n_dec)
  
  # Split x_rounded into 2 parts:
  
  # (1) Part BEFORE the decimal point:
  n_num_1 <- x_rounded %/% 1 
  
  n_char_1 <- as.character(n_num_1)  # as character
  
  n_char_1_len <- nchar(n_char_1)              # length of character seq. 
  n_sym_1_add <- (n_pre_dec - n_char_1_len)    # diff. determines missing sym 
  sym_1_add   <- rep("", length(n_sym_1_add))  # initialize for loop
  
  for (i in seq_along(n_sym_1_add)){  # for loop: 
    
    n_1_add <- n_sym_1_add[i]  # n of sym to add
    
    if (n_1_add > 0){
      sym_1_add[i] <- paste0(rep(sym, times = n_1_add), collapse = "")  # add sym!
    }  # else: do not change sym_1_add.
    
  }
  
  n_char_1_final <- paste0(sym_1_add, n_char_1)  # intermediate result 1 
  
  # (2) Part AFTER the decimal point:
  n_num_2 <- x_rounded %% 1
  
  # round to n_dec digits (again?):
  n_num_2 <- round(n_num_2, digits = n_dec)  # round to significant digits (again!) 
  
  n_char_2 <- as.character(n_num_2)  # as character
  
  n_char_2 <- substr(n_char_2, 3, nchar(n_char_2))  # remove "0." at beginning!
  
  n_char_2_len <- nchar(n_char_2)              # length of character seq.
  n_sym_2_add <- (n_dec - n_char_2_len)        # diff. determines missing sym 
  sym_2_add   <- rep("", length(n_sym_2_add))  # initialize for loop
  
  for (i in seq_along(n_sym_2_add)){  # for loop: 
    
    n_2_add <- n_sym_2_add[i]  # n of sym to add
    
    if (n_2_add > 0){
      sym_2_add[i] <- paste0(rep(sym, times = n_2_add), collapse = "")  # add sym!
    }  # else: do not change sym_2_add.
    
  }
  
  n_char_2_final <- paste0(n_char_2, sym_2_add) # intermediate result 2 
  
  # (3) paste 2 parts together again:
  if (n_dec > 0) {
    out <- paste(n_char_1_final, n_char_2_final, sep = sep)
  } else {
    out <- n_char_1_final  # use only 1st part (and no decimal separator)
  }
  
  # (+) return:
  return(out)
  
}  # num_as_char end. 

# # Check:
# num_as_char(1)
# num_as_char(10/3)
# 
# num_as_char((1.3333), n_pre_dec = 2, n_dec = 0)
# num_as_char((1.3333), n_pre_dec = 2, n_dec = 3)
# 
# num_as_char((1.6666), n_pre_dec = 2, n_dec = 0)
# num_as_char((1.6666), n_pre_dec = 2, n_dec = 1)
# num_as_char((1.6666), n_pre_dec = 2, n_dec = 2)
# num_as_char((1.6666), n_pre_dec = 2, n_dec = 3)
# 
# # Note: If n_pre_dec too small, actual number is used:
# num_as_char((1111.3333), n_pre_dec = 0, n_dec = 2)
# num_as_char((1111.6666), n_pre_dec = 0, n_dec = 2)
# 
# # Details:
# num_as_char(1, sep = ",")
# num_as_char(2, sym = " ")
# num_as_char(3, sym = " ", n_dec = 0)
# 
# # Beware of:
# num_as_char(4, sym = "8")
# num_as_char(5, sym = "ab")
# num_as_char(6, sym = "12")
#
# # Works for vectors:
# num_as_char(1:10/1, n_pre_dec = 1, n_dec = 1)
# num_as_char(1:10/3, n_pre_dec = 2, n_dec = 2)


# num_as_ordinal: Convert a (cardinal) number into an ordinal string: ------

#' Convert a number into an ordinal character sequence. 
#'
#' \code{num_as_ordinal} converts a given (cardinal) number 
#' into an ordinal character sequence. 
#' 
#' The function currently only works for the English language and 
#' does not accepts inputs that are characters, dates, or times.  
#' 
#' Note that the \code{toOrdinal()} function of the \strong{toOrdinal} package works 
#' for multiple languages and provides a \code{toOrdinalDate()} function. 
#' 
#' \strong{Caveat:} Note that this function illustrates how numbers, 
#' characters, \code{for} loops, and \code{paste()} can be combined 
#' when writing functions. It is not written efficiently or well. 
#' 
#' @param x Number(s) to convert (required, accepts numeric vectors).
#'
#' @param sep Decimal separator to use.  
#' Default: \code{sep = ""} (i.e., no separator). 
#'
#' @examples
#' num_as_ordinal(1:4)
#' num_as_ordinal(10:14)    # all with "th"
#' num_as_ordinal(110:114)  # all with "th"
#' num_as_ordinal(120:124)  # 4 different suffixes
#' num_as_ordinal(1:15, sep = "-")  # using sep
#' 
#' # Note special cases:
#' num_as_ordinal(NA)
#' num_as_ordinal("1")
#' num_as_ordinal(Sys.Date())
#' num_as_ordinal(Sys.time())
#' num_as_ordinal(seq(1.99, 2.14, by = .01))
#' 
#' 
#' @family utility functions
#'
#' @seealso 
#' \code{toOrdinal()} function of the \strong{toOrdinal} package.  
#'
#' @export 

num_as_ordinal <- function(x, sep = ""){
  
  # (-) Check inputs:
  if ( (length(x) == 1) && (is.na(x)) ) {
    message("x is required. Using x = 0:15:")
    x <- 0:15
  }
  
  if ( is.character(x) ) {  # x is not numeric: 
    message("x must be numeric, not character.")
    return(x)
  }
  
  if ( !is.numeric(x) ){
    message("x must be numeric.")
    return(x)
  }
  
  if ( (any(x %% 1 != 0)) ) {  # x is no integer: 
    message("x should be an integer, but let's try...")
  }
  
  # (1) Turn x into character(s):
  x_c <- as.character(x)
  nchar <- nchar(x_c)
  f_c <- substr(x_c, start = nchar, stop = nchar)        # final character
  f2c <- substr(x_c, start = (nchar - 1), stop = nchar)  # final 2 characters
  
  # (2) Initialize all suffixes to default:
  sfx <- rep("th", length(x))  
  
  # (3) Consider each x for suffix changes:
  for (i in seq_along(x)){
    
    # Test conditions for 3 special suffixes:
    if ( (f_c[i] == "1") && (f2c[i] != "11") ) { sfx[i] <- "st" }
    if ( (f_c[i] == "2") && (f2c[i] != "12") ) { sfx[i] <- "nd" }
    if ( (f_c[i] == "3") && (f2c[i] != "13") ) { sfx[i] <- "rd" }
    
  } # for loop end. 
  
  # (4) Return combination:
  paste0(x_c, sep, sfx)
  
}  # num_as_ordinal end.

## Checks:
# num_as_ordinal(1:15)
# num_as_ordinal(110:114)  # all with "th"
# num_as_ordinal(120:124)  # 4 different suffixes
# num_as_ordinal(1:15, sep = "-")  # using sep
# 
# # Note special cases:
# num_as_ordinal(NA)
# num_as_ordinal("1")
# num_as_ordinal(Sys.Date())
# num_as_ordinal(Sys.time())
# num_as_ordinal(seq(0, 2.5, by = .1))
# num_as_ordinal(seq(1.99, 2.15, by = .01))


# is.wholenumber: Testing for integer values (which is.integer does not) ------ 

# Note that is.integer() tests for objects of TYPE "integer", not integer values. 
# Source: R help on is.integer(). 

#' Test for whole numbers (i.e., integers). 
#'
#' \code{is.wholenumber} tests if \code{x} contains integer numbers.
#' 
#' \code{is.wholenumber} does what the \strong{base} R function \code{is.integer} is not designed to do: 
#' 
#' \itemize{ 
#' \item \code{is.wholenumber} returns TRUE or FALSE depending on whether its numeric argument \code{x} is an integer value (i.e., a whole number). 
#' 
#' \item \code{is.integer} returns TRUE or FALSE depending on whether its argument is of integer type, unless it is a factor when it returns FALSE.  
#' }
#' 
#' See the documentation of \code{\link{is.integer}} for definition and details.
#' 
#' @param x Number(s) to test (required, accepts numeric vectors).
#'
#' @param tol Numeric tolerance value.  
#' Default: \code{tol = .Machine$double.eps^0.5} (see \code{?.Machine} for details). 
#'
#' @examples
#' is.wholenumber(1)    # is TRUE
#' is.wholenumber(1/2)  # is FALSE
#' x <- seq(1, 2, by = 0.5)
#' is.wholenumber(x)
#' 
#' @family utility functions
#'
#' @seealso 
#' \code{\link{is.integer}} function of the R \strong{base} package.  
#'
#' @export 

is.wholenumber <- function(x, tol = .Machine$double.eps^0.5) {
  abs(x - round(x)) < tol
}

## Check: 
# is.wholenumber(1)    # is TRUE
# is.wholenumber(1/2)  # is FALSE
# x <- seq(1, 2, by = 0.5)
# is.wholenumber(x)




# kill_all: Kill all objects in current environment (without warning): ------

kill_all <- function(){
  
  rm(list = ls())
  
}  # kill_all end. 

## Check: 
# kill_all()


## ToDo: ----------

# - ... 

## eof. ----------------------