
## Final exam  | Data science for psychologists (Summer 2018)
## Name:Ionela Raducanu | Student ID:875673
## 2018 07 16
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## Preparations: ----- 

library(tidyverse)

## Task 1: ----- 

# (a) Save data as tibble and inspect data:
pg <- as_tibble(PlantGrowth)
pg

## Answer: The PlantGrowth data contains 30 cases (rows) and 2 variables (columns). 

## (b):
pg_01 <- pg %>%
  group_by(group) %>%
  summarise(mean = mean(weight),
            median = median(weight),
            std = sd(weight))


## (c):
ggplot(data = pg, aes(weight, color = group)) + 
  geom_histogram() + 
  geom_bar()




## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## Task 2: ----- 
## (a) 
wt <- as_tibble (nycflights13::weather)
## Answer: The nycflights13::weather data contains 26,130 cases (rows) and 15 variables (columns). 


## (b): 
is.na(wt)
sum(is.na(wt))
## Answer: 3157


mean(is.na(wt))
## Answer: 0,08%


wt %>%
  summarise(min = min(year),
            max = max(year)
            )
## Answer: min = 2013  max = 2013

## (c)
wt %>%
  group_by(origin) %>%
  summarise(cout = n()
            )

## (d)
wt_2 <- select(wt, temp)

wt_2 %>%
  mutate(temp_dc = ( temp ??? "32") × "5"/"9"))


## (e)
wt_JFK <- filter(wt, origin == "JFK")

wt_JFK %>%
  arrange(temp)
## Answer: The coldest temperatures are 12.0, 12.9, 13.1

wt_JFK %>%
  arrange(desc(temp))
## Answer: The hottest temperatures are: 98.1, 97.0, 96.1


## (f)
wt_origin <- 
  wt %>%
  group_by(origin) %>%
  summarise(means = mean(month)
            )

mean_plot <- 
  ggplot(wt_origin, aes(x = means)) + 
  geom_line()


## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## Task 3: ----- 

data <- read_csv("http://rpository.com/ds4psy/data/numeracy.csv")

## (a) 
data_b <- data
## Answer: Data_b contains 1,000 cases (rows) and 12 variables (columns)

## (b)
data_b_1<- separate(data_b, bdate, c("byear", "bmonth", "bday"))

## (c)
data_b_1%>%
  unite("summer_born", bmonth, c(04, 09), remove = TRUE)

data_b_1%>%
  unite("summer_born", bmonth, c(10, 12), remove = FALSE)

## (f)
data_b2 <- data_b %>%
  group_by(gender) %>%
  summarise(median = median(height),
            std = sd(height),
            counts = count(height))


data_b %>%
  group_by(bdate) %>%
  summarise(median = median(height),
            std = sd(height),
            counts = count(height))


## (e)

data_b_boold <- 
  data_b %>%
  group_by(gender) %>%
  summarise(blood_type = frequency(blood_type))

gather(data = data_b_boold, 
       key = blood_type, value = gender)

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##


## Task 4 : ----- 

## https://en.wikipedia.org/wiki/List_of_most_common_surnames_in_Europe
# Statistic of the Czech Republic surnames

tribble <- tibble(
  ~Rank,  ~Name,                ~Meaning,         ~Number of males, ~Number of females,
  #----|--------------------|---------------------|----------------|------------------|
    1,    "Novák/Nováková",     "new man/woman",  	34.168,	          35.558,
    2,    "Svoboda/Svobodová",  "freeholder"	      25.292,          26.569,
    3,    "Novotný/Novotná",    "newman",	          24.320,           25.328,
    4,    "Dvorák/Dvoráková",   "grange owner",     22.299,	          23.445,
    5,    "Cerný/Cerná",        "black man/woman",  17.813,           18.504,
    6,    "Procházka/Procházková", "walker",	      16.074,	          16.81,
    7,    "Kucera/Kucerová",    "curly man/woman",	15.187,	          15.689,
    8,    "Veselý/Veselá",    "cheerful,merry man/woman",	12.882,     13.494,
    9,    "Horák/Horáková",   "highlander",	        12.165,          12.796,
    10,   "Nemec/Nemcová",     "German",	          11.192,         	11.563     )


## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## By submitting this script I assure that I have completed this 
## script by myself (using only permissible sources of help). 

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## End of file. ----- 