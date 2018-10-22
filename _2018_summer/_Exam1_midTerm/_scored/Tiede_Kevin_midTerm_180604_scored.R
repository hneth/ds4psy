## Mid-term exam  | Data science for psychologists (Summer 2018)
## Name: TIede, Kevin | Student ID: 01/889913
## 2018 06 04
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## Preparations: ----- 

library(tidyverse)
pt <- 0 # initialize point score


## Task 1: ----- 

## (a) Saving and inspecting data:
sp <- as_tibble(sleep)
dim(sp)

## Answer: The sleep data contains 20 rows and 3 columns. 



## (b): Descriptives

sp %>%
  group_by(group) %>%
  summarise(
    n = n(),
    mean = mean(extra, na.rm=TRUE),
    median = median(extra, na.rm=TRUE),
    sd = sd(extra, na.rm =TRUE)
  )

## (c) Graph

ggplot(data = sp) + 
  geom_boxplot(mapping = aes(x = group, y = extra)) + 
  geom_point(mapping = aes(x = group, y = extra)) 

## (d) Reformating

Ex1d <- sp %>%
  spread(key = ID, value = extra)
Ex1d

pt <- pt + 6 # excellent!


## Task 2: ----- 

## (a) Creating tibble

de <- tribble(
  ~party, ~`2013`, ~`2017`,
  #--|--|----
  "CDU/CSU", 41.5, 33.0,
  "SPD", 25.7, 20.5,
  "Others", (100-42.5-25.7), (100-33.0-20.5)
)
de

## (b) Converting tibble to tidy table

de_2 <- de %>%
  gather(`2013`, `2017`, key = "year", value = "share")
de_2

table4a %>% 
  gather(`2013`, `2017`, key = "year", value = "share")

## (c) Visualization

ggplot(data = de_2) + 
  geom_bar(mapping = aes(x = year,  y=share, fill = party), stat="identity")

pt <- pt + 6 # excellent!



## Task 3: ----- 

## (a) Saving and inspecting data:
sw <- as_tibble(starwars)
dim(sw)

## Answer: The sleep data contains 87 rows and 13 columns. 


## (b) Missing values
sum(is.na(sw))

## The dataset contains 101 missing values in total.

sw_na <- sw %>%
  filter(is.na(homeworld) ==TRUE & (!is.na(birth_year) ==TRUE | !is.na(mass) ==TRUE))
sw_na      
dim(sw_na)

## ANswer: 3 people have missing homeworld and known birth year or mass.


## (c) Gender issues:

sw %>%
  filter(species =="Human")

sw %>%
  filter(species =="Human")%>%
  group_by(gender) %>%
  summarise (n = n())

## Answer: There are 35 Humans in total. There are 9 females and 26 males.

sw %>%
  group_by(species) %>%
  summarise(n_genders = n_distinct(gender)) %>%
  filter(n_genders >= 2  )

## Answer: There are four species (plus the NA) which have at least two gender types.



## (d) Popular homes and heights:

sw %>%
  group_by (homeworld)%>%
  summarise(n = n()) %>%
  arrange(desc(n))

## Answer: Most individuals come from Naboo (11 individuals).

sw %>%
  filter(eye_color=="orange" & homeworld =="Naboo") %>%
  summarise(mean = mean(height, na.rm=TRUE))

## Answer: The mena height is 208.6667.

## (e) Seize and mass issues:

sw %>%
  filter(species == "Droid") %>%
  summarise (median = median(height, na.rm=TRUE),
             mean = mean(height, na.rm=TRUE),
             sd = sd(height, na.rm=TRUE))

h_m <- sw %>%
  group_by(species) %>%
  summarise (mean_height = mean(height, na.rm=TRUE),
             mean_mass = mean(mass, na.rm=TRUE))
h_m

h_m %>%
  filter( min_rank(mean_height) <= 3)

h_m %>%
  filter( min_rank(desc(mean_mass)) <= 3)

pt <- pt + 12 # perfect.


## Task 4: ----- 

## (a) Tibble

st <- tribble(
  ~stock, ~d1_start, ~d1_end, ~d2_start, ~d2_end, ~d3_start, ~d3_end,
  #--|--|----
  "Amada", 2.5, 3.6, 3.5, 4.2, 4.4, 2.8, 
  "Betix", 3.3, 2.9, 3.0, 2.1, 2.3, 2.5,
  "Cevis", 4.2, 4.8, 4.6, 3.1, 3.2, 3.7
)
st


## (b)
st_long <- st %>%
  gather(d1_start, d1_end,d2_start, d2_end,d3_start, d3_end, key="date", value="price")%>%
  separate(date, into = c("day", "time"))
st_long

st_long
# ggplot(data = mpg) + 
#  geom_point(mapping = aes(x = displ, y = hwy))

## (c) Graph

ggplot(data = st_long) + 
  geom_bar(mapping = aes(x = cut))

ggplot(data = st_long) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

# Better:
st_long %>% 
  filter(time == "end") %>%
  ggplot(aes(x = day, y = price, color = stock, shape = stock)) +
  geom_point(size = 4) + 
  geom_line(aes(group = stock)) 

## (d) Spreading
st_long %>%
  spread( key = time, value = price )

pt <- pt + 4 # well done.

## Task 5: -----

## (a)

ir <-  as_tibble(iris)
dim(ir)
str(ir)
summary(ir)

sum(is.na(ir))

## ANswer: No, there are no missing values in iris.

## (b)
im1 <- ir %>% 
  group_by(Species) %>%
  summarise(mean_Sepal.Length = mean(Sepal.Length),
           mean_Sepal.Width = mean(Sepal.Width),
           mean_Petal.Length = mean(Petal.Length),
           mean_Petal.Width = mean(Petal.Width))
im1

## (c)
ggplot(data = ir) +
  geom_histogram(mapping = aes(x = Sepal.Width), binwidth = 0.1)

## (d)
ggplot(data = ir, mapping = aes(x = Sepal.Width, colour = Species)) +
  geom_freqpoly(binwidth = 0.1)


## (e)
ggplot(data = ir) + 
  geom_point(mapping = aes(x = Sepal.Width, y = Petal.Width)) +
  facet_wrap(~ Species, nrow = 1)

## (f)
ir_long <- ir %>%
  gather(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width, key ="type", value="val") %>%
  separate(type, into =c("part", "metric"))

ir_long

## (g)
im2 <- ir_long %>%
  group_by(Species, part, metric) %>%
  summarise (mean= mean(val))

im2

## Answer: The results are still the same.

## (h)



## (i)
ir_short <- ir_long %>%
  unite(type, part, metric, sep = ".")

ir_short


pt <- pt + 10  # good.


## Task 6: ----- 

## Load data (as comma-separated file): 
data <- read_csv("http://rpository.com/ds4psy/mt/out.csv")  # from online source

## (a)
dim(data)
## Answer: There are 1000 observations and 3 variables


## (b)
sum(is.na(data))
## Answer: There are 18 missing values.

## (c)
data %>%
  group_by(sex) %>%
  summarise(n = n())

## Answer: There are 507 females and 493 males.

## (d)
ggplot(data = data, mapping = aes(x = sex, y = height)) +
  geom_boxplot()

## (e)
data1 <- data %>%
  mutate(
    outlier_overall = ifelse((height > (mean(height, na.rm=TRUE)+ 2*sd(height, na.rm=TRUE)) | height < (mean(height, na.rm=TRUE)- 2*sd(height, na.rm=TRUE)) ), TRUE, FALSE ))
data1  
  
data2 <- data1 %>% group_by(sex) %>%
  mutate(
    outlier_sex = ifelse((height > (mean(height, na.rm=TRUE)+ 2*sd(height, na.rm=TRUE)) | height < (mean(height, na.rm=TRUE)- 2*sd(height, na.rm=TRUE)) ), TRUE, FALSE )) %>%
  ungroup()
data2

data <- data2

# Good, but more straightforward solution when mutate only specifies condition for outliers:
crit <- 2
data_out <- data %>%      
  # 1. Compute means, SD, and outliers for overall sample: 
  mutate(mn_height  = mean(height, na.rm = TRUE),  
         sd_height  = sd(height, na.rm = TRUE),
         out_height = abs(height - mn_height) > (crit * sd_height)) %>%
  group_by(sex) %>%       
  # 2. Compute same metrics for subgroups:
  mutate(mn_sex_height  = mean(height, na.rm = TRUE), 
         sd_sex_height  = sd(height, na.rm = TRUE),
         out_sex_height = abs(height - mn_sex_height) > (crit * sd_sex_height))
data_out

## (f)
data3 <- data %>%
  mutate(out_1 = (ifelse(outlier_overall ==TRUE & outlier_sex == TRUE, TRUE, FALSE))) %>%
  mutate(out_2 = (ifelse(outlier_overall ==FALSE & outlier_sex == TRUE, TRUE, FALSE)))

sum(data3$out_1 == TRUE, na.rm=T)
sum(data3$out_2 == TRUE, na.rm=T)

## Answer: There are 21 participants who are outliers in both measures, but 24 participants who are only outliers in theire sex group.

# Good, but simpler with filter rather than mutate...

pt <- pt + 8  # well done!

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

# Total of 46 points (out of 50).
# Grade: 1.0.  Almost perfect -- congratulations!  

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## End of file. ----- 
