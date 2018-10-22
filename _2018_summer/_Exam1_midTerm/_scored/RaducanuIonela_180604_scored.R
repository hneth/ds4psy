## Mid-term exam  | Data science for psychologists (Summer 2018)
## Name: Raducanu Ionela | Student ID: 875673
## 2018 06 04
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## Preparations: ----- 

library(tidyverse)
pt <- 0 # initialize point score


## Task 1: ----- 

## (a) Saving and inspecting data:
sp <- as_tibble(sleep)
dim(sp)

## Answer: The sleep data contains 20 rows and 3 columns. 


## (c): 
ggplot(data = sleep, mapping = aes(y = extra, x = group)) + 
  geom_boxplot() + 
  geom_point()

# Made some minor adjustments...

## (d): 

sp <- spread(sleep, key = ID, value = group)

# Try: 
spread(sp, key = ID, value = extra)


pt <- pt + 4  # ok!


## Task 2: ----- 

## (a)

de <- tbl(
  ~Party, ~Share 2013, ~Share 2017,
  "Party", "cDU/CSU"", "SPD", "Others""
  "Share 2013", 41.5, 27.5, NA
  "Share 2017", 33, 20.5, NA
)

# Minor adjustments:
de <- tibble(
  party = c("CDU/CSU", "SPD", "Others"), 
  "Share 2013" = c(41.5, 27.5, NA), 
  "Share 2017" = c(33, 20.5, NA)
  )
de


# (b) 

pt <- pt + 1  # Check tibble() vs. tribble() commmands.


## Task 3: ----- 

## (a)
sp <- as_data_frame(starwars)
# sp

# Why as data frame?  (The starwars data already is a tibble).

# Answer : The starwars tibble contains  87 rows and 13 columns

## (b) 
is.na(sp)

# Try 
sum(is.na(sp)) # => 101 cases of NA.

pt <- pt + 2



## Task 4: ----- 
## (a) 

st <- tibble(
  stock = Amada, Betix, Cevis
  d1_start = 2.5, 3.3, 4.2, 
  d1_end = 3.6, 2.9, 4.8,
  d2_start = 3.5, 3.0, 4.6, 
  d2_end = 4.2, 2.1, 3.1, 
  d3_start = 4.4, 2.3, 3.2
  d3_end = 2.8, 2.5, 3.7
)
# Good try, but note:
# tibble requires vectors [constructed with c(...)]
# use tribble with comma-separated values.

pt <- pt + 1

## Task 5: 

#(a): 
ir <- as_data_frame(iris)
dim(ir)
# Answer : The ir data contains 150 rows and 5 columns

# To get a tibble, try 
as_tibble(iris)

pt <- pt + 1

## Task 6: 

## Load data:
data <- read_csv("http://rpository.com/ds4psy/mt/out.csv")  # from online source

# (a): 
# Answer : the tibble data contains 1000 rows and 3 columns

# True, but show dim(data).

##(b)
is.na(data)

# Try
sum(is.na(data)) # => 18 

## (d)
ggplot(data = data) + 
  geom_point(mapping = aes(x = height, y = sex))

# Good attempt, but clearer would be:
ggplot(data, aes(x = height, fill = sex)) +
  facet_wrap(~sex) +
  geom_histogram(binwidth = 5)

pt <- pt + 2

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

# Total of 11 points (out of 50).
# Grade: 2.7. Not bad, but with room for improvement...  

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## End of file. ----- 

