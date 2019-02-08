## custom_functions.R | ds4psy
## hn | uni.kn | 2019 02 08
## ---------------------------

## (1) Graphics: ---------- 

## Defining colors:
seeblau <- rgb(0, 169, 224, names = "seeblau", maxColorValue = 255) # seeblau.4 (non-transparent)

seeblau.colors <- c(rgb(204, 238, 249, maxColorValue = 255), # seeblau.1
                    rgb(166, 225, 244, maxColorValue = 255), # seeblau.2 
                    rgb(89, 199, 235, maxColorValue = 255),  # seeblau.3
                    rgb(0, 169, 224, maxColorValue = 255),   # seeblau.4 
                    rgb(0, 0, 0, maxColorValue = 255),       #  5. black
                    gray(level = 0, alpha = .6),             #  6. gray 60% transparent
                    gray(level = 0, alpha = .4),             #  7. gray 40% transparent
                    gray(level = 0, alpha = .2),             #  8. gray 20% transparent
                    gray(level = 0, alpha = .1),             #  9. gray 10% transparent
                    rgb(255, 255, 255, maxColorValue = 255)  # 10. white
)

unikn.pal = data.frame(                             ## in one df (for the yarrr package): 
  "seeblau1" = rgb(204, 238, 249, maxColorValue = 255), #  1. seeblau1 (non-transparent)
  "seeblau2" = rgb(166, 225, 244, maxColorValue = 255), #  2. seeblau2 (non-transparent)
  "seeblau3" = rgb( 89, 199, 235, maxColorValue = 255), #  3. seeblau3 (non-transparent)
  "seeblau4" = rgb(  0, 169, 224, maxColorValue = 255), #  4. seeblau4 (= seeblau base color)
  "black"    = rgb(  0,   0,   0, maxColorValue = 255), #  5. black
  "seegrau4" = rgb(102, 102, 102, maxColorValue = 255), #  6. grey40 (non-transparent)
  "seegrau3" = rgb(153, 153, 153, maxColorValue = 255), #  7. grey60 (non-transparent)
  "seegrau2" = rgb(204, 204, 204, maxColorValue = 255), #  8. grey80 (non-transparent)
  "seegrau1" = rgb(229, 229, 229, maxColorValue = 255), #  9. grey90 (non-transparent)
  "white"    = rgb(255, 255, 255, maxColorValue = 255), # 10. white
  stringsAsFactors = FALSE)


## Logo: ------ 

library(ggplot)
library(cowplot)

# Re-sort palette: 
unikn.2 <- unikn.pal[c(1:4, 10:5)]
unikn.2

# Dimensions:
n_x <- 25
n_y <- n_x
N <- (n_x * n_y)

v1 <- runif(n = N, 0, 1)
v2 <- rev(rev(sort(v1)))

tb <- tibble(y = rep(1:n_x, each = n_y),
             x = rep(1:n_y, times = n_x),
             rand = v1,
             sort = v2)

# Plots:
col_brd <- grey(0, 1)

p_rand <- ggplot(tb) +
  geom_tile(aes(x = x, y = y, fill = rand), col = col_brd) +
  # labs(title = "ds4psy") + 
  coord_fixed() + 
  theme_void() +
  theme(legend.position = "none") +
  # scale_fill_continuous(low = "white", high = seeblau) +
  scale_fill_gradientn(colors = unikn.2)
# p_rand

p_sort <- ggplot(tb) +
  geom_tile(aes(x = x, y = y, fill = sort), col = col_brd) +
  # labs(title = "ds4psy") + 
  coord_fixed() + 
  theme_void() +
  theme(legend.position = "none") +
  # scale_fill_continuous(low = "white", high = seeblau) +
  scale_fill_gradientn(colors = unikn.2)
# p_sort
  
# plot_grid(p_rand, p_sort)



## (2) Generating random datasets: ---------- 
  
## Random binary values: ------ 

random_bin_value <- function(x = c(0, 1), n = 1, replace = TRUE) {
  
  if (length(x) != 2) {
    warning("x should be binary.")
  }
  
  sample(x = x, size = n, replace = replace)  
  
}

## Check: 
# random_bin_value(n = 10)
# random_bin_value(x = c("m", "f"), n = 100)
 
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