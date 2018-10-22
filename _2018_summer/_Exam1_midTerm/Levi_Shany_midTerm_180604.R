## Mid-term exam  | Data science for psychologists (Summer 2018)
## Name: SHANY LEVI | Student ID: 01/874535
## 2018 06 04
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## Preparations: ----- 

library(tidyverse)

## Task 1: -----

## (a) Saving and inspecting data:
sp <- as_tibble(sleep)
dim(sp)

## Answer: The sleep data contains 20 rows and 3 columns. 

## (b)  compute the number of observations (rows) by group and key descriptives (their mean, median, and standard deviation).

sp

sp %>%
  group_by(ID) %>%
  summarise(n = n(),
            mn_s = mean(extra),
            sd_s = sd (extra),
            md_s = median (extra))

## (C) Use ggplot to create a graph that shows the medians and raw values of extra sleep time by group

sp_c <- sp %>%
  group_by(ID, group, extra) %>%
  summarise(n = n(),
            mn_s = mean(extra),
            sd_s = sd (extra),
            md_s = median (extra))


ggplot(data = sp_c ) + 
  geom_point(mapping = aes(x = md_s, y= extra, color = group))
             
## (D)  Reformat the sleep data in sp so that the 2 groups appear in 2 lines (rows) and 10 subject IDs as 10 columns

sp

tidyr::spread

spread(sp, key = ID, value = extra)


  

## Task 3 -----

dplyr::starwars
  
# (a) Save the tibble dplyr::starwars as sw and report its dimensions

tb <- as_tibble(starwars) 
  
tb

## answer :  The starwars contains 87 rows and 13 columns

# (b) How many missing (NA) values does sw contain


sum(is.na(tb))

## answer: 101

tb %>%
 filter(is.na(homeworld), !is.na(mass) | !is.na(birth_year)) 

## answer: Yoda, IG-88, Qui-Gon

# (c) How many humans are contained in sw overall and by gender?


tb %>%
  filter(species == "Human") %>%
  group_by(gender) %>%
  count()


## answer: 25

# How many and which individuals in sw are neither male nor female?


tb %>%
  filter(gender == 'male' | gender == 'female') %>%
  count()

## answer: 6, include NA

# Of which species in sw exist at least 2 different gender values?

tb %>%
  group_by(species) %>%
  filter(gender == 'male', gender == 'female')

# (d) From which homeworld do the most indidividuals (rows) come from?

tb %>%
  group_by(homeworld) %>%
  count() %>%
  arrange(desc(n))


# asnwer: Naboo

# What is the mean height of all individuals with orange eyes from the most popular homeworld

tb %>%
  filter(homeworld == "Naboo") %>%
  group_by(eye_color == "orange") %>%
  summarise(n = n(),
            mn_h = mean(height))

# answer: 163

# (e) Compute the median, mean, and standard deviation of height for all droids

tb %>%
  group_by(name) %>%
  summarise(n = n(),
            mn_s = mean(height, na.rm = TRUE),
            sd_s = sd (height, na.rm = TRUE),
            md_s = median (height, na.rm = TRUE))

?starwars

# Compute the average height and mass by species and save the result as h_m

h_m <- tb %>%
  group_by(species) %>%
  summarise(n = n(),
            mn_h = mean(height, na.rm = TRUE),
            mn_m = mean(mass,  na.rm = TRUE))
 
# Sort h_m to list the 3 species with the smallest individuals (in terms of mean height)

h_m %>%
  arrange(mn_h)

# Sort h_m to list the 3 species with the heaviest individuals (in terms of median mass

h_m %>%
  arrange(desc(mn_m))


## Task 5 -----

iris

# (a) 

ir <- as_tibble(iris)

ir

sum(is.na(ir))

# answer: no

# (c) Create a histogram that shows the distribution of Sepal.Width values across all species

ggplot(data = ir) +
  geom_histogram(mapping = aes(x = Sepal.Width), binwidth = 0.5)

# (d) Create a plot that shows the shape of the distribution of Sepal.Width values for each species