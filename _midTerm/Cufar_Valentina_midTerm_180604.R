## Mid-term exam  | Data science for psychologists (Summer 2018)
## Name: Valentina Cufar | Student ID: 01/872180
## 2018 06 04
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## Preparations: ----- 

library(tidyverse)


## Task 1: ----- 

## (a) Saving and inspecting data:
sp <- as_tibble(sleep)
dim(sp)

## Answer: The sleep data contains 20 rows and 3 columns. 

## (b): 
sleep %>%
  group_by(group) %>%
  summarise(count = n(),bmn_group = mean(extra), md_group = median(extra), sd_group = sd(extra))
# group count bmn_group md_group sd_group
#fct> <int>     <dbl>    <dbl>    <dbl>
# 1        10      0.75     0.35     1.79
# 2        10      2.33     1.75     2.00


## (c):
ggplot(sp, aes(x=group, y=extra)) +
       geom_boxplot() +
         geom_point()

## (d):
spread(sp, key = ID, value = extra)

## Task 2 ----- 
## (a)
tribble(
  ~Party, ~Share 2013, ~Share 2017,
  "CDU/CSU", 41.5,       33,   
  "SPD",     25.7,       20.5,      
  "Others",  32.8,       46.5)

1.5 + 25.7
100-67.2
33 + 20.5
100-53.5


## Tasj 3: -----
## (a) 
sw <-  as_tibble (dplyr::starwars)
dim(sw)

# Answer: dplyr::starwars data contains 87 raws and 13 columns.


## (b)
sum(is.na(sw))

# Answer: It contains 101 missing values.
select(sw, world, birth_year, mass) %>%
  filter(homeworld)

sw_homeworld <- select(sw, name, homeworld, birth_year, mass)%>%
  arrange(desc (homeworld))
#  Answer: Yoda, Qui-Gon Jinn, IG-88.

## (c)
sw %>%
  group_by(gender) %>%
  count()
#Answer: There are 19 female and 62 male. That is 81 humans. +1 hermaphrodite.
# Answer: There are 2 that are none, and 1 that is hermaphrodite (which is both).
# Hermaphrodite is Hutt species. 

## (d)


## (e)
starwars %>% 
  group_by(species) %>%
  summarise(med_sp = median(height, na.rm = TRUE),
            me_sp = mean(height, na.rm = TRUE), 
            d_sp = sd(height, na.rm = TRUE))


# Answer: Median = 132, Mean = 140, SD = 52.

h_m <- starwars %>%
  group_by(species) %>%
  summarise(me_height = mean(height, na.rm = TRUE), 
            me_mass = mean(mass, na.rm = TRUE))

## Task 4: -----
# (a)
st <- tribble(
  ~stock, ~d1_start, ~d1_end, ~d2_start, ~d2_end, ~d3_start, ~d3_end,
  "Amada", 2.5,       3.6,      3.5,      4.2,    4.4,        2.8,
  "Betix", 3.3,       2.9,      3.0,      2.1,    2.3,        2.5,
  "Cevis", 4.2,       4.8,      4.6,      3.1,    3.2,        3.7)


## Task 5: -----
## (a)
ir <- as_tibble(iris)
# Answer 150 raws and 5 columns.
sum(is.na(ir))
# Answer: There is no missing values.

(c)
ggplot(ir) +
  geom_histogram(aes(x = Sepal.Width))

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## End of file. ----- 