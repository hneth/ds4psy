## num_util_fun.R | ds4psy
## hn | uni.kn | 2023 10 30
## ------------------------

## (0) Utility functions for manipulating/transforming numbers or numeric symbols/digits: ------ 

# Note: Most functions here are classified as belonging to the 
#       family of "numeric" AND "utility" functions. 

## (A) Testing numbers and equality: ------ 


# is_wholenumber: Testing for integer values (which is.integer does not) ------ 

# Note that is.integer() tests for objects of TYPE "integer", not integer values. 
# See help on is.integer(). 

#' Test for whole numbers (i.e., integers) 
#'
#' \code{is_wholenumber} tests if \code{x} contains only integer numbers.
#' 
#' \code{is_wholenumber} does what the \strong{base} R function \code{is.integer} is \strong{not} designed to do: 
#' 
#' \itemize{ 
#'   \item \code{is_wholenumber()} returns TRUE or FALSE depending on whether its numeric argument \code{x} is an integer value (i.e., a "whole" number). 
#' 
#'   \item \code{is.integer()} returns TRUE or FALSE depending on whether its argument is of integer type, and FALSE if its argument is a factor.  
#' }
#' 
#' See the documentation of \code{\link{is.integer}} for definition and details.
#' 
#' @param x Number(s) to test (required, accepts numeric vectors).
#'
#' @param tol Numeric tolerance value.  
#' Default: \code{tol = .Machine$double.eps^0.5} 
#' (see \code{?.Machine} for details). 
#'
#' @examples
#' is_wholenumber(1)    # is TRUE
#' is_wholenumber(1/2)  # is FALSE
#' x <- seq(1, 2, by = 0.5)
#' is_wholenumber(x)
#' 
#' # Compare:
#' is.integer(1+2) 
#' is_wholenumber(1+2) 
#' 
#' @family numeric functions 
#' @family utility functions 
#' 
#' @seealso 
#' \code{\link{is.integer}} function of the R \strong{base} package.  
#'
#' @export 

is_wholenumber <- function(x, tol = .Machine$double.eps^0.5) {
  
  abs(x - round(x)) < tol
  
} # is_wholenumber().

# # Check: 
# is_wholenumber(1)    # is TRUE
# is_wholenumber(1/2)  # is FALSE
# x <- seq(1, 2, by = 0.5)
# is_wholenumber(x)
# 
# # Compare:
# is.integer(1+2)
# is_wholenumber(1+2)


# num_equal: Testing 2 numerical vectors for (near) equality ------ 

# See 
# base::all.equal() and 
# dplyr::near for similar functions.

#' Test two numeric vectors for pairwise (near) equality 
#'
#' \code{num_equal} tests if two numeric vectors \code{x} and \code{y} are pairwise equal 
#' (within a tolerance value `tol`). 
#' 
#' \code{num_equal} verifies that \code{x} and \code{y} are numeric and 
#' then evaluates \code{abs(x - y) < tol}. 
#' Thus, \code{num_equal} provides a safer way to verify the (near) equality of numeric vectors than \code{==}   
#' (due to possible floating point effects). 
#' 
#' @param x 1st numeric vector to compare (required, assumes a numeric vector).
#'
#' @param y 2nd numeric vector to compare (required, assumes a numeric vector).
#'
#' @param tol Numeric tolerance value.  
#' Default: \code{tol = .Machine$double.eps^0.5} 
#' (see \code{?.Machine} for details). 
#'
#' @examples
#' num_equal(2, sqrt(2)^2)
#' 
#' # Recycling: 
#' num_equal(c(2, 3), c(sqrt(2)^2, sqrt(3)^2, 4/2, 9/3))
#' 
#' # Contrast:
#' .1 == .3/3
#' num_equal(.1, .3/3)
#' 
#' # Contrast:
#' v <- c(.9 - .8, .8 - .7, .7 - .6, .6 - .5, 
#'        .5 - .4, .4 - .3, .3 - .2, .2 -.1, .1)
#' unique(v)
#' .1 == v
#' num_equal(.1, v)
#'  
#' @family numeric functions 
#' @family utility functions 
#' 
#' @seealso 
#' \code{\link{is_equal}} function for generic vectors;
#' \code{\link{all.equal}} function of the R \strong{base} package;
#' \code{near} function of the \strong{dplyr} package. 
#'
#' @export 

num_equal <- function(x, y, tol = .Machine$double.eps^0.5){
  
  out <- NA  # initialize
  
  if (!is.numeric(x)) {
    message("num_equal: x must be numeric.")
    return(out)
  }
  
  if (!is.numeric(y)) {
    message("num_equal: y must be numeric.")
    return(out)
  }
  
  out <- abs(x - y) < tol 
  
  return(out)
  
} # num_equal(). 

# ## Check:
# num_equal(2, sqrt(2)^2)
# 
# # Recycling: 
# num_equal(c(2, 3), c(sqrt(2)^2, sqrt(3)^2, 4/2, 9/3))
# 
# # Contrast:
# .1 == .3/3
# num_equal(.1, .3/3)
# 
# # Contrast:
# v <- c(.9 - .8, .8 - .7, .7 - .6, .6 - .5, 
#        .5 - .4, .4 - .3, .3 - .2, .2 -.1, .1)
# unique(v)
# .1 == v
# num_equal(.1, v)
#
# # Dates:
# num_equal(unclass(as.Date("2020-08-16")), unclass(Sys.Date()))
# 
# # non-numeric inputs:
# num_equal(1:3 > 1, 1:3)
# num_equal(1:3, LETTERS[1:3])
# num_equal(as.Date("2020-08-16"), unclass(Sys.Date()))


# is_equal: A wrapper around "==" and num_equal() ------ 

#' Test two vectors for pairwise (near) equality 
#'
#' \code{is_equal} tests if two vectors \code{x} and \code{y} are pairwise equal. 
#' 
#' If both \code{x} and \code{y} are numeric, 
#' \code{is_equal} calls \code{num_equal(x, y, ...)} 
#' (allowing for a tolerance threshold \code{tol}). 
#' Otherwise, \code{x} and \code{y} are compared by \code{x == y}. 
#' 
#' \code{is_equal} provides a wrapper around \code{\link{num_equal}} 
#' (for numeric objects \code{x} and \code{y}) and \code{==} (otherwise).
#' 
#' @param x 1st vector to compare (required).
#'
#' @param y 2nd vector to compare (required).
#'
#' @param ... Other parameters (passed to \code{num_equal()}). 
#'
#' @examples
#' # numeric data: 
#' is_equal(2, sqrt(2)^2)
#' is_equal(2, sqrt(2)^2, tol = 0)
#' is_equal(c(2, 3), c(sqrt(2)^2, sqrt(3)^2, 4/2, 9/3))
#' 
#' # other data types:
#' is_equal((1:3 > 1), (1:3 > 2))                         # logical
#' is_equal(c("A", "B", "c"), toupper(c("a", "b", "c")))  # character
#' is_equal(as.Date("2023-10-30"), Sys.Date())            # dates
#' 
#' # factors:
#' is_equal((1:3 > 1), as.factor((1:3 > 2)))  
#' is_equal(c(1, 2, 3), as.factor(c(1, 2, 3)))
#' is_equal(c("A", "B", "C"), as.factor(c("A", "B", "C"))) 
#'  
#' @family numeric functions 
#' @family utility functions 
#' 
#' @seealso 
#' \code{\link{num_equal}} function for comparing numeric vectors;
#' \code{\link{all.equal}} function of the R \strong{base} package;
#' \code{near} of the \strong{dplyr} package. 
#'
#' @export 

is_equal <- function(x, y, ...){
  
  if (is.numeric(x) & is.numeric(y)){
    
    # message("is_equal: Passing numeric inputs to num_equal().")
    num_equal(x, y, ...)
    
  } else { # other data types: 
    
    x == y
    
  }
  
} # is_equal(). 

## Check:
# # numeric data: 
# is_equal(2, sqrt(2)^2)
# is_equal(2, sqrt(2)^2, tol = 0)
# is_equal(c(2, 3), c(sqrt(2)^2, sqrt(3)^2, 4/2, 9/3))
# 
# # other data types:
# is_equal((1:4 > 2), (1:4 > 3))  # logical/Boolean
# is_equal(c("A", "B", "c"), toupper(c("a", "b", "c")))  # character
# is_equal(as.Date("2020-08-16"), Sys.Date())
#
# # as factors:
# is_equal((1:4 > 2), as.factor((1:4 > 3)))  
# is_equal(c(1, 2, 3), as.factor(c(1, 2, 3)))
# is_equal(c("A", "B", "C"), as.factor(c("A", "B", "C")))



## (B) Formatting number strings/numerals (e.g., as character objects or words): ------ 



# num_as_char: Print a number (as character), with n_pre_dec digits prior to decimal sep, and rounded to n_dec digits: ------

#' Convert a number into a character sequence 
#'
#' \code{num_as_char} converts a number into a character sequence 
#' (of a specific length). 
#' 
#' The arguments \code{n_pre_dec} and \code{n_dec} set a number of desired digits 
#' before and after the decimal separator \code{sep}. 
#' \code{num_as_char} tries to meet these digit numbers by adding zeros to the front 
#' and end of \code{x}. However, when \code{n_pre_dec} is lower than the 
#' number of relevant (pre-decimal) digits, all relevant digits are shown. 
#' 
#' \code{n_pre_dec} also works for negative numbers, but 
#' the minus symbol is not counted as a (pre-decimal) digit. 
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
#' # Note: If n_pre_dec is too small, actual number is kept:
#' num_as_char(11.33, n_pre_dec = 0, n_dec = 1)
#' num_as_char(11.66, n_pre_dec = 1, n_dec = 1)
#' 
#' # Note:
#' num_as_char(1, sep = ",")
#' num_as_char(2, sym = " ")
#' num_as_char(3, sym = " ", n_dec = 0)
#' 
#' # for vectors:
#' num_as_char(1:10/1, n_pre_dec = 1, n_dec = 1)
#' num_as_char(1:10/3, n_pre_dec = 2, n_dec = 2)
#' 
#' # for negative numbers (adding relevant pre-decimals):
#' mix <- c(10.33, -10.33, 10.66, -10.66)
#' num_as_char(mix, n_pre_dec = 1, n_dec = 1)
#' num_as_char(mix, n_pre_dec = 1, n_dec = 0)
#' 
#' # Beware of bad inputs:
#' num_as_char(4, sym = "8")
#' num_as_char(5, sym = "99")
#' 
#' @family numeric functions 
#' @family utility functions 
#' 
#' @export 

num_as_char <- function(x, n_pre_dec = 2, n_dec = 2, sym = "0", sep = "."){
  
  # 0. Initialize:
  char <- NA
  
  # 1. Handle inputs:
  if ((!is.na(as.numeric(sym))) && (as.numeric(sym) != 0)) {  # x is numeric, but not 0: 
    message("Setting sym to numeric digits (other than '0') is confusing.")
  }
  
  if (nchar(sym) > 1) {  # sym contains multiple characters: 
    message("Setting sym to more than 1 character is confusing.")
  }
  
  # Handle negative imputs:
  neg_sign <- rep("", length(x)) # initialize
  neg_sign[x < 0] <- "-"  # mark negative cases
  x <- abs(x)  # consider only positive cases
  
  # 2. Main: Split x_rounded into 2 parts: ---- 
  
  x_rounded <- round(x, n_dec)
  # message(paste0("x_rounded = ", x_rounded))  # debugging 
  
  # A. Part BEFORE the decimal point: ---- 
  n_num_1 <- x_rounded %/% 1  # Note: numerator of +1 assumes positive values.  
  
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
  
  # B. Part AFTER the decimal point: ---- 
  n_num_2 <- x_rounded %% 1  # Note: numerator of +1 assumes positive values.  
  # message(paste0("1. n_num_2 = ", n_num_2))  # debugging 
  
  # round to n_dec digits (again?):
  n_num_2 <- round(n_num_2, digits = n_dec)  # round to significant digits (again!) 
  # message(paste0("2. n_num_2 = ", n_num_2))  # debugging 
  
  n_char_2 <- as.character(n_num_2)  # as character
  # message(paste0("1. n_char_2 = ", n_char_2))  # debugging 
  
  n_char_2 <- substr(n_char_2, 3, nchar(n_char_2))  # remove "0." at beginning!
  # message(paste0("2. n_char_2 = ", n_char_2))  # debugging 
  
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
  
  # 3. Prepare output: ---- 
  # (a) Paste 2 parts together again:
  if (n_dec > 0) {
    char <- paste(n_char_1_final, n_char_2_final, sep = sep)
  } else {
    char <- paste0(n_char_1_final)  # use only 1st part (and no decimal separator)
  }
  
  # (b) Add neg_sign (if applicable):
  char <- paste0(neg_sign, char)
  
  # 4. Output: 
  return(char)
  
} # num_as_char() end. 

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
#
# # For negative numbers:
# num_as_char(-11.666, n_pre_dec = 1, n_dec = 2)
# num_as_char(-11.666, n_pre_dec = 1, n_dec = 1)
# num_as_char(-11.666, n_pre_dec = 1, n_dec = 0)
# 
# num_as_char(1:12/-1, n_pre_dec = 1, n_dec = 2)
# num_as_char(1:12/-3, n_pre_dec = 1, n_dec = 2)
#
# # Mix of positive and negative numbers:
# mix <- c(10.33, -10.33, 10.66, -10.66)
# num_as_char(mix, n_pre_dec = 1, n_dec = 3)
# num_as_char(mix, n_pre_dec = 1, n_dec = 2)
# num_as_char(mix, n_pre_dec = 1, n_dec = 1)
# num_as_char(mix, n_pre_dec = 1, n_dec = 0)


# num_as_ordinal: Convert a (cardinal) number into an ordinal string: ------

#' Convert a number into an ordinal character sequence 
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
#' when writing functions. 
#' It is instructive, but not written efficiently or well 
#' (see the function definition for an alternative solution 
#' using vector indexing). 
#' 
#' @param x Number(s) to convert (required, scalar or vector).
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
#' @family numeric functions 
#' @family utility functions 
#' 
#' @seealso 
#' \code{toOrdinal()} function of the \strong{toOrdinal} package.  
#'
#' @export 

num_as_ordinal <- function(x, sep = ""){
  
  # 0. Initialize:
  char <- NA
  
  # 1. Handle inputs:
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
  
  # 1. Main: Turn x into character(s): ---- 
  x_c <- as.character(x)
  nchar <- nchar(x_c)
  f_c <- substr(x_c, start = nchar, stop = nchar)        # final character
  f2c <- substr(x_c, start = (nchar - 1), stop = nchar)  # final 2 characters
  
  # 2. Initialize to default suffix "th": ---- 
  sfx <- rep("th", length(x))  
  
  # 3a. Loop through all x for suffix changes: ---- 
  for (i in seq_along(x)){
    
    # Test conditions for 3 special suffixes:
    if ( (f_c[i] == "1") && (f2c[i] != "11") ) { sfx[i] <- "st" }
    if ( (f_c[i] == "2") && (f2c[i] != "12") ) { sfx[i] <- "nd" }
    if ( (f_c[i] == "3") && (f2c[i] != "13") ) { sfx[i] <- "rd" }
    
  } # for loop end. 
  
  ## 3b. Replace loop by vector indexing: ----
  # sfx[(f_c == "1") & (f2c != "11")] <- "st"
  # sfx[(f_c == "2") & (f2c != "12")] <- "nd"
  # sfx[(f_c == "3") & (f2c != "13")] <- "rd"
  
  # 4. Combine:
  char <- paste0(x_c, sep, sfx)
  
  # 5. Output: 
  return(char)
  
} # num_as_ordinal() end.

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




# base_digits: Define the sequence of base digits/numeric symbols (as a global constant) ------ 

base_digit_vec        <- c(0:9, LETTERS[1:6])      # max_base value: 16
base_digit_vec        <- c(0:9, LETTERS, letters)  # max_base value: 62
names(base_digit_vec) <- 0:(length(base_digit_vec) - 1)  # zero-indexed numeric names


#' Base digits: Sequence of numeric symbols (as named vector) 
#' 
#' \code{base_digits} provides numeral symbols (digits) 
#' for notational place-value systems with arbitrary bases 
#' (as a named character vector).
#' 
#' Note that the elements (digits) are character symbols 
#' (i.e., numeral digits "0"-"9", "A"-"F", etc.), 
#' whereas their names correspond to their 
#' numeric values (from 0 to \code{length(base_digits) - 1}). 
#' 
#' Thus, the maximum base value in conversions by 
#' \code{\link{base2dec}} or \code{\link{dec2base}} 
#' is \code{length(base_digits)}. 
#' 
#' @examples 
#' base_digits          # named character vector, zero-indexed names
#' length(base_digits)  # 62 (maximum base value)
#' base_digits[10]      # 10. element ("9" with name "9") 
#' base_digits["10"]    # named element "10" ("A" with name "10")
#' base_digits[["10"]]  # element named "10" ("A")
#' 
#' @family numeric functions 
#' @family utility functions 
#' 
#' @seealso
#' \code{\link{base2dec}} converts numerals in some base into decimal numbers; 
#' \code{\link{dec2base}} converts decimal numbers into numerals in another base; 
#' \code{\link{as.roman}} converts integers into Roman numerals. 
#' 
#' @export 

base_digits <- base_digit_vec

## Check:
# base_digits
# length(base_digits)  # 62, but zero-indexed names
# base_digits[10]      # 10. element ("9" with name "9")
# base_digits["10"]    # named element "10" ("A" with name "10")
# base_digits[["10"]]  # element named "10" ("A")

## Done: ----------

# - etc.

## ToDo: ------

# - etc.

## eof. ----------
