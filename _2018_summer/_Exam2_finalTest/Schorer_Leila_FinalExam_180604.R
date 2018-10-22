## Final exam  | Data science for psychologists (Summer 2018)
## Name: Leila Schorer | Student ID: 01/948611
## 2018 07 18
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## Preparations: ----- 

library(tidyverse)
library(tidyr)
#install.packages("nycflights13")
library(nycflights13)
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## Task 1: Plants ----- 

# (a): ----
# Save data as tibble and inspect data: 
pg <- as_tibble(PlantGrowth)
dim(pg)


## Answer: The PlantGrowth data contains 30 cases (rows) and 
##        2 variables (columns). 

# (b): ----
# Use a dplyr pipe to compute the number of observations (rows) in each
#       group and some key descriptives

pg %>%
  group_by(group) %>%
  summarise(count = n(),
            mn_weight = mean(weight, na.rm = TRUE),
            md_weight = median(weight, na.rm = TRUE),
            sd_weight = sd(weight, na.rm = TRUE))

## Answer: 
## A tibble: 3 x 5
#  group count mn_weight md_weight sd_weight
#  <fct> <int>     <dbl>     <dbl>     <dbl>
# 1 ctrl  10      5.03      5.15     0.583
# 2 trt1  10      4.66      4.55     0.794
# 3 trt2  10      5.53      5.44     0.443


# (c): ----
# Use ggplot to create a graph that shows the medians and raw values of
#      plant weight by group.


(graph1 <- ggplot(data = pg, aes(x = group, y = weight)) +
  geom_boxplot(aes(color = group)) +
  geom_point(position = "jitter") +
  labs(title = "Medians and raw values of plant weight by group",
       y = "Plant Weight",
       color = "Group",
       caption = "Source: Dobson, A. J. (1983) An Introduction to Statistical Modelling.")) 


## Answer: See graph1.

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## Task 2: Hot and wet flights ----- 


# (a): ---- 
# Save the tibble nycflights13::weather as wt and report its dimensions.

wt <- as_tibble(nycflights13::weather)
dim(wt)

## Answer: The ncyflights13::weather data contains 26115 cases (rows) and 
##        15 variables (columns).

# (b): ----
# Missing values and known unknowns

# (b1): How many missing (NA) values does sw (wt?) contain?
sum(is.na(wt))

## Answer: wt (sw?) contains 23974 missing values.

# (b2): What is the percentage of missing (NA) values in wt?
(sum(is.na(wt)) / sum(!is.na(wt)) * 100)

## Answer: The percentage of missing values in wt is 6.519. 

# (b3): What is the range (i.e. minimum and maximum value) of the year variable?

arrange(wt, desc(year))
arrange(wt, year)

# Another way to get the minimum and maximum value of the year variable
wt%>%
  summarise(min(wt$year),
            max(wt$year))


## Answer: As these two commands result in the same output, you can conclude
#          that the range of the year is 0. Meaning that there is only one 
#          year measured (namely 2013).

# (c) ----
# How many observations (rows) does the data contain for each of the 3
#     airports?
wt %>%
  group_by(origin) %>%
  summarise(count = n())

## Answer: 
# A tibble: 3 x 2
# origin count
# <chr>  <int>
# 1 EWR     8703
# 2 JFK     8706
# 3 LGA     8706


# (d): ----
# Compute a new variable temp_dc that provides the temperature (in degrees Celsius)
#      that corresponds to temp (in degrees Fahrenheit)

wt %>%
  mutate(temp_dc = ((temp - 32) * (5/9))) %>%
  select(origin:temp, temp_dc, everything())


# A tibble: 26,115 x 16
#    origin  year     month  day    hour  temp    temp_dc  dewp   humid    wind_dir   wind_speed   wind_gust
#    <chr>   <dbl>    <dbl>  <int>  <int> <dbl>   <dbl>    <dbl>  <dbl>    <dbl>      <dbl>        <dbl>
# 1  EWR     2013     1      1       1    39.0    3.9      26.1   59.4      270       10.4         NA
# 2  EWR     2013     1      1       2    39.0    3.9      27.0   61.6      250        8.06        NA
# 3  EWR     2013     1      1       3    39.0    3.9      28.0   64.4      240       11.5         NA
# 4  EWR     2013     1      1       4    39.9    4.4      28.0   62.2      250       12.7         NA
# 5  EWR     2013     1      1       5    39.0    3.9      28.0   64.4      260       12.7         NA
# 6  EWR     2013     1      1       6    37.9    3.30     28.0   67.2      240       11.5         NA
# 7  EWR     2013     1      1       7    39.0    3.9      28.0   64.4      240       15.0         NA
# 8  EWR     2013     1      1       8    39.9    4.4      28.0   62.2      250       10.4         NA
# 9  EWR     2013     1      1       9    39.9    4.4      28.0   62.2      260       15.0         NA
# 10 EWR     2013     1      1      10    41      5        28.0   59.6      260       13.8         NA
# ... with 26,105 more rows, and 4 more variables: precip <dbl>, pressure <dbl>,
#   visib <dbl>, time_hour <dttm>


# (e): ---- 
# When only considering "JFK" airport:
# (e1): What are the 3 (different) dates with the (a) coldest and (b) hottest 
#       temperatures at this airport?
# (e1.a): coldest 

wt %>%
  filter(origin == "JFK") %>%
  mutate(temp_dc = ((temp - 32) * (5/9))) %>%
  select(origin, year, month, day, temp_dc, temp) %>%
  arrange(temp)
  


## Answer: The 3 dates with the coldest temperatures at "JFK" airport are 
#          (beginning with the coldest)
#          23rd of January (2013) --> -11.1 °C, 
#          24th of January (2013) --> -10.6 °C,
#          8th  of May (2013)     --> -10.5 °C


# (e1.b): hottest

wt %>%
  filter(origin == "JFK") %>%
  mutate(temp_dc = ((temp - 32) * (5/9))) %>%
  select(origin, year, month, day, temp_dc, temp) %>%
  arrange(desc(temp))

## Answer: The 3 dates with the hottest temperatures at "JFK" airport are
#          (beginning with the hottest)
#          18th July (2013) --> 36.7 °C,
#          16th July (2013) --> 35.6 °C,
#          15th July (2013) --> 35.0 °C

# (f): ----
# Plot the amount of mean precipitation by month for each of the
#      three airports (origin).

# bar graph
(graph2 <- wt %>%
  group_by(month, origin) %>%
  summarise(count = n(),
            mean_precip = mean(precip, na.rm = TRUE)) %>%
  ggplot(aes(x = month, y = mean_precip, fill = origin)) +
  geom_bar(stat = "identity", color = "black", position = "dodge") +
  scale_x_continuous(breaks = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)) +
  labs(title = "Mean precipitation by month for each airiport",
       x = "Month",
       y = "Mean precipitation (in inches)",
       fill = "Airport",
       caption = "Source: ASOS download from lowa Environmental Mesonet") +
  scale_fill_brewer(palette = "Blues") +
  theme_bw())

# line graph
(graph_line <- wt %>%
    group_by(month, origin) %>%
    summarise(count = n(),
              mean_precip = mean(precip, na.rm = TRUE)) %>%
    ggplot(aes(x = month, y = mean_precip, color = origin)) +
    geom_freqpoly(stat = "identity") +
    scale_x_continuous(breaks = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)) +
    labs(title = "Mean precipitation by month for each airiport",
         x = "Month",
         y = "Mean precipitation (in inches)",
         fill = "Airport",
         caption = "Source: ASOS download from lowa Environmental Mesonet") +
    theme_light())


## Answer: See graph2 and graph_line


# (g): ----
# For each of the 3 airports:
# (g1): When excluding extreme cases of precipitation (specifically, values
#       of precip greater than 0.30): Does it rain more during winter months
#       (Oct to Mar) or durign summer months (Apr to Sep)?

# (g2): Plot the total amount of precipitation in winter vs. summer of each
#       airport.

# (g1):

wt %>%
  filter(precip <= .30) %>%
  mutate(summer = month %in% c(4:9)) %>%
  filter(summer == TRUE) %>%
  select(summer, month, precip) %>%
  summarise(count = n(),
            sum_precip_summer = sum(precip))

# # A tibble: 1 x 2
#   count             sum_precip_summer
#   <int>             <dbl>
# 1 13113              47.1
  
wt %>%
  filter(precip <= .30) %>%
  mutate(summer = month %in% c(4:9)) %>%
  filter(summer == FALSE) %>%
  select(summer, month, precip) %>%
  summarise(count = n(),
            sum_precip_winter = sum(precip))

# # A tibble: 1 x 2
#    count             sum_precip_winter
#    <int>             <dbl>
#  1 12948              44.7


## Answer: It rains more during summer months.


# (g2):

(graph_precip_winter_summer <- wt %>%
  filter(precip <= .30) %>%
  mutate(summer = month %in% c(4:9)) %>%
  group_by(summer, origin) %>%
  summarise(count = n(),
            sum_precip_summer = sum(precip)) %>%
  ggplot(aes(x = summer, y = sum_precip_summer)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ origin) +
  labs(title = "Total amount of precipitation in winter vs. summer by each airport",
       x = "Summer",
       y = "Precipitation",
       caption = "Source: ASOS download from lowa Environmental Mesonet") +
  theme_bw()
  )

## Answer: See graph_precip_winter_summer.

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## Task 3: Numeracy vs. intelligence ----- 

## Load data (as comma-separated file): 
data <- read_csv("http://rpository.com/ds4psy/data/numeracy.csv")  # from online source

# (A) Basics: ----

# (a) ----
# Inspect the data dimensions and the percentage of missing values.
dim(data)
((sum(is.na(data)) / sum(!is.na(data))) * 100)


## Answer:  The data set contains 1000 cases (rows) and 12 variables (columns). 
##          The percentage of missing values is 1.095.

# (b) ----
# Split the birth date (bdate) variable into 3 separate variables 
#     (byear, bmonth, and bday) that denote the year, month, and day of
#     each participants birth.
(data_sep <- data %>%
  separate(col = bdate, into = c("byear", "bmonth", "bday"), 
           sep = "-", convert = TRUE))

## Answer: 
# A tibble: 1,000 x 14
#    name  gender byear bmonth  bday bweekday height blood_type bnt_1 bnt_2 bnt_3 bnt_4
#    <chr> <chr>  <int>  <int> <int> <chr>     <int> <chr>      <int> <int> <int> <int>
# 1  I.G.  male    1968     12    14 Sat         169 O+             1     0     0     1
# 2  O.B.  male    1974      4    10 Wed         181 O+             1     1     1    NA
# 3  M.M.  male    1987      9    28 Mon         183 A−             0     1     0     0
# 4  V.J.  female  1978      2    15 Wed         161 A+             0     0     0     0
# 5  O.E.  male    1985      5    18 Sat         164 A−             1     0     0     0
# 6  Q.W.  male    1968      3     1 Fri         172 A+             1     1     1     0
# 7  H.K.  male    1994      4    27 Wed         157 B−             0     1    NA     0
# 8  T.R.  female  1961      6     5 Mon         167 A+             1     0     1     0
# 9  F.J.  male    1983     10     1 Sat         158 O+             0     0     0     0
# 10 J.R.  female  1941     12    29 Mon         157 O+             1     1     0     1
# ... with 990 more rows, and 2 more variables: g_iq <int>, s_iq <int>

# (c): ----
# Create a new variable summer_born that is TRUE when a participant
#      was born in summer (April to September) and FALSE when a person was 
#      born in winter (October to March).

data_sep %>%
  mutate(summer_born = bmonth %in% c(4:9)) %>%
  select(name, byear, bmonth, bday, summer_born)

## Answer:
# A tibble: 1,000 x 5
#    name   byear   bmonth bday summer_born
#    <chr>  <int>   <int>  <int> <lgl>      
#  1 I.G.   1968     12     14   FALSE      
#  2 O.B.   1974      4     10   TRUE       
#  3 M.M.   1987      9     28   TRUE       
#  4 V.J.   1978      2     15   FALSE      
#  5 O.E.   1985      5     18   TRUE       
#  6 Q.W.   1968      3      1   FALSE      
#  7 H.K.   1994      4     27   TRUE       
#  8 T.R.   1961      6      5   TRUE       
#  9 F.J.   1983     10      1   FALSE      
# 10 J.R.   1941     12     29   FALSE      
# ... with 990 more rows

# (B) Assessing IVs: ----

# (d): ----
# Compute the current age of each participant as the person would report
#      it (i.e., in completed years, taking into account today's date).

# ???

# (e): ----
# List the frequency of each blood type by gender and reformat your tibble
#      into a wider format that lists the types of gender in rows and the 
#      types of blood_type as columns

(blood_gender <- data_sep %>%
  group_by(gender, blood_type) %>%
  summarise(count = n()))

# Long format:
# A tibble: 16 x 3
# Groups:   gender [?]
#    gender  blood_type count
#    <chr>   <chr>      <int>
# 1  female  A−            41
# 2  female  A+           194
# 3  female  AB−            5
# 4  female  AB+            9
# 5  female  B−             7
# 6  female  B+            37
# 7  female  O−            34
# 8  female  O+           204
# 9  male    A−            27
# 10 male    A+           158
# 11 male    AB−            4
# 12 male    AB+           15
# 13 male    B−             3
# 14 male    B+            44
# 15 male    O−            34
# 16 male    O+           184

(blood_gender_wide <- blood_gender %>%
  spread(key = blood_type, value = count))

## Answer: Wide format:

# A tibble: 2 x 9
# Groups:   gender [2]
# gender  `  A−`  `A+` ` AB−` `AB+`  `B−`  `B+`  `O−`  `O+`
# <chr>      <int> <int> <int> <int> <int> <int> <int> <int>
# 1 female    41   194     5     9     7    37    34   204
# 2 male      27   158     4    15     3    44    34   184


# (f): ----
# Compute descriptives (the counts, means, and standard deviation) of height
#      (a) by gender and 
#      (b) by cohort (i.e. the decade of birth)


# (fa) 
data_sep %>%
  group_by(gender) %>%
  summarise(count = n(),
            mean_height = mean(height, na.rm = TRUE),
            sd_height = sd(height, na.rm = TRUE))

## Answer:
# A tibble: 2 x 4
#   gender   count      mean_height sd_height
#   <chr>    <int>      <dbl>       <dbl>
# 1 female   531        161.        8.79
# 2 male     469        173.        11.0 



# (fb) 
data_sep %>%
  mutate(cohort = (byear - byear %% 10)) %>%
  group_by(cohort) %>%
  summarise(count = n(),
            mean_height = mean(height, na.rm = TRUE),
            sd_height = sd(height, na.rm = TRUE))


## Answer:
# A tibble: 9 x 4
#     cohort count      mean_height sd_height
#     <dbl>  <int>      <dbl>       <dbl>
# 1   1920    12        161.         8.37
# 2   1930    70        161.        13.0 
# 3   1940   131        164.        11.0 
# 4   1950   125        167.        11.7 
# 5   1960   154        165.        10.9 
# 6   1970   160        167.        10.3 
# 7   1980   180        168.        11.9 
# 8   1990   151        171.        12.0 
# 9   2000    17        172.        11.6 


# (g): ----
# Visualize the distribution of height (a) by gender and (b) by cohort.
#      What do you find?

# (ga) height by gender
(graph_height_gender <- data_sep %>%
  ggplot(aes(x = gender, y = height)) +
  geom_boxplot() +
  labs(title = "Distribution of height by gender",
       x = "Gender",
       y = "Height (in cm)",
       caption = "Source: http://rpository.com/ds4psy/data/numeracy.csv") +
  theme_bw())

## Answer: See graph_height_gender 
#          One finds that men are taller than women. 
# (gb) height by cohort
(data_sep_cohort <- data_sep %>%
  mutate(cohort = (byear - byear %% 10)))

typeof(data_sep_cohort$cohort)
# [1] "double"

(data_sep_cohort$cohort <- as.factor(data_sep_cohort$cohort))
str(data_sep_cohort)
 

# Graph:
(graph_height_cohort <- data_sep_cohort %>%
  ggplot(aes(x = cohort, y = height)) +
  geom_boxplot() +
  labs(title = "Distribution of height by cohort",
       x = "Cohort",
       y = "Height in cm",
       caption = "Source: http://rpository.com/ds4psy/data/numeracy.csv") +
  theme_bw())

typeof(data_sep$height)

## Answer: See graph_height_cohort
#          One finds that people generally became taller (although there is
#          a downward trend in 2000). 


# (C): Assessing DVs: ----

# (h) ----
# Compute the aggregate BNT score as the sum of all four bnt_i values
#     (i.e. value varying from 0 to 4) for each participant. How many missing 
#     values are there?

# BNT score for each participant
(BNT_score <- data_sep %>%
  mutate(BNT_score = (bnt_1 + bnt_2 + bnt_3 + bnt_4), na.rm = TRUE) %>%
  select(name, BNT_score))
## Answer: See BNT_score.
# A tibble: 1,000 x 2
# name  BNT_score
# <chr>     <int>
# 1 I.G.          2
# 2 O.B.         NA
# 3 M.M.          1
# 4 V.J.          0
# 5 O.E.          1
# 6 Q.W.          3
# 7 H.K.         NA
# 8 T.R.          2
# 9 F.J.          0
# 10 J.R.          3
# ... with 990 more rows

# missing values
sum(is.na(BNT_score$BNT_score))

## Answer: There are 78 missing values in BNT_score column.


# (i): ----
# Inspect the values for the 2 intelligence scores g_iq and s_iq:

# (ia): How many missing values are there?
data_sep %>%
  summarise(missing_g_iq = sum(is.na(g_iq)),
            missing_s_iq = sum(is.na(s_iq)))

## Answer: There are 20 missing values in the g_iq intelligence score and
#          30 missing values in the s_iq intelligence score.

# (ib): What are their means and their ranges (minimum and maximum values)?

data_sep %>%
  summarise(mn_g_iq = mean(g_iq, na.rm = TRUE),
            mn_s_iq = mean(s_iq, na.rm = TRUE),
            min_g_iq = min(g_iq, na.rm = TRUE),
            max_g_iq = max(g_iq, na.rm = TRUE),
            min_s_iq = min(s_iq, na.rm = TRUE),
            max_s_iq = max(s_iq, na.rm = TRUE))

## Answer:
# A tibble: 1 x 6
#     mn_g_iq  mn_s_iq  min_g_iq  max_g_iq  min_s_iq  max_s_iq
#     <dbl>    <dbl>    <dbl>     <dbl>     <dbl>     <dbl>
# 1   102.     102.     73        139       70        131


# (ic): Plot their distributions in 2 separate histograms.

(graph_g_iq <- ggplot(data_sep, aes(x = g_iq)) +
  geom_histogram(binwidth = 1) +
  labs(title = "Distribution of general intelligence",
       x = "General intelligence",
       y = "Count",
       caption = "Source: numeracy.csv (http://rpository.com/ds4psy/data/numeracy.csv)") +
  theme_light())

## Answer: See graph_g_iq

(graph_s_iq <- ggplot(data_sep, aes(x = s_iq)) +
  geom_histogram(binwidth = 1) +
  labs(title = "Distribution of general intelligence",
       x = "Social intelligence",
       y = "Count",
       caption = "Source: numeracy.csv (http://rpository.com/ds4psy/data/numeracy.csv)") +
  theme_light())

## Answer: See graph_s_iq

# (j): ----
# Visualize the relationship between g_iq and s_iq. Can you detect a 
#      systematic trend?


(graph_g_s_iq <- ggplot(data_sep, aes(x = g_iq, y = s_iq)) +
  geom_point(alpha = .2) +
  geom_smooth()) +
  labs(title = "Relationship between general intelligence and social intelligence",
       x = "General Intelligence",
       y = "Social Intelligence",
       caption = "Source: numeracy.csv (http://rpository.com/ds4psy/data/numeracy.csv)") +
  theme_light()

## Answer:See graph_g_s_iq
#         Yes, people with lower to average general intelligence seem to have higher
#         social intelligence than people with high general intelligence do. 

# (D): Exploring results ----

# (k): ----
# Does numeracy (as measured by the aggregate BNT score) seem to vary
#      by gender?

data_sep %>%
  mutate(BNT_score = (bnt_1 + bnt_2 + bnt_3 + bnt_4)) %>%
  ggplot(aes(x = gender, y = BNT_score)) +
  geom_boxplot()+
  labs(title = "Numeracy by gender",
       x = "Gender",
       y = "BNT Score",
       caption = "Source: numeracy.csv (http://rpository.com/ds4psy/data/numeracy.csv)")

## Answer: Yes, women tend to have better BNT scores than men.

# (l): ----
# Assess possible effects of numeracy (as measured by BNT) on the 2 measures 
#      of intelligence.

(graph_numeracy_intelligence <- 
    data_sep %>%
    mutate(BNT_score = (bnt_1 + bnt_2 + bnt_3 + bnt_4)) %>%
    ggplot(aes(x = g_iq, y = s_iq)) +
    geom_point(alpha = .2) +
    geom_smooth() +
  facet_wrap(~ BNT_score) +
  labs(title = "Effects of numeracy (BNT Score) on intelligence ",
       x = "General Intelligence",
       y = "Social Intelligence",
       caption = "Source: numeracy.csv (http://rpository.com/ds4psy/data/numeracy.csv)") +
  theme_light())

## Answer: See graph_numeracy_intelligence
#          Peope with high numeracy skills and high general intelligence scores seem to
#          have quite low social intelligence scores.
#          All in all you can still see the same trend: people with high general intelligence
#          scores tend to have lower social intelligence scores. This is true for all
#          BNT scores, except for the very low BNT score, where high general intelligence 
#          is associated by higher social intelligence. Still, one has to look at this
#          with caution because the standard deviation is quite high and the sample 
#          is not as big as in the other conditions.

?geom_smooth


# (m): ----
# Assess possible effects of the independent variables
# (m1) gender
# (m2) age 
# (m3) birth season (summer_born)
# (m4) blood type
# (m5) the day of the week in which a person was born (bweekday)

# on each of the 2 types of intelligence in 2 ways

# (ma): numerically (by computing group means) and
# (mb): graphically (by plotting means and/ or distributions)


# (m1a) : Numerically: Possible effects of gender on intelligence

data_sep %>%
  group_by(gender) %>%
  summarise(count = n(),
            mean_s_iq = mean(s_iq, na.rm = TRUE),
            mean_g_iq = mean(g_iq, na.rm = TRUE))

## Answer: Women tend to have higher social intelligence scores than men do
#          The differences in general intelligence scores are way smaller 
#          although women still have a slightly better mean score.
# A tibble: 2 x 4
#   gender  count    mean_s_iq  mean_g_iq
#   <chr>   <int>    <dbl>      <dbl>
# 1 female   531     107.       103.
# 2 male     469     96.5       101.

# (m1b) : Graphically: Possible effects of gender on intelligence

(graph_gender_intelligence <- data_sep %>%
  ggplot(aes(x = g_iq, y = s_iq)) +
  geom_point(alpha = .5) +
  geom_smooth() +
  facet_wrap(~ gender) +
  labs(title = "Effects of gender on intelligence",
       x = "General Intelligence",
       y = "Social Intelligence",
       caption = "Source: numeracy.csv (http://rpository.com/ds4psy/data/numeracy.csv)") +
  theme_light())

## Answer: See graph_gender_intelligence.
#          You can see that women have higher social intelligence scores than men.
#          Women might have slightly higher general intelligence scores than
#          Men but the variation is pretty high here so one cannot tell
#          if there is an acutal effect. 


# (m2a): Numerically Possible effects of age on intelligence
data_sep %>%
  mutate(cohort = (byear - byear %% 10)) %>%
  group_by(cohort) %>%
  summarise(count = n(),
            mean_s_iq = mean(s_iq, na.rm = TRUE),
            mean_g_iq = mean(g_iq, na.rm = TRUE))

## Answer: Social intelligence scores are lower in the oldest cohort then rise
#          until 1940-cohort and then decrease a little or stay the same.
#          General intelligence score is highest in the oldest cohort and then
#          decreases until 1940-cohort and then stays more or less the same.
#          The result for the general intelligence is surprising and not quite
#          plausible as today's general education systems are better and people
#          should have higher general intelligence scores. As there are way fewer
#          participants from the older cohorts it's possible that the results
#          are biased (i.e. maybe only people with high education?). One should
#          look into this in more detail (i.e. comparing education of cohorts)

# A tibble: 9 x 4
#     cohort count   mean_s_iq  mean_g_iq
#     <dbl>  <int>   <dbl>      <dbl>
# 1   1920    12      97.4      105.
# 2   1930    70     101.       104.
# 3   1940   131     103.       101.
# 4   1950   125     102.       102.
# 5   1960   154     102.       102.
# 6   1970   160     103.       102.
# 7   1980   180     102.       102.
# 8   1990   151     100.       101.
# 9   2000    17     100        102.

# (m2b): Graphically: Possible effects of age on intelligence

(graph_cohort_intelligence <- data_sep %>%
  mutate(cohort = (byear - byear %% 10)) %>%
  ggplot(aes(x = g_iq, y = s_iq)) +
  geom_point(alpha = .5) +
  geom_smooth() +
  facet_wrap(~ cohort) +
  labs(title = "Effects of age on intelligence",
       x = "General Intelligence",
       y = "Social Intelligence",
       caption = "Source: numeracy.csv (http://rpository.com/ds4psy/data/numeracy.csv)") +
  theme_light())

## Answer: See graph_cohort_intelligence 
#          

# (m3a): Numerically Possible effects of birth season on intelligence

data_sep %>%
  mutate(summer_born = bmonth %in% c(4:9)) %>%
  group_by(summer_born) %>%
  summarise(count = n(),
            mean_s_iq = mean(s_iq, na.rm = TRUE),
            mean_g_iq = mean(g_iq, na.rm = TRUE))

## Answer: People that were born in summer have higher general intelligence
#          scores than people that were born in winter. At the same time
#          people that are born in summer have lower social intelligence scores
#          than people that are born in winter. It makes sense that people
#          with high general intelligence scores have lower social intelligence
#          scores (we have seen the effect in the data before) but it is not
#          quite plausbible why intelligence varies with birth season in the
#          first place.

# A tibble: 2 x 4
#   summer_born   count    mean_s_iq  mean_g_iq
#   <lgl>         <int>    <dbl>      <dbl>
# 1 FALSE         488      105.        99.6
# 2 TRUE          512       99.2      104. 

# (m3b): Graphically: Possible effects of birth season on intelligence
(graph_birthseason_intelligence <- data_sep %>%
  mutate(summer_born = bmonth %in% c(4:9)) %>%
  ggplot(aes(x = g_iq, y = s_iq)) +
  geom_point(alpha = .5) +
  geom_smooth() +
  facet_wrap(~ summer_born) +
  labs(title = "Effects of birth season on intelligence",
       subtitle = "Note: FALSE = born in winter, TRUE = born in summer",
       x = "General Intelligence",
       y = "Social Intelligence",
       caption = "Source: numeracy.csv (http://rpository.com/ds4psy/data/numeracy.csv)") +
  theme_light())

## Answer: See graph_birthseason_intelligence

# (m4a): Numerically: Possible effects of blood type on intelligence
data_sep %>%
  group_by(blood_type) %>%
  summarise(count = n(),
            mean_s_iq = mean(s_iq, na.rm = TRUE),
            mean_g_iq = mean(g_iq, na.rm = TRUE))

## Answer: General intelligence scores do not vary that much between blood types
#          although the AB- score is a little striking and stands out as it is
#          way lower. This might result from the very small sample compared to the
#          other blood types. 
#          Social intelligence varies a lot between the blood types which is not
#          really plausible, especially because general intelligence does not 
#          vary a lot. It is striking that all "+" blood types have higher 
#          social intelligence (except AB+) than the "-" blood types (except AB-).

# A tibble: 8 x 4
#   blood_type count    mean_s_iq mean_g_iq
#   <chr>      <int>    <dbl>     <dbl>
# 1 A−            68      94.5     104. 
# 2 A+           352     104.      102. 
# 3 AB−            9      98.2      98.8
# 4 AB+           24      94.6     103. 
# 5 B−            10      94.2     101. 
# 6 B+            81     103.      103. 
# 7 O−            68      92.8     102. 
# 8 O+           388     104.      101.

# (m4b): Graphically: Possible effects of blood type on intelligence

(graph_bloodtype_intelligence <- data_sep %>%
    ggplot(aes(x = g_iq, y = s_iq)) +
    geom_point(alpha = .5) +
    geom_smooth() +
    facet_wrap(~ blood_type) +
    labs(title = "Effects of blood type on intelligence",
         x = "General Intelligence",
         y = "Social Intelligence",
         caption = "Source: numeracy.csv (http://rpository.com/ds4psy/data/numeracy.csv)") +
    theme_light())

## Answer: See graph_bloodtype_intelligence

# (m5a): Numerically: Possible effects of the day of the week on which a 
#                     person was born on intelligence

data_sep %>%
  group_by(bweekday) %>%
  summarise(count = n(),
            mean_s_iq = mean(s_iq, na.rm = TRUE),
            mean_g_iq = mean(g_iq, na.rm = TRUE))

## Answer: Social intelligence scores do not vary a lot between the day of the
#          week on which a person was born. There are differences in general
#          intelligence though. People born on Saturday or Sunday have higher 
#          intelligence scores than people born on the other days. 
#          People born on Thursday and Tuesday have lower intelligence scores
#          People born on Friday, Monday and Wedneday have the same mean 
#          intelligence scores, namely 102.

#   bweekday   count    mean_s_iq mean_g_iq
#   <chr>      <int>    <dbl>     <dbl>
# 1 Fri        139      102.      102. 
# 2 Mon        152      102.      102. 
# 3 Sat        143      102.      108. 
# 4 Sun        136      102.      107. 
# 5 Thu        148      101.       97.9
# 6 Tue        149      102.       96.1
# 7 Wed        133      102.      102. 

# (m5b): Graphically: Possible effects of the day of the week on which a 
#                     person was born on intelligence

(graph_bweekday_intelligence <- data_sep %>%
    ggplot(aes(x = g_iq, y = s_iq)) +
    geom_point(alpha = .5) +
    geom_smooth() +
    facet_wrap(~ bweekday) +
    labs(title = "Effects ofthe day of the week on which a person was born on intelligence",
         x = "General Intelligence",
         y = "Social Intelligence",
         caption = "Source: numeracy.csv (http://rpository.com/ds4psy/data/numeracy.csv)") +
    theme_light())

## Answer: See graph_bweekday_intelligence.


## Task 4: Your data, your plot ----

# Source of my data: https://en.wikipedia.org/wiki/List_of_men%27s_footballers_with_50_or_more_international_goals

# Men's footballers with 50 or more international goals

# (a) Loading and saving my data into R ----

mydata <- tribble(
  ~Number, ~Name,              ~Nation,                  ~Confederation,	~International_goals, ~Caps, ~Goals_per_match, ~Career_span,
# --------|-------------------|-------------------------|---------------|---------------------|------|-----------------|--------------|
   1,      "Ali Daei",         "Iran",                    "AFC",          	109, 	                149,   	0.73,           	"1993-2006",	
   2,    	 "Cristiano Ronaldo","Portugal", 	              "UEFA",          	85,	                  154,   	0.56,           	"2003-2018",
   3,      "Ferenc Puskás",	   "Hungary_Spain",           "UEFA",         	84,                  	89,	    0.94,           	"1945-1962",
   4,      "Kunishige_Kamamoto","Japan",	                "AFC",           	80,                 	84,   	0.95,            	"1964-1977",
   5,	     "Godfrey Chitalu",   "Zambia",      	          "AF",           	79,                  	108,   	0.71,             "1968-1980",
   6,   	 "Hussein Saeed",   	"Iraq",             	    "AFC",          	78,                 	137,   	0.57,             "1977-1990",	
   7,   	 "Pelé"	,             "Brazil",     	          "CONMEBOL",      	77,                  	91,    	0.85,            	"1957-1971",
   8,	     "Sándor Kocsis",   	"Hungary",                "UEFA",         	75,                 	68,    	1.10,            	"1948-1956",	
   8,      "Bashar Abdullah",	  "Kuwait",     	          "AFC",          	75,                 	134,   	0.56,            	"1996-2018",
  10,	     "Kinnah Phiri",  	  "Malawi",     	          "CAF",          	71,                 	115,  	0.62,            	"1973-1981",	
  10,      "Majed Abdullah",   	"Saudi Arabia",           "AFC",          	71,                 	116,   	0.61,        	    "1977-1994",	
  10,      "Kiatisuk Senamuang","Thailand",	              "AFC",          	71,                 	134,   	0.53,             "1993-2007",	
  10,      "Miroslav Klose",  	"Germany",   	            "UEFA",         	71,                 	137,   	0.52,            	"2001-2014",	
  14,   	 "Piyapong Pue-on",  	"Thailand", 	            "AFC",          	70,                  	100,   	0.70,           	"1981-1997",	
  14,      "Stern John", 	      "Trinidad and Tobago",    "CONCACAF",     	70,                 	115,   	0.61,            	"1995-2012",	
  14,      "Hossam Hassan",   	"Egypt",        	        "CAF",           	70,                 	169,   	0.41,           	"1985-2006",
  17,   	 "Gerd Müller",   	  "West Germany",	          "UEFA",          	68,                  	62,    	1.10, 	          "1966-1974",	
  17,      "Carlos Ruiz",  	    "Guatemala",  	          "CONCACAF",      	68,                  	132,   	0.52,          	  "1998-2016",	
  17,      "Robbie Keane",     	"Republic of Ireland",    "UEFA",         	68,                  	146,   	0.46,           	"1998-2016",
  20,      "Didier Drogba",  	  "Ivory Coast",	          "CAF",           	65,                 	104,   	0.61,          	  "2002-2014",
  20,      "Lionel Messi",  	  "Argentina",  	          "CONMEBOL",     	65,                  	128,   	0.51,            	"2005-2018",
  22,    	 "Sunil Chhetri",   	"India",            	    "AFC",          	64,                 	101,  	0.63,           	"2005-2018",	
  23,    	 "Ronaldo",        	  "Brazil",          	      "CONMEBOL",     	62,                  	98,    	0.63, 	          "1994-2011",	
  23,      "Zlatan Ibrahimović","Sweden", 	              "UEFA",         	62,                  	116,   	0.53,             "2001-2016",	
  23,      "Ahmed Radhi",    	  "Iraq",	                  "AFC",            62,                 	121,   	0.51,           	"1982-1997",	
  26,   	 "Imre Schlosser",	  "Hungary",        	      "UEFA",        	  59,                 	68,    	0.87,          	  "1906-1927",	
  26,      "David Villa",   	  "Spain",           	      "UEFA",          	59,                 	98,   	0.60,             "2005-2018",	
  28,    	 "Cha Bum-kun",   	  "South Korea",      	    "AFC",          	58,                 	135,   	0.42,         	  "1972-1986",	
  29,    	 "Neymar",            "Brazil",	                "CONMEBOL",      	57,                 	90,    	0.63,            	"2010-2018",	
  29,      "Carlos Pavón",    	"Honduras",          	    "CONCACAF",      	57,                 	101,   	0.56,           	"1993-2010",	
  29,      "Clint Dempsey",   	"United States", 	        "CONCACAF",     	57,                  	141,   	0.40,           	"2004-2018",	
  29,      "Landon Donovan",   	"United States",  	      "CONCACAF",      	57,                  	157,   	0.36,           	"2000-2014",	
  29,      "Younis Mahmoud",  	"Iraq",             	    "AFC",           	57,                 	148,   	0.39,           	"2002-2016",	
  34,	     "Romário",      	    "Brazil",           	    "CONMEBOL",      	55,                 	70,    	0.79,            	"1987-2005",	
  34,      "Kazuyoshi Miura",  	"Japan",           	      "AFC",          	55,                 	89,    	0.62,         	  "1990-2000",	
  34,      "Jan Koller",   	    "Czech Republic",    	    "UEFA",          	55,                 	91,    	0.60,         	  "1999-2009",	
  34,      "Robert Lewandowski","Poland",                 "UEFA",          	55,                  	98,    	0.56,             "2008-2018",	
  34,      "Fandi Ahmad",       "Singapore",        	    "AFC",          	55,                 	101,   	0.55,          	  "1979-1997",	
  34,      "Bader Al-Mutawa", 	"Kuwait",                 "AFC",          	55,                  	162,   	0.32,          	  "2003-2018",	
  40,   	 "Gabriel Batistuta", "Argentina",   	          "CONMEBOL",     	54,                  	77,    	0.70,         	  "1991-2002",	
  40,      "Samuel Eto'o",   	  "Cameroon",        	      "CAF",           	54,                  	118,   	0.46,         	  "1997-2014",
  42,    	 "Joachim Streich",  	"East Germany",   	      "UEFA",   	      53,                 	98,    	0.54,           	"1969-1984",
  42,      "Luis Suárez",     	"Uruguay",       	        "CONMEBOL",      	53,                 	103,   	0.51,             "2007-2018",	
  42,      "Wayne Rooney",	    "England",          	    "UEFA",         	53,            	      119,  	0.44,           	"2003-2016",	
  45,      "Poul Nielsen",   	  "Denmark",	              "UEFA",          	52,                  	38,    	1.37,             "1910-1925",	
  45,      "Ali Ashfaq",     	  "Maldives",      	        "AFC",          	52,                 	78,    	0.66,             "2003-2018",	
  45,      "Edin Džeko",       	"Bosnia and Herzegovina", "UEFA",          	52,                  	89,   	0.59,             "2007-2018",	
  45,      "Jon Dahl Tomasson", "Denmark",       	        "UEFA",         	52,                  	112,   	0.46,          	  "1997-2010",
  45,      "Adnan Al Talyani", 	"United Arab Emirates",	  "AFC",          	52,                 	161,   	0.32,            	"1983-1997",	
  50,    	 "Lajos Tichy",      	"Hungary",               	"UEFA",         	51,                  	72,    	0.71,            	"1955-1971",	
  50,      "Lê Công Vinh",   	  "Vietnam",               	"AFC",          	51,	                  83, 	  0.61,        	    "2004-2016",	
  50,      "Asamoah Gyan",   	  "Ghana",                	"CAF",          	51,                 	106,   	0.48,          	  "2003-2018",	
  50,      "Hakan Şükür",     	"Turkey",               	"UEFA",         	51,                  	112,   	0.46,            	"1992-2007",	
  50,      "Thierry Henry",   	"France",              	  "UEFA",          	51,                 	123,  	0.41,         	  "1997-2010",	
  55,      "Karim Bagheri",	    "Iran",                 	"AFC",          	50,                  	87,   	0.58,       	    "1993-2010",	
  55,      "Phil Younghusband",	"Philippines",            "AFC",           	50,                 	97,    	0.52,             "2006-2018",	
  55,      "Robin van Persie",	"Netherlands",	          "UEFA",         	50,                 	102,   	0.49,           	"2005-2018",	
  55,      "Hwang Sun-hong",	  "South Korea",	          "AFC",	          50,                 	103,   	0.49,           	"1988-2002",	
  55,      "Javier Hernández",	"Mexico",                 "CONCACAF",      	50,                  	106,   	0.48,             "2009-2018",	
  55,      "Tim Cahill",	      "Australia",          	  "OFC/AFC",       	50,                  	107,  	0.47,        	    "2004-2018",	
  55,      "Shinji Okazaki", 	  "Japan",              	  "AFC",          	50,                 	116,   	0.43,             "2008-2018"
)

# What I changed in the dataset and why:
# 1.) In the original dataset all football players with the same amount of international goals were having the same ranking number but they 
#     were clustered so that only the first one actually had a number in front of the name. I added numbers to every player so that there 
#     wouldn't be any NAs.
# 2.) I added underscores ("_") (instead of a space) in column names that consisted of 2 words so that it would be more robust.
# 3.) In the career span column I added "2018" when there was space after the first number (meaning that they still play football) to make it
#     easier to separate the column later.


# (b) Reformat my data ----

(mydata_sep <- mydata %>%
  separate(col = Career_span, into = c("career_begin", "career_end"), sep = "-"))

# Coercing character into factor (career_begin and career_end into factors)

(mydata_sep$career_begin <- as.numeric(mydata_sep$career_begin))

typeof(mydata_sep$career_begin)
#  "double"

(mydata_sep$career_end <- as.numeric(mydata_sep$career_end))

typeof(mydata_sep$career_end)
# "double"

mydata_sep

# (c): Analyzing my data ----

# Who has appeared most often in international games, who has appeared least often?

# least often
mydata_sep %>%
  arrange(Caps)

 # most often
mydata_sep %>%
  arrange(desc(Caps))

# Poul Nielsen has appeared least often in international games and Hossam Hassan has appeared most often in international games.
  
# Which player has the longest career, who has the shortest?

# shortest career
mydata_sep %>%
  mutate(career = (career_end - career_begin)) %>%
  arrange(career) %>%
  select(Number:Nation, career, everything())

# longest career
mydata_sep %>%
  mutate(career = (career_end - career_begin)) %>%
  arrange(desc(career)) %>%
  select(Number:Nation, career, everything())

## Answer: Bashar Abdullah has the longest career (22 years). Interestingly his career is not even over yet! 
# Sandor Kocsis has had the shortest career (8 years).

#longest career
# # A tibble: 61 x 10
#       Number Name    Nation   career Confederation  International_g~  Caps   Goals_per_match career_begin career_end
#       <dbl> <chr>    <chr>     <dbl> <chr>          <dbl>             <dbl>  <dbl>           <dbl>        <dbl>
#  1    8     Bashar~  Kuwait   22     AFC            75                134    0.56            1996         2018
#  2   14     Hossam~  Egypt    21     CAF            70                169    0.41            1985         2006
#  3   26     Imre S~  Hungary  21     UEFA           59                68     0.87            1906         1927

# shortest career
# A tibble: 61 x 10
#   Number Name     Nation  career  Confederation International_g~  Caps    Goals_per_match career_begin career_end
#   <dbl>  <chr>    <chr>    <dbl>  <chr>         <dbl>             <dbl>   <dbl>           <dbl>        <dbl>
# 1 8      Sándor ~ Hungary  8      UEFA          75                68      1.1             1948         1956
# 2 10     Kinnah ~ Malawi   8      CAF           71                115     0.62            1973         1981
# 3 17     Gerd Mü~ West G~  8      UEFA          68                62      1.1             1966         1974

# Which confederation ist the most successful one? (most players in this list --> times listed)
mydata_sep %>%
  group_by(Confederation) %>%
  summarise(count = n())

## Answer: The most successful confederation is AFC.
# A tibble: 7 x 2
#   Confederation   count
#   <chr>           <int>
# 1 AF                1
# 2 AFC              21
# 3 CAF               5
# 4 CONCACAF          6
# 5 CONMEBOL          7
# 6 OFC/AFC           1
# 7 UEFA             20

# Which nation ist the most successful one? (most players in this list --> times listed)

mydata_sep %>%
  group_by(Nation) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

## Answer: Brazil is the most successful country.
# # A tibble: 45 x 2
#   Nation      count
#   <chr>       <int>
# 1 Brazil          4
# 2 Hungary         3
# 3 Iraq            3
# 4 Japan           3

# How many players from this list are from Germany (including East and West)?

mydata_sep %>%
  filter(Nation == "Germany" | Nation == "West Germany" | Nation == "East Germany")

## Answer: There are 3 players from Germany, namely Miroslav Klose, Gerd Müller and Joachim Streich.

# (d): Visualization of my data ----

# Is there a relationship between career years and International goals?

(graph_career_goals <- mydata_sep %>%
  mutate(career = (career_end - career_begin)) %>%
  ggplot(aes(x = career, y = International_goals)) +
  geom_point(position = "jitter") +
  geom_smooth() +
  labs(title = "Relationship between career years and amount of international goals",
       x = "Career (in years)",
       y = "International Goals",
       caption = "Source: https://en.wikipedia.org/wiki/List_of_men%27s_footballers_with_50_or_more_international_goals") +
  theme_light())

## Answer: See graph_career_goals
#          No, there doesn't actually seem to be a clear relationship. 


# Display the relationship between international goals an appearance at international games by confederation and
# label the player with the most and the least goals.

(graph_text <- ggplot(mydata_sep, aes(x = Caps, y = International_goals, color = Confederation)) +
  geom_point(position = "jitter") +
  geom_text(x = 149, y = 109, label = "Daei") +
  geom_text(x = 116, y = 50, label = "Okazaki") +
  labs(title = "Relationship between international goals an appearance 
       at international games by confederation",
       x = "Appearance at international games",
       y = "Internation goals",
       caption = "Source: https://en.wikipedia.org/wiki/List_of_men%27s_footballers_with_50_or_more_international_goals")+
  theme_classic()
)

## Answer: See graph_text

# Relationship between Goals per match and Nation 

(graph_goals_nation <- ggplot(mydata_sep, aes(x = Nation, y = Goals_per_match)) +
    geom_bar(stat = "identity")) +
  labs(title = "Relationship between Goals per match and nations ",
       x = "Nation",
       y = "Goals per match",
       caption = "Source: https://en.wikipedia.org/wiki/List_of_men%27s_footballers_with_50_or_more_international_goals") +
  theme_light() +
  theme(axis.text.x =  element_text(angle = 90)) 

## Answer: See graph_goals_nation


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## By submitting this script I assure that I have completed this 
## script by myself (using only permissible sources of help). 

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## End of file. ----- 