## util_fun.R | ds4psy
## hn | uni.kn | 2019 08 19
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
}

## Check: 
# make_grid()
# make_grid(x_min = 0, x_max = 0, y_min = 1, y_max = 1)
# make_grid(x_min = 1, x_max = 0, y_min = 2, y_max = 1)
# make_grid(x_min = "A")
# make_grid(x_min = 1/2, y_min = 1/3)



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
#' num_as_char((1.6666), n_pre_dec = 1, n_dec = 0)
#' num_as_char((1.6666), n_pre_dec = 2, n_dec = 1)
#' num_as_char((1.6666), n_pre_dec = 2, n_dec = 2)
#' num_as_char((1.6666), n_pre_dec = 2, n_dec = 3)
#' 
#' # Note: If n_pre_dec is too small, actual number is used:
#' num_as_char((11.33), n_pre_dec = 0, n_dec = 1)
#' num_as_char((11.66), n_pre_dec = 1, n_dec = 1)
#'   
#' @family utility functions
#'
#' @export 

num_as_char <- function(x, n_pre_dec = 2, n_dec = 2, sep = "."){
  
  x <- round(x, n_dec)
  
  # split into 2 parts:
  # (1) before decimal point (.):
  n_num_1 <- x %/% 1
  
  n_char_1 <- as.character(n_num_1)
  # print(n_char_1)  # debugging
  
  if (nchar(n_char_1) < n_pre_dec){
    
    # add zeros at front:  
    dif_1 <- (n_pre_dec - nchar(n_char_1)) 
    zeros_1 <- paste0(rep("0", dif_1), collapse = "")
    n_char_1 <- paste0(zeros_1, n_char_1)
    
  }
  
  # (2) after decimal point (.):
  n_num_2 <- x %% 1
  # print(n_num_2)  # debugging
  
  n_num_2 <- round(n_num_2, digits = n_dec)  # round to significant digits!
  # print(n_num_2)  # debugging
  
  n_char_2 <- as.character(n_num_2)
  
  n_char_2 <- substr(n_char_2, 3, nchar(n_char_2))  # remove "0." at beginning
  # print(n_char_2)  # debugging
  
  if (nchar(n_char_2) < n_dec){
    
    # add zeros at back:  
    dif_2 <- (n_dec - nchar(n_char_2)) 
    zeros_2 <- paste0(rep("0", dif_2), collapse = "")
    n_char_2 <- paste0(n_char_2, zeros_2)
    
  }
  
  if (n_dec > 0){
    out <- paste(n_char_1, n_char_2, sep = sep)
  } else {
    out <- n_char_1
  }
  
  # return:
  return(out)
  
}

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


# kill_all: Kill all objects in current environment (without warning): ------

kill_all <- function(){
  
  rm(list = ls())
  
}

## Check: 
# kill_all()


## ToDo: ----------

## eof. ----------------------