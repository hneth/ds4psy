## r4ds: Chapter 7:  
## Code for http://r4ds.had.co.nz/exploratory-data-analysis.html 
## hn spds uni.kn
## 2018 03 15 ------

## Quotes: ------

# > “There are no routine statistical questions, only questionable statistical routines.” 
# > Sir David Cox

# > “Far better an approximate answer to the right question, which is often vague, 
# >  than an exact answer to the wrong question, which can always be made precise.” 
# >  John Tukey

## 7.1 Introduction ------

# EDA is an iterative cycle. 
# You:
# 1. Generate questions about your data.
# 2. Search for answers by visualising, transforming, and modelling your data.
# 3. Use what you learn to refine your questions and/or generate new questions.

# EDA is not a formal process with a strict set of rules. 
# More than anything, EDA is a state of mind. 

# EDA is an important part of any data analysis, 
# because you always need to investigate the quality of your data. 

# Data cleaning is just one application of EDA: 
# you ask questions about whether your data meets your expectations or not. 

# To do data cleaning, you’ll need to deploy all the tools of EDA:
# visualisation, transformation, and modelling.

## 7.1.1 Prerequisites

library(tidyverse)

## 7.2 Questions ------ 

## Goal of EDA: developing an understanding of data.

## - use questions to guide attention
## - creative process: good quality and large quantity of questions
## - no general rules, but 2 types of questions: 
##   a. type of variation within variables?
##   b. type of covariation between variables?


## Terminology:

# - variable := a quantity, quality, or property that you can measure.

# - value := the state of a variable when you measure it. 
#            The value of a variable may change from measurement to measurement.

# - observation := a set of measurements made under similar conditions 
#            (usually at the same time and on the same object). 
#            An observation will contain several values, each associated with a different variable. 
#            I’ll sometimes refer to an observation as a data point. [aka. "case"]

# - Tabular data is a set of values, each associated with a variable and an observation. 
#   Tabular data is "tidy" if 
#           a) each value is placed in its own “cell”, 
#           b) each variable in its own column, and 
#           c) each observation in its own row.


## 7.3 Variation ------

# Variation := the tendency of the values of a variable to change 
#              from measurement to measurement.

# Viewing variation: visualise the distribution of the variable’s values.

## 7.3.1 Visualising distributions 

## A: Distribution of a categorical variable (discrete levels): 
##    bar chart

table(diamonds$cut)

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

# Bar height denotes frequency of category value. 

# Compute with dplyr:

diamonds %>% 
  count(cut)

# OR (more explicitly): 

diamonds %>%
  group_by(cut) %>%
  summarise(count = n())

## B: Distribution of a continuous variable, 
##    histogram:

ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = carat), binwidth = 0.5)

# You can compute this by hand by combining 
# dplyr::count() and ggplot2::cut_width():

?cut_width

diamonds %>% 
  count(cut_width(carat, width = 0.5))

# Always explore a variety of binwidths when working with histograms, 
# as different binwidths can reveal different patterns.

ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = carat), binwidth = 0.1)

smaller <- diamonds %>% 
  filter(carat < 3)

ggplot(data = smaller, mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.1)

# Use geom_freqpoly() instead of geom_histogram() to overlay 
# multiple histograms in the same plot. 


# geom_freqpoly() performs the same calculation as geom_histogram(), 
# but instead of displaying the counts with bars, uses lines instead. 
# It’s much easier to understand overlapping lines than bars: 

ggplot(data = smaller, mapping = aes(x = carat, color = cut)) +
  geom_freqpoly(binwidth = 0.1)

# Same with geom_histogram:

ggplot(data = smaller, mapping = aes(x = carat, fill = cut)) +
  geom_histogram(binwidth = 0.1) +
  scale_fill_brewer(palette = "Blues") +
  theme_light()


## 7.3.2 Typical values ------

## Look for patterns:
## - missing/rare/frequent values
## - changes in values
## - clusters of similar/dissimilar values

ggplot(data = smaller, mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.01)

## Duration and waiting times of eruptions of Old Faithful geyser in Yellowstone:

?faithful
head(faithful)

ggplot(data = faithful, mapping = aes(x = eruptions)) + 
  geom_histogram(binwidth = 0.25)

## +++ here now +++

## ------
## eof.