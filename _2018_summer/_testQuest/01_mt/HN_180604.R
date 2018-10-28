## Mid-term exam  | Data science for psychologists (Summer 2018)
## Name: ... | Student ID: ...
## 2018 06 04
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## Preparations: ----- 

library(tidyverse)



## Task 1: ----- 

## (a) Saving and inspecting data:
sp <- as_tibble(sleep)
dim(sp) # => 20 rows, 3 columns

## Answer: The sleep data contains 20 rows and 3 columns. 

## (b)
# Use a dplyr pipe to compute the number of observations (rows) by group
# and key descriptives (their mean, median, and standard deviation). (2 points)

sp %>%
  group_by(group) %>%
  summarise(mean = mean(extra),
            median = median(extra),
            sd = sd(extra))

## (c). Use ggplot to create a graph that shows the medians and raw values of extra sleep time by group. (2 points)

ggplot(sp, aes(x = group, y = extra, fill = group)) +
  geom_boxplot() +
  geom_jitter()

## (d) Reformat the sleep data in sp so that the 2 groups appear in 2 lines (rows) and 10 subject IDs as 10 columns. (1 point)

sp %>%
  spread(key = ID, val = extra)

## Task 2: ----- 

# (a)
de <- tribble(
  ~party, ~share_2013, ~share_2017, 
  "CDU/CSU", 	.415, 	.33,
  "SPD", 	    .257, 	.205,
  "Others", 	(1 - .415 -  .257), 	(1 - .33 - .205) )

# (b)
de_2 <- de %>%
  gather(share_2013:share_2017, key = "key", value = "share") %>%
  separate(key, into = c("stuff", "year")) %>%
  select(year, party, share)
  
# (c)
de_2

ggplot(de_2, aes(x = year, y = share, fill = party)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("black", "firebrick", "gold"))

## Task 3: -----

## (a)
sw <- dplyr::starwars
sw # 87 rows x 13 columns

## (b)
sum(is.na(sw)) # => 101 NA values

sw %>%
  filter(is.na(homeworld), (!is.na(birth_year) | !is.na(mass))) %>%
  .$name

## (c)

sw %>%
  filter(species == "Human") %>%
  group_by(gender) %>%
  count()

# 35 humans overall, 9 females, 26 males.

sw %>%
  filter(gender != "male", gender != "female") %>%
  .$name

# => 3 individuals:  
# [1] "Jabba Desilijic Tiure"
# [2] "IG-88"                
# [3] "BB8"

# (d) 

sw %>%
  group_by(homeworld) %>%
  count() %>%
  arrange(desc(n))

# => Naboo

sw %>%
  filter(homeworld == "Naboo", eye_color == "orange") %>%
  summarise(mean_height = mean(height, na.rm = TRUE))
  
# => 209 centimeters

# (e)

sw %>%
  filter(species == "Droid") %>%
  summarise(md_height = median(height, na.rm = TRUE), 
            mn_height = mean(height, na.rm = TRUE),
            sd_height = sd(height, na.rm = TRUE))
  
h_m <- sw %>%
  group_by(species) %>%
  summarise(mn_height = mean(height, na.rm = TRUE),
            mn_mass = mean(mass, na.rm = TRUE)) 
h_m

h_m %>%
  arrange(mn_height) %>%
  head(3)

h_m %>%
  arrange(desc(mn_mass)) %>%
  head(3)


## Task 4: ----- 

st <- tribble(
~stock, 	~d1_start, 	~d1_end, 	~d2_start, 	~d2_end, 	~d3_start, 	~d3_end,
"Amada", 	2.5, 	3.6, 	3.5, 	4.2, 	4.4, 	2.8,
"Betix", 	3.3, 	2.9, 	3.0, 	2.1, 	2.3, 	2.5,
"Cevis", 	4.2, 	4.8, 	4.6, 	3.1, 	3.2, 	3.7)

dim(st)

# (b)
st_long <- st %>%
  gather(d1_start:d3_end, key = "key", value = "price") %>%
  separate(key, into = c("day", "time"), sep = "_")

st_long

# (c)

st_long %>%
  filter(time == "end") %>%
  ggplot(aes(x = day, y = price, color = stock)) +
  geom_line(aes(group = stock)) +
  geom_point() +
  theme_bw()

# (d)

st_long %>%
  spread(key = time, value = price) %>%
  select(stock, day, start, end)


## Task 5: ----- 

# (a) 

ir <- datasets::iris
dim(ir) # => 150 rows and 5 columns

sum(is.na(ir)) # => 0 missing (NA) values

# (b)

im1 <- ir %>%
  group_by(Species) %>%
  summarise(mn_S_L = mean(Sepal.Length), 
            mn_S_W = mean(Sepal.Width),
            mn_P_L = mean(Petal.Length), 
            mn_P_W = mean(Petal.Width)
            )
im1

# (c)
ggplot(ir, aes(x = Sepal.Width)) +
  geom_histogram(binwidth = .1, fill = "forestgreen")

# (d)
ggplot(ir, aes(x = Sepal.Width, fill = Species)) +
  facet_wrap(~Species) +
  geom_histogram(binwidth = .1) +
  # coord_fixed() +
  theme_bw()

# (e)
ggplot(ir, aes(x = Sepal.Width, y = Petal.Width, color = Species)) +
  facet_wrap(~Species) +
  geom_point() +
  coord_fixed() +
  theme_bw()

# (f)

ir
ir_long <- ir %>%
  gather(Sepal.Length:Petal.Width, key = "key", value = "val") %>%
  separate(key, into = c("part", "metric"))

# (g)

im2 <- ir_long %>%
  group_by(Species, part, metric) %>%
  summarise(mean = mean(val))
im2

# (h)

ggplot(im2, aes(x = part, y = mean, group = metric, color = metric)) +
  facet_wrap(~Species) +
  geom_line() +
  geom_point(size = 4) +
  theme_bw()


## Task 6: ----- 

## (a) 
data <- read_csv("http://rpository.com/ds4psy/mt/out.csv")
dim(data) # => 1000 rows, 3 columns 

## (b)
sum(is.na(data)) # => 18 missing values

## (c)
data %>%
  group_by(sex) %>%
  count()
  
## => 50.7% females, 49.3% males. 

## (d)
ggplot(data, aes(x = sex, y = height, fill = sex)) +
  geom_violin() +
  geom_jitter(alpha = 1/3)

## (e)
data_out <- data %>%
  mutate(mn_all = mean(height, na.rm = TRUE), 
         sd_all = sd(height, na.rm = TRUE),
         out_all = abs(height - mn_all) > 2 * sd_all) %>%
  group_by(sex) %>%
  mutate(mn_sex = mean(height, na.rm = TRUE), 
         sd_sex = sd(height, na.rm = TRUE),
         out_sex = abs(height - mn_sex) > 2 * sd_sex)
dim(data_out)
  
## (f)
out_1 <- data_out %>%
  filter(out_all, out_sex)
out_1

# => 21 people. 

out_2 <- data_out %>%
  filter(!out_all, out_sex)
out_2

# => 24 people. 

# (g)

ggplot(out_1, aes(x = sex, y = height, fill = sex)) +
  geom_violin() +
  geom_jitter() +
  theme_bw()

# => mostly small women and tall men.

ggplot(out_2, aes(x = sex, y = height, fill = sex)) +
  geom_violin() +
  geom_jitter() +
  theme_bw()

# => only tall women and small men. 

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## End of file. ----- 