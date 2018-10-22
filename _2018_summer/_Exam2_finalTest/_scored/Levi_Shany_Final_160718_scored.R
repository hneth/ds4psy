## Final exam  | Data science for psychologists (Summer 2018)
## Name: Shany Levi | Student ID: 01/874535
## 2018 07 16
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## Preparations: ----- 

library(tidyverse)
library(ggplot2) # for plotting (included in tidyverse)
library(data.table)  # WHY?

pt <- 0  # counter for current point total


## Task 1: -----

## (a) Saving and inspecting data:

pg <- as_tibble(PlantGrowth)

pg

## Answer: The sleep data contains 30 rows and 2 columns.


## (b) compute the number of observations (rows) by group and key descriptives:

pg %>%
  group_by(group) %>%
  summarise(n = n(),
            mn_w = mean(weight),
            sd_w = sd (weight),
            md_w = median (weight))

## (c)  create a graph that shows the medians and raw values of plant weight by group:

ggplot(pg, aes(x = group, y = weight, color = group))+
  geom_boxplot()+
  geom_point(alpha = 2/3, size = 4, position = "jitter")

pt <- pt + 5  # excellent!

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##


## Task 2: -----

library(nycflights13)

## (a) Save the tibble and report its dimensions:

wt <- as_tibble(nycflights13::weather)
wt

## Answer: The weather data contains 26,130 rows and 15 columns.


## (b) Missing values and known unknowns:

# -1- How many missing (NA) values does sw contain?

sum(is.na(wt))

## Answer: sw contain 3157 missing values


# -2- What is the percentage of missing (NA) values in wt?

sum(is.na(wt))/(26130 * 15)

0.008054599*100

## Answer: the percentage of missing values is 8.054599e-05


## ok, but quicker:
mean(is.na(wt))

# -3- What is the range (i.e., minimum and maximum value) of the year variable?

# View(wt)

range(wt$year)

## Answer: The range of the year variable is 0. the minimun and the maximum is 2013.


## (c) How many observations (rows) does the data contain for each of the 3 airports (origin)?

group_by(wt, origin) %>%
       count()
       
## Answer:  EWR  8708, JFK 8711, LGA 8711



## (d)  Compute a new variable temp_dc that provides the temperature 
# (in degrees Celsius) that corresponds to temp (in degrees Fahrenheit).

mutate(wt,
       temp_dc = (temp-32) * 5/9)

# Add your new temp_dc variable to a new dataset wt_2 and re-arrange
# its columns so that your new temp_dc variable appears next to temp

wt_2 <- mutate(wt,
       temp_dc = (temp-32) * 5/9) %>%
 select(origin:temp, temp_dc, dewp:time_hour)

wt_2



## (e) When only considering "JFK" airport:
## What are the 3 (different) dates with the (a) coldest and (b) hottest temperatures at this airport?

filter(wt_2, origin == "JFK") %>%
  group_by(temp_dc) %>%
  arrange(temp_dc)


filter(wt_2, origin == "JFK") %>%
  group_by(temp_dc) %>%
  arrange(desc(temp_dc))

## Answer:
## (a) coldest:  23.1.2013: -11.1 , 24.1.2013: -10.6 ,  9.5.2013: -10.5 
## (b) hotest:   18.7.2013: 36.7 ,  16.7.2013: 35.6  ,  15.7.2013: 35


## (f) Plot the amount of mean precipitation by month for each of the 3 airports (origin)
# First use dplyr to compute a table of means (by origin and month). 
# Then use ggplot to draw a line or bar plot of the means.


wt %>%
  group_by(origin, month) %>%
  summarise(n = n(),
            precip_m = mean(precip, na.rm = TRUE)) %>%
  ggplot(wt, mapping = aes(x = month, y = precip_m, color = origin)) + 
  geom_line()


## (g)  For each of the 3 airports:
# When excluding extreme cases of precipitation (specifically, values of precip greater than 0.30):
# Does it rain more during winter months (Oct to Mar) or during summer months (Apr to Sep)?

            
weather_percip <- wt[wt$precip < 0.3, ]  # Why not filter?  

weather_percip$season <- NA
weather_percip$season[weather_percip$month == 10 |weather_percip$month == 11 |weather_percip$month == 12 |weather_percip$month == 1 |weather_percip$month == 2 |weather_percip$month == 3] <- "winter"
weather_percip$season[weather_percip$month == 4 |weather_percip$month == 5 |weather_percip$month == 6 |weather_percip$month == 7 |weather_percip$month == 8 |weather_percip$month == 9] <- "summer"

mean(weather_percip$precip[weather_percip$season == "winter"])
mean(weather_percip$precip[weather_percip$season == "summer"])

## Answer: it rains more in the summer

## Plot the total amount of precipitation in winter vs. summer for each airport

agg <- aggregate(weather_percip$precip, by=list(weather_percip$origin,weather_percip$season), FUN = mean, na.rm=TRUE)

setnames(agg, old = c("Group.1", "Group.2", "x"), new = c("origin", "season", "percip"))


ggplot(agg, aes(x = agg$origin, y=agg$percip))+
  geom_bar(aes(fill = agg$season), position = "dodge", stat = "identity")+
  xlab("origin")+
  scale_y_continuous(name = "precipation")

## ERROR...
           

pt <- pt + 12  # good!


## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
  

## Task 3: -----

data <- read_csv("http://rpository.com/ds4psy/data/numeracy.csv")

data <- read_csv("numeracy.csv")

# View(data)

## (a) Inspect the data dimensions and the percentage of missing values

sum(is.na(data))

## Answer: The data contains 1000 rows and 12 columns, 130 missing values. 


## (b)  Split the birth date (bdate) variable into 3 separate variables (byear, bmonth, and bday)

data_a <- data %>% 
  separate(bdate, into = c("byear", "bmonth","bday"),  convert = TRUE)


## (c)  Create a new variable summer_born that is TRUE when a participant was born in summer
##  and FALSE when a person was born in winter (October to March).

data_a$born <- NA
data_a$born[data_a$bmonth == 10 |data_a$bmonth == 11 |data_a$bmonth == 12 |data_a$bmonth == 1 |data_a$bmonth == 2 |data_a$bmonth == 3] <- "winter_born"
data_a$born[data_a$bmonth == 4 |data_a$bmonth == 5 |data_a$bmonth == 6 |data_a$bmonth == 7 |data_a$bmonth == 8 |data_a$bmonth == 9] <- "summer_born"

# Better use ranges... 


## (d) Compute the current age of each participant as the person would report it 

data_a$age <- NA
data_a$age <- as.numeric(as.Date("2018-07-16")-as.Date(data$bdate))/365

## This yields some decimal number... 


## (e) List the frequency of each blood type

temp <- group_by(data_a, gender, blood_type) %>%
          count()

spread(data = temp, 
       key = blood_type, value = n)


## (f) Compute descriptives (the counts, means, and standard deviations) 

data_b <- mutate(data_a,
              decade = byear - byear %% 10) 

data_b %>%
  group_by(gender, decade) %>%
  summarise(n = n(),
            mn_d = mean(height),
            sd_d = sd (height),
            md_d = median (height))


## (g) Visualize the distributions of height (a) by gender and (b) by cohort

ggplot(data_b, aes(x = data_b$decade, y=data_b$height))+
  geom_bar(aes(fill = data_b$gender), position = "dodge", stat = "identity")+
  xlab("Decade")+
  scale_y_continuous(name = "Height")

## ANSWER: The younger people (born after 1975) are taller than the old (born between years 1950-1975)
## and the males are taller than the females


## (h)  Compute the aggregate BNT score as the sum of all four bnt_i values 

data_b$BNT <- data_b$bnt_1 + data_b$bnt_2 + data_b$bnt_3 + data_b$bnt_4

sum(is.na(data_b$BNT))

## ANSWER: 78 missing Bnt values


## (i) Inspect the values for the 2 intelligence scores g_iq and s_iq

# (i) -1- How many missing values are there?

sum(is.na(data_b$g_iq))
sum(is.na(data_b$s_iq))

## ANSWER: g_iq has 20 missing values, s_iq has 30 missing values

# (i) -2- What are their means and their ranges?

mean(data_b$g_iq, na.rm = TRUE)

range(data_b$g_iq, na.rm = TRUE)

## ANSWER: g_iq mean = 101.9071, minimum = 73, maximum = 139


mean(data_b$s_iq, na.rm = TRUE)

range(data_b$s_iq, na.rm = TRUE)

## ANSWER: s_iq mean = 101.9742, minimum = 70, maximum = 131

# (i) -3- Plot their distributions in 2 separate histograms

ggplot(data_b, aes(data_b$g_iq))+
  geom_histogram()

ggplot(data_b, aes(data_b$s_iq))+
  geom_histogram()


## (j) Visualize the relationship between g_iq and s_iq. Can you detect any systematic trend?

ggplot(data_b) +
  geom_point(aes(x = s_iq, y = g_iq), position = "jitter") +
  geom_smooth(mapping = aes(x = s_iq, y = g_iq))

## ANSWER: There is barely any connection between the variables 


## (k) Does numeracy (as measured by the aggregate BNT score) seem to vary by gender?

data_c <- data_b[!is.na(data_b$BNT),]

t.test(data_c$BNT[data_c$gender == "female"],data_c$BNT[data_c$gender == "male"])

## ANSWER: yes, numercay is vary by gender


## (L) Assess possible effects of numeracy (as measured by BNT) on the 2 measures of intelligence

regGIQ <- lm(data_c$g_iq~data_c$BNT)
summary(regGIQ)

regSIQ <- lm(data_c$s_iq~data_c$BNT)
summary(regSIQ)

## ANSWER; there is significant effect of BNT score on the general iq (p<0.001),
## there is significant effect of BNT score on the social iq (p<0.05)


## (M) Assess possible effects of the independent variables

## age:

regAge <- lm(data_c$BNT~data_c$age)
summary(regAge)

ggplot(data_c)+
  geom_point(aes(x = age, y = BNT), position = "jitter") +
  geom_smooth(mapping = aes(x = age, y = BNT))

## ANSWER: the effect of age on numeracy is not significant



## gender:

aovGender <- aov(data_c$BNT~data_c$gender)
summary(aovGender)


ggplot(data_c, aes(x = gender, y = BNT))+
  geom_bar(stat = "summary", fun.y = "mean")

## ANSWER: the effect of gender on numeracy is significant (p< 0.001)


# birth season:

aovBorn <- aov(data_c$BNT~data_c$born)
summary(aovBorn)

ggplot(data_c, aes(x = born, y = BNT))+
  geom_bar(stat = "summary", fun.y = "mean")

## ANSWER: the effect of summerborn on numeracy is not significant 



# blood type:

aovBT <- aov(data_c$BNT~data_c$blood_type)
summary(aovBT)

ggplot(data_c, aes(x = blood_type, y = BNT))+
  geom_bar(stat = "summary", fun.y = "mean")  

## ANSWER: the effect of blood type on numeracy is not significant



# the day of the week on which a person was born:

aovBWD <- aov(data_c$BNT~data_c$bweekday)
summary(aovBWD)

ggplot(data_c, aes(x = bweekday, y = BNT))+
  geom_bar(stat = "summary", fun.y = "mean")

## ANSWER: the effect of bday on numeracy is not significant

## The data suggests only plausible effects ##


pt <- pt + 26  # good.

## Mostly good, but some questionable graphs and stats.
## Why mix base-R and tidyverse commands?


## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## Points: 42/50.
## Grade:  1.7 - Very good!

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## By submitting this script I assure that I have completed this 
## script by myself (using only permissible sources of help). 

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## End of file. ----- 