## Mid-term exam  | Data science for psychologists (Summer 2018)
## Name: Lucía Gallego Alonso | Student ID: 01/816081
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

## (b)
obser <- group_by(sp, extra, group, ID) %>%
  + summarise(obser, mean(obser), median(obser), sqrt(var(obser)))

# correct components, but syntax of pipe is erroneous. 

## (c): ... 
## 
ggplot(data = sleep) + 
    geom_point(mapping = aes(x = extra, y = group)) +
    geom_boxplot(mapping = aes(x = extra, y = group))
 ## We use boxplot because it shows the medians and points for the raw data

## Reverse x and y:
ggplot(data = sleep, aes(x = group, y = extra) ) + 
  geom_boxplot() + 
  geom_point()

##  (d)

spread(sleep, key = group, value = extra)
 
  ##ID    1    2
 1   1  0.7  1.9
 2   2 -1.6  0.8
 3   3 -0.2  1.1
 4   4 -1.2  0.1
 5   5 -0.1 -0.1
 6   6  3.4  4.4
 7   7  3.7  5.5
 8   8  0.8  1.6
 9   9  0.0  4.6
 10 10  2.0  3.4

# The question asked for:  
spread(sleep, key = ID, value = extra)

pt <- pt + 5 # good job!


 
## Task 2: ----- 

## (a) ...

de <- tribble(
   ~x,            ~y,   ~z,
   #----------|-------|------
   "CDU/CSU",  "41.5%", "33%"
   "SPD",      "25.7%", "20.5%"
   "Others",   "?"    ,   "?"
 )

# - Missing commas at end of the line
# - Enter numbers not as characters
#   (instead of "10%", use .10) 

pt <- pt + 1 
 
 
## Task 3: ----- 
## (a) ...
 
 sw <- as_tibble(starwars)
 dim(sw)
 
 # Answer: The starwars data contains 87 rows and 13 colums
   
 ## (b)
 
 sum(is.na(sw))
 # sw contains 101 missing values
 filter(sw, is.na(homeworld))
 #This commands select all the subjects with missing data in homeworld
 
 # Better:
 sw %>% 
   filter(is.na(homeworld), !is.na(mass) | !is.na(birth_year))
  
 ## (c) 
 filter(sw, species == "Human") %>%
    arrange(sw, gender)
 # There are 87 humans
 
 # Almost, try:
 filter(sw, species == "Human") %>%
   group_by(gender) %>%
   count()
 
 gen <- select(sw, gender)
 sum(is.na(gen))
 # There are 3 individuals without gender and one hermaphrodite
 
 pt <- (pt + 4)  # not bad.
 
 ## Task 4: ----- 
 
 ## (a) ...
 tibble(
   +     `Amanda` = "2.5,	3.6,	3.5,	4.2,	4.4,	2.8", 
   +     `Betix` = "3.3, 2.9,	3.0,	2.1,	2.3,	2.5",
   +     `Cevis` = "4.2,	4.8,	4.6,	3.1,	3.2,	3.7"
   + )
 
 # tibbles requires vectors [constructed with c(...)] 
 # Try tribble...  
 
 pt <- (pt + 1) # bad luck.
 
 ## Task 5: ----- 
 ## (a) ...
 ir <- as_tibble(iris)
 sum(is.na(ir))
 # It does not contain missiong values
  # (c)

 ggplot(data = ir) + 
   geom_histogram(mapping = aes(x = Sepal.Width, y = Species))
# Almost, try:
 ggplot(data = ir) + 
   geom_histogram(mapping = aes(x = Sepal.Width))
 
 pt <- (pt + 3) # not bad.
 
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
   
# Total of 14 points (out of 50).
# Grade: 2.7.  Not bad, but with room for improvement.
   
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## End of file. ----- 