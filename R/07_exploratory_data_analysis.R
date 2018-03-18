## r4ds: Chapter 7:  
## Code for http://r4ds.had.co.nz/exploratory-data-analysis.html 
## hn spds uni.kn
## 2018 03 18 ------

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


## 7.3.3 Unusual values ------

# Outliers are observations that are unusual; data points that don’t seem to fit
# the pattern. Sometimes outliers are data entry errors; other times outliers
# suggest important new science. 

# When you have a lot of data, outliers are sometimes difficult to see in a
# histogram. For example, take the distribution of the y variable from the
# diamonds dataset. The only evidence of outliers is the unusually wide limits
# on the x-axis:

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = y), binwidth = 0.5)

range(diamonds$y)

# There are so many observations in the common bins that the rare bins are so
# short that you can’t see them (although maybe if you stare intently at 0
# you’ll spot something). To make it easy to see the unusual values, we need to
# zoom to small values of the y-axis with coord_cartesian():
  
ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = y), binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 50))

# coord_cartesian() also has an xlim() argument for when you need to zoom into
# the x-axis. 

# ggplot2 also has xlim() and ylim() functions that work slightly differently: 
# they throw away the data outside the limits.

# This allows us to see that there are three unusual values: 0, ~30, and ~60. 
# We pluck them out with dplyr:

unusual <- diamonds %>% 
  filter(y < 3 | y > 20) %>% 
  select(price, x, y, z) %>%
  arrange(y)
unusual

# The y variable measures one of the three dimensions of these diamonds, in mm.
# We know that diamonds can’t have a width of 0mm, so these values must be
# incorrect. We might also suspect that measurements of 32mm and 59mm are
# implausible: those diamonds are over an inch long, but don’t cost hundreds of
# thousands of dollars!

# It’s good practice to repeat your analysis with and without the outliers. 

# If they have minimal effect on the results, and you can’t figure out why they’re
# there, it’s reasonable to replace them with missing values, and move on.

# However, if they have a substantial effect on your results, you shouldn’t drop
# them without justification.  You’ll need to figure out what caused them 
# (e.g. a data entry error) and disclose that you removed them in your write-up.


## 7.3.4 Exercises -----

?diamonds

# 1. Explore the distribution of each of the x, y, and z variables in diamonds.
#    What do you learn? Think about a diamond and how you might decide which
#    dimension is the length, width, and depth.

# width y: see above

# length x:

range(diamonds$x)

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = x), binwidth = 0.5)

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = x), binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 20))

# depth z:

range(diamonds$z)

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = z), binwidth = 0.5)

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = z), binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 20))

# All 3 variables in one plot:
# (a) gather 3 variables into 1 (using tidyr): 1 freqpoly by group
# (b) 3 different layers of a plot: 3 freqpoly layers

bw <- 0.1

ggplot(data = diamonds) +
  geom_freqpoly(mapping = aes(x = x), binwidth = bw, color = "forestgreen") +
  geom_freqpoly(mapping = aes(x = y), binwidth = bw, color = "firebrick") + 
  geom_freqpoly(mapping = aes(x = z), binwidth = bw, color = "steelblue") +
  coord_cartesian(xlim = c(0, 10)) + 
  theme_light()

# Relationships between 2 dimensions:

# x by y:

ggplot(data = diamonds, mapping = aes(x = x, y = y)) + 
  geom_point(color = "steelblue4", alpha = 1/4) +
  # coord_cartesian(ylim = c(0, 10)) + 
  theme_light()

# x by z:

ggplot(data = diamonds, mapping = aes(x = x, y = z)) + 
  geom_point(color = "steelblue4", alpha = 1/4) +
  # coord_cartesian(ylim = c(0, 10)) + 
  theme_light()


# 2. Explore the distribution of price. 
#    Do you discover anything unusual or surprising? 
#    (Hint: Carefully think about the binwidth and make sure you try a wide range of values.)
#    [test.quest]: Describe main findings (start, shape, modal, max, ...) & mark in a graph.

range(diamonds$price)

# Start with binwidth = 1000: 

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = price), binwidth = 1000, fill = "steelblue4") + 
  # coord_cartesian(ylim = c(0, 20)) + 
  theme_light()

# Smaller binwidth = 100: 

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = price), binwidth = 100, fill = "steelblue4") + 
  # coord_cartesian(ylim = c(0, 20)) + 
  theme_light()

# Note gap around x = 1000 and zoom in:

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = price), binwidth = 50, fill = "steelblue4") + 
  coord_cartesian(xlim = c(0, 5000), ylim = c(0, 1500)) + 
  theme_light()

# Locate peak (by limiting x range):

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = price), binwidth = 50, fill = "steelblue4") + 
  coord_cartesian(xlim = c(0, 1000), ylim = c(0, 1500)) + 
  geom_vline(mapping = aes(xintercept = 700), color = "yellow") + 
  theme_light()

# Zoom in to gap around x = 1500:

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = price), binwidth = 10, fill = "steelblue4") + 
  coord_cartesian(xlim = c(1400, 1600), ylim = c(0, 250)) + 
  theme_light()

# Solution: 
# - start at a min of $300
# - peak at $700
# - decline to max of $18823
# - peculiar: Range from $1460 to $1550 is vacant.


# 3. How many diamonds are 0.99 carat? How many are 1 carat? 
#    What do you think is the cause of the difference?

?diamonds

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = carat), binwidth = 0.1, fill = "firebrick") + 
  # coord_cartesian(xlim = c(1400, 1600), ylim = c(0, 250)) + 
  theme_light()

# Zooming in further:

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = carat), binwidth = 0.01, fill = "firebrick") + 
  coord_cartesian(xlim = c(0, 2.5), ylim = c(0, 2500)) + 
  theme_light()

# Zooming in on x = 1 carat:

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = carat), binwidth = 0.01, fill = "firebrick") + 
  coord_cartesian(xlim = c(0.75, 1.25), ylim = c(0, 2500)) + 
  theme_light()

# Reasons:
# - people round numbers 
# - diamond size is not defined by nature, but are cut by sellers aiming to maximize profits


# 4. Compare and contrast coord_cartesian() vs xlim() or ylim() 
#    when zooming in on a histogram. 
#    - What happens if you leave binwidth unset? 
#    - What happens if you try and zoom so only half a bar shows?

# (a) Basic histogram: 

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = carat), binwidth = NULL, fill = "steelblue4") + 
  theme_light()

# => binwidth is set automatically (to 30).

# (b) Adding coord_cartesian():

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = carat), binwidth = NULL, fill = "steelblue4") + 
  coord_cartesian(xlim = c(0, 2.5), ylim = c(0, 2500)) + 
  theme_light()

# => zooms in without changing the plot.

# (c) Contrast with xlim and ylim:

?xlim

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = carat), binwidth = NULL, fill = "steelblue4") + 
  # coord_cartesian(xlim = c(0, 2.5), ylim = c(0, 2500)) + 
  xlim(0, 2.5) + 
  ylim(0, 2500) + 
  theme_light()

# - Values outside given ranges are removed (set to NA).
# - Binwidth is automatically set to smaller value (0.1)

# Providing binwidth:

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = carat), binwidth = 0.1, fill = "steelblue4") + 
  # coord_cartesian(xlim = c(0, 2.5), ylim = c(0, 2500)) + 
  xlim(0, 2.5) + 
  ylim(0, 2500) + 
  theme_light()

# - even more gaps

# ad: What happens if you leave binwidth unset? 

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = carat), binwidth = NULL, fill = "steelblue4") + 
  coord_cartesian(xlim = c(1, 2.5), ylim = c(0, 2500)) + 
  theme_light()

# => Binwidth remains the same (i.e., is not adjusted automatically).

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = carat), binwidth = NULL, fill = "steelblue4") + 
  # coord_cartesian(xlim = c(1, 2.5), ylim = c(0, 2500)) + 
  xlim(1, 2.5) + 
  ylim(0, 2500) + 
  theme_light()

# => Binwidth is adjusted (lowered) automatically.

# ad: What happens if you try and zoom so only half a bar shows?

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = carat), binwidth = 0.1, fill = "steelblue4") + 
  theme_light()

# => 5 bars with frequencies of > 5000.

# coord_cartesian():

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = carat), binwidth = 0.1, fill = "steelblue4") + 
  coord_cartesian(ylim = c(0, 5000)) + 
  theme_light()

# => zooming only (without changing anything in the plot)

# xlim() and ylim():

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = carat), binwidth = 0.1, fill = "steelblue4") + 
  ylim(0, 5000) + 
  theme_light()

# => 5 bars that exceed limit are removed (see warning).

# Conclusions: 
# - binwidth should be set to suitable value whenever possible.
# - for zooming in, always use coord_cartesian()



## 7.4 Missing values ------

# What to do with outliers or suspect/peculiar values?

# 1. Drop the entire row with the strange values:

diamonds2 <- diamonds %>% 
  filter(between(y, 3, 20))

?between # between(x, left, right) is an efficient shortcut for  x >= left & x <= right

# Dropping is not recommended. Better solution:

# 2. Replace unusual values with missing values. 

# The easiest way to do this is to use mutate() to replace the variable with a
# modified copy. You can use the ifelse() function to replace unusual values
# with NA:

diamonds2 <- diamonds %>% 
  mutate(y = ifelse((y < 3 | y > 20), NA, y))

# ifelse() has three arguments: 
# - The first argument test should be a logical vector. 
# - The result will contain the value of the second argument, yes, when test is TRUE, and 
# - the value of the third argument, no, when it is false.

# Like R, ggplot2 subscribes to the philosophy that missing values should never
# silently go missing. It’s not obvious where you should plot missing values, so
# ggplot2 doesn’t include them in the plot, but it does warn that they’ve been
# removed:

ggplot(diamonds2) +
  geom_point(mapping = aes(x = x, y = y)) +
  theme_light()

# Warning: Removed 9 rows containing missing values (geom_point).

# To suppress that warning, set na.rm = TRUE:
  
ggplot(data = diamonds2, mapping = aes(x = x, y = y)) + 
  geom_point(na.rm = TRUE) +
  theme_light()

# Other times you want to understand what makes observations with missing values
# different to observations with recorded values. 

# For example, in nycflights13::flights, missing values in the dep_time variable
# indicate that the flight was cancelled. So you might want to compare the
# scheduled departure times for cancelled and non-cancelled times. You can do
# this by making a new variable with is.na().

nycflights13::flights %>% 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>% 
  ggplot(mapping = aes(sched_dep_time)) + 
  geom_freqpoly(mapping = aes(color = cancelled), binwidth = 1/4) +
  theme_light()

# Zooming in:

nycflights13::flights %>% 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>% 
  ggplot(mapping = aes(sched_dep_time)) + 
  geom_freqpoly(mapping = aes(color = cancelled), binwidth = 1/4) +
  coord_cartesian(ylim = c(0, 1000)) + 
  theme_light()

# Note: Check for correlation between times of cancelled and non-cancelled flights.
#       => See next section: Covariation 

# Solution: Compare density (count standardized to 1) [test.quest]: 

nycflights13::flights %>% 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>% 
  ggplot(mapping = aes(x = sched_dep_time, y = ..density..)) + 
  geom_freqpoly(mapping = aes(color = cancelled), binwidth = 1/4) +
  theme_light()

# => early flights (up to 12:00) are less likely to be cancelled than late flights (after 15:00).


## 7.4.1 Exercises ------

# 1. What happens to missing values in a histogram? 
#    What happens to missing values in a bar chart? 
#    Why is there a difference?

diamonds2 <- diamonds %>% 
  mutate(y = ifelse((y < 3 | y > 20), NA, y))

ggplot(diamonds2, mapping = aes(x = y)) +
  geom_histogram(binwidth = 1/50) 

# => 9 NA values are removed.

# Bar chart on continuous variable (exceptional case): 

ggplot(diamonds2, mapping = aes(x = y)) +
  geom_bar() 

# => 9 NA values are removed.

# But: 
# Bar chart on categorical variable (ordinary case):

ggplot(diamonds2, mapping = aes(x = cut)) +
  geom_bar() 

# => NA values are not mentioned.
# ?: Are they simply left out?

diamonds2 %>%
  mutate(cut2 = ifelse((cut =="Very Good"), NA, cut)) %>%
  ggplot(mapping = aes(x = cut2)) +
  geom_bar() 


# 2. What does na.rm = TRUE do in mean() and sum()?

v <- c(1, 2, 3, NA, 4)
  
sum(v)
sum(v, na.rm = TRUE)

mean(v)
mean(v, na.rm = TRUE)

# na.rm = TRUE removes NA values before applying function.




## 7.5 Covariation ------

# If variation describes the behavior within a variable, 
# covariation describes the behavior between variables. 

# Covariation is the tendency for the values of two or more variables 
# to vary together in a related way. 

# The best way to spot covariation is to visualise the relationship 
# between two or more variables. 

# How you do that should again depend on the type of variables involved.



## 7.5.1 A categorical and a continuous variable -----

## (A) Frequency polygon: ----

# It’s common to want to explore the distribution of a continuous variable
# broken down by a categorical variable, as in the previous frequency polygon.

# The default appearance of geom_freqpoly() is not that useful for that sort of
# comparison because the height is given by the count. That means if one of the
# groups is much smaller than the others, it’s hard to see the differences in
# shape:
  
ggplot(data = diamonds, mapping = aes(x = price)) + 
  geom_freqpoly(mapping = aes(color = cut), binwidth = 500)

# It’s hard to see the difference in distribution 
# because the overall counts differ so much:

ggplot(diamonds) + 
  geom_bar(mapping = aes(x = cut))

# To make the comparison easier we need to swap what is displayed on the y-axis.
# Instead of displaying count, we’ll display density, which is the count
# standardised so that the area under each frequency polygon is one:

ggplot(data = diamonds, mapping = aes(x = price, y = ..density..)) + 
  geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)


## (B) Boxplot: ----

# Another alternative to display the distribution of a continuous variable
# broken down by a categorical variable is the boxplot. 

# A boxplot is a type of visual shorthand for a distribution of values. 
# Each boxplot consists of:
  
# 1. A box that stretches from the 25th percentile of the distribution to the
#    75th percentile, a distance known as the interquartile range (IQR). 
#    In the middle of the box is a line that displays the median, i.e. 50th percentile, of
#    the distribution. 
#    These three lines give you a sense of the spread of the distribution and 
#    whether or not the distribution is symmetric about the median or skewed to one side.

# 2. Visual points that display observations that fall more than 1.5 times the
#    IQR from either edge of the box. These outlying points are unusual so are
#    plotted individually.

# 3. A line (or whisker) that extends from each end of the box and goes to the 
#    farthest non-outlier point in the distribution.

ggplot(data = diamonds, mapping = aes(x = cut, y = price)) +
  geom_boxplot() +
  theme_light()

# poor alternative: 

ggplot(data = diamonds, mapping = aes(x = cut, y = price, color = cut)) +
  geom_violin() +
  # geom_jitter(alpha = 1/5) + 
  scale_color_brewer(palette = "Set1") + 
  theme_light()

# We see much less information about the distribution, but the boxplots are much
# more compact so we can more easily compare them (and fit more on one plot). 
# It supports the counterintuitive finding that better quality diamonds are cheaper
# on average! 
# In the exercises, you’ll be challenged to figure out why.


## (C) Ordered vs. un-ordered factors: reordering categories ----

# cut is an ordered factor: 
# fair is worse than good, which is worse than very good and so on. 
# Many categorical variables don’t have such an intrinsic order,
# so you might want to reorder them to make a more informative display. 
# One way to do that is with the reorder() function.

# For example, take the class variable in the mpg dataset. 
# You might be interested to know how highway mileage varies across classes:
  
ggplot(data = mpg, mapping = aes(x = class, y = hwy, color = class)) +
  geom_boxplot()

# To make the trend easier to see, we can reorder class based on the median value of hwy:
  
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy, color = class))

# If you have long variable names, geom_boxplot() will work better if you flip it 90°. 
# You can do that with coord_flip().

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy, color = class)) +
  coord_flip()

## 7.5.1.1 Exercises -----

# 1. Use what you’ve learned to improve the visualisation of the departure times
#    of cancelled vs. non-cancelled flights.

nycflights13::flights %>% 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>% 
  ggplot(mapping = aes(x = sched_dep_time, y = ..density..)) + 
  geom_freqpoly(mapping = aes(color = cancelled), size = 1, binwidth = 1/4) +
  scale_color_brewer(palette = "Set1") +
  theme_light()

# 2. a) What variable in the diamonds dataset is most important for predicting the
#       price of a diamond? 
#    b) How is that variable correlated with cut? 
#    c) Why does the combination of those two relationships lead to lower quality diamonds 
#       being more expensive?

?diamonds

with(diamonds, cor(carat, price))
with(diamonds, cor(x, price))
with(diamonds, cor(y, price))
with(diamonds, cor(z, price))
with(diamonds, cor(table, price))

# a) carat is most relevant for price:

ggplot(diamonds, mapping = aes(x = carat, y = price, color = cut)) +
  geom_point(alpha = 1/3) + 
  scale_color_brewer(palette = "Set1") +
  theme_light()

# split into different facets (by cut):

ggplot(diamonds, mapping = aes(x = carat, y = price)) +
  geom_point(alpha = 1/10) + 
  facet_wrap(~cut) + 
  scale_color_brewer(palette = "Set1") +
  theme_light()

# frequency of carat:

ggplot(diamonds, mapping = aes(x = carat, color = cut)) +
  geom_freqpoly(binwidth = 0.1) +
  scale_color_brewer(palette = "Set1") +
  theme_light()

# Show distribution density (each curve scaled to 1):

ggplot(diamonds, mapping = aes(x = carat, y = ..density.., color = cut)) +
  geom_freqpoly(binwidth = 0.1) +
  scale_color_brewer(palette = "Set1") +
  theme_light()

# => lowest quality = most frequent for high carat counts; 
#    highest quality = most frequent for low carat counts.


# b) How is that variable correlated with cut? 
#    cut is categorical, hence use boxplot or violin plot:

# Price by cut:

ggplot(diamonds, mapping = aes(x = cut, y = price, color = cut)) +
  geom_boxplot() + 
  scale_color_brewer(palette = "Set1") +
  theme_light()

ggplot(diamonds, mapping = aes(x = cut, y = price, color = cut)) +
  geom_violin() + 
  scale_color_brewer(palette = "Set1") +
  theme_light()

# Carat by cut:

ggplot(diamonds, mapping = aes(x = cut, y = carat, color = cut)) +
  geom_boxplot() + 
  scale_color_brewer(palette = "Set1") +
  theme_light()

# Note: Boxplot does not show frequency and gets messy when there are many outliers.
#       (See Exercise 4 below: lvplot)

ggplot(diamonds, mapping = aes(x = cut, y = carat, color = cut)) +
  geom_jitter(alpha = 1/10) + 
  geom_violin() + 
  scale_color_brewer(palette = "Set1") +
  theme_light()

# => 1. negative relationship: lower quality (cut) tends to have more carats (except for premium cut).
#    2. ideal cut with low carats is most frequent type of diamond.


# 3. Install the ggstance package, and create a horizontal boxplot. 
#    How does this compare to using coord_flip()?

# from above:

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy, color = class)) +
  coord_flip() + 
  theme_light()

# adding cyl as a factor within class:

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy, fill = factor(cyl))) +
  coord_flip() + 
  theme_light()

# ggstance implements horizontal versions of common ggplot2 Geoms, Stats, and Positions.

# Difference in argument order of command: 
# To create a horizontal layer in ggplot2 with coord_flip(), 
# aesthetics are specified as if they were to be drawn vertically:
# In ggstance, aesthetics are specified in their natural order:

# install.packages('ggstance')
library(ggstance)

ggplot(data = mpg) +
  geom_boxploth(mapping = aes(x = hwy, y = reorder(class, hwy, FUN = median), color = class)) +
  theme_light()

# adding cyl as a factor within class:

ggplot(data = mpg) +
  geom_boxploth(mapping = aes(x = hwy, y = reorder(class, hwy, FUN = median), fill = factor(cyl))) +
  theme_light()

# 3 differences:
# 
# - Command order (see above).
# - While coord_flip() in ggplot can only flip a plot as a whole, 
#   ggstance provides flipped versions of Geoms, Stats and Positions. 
#   This makes it easier to build horizontal layer or use vertical positioning 
#   (e.g. vertical dodging). 
# - Also, horizontal Geoms draw horizontal legend keys to keep the appearance 
#   of plots consistent.


# 4. One problem with boxplots is that they were developed in an era of much
#    smaller datasets and tend to display a prohibitively large number of “outliers”. 
#    Also: Boxplots do not represent frequency and thus can be misleading when categories 
#    differ a lot in their frequency (as in the diamond$cut example above).

ggplot(diamonds, mapping = aes(x = cut, y = carat, color = cut)) +
  geom_boxplot() + 
  scale_color_brewer(palette = "Set1") +
  theme_light()

#   One approach to remedy this problem is the letter value plot. 
#   Install the lvplot package, and try using geom_lv() to display the distribution of
#   price vs cut. 

# install.packages('lvplot')
library(lvplot)

# From examples (using mpg data):
p <- ggplot(mpg, aes(class, hwy)) + theme_light()
p
p + geom_lv(aes(fill = ..LV..)) + scale_fill_brewer()
p + geom_lv() + geom_jitter(width = 0.2)
p + geom_lv(alpha = 1, aes(fill = ..LV..)) + scale_fill_lv()

# Above graph (i.e., still carat by cut):

ggplot(diamonds, mapping = aes(x = cut, y = carat, color = cut)) +
  geom_lv() + 
  scale_color_brewer(palette = "Set1") +
  theme_light()

# Price vs. cut:

ggplot(diamonds, mapping = aes(x = cut, y = price)) +
  geom_lv(aes(fill = ..LV..)) + 
  scale_fill_brewer() +
  theme_light()

# What do you learn? How do you interpret the plots?
  

# 5. Compare and contrast 
#    a) geom_violin() with a 
#    b) facetted geom_histogram(), or a 
#    c) coloured geom_freqpoly(). 
# What are the pros and cons of each method?

# - all plot types show distributions
# - of 1 continuous variable by 1 categorical variable

# 1) Using mpg data: Distribution of hwy by class of car:
# a) violin plot:

ggplot(mpg) +
  geom_violin(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy, color = class)) +
  theme_light()

# b) histogram facets:

ggplot(mpg) +
  facet_wrap(~class) + 
  geom_histogram(mapping = aes(x = hwy, fill = class), binwidth = 1) +
  theme_light()

# c) freqpoly: 

ggplot(mpg) +
  geom_freqpoly(mapping = aes(x = hwy, color = class)) +
  theme_light()

# freqpoly as density:

ggplot(mpg) +
  geom_freqpoly(mapping = aes(x = hwy, y = ..density.., color = class)) +
  theme_light()

# 2) Using diamonds data: price by carat

# a) violin plot:

ggplot(diamonds) +
  geom_violin(mapping = aes(x = cut, y = price, color = cut)) +
  theme_light()

# b) histogram facets:

ggplot(diamonds) +
  facet_wrap(~cut) + 
  geom_histogram(mapping = aes(x = price, fill = cut), binwidth = 1000) +
  theme_light()

# c) freqpoly: 

ggplot(diamonds) +
  geom_freqpoly(mapping = aes(x = price, color = cut)) +
  theme_light()


# 6. If you have a small dataset, it’s sometimes useful to use geom_jitter() 
#    to see the relationship between a continuous and categorical variable. 
#    The ggbeeswarm package provides a number of methods similar to geom_jitter().
#    List them and briefly describe what each one does.

# install.packages('ggbeeswarm')
library(ggbeeswarm)

ggplot(mpg) +
  geom_beeswarm(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy, color = class)) +
  theme_light()

ggplot(mpg) +
  geom_quasirandom(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy, color = class)) +
  theme_light()

# Note: ggbeeswarm gets difficult with larger datasets (large N of cases): 

ggplot(diamonds) +
  geom_quasirandom(mapping = aes(x = cut, y = price, color = cut), alpha = 1/10) +
  theme_light()



## 7.5.2 Two categorical variables -----

# (1) Visualize the frequency of counts:

# To visualise the covariation between categorical variables, 
# count the number of observations for each combination
# by using geom_count():

ggplot(data = diamonds) +
  geom_count(mapping = aes(x = cut, y = color), color = "steelblue") + 
  theme_light()

# The size of each circle in the plot displays how many observations occurred at
# each combination of values. Covariation will appear as a strong correlation
# between specific x values and specific y values.


# (2) Contingency/frequency table:

# table(diamonds$cut)
# table(diamonds$color)

t1 <- table(diamonds$color, diamonds$cut)
t1


# (2) Using dplyr:

t2 <- diamonds %>% 
  count(color, cut)
t2

# Then visualise t2 with geom_tile() and the fill aesthetic:

ggplot(t2) +
  geom_tile(mapping = aes(x = color, y = cut, fill = n))

# same with t1 (i.e., without dplyr):

df1 <- data.frame(t1)
names(df1) <- c("color", "cut", "n")
head(df1)

ggplot(df1) +
  geom_tile(mapping = aes(x = color, y = cut, fill = n))

# If the categorical variables are unordered, 
# use the seriation package to simultaneously reorder the rows and columns 
# in order to more clearly reveal interesting patterns. 

# For larger plots, you might want to try the 
# d3heatmap or heatmaply packages, which create interactive plots.


## 7.5.2.1 Exercises ---- 

# 1. How could you rescale the count dataset above to more clearly show the
#    distribution of cut within colour, or colour within cut?

?geom_count

p <- ggplot(diamonds, aes(x = cut, y = color)) +
  theme_light()

# above:
p + geom_count()

# with scale_size_area():
p + geom_count() +
  scale_size_area(max_size = 15)

# Display proportions instead of counts:
p + geom_count(aes(size = ..prop.., group = 1)) +
  scale_size_area(max_size = 15)

p + geom_count(aes(size = ..prop.., group = 2)) +
  scale_size_area(max_size = 15)

# Or group by x/y variables to have rows/columns sum to 1.
p + geom_count(aes(size = ..prop.., group = cut)) + # columns sum to 1
  scale_size_area(max_size = 15) 

p + geom_count(aes(size = ..prop.., group = color)) + # rows sum to 1
  scale_size_area(max_size = 15)


# 2. Use geom_tile() together with dplyr to explore how average flight delays
#    vary by destination and month of year. What makes the plot difficult to read?
#    How could you improve it?

arr_delay <- nycflights13::flights %>%
  group_by(month, dest) %>%
   summarise(count = n(),
             n_not_NA = sum(!is.na(arr_delay)), 
             mn_delay = mean(arr_delay, na.rm = TRUE))

ggplot(arr_delay, aes(x = dest, y = month)) +
  geom_tile(aes(fill = mn_delay))

# - too many destinations
# - missing values for some destinations => remove them
# - flip x axis labels


# 3. Why is it slightly better to use aes(x = color, y = cut) 
#    rather than aes(x = cut, y = color) in the example above?

# used above:
ggplot(data = diamonds) +
  geom_count(mapping = aes(x = cut, y = color), color = "steelblue") + 
  theme_light()

# better alternative:   
ggplot(data = diamonds) +
  geom_count(mapping = aes(x = color, y = cut), color = "steelblue") + 
  theme_light()

# There are 7 levels of color vs. 5 levels of cut: 
# Use larger number as x axis 
# (on rectangular screens with larger width than height)



## 7.5.3 Two continuous variables -----

# You’ve already seen one great way to visualise the covariation between two
# continuous variables: 

## Draw a scatterplot with geom_point(): ----

# Covariation shows as a pattern in the points. 

# For example, see the exponential relationship between 
# the carat size and price of a diamond:

p <- ggplot(data = diamonds, mapping = aes(x = carat, y = price)) +
  theme_light()

p + geom_point()

# Problem with large data sets: Overplotting

# Possible solutions: 

## (A) Add transparency using the alpha aesthetic: ----

p + geom_point(alpha = 1/25)

# But: Transparency can be insufficient for large data sets.

## (B) Bin across 2 dimensions: ----

# Previously we used geom_histogram() and geom_freqpoly() to bin in 1 dimension. 
# Now we use geom_bin2d() and geom_hex() to bin in 2 dimensions:

smaller <- diamonds %>% 
  filter(carat < 3)

p <- ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  theme_light()

# Using transparency:
p + geom_point(alpha = 1/25)

# Using geom_bin2d(): 
p + geom_bin2d()

## Using geom_hexbin():
# install.packages('hexbin')

p + geom_hex()

# geom_bin2d() and geom_hex() divide the coordinate plane into 2d bins and then
# use a fill color to display how many points fall into each bin. 
# - geom_bin2d() creates rectangular bins. 
# - geom_hex() creates hexagonal bins (and requires the hexbin package). 

# Note: The vertical pattern of price frequency by carat size disappears 
#       in both binned versions.  Perhaps try a smaller bin width?

?geom_hex

p + geom_hex(bins = 90)

p + geom_hex(binwidth = c(1, 1000))
p + geom_hex(binwidth = c(0.1, 1000))
p + geom_hex(binwidth = c(0.05, 500))
p + geom_hex(binwidth = c(0.025, 250))


## (C) Bin 1 continuous variable and visualize 1 categorical + 1 continuous variable: ----

# Another option is to bin one continuous variable so it acts like a categorical
# variable. Then you can use one of the techniques for visualising the
# combination of a categorical and a continuous variable that you learned about.

# For example, you could bin carat and then for each group, display a boxplot:
  
ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)))

p + geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)))
  
# cut_width(x, width), as used above, divides x into bins of width width.

# Problem: Boxplot do not show frequency of observations per box: 
# By default, boxplots look roughly the same (apart from number of outliers) 
# regardless of how many observations there are, so it’s difficult to tell 
# that each boxplot summarises a different number of points. 

# Solutions:

# (a) One way to show that is to make the width of the boxplot proportional to the
#     number of points with varwidth = TRUE:  [test.quest]

p + geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)), varwidth = TRUE)

# (b) Another approach is to display approximately the same number of points 
#     in each bin. That’s the job of cut_number():
  
p + geom_boxplot(mapping = aes(group = cut_number(carat, 20)))  


## 7.5.3.1 Exercises -----

library(tidyverse)

smaller <- diamonds %>% 
  filter(carat < 3)

# 1. Instead of summarising the conditional distribution with a boxplot, 
#    you could use a frequency polygon. 
#    What do you need to consider when using cut_width() vs cut_number()? 
#    How does that impact a visualisation of the 2d distribution of carat and price?

q <- ggplot(data = smaller, mapping = aes(x = carat)) + 
  theme_light()

q + geom_freqpoly(mapping = aes(color = cut_width(price, 5000)))

q + geom_freqpoly(mapping = aes(color = cut_number(price, 6)))


# 2. Visualise the distribution of carat, partitioned by price.

r <- ggplot(data = smaller, mapping = aes(x = price, y = carat)) + 
  theme_light()

r + geom_boxplot(mapping = aes(group = cut_width(price, 2000))) # bin spanning a width of $1000

r + geom_boxplot(mapping = aes(group = cut_width(price, 2000)), varwidth = TRUE) # width represents freq

r + geom_boxplot(mapping = aes(group = cut_number(price, 10))) # 10 bins with equal number of points per bin


# 3. How does the price distribution of very large diamonds compare to small diamonds. 
#    Is it as you expect, or does it surprise you?

p <- ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  theme_light()

p + geom_boxplot(mapping = aes(group = cut_width(carat, 1))) # bin spanning a width of 1 carat

# Larger diamonds (as defined by carat) show more variability, unsurprisingly. 


# 4. Combine two of the techniques you’ve learned to visualise 
#    the combined distribution of cut, carat, and price.

?diamonds

# cut is categorical => use as grouping or faceting variable

s <- ggplot(data = smaller, mapping = aes(x = carat, y = price)) +
  theme_light()

s + geom_point(aes(color = cut), alpha = 1/10)

# use faceting:

s + facet_wrap(~cut) +
    geom_point(aes(color = cut), alpha = 1/10)

 
# 5. Two dimensional plots reveal outliers that are 
#    not visible in one dimensional plots. 

# For example, some points in the plot below have an unusual combination 
# of x and y values, which makes the points outliers even though their 
# x and y values appear normal when examined separately:

ggplot(data = diamonds) +
  geom_point(mapping = aes(x = x, y = y), alpha = 1/5) +
  coord_cartesian(xlim = c(4, 11), ylim = c(4, 11)) +
  theme_light()

# Why is a scatterplot a better display than a binned plot for this case?

# Answer: The scatterplot shows the linear relationship between x and y?


## 7.6 Patterns and models ------



## +++ here now +++ ------

## ------
## eof.