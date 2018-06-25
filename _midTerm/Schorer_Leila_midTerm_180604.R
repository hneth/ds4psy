## Mid-term exam  | Data science for psychologists (Summer 2018)
## Name: Leila Schorer | Student ID: 01/948611
## 2018 06 04
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## Preparations: ----- 

library(tidyverse)


## Task 1: ----- 

## (a) Saving and inspecting data:
sp <- as_tibble(sleep)
dim(sp)

## Answer: The sleep data contains 20 rows and 3 columns. 

## (b): ... 
?sleep
sp
sp %>%
  group_by(group) %>%
  summarise(count = n(),
            mn = mean(extra),
            md = median(extra),
            sd = sd(extra))

## Answer:Number of observations ia 10 per group (drug given or not), mean of group 1 
#         is 0.75, median is 0.35, standard deviation is 1.79 of group one. Of group two the mean is 2.33, the median
#         is 1.75 and the standard deviation is 2.00
# A tibble: 2 x 5
# group count    mn    md    sd
# <fct> <int> <dbl> <dbl> <dbl>
#   1 1        10  0.75  0.35  1.79
# 2 2        10  2.33  1.75  2.00


## (c):

graph_1c <- sp %>%
  group_by(group) %>%
  ggplot(aes(x = group, y = extra)) +
  geom_boxplot() +
  geom_point(position = "jitter")

# Answer: see graph_1c. 

## (d):
sp
sp_wide <- sp %>%
  spread(key = ID, value = extra)

# Answer: This is what it looks like then:
# A tibble: 2 x 11
# group   `1`   `2`   `3`   `4`   `5`   `6`   `7`   `8`   `9`  `10`
# <fct> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#   1 1       0.7  -1.6  -0.2  -1.2  -0.1   3.4   3.7   0.8   0     2  
# 2 2       1.9   0.8   1.1   0.1  -0.1   4.4   5.5   1.6   4.6   3.4



## Task 2 : ----- 
## (a) 

de <- as.tibble(de)

de <- tribble(
  ~Party, ~Share_2013, ~Share_2017,
  # -----|-------------|-----------
  "CDU/CSU", 0.415, 0.33,
  "SPD",  .257, 0.25,
  "Others", NA, NA
)

# Answer: The tibble de now looks like this:

# A tibble: 3 x 3
# Party   Share_2013 Share_2017
# <chr>        <dbl>      <dbl>
#   1 CDU/CSU      0.415       0.33
#2 SPD          0.257       0.25
# 3 Others      NA          NA   


## (b)

de_2 <- de %>%
  gather(`Share_2013`, `Share_2017`, key = "year", value = "share")

de_2

# Answer: The "tidy" table de_2 now looks like this:

# A tibble: 6 x 3
# Party   year        share
# <chr>   <chr>       <dbl>
#   1 CDU/CSU Share_2013  0.415
# 2 SPD     Share_2013  0.257
# 3 Others  Share_2013 NA    
# 4 CDU/CSU Share_2017  0.33 
# 5 SPD     Share_2017  0.25 
# 6 Others  Share_2017 NA    


## (c):

de_2 %>%
  ggplot(aes(x = year, fill = share)) +
  geom_bar

ggplot(data = de_2, aes(x = year, fill = share)) +
  geom_bar()



## Task 3 : ----- 

## (a):

sw <- as.tibble(dplyr::starwars)
dim(sw)

## Answer: The starwars data contains 87 rows and 13 columns. 


## (b):

sum(is.na(sw))

## Answer: There a re 101 missing values.

sw %>%
  filter(is.na(homeworld), !is.na(mass) | !is.na(birth_year))

## Answer: Yoda, IG-88 and Qui-~ come from an unkown 
#          homeworld but have known a birth year and mass


## (c):

sw %>%
  filter(species == "Human") %>%
  group_by(gender) %>%
  summarise(count = n())

## Answer: There are 9 females and 26 male humans
#          and so there are 35 humans overall.


sw %>%
  filter(gender != "female", gender != "male") %>%
  count()

View(sw)

 
## Answer: There are 3 individuals that are neither female nor male
#           and they are calles C-3PO, R2-D2, R5-D4


sw %>%
  filter(gender == "female", gender == "male")


# (d) 

sw %>%
  group_by(homeworld) %>%
  count() %>%
  arrange(desc(n))

## Answer: The most individuals come from Naboo

sw %>%
  filter(homeworld == "Naboo", eye_color == "orange") %>%
  summarise(count = n(),
            mn_height = mean(height))
  
## Answer: The mean height from individuals from Naboo (the most popular homeworld)
#          is 209cm.


# (e)

sw %>%
  filter(species == "Droids") %>%
  summarise(count = n(),
            mn_height = mean(height, na.rm = TRUE),
            md_height = median(height, na.rm = TRUE),
            sd_height = sd(height, na.rm = TRUE))

# Answer: The output is NA

h_m <- sw %>%
  group_by(species) %>%
  summarise(count = n(),
            mn_height = mean(height),
            mn_mass = mean(mass),
            na.rm = TRUE)
h_m

# Answer: h_m is the summarised height and mass by species.

h_m %>%
  arrange(mn_height)

## Answer: The 3 smallest species are Yoda's species, Aleena and Ewok.

h_m %>%
  arrange(desc(mn_mass))

## Answer: The 3 heaviest species are Hutt, Kaleesh and Wookiee.


## Task 4: -----

# (a)

tribble(
  ~stock, ~d1_start, ~d1_end, ~d2_start, ~d2_end, ~d3_end, ~d3_start, ~d3_end,
  # -----|-----------|-------|----------|--------|--------|----------|---------
  "Amada", 2.5, 3.6, 3.5, 4.2, 4.4, 2.8,
  "Betix", 3.3, 2.9, 3.0, 2.1, 2.3, 2.5,
  "Cevis", 4.2, 4.8, 4.6, 3.1, 3.2, 3.7)

# Error..

## Task 5: ----

# (a)
ir <- as.tibble(datasets::iris)

sum(is.na(ir))

# Answer: No, there are no missing values.

# (b)
im1 <- ir %>%
  group_by(Species) %>%
  summarise(mn_spl_length = mean(Sepal.Length),
          mn_spl_width = mean(Sepal.Width),
          mn_ptl_length = mean(Petal.Length),
          mn_ptl_width = mean(Petal.Width))

im1

## Answer: im1 shows the means of the 3 measrement columns for each of the 3 species.

# (c)

# Problem with the iris data: 

im1 %>%
  ggplot(aes(x = mn_spl_width)) +
  geom_histogram(aes(colour = Species), binwidth  = 0.1)

# (d)

im1 %>%
  ggplot(aes(x = mn_spl_width)) +
  geom_freqpoly(aes(colour = Species), binwidth = 0.1)




## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## End of file. ----- 