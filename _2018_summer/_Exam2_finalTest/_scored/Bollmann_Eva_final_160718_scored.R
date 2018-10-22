## Final exam  | Data science for psychologists (Summer 2018)
## Name: Bollmann, Eva Amelie | Student ID: 01/947103
## 2018 07 16
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

# when reading the exam, I greatly advise to use "Shipt + O" because I structured the exam like that.

## Preparations: --------------------------------------------- 

library(tidyverse)


pts <- 0 # counter for points.

## Task 1: Plants -------------------------------------------

# (1a) Save data as tibble and inspect data:------------------
pg <- as_tibble(PlantGrowth)
pg
# Answer:
# -> The dimensions of PlantGrowths are 30 x 2. 
#    The data therefore contains 30 cases (rows) and 2 variables (columns). 

# (1b) compute the number of observations (rows) in each group ------ 
##     and give key descriptives
pg %>%
  group_by(group) %>%
  summarise(n())
# Answer:
# -> In each Group (ctrl, trt1, trt2) are each 10 observations.
#________________________________

pg %>%
  group_by(group) %>%
  summarise(
    mn = mean(weight),
    md = median(weight),
    sd = sd(weight)
  )
# Answer:
# -> Key descriptives (mean, median, standart deviation) of the 
#    of the plants under the different conditions are: 
#*****************************************************
# A tibble: 3 x 4
#group    mn    md    sd
#<fct> <dbl> <dbl> <dbl>
# 1 ctrl   5.03  5.15 0.583
# 2 trt1   4.66  4.55 0.794
# 3 trt2   5.53  5.44 0.443
#*****************************************************

#________________________________

# (1c) create a graph that shows median and raw values of weight by group -----
# Boxplot
ggplot(data = pg, mapping = aes(x = group, y = weight)) + 
  geom_boxplot(fill=NA) +
  geom_point(aes (colour = group), position = "jitter")+
  labs(colour = "Type of Plant", x = "Type of Plant", y = "Weight", title = "Destribution of Weight of Different Plants", caption = "Dobson, A. J. (1983) An Introduction to Statistical Modelling. London: Chapman and Hall.")

# Answer:
# -> The thick bar within the boxes show the median of each group. 
#    The single observation of each group are in the assigned colour. 
#_________________________________

pts <- pts + 5  # excellent!


## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~----
## Task 2: Hot and Wet flights--------------------------------------------
library(nycflights13) # load package


# (2a) save as tibble "wt" and report dimensions -----------------------------

wt <- as_tibble(nycflights13::weather)
wt

# Answer:
# -> Dimensions: The tibble "wt" has the dimensions 26130 x 15
#    The data therefore contains 26130 cases (rows) and 15 variables (columns).
#____________________________________

# (2b) missing values and unknowns -------------------------------------

#     How many missing (NA) values does sw contain? --------------------
# Problem with the question:
View(wt) # there is no variable "sw", I therefore assume the first questions is:
#          "How many missing (NA) values does wt contain?" 
# (indeed)

wt %>%
 summarise(
 wt_NA = sum(is.na(wt)))
# Answer:
# -> the number of missing values in the tibble "wt" is 3157
#_______________________________


#     What is the percentage of missing (NA) values in wt? --------------------
#Percentage = Number of Missing values per number of total (possible) 
#   values, including the missing values, multiplied by 100 

26130*15 # is number of total possible values
3157 # number of missing values
(3157 / (26130*15))*100

# Answer:
# -> 0.81 percent of the values in the dataset are NA (missing values)

# Correct (but see quicker solutions):
sum(is.na(wt))  # sum of NA values
mean(is.na(wt)) # percentage

#_______________________________


#     What is the range (i.e., min and max value) of the year variable? --------------------

wt %>%
  arrange(year) %>%
  summarise(min(year), max(year))

# Answer:
# -> The range of variable "year" is from 2013 (min) to 2013(max). 
#    Therefore all oberservation took place in the year 2013.

# Correct (but see quicker solution):
range(wt$year)

#____________________________________

# (2c) how many observations (rows) for each airport? -------------------------------------

wt %>%
  group_by(origin)%>%
  count()

#*****************************************************
# # A tibble: 3 x 2
# Groups:   origin [3]
#origin     n
#<chr>  <int>
#1 EWR     8708
#2 JFK     8711
#3 LGA     8711
#*****************************************************

# Answer:
# -> for the airports JFK and LGA, there are 8711 observations and for the airport EWR, there are 8708 observations.
#______________________________

# (2d) Compute new var temp_dc to new dataset wt_2 -------------------------------------
wt_2 <- wt %>%
  mutate(temp_dc = ((temp - 32) * 5/9)) %>%
  select(origin, year, month, day, hour, temp, temp_dc, everything() )

wt_2
# View(wt_2)

# (2e) only JFK: dates with coldest, hottest temperature -------------------------------------


wt_2 %>%
  filter(origin == "JFK") %>%
  group_by(month, day) %>%
  arrange(temp) %>%
  distinct(month, day, .keep_all = TRUE)

# Answer:
# -> the three days with the coldest temperatures are the 
#       23.01.13 with -11.1 C;
#       24.01.13 with -10.6 C;
#       09.05.13 with -10.5 C # I assume, that this must fault in the dataset, as it is highly unlikely 
#                             to have such cold temperatures in May(I checked it against other sources 
#                             of weather report for May 2013 in New York. The next coldest day was the 25.01.13.

# Correct & good thinking!

#__________________________________________



wt_2 %>%
  filter(origin == "JFK") %>%
  group_by(month, day) %>%
  arrange(desc(temp)) %>%
  distinct(month, day, .keep_all = TRUE) 

# Answer:
# -> the three days with the hottest temperatures are the 
#       18.07.13 with 36.7Â C;
#       16.07.13 with 35.6Â C;
#       15.07.13 with 35.0Â C

# Good!

#__________________________________________

# (2f) Plot the amount of Mean precipitation by month for all airports-------------------------------------
wt_2 %>%
  group_by(origin, month) %>%
  mutate(mn_precip = mean(precip)) %>%
  distinct(month, .keep_all = TRUE) %>%
  ggplot(mapping = aes(x = month, y = mn_precip)) +
  geom_line(aes(colour = origin)) +
  scale_x_continuous(breaks = seq(0, 12, 1))

# I meant only 1 line for all airports, but this is even better. #

#_________________________________________


# (2g) for each airport:-------------------------------------
# excluding extreme cases of precipitation: (greater that 0.30) and plotting total perception


wt_2 %>%
  filter(precip <= 0.30)%>%
  mutate(summer = ifelse(month %in% 4:9, "TRUE", "FALSE") )%>%
  group_by( origin, summer) %>%
  summarise(total = sum(precip),
            mean = mean(precip), 
            sd = sd(precip))

#*************************************************
# A tibble: 6 x 5
# Groups:   origin [?]
#origin summer total    mean     sd
#<chr>  <chr>  <dbl>   <dbl>  <dbl>
#1 EWR    FALSE  10.9  0.00252 0.0142
#2 EWR    TRUE   11.9  0.00271 0.0173
#3 JFK    FALSE  10.3  0.00239 0.0142
#4 JFK    TRUE   10.3  0.00235 0.0156
#5 LGA    FALSE  10.0  0.00232 0.0139
#6 LGA    TRUE    9.21 0.00210 0.0141  
#*************************************************
#Answer: 
# when looking at each Airport, comparing total and mean (at each flight, plus standart deviation) 
#   amount of perception, one can see no clear pattern. Total and mean perception seem to be 
#   greater at EWR, compared to the Other Airports. However, when comaring means and standart deviation, 
#   no value seems to be significantly different to an other value.
#_________________________________________________
 
  
wt_2 %>%
  filter(precip <= 0.30)%>%
  mutate(summer = ifelse(month %in% 4:9, "TRUE", "FALSE") )%>%
  group_by(origin, summer) %>%
  summarise(percip_time = sum(precip),
            sd = sd(precip)) %>%
  ggplot() +
  geom_bar(aes(x = summer, y = percip_time, fill = summer), stat = "identity")+
  labs(x = "Airports",
       y = "Total Perception",
       title = "Perception during time of Year at different Aiports",
       caption = "Source: Dataset nycflights13::weather")+
  scale_x_discrete(labels = c("FALSE" = "Winter", "TRUE" = "Summer"))+
  scale_fill_discrete("Time of Year", 
                      labels=c("Summer", "Winter"))+
    theme(axis.text.x = element_blank(),  axis.ticks = element_blank())+
  facet_wrap(~origin)


pt <- pt + 15 # excellent!
  
#_________________________________________

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~----------




## Task 3: Numeracy vs. intelligence---------------- 
## Load data (as comma-separated file): 
data <- read_csv("http://rpository.com/ds4psy/data/numeracy.csv")  # from online source



# (3a) Dimensions and Percentage of missing values ------------------
data

# Answer:
# -> The dimensions of Data are 1000 x 12.
#    The data therefore contains 1000 cases (rows) and 12 variables (columns). 



data %>%
  summarise(
    wt_NA = sum(is.na(data))) #-> Number of missing values is 130
 ( 130 / (1000*12))*100 

# Answer:
# -> Percentage of missing values is 1.08

# Correct, but quicker:
sum(is.na(data))
mean(is.na(data))

#_______________________________________



# (3b) Split Birthday -----------------------------------
data_a <- data %>%
  separate(bdate, into= c("byear", "bmonth", "bday"), convert = TRUE)
data_a # to check type of variables

#*****************************************************
# A tibble: 1,000 x 14
#name  gender byear bmonth  bday bweekday height blood_type bnt_1 bnt_2 bnt_3 bnt_4  g_iq  s_iq
#<chr> <chr>  <int>  <int> <int> <chr>     <int> <chr>      <int> <int> <int> <int> <int> <int>
#1 I.G.  male    1968     12    14 Sat         169 O+             1     0     0     1   113    99
#2 O.B.  male    1974      4    10 Wed         181 O+             1     1     1    NA   114   100
#3 M.M.  male    1987      9    28 Mon         183 A???             0     1     0     0   108    87
#4 V.J.  female  1978      2    15 Wed         161 A+             0     0     0     0    93   102
#5 O.E.  male    1985      5    18 Sat         164 A???             1     0     0     0   114    83
#6 Q.W.  male    1968      3     1 Fri         172 A+             1     1     1     0   103    NA
#7 H.K.  male    1994      4    27 Wed         157 B???             0     1    NA     0   110    85
#8 T.R.  female  1961      6     5 Mon         167 A+             1     0     1     0   103   103
#9 F.J.  male    1983     10     1 Sat         158 O+             0     0     0     0   107   101
#10 J.R.  female  1941     12    29 Mon         157 O+             1     1     0     1   107   110
# ... with 990 more rows
#*****************************************************

#____________________________________________



# (3c) Born-in-Summer-or-Winter-Variable -----------------------------------
data_b <- data_a %>%
  mutate(summer_born = ifelse(bmonth %in% 4:9, "TRUE", "FALSE")) 

# Answer:
# to see result in front of dataframe:
select(data_b, summer_born, everything())  

# Ok, but rather arrange as follows:
data_b2 <- data_a %>% 
  mutate(summer_born = (bmonth > 3) & (bmonth < 10)) %>%
  select(name:bday, summer_born, everything()) # re-arrange variables
data_b2

#*****************************************************
# A tibble: 1,000 x 15
#summer_born name  gender byear bmonth  bday bweekday height blood_type bnt_1 bnt_2 bnt_3 bnt_4  g_iq
#<chr>       <chr> <chr>  <int>  <int> <int> <chr>     <int> <chr>      <int> <int> <int> <int> <int>
#1 FALSE       I.G.  male    1968     12    14 Sat         169 O+             1     0     0     1   113
#2 TRUE        O.B.  male    1974      4    10 Wed         181 O+             1     1     1    NA   114
#3 TRUE        M.M.  male    1987      9    28 Mon         183 A???             0     1     0     0   108
#4 FALSE       V.J.  female  1978      2    15 Wed         161 A+             0     0     0     0    93
#5 TRUE        O.E.  male    1985      5    18 Sat         164 A???             1     0     0     0   114
#6 FALSE       Q.W.  male    1968      3     1 Fri         172 A+             1     1     1     0   103
#7 TRUE        H.K.  male    1994      4    27 Wed         157 B???             0     1    NA     0   110
#8 TRUE        T.R.  female  1961      6     5 Mon         167 A+             1     0     1     0   103
#9 FALSE       F.J.  male    1983     10     1 Sat         158 O+             0     0     0     0   107
#10 FALSE       J.R.  female  1941     12    29 Mon         157 O+             1     1     0     1   107
# ... with 990 more rows, and 1 more variable: s_iq <int>
#*****************************************************

#_______________________________________


# (3d) Computation of current Age -----------------------------------
# I calculated this exercise to be executed on the 16.07.18, so it 
#   would be the birthday of people with their birthday being the 16.07.xx

data_c <- data_b %>%
  mutate( bdate_today =  ifelse(bmonth >= 8, "after", ifelse(bmonth == 7 & bday >= 17, "after", "before"))) 

data_d <- data_c %>%  
  mutate(age_today = ifelse(bdate_today == "before", 2018 - byear, ifelse(bdate_today == "after", 2018 - byear - 1, NA)), convert = TRUE)

# Answer:
# -> to see result in front of dataframe: 
select(data_d, age_today, bdate_today, everything())
#*****************************************************
# A tibble: 1,000 x 17
#age_today bdate_today name  gender byear bmonth  bday bweekday height blood_type bnt_1 bnt_2 bnt_3 bnt_4
#<chr>     <chr>       <chr> <chr>  <int>  <int> <int> <chr>     <int> <chr>      <int> <int> <int> <int>
#1 49        after       I.G.  male    1968     12    14 Sat         169 O+             1     0     0     1
#2 44        before      O.B.  male    1974      4    10 Wed         181 O+             1     1     1    NA
#3 30        after       M.M.  male    1987      9    28 Mon         183 A???             0     1     0     0
#4 40        before      V.J.  female  1978      2    15 Wed         161 A+             0     0     0     0
#5 33        before      O.E.  male    1985      5    18 Sat         164 A???             1     0     0     0
#6 50        before      Q.W.  male    1968      3     1 Fri         172 A+             1     1     1     0
#7 24        before      H.K.  male    1994      4    27 Wed         157 B???             0     1    NA     0
#8 57        before      T.R.  female  1961      6     5 Mon         167 A+             1     0     1     0
#9 34        after       F.J.  male    1983     10     1 Sat         158 O+             0     0     0     0
#10 76        after       J.R.  female  1941     12    29 Mon         157 O+             1     1     0     1
# ... with 990 more rows, and 3 more variables: g_iq <int>, s_iq <int>, summer_born <chr>
#*****************************************************

# -> or to view variable: 
# View(data_d)

# Very good!

#____________________________________

# (3e) Frequency of blood type by gender -----------------------------------
frq_blood <- data_d %>%
  group_by(blood_type, gender) %>%
  summarise(freq = n())

# Answer:
frq_blood
# -> Console-output:
#*****************************************************
# A tibble: 16 x 3
# Groups:   blood_type [?]
#blood_type gender  freq
#<chr>      <chr>  <int>
#1 Aâ         female    41
#2 Aâ         male      27
#3 A+         female   194
#4 A+         male     158
#5 ABâ        female     5
#6 ABâ        male       4
#7 AB+        female     9
#8 AB+        male      15
#9 Bâ         female     7
#10 Bâ         male       3
#11 B+         female    37
#12 B+         male      44
#13 Oâ         female    34
#14 Oâ         male      34
#15 O+         female   204
#16 O+         male     184
#*****************************************************
#_________________________________________


#       gender as row, blood_type in column------------------
frq_blood %>%
  spread( key = blood_type, value = freq)

#*****************************************************
# A tibble: 2 x 9
#gender  `A???`  `A+` `AB???` `AB+`  `B???`  `B+`  `O???`  `O+`
#<chr>  <int> <int> <int> <int> <int> <int> <int> <int>
#1 female    41   194     5     9     7    37    34   204
#2 male      27   158     4    15     3    44    34   184
#*****************************************************
#______________________________________________

# (3f) Descriptives of height -----------------------------------

#   (a) by gender------------------------------------------------
data_d %>%
  group_by(gender) %>%
  summarise(counts = n(),
            mn_height = mean(height),
            sd_height = sd(height))

#Answer:
#*****************************************************
# A tibble: 2 x 4
#gender counts mn_height sd_height
#<chr>   <int>     <dbl>     <dbl>
#1 female    531      161.      8.79
#2 male      469      173.     11.0 
#*****************************************************
#____________________________________________-


#   (b) by cohort------------------------------------------------

data_d %>%
  mutate(cohort = age_today %/% 10) %>%
  group_by(cohort) %>%
  summarise(counts = n(),
            mn_height = mean(height),
            sd_height = sd(height))

# Note: Consider using age rather than age_today? 
#
# data_f <- data_d %>%
#   mutate(cohort = age %/% 10)

# Answer:
# -> Output from Console:
#*****************************************************
# A tibble: 9 x 4
#   cohort counts mn_height sd_height
#   <dbl>  <int>     <dbl>     <dbl>
#1     1.     31      169.     10.2 
#2     2.    159      171.     12.0 
#3     3.    178      168.     11.9 
#4     4.    168      167.     10.8 
#5     5.    149      166.     10.8 
#6     6.    127      167.     11.5 
#7     7.    119      163.     11.4 
#8     8.     59      160.     12.6 
#9     9.     10      160.      8.82
#*****************************************************
#______________________________________________



# (3g) Plots of height -----------------------------------


#   (a) by gender---------------------------------

data_d %>%
  group_by(gender) %>%
  summarise(counts = n(),
            mn_height = mean(height),
            sd_height = sd(height))%>%
  ggplot(aes(x = gender, y = mn_height))+
  geom_bar(aes(fill=gender), stat = "identity", show.legend = FALSE) +
  geom_errorbar(aes(ymin = mn_height - sd_height, ymax = mn_height + sd_height))+
  labs(x = "Gender", y = "Mean Height", title = "Mean Height by Gender", 
       subtitle = "Error Bars indicate Standart Deviation", caption = "Source: http://rpository.com/ds4psy/data/numeracy.csv")

#-> Men are on average taller than the women (only looked at it deskriptively)
#_________________________________________________

#   (b) by cohort ---------------------------------

data_d %>%
  mutate(cohort = age_today %/% 10) %>%
  group_by(cohort) %>%
  summarise(mn_height = mean(height),
            sd_height = sd(height)) %>%
  ggplot(aes(x = cohort, y = mn_height))+
  geom_bar( stat = "identity", fill = "pink") +
  geom_errorbar( aes (ymin = mn_height - sd_height, ymax = mn_height + sd_height))+
  scale_x_continuous(breaks=seq(0, 9, 1)) +
  labs(x = "Cohort",subtitle = "Error Bars indicate Standart Deviation", y = "Mean Height", title = "Mean Height by Cohort", caption = "Source: http://rpository.com/ds4psy/data/numeracy.csv")

# Answer: 
# -> There is a decrease in height from the youngest to the olderst cohort, 
#    but non of those differences of height between any cohorts are discriptively (no test for significance)
#_________________________________________________
 
# (3h) BNT Scores and Missing values -----------------------------------

data_e <- data_d %>%
  mutate(bnt_score = bnt_1 + bnt_2 + bnt_3 + bnt_4) %>%
  select(bnt_score, everything())

# data_e
# Answer:
# -> New Variable "BNT-Score in first column to show results. Output from Console:
#*****************************************************
# A tibble: 1,000 x 19
#   bnt_score name  gender byear bmonth  bday bweekday height blood_type
#<int> <chr> <chr>  <int>  <int> <int> <chr>     <int> <chr>     
#1         2 I.G.  male    1968     12    14 Sat         169 O+        
#2        NA O.B.  male    1974      4    10 Wed         181 O+        
#3         1 M.M.  male    1987      9    28 Mon         183 Aâ        
#4         0 V.J.  female  1978      2    15 Wed         161 A+        
#5         1 O.E.  male    1985      5    18 Sat         164 Aâ        
#6         3 Q.W.  male    1968      3     1 Fri         172 A+        
#7        NA H.K.  male    1994      4    27 Wed         157 Bâ        
#8         2 T.R.  female  1961      6     5 Mon         167 A+        
#9         0 F.J.  male    1983     10     1 Sat         158 O+        
#10         3 J.R.  female  1941     12    29 Mon         157 O+        
# ... with 990 more rows, and 10 more variables: bnt_1 <int>,
#   bnt_2 <int>, bnt_3 <int>, bnt_4 <int>, g_iq <int>, s_iq <int>,
#   summer_born <chr>, bdate_today <chr>, age_today <dbl>, convert <lgl>
#*****************************************************


data_e %>%
  summarise(n = n(),
    BNT_NA = sum(is.na(bnt_score)))
# Answer:
#-> There are 1000 observations, of which 78 have a missing BNT-Score. 
#   This is due to them having missing values in at least one of the bnt_i- variables.

# correct!

#___________________________________________________________

# (3i) Intelligence Scores -----------------------------------

sum_giq <-  data_e%>%
  summarise(id= "giq",
            n = n(),
            n_NA = sum(is.na(g_iq)),
            mn = mean(g_iq, na.rm = TRUE),
            min = min(g_iq, na.rm = TRUE),
            max = max(g_iq, na.rm = TRUE))

sum_siq <- data_e %>%
  summarise( id = "siq",
             n = n(),
             n_NA = sum(is.na(s_iq)),
             mn = mean(s_iq, na.rm = TRUE),
             min = min(s_iq, na.rm = TRUE),
             max = max(s_iq, na.rm = TRUE)) 

sum_iq <- rbind(sum_giq, sum_siq)
sum_iq
#*****************************************************
# A tibble: 2 x 6
# id        n  n_NA    mn   min   max
#  <chr> <int> <int> <dbl> <dbl> <dbl>
#1 giq    1000    20  102.   73.  139.
#2 siq    1000    30  102.   70.  131.
#*****************************************************
# Answer:
# -> For s_iq there are 30 missing values. For g_iq, there are 20 missing values.
# -> The means are for g_iq and s_iq are both 102, but the ranges differ.
#   range of g_iq: [73, 139]; range of s_iq: [70, 131]

data_e %>%
  filter(!is.na(g_iq)) %>%
ggplot()+
  geom_histogram( mapping = aes(x = g_iq), binwidth = 5, stat = "bin") +
  labs(x = "General Intelligence", y = "Count", 
       title = "Destribution of General Intelligence",
       caption = "Source: http://rpository.com/ds4psy/data/numeracy.csv")



data_e %>%
  filter( !is.na(s_iq)) %>%
  ggplot()+
  geom_histogram(data = data_e, mapping = aes( x = s_iq), binwidth = 5, stat = "bin") +
  labs(x = "Social Intelligence", y = "Count", title = "Destribution of Social Intelligence",
       caption = "Source: http://rpository.com/ds4psy/data/numeracy.csv")


# (3j) Visualize the relationship between g_iq and s_iq -----------------------
data_e %>%
  filter( !is.na(s_iq), !is.na(g_iq)) %>%
  group_by(s_iq, g_iq) %>%
ggplot()  +
  geom_jitter( mapping = aes( x = g_iq, y = s_iq),size = 0.1) +
  geom_smooth(mapping = aes( x = g_iq, y = s_iq), level = 0.99, method = "lm") +
  scale_x_continuous(name = "General Intelligence", limits = c(70, 140) )+
  scale_y_continuous(name = "Social Intelligence", limits = c(70, 140) )+
  labs(  title = "Destribution of Social and General Intelligence", subtitle = "Grey Area around Line indicates 99%-confidence-interval",
       caption = "Source: http://rpository.com/ds4psy/data/numeracy.csv")

# Answer:
# -> It seems as if there is a great variance in each Social Intelligence (SI) and General Intelligence (GI).
#    However, the Variance seems very big, especially in the middle of the destribution and if looking at 
#     the scatterplot only, it is difficult to se any direction of a connection.  
#     The linear regression line has a shallow slope only, which indicates a small correlation only. 
# -> I therefore assume, that there is no significant relationship between SI and GI, but I did not test that for significance.
#    however indicates a slight negative linear relationship, especially for higher General IQ Scores.
#    People with a lower GI-Scores have higher SI-Scores, whereas people with Higher 
#    GI-Score, have lower SI-Scores. Further examinations would need to exclude the effects of outliers and test, whether the relationship survives.
#________________________________________________

# (3k) Numeracy by Gender -------------------------------------------

data_e %>%
  ggplot(aes( x=gender, y = bnt_score, nr.rm =TRUE)) +
  geom_boxplot()+
  labs(x = "Gender", y = "BNT-Score", title = "Destribution of Numeracy by Gender",
       caption = "Source: http://rpository.com/ds4psy/data/numeracy.csv")

data_e %>%
  group_by(gender) %>%
  filter( !is.na(bnt_score))%>%
  summarise(mn = mean(bnt_score),
            sd = sd(bnt_score)) %>%
  ggplot(aes(x = gender, y = mn))+
  geom_bar( aes(fill = gender), stat="identity",show.legend = FALSE) + 
  geom_errorbar( aes(ymin = mn - sd, ymax = mn + sd)) + 
  labs(y = "Mean BNT-Score", x = "Gender", title = "Mean Numeracy Score by Gender",subtitle = "Error Bars indicate Standart Deviation",
       caption = "Source: http://rpository.com/ds4psy/data/numeracy.csv")

#_______________________
data_e %>%
  drop_na(bnt_score, gender) %>%
  ggplot(aes( x=bnt_score, fill = gender)) +
  geom_histogram( stat = "count", position= "dodge" )+
  labs(x = "BNT-Score", y = "Count", title = "Variation of Numeracy by Gender", fill = "Gender",
       caption = "Source: http://rpository.com/ds4psy/data/numeracy.csv")

data_e %>%
  filter( !is.na(bnt_score))%>%
  count(gender)

#**********************
# A tibble: 2 x 2
#gender     n
#<chr>  <int>
#1 female   480
#2 male     442
#**********************


# -> The number of Men and women are unequal, I therefore made another Diagram to show the proportion of gender per BNT-Score:
data_e %>%
  filter(!is.na(bnt_score)) %>%
  ggplot(aes( x=bnt_score, fill = gender)) +
  geom_histogram( stat = "count", position= "fill" )+
  labs(x = "BNT-Score", y = "Proportion by Gender", title = "Relational Destribution of Numeracy by Gender", 
       fill = "Gender", caption = "Source: http://rpository.com/ds4psy/data/numeracy.csv")


# Answer:
# -> The Plots I programmed show simmilar (but different) means of the BNT_Score in Men and Women. 
#     Women scored on average higher than men, but variance was for both groups high.
# -> When looking at the Histogram with the counts of the different scores for women and men being next to each other, 
#    one sees, that the destribution seems similar.
# -> Since the group sizes of men and women seem to be different, the plot with the relational destribution tries to take this into account.
#    It shows, that  higher scores were more often achieved by women. Lower scores were ore often achieved by men.
#__________________________________________________________

# (3l) Effect of Numeracy on Intelligence -------------------------------------------

data_e %>%
  filter(!is.na(bnt_score), !is.na(g_iq), !is.na(s_iq))%>%
  group_by (bnt_score) %>%
  ggplot(position = "dodge") +
  geom_smooth(aes(x = bnt_score, y = g_iq ), colour = "blue", span = 1, fill = "steelblue2", method = "lm") +
  geom_smooth(aes(x = bnt_score, y = s_iq ), colour = "red", span = 1, fill = "salmon1", method = "lm") +
  labs(x = "BNT-Score", y = "Intelligence Quotient", 
       title = " Effect of Numeracy on Intelligence Quotient",
       subtitle= " Blue = General Intelligence, Red = Social Intelligence, \n Areas around Line indicate 95%-confidence-intervals", caption = "Source: http://rpository.com/ds4psy/data/numeracy.csv")
# Answer:
# -> Relations of Numeracy and Intelligence Quotient seem to be linearily related to Social Intelligence and General Inteligence.
# -> Numeracy does seem to significantly differ with General Intelligence, as the Confidence Intervall around the line do not overlap (at y-axis) when comparing for the different BNR-Scores, at least when comparing high and low values. . 
# -> Numeracy does not seem to have an effect on Social Intelligence, as the geom_ribbon (Coloured Confidence Interval around line), but the linear (and other) model(s) should be tested for significance.

# Broadly said: 
# -> People with higher Numeracy have been found to also have higher General Intelligence-Quotients. 
# -> People with higher Numeracy might also have have higher Social Intelligence-Quotients.
# -> High level of Numeracy seems to haven an bigger effect on General Intelligence than on Social Intelligence.

# (3m) Possible Effect of IV on GIQ and SIQ -------------------------------------------


#__________________________________________________________
# ! in all the nummerical tibbles, that I created and saved for task (3m) ,
#   I included the Standartdeviartion to be able to use them for latter plots.
#   I hope it is alright, that I printed those tibbles instead of the single mean-variables 
#   (I see a benefit in observing the whole tibble, becaus eit gives important information about the destribution )
#__________________________________________________________

#     of gender -------------------------------------
#       (a) numerically -----

iq_gender <- data_e %>%
  select(gender, s_iq, g_iq)%>%
  filter(!is.na(g_iq), !is.na(s_iq))%>%
  group_by(gender)%>%
  summarise_each(funs(mean, sd))

# Answer:
iq_gender
#-> numeric output as summery table with mean and sd of each s_iq and g_iq:
#*************************************************
# A tibble: 2 x 5
#   gender s_iq_mean g_iq_mean s_iq_sd g_iq_sd
#  <chr>      <dbl>     <dbl>   <dbl>   <dbl>
#1 female     107.       103.    9.48    9.31
#2 male        96.4      101.    9.18    9.02
#*************************************************
# -> Mean SI of women: 107
# -> Mean SI of men: 96.4
# -> Mean GI of women: 103
# -> Mean GI of men: 101
#________________________________________________
#______________________________________



#       (b) graphically--------------
#reformating the tibble to print nicely:
iq_gen <- iq_gender %>%
  gather(s_iq_mean, g_iq_mean, key = "iq_type_mn", value = "mean") %>%
  gather(s_iq_sd, g_iq_sd, key = "iq_type_sd", value = "sd")
iq_gen$iq_type_sd[iq_gen$iq_type_sd=="s_iq_sd"] <- "Social"
iq_gen$iq_type_mn[iq_gen$iq_type_mn=="s_iq_mean"] <- "Social"
iq_gen$iq_type_sd[iq_gen$iq_type_sd=="g_iq_sd"] <- "General"
iq_gen$iq_type_mn[iq_gen$iq_type_mn=="g_iq_mean"] <- "General"
iq_gen_1 <- iq_gen %>%
  filter(iq_type_mn == "Social" & iq_type_sd =="Social" | iq_type_mn == "General" & iq_type_sd =="General") %>%
  select(-iq_type_sd)

iq_gen_1
#********************************************
# A tibble: 4 x 4
#gender iq_type_mn  mean    sd
#<chr>  <chr>      <dbl> <dbl>
#1 female Social     107.   9.48
#2 male   Social     96.4   9.18
#3 female General    103.   9.31
#4 male   General    101.   9.02
#*********************************************

iq_gen_1 %>%
  ggplot(aes(x=iq_type_mn, y = mean, fill=gender))+
  geom_bar(position = "dodge", stat="identity")+
  geom_errorbar(aes(ymin = mean - sd, ymax = mean +sd), stat = "identity", position="dodge") +
  labs(x = "Types of Intelligence", y = "Intelligence Quotient", fill= "Gender",
       title = "Effect of Gender on Intelligence Quotients", subtitle = "Error Bars indicate Standart Deviation",
       caption = "Source: http://rpository.com/ds4psy/data/numeracy.csv")

#Answer:
#-> Gender differences in General Intelligence do not exist, as the differences in the means
#     are very small, especially compared to standart deviation.
# -> Deskriptively , it seems as if Men are lower in social Intelligence than female. 
#     But because the error bars only indicate standart deviation, I assume that there
#     is also no significant gender effect for Social Intelligence.
#___________________________________________________________



#     of age ----------------------------------------
#       (a) numerically -----------------------------
#           means of s_iq and g_iq per age: ----------------
iq_age <- data_e %>%
  select(age_today, s_iq, g_iq)%>%
  filter(!is.na(g_iq), !is.na(s_iq))%>%
  group_by(age_today)%>%
  summarise_each(funs(mean, sd))

# Answer:
iq_age
# -> means of s_iq and g_iq are grouped by age in the tibble "iq_age". Output from console: (I also computed SD, as it will be useful for further visualisation)
#*************************************************
# A tibble: 77 x 5
#      age_today s_iq_mean g_iq_mean s_iq_sd g_iq_sd
#       <dbl>     <dbl>     <dbl>   <dbl>   <dbl>
#1       16.      98.8     102.    18.1     3.30
#2       17.     105.       99.5    5.32    3.32
#3       18.      97.8     104.     8.20   12.0 
#4       19.     108.      103.    11.0     4.15
#5       20.      97.1     102.     7.41    8.48
#6       21.      99.6     103.     8.91   11.7 
#7       22.      98.8      99.9   16.2     8.55
#8       23.      99.8     102.    13.9     9.23
#9       24.      96.7      99.9    8.92    5.12
#10       25.     103.      101.    10.5     6.49
# ... with 67 more rows
#*************************************************

#           means of s_iq and g_iq per cohort: ----------------
iq_cohort <- data_e %>%
  select(age_today, s_iq, g_iq)%>%
  mutate(cohort = age_today %/% 10) %>% 
           filter(!is.na(g_iq), !is.na(s_iq))%>%
           group_by(cohort)%>%
           summarise_each(funs(mean, sd))

iq_cohort
#*************************************************
# A tibble: 9 x 7
#cohort age_today_mean s_iq_mean g_iq_mean age_today_sd s_iq_sd g_iq_sd
#<dbl>          <dbl>     <dbl>     <dbl>        <dbl>   <dbl>   <dbl>
#1     1.           17.8     102.       103.        1.00    10.9     8.38
#2     2.           24.9     101.       101.        2.50    11.5     8.37
#3     3.           34.5     102.       102.        2.81    10.0     8.40
#4     4.           44.9     102.       102.        2.79    10.7     9.41
#5     5.           54.4     102.       101.        2.86    10.0     9.48
#6     6.           64.9     103.       102.        2.84    10.5     9.52
#7     7.           74.4     102.       101.        2.85    11.3    10.2 
#8     8.           84.0     102.       103.        2.51    11.4     9.09
#9     9.           91.0      98.8      109.        0.866    5.17   15.1 
#*************************************************


#       (b) graphically -----------------------------



iq_age %>%
  ggplot()+
  geom_smooth(mapping = aes(x = age_today, y = s_iq_mean),colour = "deeppink1", fill= "pink1", span = 5)+ #I used span=5 to reduce noise, but still being accurate
  geom_smooth(mapping = aes(x = age_today, y = g_iq_mean),colour = "green3", fill= "green1", span = 5)+
  labs(x = "Age", y = "Intelligence Quotient", 
       title = "Effect of Age on Intelligence Quotient",
       subtitle= "Green = Genereal Intelligence, Pink = Social Intelligence", caption = "Source: http://rpository.com/ds4psy/data/numeracy.csv")
#_____________________________________________________________
# Answer:
# -> Age seems to have different effect on SI and GI. 
# -> SI seems to have a peak in middle age (around 50) and deminish in young and old age. I am not sure abou significance of the effect. I only investigated in a descriptive effect.
# -> GI seems to have a low in middle age (around 45) and be higher in young and  especially old age. I am not sure abou significance of the effect. I only investigated in a descriptive effect.
#_____________________________________________________________

#     of birth season (summer_born) ------------------------
#       (a) numerically -----------------------------

iq_time <- data_e %>%
  select(summer_born, s_iq, g_iq)%>%
  filter(!is.na(g_iq), !is.na(s_iq))%>%
  group_by(summer_born)%>%
  summarise_each(funs(mean, sd))

# Answer:
iq_time
#************************************************
# A tibble: 2 x 5
#summer_born s_iq_mean g_iq_mean s_iq_sd g_iq_sd
#<chr>           <dbl>     <dbl>   <dbl>   <dbl>
#1 FALSE           105.       99.5    9.32    8.16
#2 TRUE             99.1     104.    11.1     9.61
#************************************************
# -> Mean SI of summer-born perople: 99.1
# -> Mean SI of winter-born perople: 105.0
# -> Mean GI of summer-born perople: 99.5
# -> Mean GI of winter-born perople: 104.0
#________________________________________________

#       (b) graphically ------------------------------------------
# restructuring of tibble iq_time for purpose of plotting: (as done for gender)
iq_tim <- iq_time %>%
  gather(s_iq_mean, g_iq_mean, key = "iq_type_mn", value = "mean") %>%
  gather(s_iq_sd, g_iq_sd, key = "iq_type_sd", value = "sd")
iq_tim$iq_type_sd[iq_tim$iq_type_sd=="s_iq_sd"] <- "Social"
iq_tim$iq_type_mn[iq_tim$iq_type_mn=="s_iq_mean"] <- "Social"
iq_tim$iq_type_sd[iq_tim$iq_type_sd=="g_iq_sd"] <- "General"
iq_tim$iq_type_mn[iq_tim$iq_type_mn=="g_iq_mean"] <- "General"
iq_tim_1 <- iq_tim %>%
  filter(iq_type_mn == "Social" & iq_type_sd =="Social" | iq_type_mn == "General" & iq_type_sd =="General") %>%
  select(-iq_type_sd)
iq_tim_1

iq_tim_1 %>%
  ggplot(aes(x=iq_type_mn, y = mean, fill=summer_born))+
  geom_bar(position = "dodge", stat="identity")+
  geom_errorbar(aes(ymin = mean - sd, ymax = mean +sd), stat = "identity", position="dodge") +
  labs(x = "Types of Intelligence", y = "Intelligence Quotient", fill= "Born in Summer",
       title = "Effect of 'Summer-Born' on Intelligence Quotients", subtitle = "Error Bars indicate Standart Deviation",
       caption = "Source: http://rpository.com/ds4psy/data/numeracy.csv")

# Answer:
# -> Differences in both types of IQ-means for winter- and summer-birn hab?ve been found.
# -> There might be a slight interaction effect. 
# -> People Born in Summer seem to have higher GI and lower SI compared to People Born in Winter.
# -> People Born in Winter seem to have higher SI and lower GI compared to People Born in Summer.

#__________________________________________________________


#     of blood type -----------------------------------------------
#       (a) numerically -----------------------------

iq_blood <- data_e %>%
  select(blood_type, s_iq, g_iq)%>%
  filter(!is.na(g_iq), !is.na(s_iq))%>%
  group_by(blood_type)%>%
  summarise_each(funs(mean, sd))

# Answer:
iq_blood
#*******************************************************
# A tibble: 8 x 5
#blood_type   s_iq_mean g_iq_mean s_iq_sd g_iq_sd
#<chr>            <dbl>     <dbl>   <dbl>   <dbl>
#1 A−              94.3     104.    10.5     9.89
#2 A+             104.      102.    10.4     9.04
#3 AB−             98.2      98.8    6.46    9.86
#4 AB+             94.6     103.     7.91    9.87
#5 B−              94.2     101.     7.96   10.9 
#6 B+             103.      103.    10.0     9.28
#7 O−              92.8     102.     8.63    9.29
#8 O+             104.      101.     9.98    9.16
#*******************************************************

#       (b) graphically ------------------------------------------


iq_blood %>%
  ggplot(mapping = aes(x = blood_type, y = g_iq_mean))+
  geom_bar(colour = "green3", fill= "green1", stat= "identity")+
  geom_errorbar(aes(ymin = g_iq_mean - g_iq_sd, ymax = g_iq_mean + g_iq_sd)) +
     labs(x = "Bloodtype", y = " General Intelligence Quotient", 
       title = "Effect of Bloodtype on General Intelligence",subtitle = "Error Bars indicate Standart Deviation",
       caption = "Source: http://rpository.com/ds4psy/data/numeracy.csv")

iq_blood %>%
  ggplot(mapping = aes(x = blood_type , y = s_iq_mean))+
  geom_bar(colour = "deeppink1", fill= "pink1", stat= "identity")+ 
  geom_errorbar(aes(ymin = s_iq_mean - s_iq_sd, ymax = s_iq_mean + s_iq_sd)) +
  labs(x = "Bloodtype", y = " Social Intelligence Quotient", subtitle = "Error Bars indicate Standart Deviation",
       title = "Effect of Bloodtype on Social Intelligence",
        caption = "Source: http://rpository.com/ds4psy/data/numeracy.csv")
#__________________________________________
# Answer:
# -> Bloodtype does not seem to have an effect on General Intelligence, as the means are quote similar, as are the standart deviations.
# -> Bloodtype might have an effect on Social Intelligence, as the means of Social IQ are different among the different blood types. 
#     However, significance is not clear, as errorbars only indicate the standart deviation and no confidence Intervalls. 
#__________________________________________



#     of weekday -----------------------------------------------
#       (a) numerically -----------------------------
iq_weekday <- data_e %>%
  select(bweekday, s_iq, g_iq)%>%
  filter(!is.na(g_iq), !is.na(s_iq))%>%
  group_by(bweekday)%>%
  summarise_each(funs(mean, sd))

# Answer:
iq_weekday
#*******************************************************
# A tibble: 7 x 5
#bweekday    s_iq_mean g_iq_mean s_iq_sd g_iq_sd
#<chr>           <dbl>     <dbl>   <dbl>   <dbl>
#1 Fri           102.     102.     10.8    6.76
#2 Mon           102.     101.     10.3    7.54
#3 Sat           102.     108.     10.4    9.45
#4 Sun           102.     107.     10.6    9.21
#5 Thu           101.      97.9    11.3    9.23
#6 Tue           102.      96.0    10.9    8.73
#7 Wed           102.     102.     10.4    6.41
#*******************************************************


#       (b) graphically ------------------------------------------


iq_weekday %>%
  ggplot(mapping = aes(x = bweekday, y = g_iq_mean))+
  geom_bar(colour = "orange3", fill= "orange1", stat= "identity")+
  geom_errorbar(aes(ymin = g_iq_mean - 1.96*g_iq_sd/sqrt(1000), ymax = g_iq_mean + 1.96*g_iq_sd/sqrt(1000))) +
  labs(x = "Weekday", y = " General Intelligence Quotient", 
       title = "Effect of Weekday of Birth on General Intelligence", subtitle = "Error Bars indicate Standart Deviation",
       caption = "Source: http://rpository.com/ds4psy/data/numeracy.csv")

iq_weekday %>%
  ggplot(mapping = aes(x = bweekday , y = s_iq_mean))+
  geom_bar(colour = "gold2", fill= "gold", stat= "identity")+ 
  geom_errorbar(aes(ymin = s_iq_mean - s_iq_sd, ymax = s_iq_mean + s_iq_sd)) +
  labs(x = "Weekday", y = " Social Intelligence Quotient",  subtitle = "Error Bars indicate Standart Deviation",
       title = "Effect of Weekday of Birth on Social Intelligence",
       caption = "Source: http://rpository.com/ds4psy/data/numeracy.csv")

# -> There are no differences in Social Intelligences found, when comparing for the weekday of birth.
# -> There are deskriptive mean differences of General INtelligence, when looking at weekday of birth, with weekend babies being more generally intelligent.
# -> Data implies an effect of weekday on General Intelligence, but not on Social Intelligence.
#     But Maybe the effect could be explained about a mediator or moderator variable. 
#     (e.g. Socio economical status or Education of parents could influences weekday of birth, due to induction of labour or Cesarian)
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ----

pts <- pts + 30  # very good!



## Task 4: ---------------------------------------------------- 
# Import Data -------------------------------------------------

# Data on Largest Cities
install.packages("htmltab")
library(htmltab)

city_import <- as.tibble( htmltab("https://en.wikipedia.org/wiki/List_of_largest_cities#Largest_cities",2, rm_nodata_cols = F))
 
# Tidy Data ---------------------------------------------------
lrg_city <- city_import %>%
  separate(Nation, into = c( "a", "nation"), sep = 2) %>%
  select(-Image, -a) %>%
  rename( cit_prop = `Population >> City proper`,
          met = `Population >> Metropolitan area`,
          urb = `Population >> Urban area`,
          name = City)%>%
   separate( cit_prop, into= c("p1", "p2", "p3" ), sep = ",") %>% # all variables in the tibble ar characters. Transformation to convert to numeric
  unite(cit_prop, p1, p2, p3, sep ="") %>%
  separate( met, into= c("ma1", "ma2", "ma3" ), sep = ",") %>%
  unite(met, ma1, ma2, ma3, sep ="") %>%
  separate( urb, into= c("ua1", "ua2", "ua3" ), sep = ",") %>%
  unite(urb, ua1, ua2, ua3, sep ="")

lrg_city$cit_prop[lrg_city$cit_prop=="NANANA"] <- "NA"
lrg_city$urb[lrg_city$urb=="NANANA"] <- "NA"
lrg_city$met[lrg_city$met=="NANANA"] <- "NA"

lrg_city$cit_prop <- as.integer(as.character(lrg_city$cit_prop))
lrg_city$urb <- as.integer(as.character(lrg_city$urb))
lrg_city$met <- as.integer(as.character(lrg_city$met))


# View(lrg_city)

lrg_city
#*************************************************
# A tibble: 244 x 5
#name      nation       cit_prop   met       urb
#<chr>     <chr>         <int>    <int>    <int>
#1 Chongqing China      30165500       NA  8189800
#2 Shanghai  China      24256800 24750000 23416000
#3 Delhi     India      11034555       NA 21753486
#4 Beijing   China      21516000 24900000 21009000
#5 Mumbai    India      12478447 12771200 20748395
#6 Dhaka     Bangladesh  8063000 17151925 19580000
#7 Lagos     Nigeria    16060303 21000000 13123000
#8 Chengdu   China      16044700 10376000       NA
#9 Karachi   Pakistan   14910352       NA       NA
#10 Guangzhou China      14043500 44259000 20800654
# ... with 234 more rows
#*************************************************


# -> to tidy data I did :drop useles variables, cleaning up country names, renaming columns,
#     delete comma from values of variables pop, met_area and urb_area (while keeping NAs), convert those variables to ineger 
# lrg.city is composed og 244 observations (individual cities) with the corresponding nation, population and  the metroarea and the urban area.
# By source the connection of metro area and urban area are: 
# A formal local government area comprising the urban area as a whole and its primary commuter areas, typically formed around a city with a large concentration of people (i.e., a population of at least 100,000). In addition to the city proper, a metropolitan area includes both the surrounding territory with urban levels of residential density and some additional lower-density areas that are adjacent to and linked to the city (e.g., through frequent transport, road linkages or commuting facilities).
# I therefore assume, that the metro area is generally bigger, as it shoul consist of the urban area plus the outskirts of the city.

#_______________________________________________

# Missings ----------------------------------------
# -> checking for numers of NAs per Variable
lrg_city %>%
  summarise(n = n(),
            NA_cit_prop = sum(is.na(cit_prop)),
            NA_urb = sum(is.na(urb)),
            NA_met = sum(is.na(met)))
# Answer: 
# -> Number of NA is lowest for Numbers of Populations, but and very high for values of area, especially for urban area.
#**************************************************
# A tibble: 1 x 4
#  n   NA_cit_prop  NA_urb NA_met
# <int>    <int>  <int>  <int>
#1   244      3    206    102
#**************************************************

# Range ---------------------------------------------
lrg_city %>%
  summarise(min_cp = min(cit_prop, na.rm = TRUE),
            max_cp = max(cit_prop, na.rm = TRUE),
            min_urb = min(urb, na.rm = TRUE),
            max_urb = max(urb, na.rm = TRUE),
            min_met = min(met, na.rm = TRUE),
            max_met = max(met, na.rm = TRUE))

#Range of Population Sizes in each Area:
#****************************************************
# A tibble: 1 x 6
#min_cp    max_cp  min_urb   max_urb  min_met   max_met
#<dbl>     <dbl>    <dbl>     <dbl>    <dbl>     <dbl>
#1 1014825. 30165500. 1435185. 36923000. 1200000. 44259000.
#****************************************************


#_______________________________________________
# Countries with highest count of cities among the Largest Cities ------------------------------------
# How many countries contain at least one of the 244 biggest cities, 
# and which are the four countries, that contain the most of the 244 cities, how many?
lrg_city %>%
  group_by(nation) %>%
  summarise(n = n()) %>%
  arrange(desc(n))

#*************************************************
# A tibble: 85 x 2
#nation            n
#<chr>         <int>
#1 China            36
#2 India            17
#3 Japan            11
#4 Brazil           10
#5 United States     9
#6 Iran              8
#7 Pakistan          8
#8 Indonesia         7
#9 Korea, South      7
#10 Russia            7
# ... with 75 more rows
#*************************************************

# Answer:
# 85 countries contain at least one of the 244 biggest cities. 
#   Thus, the 244 biggest cities are scattered across 85 contries.
# The four countries with the most cities listed among the 244 biggest cities are 
#   China (36 cities), India (17 cities), Japan (11 cities) and Brasil(10)

#____________________________________________
# Mean City Proper Population Size by Country ------------------------------------------
# How big is the average city proper (administrative ) population size in each country?

lrg_city %>%
  group_by(nation) %>%
  summarise(n = n(),
            mn_cit_prop = mean(cit_prop)) %>%
  arrange(desc(mn_cit_prop))
#*************************************************
# A tibble: 85 x 3
#nation         n    mn_cit_prop
#<chr>      <int>     <dbl>
#1 DR Congo       1 11855000.
#2 Peru           1  8852000.
#3 Thailand       1  8750600.
#4 China         36  8009901.
#5 Turkey         3  7821333.
#6 Vietnam        2  7635100.
#7 Egypt          3  6362321.
#8 Chile          1  5743719.
#9 Singapore      1  5535000.
#10 Bangladesh     2  5322322.
# ... with 75 more rows
#*************************************************
# -> If one tries to calculate the mean city proper population size, a problem emerges. 
#     Many countries only have very few numbers of cities among the largest-cities-dataset. 
#     Therefore, the number of cities that go into the calculation of the mean vary (e.g. 36 of the 244 largest cities are chinese, but only one is from DR Congo)
#     Therefore, calculation and comparsion of means as is, is difficult. 

# ______________________________________________________________
# I therefore looked at the mean city size only of countries, that had at least 5 cities 
#   among the 244 largest cities:
lrg_city %>%
  filter( !is.na(cit_prop)) %>%
  group_by(nation) %>%
  summarise(n = n(),
            mn_cit_prop = mean(cit_prop),
            sd_mn = sd(cit_prop)) %>%
  filter(n >= 5) %>%
  ggplot( aes(x=reorder(nation, mn_cit_prop), y= mn_cit_prop))+
  geom_bar( stat = "identity",  aes(alpha = n),fill = "blue") + 
  geom_errorbar( aes(ymin = mn_cit_prop - sd_mn ,  ymax = mn_cit_prop+ sd_mn))+ 
  coord_flip()+
  scale_x_discrete( name = "Nation")+
  scale_y_continuous( name = "Mean City Proper Population", labels = scales::comma, limits = c(-800000, 15000000)) +
  theme(axis.text.x=element_text(angle=45,hjust=1))+
  labs(  title = "Mean City Proper Population Size \n by Country ", 
         caption = "Source: https://en.wikipedia.org/wiki/List_of_largest_cities#Largest_cities",
         subtitle = " Error Bars indicate Standart Deviation,\n only countries with at least 5 cities,",
         alpha = "Count of Cities \n among the 244 \n largest Cities")

#____________________________________________________
# -> The order of the countries with biggest mean city proper population seems very different in the now obtained destribution, 
#     compared to the table we extracted before. Note, that the standart deviation is very big. 
#     This probably is a result of the countries cities being very different in size.
#     One can now see, that chinese, pakistanian and indian cities among the largest cities are on average the biggest. 
# -> But the obtained order is still influenced by the absolout size differences of each city. 
#____________________________________________________


# Mean City Proper Population Rank by Country --------------------------------------------------
# -> To find out, which countries have the biggest cities relalatively to the other countries, 
#     I observed the order according to mean ranks. When taking into account a rank, rather than the size of a city, 
#     the absolut difference from the different cities does not get observed.

lrg_city %>%
  filter( !is.na(cit_prop)) %>%
  mutate(rnk = rank(cit_prop)) %>%  # higher rank correspnds to bigger cities.
  group_by(nation) %>%
  summarise(n = n(),
            mn_rnk = mean(rnk),
            sd_rnk = sd(rnk)) %>%
  filter(n >= 5) %>%
  arrange(desc(mn_rnk)) %>%
ggplot( aes(x=reorder(nation, mn_rnk), y= mn_rnk))+
  geom_bar( stat = "identity",  aes(alpha = n),fill = "darkgreen") + 
  geom_errorbar( aes(ymin = mn_rnk - sd_rnk ,  ymax = mn_rnk+ sd_rnk))+ 
  coord_flip()+
  scale_x_discrete( name = "Nation")+
  scale_y_continuous( name = "Mean Rank of City Proper Size", labels = scales::comma, limits = c(-15, 250)) +
  theme(axis.text.x=element_text(angle=45,hjust=1))+
  labs(  title = "Mean City Rank \n by Country",
         caption = "Source: https://en.wikipedia.org/wiki/List_of_largest_cities#Largest_cities",
         subtitle = " Error Bars indicate Standart Deviation, \n only countries with at least 5 cities, \n higher rank corresponds to bigger cities",
         alpha = "Count of Cities \n among the 244 \n largest Cities")
#____________________________________________________
# -> The order is again very different. But what is noticable over all the plots is, that China, 
#     India and Pakistan in both of the last plots, were among the four Countries with biggest
#     cities, concerning city proper population size.
#____________________________________________________



# Relationships of absolute Population Sizes in City Proper, Metropolitan Area and Urban Area -----------------
#____________________________________________________

# 1) Relationship of Population Size in Metropolitan and Urban Area, size of dots indicating the size of city proper population
lrg_city %>%
    filter(!is.na(cit_prop), !is.na(urb), !is.na(met))%>%
  ggplot(aes(x= urb, y =met))+
  geom_point(aes(size = cit_prop)) +
  geom_smooth(span = 500000, se = FALSE, colour = "red") +
  scale_x_continuous( name = "Population in Urban Area", labels = scales::comma)+
  scale_y_continuous( name = "Population in Metropolitan Area", labels = scales::comma) +
  theme(axis.text.x=element_text(angle=45,hjust=1))+
  labs(  title = " Relationship of Population Size \n in Metropolitan and Urban Area", size = "Population Size",
         subtitle = " Size of Point indicate Size of City Proper Population",
       caption = "Source: https://en.wikipedia.org/wiki/List_of_largest_cities#Largest_cities")

#____________________________________________________
# -> There seems to be a quite linear relationship between Metropolitan and Urban Area
#     Population size. But the Relationship to Population size does not seem to be as lineary 
#     (because point size does not get stringetly bigger with higher x- and y-axis).
#____________________________________________________



# 2) Relationship/Correlation of Population size in Urban with Metropolitan Area (withou City Proper size)

lrg_city %>%
  filter( !is.na(met), !is.na(cit_prop), !is.na(urb))%>%
  ggplot(aes(x= urb, y =met))+
  geom_point() +
  geom_smooth(colour = "red", method = "lm") +
  scale_x_continuous( name = "Population in Urban Area", labels = scales::comma,  limits = c(0, 45000000))+
  scale_y_continuous( name = "Population in Metropolitan Area", labels = scales::comma, limits = c(0, 45000000)) +
  theme(axis.text.x=element_text(angle=45,hjust=1))+
  labs(  title = " Relationship of Population \n in Urban and Metropolitan Area", 
         caption = "Source: https://en.wikipedia.org/wiki/List_of_largest_cities#Largest_cities",
         subtitle = "Area around Line indicates 95% confidence interval")

# 3) Relationship/Correlation of Population size in Urban with City Proper Area
lrg_city %>%
  filter( !is.na(met), !is.na(cit_prop), !is.na(urb))%>%
  ggplot(aes(x= urb, y =cit_prop))+
  geom_point() +
  geom_smooth(colour = "red", method = "lm") +
  scale_x_continuous( name = "Population in Urban Area", labels = scales::comma, limits = c(0, 45000000))+
  scale_y_continuous( name = "Population in City Proper", labels = scales::comma, limits = c(0, 45000000)) +
  theme(axis.text.x=element_text(angle=45,hjust=1))+
  labs(  title = "Relationship Population in Urban Area and City Proper", 
         caption = "Source: https://en.wikipedia.org/wiki/List_of_largest_cities#Largest_cities",
         subtitle = "Area around Line indicates 95% confidence interval")


# 4)R elationship/Correlation of Population size of Metropolitan with City Proper Area
lrg_city %>%
  filter( !is.na(met), !is.na(cit_prop), !is.na(urb))%>%
  ggplot(aes(x= met, y =cit_prop))+
  geom_point() +
  geom_smooth(span = 500000,colour = "red", method = "lm") +
  scale_x_continuous( name = "Population in Metropolitan Area", labels = scales::comma,  limits = c(0, 45000000))+
  scale_y_continuous( name = "Population in City Proper", labels = scales::comma, limits = c(0, 45000000)) +
  theme(axis.text.x=element_text(angle=45,hjust=1))+
  labs(  title = "Relationship of Population in Metropolitan Area and City Proper", 
         caption = "Source: https://en.wikipedia.org/wiki/List_of_largest_cities#Largest_cities",
         subtitle = "Area around Line indicates 95% confidence interval")
#____________________________________________________
# -> Visually comparing the the Population size of city proper (administrative), metropolitan 
#     and urban area reveals, that a linear model fits quite well to all three destributions. 

# -> Comparing the slope of the regression lines in the different graphs reveals, that graphs with 
#     the City Proper Population being in the y-axis are more shallow. Graph of metropolitain versus urban population size is much steeper.
#     This might be explicable with the smaller range of the City-Proper-Variable, that I showed in the table above. 

# -> Conclusion: comparing the biggest cities, their metropolitain and urban population sizes differ a 
#    lot more than their City Proper. This finding is probably due to the definitons of the areas. The table consicst 
#    of those cities, that are world biggest in City Proper (taking only the biggest, which therefore similar in size), not regarding metropolitan or urban population size.
#____________________________________________


# -> But the fit of regression lines to the values varies, as indicated by length of Confidential Interval. 

# -> The more observations are included into a regression, the better the fit will be. Because for Urban Area, there are 
#     the most missings, I wil plot the graph city proper versus metropolitan area once again, containing also observations, 
#     where urban population size is missing. This should give a better regression model fit, but be 
#     uncomparable to the graphs including urban population size.


# 5) Relationship/Correlation of Population size of Metropolitan with City Proper Area

lrg_city %>%
  filter( !is.na(met), !is.na(cit_prop))%>%
  ggplot(aes(x= met, y =cit_prop))+
  geom_point(size = 0.5) +
  geom_smooth(span = 500000,colour = "red", method = "lm") +
  scale_x_continuous( name = "Population in Metropolitan Area", labels = scales::comma,  limits = c(0, 45000000))+
  scale_y_continuous( name = "Population in City Proper", labels = scales::comma, limits = c(0, 45000000)) +
  theme(axis.text.x=element_text(angle=45,hjust=1))+
  labs(  title = "Relationship of Population in Metropolitan Area and City Proper", 
         caption = "Source: https://en.wikipedia.org/wiki/List_of_largest_cities#Largest_cities",
         subtitle = "Area around Line indicates 95% confidence interval")
#__________________________________________________
# Graph of Metropolitan Population versus City Proper gave a much more fitted regression model, which is probably due to the 
# The correlation  seems to be greater, because the CI is smaller. The slope of the regression line alo changed, becoming steeper.
#__________________________________________________



# Relationships of Ranks of Population Size in City Proper, Metropolitan Area and Urban Area ------------------

lrg_city %>%
  filter(!is.na(cit_prop), !is.na(urb), !is.na(met))%>%
  mutate(rnk_cp = rank(cit_prop),
         rnk_met = rank(met),
         rnk_urb = rank(urb)) %>%  # higher rank corresponds to bigger cities.
  ggplot(aes(x= rnk_urb, y =rnk_met))+
  geom_point() +
  geom_smooth(span = 500000,  colour = "red", method = "lm") +
  scale_x_continuous( name = "Rank for Urban Area Propulation", labels = scales::comma)+
  scale_y_continuous( name = "Rank for Metropolitan Area Poulation", labels = scales::comma) +
  labs(  title = " Relationship of Ranks \n for Metropolitan and Urban Area Population Size", size = "Population Size",
         caption = "Source: https://en.wikipedia.org/wiki/List_of_largest_cities#Largest_cities",
         subtitle = " Area around Regression Line indicates 95 % Confidencel Interval")



lrg_city %>%
  filter(!is.na(cit_prop), !is.na(urb), !is.na(met))%>%
  mutate(rnk_cp = rank(cit_prop),
         rnk_met = rank(met),
         rnk_urb = rank(urb)) %>%  # higher rank correspnds to bigger cities.
  ggplot(aes(x= rnk_cp, y =rnk_urb))+
  geom_point() +
  geom_smooth(span = 500000,  colour = "red", method = "lm") +
  scale_x_continuous( name = "Rank for City Proper Area Propulation", labels = scales::comma)+
  scale_y_continuous( name = "Rank for Urban Area Poulation", labels = scales::comma) +
  labs(  title = " Relationship of Ranks \n for Urban and City Proper Population Size", size = "Population Size",
         caption = "Source: https://en.wikipedia.org/wiki/List_of_largest_cities#Largest_cities",
         subtitle = " Area around Regression Line indicates 95 % Confidencel Interval")



lrg_city %>%
  filter(!is.na(cit_prop), !is.na(urb), !is.na(met))%>%
  mutate(rnk_cp = rank(cit_prop),
         rnk_met = rank(met),
         rnk_urb = rank(urb)) %>%  # higher rank correspnds to bigger cities.
  ggplot(aes(x= rnk_cp, y =rnk_met))+
  geom_point() +
  geom_smooth(span = 500000,  colour = "red", method = "lm") +
  scale_x_continuous( name = "Rank for City Proper Area Propulation", labels = scales::comma)+
  scale_y_continuous( name = "Rank for Metropolitan Area Poulation", labels = scales::comma) +
  labs(  title = " Relationship of Ranks \n for Metropolitan and City Proper Population Size", size = "Population Size",
         caption = "Source: https://en.wikipedia.org/wiki/List_of_largest_cities#Largest_cities",
         subtitle = " Area around Regression Line indicates 95 % Confidencel Interval")

# -> The three graphs show, that the ranks of metropolitan and urban Area Population size, were related the most, 
#     because the points in that graph scattered the closest around regression line. But for all three graphs,
#     a linear regression line did seem to fit the destribution of points, and relations could all be positive an linear.

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ----


pts <- pts + 5  # Excellent!


## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## By submitting this script I assure that I have completed this 
## script by myself (using only permissible sources of help). 

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##


## Points: 50/50.
## Grade:  1.0 - Well done!

## End of file. ----- 