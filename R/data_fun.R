## data_fun.R | ds4psy
## hn | uni.kn | 2019 07 28
## ---------------------------

## Functions for creating and manipulating data. 

## (1) Generating random datasets: ---------- 

# Random binary values: Flip a 0/1 coin n times  ------ 

random_bin_value <- function(x = c(0, 1), n = 1, replace = TRUE) {
  
  if (length(x) != 2) {
    warning("x should be binary.")
  }
  
  sample(x = x, size = n, replace = replace)  
  
}

## Check: 
# random_bin_value(n = 10)
# random_bin_value(x = c("m", "f"), n = 100)


# Permutations: List all permutations of a set ----------

# library(combinat)

# set <- c("a", "b", "c")
# pm <- combinat::permn(x = set)
# pm


# Combinations: List all combinations of length n of a set ---------- 

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


# n random sequence of len symbols from some set: ----- 

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

# add_NAs: ----- 

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


# add_whats: ----- 

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




## (2) Tables for plots: ----------

# make_tb: Create tb for plots: --------

make_tb <- function(n = NA, rseed = NA){
  
  tb <- NA  # initialize
  
  # Robustness:
  if (is.na(rseed)) {
    rseed <- sample(1:999, size = 1, replace = TRUE)  # random rseed
  }
  if (is.na(n)) {
    n <- sample(1:10, size = 1, replace = TRUE)  # random n
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
  
  # Tibble: 
  tb <- tibble::tibble(x = rep(1:n_y, times = n_x),
                       y = rep(n_x:1, each = n_y),
                       sort = v_sort,
                       rand = v_rand,
                       col_sort = col_sort,
                       col_rand = col_rand)
  
  return(tb)
  
}

## Check: 
make_tb(n = 3)

## Check rseed: 
# make_tb(n = 5, rseed = 1)
# make_tb(n = 5, rseed = 1)

## ToDo: ----------

## eof. ----------------------