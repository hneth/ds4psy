## Mid-term exam  | Data science for psychologists (Summer 2018)
## Name: Julia Schuhmann | Student ID: 01/947586
## 2018 06 04
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## Preparations: ----- 

library(tidyverse)

## Task 1: ----- 

## (a) Saving and inspecting data:
sp <- as_tibble(sleep)
dim(sp)
?sleep
View(sleep)
## Answer: The sleep data contains 20 rows and 3 columns. 

## (b): Use a dplyr pipe to compute the number of observations (rows) 
#by group and key descriptives (their mean, median, and standard deviation). (2 points)

sp%>%
  group_by(group)%>%
  summarise(mean= mean(extra),
    median= median(extra),
    sd =sd (extra))

## (c): Use ggplot to create a graph that shows the medians and 
#raw values of extra sleep time by group. (2 points)

ggplot(data=sp, mapping=aes(x=group, y=extra))+
  geom_boxplot()+
  geom_point()

?geom_boxplot
?geom_point

## (d): 1d. Reformat the sleep data in sp so that the 2 groups appear 
#in 2 lines (rows) and 10 subject IDs as 10 columns. (1 point)

spread(sp, key=ID, value= extra)

## Task 2: ----- 
## (a) 
de<-tribble(
~"Party",~"Share 2013:",~"Share 2017:",
"CDU/CSU", .415, .33,
"SPD", .257, .205,
"Others", .328, .465)
de

## (b) 2b. Convert your de table into a "tidy" table saved as de_2. 
#Use tidyr::gather to list the values of all election results in 1 
#variable called share and make sure that de_2 contains a separate variable 
#(column) that specifies the election year.
     de_2<- de%>%
        gather(`Share 2013:`, `Share 2017:`, key = "share", value="result")


        +mutate(de_2,
                electionyear= 
        )

de_2

## (c) Visualize and contrast the election results by a bar chart that 
#contains 2 bars (representing the 2 elections) and the party's share 
#of votes (as the proportions of each bar). 




## Task 3: ----- 
## (a) Save the tibble dplyr::starwars as sw and report its dimensions

sw<-as_tibble(starwars)
View(starwars)

#A tibble with 87 rows and 13 variables:

## (b) Missing values and known unknowns:

#How many missing (NA) values does sw contain? (1 point)
  sum(is.na(sw))
  #[1]contains 101 missing values

?is.na

#Which individuals come from an unknown (missing) homeworld 
#but have a known birth_year or known mass? (1 point)

sw%>%
  filter(is.na(homeworld)& !is.na(birth_year)|!is.na(mass))%>%
  count()
  #59 

## (c) Gender issues:

#How many humans are contained in sw overall and by gender? (1 point)

sw%>%
  group_by(species)%>%
  count("Human")
  #38 humans are contained in sw overall

sw%>%
  group_by(gender)%>%
  count("Human")

# gender        `"Human"`     n
#<chr>         <chr>     <int>
# 1 female        Human        19
#2 hermaphrodite Human         1
#3 male          Human        62
#4 none          Human         2
#5 NA            Human         3

## (d) Popular homes and heights:

#From which homeworld do the most indidividuals (rows) come from? (1 point)

sw%>%
  group_by(homeworld)
  count
  arrange()


#What is the mean height of all individuals with orange eyes from the 
#most popular homeworld? (1 point)

sw%>% 
  group_by(eye_color)%>%
  select("orange")%>%
  mean_height<-mean(height)


#How many and which individuals in sw are neither male nor female? (1 point)

sw%>%
  group_by(gender)%>%
  filter(!"male"&!"female")
  
?filter()

#Of which species in sw exist at least 2 different gender values? (1 point)

## (e) 3e. Seize and mass issues:

#Compute the median, mean, and standard deviation of height for all droids. (1 point)

sw%>%
  group_by(species)%>%
  contains(match="droid")

View(starwars)

#Compute the average height and mass by species and save the result as h_m. (1 point)

sw%>%
  group_by(species)%>%
  transmute(h_m<-mean(height))


  
#Sort h_m to list the 3 species with the smallest individuals (in terms of mean height). (1 point)


#Sort h_m to list the 3 species with the heaviest individuals (in terms of median mass). (1 point)



## Task 4: ----- 
## (a) 

## Task 5: ----- 
## (a) Save datasets::iris a tibble ir that contains this data and inspect it. 
        #Are there any missing values?

ir<-as_tibble(iris)

sum(is.na(ir)) #there are no missing values

## (b) Compute a summary table that shows the means of the 4 measurement 
#columns (Sepal.Length, Sepal.Width, Petal.Length, Petal.Width) for each 
#of the 3 Species (in rows). Save the resulting table of means as a tibble im1 . (2 points)



## Task 6: ----- 
## (a) 
## Load data (as comma-separated file): 
data <- read_csv("http://rpository.com/ds4psy/mt/out.csv")  # from online source

read_csv
data<-as_tibble(read_csv)
