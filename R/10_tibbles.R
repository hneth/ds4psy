## r4ds: Chapter 10: Tibbles  
## Code for http://r4ds.had.co.nz/tibbles.html 
## hn spds uni.kn
## 2018 03 19 ------

## 10.1 Introduction ------

# In this chapter we’ll explore the tibble package, part of the core tidyverse:

library(tidyverse)

# From 

vignette("tibble")

# Tibbles are a modern take on data frames. 
# They keep the features that have stood the test of time, 
# and drop the features that used to be convenient but are now frustrating 
# (i.e. converting character vectors to factors).


## 10.2 Creating tibbles ------

# Almost all of the functions that you’ll use in this book produce tibbles, 
# as tibbles are one of the unifying features of the tidyverse. 

# Most other R packages use regular data frames, 
# so you might want to coerce a data frame to a tibble. 
# You can do that with as_tibble():

?iris

it <- as_tibble(iris)
it


## [test.quest]: Explore iris 
{

## Histograms or freqpoly (1 continuous variable) by species (category):

ggplot(it, aes(x = Petal.Length, fill = Species)) + 
  geom_histogram(binwidth = 0.25) + 
  theme_light()

ggplot(it, aes(x = Petal.Length, color = Species)) + 
  geom_freqpoly(binwidth = 0.5) + 
  theme_light()

ggplot(it, aes(x = Petal.Length, fill = Species)) + 
  facet_wrap(~Species) + 
  geom_histogram(binwidth = 0.10) + 
  theme_light()


## Scatterplots (2 continuous variables):

ggplot(it, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + 
  geom_point(size = 3, alpha = 1/2) + 
  theme_light()

# Insight: 
# - 3 clusters (partly overlapping)
# - low positive correlation

ggplot(it, aes(x = Petal.Length, y = Petal.Width, color = Species)) + 
  geom_point(size = 3, alpha = 1/2) + 
  theme_light()

# Insight:
# - 3 clear clusters (by species)
# - positive correlation (overall)

}


# +++ here now +++ ------




## Appendix ------

# If this chapter leaves you wanting to learn more about tibbles, you might enjoy 

vignette("tibble")

## ------
## eof.