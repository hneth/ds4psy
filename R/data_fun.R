## data_fun.R | ds4psy
## hn | uni.kn | 2020 07 30
## ---------------------------

## Functions for creating and manipulating data. 


## (1) Generate random datasets: ---------- 

# Random binary values: Flip a 0/1 coin n times:  ------ 

random_bin_value <- function(x = c(0, 1), n = 1, replace = TRUE) {
  
  if (length(x) != 2) {
    message("random_bin_value: x should be binary.")
  }
  
  sample(x = x, size = n, replace = replace)  
  
} # random_bin_value end. 

## Check: 
# random_bin_value(n = 10)
# random_bin_value(x = c("m", "f"), n = 100)


# coin: Flip a fair coin n times (with events): ------ 

#' Flip a fair coin (with 2 sides "H" and "T") n times. 
#'
#' \code{coin} generates a sequence of events that 
#' represent the results of flipping a fair coin \code{n} times. 
#' 
#' By default, the 2 possible \code{events} for each flip 
#' are "H" (for "heads") and "T" (for "tails"). 
#' 
#' @param n Number of coin flips.
#' Default: \code{n = 1}. 
#' 
#' @param events Possible outcomes (as a vector). 
#' Default: \code{events = c("H", "T")}. 
#'
#' @examples
#' # Basics: 
#' coin()
#' table(coin(n = 100))
#' table(coin(n = 100, events = LETTERS[1:3]))
#' 
#' # Note an oddity:
#' coin(10, events = 8:9)  # works as expected, but 
#' coin(10, events = 9:9)  # odd: see sample() for an explanation.
#' 
#' # Limits:
#' coin(2:3)
#' coin(NA)
#' coin(0)
#' coin(1/2)
#' coin(3, events = "X")
#' coin(3, events = NA)
#' coin(NULL, NULL)
#' 
#' @family sampling functions
#'
#' @export 

coin <- function(n = 1, events = c("H", "T")){
  
  # check inputs: 
  if (is.null(n)){
    message("coin: n must not be NULL. Using n = 1:") 
    n <- 1
  }
  if (is.null(events)){
    message("coin: events must not be NULL. Using events = c('H', 'T':)") 
    events <- c("H", "T")
  }
  
  if (length(n) > 1) {  # n is a vector: 
    message(paste0("coin: n must be a scalar. Using n[1] = ", n[1], ":"))
    n <- n[1]
  }
  
  if ( (length(n) == 1) && ( is.na(n) || !is.numeric(n) || !is.wholenumber(n) || (n < 1) ) ) { 
    message("coin: n must be a positive integer. Using n = 1:") 
    n <- 1
  }
  
  # sample n outcomes: 
  sample(x = events, size = n, replace = TRUE)
  
} # coin end. 

# ## Check:
# # Basics:
# coin()
# table(coin(n = 1000))
# 
# # Limits:
# coin(2:3)
# coin(NA)
# coin("_")
# coin(0)
# coin(1/2)
# coin(10, NA)
# coin(NULL, NULL)

## Note:
# table(coin(1000, 9:9))  # does NOT draw only 9...


# Random values from a normal distribution: ------ 

# r_n <- rnorm(n = 10000, mean = 100, sd = 10)
# table(round(r_n, 0))
# hist(r_n)


# Random values from a uniform distribution: ------ 

# r_u <- runif(n = 10000, min = .500, max = 6.499)
# table(round(r_u, 0))
# hist(r_u)


# Random draws from a sample: ------ 

# r_s <- sample(x = 1:10, size = 1000, replace = TRUE)
# table(r_s)
# hist(r_s, right = TRUE)
# hist(r_s, right = FALSE)


# Sample random characters (from given characters): ------ 

#' Draw a sample of n random characters 
#' (from given characters). 
#'
#' \code{sample_char} draws a sample of  
#' \code{n} random characters from a given range of characters.
#' 
#' By default, \code{sample_char} draws \code{n = 1} 
#' a random alphabetic character from  
#' \code{x_char = c(letters, LETTERS)}.
#' 
#' As with \code{sample()}, the sample size \code{n} must not exceed 
#' the number of available characters \code{nchar(x_char)}, 
#' unless \code{replace = TRUE} (i.e., sampling with replacement). 
#' 
#' @param x_char Population of characters to sample from. 
#' Default: \code{x_char = c(letters, LETTERS)}. 
#' 
#' @param n Number of characters to draw. 
#' Default: \code{n = 1}. 
#' 
#' @param replace Boolean: Sample with replacement? 
#' Default: \code{replace = FALSE}. 
#' 
#' @param ... Other arguments.  
#' (Use for specifying \code{prob}, as passed to \code{sample()}.)   
#' 
#' @return A text string (scalar character vector). 
#' 
#' @examples
#' sample_char()  # default
#' sample_char(n = 10)
#' sample_char(x_char = "abc", n = 10, replace = TRUE)
#' sample_char(x_char = c("x y", "6 9"), n =  6, replace = FALSE)
#' sample_char(x_char = c("x y", "6 9"), n = 20, replace = TRUE)
#' 
#' # Biased sampling: 
#' sample_char(x_char = "abc", n = 20, replace = TRUE, 
#'              prob = c(3/6, 2/6, 1/6))
#' 
#' # Note: By default, n must not exceed nchar(x_char):
#' sample_char(n = 52, replace = FALSE)    # works, but
#' # sample_char(n = 53, replace = FALSE)  # would yield ERROR; 
#' sample_char(n = 53, replace = TRUE)     # works again.
#' 
#' @family sampling functions
#'
#' @export 

sample_char <- function(x_char = c(letters, LETTERS), n = 1, replace = FALSE, ...){
  
  out <- NA  # initialize
  
  # Checks: 
  # x_char is a vector of characters:
  if (!is.character(x_char)){
    message("sample_char: x_char must be of type character.")
  }
  
  # # x_char is not "":
  # if ((all(is.character(x_char))) & (sum(nchar(x_char) == 0))){
  #   message("sample_char: x_char must contain at least 1 character.")
  # }
  
  # Split x_char into a vector of individual characters:
  char_v <- unlist(strsplit(x_char, split = ""))
  
  # Check: Verify that is something to sample from:   
  if (length(char_v) == 0){
    message("sample_char: x_char must contain at least 1 character.")
  }
  
  # Use sample(): 
  sample_v <- sample(x = char_v, size = n, replace = replace, ...)
  
  # Paste into single char:
  out <- paste0(sample_v, collapse = "")
  
  return(out)
  
} # sample_char end. 

# ## Check: 
# sample_char()
# sample_char(n = 10)
# sample_char(x_char = "abc", n = 10, replace = TRUE)
# sample_char(x_char = c("x y", "6 9"), n =  6, replace = FALSE)
# sample_char(x_char = c("x y", "6 9"), n = 20, replace = TRUE)
# 
# # Biased sampling: 
# sample_char(x_char = "abc", n = 20, replace = TRUE, prob = c(3/6, 2/6, 1/6))
#
# # Note: By default, n must not exceed nchar(x_char):
# sample_char(n = 52, replace = FALSE)    # works, but
# # sample_char(n = 53, replace = FALSE)  # yields ERROR.
# sample_char(n = 53, replace = TRUE)     # works again

# ## Errors:
#
# sample_char(x_char = 1)
# sample_char(x_char = NA)
# sample_char(x_char = NULL)
#
# sample_char(x_char = "")
# sample_char(x_char = c("", ""))
# sample_char(x_char = c("", "", " "))

# ## R meta-characters:
# metas <- c(". \ | ( ) [ { ^ $ * + ?")
# nomta <- c(", : / < > ] } & % # - ! =")
# 
# # without spaces:
# mcv <- unlist(strsplit(metas, split = " "))
# mcv  # Note: \ is now ""!
# nmv <- unlist(strsplit(nomta, split = " "))
# nmv
# 
# # Apply: 
# sample_char(x_char = c(mcv, nmv), n = 24, replace = FALSE)  # unique items
# sample_char(x_char = c(mcv, nmv), n = 50, replace = TRUE)   # repeated items


# Sample random dates (from a given range): ------

#' Draw a sample of n random dates (from a given range). 
#'
#' \code{sample_date} draws a sample of  
#' \code{n} random dates from a given range.
#' 
#' By default, \code{sample_date} draws \code{n = 1} 
#' random date (as a "Date" object) in the range 
#' \code{from = "1970-01-01"} 
#' \code{to = Sys.Date()} (current date).
#' 
#' @param n Number dates to draw. 
#' Default: \code{n = 1}. 
#' 
#' @param from Earliest date (as string). 
#' Default: \code{from = "1970-01-01"}. 
#' 
#' @param to Latest date (as string). 
#' Default: \code{to = Sys.Date()}. 
#' 
#' @return A vector of class "Date". 
#' 
#' @examples
#' sample_date()
#' sort(sample_date(n = 10))
#' sort(sample_date(n = 10, from = "2020-02-28", to = "2020-03-01"))  # 2020 is a leap year
#' 
#' # Note: Oddity with sample():
#' sort(sample_date(n = 10, from = "2020-01-01", to = "2020-01-01"))  # range of 0!
#' # see sample(9:9, size = 10, replace = TRUE)
#' 
#' @family sampling functions
#'
#' @export 

sample_date <- function(n = 1, from = "1970-01-01", to = Sys.Date()){
  
  # 0. Initialize:
  dt <- rep(NA, n) 
  
  # 1. Handle inputs:
  # set.seed(1984)  # for reproducible randomness
  d1 <- as.Date(from)  
  d2 <- as.Date(to)   
  
  # 2. Main: Use sample() 
  dt <- as.Date(sample(as.numeric(d1):as.numeric(d2), size = n, 
                       replace = TRUE), origin = '1970-01-01')
  
  # 3. Output:
  return(dt)
  
} # sample_date end. 

## Check:
# sample_date()
# sort(sample_date(n = 10))
# sort(sample_date(n = 10, from = "2020-02-28", to = "2020-03-01"))  # 2020 is a leap year
# 
# # Note: Oddity with sample():
# sort(sample_date(n = 10, from = "2020-01-01", to = "2020-01-01"))  # range of 0!
# # see sample(9:9, size = 10, replace = TRUE)



# Sample random times (from a given range): ------

#' Draw a sample of n random times (from a given range). 
#'
#' \code{sample_time} draws a sample of  
#' \code{n} random times from a given range.
#' 
#' By default, \code{sample_time} draws \code{n = 1} 
#' random calendar time (as a "POSIXct" object) in the range 
#' \code{from = "1970-01-01 00:00:00"} 
#' \code{to = Sys.time()} (current time).
#' 
#' If \code{as_POSIXct = FALSE}, a local time ("POSIXlt") object is returned 
#' (as a list). 
#' 
#' The \code{tz} argument allows specifying time zones 
#' (see \code{Sys.timezone()} for current setting 
#' and \code{OlsonNames()} for options.) 
#' 
#' @param n Number dates to draw. 
#' Default: \code{n = 1}. 
#' 
#' @param from Earliest date (as string). 
#' Default: \code{from = "1970-01-01 00:00:00"}. 
#' 
#' @param to Latest date (as string). 
#' Default: \code{to = Sys.time()}. 
#' 
#' @param as_POSIXct Boolean: Return calendar time ("POSIXct") object? 
#' Default: \code{as_POSIXct = TRUE}. 
#' If \code{as_POSIXct = FALSE}, a local time ("POSIXlt") object is returned 
#' (as a list). 
#' 
#' @param tz Time zone.
#' Default: \code{tz = ""} (i.e., current system time zone,  
#' see \code{Sys.timezone()}). 
#' Use \code{tz = "UTC"} for Universal Time, Coordinated. 
#' 
#' @return A vector of class "POSIXct" or "POSIXlt".   
#' 
#' @examples
#' # Basics:
#' sample_time()
#' sample_time(n = 10)
#' 
#' # Specific ranges:
#' sort(sample_time(n = 10, from = (Sys.time() - 60)))  # within the last minute
#' sort(sample_time(n = 10, from = (Sys.time() - 1 * 60 * 60)))  # within the last hour
#' sort(sample_time(n = 10, from = Sys.time(), 
#'                            to = (Sys.time() + 1 * 60 * 60)))  # within the next hour
#' sort(sample_time(n = 10, from = "2020-12-31 00:00:00 CET", 
#'                            to = "2020-12-31 00:00:01 CET"))   # within 1 sec range
#'                            
#' # Local time (POSIXlt) objects (as list):
#' sample_time(as_POSIXct = FALSE)
#' unlist(sample_time(as_POSIXct = FALSE))
#' 
#' # Time zones:
#' sample_time(n = 3, tz = "UTC")
#' sample_time(n = 3, tz = "US/Pacific")
#'  
#' # Note: Oddity with sample(): 
#' sort(sample_time(n = 10, from = "2020-12-31 00:00:00 CET", 
#'                            to = "2020-12-31 00:00:00 CET"))  # range of 0!
#' # see sample(9:9, size = 10, replace = TRUE)
#' 
#' @family sampling functions
#'
#' @export

sample_time <- function(n = 1, 
                        from = "1970-01-01 00:00:00", to = Sys.time(),
                        as_POSIXct = TRUE, tz = ""){
  
  # 0. Initialize:
  tv <- rep(NA, n)  
  
  # 1. Handle inputs:
  t1 <- as.POSIXlt(from)
  t2 <- as.POSIXlt(to)
  
  # 2. Main: Use sample()
  tv <- as.POSIXlt(sample(as.numeric(t1):as.numeric(t2), size = n, 
                          replace = TRUE), origin = '1970-01-01')
  
  # 3. Add time zone:
  if (as_POSIXct) { 
    tv <- as.POSIXct(tv, tz = tz)  # convert into POSIXct with tz
  } else {
    tv <- as.POSIXct(tv, tz = tz)  # convert into POSIXct with tz
    tv <- as.POSIXlt(tv, tz = tz)  # re-convert into POSIXlt
  }
  
  # 4. Output: 
  return(tv)
  
} # sample_time end.


# ## Check:
# # Basics:
# sample_time()
# sample_time(n = 10)
# 
# # Specific ranges:
# sort(sample_time(n = 10, from = (Sys.time() - 60)))  # within the last minute
# sort(sample_time(n = 10, from = (Sys.time() - 1 * 60 * 60)))  # within the last hour
# sort(sample_time(n = 10, from = Sys.time(), to = (Sys.time() + 1 * 60 * 60)))  # within next hour
# sort(sample_time(n = 10, from = "2020-01-01 00:00:00 CET", to = "2020-01-01 00:00:01 CET"))  # 1 sec range
# 
# # Local time (POSIXlt) objects (as list):
# sample_time(as_POSIXct = FALSE)
# unlist(sample_time(as_POSIXct = FALSE))
# 
# # Time zones:
# sample_time(n = 3, tz = "UTC")
# sample_time(n = 3, tz = "US/Pacific")
# 
# # Note: Oddity with sample():
# sort(sample_time(n = 10, from = "2020-01-01 00:00:00 CET", to = "2020-01-01 00:00:00 CET"))  # range of 0!
# # see sample(9:9, size = 10, replace = TRUE)

## ToDo: Sampling normally distributed times:
# now <- Sys.time()
# hist(as.POSIXlt(now) + rnorm(n = 1000, mean = 0, sd = 60*60), breaks = 10)
# t1 <- as.POSIXlt(Sys.time())
# t2 <- as.POSIXlt(Sys.time() + 1 * 60 * 60)  # 1 hour later
# as.POSIXlt(sample(as.numeric(t1):as.numeric(t2), size = 10, replace = TRUE), origin = '1970-01-01')


# dice: n random draws from a sample (from events): ------ 

#' Throw a fair dice (with a given number of sides) n times. 
#'
#' \code{dice} generates a sequence of events that 
#' represent the results of throwing a fair dice 
#' (with a given number of \code{events} or number of sides) 
#' \code{n} times.
#' 
#' By default, the 6 possible \code{events} for each throw of the dice  
#' are the numbers from 1 to 6. 
#' 
#' @param n Number of dice throws. 
#' Default: \code{n = 1}. 
#' 
#' @param events Events to draw from (or number of sides).
#' Default: \code{events = 1:6}. 
#'
#' @examples
#' # Basics:
#' dice()
#' table(dice(10^4))
#' 
#' # 5-sided dice:
#' dice(events = 1:5)
#' table(dice(100, events = 5))
#' 
#' # Strange dice:
#' dice(5, events = 8:9)
#' table(dice(100, LETTERS[1:3]))
#' 
#' # Note:
#' dice(10, 1)
#' table(dice(100, 2))
#' 
#' # Note an oddity:
#' dice(10, events = 8:9)  # works as expected, but 
#' dice(10, events = 9:9)  # odd: see sample() for an explanation.
#' 
#' # Limits:
#' dice(NA)
#' dice(0)
#' dice(1/2)
#' dice(2:3)
#' dice(5, events = NA)
#' dice(5, events = 1/2)
#' dice(NULL, NULL)
#' 
#' @family sampling functions
#'
#' @export 

dice <- function(n = 1, events = 1:6){
  
  # (a) verify n: 
  if (is.null(n)){
    message("dice: n must not be NULL. Using n = 1:") 
    n <- 1
  }
  if (length(n) > 1) {  # n is a vector: 
    message(paste0("dice: n must be scalar. Using n[1] = ", n[1], ":"))
    n <- n[1]
  }
  # Verify that n is a numeric integer > 1:  
  if ((length(n) == 1) && (is.na(n) || !is.numeric(n) || !is.wholenumber(n) || (n < 1) ) ) { 
    message("dice: n must be a positive integer. Using n = 1:") 
    n <- 1
  }
  
  # (b) verify events: 
  if (is.null(events)){
    message("dice: events must not be NULL. Using events = 1:6:") 
    events <- 1:6
  }
  
  if (length(events) > 1) {  # events is a vector: 
    
    # message(paste0("dice: sides is a set. Using it:"))
    
    set_of_events <- events
    
  } else {  # sides is a scalar: length(sides) <= 1:
    
    # Verify that events is a numeric integer > 1:
    if ( is.na(events) || !is.numeric(events) || !is.wholenumber(events) || (events < 1) ) { 
      message("dice: events must be an integer or a set. Using events = 6:") 
      events <- 6
    }
    
    set_of_events <- 1:events  # default set
    
  }
  
  # Sample n times from set_of_events: 
  sample(x = set_of_events, size = n, replace = TRUE)
  
} # dice end.

# ## Check:
# # Basics:
# dice()
# table(dice(10^4))
# 
# # 5-sided dice:
# dice(sides = 5)
# table(dice(10^5, sides = 5))
# 
# # Set dice:
# dice(5, sides = 2:3)
# dice(5, sides = c(2, 4, 6))
# 
# # Note:
# dice(10, 1)  # always yields 1
# table(dice(1000, 2))
# 
# # Limits:
# dice(NA)
# dice(0)
# dice(1/2)
# dice(2:3)
# dice(10, sides = NA)
# dice(10, sides = 1/2)
# 
# # Note an oddity:
# dice(n = 10, sides = 3:4)  # works, but 
# dice(n = 10, sides = 4:4)  # odd: see sample() for an explanation.

# dice(NULL, NULL)

# dice_2: n non-random draws from a sample (from 1 to sides): ------ 

#' Throw a questionable dice (with a given number of sides) n times. 
#'
#' \code{dice_2} is a variant of \code{\link{dice}} that 
#' generates a sequence of events that 
#' represent the results of throwing a dice 
#' (with a given number of \code{sides}) \code{n} times.
#' 
#' Something is wrong with this dice. 
#' Can you examine it and measure its problems 
#' in a quantitative fashion?
#' 
#' @param n Number of dice throws.
#' Default: \code{n = 1}. 
#' 
#' @param sides Number of sides.
#' Default: \code{sides = 6}. 
#'
#' @examples 
#' # Basics:
#' dice_2()
#' table(dice_2(100))
#' 
#' # 10-sided dice:
#' dice_2(sides = 10)
#' table(dice_2(100, sides = 10))
#' 
#' # Note:
#' dice_2(10, 1)
#' table(dice_2(5000, sides = 5))
#' 
#' # Note an oddity:
#' dice_2(n = 10, sides = 8:9)  # works, but 
#' dice_2(n = 10, sides = 9:9)  # odd: see sample() for an explanation.
#' 
#' 
#' @family sampling functions
#'
#' @export 

dice_2 <- function(n = 1, sides = 6){
  
  # (a) verify n:
  if (is.null(n)){
    message("dice_2: n must not be NULL. Using n = 1:") 
    n <- 1
  }
  if (length(n) > 1) {  # n is a vector: 
    message(paste0("dice_2: n must be scalar. Using n[1] = ", n[1], ":"))
    n <- n[1]
  }
  
  # Verify that n is a numeric integer > 1:  
  if ((length(n) == 1) && (is.na(n) || !is.numeric(n) || !is.wholenumber(n) || (n < 1) ) ) { 
    message("dice_2: n must be a positive integer. Using n = 1:") 
    n <- 1
  }
  
  # (b) verify sides: 
  if (is.null(sides)){
    message("dice_2: sides must not be NULL. Using sides = 6:") 
    sides <- 6
  }
  
  if (length(sides) > 1) {  # sides is a vector: 
    
    # message(paste0("dice_2: sides is a set. Using it:"))
    
    set_of_sides <- sides
    
  } else {  # sides is a scalar: length(sides) <= 1:
    
    # Verify that sides is a numeric integer > 1:
    if ( is.na(sides) || !is.numeric(sides) || !is.wholenumber(n) || (sides < 1) ) { 
      message("dice_2: sides must be an integer or a set. Using sides = 6:") 
      sides <- 6
    }
    
    set_of_sides <- 1:sides  # default set
    
  }
  
  n_sides <- length(set_of_sides)  # number of sides
  
  ## Weigh events by some probability density distribution:
  # pfac <- # loading factor (0: fair, 1: always final side)
  
  ## Bias for 1 side:
  ptru <- 1/n_sides    # p-values of a fair dice
  bias <- ptru * .075  # (additional) bias of 1 side 
  p_hi <- ptru + bias  # higher p of biased side
  p_lo <- ptru - (bias/(n_sides - 1))  # lower p of all other sides
  pset <- c(rep(p_lo, (n_sides - 1)), p_hi)  # p-values of all sides
  
  sample(x = set_of_sides, size = n, replace = TRUE, prob = pset)
  
} # dice_2 end.

# ## Check:
# # Basics:
# dice_2()
# table(dice_2(10^5))
# 
# # 10-sided dice:
# dice_2(sides = 10)
# table(dice_2(10^6, sides = 10))
# 
# # Set dice:
# table(dice_2(300000, sides = c("A", "B", "C")))
# 
# # Note:
# dice_2(10, 1)
# table(dice_2(2000, 2))
# 
# # Note an oddity:
# dice_2(n = 10, sides = 3:4)  # works, but
# dice_2(n = 10, sides = 4:4)  # odd: see sample() for an explanation.


# Permutations: List all permutations of a set: ----------

# library(combinat)

# set <- c("a", "b", "c")
# pm <- combinat::permn(x = set)
# pm


# Combinations: List all combinations of length n of a set: ---------- 

# # (a) Using utils::combn: 
# m <- utils::combn(x = 1:4, m = 2)
# m
# is.matrix(m)
# t(m)
# is.vector(m)  # if m == length(x)

all_combinations <- function(set, length){
  
  out <- NA  # initialize
  
  # Use utils::combn to obtain matrix:
  m <- utils::combn(x = set, m = length)
  
  if (is.vector(m)){
    
    out <- m  # return as is
    
  } else if (is.matrix(m)){
    
    out <- t(m)  # transpose m into matrix of rows 
    
  }
  
  return(out)
  
} # all_combinations end. 

## Check:
# all_combinations(set = 1:3, length = 4)  # ERROR: n < m
# all_combinations(set = c("a", "b", "c"), 2)
# all_combinations(set = 1:5, length = 2)
# all_combinations(set = 1:25, 2)  # Note: 25 * 24 / 2 combinations.


# Random vector of n symbols of length len from some set: ----- 

random_symbols <- function(n = 1, set = letters, len = 1, sep = "") {
  
  stopifnot(is.numeric(n), n > 0) # check conditions
  
  out <- rep(NA, n) # initialize output vector
  
  for (i in 1:n) {
    
    i_th <- ""  # initialize
    
    for (j in 1:len) {
      
      j_th <- sample(set, 1, replace = TRUE)
      i_th <- paste0(i_th, j_th, sep = sep)
      
    }
    
    out[i] <- i_th
    
  }
  
  return(out)
  
} # random_symbols end. 

## Check:
# random_symbols(n = 10, len = 4)
# random_symbols(n = 10, len = 10)
# random_symbols(n = 10, set = as.character(0:9), len = 4)



## Goal: Adding a random amount (number or proportion) of NA or other values to a vector:

# Adding to data: add_NAs: ----- 

## A function to replace a random amount (a proportion <= 1 or absolute number > 1) 
## of vector elements by NA values:  

add_NAs <- function(vec, amount){
  
  stopifnot((is.vector(vec)) & (amount >= 0) & (amount <= length(vec)))
  
  out <- vec
  n <- length(vec)
  
  amount2 <- ifelse(amount < 1, round(n * amount, 0), amount) # turn amount prop into n
  
  out[sample(x = 1:n, size = amount2, replace = FALSE)] <- NA
  
  return(out)
  
} # add_NAs end. 

## Check:
# add_NAs(1:10, 0)
# add_NAs(1:10, 3)
# add_NAs(1:10, .5)
# add_NAs(letters[1:10], 3)


# Adding to data: add_whats: ----- 

## Generalization of add_NAs: 
## Replace a random amount of vector elements by what: 

add_whats <- function(vec, amount, what = NA){
  
  stopifnot((is.vector(vec)) & (amount >= 0) & (amount <= length(vec)))
  
  out <- vec
  n <- length(vec)
  
  amount2 <- ifelse(amount < 1, round(n * amount, 0), amount) # turn amount prop into n
  
  out[sample(x = 1:n, size = amount2, replace = FALSE)] <- what
  
  return(out)
  
}  # add_whats end. 

## Check:
# add_whats(1:10, 3) # default: what = NA
# add_whats(1:10, 3, what = 99)
# add_whats(1:10, .5, what = "ABC")



## (2) Make tables for plots: ----------

# make_tb: Create (n x n) table tb for plots: --------

make_tb <- function(n = NA, rseed = NA){
  
  tb <- NA  # initialize
  
  # Robustness:
  if (is.na(rseed)) {
    rseed <- sample(1:9999, size = 1, replace = TRUE)  # random rseed
  }
  if (is.na(n)) {
    n <- sample(1:12, size = 1, replace = TRUE)  # random n
  }
  
  # Parameters:
  n_x <- n
  n_y <- n
  N   <- (n_x * n_y)
  set.seed(seed = rseed)  # for reproducible randomness
  
  # Vectors:  
  # (a) sorted: 
  v_sort <- 1:N         # Tile: top_left = seeblau, bottom_right = black   | Polar: outer = seeblau, center = black.
  # v_sort <- rev(1:N)  # Tile: top_left = black,   bottom_right = seeblau | Polar: outer = black, center = seeblau.
  
  # Colors of text labels:
  col_sort <- rep("white", N)  # default
  lim_black <- .25  # threshold to switch from "white" to "black" labels
  col_sort[(v_sort > (lim_black * N)) & 
             (v_sort <= ((1 - lim_black) * N))] <- "black"  # switch to "black" in mid of range
  # table(col_sort)
  
  # (b) random: 
  # v_rand <- runif(n = N, 0, 1)
  rand_ord <- sample(v_sort, N)   # random permutation of v_sort
  v_rand   <- rand_ord            # random permutation of v_sort
  col_rand <- col_sort[rand_ord]  # corresponding colors
  
  # x and y vectors: 
  x_vec <- rep(1:n_y, times = n_x)
  y_vec <- rep(n_x:1, each = n_y)
  
  # # (a) as tibble: 
  # tb <- tibble::tibble(x = x_vec,
  #                      y = y_vec,
  #                      sort = v_sort,
  #                      rand = v_rand,
  #                      col_sort = col_sort,
  #                      col_rand = col_rand)
  
  # (b) as data frame: 
  tb <- data.frame(x = x_vec,
                   y = y_vec,
                   sort = v_sort,
                   rand = v_rand,
                   col_sort = col_sort,
                   col_rand = col_rand, 
                   stringsAsFactors = FALSE)
  
  return(tb)
  
} # make_tb end. 

## Check: 
# make_tb(n = 3)
# make_tb(n = 5, rseed = 1)  # check rseed
# make_tb(n = 5, rseed = 1)


# make_tbs: Create simpler (1 x n) table tbs for plots: --------

make_tbs <- function(n = NA, rseed = NA){
  
  tbs <- NA  # initialize
  
  # Robustness:
  if (is.na(rseed)) {
    rseed <- sample(1:9999, size = 1, replace = TRUE)  # random rseed
  }
  if (is.na(n)) {
    n <- sample(1:12, size = 1, replace = TRUE)  # random n
  }
  
  # Parameters:
  n_x <- n
  n_y <- 1  # only 1 column/row 
  N   <- (n_x * n_y)
  set.seed(seed = rseed)  # for reproducible randomness
  
  # Vectors:  
  # (a) sorted: 
  v_sort <- 1:N         # Tile: top_left = seeblau, bottom_right = black   | Polar: outer = seeblau, center = black.
  # v_sort <- rev(1:N)  # Tile: top_left = black,   bottom_right = seeblau | Polar: outer = black, center = seeblau.
  
  # Colors of text labels:
  col_sort <- rep("white", N)  # default
  lim_black <- .25  # threshold to switch from "white" to "black" labels
  col_sort[(v_sort > (lim_black * N)) & 
             (v_sort <= ((1 - lim_black) * N))] <- "black"  # switch to "black" in mid of range
  # table(col_sort)
  
  # (b) random: 
  # v_rand <- runif(n = N, 0, 1)
  rand_ord <- sample(v_sort, N)   # random permutation of v_sort
  v_rand   <- rand_ord            # random permutation of v_sort
  col_rand <- col_sort[rand_ord]  # corresponding colors
  
  # x and y vectors: 
  x_vec <- 1:n_x 
  y_vec <- rep(1, n_x)
  
  # # (a) as tibble: 
  # tbs <- tibble::tibble(x = x_vec, 
  #                       y = y_vec, 
  #                       sort = v_sort,
  #                       rand = v_rand,
  #                       col_sort = col_sort,
  #                       col_rand = col_rand)
  
  # (b) as data frame: 
  tbs <- data.frame(x = x_vec, 
                    y = y_vec, 
                    sort = v_sort,
                    rand = v_rand,
                    col_sort = col_sort,
                    col_rand = col_rand,
                    stringsAsFactors = FALSE)
  
  return(tbs)
  
} # make_tbs end. 

## Check: 
# make_tbs(n = 6)
# make_tbs(n = 6, rseed = 1)  # check rseed
# make_tbs(n = 6, rseed = 1)



# make_grid: Generate a grid of x-y coordinates (from -x:x to -y:y): ------ 

#' Generate a grid of x-y coordinates. 
#'
#' \code{make_grid} generates a grid of x/y coordinates and returns it 
#' (as a data frame).
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
#' @family data functions
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
  
  # x and y vectors: 
  x_vec <- rep(xs, times = length(ys)) 
  y_vec <- rep(ys, each = length(xs))             
  
  ## (a) as tibble:
  # tb <- tibble::tibble(x = x_vec,
  #                      y = y_vec) 
  
  # (b) as data frame:
  tb <- data.frame(x = x_vec, 
                   y = y_vec,
                   stringsAsFactors = FALSE)
  
  return(tb)
  
}  # make_grid end. 

## Check: 
# make_grid()
# make_grid(x_min = 0, x_max = 0, y_min = 1, y_max = 1)
# Note: 
# make_grid(x_min = 1, x_max = 0, y_min = 2, y_max = 1)
# make_grid(x_min = 1/2, y_min = 1/3)
## Errors: 
# make_grid(x_min = "A")


## ToDo: ----------

# - sample_time variant for sampling normally distributed times?

## eof. ----------------------