## Mid-term exam  | Data science for psychologists (Summer 2018)
## Name: Raducanu Ionela | Student ID: 875673
## 2018 06 04
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## Preparations: ----- 

library(tidyverse)


## Task 1: ----- 

## (a) Saving and inspecting data:
sp <- as_tibble(sleep)
dim(sp)

## Answer: The sleep data contains 20 rows and 3 columns. 


## (c): 
ggplot(data = sleep, mapping = aes(x = extra, y = group) + 
geom_point()
geom_bloxplot()

## (d): 

sp <- spread(sleep, key = ID, value = group)



## Task 2: ----- 
## (a) 

de <- tbl(
  ~Party, ~Share 2013, ~Share 2017,
  "Party", "cDU/CSU"", "SPD", "Others""
  "Share 2013", 41.5, 27.5, NA
  "Share 2017", 33, 20.5, NA
)

(b): 


## Task 3: ----- 
## (a)
sp <- as_data_frame(starwars)



#Answer : The starwars tibble contains  87 rows and 13 columns

##(b) 
is.na(sp)


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

## Task 5: 

#(a): 
> ir <- as_data_frame(iris)
> dim(ir)
# Answer : The ir data contains 150 rows and 5 columns



## Task 6: 
#(a): 
# Answer : the tibble data contains 1000 rows and 3 columns

##(b)
is.na(data)

## (d)
ggplot(data = data) + 
  geom_point(mapping = aes(x = height, y = sex))

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## End of file. ----- 