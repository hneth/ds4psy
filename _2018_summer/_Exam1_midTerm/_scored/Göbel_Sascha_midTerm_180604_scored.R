## Mid-term exam  | Data science for psychologists (Summer 2018)
## Name: Sascha Göbel | Student ID: 01/900472
## 2018 06 04
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## Preparations: ----- 

library(tidyverse)
pt <- 0 # initialize point score


## Task 1: ----- 

## (a) Assign 'sleep' data as a tibble to object 'sp' and inspect dimensions:
sp <- as.tibble(sleep)
dim(sp)
## Answer: The sleep dataset contains 20 rows and 3 columns

## (b) compute number of observations by group and key descriptives for the extra variable:
result_1 <-sp %>%
  group_by(group) %>%
  summarise(obs = n(),
            mean = mean(extra),
            median = median(extra),
            sd = sd(extra))
print(result_1)
## Answer: The sleep dataset contains 2 groups, each with 10 observations, they
##         differ starkly in their discriptives for the extra sleep variable

## (c) create graph with ggplot2 that shows medians and raw values of extra sleeptime by group:
ggplot() +
  geom_point(data = sp, aes(x = group, y = extra, color = group), position = "jitter") +
  geom_point(data = result_1, aes(x = group, y = median))
## Answer: In the plot, groups are additionally differentiated by colors, the respective 
## medians are given in black

## (d)  Reformat the sleep data so that it is in wie format for groups in rows
sp_wide <- sp %>%
  spread(key = ID, value = extra)
print(sp_wide)
## Answer: The sp_wide contains 2 rows, one for each group, and 11 columns, the first indicating 
## the grouping, the rest yielding the extra sleep for each ID in the respective group.

pt <- pt + 6 # excellent!


## Task 2: ----- 

## (a) Create tibble with election shares:
de <- tibble(party = as.factor(c("CDU/CSU", "SPD", "Others")), 
             share2013 = c(41.5, 25.7, 32.8), 
             share2017 = c(33, 20.5, 46.5))
print(de)
## Answer: The tibble de comes with three rows and three columns in wide format
## Btw: "de" is a function name in utils and should not be used as a name for objects

## (b) Convert the dataset de into a "tidy" table:
de_2 <- de %>%
  gather(`share2013`, `share2017`, 
         key = "election_year", 
         value = "share")
print(de_2)
## Answer: The dataset de_2 now contains one column for the grouping (party), one for the 
## election year, and one for the vote share, i.e. long format

## (c) Visualize election results with a stacked bar chart over parties by election:
ggplot(data = de_2, aes(x = election_year, y = share, fill = party)) + 
  geom_bar(stat = "identity")
## Answer: The plot show the party vote shares by election year as a stacked bar chart

pt <- pt + 6 # well done!


## Task 3: ----- 

## (a) Save the tibble dplyr::starwars as sw and report its dimensions:
sw <- starwars
dim(sw)
## Answer: The dataset sw contains 87 rows and 13 columns

## (b) How many missing (NA) values does sw contain? Which individuals come from an 
## unknown (missing) homeworld but have a known birth_year or known mass? :
sw_missings <- sw %>%
  summarise_all(funs(sum(is.na(.)))) %>%
  rowSums()
print(sw_missings)
## Answer: Alltogether the sw dataset contains 101 missing values

# Correct, but there's simpler way:
sum(is.na(sw))

sw_subset_1 <- sw %>%
  filter(is.na(homeworld) & (!is.na(birth_year) | !is.na(mass)))
sw_subset_1
## Answer: Only three observations fulfill this criterion, Yoda, "IG-88, and Qui-Gon Jinn

## (c) How many humans are contained in sw overall and by gender? How many and which individuals in sw are neither male nor female? Of which species in sw exist at least 2 different gender values?:
humans <- sw %>%
  filter(species == "Human") %>%
  group_by(gender) %>%
  summarise(n = n())

print(humans)
sum(humans$n)
## Answer: Overall, there are 35 humans in the sw dataset, 9 female, 26 male

other_gender <- sw %>%
  filter(gender != "male" & gender != "female")
other_gender

print(other_gender[,c(1,8)])
# or: 
other_gender %>% select(1, 8)

## Answer : Only three individuals are neither male nor female, Jabba is a hermaphrodite and
## the other two are droids without a gender attached

## (d) From which homeworld do the most indidividuals (rows) come from? Mean height of all individuals with orange eyes from the most popular homeworld? :
sw %>%
  group_by(homeworld) %>%
  summarise(n = n()) %>%
  arrange(desc(n))
## Answer: The most individuals come from Nabooo, Tatooine or an unknown homeworld

sw %>%
  filter(eye_color == "orange" & homeworld == "Naboo") %>%
  summarise(mean(height))
## Answer the mean height of such individuals is 209 cm or inch, not sure about the scale

## (e) Median, mean, and standard deviation of height for all droids. Sort h_m to list the 3 species with the smallest individuals. Sort h_m to list the 3 species with the heaviest individuals (in terms of median mass).
result_2<- sw %>% 
  filter(species == "Droid") %>%
  summarise(median = median(height, na.rm = TRUE),
            mean = mean(height, na.rm = TRUE),
            sd = sd(height, na.rm = TRUE))
print(result_2)
## Answer median = 123, mean = 140, sd = 52

h_m <- sw %>%
  group_by(species) %>%
  summarise(mean_height = mean(height, na.rm = TRUE),
            mean_mass = mean(mass, na.rm = TRUE))
print(h_m)
arrange(h_m, mean_height)
## Answer: The smalles individuals have a mean height of 66

arrange(h_m, desc(mean_mass))
## Answer: The heaviest individuals have a mean mass of 1358

pt <- pt + 12 # excellent!

## Task 4: ----- 

## (a) Create a tibble st that contains this data in this (wide) format:
st <- tibble(stock = as.factor(c("Amada", "Betix", "Cevis")), 
             d1_start = c(2.5, 3.3, 4.2), 
             d1_end = c(3.6, 2.9, 4.8),
             d2_start = c(3.5, 3.0, 4.6),
             d2_end = c(4.2, 2.1, 3.1),
             d3_start = c(4.4, 2.3,	3.2),
             d3_end = c(2.8, 2.5, 3.7))
st             

# Good, but tribble(...) would have been simpler. 

## (b) Transform st into a longer table st_long that contains 18 rows and only 1 numeric variable for all stock prices. Adjust this table so that the day and time appear as 2 separate columns

## No time, but requires separate

pt <- pt + 2

## Task 5: -----

## (a) save datasets::iris a tibble ir that contains this data and inspect it. Are there any missing values?
ir <- as.tibble(iris)
ir %>%
  summarise_all(funs(sum(is.na(.)))) %>%
  rowSums()
## Answer: Nope, no missings

## (b) Compute a summary table that shows the means of the 4 measurement columns (Sepal.Length, Sepal.Width,  Petal.Length, Petal.Width) for each of the 3 Species (in rows). Save the resulting table of means as a tibble im1 
im1 <- ir %>%
  group_by(Species) %>%
  summarise(mean_sepl = mean(Sepal.Length),
            mean_sepw = mean(Sepal.Width),
            mean_petl = mean(Petal.Length),
            mean_petw = mean(Petal.Width))
print(im1)

## (c) Create a histogram that shows the distribution of Sepal.Width values across all species
ggplot(data = ir, aes(Sepal.Width)) +
  geom_histogram() +
  facet_wrap(~ Species)

pt <- pt + 5  # good.

## Task 6: -----

## (a) Load data (as comma-separated file), Save the data into a tibble data and report its number of observations and variables:
data <- read_csv("http://rpository.com/ds4psy/mt/out.csv")  # from online source
data <- as.tibble(data)
dim(data)
## Answer: 1000 observations, 3 columns

## (b) 
data %>%
summarise_all(funs(sum(is.na(.)))) %>%
  rowSums()
## Answer: 18 missings in data

pt <- pt + 2  # good start.

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

# Total of 33 points (out of 50).
# Grade: 1.3.  Well done! 

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## End of file. ----- 