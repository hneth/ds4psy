## Final exam  | Data science for psychologists (Summer 2018)
## Name: Valentina Cufar | Student ID:01/872180
## 2018 07 18
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## Preparations: ----- 

library(tidyverse)
pt <- 0  # counter for current point total

## Task 1: ----- 

# (a) Save data as tibble and inspect data:
pg <- as_tibble(PlantGrowth)
dim(pg)

## Answer: The PlantGrowth data contains 30 cases (rows) and 2 variables (columns). 

## (b): 
pg %>%
  group_by(group) %>%
  summarise(count = n(),
            M_group = mean(weight),
            ME_group = median(weight),
            SD_group = sd(weight))

## Answer: 
# group  count M_group ME_group SD_group
# <fct> <int>   <dbl>    <dbl>    <dbl>
#  ctrl     10    5.03     5.15    0.583
#  trt1     10    4.66     4.55    0.794
#  trt2     10    5.53     5.44    0.443

## (c):
ggplot(pg, aes(group, weight, color = group)) +
  geom_boxplot()+
  geom_point(alpha=0.5, size = 4, position = "jitter")

pt <- pt + 5  # well done!

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## Task 2: -----
library(nycflights13)

## (a) 
wt <- nycflights13::weather
dim(wt)

##Answer: The Weather data contains 26130 cases (rows) and 15 variables (columns).

## (b)
sum(is.na(wt))

##Answer: SW contains 3157 missing values. 

(sum(is.na(wt))/(sum(is.na(wt))+sum(!is.na(wt))))*100
3157+388793
3157/391950*100

## Answer: The percentage of wt is 0,81 % (not even 1 %).

# True, but shorter solution:
mean(is.na(wt))

wt %>%
  summarise(min_year = min(year),
            max_year = max(year),
            SD_year = sd(year))
## Answer: Varible year doen't have any variance, Min and MAx value are 2013 (all cases has the same year).

## (c)
wt %>%
  group_by(origin)%>%
  summarise(n())

## Answer: Data contains 8708 observations of airport EWR, 8711 of airport JFK and 8711 of airport LGA.
# EWR     8708
# JFK     8711
# LGA     8711

## (d)
mutate(temp_dc = (temp - 32)*(5/9))

wt_2 <- wt %>%
  mutate(temp_dc = (temp - 32)*(5/9)) %>%
  select(origin:temp, temp_dc, everything())


## (e)
wt_2 %>%
  filter(origin == "JFK") %>%
  select(year, month, day, temp, temp_dc) %>%
  arrange(temp_dc)

## Answer: 3 the coldest dates and temparature: 
              # 23.1.2013 with extreme temparature - 11.1, 
              # 24.1.2013 with extreme temparature - 10.6 
              # and 9.5.2013 with extreme temparature -10.5.


wt_2 %>%
  filter(origin == "JFK") %>%
  select(year, month, day, temp, temp_dc) %>%
  arrange(desc(temp_dc))

## Answer: 3 the hotest dates and temparature: 
            # 18.7.2013 with extreme temparature 36.7, 
            # 16.7.2013 with extreme temparature 35.6,
            # and 15.7.2013 with extreme temparature 35.


## (f)
library(ggplot2)

wt_3 <- wt %>%
  group_by(origin, month)%>%
  summarise(M_precip = mean(precip, na.rm = TRUE))

ggplot(wt_3, aes(month, M_precip, fill = origin)) +
 geom_bar(stat = "identity", position = "dodge", color = "black")

# ok, but 3 lines would have been clearer. 

## (g)

wt_4 <- wt %>%
  filter(precip < 0.3) %>%
  mutate(summer = between(month, 4,9),
         winter = between(month, 1,3) | between(month, 10, 12)) %>%
  select(precip, winter, summer, month, origin) %>%
  mutate(Wint_or_summ = ifelse(between(month, 4,9), "summer", "winter")) 
wt_4 # ok, but rather complicated... 

wt_4 %>%
  group_by(Wint_or_summ) %>%
  summarise(mn_precip = mean(precip))
## Answer: The mean of peripitation is a bit higher in winter (0,00241) than in summer (0,00239).
#  Wint_or_summ mn_precip
# <chr>            <dbl>
# summer         0.00239
# winter         0.00241

wt_5 <- wt_4 %>%
  group_by(origin, Wint_or_summ)%>%
  summarise(Together = sum(precip))

ggplot(wt_5, aes(Wint_or_summ, Together))+
  geom_bar(stat = "identity", position = "dodge")+
  facet_wrap(~origin)+
  labs(x = "Winter or summer", y = "Total amount of precipitation")

# good.

pt <- pt + 15  # very good!

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## Task 3: -----

## (a)
data <- read_csv("http://rpository.com/ds4psy/data/numeracy.csv")
dim(data)

(sum(is.na(data))/(sum(is.na(data))+sum(!is.na(data)))) * 100

# Answer: The data contains of 1000 rows and 12 columns.Percentage of missing values is 1.08 %.

## (b)
data_a <- separate(data, col = bdate,into = c("year","month","day"), sep = "-") %>%
  transform(year = as.numeric(year), month = as.numeric(month), day = as.numeric((day)))

as_tibble(data_a)

## (c)
data_b <- data_a %>%
  mutate(summer_born = between(month, 4,9))

## (d)
data_c <- data_b %>%
  mutate(age_year1 = 2018 - year, 
         age_month = 7 - month,
         age_day = 18 - day)

data_c <- data_c %>%
  mutate(month1 = ifelse(age_day >= 0, 1, 0)) %>%
  mutate(month2 = age_month + month1) %>%
  mutate(age_year2 = ifelse(month2 >0, 1, 0)) %>%
  mutate(age_year = age_year1 + age_year2)


## (e)
data_d <- data_c%>%
  group_by(gender)%>%
  count(blood_type)

data_d %>%
  spread(key = blood_type, value = n)

##Answer: 
# gender   `A-`  `A+` `AB-` `AB+`  `B-`  `B+`  `O-`  `O+`
# <chr>   <int> <int> <int> <int> <int> <int> <int> <int>
#  female    41   194     5     9     7    37    34   204
#  male      27   158     4    15     3    44    34   184

## (f)
data_e <- data_c%>%
  transform(height = as.numeric(height))%>%
  mutate(cohort = age_year%/%10)

data_f <- data_e%>%
  group_by(gender, cohort)%>%
  summarise(n_height = n(),
            M_height = mean(height, na.rm = TRUE),
            SD_height = sd(height, na.rm = TRUE))

## (g)
data_e$cohort
as.factor(data_e$cohort)

ggplot(data_e)+
  geom_point(aes(x=height, y=cohort, color = gender, alpha = 0.5), position = "jitter")


## Answer: I found out that males are heigher than females and that there might be a slight trend of younger being heigher, 
##         but it doesn't influence that much. 
  
## Actually, the influence is highly systematic --- but that's ok... 


  
## (h)
data_h <- data_e%>%
  mutate(BNT_score = bnt_1 + bnt_2 + bnt_3 + bnt_4)

data_h %>%
count(is.na(BNT_score))

##Answer: BNT_score has 78 missing values.

## (i)
data_h %>%
  count(is.na(g_iq))
data_h %>%
  count(is.na(s_iq))

##Answer: There is 20 missing values in variable g_iq and 30 missing values in s_iq variable.

data_h %>%
  summarise(M_g_iq = mean(g_iq, na.rm = TRUE),
            Min_g_iq = min(g_iq, na.rm = TRUE),
            Max_g_iq = max(g_iq, na.rm = TRUE),
            M_s_iq = mean(s_iq, na.rm = TRUE),
            Min_s_iq = min(s_iq, na.rm = TRUE),
            Max_s_iq = max(s_iq, na.rm = TRUE))

##Answer:g_ig: Mean 101.91, range 73-139. s_iq: Mean 101,97, range 70-131.
# M_g_iq  Min_g_iq  Max_g_iq        M_s_iq  Min_s_iq  Max_s_iq
# 101.9071   73      139            101.9742       70      131

ggplot(data_h, aes(x = g_iq))+
  geom_histogram()


ggplot(data_h, aes(x = s_iq))+
  geom_histogram()

## (j)
ggplot(data_h)+
  geom_point(aes(x = g_iq, y = s_iq), position = "jitter")

ggplot(data_h)+
  geom_point(aes(x = s_iq, y = g_iq, alpha = 0.5), position = "jitter")+
  geom_abline()

## Answer: There is no systematic trend. But we can see, that most of the answers were aroung 100 (mean values of both variables).

## (k)
data_h %>%
  group_by(gender)%>%
  summarise(n = n(),
            M_BNT = mean(BNT_score, na.rm = TRUE),
            SD_BNT = sd(BNT_score, na.rm = TRUE),
            min_BNT = min(BNT_score, na.rm = TRUE),
            max_BNT = max(BNT_score, na.rm = TRUE))

ggplot(data_h)+
  geom_bar(aes(x=gender, y = BNT_score), stat = "identity")

# Answer: From results we can see, that female mean is higher than male mean, so it mean that there is a bit of difference between them. 
# gender     n   M_BNT SD_BNT min_BNT max_BNT
# <chr>   <int>  <dbl>  <dbl>   <dbl>   <dbl>
# female    531  2.14  0.955       0       4
#  male     469  1.82  0.950       0       4

## (l)
data_h %>%
  group_by(BNT_score)%>%
  summarise(M_g_iq = mean(g_iq, na.rm = TRUE),
            Min_g_iq = min(g_iq, na.rm = TRUE),
            Max_g_iq = max(g_iq, na.rm = TRUE),
            M_s_iq = mean(s_iq, na.rm = TRUE),
            Min_s_iq = min(s_iq, na.rm = TRUE),
            Max_s_iq = max(s_iq, na.rm = TRUE)) 

data_l <- data_h %>%
  group_by(BNT_score)%>%
  summarise(M_g_iq = mean(g_iq, na.rm = TRUE),
            M_s_iq = mean(s_iq, na.rm = TRUE)) %>%
  select(M_g_iq, M_s_iq, BNT_score)

ggplot(data_h)+
  geom_point(aes(x = s_iq, y = g_iq, color = BNT_score, alpha = 0.5), position = "jitter")+
  geom_abline()

ggplot(data_l)+
  geom_bar(aes(x=BNT_score, y = M_g_iq), stat = "identity")

ggplot(data_l)+
  geom_bar(aes(x=BNT_score, y = M_s_iq), stat = "identity")


##Answer: It shows, that might higher BNT score also means also higher g_iq (BNT = 3 or 4),
# but the difference is not that obvious for s_iq variable. 

# BNT_score M_g_iq Min_g_iq Max_g_iq M_s_iq Min_s_iq Max_s_iq
# <int>  <dbl>    <dbl>    <dbl>  <dbl>    <dbl>    <dbl>
#         0   98.6       80      126   101.       76      122
#         1  101.        76      125   101.       70      129
#         2   99.9       81      130   102.       71      131
#         3  107.        84      139   103.       75      126
#         4  107.        88      132   102.       78      121
#        NA  101.        73      124   102.       75      123


## (m)
data_v <- data_h%>%
  filter(!is.na(s_iq),!is.na(g_iq))

# Gender:
data_h %>%
  group_by(gender)%>%
  summarise(M_g_iq = mean(g_iq, na.rm = TRUE),
            M_s_iq = mean(s_iq, na.rm = TRUE))

ggplot(data_v)+
  geom_boxplot(aes(x = gender, y = s_iq))

ggplot(data_v)+
  geom_boxplot(aes(x = gender, y = g_iq))

# Cohort:
data_coh <- data_h %>%
  group_by(cohort)%>%
  summarise(M_g_iq = mean(g_iq, na.rm = TRUE),
            M_s_iq = mean(s_iq, na.rm = TRUE))

ggplot(data_coh)+
  geom_line(aes(x = cohort, y = M_s_iq), stat = "identity")
 
ggplot(data_coh)+
  geom_line(aes(x = cohort, y = M_g_iq), stat = "identity")

# Summer_born:
data_h %>%
  group_by(summer_born)%>%
  summarise(M_g_iq = mean(g_iq, na.rm = TRUE),
            M_s_iq = mean(s_iq, na.rm = TRUE))

ggplot(data_v)+
  geom_boxplot(aes(x = summer_born, y = s_iq))

ggplot(data_v)+
  geom_boxplot(aes(x = summer_born, y = g_iq))


# Blood type:
data_h %>%
  group_by(blood_type)%>%
  summarise(M_g_iq = mean(g_iq, na.rm = TRUE),
            M_s_iq = mean(s_iq, na.rm = TRUE))

ggplot(data_v)+
  geom_boxplot(aes(x = blood_type, y = s_iq))

ggplot(data_v)+
  geom_boxplot(aes(x = blood_type, y = g_iq))

# bweekday:
data_h %>%
  group_by(bweekday)%>%
  summarise(M_g_iq = mean(g_iq, na.rm = TRUE),
            M_s_iq = mean(s_iq, na.rm = TRUE))

ggplot(data_v)+
  geom_boxplot(aes(x = bweekday, y = s_iq))

ggplot(data_v)+
  geom_boxplot(aes(x = bweekday, y = g_iq))

## Answer: 
# Females reports higher g_iq and s_iq than males. 
# Age (cohort) probably dosen't have that much of a "influence" on g_iq and s_iq. 
# It is very interesting that individuals born in Summer have higher g_iq, individuals born in winter have higher s_iq.
# g_iq: the lowest result is in group AB-, while for s_iq: the lowest number is for group O-, lower nubers are also reported by groups A-, AB-, AB+ and B-.
# It is very interesting that individuals born on Thursday and Tuesday have lover level of g_iq. 


pt <- pt + 28  # some graphs a bit simple, but otherwise very good!

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## Task 4: -----

## Link: https://en.wikipedia.org/wiki/European_countries_by_electricity_consumption_per_person 
elco <- read_xlsx("C:/Users/cufar/OneDrive/Documents/Valentina/Konsatnz faks/R/practice_R/data.xlsx", 1)

# elco <- read_xlsx("data.xlsx", 1)

elco1 <- as_tibble(elco) 

elco2 <- elco1 %>%
  separate(col=yr_2010, into = c("one","two"), sep = " ") %>%
  unite(col = "yr_2010", one, two, sep = "") %>%
  separate(col = yr_2011, into = c("three","four"), sep = " ") %>%
  unite(col = "yr_2011", three, four, sep = "") %>%
  separate(col=yr_2012, into = c("five","six"), sep = " ") %>%
  unite(col = "yr_2012", five, six, sep = "")
  
elco3 <- elco2%>%
  transform(yr_2010 = as.numeric(yr_2010),
            yr_2011 = as.numeric(yr_2011), 
           yr_2012 = as.numeric(yr_2012))

elco3 %>%
  summarise(n = n(),
            M_2010 = mean(yr_2010),
            M_2011 = mean(yr_2011),
            M_2012 = mean(yr_2012),
            SD_2010 = sd(yr_2010),
            SD_2011 = sd(yr_2011),
            SD_2012 = sd(yr_2012),
            Me_2010 = median(yr_2010),
            Me_2011 = median(yr_2011),
            Me_2012 = median(yr_2012))
  
#  n   M_2010     M_2011    M_2012    SD_2010   SD_2011   SD_2012   Me_2010   Me_2011   Me_2012
# 38   7779.842   7702.368  7706.816  8589.597  8552.35   8664.83   5597.5    5557      5481.5


## From results we can see that mean electricity consumption per person 2012 (for all coutries ) 
## is lower than it was 2010 (M =7779,84, SD = 5597,5). 

elco3 %>%
  arrange(yr_2010)
elco3 %>%
  arrange(yr_2011)
elco3 %>%
  arrange(yr_2012)
elco3 %>%
  arrange(desc(yr_2010))
elco3 %>%
  arrange(desc(yr_2011))
elco3 %>%
  arrange(desc(yr_2012))

## In 2010, 2011 and 2012 the highest electricity consuption was Iceland and the lowest in Albania. 

elco3 %>%
  filter(yr_2010>7779)
## Countries with higer consuption (in year 2010) then an average are: 
## Avstria, Belgium, Finland, Iceland, Luxemburg, Norway, Sweden and Switzerland.

elco4 <- elco3 %>%
  gather(key = year1, value=consuption, yr_2010:yr_2012) %>%
  separate(col=year1, into = c("delite","year"), sep = "_") %>%
  select(Country, year, consuption)

ggplot(elco4, aes(x = year, y = consuption))+
  geom_boxplot()

elco5 <- filter(elco4, consuption < 10000)
  ggplot(elco5, aes(x = year, y = consuption))+
  geom_boxplot()+
    geom_point(position = "jitter")

elco6 <- elco5 %>%
  
elco7 <- elco4 %>%
  group_by(year) %>%
  summarise(M_consuption = mean(consuption)) %>%
  select(M_consuption, year)

ggplot(elco7)+
  geom_bar(aes(x=year, y= M_consuption), stat = "identity")


## Exemple of entering data with tribble: 
ec <- tribble(
  ~Country,	 ~yr_2010,  ~	yr_2011,  ~yr_2012,
"Albania", 	1947,	2195,	2118,
"Austria", 	8347,	8390,	8507,
"Belarus", 	3564,	3629,	3698,
"Belgium",	8369,	8021,	7987,
"Bulgaria",	4560,	4864,	4762)

pt <- pt + 5 # very good!

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## Points: 50/50.
## Grade:  1.0 - Well done!

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## By submitting this script I assure that I have completed this 
## script by myself (using only permissible sources of help). 

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## End of file. ----- 