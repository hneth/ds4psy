## Final exam  | Data science for psychologists (Summer 2018)
## Name: Julia Schuhmann | Student ID: 01/947586
## 2018 07 16
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## Preparations: ----- 

library (tidyverse)
library (nycflights13)

## Task 1: ----- 

## (a) 
plantgrowth <- as_tibble(PlantGrowth)
glimpse(plantgrowth)
#observations: 30
#variables: 2

## (b)
plantgrowth%>%
  group_by(group)%>%
  count()

#  group     n
# <fct> <int>
#1 ctrl     10
#2 trt1     10
#3 trt2     10

plantgrowth%>%
  group_by(group)%>%
  summarise(mn_group = mean(weight, na.rm = TRUE),
            md_group = median(weight, na.rm = TRUE),
            sd_group = sd(weight, na.rm = TRUE)
  )

## A tibble: 3 x 4
#group mn_group md_group sd_group
#<fct>    <dbl>    <dbl>    <dbl>
#1 ctrl      5.03     5.15    0.583
#2 trt1      4.66     4.55    0.794
#3 trt2      5.53     5.44    0.443

## (c)

ggplot(plantgrowth, mapping = aes(x = group, y = weight))+
       geom_boxplot()+
       geom_point(position = "jitter")+
       labs(title = "plant weight by group", caption = "Data from tidyverse::Plantgrowth")

  

## Task 2: ####

## (a)
wt <- as_tibble(nycflights13::weather)
glimpse(wt)
#Observations: 26,115
#Variables: 15

## (b)
View(wt)
wt%>%
  count()
#26115 = total observations

sum(is.na(wt))
#23974

sum(!is.na(wt))
#367751

#percentage: 6.519
(sum(is.na(wt)) / sum(!is.na(wt)))*100

wt%>%
  summarise(min(year), 
            max(year)
  )

## A tibble: 1 x 2
#`min(year)` `max(year)`
# <dbl>       <dbl>
#  1        2013        2013

View(wt)

## (c)
wt%>%
  group_by(origin)%>%
  count()

## A tibble: 3 x 2
# Groups:   origin [3]
#origin     n
#<chr>  <int>
#1 EWR     8703
#2 JFK     8706
#3 LGA     8706

## (d)
#temp in Fahrenheit, temp_dc in Celcius
wt%>% 
  mutate(temp_dc = (temp-32)*(5/9))%>%
  select(temp_dc, temp)

# A tibble: 26,115 x 2
# temp_dc  temp
# <dbl> <dbl>
# 1    3.9   39.0
# 2    3.9   39.0
# 3    3.9   39.0
# 4    4.4   39.9
# 5    3.9   39.0
# 6    3.30  37.9
# 7    3.9   39.0
# 8    4.4   39.9
# 9    4.4   39.9
# 10    5     41  
# ... with 26,105 more rows


View(wt)

mutate(wt, 
       temp_dc = (temp-32)*(5/9))

wt2 = mutate(wt, 
            temp_dc = (temp-32)*(5/9))

wt3 <- wt2%>%
        select(origin:temp, temp_dc, everything())

View(wt3)

# A tibble: 26,115 x 16
#origin  year month   day  hour  temp temp_dc  dewp humid
#<chr>  <dbl> <dbl> <int> <int> <dbl>   <dbl> <dbl> <dbl>
#1 EWR     2013     1     1     1  39.0    3.9   26.1  59.4
#2 EWR     2013     1     1     2  39.0    3.9   27.0  61.6
#3 EWR     2013     1     1     3  39.0    3.9   28.0  64.4
#4 EWR     2013     1     1     4  39.9    4.4   28.0  62.2
#5 EWR     2013     1     1     5  39.0    3.9   28.0  64.4
#6 EWR     2013     1     1     6  37.9    3.30  28.0  67.2
#7 EWR     2013     1     1     7  39.0    3.9   28.0  64.4
#8 EWR     2013     1     1     8  39.9    4.4   28.0  62.2
#9 EWR     2013     1     1     9  39.9    4.4   28.0  62.2
#10 EWR     2013     1     1    10  41      5     28.0  59.6
# ... with 26,105 more rows, and 7 more variables:
#   wind_dir <dbl>, wind_speed <dbl>, wind_gust <dbl>,
#   precip <dbl>, pressure <dbl>, visib <dbl>, time_hour <dttm>

## (e)
#temp_dc

wt3%>%
  filter(origin == "JFK")%>%
  arrange(temp_dc)

## A tibble: 8,706 x 16
#origin  year month   day  hour  temp temp_dc   dewp humid
#<chr>  <dbl> <dbl> <int> <int> <dbl>   <dbl>  <dbl> <dbl>
#1 JFK     2013     1    23     4  12.0   -11.1  -7.06  41.3
#2 JFK     2013     1    23     5  12.0   -11.1  -5.08  45.4
#3 JFK     2013     1    23     6  12.0   -11.1  -5.08  45.4
#4 JFK     2013     1    23     1  12.9   -10.6  -9.04  36.0
#5 JFK     2013     1    23     2  12.9   -10.6  -7.96  38.0
#6 JFK     2013     1    23     3  12.9   -10.6  -7.06  39.7
#7 JFK     2013     1    23     7  12.9   -10.6  -4     46.0
#8 JFK     2013     1    24     1  12.9   -10.6  -2.02  50.5
#9 JFK     2013     5     8    22  13.1   -10.5  12.0   95.3

#coldest temperatures:
#23.01.2013: -11.1 Grad°C
#24.01.2013: -10.6 Grad°C
#08.05.2013: -10.5 Grad°C

wt3%>%
  filter(origin == "JFK")%>%
  arrange(desc(temp_dc))
## A tibble: 8,706 x 16
#origin  year month   day  hour  temp temp_dc  dewp humid
#<chr>  <dbl> <dbl> <int> <int> <dbl>   <dbl> <dbl> <dbl>
#1 JFK     2013     7    18    12  98.1    36.7  66.9  36.4
#2 JFK     2013     7    18    11  97.0    36.1  68    39.0
#3 JFK     2013     7    18    14  97.0    36.1  71.1  43.4
#4 JFK     2013     7    16    14  96.1    35.6  62.1  32.6
#5 JFK     2013     7    18    10  96.1    35.6  66.9  38.7
#6 JFK     2013     7    18    13  96.1    35.6  71.1  44.6
#7 JFK     2013     7    15    16  95      35    68    41.5

#hottest temperatures: 
#18.07.2013: 36.7°C
#16.07.2013: 35.6°C
#15.07.2013: 35.0°C

## (f)
wt%>%
    group_by(origin, month)%>%
    summarise(
              mean_precip = mean(precip, na.rm = TRUE))%>%
    ggplot(aes(x = month, y = mean_precip, fill = origin))+
    geom_bar(stat = "identity", position = "dodge")+
    scale_x_continuous(breaks = c(1,2,3,4,5,6,7,8,9,10,11,12))
  

wt%>%
  group_by(origin, month)%>%
  summarise(
    mean_precip = mean(precip, na.rm = TRUE))%>%
  ggplot(aes(x = month, y = mean_precip, color = origin))+
  geom_line(stat = "identity")+
  scale_x_continuous(breaks = c(1,2,3,4,5,6,7,8,9,10,11,12))

##(g)
wt%>%
  filter(precip <= 0.3)%>%
  mutate(summer = between(month,4,9))%>%
  filter(summer == TRUE)%>%
  summarise(count = n(),
            sump_precip_summer = (sum(precip)))
  
#sum: 47.1
  
wt%>%
  filter(precip <= 0.3)%>%
  mutate(summer = between(month,4,9))%>%
  filter(summer == FALSE)%>%
  summarise(count = n(),
            sump_precip_winter = (sum(precip)))

#sum: 44.7

#in summer it does rain more than in winter when you exclude the 
#exreme cases of precipation

wt_g <- wt%>% 
          filter(precip <= 0.3)%>%
          mutate(summer = between(month,4,9))%>%
          group_by(summer, origin)%>%
          summarise(
            count = n(),
            sum_precip_summer = (sum(precip)))

ggplot(wt_g, aes(x = summer, y = sum_precip_summer))+
  geom_bar(stat = "identity")+
  facet_wrap(~ origin)






## Task 3: ####
data <- read_csv("http://rpository.com/ds4psy/data/numeracy.csv")
View(data)

## (a)
dim(data)
glimpse(data)
#obervations: 1000, variables: 12
sum(is.na(data)) #130
sum(!is.na(data)) #11870
(sum(is.na(data)) / sum(!is.na(data))) * 100
#percentage of missing values: circa 1%

## (b)
data_sep <- separate(data = data, col = bdate, 
            into = c("byear","month","bday"), sep = "-", convert = TRUE)
data_sep
# A tibble: 1,000 x 14
#name  gender byear month  bday bweekday height blood_type
#<chr> <chr>  <int> <int> <int> <chr>     <int> <chr>     
#  1 I.G.  male    1968    12    14 Sat         169 O+        
#  2 O.B.  male    1974     4    10 Wed         181 O+        
#  3 M.M.  male    1987     9    28 Mon         183 A???  

## (c)
data_sep%>%
    mutate(summer_born = between(month, 4,9))%>%
    select(name, gender, byear, month, bday, summer_born)

## A tibble: 1,000 x 6
#name  gender byear month  bday summer_born
#<chr> <chr>  <int> <int> <int> <lgl>      
#1 I.G.  male    1968    12    14 FALSE      
#2 O.B.  male    1974     4    10 TRUE       
#3 M.M.  male    1987     9    28 TRUE       
#4 V.J.  female  1978     2    15 FALSE
  
data_summer_born <- data_sep%>%
  mutate(summer_born = between(month, 4,9))

## (d)
data_sep%>%
  mutate(age = 2018- byear
           )%>%
  select(name:bweekday,age,everything())

#so you can nearly compute the age
#but the people gaining this age during the year are one year too old
#if-else-structure?!

data_sep%>%
  mutate(age = filter(month>=7, day>=15) 2018- byear, 
                filter(month>7, day>15) 2018- (byear +1)
        )%>%
  select(name:bweekday,age,everything())

## (e)
data_3e <- data%>%
            group_by(gender)%>%
            count(blood_type)

spread(data_3e, key = blood_type, value = n)

## A tibble: 2 x 9
# Groups:   gender [2]
#gender  `A???`  `A+` `AB???` `AB+`  `B???`  `B+`  `O???`  `O+`
#<chr>  <int> <int> <int> <int> <int> <int> <int> <int>
#1 female    41   194     5     9     7    37    34   204
#2 male      27   158     4    15     3    44    34   184

## (f)
data_sep%>%
  mutate(cohort = (byear- byear %% 10))%>%
  select(name:bweekday,cohort,everything())%>%
  group_by(cohort)%>%
  summarise(
            count = n(),
            mean_height = mean(height, na.rm = TRUE),
            sd_height = sd(height, na.rm = TRUE)
  )

## A tibble: 9 x 4
#cohort count mean_height sd_height
#<dbl> <int>       <dbl>     <dbl>
#1   1920    12        161.      8.37
#2   1930    70        161.     13.0 
#3   1940   131        164.     11.0 
#4   1950   125        167.     11.7 
#5   1960   154        165.     10.9 
#6   1970   160        167.     10.3 
#7   1980   180        168.     11.9 
#8   1990   151        171.     12.0 
#9   2000    17        172.     11.6 

data_sep%>%
  group_by(gender)%>%
  summarise(
            count = n(),
            mean_height = mean(height, na.rm = TRUE),
            sd_height = sd(height, na.rm = TRUE)
  )

# A tibble: 2 x 4
#gender count mean_height sd_height
#<chr>  <int>       <dbl>     <dbl>
#1 female   531        161.      8.79
#2 male     469        173.     11.0 

## (g)
ggplot(aes(x = gender, y = height)+
         geom_bar())

data_sep2 <- data_sep%>%
              mutate(cohort = (byear- byear %% 10))

typeof(data_sep2$cohort)      #double

data_sep2$cohort <- as.factor(data_sep2$cohort)
typeof(data_sep2$cohort) #integer

data_sep2%>%
  ggplot(aes(x = cohort, y = height))+
         geom_boxplot()

## (h)
BNT <- data%>%
        group_by(name)%>%
        mutate(BNT_score = bnt_1 + bnt_2 + bnt_3 + bnt_4,na.rm = TRUE)%>%
        select(name,BNT_score,everything())

sum(is.na(BNT$BNT_score))
#78 missing values


## (i)
data_sep%>%
  summarise(
              missing_g_iq = sum(is.na(g_iq)),
              missing_s_iq= sum(is.na(s_iq))
  )

## A tibble: 1 x 2
#missing_g_iq missing_s_iq
#<int>        <int>
#  1           20           30

iqtb <- data_sep%>%
          summarise(mn_g_iq = mean(g_iq, na.rm = TRUE),
                    min_g_iq = min(g_iq, na.rm = TRUE),
                    max_g_iq = max(g_iq, na.rm = TRUE),
                    mn_s_iq = mean(s_iq, na.rm = TRUE),
                    min_s_iq = min(s_iq, na.rm = TRUE),
                    max_s_iq = max(s_iq, na.rm = TRUE)
    )

iqtb
# A tibble: 1 x 6
#mn_g_iq min_g_iq max_g_iq mn_s_iq min_s_iq max_s_iq
#<dbl>    <dbl>    <dbl>   <dbl>    <dbl>    <dbl>
#  1    102.       73      139    102.       70      131


ggplot(data_sep, aes(x = g_iq))+
  geom_histogram(binwidth = 1)

ggplot(data_sep, aes(x = s_iq))+
  geom_histogram(binwidth = 1)


## (j)
ggplot(data, aes (x = g_iq, y = s_iq))+
  geom_point(position = "identity", alpha = 1/5)+
  geom_smooth()

#both intelligence scale show crowding in the middle

## (k)
data_sep%>%
  mutate(BNT_score = bnt_1 + bnt_2 + bnt_3 + bnt_4,na.rm = TRUE)%>%
  ggplot(aes (x = gender, y = BNT_score))+
  geom_boxplot()

#female seem to have a higher BNT_score

## (l)
ggplot(BNT, aes (x = g_iq, y = s_iq))+
  geom_point(position = "identity", alpha = 1/5)+
  facet_wrap(~BNT_score)

## (m)
# (m_a) numerically
data_sep%>%
  group_by(gender)%>%
  summarise(mean_g_iq = mean(g_iq, na.rm = TRUE),
            mean_s_iq = mean(s_iq, na.rm = TRUE))

## A tibble: 2 x 3
#gender mean_g_iq mean_s_iq
#<chr>      <dbl>     <dbl>
#1 female      103.     107. 
#2 male        101.      96.5

#it seems as if the women have higher scores in the iq-scale

data_sep2%>%
  group_by(cohort)%>%
  summarise(mean_g_iq = mean(g_iq, na.rm = TRUE),
            mean_s_iq = mean(s_iq, na.rm = TRUE))
## A tibble: 9 x 3
#cohort mean_g_iq mean_s_iq
#<dbl>     <dbl>     <dbl>
#1   1920      105.      97.4
#2   1930      104.     101. 
#3   1940      101.     103. 
#4   1950      102.     102. 
#5   1960      102.     102. 
#6   1970      102.     103. 
#7   1980      102.     102. 
#8   1990      101.     100. 
#9   2000      102.     100  

#the means do not differ much between the different cohorts

data_summer_born%>%
  group_by(summer_born)%>%
  summarise(mean_g_iq = mean(g_iq, na.rm = TRUE),
            mean_s_iq = mean(s_iq, na.rm = TRUE))

## A tibble: 2 x 3
#summer_born mean_g_iq mean_s_iq
#<lgl>           <dbl>     <dbl>
#1 FALSE            99.6     105. 
#2 TRUE            104.       99.2

#the summer_born- people have in average higher scores in the g_iq
#and lower scores in the s_iq
#people born in winter have higher scores in the s_iq
#and lower scores in the g_iq

data_sep%>%
  group_by(blood_type)%>%
  summarise(mean_g_iq = mean(g_iq, na.rm = TRUE),
            mean_s_iq = mean(s_iq, na.rm = TRUE))

## A tibble: 8 x 3
#blood_type mean_g_iq mean_s_iq
#<chr>          <dbl>     <dbl>
#1 A???             104.       94.5
#2 A+             102.      104. 
#3 AB???             98.8      98.2
#4 AB+            103.       94.6
#5 B???             101.       94.2
#6 B+             103.      103. 
#7 O???             102.       92.8
#8 O+             101.      104. 
  
data_sep%>%
  group_by(bweekday)%>%
  summarise(mean_g_iq = mean(g_iq, na.rm = TRUE),
            mean_s_iq = mean(s_iq, na.rm = TRUE))

# A tibble: 7 x 3
#bweekday mean_g_iq mean_s_iq
#<chr>        <dbl>     <dbl>
#1 Fri          102.       102.
#2 Mon          102.       102.
#3 Sat          108.       102.
#4 Sun          107.       102.
#5 Thu           97.9      101.
#6 Tue           96.1      102.
#7 Wed          102.       102.

#people born on saturday have the highest g_iq
#people born on thursday and tuesday have the lowest g_iq
#in terms of s_iq there aren't great differences in the scores

# (m_b) graphically
ggplot(data_sep, aes (x = g_iq, y = s_iq))+
  geom_point(position = "identity", alpha = 1/5)+
  facet_wrap(~gender)

ggplot(data_sep2, aes (x = g_iq, y = s_iq))+
  geom_point(position = "identity", alpha = 1/5)+
  facet_wrap(~cohort)

ggplot(data_summer_born, aes (x = g_iq, y = s_iq))+
  geom_point(position = "identity", alpha = 1/5)+
  facet_wrap(~summer_born)

ggplot(data_sep, aes (x = g_iq, y = s_iq))+
  geom_point(position = "identity", alpha = 1/5)+
  facet_wrap(~blood_type)

ggplot(data_sep, aes (x = g_iq, y = s_iq))+
  geom_point(position = "identity", alpha = 1/5)+
  facet_wrap(~bweekday)




## Task 4: ####

#first try to get the data frame into R -> did not worked well
#so I decided to put the data into an excelfile
tribble(
  ~Name, ~Nr, ~Geburtstag, ~Position, ~Verein, ~LS, ~Tore, ~T/S,
  #-----------|---|-------------|----------|----------|---|---|---|        
  "Silvio Heinevetter", 12,  21.10.1984,  "TW", "Füchse Berlin",  176,  2,  0,  
  "Andreas Wolff",33,  3.03.1991,  "TW", "THW Kiel",  69,  9,  0.1,  
  "Uwe Gensheimer", 3, 26.10.1986,  "LA", "Saint-Germain (F)",  156,  722,  4.6,  
  "Patrick Wiencek",7,  22.03.1989,  "KR", "THW Kiel",  118,  269,  2.3, 
  "Tim Suton",8,  8.05.1996,  "RL", "TBV Lemgo",  6,  9,  1.5  ,
  "Fabian Wiede", 10 ,8.02.1994,  "RR", "Füchse Berlin",  62,  117,  1.9  ,
  "Hendrik Pekeler", 13 , 2.07.1991,  "KR" ,  "Rhein-Neckar Löwen",  80  124  1.6,  
  "Steffen Weinhold", 17,  19.07.1986,  "RR", "THW Kiel",  111,  279 , 2.5,  
  "Tim Kneule",18,   18.08.1986,  "RM" , "Frisch Auf Göppingen" ,  30  ,44 , 1.5  ,
  "Marian Michalczik",22,  1.02.1997,  "RL" ,"GWD Minden" , 8 , 6,  0.8  ,
  "Patrick Groetzki",24,  4.07.1989,  "RA" ,  "Rhein-Neckar Löwen",  128,  345 , 2.7  ,
  "Kai Häfner", 25,  10.07.1989,  "RR", "TSV Hannover-Burgdorf",  68,  149,  2.2,  
  "Evgeni Pevnov", 28, 13.02.1989  ,"KR"  ,"TSV Hannover-Burgdorf",  18,  11 , 0.6 , 
  "Tim Hornke", 29, 4.08.1990,  "RA",  "TBV Lemgo", 17,  40,  2.4 , 
  "Julius Kühn", 35,  1.04.1993,  "RL",  "MT Melsungen",48,  155,  3.2,  
  "Matthias Musche", 37,  18.07.1992,  "LA",  "SC Magdeburg",  26,  41,  1.6 , 
  "Fabian Böhm", 38, 24.06.1989,  "RL",   "TSV Hannover-Burgdorf",  11,  13,  1.2,  
  "Niclas Pieczkowski", 43,  28.12.1989,  "RM",  "SC DHfK Leipzig",  39,  41,  1.1,  
  "Moritz Preuss", NA,  22.02.1995,  "KR","VfL Gummersbach",  5,  4,  0.8  )


#https://de.wikipedia.org/wiki/Deutsche_M%C3%A4nner-Handballnationalmannschaft


owndata<-as_tibble(Handballmannschaft)
#re-format, analyze, and visualize this tibble in one or several graphs

owndata

# (a) who is the oldest player?

owndata_sep <-  owndata%>%
                separate(Geburtstag, into = c("Tag","Monat","Geburtsjahr"), 
                         sep = "\\.", convert = TRUE)
            
## A tibble: 19 x 10
     Nr. Name     Tag Monat Geburtsjahr Position Verein     LS
  <int> <chr>  <int> <int>       <int> <chr>    <chr>   <int>
#  1    12 Silvi~    21    10        1984 TW       "Fxfc~   176
#  2    33 Andre~     3     3        1991 TW       THW Ki~    69
#  3     3 Uwe G~    26    10        1986 LA       Paris ~   156
#  4     7 Patri~    22     3        1989 KR       THW Ki~   118
#  5     8 Tim S~     8     5        1996 RL       TBV Le~     6
#  6    10 Fabia~     8     2        1994 RR       "F\xfc~    62
#  7    13 Hendr~     2     7        1991 KR       "Rhein~    80
#  8    17 Steff~    19     7        1986 RR       THW Ki~   111
#  9    18 Tim K~    18     8        1986 RM       "Frisc~    30
#  10    22 Maria~     1     2        1997 RL       GWD Mi~     8
#  11    24 Patri~     4     7        1989 RA       "Rhein~   128
#  12    25 "Kai ~    10     7        1989 RR       TSV Ha~    68
#  13    28 Evgen~    13     2        1989 KR       TSV Ha~    18
#  14    29 Tim H~     4     8        1990 RA       TBV Le~    17
#  15    35 "Juli~     1     4        1993 RL       MT Mel~    48
#  16    37 Matth~    18     7        1992 LA       SC Mag~    26
#  17    38 "Fabi~    24     6        1989 RL       TSV Ha~    11
#  18    43 Nicla~    28    12        1989 RM       SC DHf~    39
#  19    NA Morit~    22     2        1995 KR       VfL Gu~     5
  # ... with 2 more variables: Tore <int>, `T/S` <chr>


# (b) which year is the most common birthyear?
owndata_sep%>%
  group_by(Geburtsjahr)%>%
  count()%>%
  arrange(desc(n))

View(owndata_sep)
     
#1989 is the most common birthyear

# (c) who had the most matches (LS)?
owndata%>%
  group_by(Name)%>%
  arrange(desc(LS))

## A tibble: 19 x 8
# Groups:   Name [19]
#Nr. Name    Geburtstag Position Verein      LS  Tore `T/S`
#<int> <chr>   <chr>      <chr>    <chr>    <int> <int> <chr>
# 1    12 Silvio~ 21.10.1984 TW       "F\xfcc~   176     2 0    
# 2     3 Uwe Ge~ 26.10.1986 LA       Paris S~   156   722 4,6  
# 3    24 Patric~ 04.07.1989 RA       "Rhein-~   128   345 2,7  

#Silvio Heinevetter is the most expierenced player

# (d) who scored the most goals (Tore)?
owndata%>%
  group_by(Name)%>%
  arrange(desc(Tore))

## A tibble: 19 x 8
# Groups:   Name [19]
#Nr. Name    Geburtstag Position Verein      LS  Tore `T/S`
#<int> <chr>   <chr>      <chr>    <chr>    <int> <int> <chr>
# 1     3 Uwe Ge~ 26.10.1986 LA       Paris S~   156   722 4,6  
# 2    24 Patric~ 04.07.1989 RA       "Rhein-~   128   345 2,7  
# 3    17 Steffe~ 19.07.1986 RR       THW Kiel   111   279 2,5

#Uwe Gensheimer scored the most goals

# (e) how many players play in the team "Rhein-Neckar Löwen" (Verein)?
owndata%>%
  group_by(Verein)%>%
  count%>%
  filter(Verein == "Rhein-Neckar L<f6>wen")

#2 players play in the national team

# (f) which Verein has the most players in the national team? 
owndata%>%
  group_by(Verein)%>%
  count()%>%
  arrange(desc(n))

# A tibble: 12 x 2
# Groups:   Verein [12]
#Verein                        n
#<chr>                     <int>
# 1 THW Kiel                      3
# 2 TSV Hannover-Burgdorf         3
# 3 "F\xfcchse Berlin"            2
# 4 "Rhein-Neckar L\xf6wen"       2
# 5 TBV Lemgo                     2

#THW Kiel as well as TSV Hannover have the most players in the national team 

# (g) which team puts the best players (most goals)?
owndata%>%
  group_by(Verein)%>%
  arrange(desc(Tore))

#Paris-St-Germain puts the best player

## A tibble: 19 x 8
# Groups:   Verein [12]
#Nr. Name    Geburtstag Position Verein      LS  Tore `T/S`
#<int> <chr>   <chr>      <chr>    <chr>    <int> <int> <chr>
# 1     3 Uwe Ge~ 26.10.1986 LA       Paris S~   156   722 4,6  
# 2    24 Patric~ 04.07.1989 RA       "Rhein-~   128   345 2,7  
# 3    17 Steffe~ 19.07.1986 RR       THW Kiel   111   279 2,5  
# 4     7 Patric~ 22.03.1989 KR       THW Kiel   118   269 2,3 

# (h) Zusammenhang Jahrgang + Länderspiele
ggplot(owndata_sep, aes(x = Geburtsjahr, y = LS))+
  geom_point(position = "Jitter")+
  geom_smooth()+
  labs(title = "Zusammenhang Jahrgang + Erfahrung",
        x = "Jahrgang", 
        y = "Länderspiele",
       caption = "Data from: https://de.wikipedia.org/wiki/Deutsche_M%C3%A4nner-Handballnationalmannschaft
")

#ältere Spieler haben tendenziell mehr Spielerfahrung (mehr Länderspiele),
#die meisten Spieler sind im Jahrgang 1989

owndata_sep%>%
  group_by(Geburtsjahr)%>%
  count()%>%
  arrange(desc(n))



