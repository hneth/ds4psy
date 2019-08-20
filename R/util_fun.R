## util_fun.R | ds4psy
## hn | uni.kn | 2019 08 20
## ---------------------------

## Utility functions. 

# make_grid: Generate a grid of x-y coordinates (from -x:x to -y:y): ------ 

#' Generate a grid of x-y coordinates (as a tibble). 
#'
#' \code{make_grid} generates a grid of x/y coordinates and returns it as a tibble.
#' 
#' @param x_min Minimum x coordinate.  
#' Default: \code{x_min = 0}. 
#'
#' @param x_max Maximum x coordinate.  
#' Default: \code{x_max = 2}. 
#' 
#' @param y_min Minimum y coordinate.  
#' Default: \code{y_min = 0}. 
#'
#' @param y_max Maximum y coordinate.  
#' Default: \code{y_max = 1}. 
#'
#' @examples
#' make_grid()
#' make_grid(x_min = -3, x_max = 3, y_min = -2, y_max = 2)
#'  
#' @family utility functions
#'
#' @import tibble
#' 
#' @export 

make_grid <- function(x_min = 0, x_max = 2, y_min = 0, y_max = 1){
  
  # check inputs: 
  if (!is.numeric(x_min) || !is.numeric(x_max) || 
      !is.numeric(y_min) || !is.numeric(y_max) ) {
    stop("All arguments must be numeric.")
  }
  
  if (x_min > x_max) {
    message("x_max should be larger than x_min: Reversing them...")
    x_tmp <- x_min
    x_min <- x_max
    x_max <- x_tmp 
  }
  
  if (y_min > y_max) {
    message("y_max should be larger than y_min: Reversing them...")
    y_tmp <- y_min
    y_min <- y_max
    y_max <- y_tmp 
  }
  
  # initialize:
  tb <- NA 
  
  # ranges: 
  xs <- x_min:x_max
  ys <- y_min:y_max
  
  # tibble:
  tb <- tibble::tibble(x = rep(xs, times = length(ys)),
                       y = rep(ys, each = length(xs)))
  
  return(tb)
  
}  # make_grid end. 

## Check: 
# make_grid()
# make_grid(x_min = 0, x_max = 0, y_min = 1, y_max = 1)
# make_grid(x_min = 1, x_max = 0, y_min = 2, y_max = 1)
# make_grid(x_min = "A")
# make_grid(x_min = 1/2, y_min = 1/3)




# vrep: A vectorized version of rep: ------

vrep <- Vectorize(rep.int, "times")

## Check:
# vrep(x = 1,   times = 1:3)
# vrep(x = "a", times = 2:4)

# num_as_char: Print a number (as character), with n_pre_dec digits prior to decimal sep, and rounded to n_dec digits: ------

#' Convert a number to character sequence. 
#'
#' \code{num_as_char} converts a given number into a character sequence. 
#' 
#' The arguments \code{n_pre_dec} and \code{n_dec} set a number of desired digits 
#' before and after the decimal separator \code{sep}. 
#' \code{num_as_char} tries to meet these digit numbers by adding zeros to the front 
#' and end of \code{x}. 
#' 
#' Note that this function illustrates how numbers, 
#' characters, \code{for} loops, and \code{paste()} can be combined 
#' when writing functions. It is not written efficiently or well. 
#' 
#' @param x Number to convert (required).
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
  if ((!is.na(as.numeric(sym))) && (as.numeric(sym) != 0)) {
    message("Setting sym to numeric digits (other than '0') is confusing.")
  }
  if (nchar(sym) > 1) {
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

# kill_all: Kill all objects in current environment (without warning): ------

kill_all <- function(){
  
  rm(list = ls())
  
}  # kill_all end. 

## Check: 
# kill_all()


## ToDo: ----------

## eof. ----------------------