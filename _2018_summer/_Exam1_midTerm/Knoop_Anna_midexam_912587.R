#############################################################

# MID TERM EXAM

# 04.06.2018

# Anna-Katharina Knoop / 912587

# Data Science for Psychologists

#############################################################


library(tidyverse)


# Task 1 ----

# 1a ----

sp <- as.tibble(sleep)

dim(sp)
#  20 rows and 3 columns


# 1b ---- 
#pipe to compute the number of observations (rows) by group
# and key descriptives (their mean, median, and standard deviation)
sp
sp %>%
  group_by(group) %>%
  summarise(
    n = n(),
    mean = mean(extra,na.rm = T),
    sd = sd(extra, na.rm = T))
  
  #   group     n  mean    sd
#<fct> <int> <dbl> <dbl>
#  1 1        10 0.750  1.79
#2 2        10 2.33   2.00


# 1c ----

# Use ggplot to create a graph that shows the medians and raw values of extra sleep time by group


sp %>%
ggplot( mapping = aes( x = group, y = extra)) +
  geom_boxplot() +
  geom_point( mapping = aes ( colour = group), position = "jitter")+
  ggtitle ("Raw values and Medians of extra sleep")
  

# 1d ----

# Reformat the sleep data in sp so that the 2 groups appear in 2 lines (rows) and 10 subject IDs as 10 columns

spread(sp, key = group, value = extra)








# Task 2 ----

#2a ----
#Create a tibble de that contains this data and the missing (?) values for all other parties so that all shares 
# of an election add up to 100%. (2 points)

de <-  tribble(
  ~party, ~share13, ~share2017,
  "CDU/CSU" , .415,	.33,
  "SPD" , .257, 	.205 , 
  "Others" , (1- .415 - .257), (1 - .33 - .205)  )  # ERROR



# 2b ----

# Convert your de table into a "tidy" table saved as de_2. (2 points)


de %>%
  gather(share13:share2017, key = "key", value = "value")



# 2c ----

# Visualize and contrast the election results by a bar chart that contains 2 bars 
#(representing the 2 elections) and the party's share of votes (as the proportions of each bar). (2 points)
de
de %>%
  ggplot(mapping = aes ( fill = party, y = "value", x = "key")) +
  geom_bar(mapping = aes ( group = party))




# Task 3 ----

# 3a  ----
# Save the tibble dplyr::starwars as sw and report its dimensions. (1 point)

sw <- starwars

# 3b ----


# Missing values and known unknowns:
  
  # How many missing (NA) values does sw contain? (1 point)
sum(is.na(starwars))
# 101


# Which individuals come from an unknown (missing) homeworld but have a known birth_year or known mass? (1 point)

sw %>%
  filter( is.na(homeworld) , !is.na(birth_year)| !is.na(mass))
# Yoda, IG88, Qui Gon Jinn

# 3c ----

# How many humans are contained in sw overall and by gender? (1 point)
sw %>%
  group_by(species) %>%
  count() %>%
  filter(species == "Human")
# 35 Humans

starwars %>%
  filter(species == "Human") %>% 
  group_by(gender) %>%
  summarise( n = n()) 
# femanle 9 , male 26

#How many and which individuals in sw are neither male nor female? (1 point)

nichtMuW <-starwars %>%
  filter(gender != "male", gender != "female" )
# 13 Personen sind weder M noch W

print(nichtMuW)  # Ergebnis


# Of which species in sw exist at least 2 different gender values? (1 point) 

starwars %>%
  filter( gender != is.na, )

#3d ---- 



# From which homeworld do the most indidividuals (rows) come from? (1 point)

starwars %>%
  group_by(homeworld) %>%
  summarise( n = n()) %>%
  arrange(desc(n))
# Naboo


# What is the mean height of all individuals with orange eyes from the most popular homeworld? (1 point)

starwars %>%
  filter(homeworld == "Naboo") %>%
  filter(eye_color == "orange") %>%
  summarise( n = n(),
             meanh = mean(height))
# 209 


#3e ----
# ompute the median, mean, and standard deviation of height for all droids. (1 point) 

sw %>%
  filter(species == "Droid") %>%
  summarize( median = median(height),
            mean = mean(height, rm.na = T),
            sd = sd(height, rm.na = T))


# Compute the average height and mass by species and save the result as h_m. (1 point) 

h_m <- sw %>%
  group_by(species) %>%
  summarise( n = n(),
             mn_height = mean(height),
             mn_mass = mean(mass))


# Sort h_m to list the 3 species with the smallest individuals (in terms of mean height). (1 point)

h_m %>%
  arrange(mn_height) %>%
  slice(1:3)


# Sort h_m to list the 3 species with the heaviest individuals (in terms of median mass). (1 point)

h_m %>%
  arrange(desc(mn_mass)) %>%
  slice(1:3)


# Task 4 ----

# 4a ----

st <- tribble(
~stock ,	~d1_start ,	~d1_end, 	~d2_start, 	~d2_end, 	~d3_start, 	~d3_end,
"Amada" ,	2.5 ,	3.6 ,	3.5 ,	4.2 ,	4.4 ,	2.8,
"Betix" ,	3.3 ,	2.9 ,	3.0 ,	2.1 ,	2.3 ,	2.5,
"Cevis" ,	4.2 ,	4.8 ,	4.6 ,	3.1 ,	3.2 ,	3.7)


# 4b ----
# Transform st into a longer table st_long that contains 18 rows and only 1 numeric variable for all stock prices.
# Adjust this table so that the day and time appear as 2 separate columns. (2 points)


st_long <- gather(st, d1_start : d3_end, key = "year", value = "stockprice" ) %>%
  separate(year, into = c("day" , "time"))


st_long

# 4 c ----


# Create a graph that shows the 3 stocks' end prices (on the y-axis) over the 3 
# days (on the x-axis). (1 point)

st_long %>%
  filter(time == "end") %>%
  ggplot( mapping = aes ( x = day , y = stockprice ,color = stock)  ) +
  geom_point()


# 4 d ----
# Spread st_long into a wider table that contains start and
#end prices as 2 distinct variables (columns) for each stock and day. (1 point)

st_long %>%
  spread( key =  "day" , value = "stockprice")





# Task 5 ----

# 5a  ----
#Save datasets::iris a tibble ir that contains this data and inspect it. 
#Are there any missing values?
ir <- as.tibble(iris)
sum(is.na(ir))
# no Missing values


# 5b ----

#Compute a summary table that shows the means of the 4 measurement columns (Sepal.Length, Sepal.Width, 
                  #        Petal.Length, Petal.Width) for each of the 3 Species (in rows). Save the resulting
#table of means as a tibble im1 . (2 points)

im1 <- ir %>%
  summarise(
    mn_SL = mean(Sepal.Length),
    mn_SW = mean(Sepal.Width),
    mn_PW = mean(Sepal.Length),
    mn_PL = mean(Sepal.Length)
  )


# 5c ----

# Create a histogram that shows the distribution of Sepal.Width values across all species. (1 point)

ir %>%
  ggplot( mapping = aes ( x = Sepal.Width)) +
  geom_histogram() +
  ggtitle(" Sepal Width across all species")


# 5d ----

# 5d. Create a plot that shows the shape of the distribution of Sepal.Width values for each species. (1 point)

ir %>%
  ggplot( mapping = aes ( x = Sepal.Width)) +
  geom_histogram() +
  facet_wrap(~ Species)

ir


# 5e ----

# Create a plot that shows Petal.Width as a
#function of Sepal.Width separately (i.e., in 3 facets) for each species. (1 point)

ir %>%
  ggplot( mapping = aes ( x = Sepal.Width)) +
  geom_histogram() +
  facet_grid(Petal.Width ~ Sepal.Width)


# 5f ----

# Re-format your tibble ir into a tibble ir_long which in "long format". (2 points)

ir_long <- ir %>%
  gather(Sepal.Length : Petal.Width, key = "Typ", value = "Wert") %>%
  separate( Typ, into = c("Part", "metric"))


# 5g ----
# Use ir_long to recompute the subgroup means (for each combination of species, plant part,
#and metric) computed in 5b.. Save the resulting table of means as a tibble im2 and verify that
#they have not changed from im1 above. (2 points)

ir_long %>% 
  group_by(Part, metric)  %%
  summarise( mean )



# 5 h

# 5 i

  




# Task 6 ----

## Load data (as comma-separated file): 
data <- read_csv("http://rpository.com/ds4psy/mt/out.csv")  # from online source


# 6.a ----
# Save the data into a tibble data and report its number of observations and variables. (1 point)

data <- as.tibble(data)
dim(data)
# 1000 observations, 3 Variables

# 6.b ----

# How many missing data values are there in data? (1 point)

sum(is.na(data))
# 18 missing Data


#6.c ----

# What is the gender (or sex) distribution in this sample? (1 point)

data %>%
  group_by(sex) %>%
  count()
# female: 507, male: 493



# 6.d ----
# Create a plot that shows the distribution of height values for each gender. (1 point)

data %>%
  ggplot(mapping = aes( x = height)) +
  geom_histogram() +
  facet_wrap( ~ sex)


# 6.e ----

# Compute 2 new variables that signal and distinguish between 2 types of outliers in terms of height:
# outliers relative to the height of the overall sample (i.e., individuals with height values deviating 
#more than 2 SD from the overall mean of height) (1 point);



data %>%
  mutate( out_1 = mean(height).....????? )


# outliers relative to the height of some subgroup's mean and SD. Here, a suitable subgroup to consider 
# is every person's gender (i.e., individuals with height values deviating more than 2 SD from the mean 
#height of their own gender). (1 point)



data %>%
  mutate( out_2 = mean(height).....???? )








