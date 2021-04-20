## util_fun.R | ds4psy
## hn | uni.kn | 2021 04 20
## ---------------------------

## Utility functions. 

# vrep: A vectorized version of rep: ------

vrep <- Vectorize(rep.int, "times")

## Check:
# vrep(x = 1,   times = 1:3)
# vrep(x = "a", times = 2:4)
## => works, but returns a list.


# recycle_vec: Recycle (extend or truncate) a vector v to a length len: ------

recycle_vec <- function(v, len){
  
  # Special cases:  
  if (is.na(len)) { return(NA) }
  if (len == 0) { return(v[0]) }
  
  # Initialize: 
  v_len <- length(v)
  
  # Main: Compare v_len with len:  
  if (v_len > len){ # truncate v:
    
    v[1:len]  # first len elements
    
  } else if (v_len < len) { # extend v:
    
    rep(v, ceiling(len/v_len))[1:len]
    
  } else {
    
    v  # no change
    
  }
  
} # recycle_vec() end.


## Check:
# recycle_vec(1:4, NA)
# recycle_vec(1:4, 6)
# recycle_vec(1:4, 2)
# recycle_vec(1:4, 4)
# # Note: 
# recycle_vec(1:3, 0)
# recycle_vec(letters[1:3], 0)
# recycle_vec(c(1, NA, 3), 5)


# align_vec: Recycle or truncate a vector v to the length of a main one: ------

# Return the modified vector (with a different length).

align_vec <- function(v_mod, v_fix){
  
  v_out <- v_mod  # default: original v_mod
  
  # Lengths:
  n_fix <- length(v_fix)
  n_org <- length(v_mod)
  
  # Main:
  if (n_fix != n_org){  # different lengths:
    
    if (n_org > n_fix){ # 1. truncate v_mod to the length of n_fix:
      
      v_out <- v_mod[1:n_fix]
      
    } else { # 2. recycle v_mod to the length of n_fix:
      
      v_out <- rep(v_mod, ceiling(n_fix/n_org))[1:n_fix]
      
    } # end else.
  } # end if.
  
  return(v_out)
  
} # align_vec() end.

# ## Check:
# align_vec(LETTERS[1:4], 1:4)  # same length
# align_vec(LETTERS[1:4], 1:6)  # lengthen v_mod
# align_vec(LETTERS[1:6], 1:4)  # shorten v_mod
# 
# # Note:
# align_vec(LETTERS[1:3], NA)
# align_vec(NA, 1:4)


# align_vec_pair: Recycle a pair of vector to the length of the longer one: ------ 

# Return the pair of both vectors (as a list). 

align_vec_pair <- function(v1, v2){
  
  # Initialize: 
  lo <- NA
  o1 <- v1
  o2 <- v2 
  
  # Length of vectors: 
  n1 <- length(v1)
  n2 <- length(v2)
  
  # Main: 
  if (n1 != n2){  # different lengths:
    
    if (n2 > n1){ # 1. recycle v1 to length of v2:
      
      o1 <- rep(v1, ceiling(n2/n1))[1:n2]
      
    } else { # 2. recycle v2 to the length of v1: 
      
      o2 <- rep(v2, ceiling(n1/n2))[1:n1]
      
    } # end else. 
  } # end if.  
  
  # Output: Return both vectors (as a list): 
  lo <- list(o1, o2) 
  
  return(lo)
  
} # align_vec_pair() end. 

# ## Check:
# align_vec_pair(1:5, LETTERS[1:5])  # same length
# align_vec_pair(1:5, LETTERS[1:3])  # 2nd vector is recycled
# align_vec_pair(1:5, LETTERS[1:10]) # 1st vector is recycled
# 
# # Note: Handling NA cases
# align_vec_pair(NA, LETTERS[1:3])
# align_vec_pair(1:5, NA)



# num_as_char: Print a number (as character), with n_pre_dec digits prior to decimal sep, and rounded to n_dec digits: ------

#' Convert a number into a character sequence. 
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



# is_vector: Testing for a vector (which is.vector does not) ------ 

#' Test for a vector (i.e., atomic vector or list). 
#'
#' \code{is_vector} tests if \code{x} is a vector.
#' 
#' \code{is_vector} does what the \strong{base} R function \code{is.vector} is \strong{not} designed to do: 
#' 
#' \itemize{ 
#'   \item \code{is_vector()} returns TRUE if \code{x} is an atomic vector or a list (irrespective of its attributes). 
#' 
#'   \item \code{is.vector()} returns TRUE if \code{x} is a vector of the specified \code{mode} having no attributes other than names, otherwise FALSE.
#' }
#' 
#' Internally, the function is a wrapper for \code{is.atomic(x) | is.list(x)}. 
#' 
#' Note that data frames are also vectors.
#' 
#' See the documentations of \code{\link{is.atomic}}, \code{\link{is.list}}, and \code{\link{is.vector}} for details.
#' 
#' @param x Vector(s) to test (required).
#'
#' @examples
#' # Define 3 types of vectors:
#' v1 <- 1:3  # (a) atomic vector
#' names(v1) <- LETTERS[v1]  # with names
#' 
#' v2 <- v1   # (b) copy vector
#' attr(v2, "my_attr") <- "foo"  # add an attribute
#' ls <- list(1, 2, "C")  # (c) list
#' 
#' # Compare:
#' is.vector(v1)
#' is.list(v1)
#' is_vector(v1)
#' 
#' is.vector(v2)  # FALSE
#' is.list(v2)
#' is_vector(v2)  # TRUE
#' 
#' is.vector(ls)
#' is.list(ls)
#' is_vector(ls)
#' 
#' # Data frames are also vectors: 
#' df <- as.data.frame(1:3)
#' is_vector(df)  # is TRUE
#' 
#' @family utility functions
#'
#' @seealso 
#' \code{\link{is.atomic}} function of the R \strong{base} package; 
#' \code{\link{is.list}} function of the R \strong{base} package;  
#' \code{\link{is.vector}} function of the R \strong{base} package.  
#'
#' @export 

is_vector <- function(x) {
  
  is.atomic(x) | is.list(x)
  
} # is_vector() end.

# ## Check: 
# # 3 types of vectors:
# v1 <- 1:3  # (a) atomic vector
# names(v1) <- LETTERS[v1]  # with names
# 
# v2 <- v1   # (b) copy vector
# attr(v2, "my_attr") <- "foo"  # add an attribute
# 
# ls <- list(1, 2, "C")  # (c) list
# 
# # Compare:
# is.vector(v1)
# is.list(v1)
# is_vector(v1)
# 
# is.vector(v2)  # FALSE
# is.list(v2)
# is_vector(v2)  # TRUE
# 
# is.vector(ls)
# is.list(ls)
# is_vector(ls)
# 
# # Vectors of vectors:
# vs <- c(v1, v2, ls)
# df <- data.frame(v1, v2)
# 
# is.vector(vs)
# is.vector(df)
# 
# # Data frames are also vectors: 
# df <- as.data.frame(1:3)
# is_vector(df)  # is TRUE


# is_wholenumber: Testing for integer values (which is.integer does not) ------ 

# Note that is.integer() tests for objects of TYPE "integer", not integer values. 
# See help on is.integer(). 

#' Test for whole numbers (i.e., integers). 
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
#' @family utility functions
#'
#' @seealso 
#' \code{\link{is.integer}} function of the R \strong{base} package.  
#'
#' @export 

is_wholenumber <- function(x, tol = .Machine$double.eps^0.5) {
  
  abs(x - round(x)) < tol
  
} # is_wholenumber() end.

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

# See also 
# base::all.equal() and 
# dplyr::near for similar functions.

#' Test two numeric vectors for pairwise (near) equality. 
#'
#' \code{num_equal} tests if two numeric vectors \code{x} and \code{y} are pairwise equal 
#' (within some tolerance value `tol`). 
#' 
#' \code{num_equal} is a safer way to verify the (near) equality of numeric vectors than \code{==},  
#' as numbers may exhibit floating point effects. 
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
  
} # num_equal() end. 

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

#' Test two vectors for pairwise (near) equality. 
#'
#' \code{is_equal} tests if two vectors \code{x} and \code{y} are pairwise equal. 
#' 
#' If both \code{x} and \code{y} are numeric, 
#' \code{is_equal} calls \code{num_equal(x, y, ...)} 
#' (allowing for some tolerance threshold \code{tol}).  
#' 
#' Otherwise, \code{x} and \code{y} are compared by \code{x == y}. 
#' 
#' \code{is_equal} is a safer way to verify the (near) equality of numeric vectors than \code{==},  
#' as numbers may exhibit floating point effects. 
#' 
#' @param x 1st vector to compare (required).
#'
#' @param y 2nd vector to compare (required).
#'
#' @param ... Other parameters (passed to \code{num_equal()}). 
#'
#' @examples
#' 
#' # numeric data: 
#' is_equal(2, sqrt(2)^2)
#' is_equal(2, sqrt(2)^2, tol = 0)
#' is_equal(c(2, 3), c(sqrt(2)^2, sqrt(3)^2, 4/2, 9/3))
#' 
#' # other data types:
#' is_equal((1:3 > 1), (1:3 > 2))                         # logical
#' is_equal(c("A", "B", "c"), toupper(c("a", "b", "c")))  # character
#' is_equal(as.Date("2020-08-16"), Sys.Date())            # dates
#' 
#' # as factors:
#' is_equal((1:3 > 1), as.factor((1:3 > 2)))  
#' is_equal(c(1, 2, 3), as.factor(c(1, 2, 3)))
#' is_equal(c("A", "B", "C"), as.factor(c("A", "B", "C"))) 
#'  
#' @family utility functions
#'
#' @seealso 
#' \code{\link{num_equal}} function for comparing numeric vectors;
#' \code{\link{all.equal}} function of the R \strong{base} package;
#' \code{near} function of the \strong{dplyr} package. 
#'
#' @export 

is_equal <- function(x, y, ...){
  
  if (is.numeric(x) & is.numeric(y)){
    
    # message("is_equal: Passing numeric inputs to num_equal().")
    num_equal(x, y, ...)
    
  } else { # all other data types: 
    
    x == y
    
  }
  
} # is_equal() end. 

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



# kill_all: Kill all objects in current environment (without warning): ------

kill_all <- function(){
  
  rm(list = ls())
  
} # kill_all() end. 

## Check: 
# kill_all()


## ToDo: ----------

# - etc.

## eof. ----------------------