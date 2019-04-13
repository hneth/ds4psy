## custom_functions.R | ds4psy
## hn | uni.kn | 2019 04 13
## ---------------------------

## (1) Graphics: ---------- 

## Defining colors:

## WAS: 
# seeblau <- rgb(0, 169, 224, names = "seeblau", maxColorValue = 255) # seeblau.4 (non-transparent)
# 
# seeblau.colors <- c(rgb(204, 238, 249, maxColorValue = 255), # seeblau.1
#                     rgb(166, 225, 244, maxColorValue = 255), # seeblau.2 
#                     rgb(89, 199, 235, maxColorValue = 255),  # seeblau.3
#                     rgb(0, 169, 224, maxColorValue = 255),   # seeblau.4 
#                     rgb(0, 0, 0, maxColorValue = 255),       #  5. black
#                     gray(level = 0, alpha = .6),             #  6. gray 60% transparent
#                     gray(level = 0, alpha = .4),             #  7. gray 40% transparent
#                     gray(level = 0, alpha = .2),             #  8. gray 20% transparent
#                     gray(level = 0, alpha = .1),             #  9. gray 10% transparent
#                     rgb(255, 255, 255, maxColorValue = 255)  # 10. white
# )
# 
# unikn.pal = data.frame(                             ## in one df (for the yarrr package): 
#   "seeblau1" = rgb(204, 238, 249, maxColorValue = 255), #  1. seeblau1 (non-transparent)
#   "seeblau2" = rgb(166, 225, 244, maxColorValue = 255), #  2. seeblau2 (non-transparent)
#   "seeblau3" = rgb( 89, 199, 235, maxColorValue = 255), #  3. seeblau3 (non-transparent)
#   "seeblau4" = rgb(  0, 169, 224, maxColorValue = 255), #  4. seeblau4 (= seeblau base color)
#   "black"    = rgb(  0,   0,   0, maxColorValue = 255), #  5. black
#   "seegrau4" = rgb(102, 102, 102, maxColorValue = 255), #  6. grey40 (non-transparent)
#   "seegrau3" = rgb(153, 153, 153, maxColorValue = 255), #  7. grey60 (non-transparent)
#   "seegrau2" = rgb(204, 204, 204, maxColorValue = 255), #  8. grey80 (non-transparent)
#   "seegrau1" = rgb(229, 229, 229, maxColorValue = 255), #  9. grey90 (non-transparent)
#   "white"    = rgb(255, 255, 255, maxColorValue = 255), # 10. white
#   stringsAsFactors = FALSE)

# NEW:
library(unikn)  # from dedicated package

unikn.pal <- unikn::pal_unikn
seeblau <- unikn::pal_unikn[["seeblau3"]]  # 
# seeblau # seeblau3: "#59C7EB"


# pal_n_sq: Get n^2 (n x n) specific colors of a palette [pal]: ------ 

# - Documentation: ---- 

#' Get n^2 dedicated colors of a color palette.
#'
#' \code{pal_n_sq} returns \code{n^2} dedicated colors of a color palette \code{pal} 
#' (up to a maximum of \code{n + 1} colors). 
#' 
#' Note that \code{pal_n_sq} was created for \code{pal = \link{pal_unikn}} 
#' for small values of \code{n} (\code{n = 1, 2, 3}) and 
#' returns the 11 colors of \code{\link{pal_unikn_plus}} for any \code{n > 3}. 
#' 
#' Use the more specialized function \code{use_pal_n} for choosing 
#' \code{n} dedicated colors of a known color palette. 
#' 
#' @param n A number specifying the desired number colors of pal (as a number) 
#' or the character string \code{"all"} (to get all colors of \code{pal}). 
#' Default: \code{n = "all"}. 
#'
#' @param pal A color palette (as a data frame). 
#' Default: \code{pal = \link{pal_unikn}}. 
#'
#' @examples
#' # pal_n_sq(1) #  1 color: seeblau3
#' # pal_n_sq(2) #  4 colors
#' # pal_n_sq(3) #  9 colors (5: white)
#' # pal_n_sq(4) # 11 colors of pal_unikn_plus (6: white)
#' 
#' @family color palettes
#'
#' @seealso
#' \code{\link{seecol}} to plot color palettes; 
#' \code{\link{usecol}} to use color palettes; 
#' \code{\link{pal_unikn}} for the default uni.kn color palette. 
#' 
#' 

# - Definition: ---- 

pal_n_sq <- function(n = "all", pal = pal_unikn){
  
  # handle inputs:
  stopifnot(length(pal) > 0)
  
  if (is.character(n) && tolower(n) == "all") { n <- length(pal) }
  stopifnot(is.numeric(n))
  stopifnot(n > 0)
  
  out <- NA    # initialize
  
  if (n == 1) {
    
    out <- pal[3]  #  1 preferred color: seeblau3
    
  } else if (n == 2) {
    
    out <- pal[c(2, 4, 6, 10)]  #  4 colors: seeblau4, seeblau2, white, grey
    
  } else if (n == 3) {
    
    out <- pal[-7]  #  9 colors: seeblau > white > black
    
  } else { # n > 3: 9+ colors: 
    
    if (isTRUE(all.equal(pal, pal_unikn))) {
      
      # out <- pal[c(1:2, 2:10)]   # 11 colors: seeblau (seeblau.3: 2x) > white (6 = mid) > black (11) [default]  
      
      out <- pal_unikn        # 11 colors: seeblau.5 > white (6 = mid) > black (11)  
      
    } else { # any other pal:
      
      out <- pal
      
    }
    
  } # if (n == etc.)
  
  return(out)
  
}


## (2) Generating random datasets: ---------- 
  
## Random binary values: Flip a 0/1 coin n times  ------ 

random_bin_value <- function(x = c(0, 1), n = 1, replace = TRUE) {
  
  if (length(x) != 2) {
    warning("x should be binary.")
  }
  
  sample(x = x, size = n, replace = replace)  
  
}

## Check: 
# random_bin_value(n = 10)
# random_bin_value(x = c("m", "f"), n = 100)


## Permutations: List all permutations of a set ----------

# library(combinat)

# set <- c("a", "b", "c")
# pm <- combinat::permn(x = set)
# pm


## Combinations: List all combinations of length n of a set ---------- 

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
  
}

## Check:
# all_combinations(set = 1:3, length = 4)  # ERROR: n < m
# all_combinations(set = c("a", "b", "c"), 2)
# all_combinations(set = 1:5, length = 2)
# all_combinations(set = 1:25, 2)  # Note: 25 * 24 / 2 combinations.


## n random sequence of len symbols from some set: ----- 

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
}

## Check:
# random_symbols(n = 10, len = 4)
# random_symbols(n = 10, len = 10)
# random_symbols(n = 10, set = as.character(0:9), len = 4)



## Goal: Adding a random amount (number or proportion) of NA or other values to a vector:

## add_NAs: ----- 

## A function to replace a random amount (a proportion <= 1 or absolute number > 1) 
## of vector elements by NA values:  

add_NAs <- function(vec, amount){
  
  stopifnot((is.vector(vec)) & (amount >= 0) & (amount <= length(vec)))
  
  out <- vec
  n <- length(vec)
  
  amount2 <- ifelse(amount < 1, round(n * amount, 0), amount) # turn amount prop into n
  
  out[sample(x = 1:n, size = amount2, replace = FALSE)] <- NA
  
  return(out)
  
}

## Check:
# add_NAs(1:10, 0)
# add_NAs(1:10, 3)
# add_NAs(1:10, .5)
# add_NAs(letters[1:10], 3)


## add_whats: ----- 

## Generalization of add_NAs: 
## Replace a random amount of vector elements by what: 

add_whats <- function(vec, amount, what = NA){
  
  stopifnot((is.vector(vec)) & (amount >= 0) & (amount <= length(vec)))
  
  out <- vec
  n <- length(vec)
  
  amount2 <- ifelse(amount < 1, round(n * amount, 0), amount) # turn amount prop into n
  
  out[sample(x = 1:n, size = amount2, replace = FALSE)] <- what
  
  return(out)
  
}

## Check:
# add_whats(1:10, 3) # default: what = NA
# add_whats(1:10, 3, what = 99)
# add_whats(1:10, .5, what = "ABC")




## (3) Counters: ---------- 

nr <- 0  # task number
pt <- 0  # point total


## ToDo: ----------

## eof. ----------------------