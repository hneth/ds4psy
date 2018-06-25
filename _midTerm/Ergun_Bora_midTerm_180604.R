## Mid-term exam  | Data science for psychologists (Summer 2018)
## Name: Bora Ergün | Student ID: 126014325137
## 2018 06 04
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##

## Preparations: ----- 

library(tidyverse)

##Task 1: -----

##(a)

sp <- as_tibble(sleep)

dim(sp)

##(b)
sp

gp <- group_by(sp, group)
  summarise(gp, n = n(),
            mean_obs = mean(extra),
            median_obs = median(extra),
            std_obs = sd(extra))
##(c)
  
ggplot(sp) +
  geom_boxplot(mapping = aes(x = group, y = extra)) +
  geom_point(mapping = aes(x = group, y = extra, color = group))

##(d)  
  
spread(sp, key = ID, value = extra)

##Task 2: -----

## (a)
de <- tribble(~"Party", ~"Share 2013", ~"Share 2017", 
       "CDU/CSU", 41.5, 33,
       "SPD", 25.7, 20.5,
       "Others",32.8 ,46.5)
de

## (b)


de_2 <- gather(de, `Share 2013`, `Share 2017`, key = "year", value = "percentage")

de_2


## (c)


ggplot(de_2) +
  geom_bar(mapping = aes(x = year, fill = Party))
         

##Task 3 -----

## (a)

sw <- as_tibble(starwars)

dim(sw)

##(b)

sum(is.na(sw))

sw %>%
  filter(homeworld == is.na(), birth_year != is.na())


##(c)

## (d)

sw

  
##task4 -----

## (a)
st <- tribble(~stock, ~d1_start, ~d1_end, ~ d2_start, ~ d2_end, ~d3_start, ~d3_end,
        "Amada", 2.5, 3.6, 3.5, 4.2, 4.4, 2.8,
        "Betix", 3.3, 2.9, 3.0, 2.1, 2.3, 2.5,
        "Cevis", 4.2, 4.8, 4.6, 3.1, 3.2, 3.7)
##(b)

st_long <- gather(st,`d1_start`, `d1_end`,`d2_start`,`d2_end`,`d3_start`,`d3_end`, key = times, value = stock_prices) %>%
  separate(times, into = c("day", "time"))

##(c)
long_end <- filter(st_long, time == "end" )
ggplot(long_end) +
  geom_point(mapping = aes(x = day, y = stock_prices, color = stock))





## Task 5 -----

##(a)

ir <- as_tibble(iris)
View(ir)


##(b)

##(c)

ggplot(ir)+
  geom_histogram(mapping = aes(x = Sepal.Width))

##(d)

ggplot(ir)+
  geom_freqpoly(mapping = aes(x = Sepal.Width, color = Species))
##(e)

ggplot(ir)+
  geom_point(mapping = aes(x = Petal.Width, y = Sepal.Width))+
  facet_wrap(~ Species, nrow = 3 )

##(f)

ir_long <- gather(ir, `Petal.Width`, `Petal.Length`, `Sepal.Width`,`Sepal.Length`, key = measure_type, value = measurement)


##(g)




