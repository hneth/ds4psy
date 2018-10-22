## Final exam  | Data science for psychologists (Summer 2018)
## Name: Lucía Gallego Alonso | Student ID: 01/816081
## 2018 07 16
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## Preparations: ----- 

library(tidyverse)
pt <- 0  # counter for current point total



## Task 1: ----- 

# (a) Save data as tibble and inspect data:
pg <- as_tibble(PlantGrowth)
pg

## Answer: The PlantGrowth data contains 30 cases (rows) and 2 variables (columns). 

## (b): ... 
pg %>%
  summarise(n_group = sum(!is.na(group)))

pg %>%
  summarise(n_weight = sum(!is.na(weight)), 
            mn_weight = mean(weight, na.rm = TRUE),
            md_weight = median(weight, na.rm = TRUE),
            sd_weight = sd(weight, na.rm = TRUE),
            )
## Answer: n_weight mn_weight md_weight sd_weight
##           <int>     <dbl>     <dbl>     <dbl>
##             30      5.07      5.15     0.701

# Missing group_by factor:   group_by(group) %>%

## (c):

ggplot(data = pg) + 
  geom_point(mapping = aes(x = group, y = weight)) +
  geom_boxplot(mapping = aes(x = group, y = weight))

# OK, but plot points after boxplot (to show points before boxes).

pt <- pt + 3  # ok. 


## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## Task 2: 
## (a):

wt <- as_tibble(nycflights13::weather)
wt 
## Answer: The Weather data contains 26,115 cases (rows) and 15 variables (columns). 


## (b):

sum(is.na(wt))
# Answer: SW contains 23974 missing values

sum(is.na(wt)) / sum(!is.na(wt)) * 100

# Answer: The percentage of missing data is 6,52%

# NO: .81 percent (i.e., less than 1%)
#      shorter solution:
mean(is.na(wt))



wt %>%
  summarise(max_year = max(year, na.rm = TRUE),
            min_year = min(year, na.rm = TRUE)
            )
## There is just one value in the year variable: 2013

## (c):

wt %>%
  summarise(n_origin = sum(!is.na(origin)))

wt %>%
  group_by(origin) %>%
  summarise(count = n())
## Answer: The airport EWR has 8703 observations, JFK and LGA have both 8706

## The numbers in the table differ!

## (d):

wt_2 <- mutate(wt, 
       temp_dc = (temp - 32) * 5 / 9)

wt_3 <- select(wt_2, temp_dc, temp, everything())

## (e):
wt_JFK <- filter(wt_3, origin == "JFK")

wt_JFK %>%
  arrange(temp_dc)
##Answer: 3 different dates with the coldest temperature in Celsius: 23/01/2013, 
## 24/01/2013 , 8/05/2013

wt_JFK %>%
  arrange(desc(temp_dc))

##Answer: 3 different dates with the hottest temperature in Celsius: 18/07/2013, 
## 16/07/2013 , 15/07/2013

## (f)
  
wt %>%
  group_by(origin, month) %>%
  summarise(mn_precip = mean(precip, na.rm = TRUE)) %>%
  ggplot() + 
  geom_line(mapping = aes(x = month, y = mn_precip, color = origin))
  
## (g)

wt %>%
  group_by(origin) %>%
  filter(precip > 0.30) %>%
  wt$summer <- isTRUE(wt$month == 4, 5, 6, 7, 8, 9)

# ERROR... 

pt <- pt + 11  # good.

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## Task 3: 
## Load data (as comma-separated file): 
data <- read_csv("http://rpository.com/ds4psy/data/numeracy.csv")

## (a):
data
## data data contains 1000 participants (rows) and 12 variables (columns).
sum(is.na(data)) / sum(!is.na(data)) * 100
## 1.01% of missing values

## (b):

data_birth <- separate(data, bdate, into = c("byear", "bmonth", "bday"), convert = TRUE)
 
## (c):

data_birth$summer_born <- isTRUE(data_birth$bmonth == between(bmonth, 4, 9))

##(d):
today <- as.Date("2018-07-18")

data_a <- mutate(data, 
       age = (today - bdate) / 365)
data_a

## This gives the age in years

## Not quite --- it yields a decimal number... 

## (e):

freq_blood_type <- data %>%
  sum( blood_type == "O+") / sum(!is.na(blood_type)) * 100

data_gender <- group_by(data, gender) %>%
  summarise(Oplus = sum(!is.na(blood_type == "O+")),
            Omin = sum(!is.na(blood_type == "O-")),
            Aplus = sum(!is.na(blood_type == "A+")),
            Amin = sum(!is.na(blood_type == "A-")),
            Bplus = sum(!is.na(blood_type == "B+")),
            Bmin = sum(!is.na(blood_type == "B-")))

tidy_data_gender <- gather(data = data_gender, 
       key = blood, value = cases, 
       `Oplus`:`Bmin`)

spread(data = tidy_data_gender, 
       key = blood, value = cases)

##Answer:
# A tibble: 2 x 7
#       gender  Amin Aplus  Bmin Bplus  Omin Oplus
#      <chr>  <int> <int> <int> <int> <int> <int>
#1     female   531   531   531   531   531   531
#2       male     469   469   469   469   469   469


## Sums are too high... 

##(f)

data %>%
  group_by(gender) %>%
  summarise (n_height = sum(!is.na(height)), 
            mn_height = mean(height, na.rm = TRUE),
            md_height = median(height, na.rm = TRUE),
            sd_height = sd(height, na.rm = TRUE))

# A tibble: 2 x 5
#gender n_height mn_height md_height sd_height
#<chr>     <int>     <dbl>     <int>     <dbl>
 # 1 female      531      161.       161      8.79
#2 male        469      173.       173     11.0 

mutate(data_a,
       cohort = age %/% 10)
# I can´t operate with the variable "age" that I created because it is a time
# variable

##(h):

data_b <- mutate(data,
          BNT = bnt_1 + bnt_2 + bnt_3 + bnt_4)

sum(is.na(data_b$BNT))

##Answer: There are 78 missing values in BNT

##(i):

sum(is.na(data_b$g_iq))
sum(is.na(data_b$s_iq))

# There are 20 missing values in g_iq and 30 in s_iq

data_b %>%
  summarise(mn_g = mean(g_iq, na.rm = TRUE),
            max_g = max(g_iq, na.rm = TRUE),
            min_g = min(g_iq, na.rm = TRUE),
            mn_s = mean(s_iq, na.rm = TRUE),
            max_s = max(s_iq, na.rm = TRUE),
            min_s = min(s_iq, na.rm = TRUE))

# A tibble: 1 x 6
#mn_g max_g min_g  mn_s max_s min_s
#<dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
 # 1  102.  139.   73.  102.  131.   70.

ggplot(data_b,aes(g_iq)) +
  geom_histogram(binwidth = 5)


ggplot(data_b,aes(s_iq)) +
  geom_histogram(binwidth = 5)

##(j):

ggplot(data_b,aes(s_iq, g_iq)) +
  geom_point()


ggplot(data_b,aes(s_iq, g_iq)) +
  geom_smooth(method = lm)

#The plots show a equal distribution in both variables. 
# Both have a normal distribution with the peak around 100

##(k):

data_b %>%
  group_by(gender) %>%
  summarise (mn_BNT = mean(BNT, na.rm = TRUE),
             sd_BNT = sd(BNT, na.rm = TRUE))

# The mean in the Berlin Numeracy Test is higher
# for women

##(l): 

## ???

pt <- pt + 25  # minor errors, some graphs a bit simple, but otherwise ok.


## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## Task 4: 
library(readxl)
refugees <- read_excel("Desktop/refugees.xlsx")
View(refugees)
#The dataset correspond to the wikipedia data of https://en.wikipedia.org/wiki/List_of_countries_by_refugee_population 
#By_country_of_asylum

table <- refugees %>%
  filter(refug_percent > 1)
# I exclude the countries with less percentage of refugees to work with a more manageable amount of data


ggplot(data = table) + 
  geom_boxplot(mapping = aes(x = Country, y = refug_percent))

table %>%
  mutate(increase = `r_2014 ` - `r_2006 `)

pt <- pt + 3  # A bit sparse, but good effort.

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## Points: 42/50.
## Grade:  1.7 - Well done!

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## By submitting this script I assure that I have completed this 
## script by myself (using only permissible sources of help). 

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## End of file. ----- 