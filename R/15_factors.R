## r4ds: Chapter 15: Factors
## Code for http://r4ds.had.co.nz/factors.html 
## hn spds uni.kn
## 2018 04 16 ------

## [see Book chapter 1x: "..."]

## Note: forcats is not part of the core tidyverse. 



## 15.1 Introduction ------

# In R, factors are used to work with _categorical_ variables, 
# variables that have a fixed and known set of possible values. 
# They are also useful when you want to display character vectors 
# in a non-alphabetical order.

# Historically, factors were much easier to work with than characters. 
# As a result, many of the functions in base R automatically convert 
# characters to factors. This means that factors often crop up in places 
# where they’re not actually helpful. 

# Fortunately, you don’t need to worry about that in the tidyverse, 
# and can focus on situations where factors are genuinely useful.

# Historical context on factors: 
# stringsAsFactors: An unauthorized biography by Roger Peng, 
# https://simplystatistics.org/2015/07/24/stringsasfactors-an-unauthorized-biography/ 
# and 
# stringsAsFactors = <sigh> by Thomas Lumley.
# http://notstatschat.tumblr.com/post/124987394001/stringsasfactors-sigh


## 15.1.1 Prerequisites 

# This chapter will focus on the forcats package, 
# which provides tools for dealing with categorical variables 
# (and is an anagram of factors). 
# forcats is not part of the core tidyverse, so we need to load it explicitly:

library(tidyverse)
library(forcats)


# 15.2 Creating factors ------

# Imagine a variable that records month:
x1 <- c("Dec", "Apr", "Jan", "Mar")

# Using a string (i.e., variables of text information) to record this variable 
# creates 2 problems:

# 1. There are only 12 possible months (i.e., a fixed set of values), 
#    and there’s nothing saving you from typos:
x2 <- c("Dec", "Apr", "Jam", "Mar")

# 2. It doesn’t sort in a useful way:
sort(x1) # sorts alphabetically 


# You can fix both of these problems with a factor. 
# To create a factor you start by creating a list of the valid levels:
  
month_levels <- c(
    "Jan", "Feb", "Mar", "Apr", "May", "Jun", 
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    )

# Now you can create a factor:
y1 <- factor(x1, levels = month_levels)
y1

# And any values NOT in the set (of levels) 
# will be silently converted to NA:
y2 <- factor(x2, levels = month_levels)
y2

# If you want a warning, you can use readr::parse_factor():
y2 <- parse_factor(x2, levels = month_levels)

# If you omit the levels argument, they’ll be taken 
# from the data in alphabetical order:
factor(x1)

# Sometimes you’d prefer that the order of the levels 
# match the order of the first appearance in the data. 
# You can do that 
# (a) when creating the factor 
#     by setting levels to unique(x), or 
# (b) after the fact(or), 
#     with fct_inorder():

f1 <- factor(x1, levels = unique(x1))  # sets levels to order of appearance 
f1

f2 <- x1 %>% factor() %>% fct_inorder() # creates factor and then fixes order of levels
f2

all.equal(f1, f2)  # => TRUE


# To access the set of valid levels directly, 
# use levels():
levels(f2)


## 15.3 General Social Survey ------ 

# For the rest of this chapter, we’re going to focus on 
forcats::gss_cat

# It’s a sample of data from the General Social Survey, 
# which is a long-running US survey conducted by the 
# independent research organization NORC at the University of Chicago.
# http://gss.norc.org/

## Check data: ----

gss_cat
glimpse(gss_cat)
?gss_cat # provides info on package data

## Explore data: ----

# When factors are stored in a tibble, 
# you can’t see their levels so easily. 
# One way to see them is with count():

gss_cat %>% count(race)
gss_cat %>% count(marital)
gss_cat %>% count(rincome)

# Or with a bar chart:
  
ggplot(gss_cat, aes(race)) +
  geom_bar()

ggplot(gss_cat, aes(marital)) +
  geom_bar()

# By default, ggplot2 will drop levels that don’t have any values. 
# We can force them to display with:

ggplot(gss_cat, aes(race)) +
  geom_bar() +
  scale_x_discrete(drop = FALSE)

ggplot(gss_cat, aes(marital)) +
  geom_bar() +
  scale_x_discrete(drop = FALSE)

# These levels represent valid values that simply did not occur in this dataset. 
# Unfortunately, dplyr doesn’t yet have a drop option, but it will in the future.


## 15.3.1 Exercise -----

# 1. Explore the distribution of rincome (reported income). 
#    What makes the default bar chart hard to understand? 
#    How could you improve the plot?

ggplot(gss_cat, aes(rincome)) +
  geom_bar() 

# Problems: 
# x-axis labels are hard to read (thus: rotate by 90 degrees)
# and add color info:

# Prettier version:
ggplot(gss_cat, aes(rincome, fill = rincome)) +
  geom_bar() +
  scale_fill_hue(h = c(100, 300)) + 
  theme_light() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))

# Alternatively, flip the plot to display labels horizontally:
ggplot(gss_cat, aes(rincome, fill = rincome)) +
  geom_bar() +
  scale_fill_hue(h = c(100, 300)) + 
  theme_light() +
  coord_flip()

# Still suboptimal:
# - Order of factor levels should be changed: 
# - scale should be reversed
# - group all missing factor levels together
levels(gss_cat$rincome)


# 2. What is the most common relig in this survey? 
#    What’s the most common partyid?

# relig: 
gss_cat %>% count(relig) %>% arrange(desc(n))
gss_cat %>% count(relig, sort = TRUE) # shorter version

ggplot(gss_cat, aes(relig, fill = relig)) +
  geom_bar() +
  # scale_fill_hue(h = c(200, 300)) + 
  theme_light() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))

# => The most common relig is "Protestant".

# partyid: 
gss_cat %>% count(partyid) %>% arrange(desc(n))
gss_cat %>% count(partyid, sort = TRUE)  # shorter version

ggplot(gss_cat, aes(partyid, fill = partyid)) +
  geom_bar() +
  # scale_fill_hue(h = c(200, 300)) + 
  theme_light() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))

# => The most common partyid is "Independent".   

# 3. Which relig does denom (denomination) apply to? 
#    How can you find out with a table? 
#    How can you find out with a visualisation?

gss_cat %>% 
  # filter(relig == "Protestant") %>%
  group_by(relig, denom) %>%
  summarise(n = n(),
            non_NA = sum(!is.na(denom))) %>%
  arrange(desc(n)) %>%
  head(20)

# denom further categorizes relig == "Protestant".

# Alternative ways of showing this from: 
# https://jrnold.github.io/r4ds-exercise-solutions/factors.html#exercise-4-21 

# 1. Let’s filter out the non-responses, no answers, others, 
#    not-applicable, or no denomination, 
# to leave only answers to denominations. 
# After doing that, the only remaining responses are “Protestant”.

gss_cat %>%
  filter(!denom %in% c("No answer", "Other", "Don't know", "Not applicable",
                       "No denomination")) %>%
  count(relig)

# 2. This is also clear in a scatter plot of relig vs. denom 
#    in which points are proportional to the size of the number of answers 
#    (since otherwise there would be overplotting).

gss_cat %>%
  count(relig, denom) %>%
  ggplot(aes(x = relig, y = denom, size = n)) +
  geom_point(color = "steelblue") +
  theme_light() + 
  theme(axis.text.x = element_text(angle = 90))


## Working with factors: ------
  
# When working with factors, the two most common operations are changing the
# order of the levels, and changing the values of the levels. Those operations
# are described in the sections below.


## 15.4 Modifying factor order ------

# It’s often useful to change the order of the factor levels in a visualisation.
# For example, imagine you want to explore the average number of hours spent
# watching TV per day across religions:
  
relig_summary <- gss_cat %>%
  group_by(relig) %>%
  summarise(
    age = mean(age, na.rm = TRUE),
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )

# relig_summary

ggplot(relig_summary, aes(tvhours, relig)) + 
  geom_point() + theme_light()

# It is difficult to interpret this plot because there’s no overall pattern. 

# We can improve it by reordering the levels of relig using fct_reorder().

## (A) fct_reorder(): ----

# fct_reorder() takes three arguments:
# 1. f, the factor whose levels you want to modify.
# 2. x, a numeric vector that you want to use to reorder the levels.
# 3. Optionally, fun, a function that’s used if there are multiple values of 
#    x for each value of f. The default value of fun is median.

ggplot(relig_summary, aes(tvhours, fct_reorder(f = relig, x = tvhours))) +
  geom_point() + theme_light()

# Reordering religion makes it much easier to see that people in the 
# “Don’t know” category watch much more TV, and Hinduism & 
# Other Eastern religions watch much less.

# As you start making more complicated transformations, 
# I’d recommend moving them out of aes() and 
# into a separate mutate() step. 
# For example, you could rewrite the plot above as:
  
relig_summary %>%
  mutate(relig = fct_reorder(relig, tvhours)) %>%  # new mutate step!
  ggplot(aes(tvhours, relig)) +
  geom_point() + theme_light()

# Let's create a similar plot showing how average age 
# varies across reported income level:

rincome_summary <- gss_cat %>%
  group_by(rincome) %>%
  summarise(
    age = mean(age, na.rm = TRUE),
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )

# rincome_summary

ggplot(rincome_summary, aes(age, fct_reorder(rincome, age))) + 
  geom_point() + theme_light()

# OR (with separate mutate step): 
rincome_summary %>%
  mutate(rincome = fct_reorder(rincome, age)) %>%  # new mutate step!
  ggplot(aes(age, rincome)) + 
  geom_point() + theme_light()

# Here, arbitrarily reordering the levels isn’t a good idea! 
# That’s because rincome already has a principled order 
# that we shouldn’t mess with. 
# Reserve fct_reorder() for factors whose levels are arbitrarily ordered.

## (B) fct_relevel(): ----

# However, it does make sense to pull the “Not applicable” category  
# to the front with the other special levels. 

# We can use fct_relevel(). 
# It takes a factor, f, and then any number of levels 
# that we want to move to the front of the line:

levels(rincome_summary$rincome)

ggplot(rincome_summary, aes(age, fct_relevel(rincome, "Not applicable"))) + 
  geom_point() + theme_light()

# Why do you think the average age for “Not applicable” is so high?

# Let's add the counts to the plot:
ggplot(rincome_summary, aes(age, fct_relevel(rincome, "Not applicable"))) + 
  geom_point(aes(size = n)) + theme_light()

# It's not due to a few outliers, as there are many cases in the NA category. 
# Perhaps pensioners are counted in this category? 


## (C) fct_reorder2(): ----

# Another type of reordering is useful when you are colouring 
# the lines on a plot. 
# fct_reorder2() reorders the factor by the y values 
# associated with the largest x values. 
# This makes the plot easier to read because line colours line up with the legend: 

by_age <- gss_cat %>%
  filter(!is.na(age)) %>%
  group_by(age, marital) %>%
  count() %>%
  # mutate(prop = (n / sum(n)))  # ERROR: yields 1 for all prop
  mutate(prop = (n / 21407))     # hack fix

sum(by_age$n) # => 21407         # hack fix
by_age

# Default: Group colored lines by marital:
ggplot(by_age, aes(age, prop, colour = marital)) +
  geom_line(na.rm = TRUE) + theme_light()

# with fact_reorder2():
ggplot(by_age, aes(age, prop, colour = fct_reorder2(marital, age, prop))) +
  geom_line() +
  labs(colour = "marital") + theme_light()

## (D) fct_infreq() and fct_rev(): ----

# For bar plots, you can use fct_infreq() 
# to order levels in increasing frequency: 

# This is the simplest type of reordering 
# because it doesn’t need any extra variables. 
# You may want to combine with fct_rev().

gss_cat %>%
mutate(marital = marital %>% fct_infreq() %>% fct_rev()) %>%
  ggplot(aes(marital)) +
  geom_bar() + theme_light()

# without fct_rev():
gss_cat %>%
  mutate(marital = marital %>% fct_infreq()) %>% # fct_rev()) %>%
  ggplot(aes(marital)) +
  geom_bar() + theme_light()


## 15.4.1 Exercises -----

# 1. There are some suspiciously high numbers in tvhours. 
#    Is the mean a good summary?

gss_cat %>%
  group_by(tvhours) %>%
  count() %>%
  arrange(desc(n))

# Check distribution:
gss_cat %>%
  filter(!is.na(tvhours)) %>%
  ggplot(aes(x = tvhours)) +
  geom_histogram(binwidth = .5)

# Distribution looks skewed.  

# Alternative 1: Use median instead!
# Above example when using median:

relig_tv <- gss_cat %>%
  group_by(relig) %>%
  summarise(
    age = mean(age, na.rm = TRUE),
    tvhours = median(tvhours, na.rm = TRUE),
    n = n()
  )

relig_tv %>%
  mutate(relig = fct_reorder(relig, tvhours)) %>%  # new mutate step!
  ggplot(aes(tvhours, relig)) +
  geom_point(aes(size = n)) + theme_light()

# Alternative 2: Rescale tvhours via log_transformation.

   
# 2. For each factor in gss_cat identify whether the order of the levels 
#    is arbitrary or principled.

gss_cat

# marital: 
levels(gss_cat$marital)  # seems somehwat systematic.

gss_cat %>%
  group_by(marital) %>%
  count()

# => marital factor levels seem somewhat systematic, 
# but married could be moved before separated/divorced/widowed.

# race:
levels(gss_cat$race)  # seems unprincipled.

gss_cat %>%
  group_by(race) %>%
  count()

# => race factor levels seem arranged by frequency.

# partyid:
levels(gss_cat$partyid)  # seems principled: 3 other, 
                         # then from strong rep to strong dem.


# 3. Why did moving “Not applicable” to the front of the levels 
#    move it to the bottom of the plot?

ggplot(rincome_summary, aes(age, fct_relevel(rincome, "Not applicable"))) + 
  geom_point(aes(size = n)) + theme_light()

# Effects of fct_relevel: 
levels(gss_cat$rincome)            # has "Not applicable" at the end
levels(fct_relevel(gss_cat$rincome, "Not applicable"))  # at the front


## 15.5 Modifying factor levels ------

# More powerful than changing the orders of the levels is changing their values.
# This allows clarifying labels for publication, and collapsing levels for
# high-level displays. 

## (A) fct_recode(): ---- 

# The most general and powerful tool is fct_recode(). 
# It allows recoding, or changing, the value of each level. 

# For example, take the gss_cat$partyid:
gss_cat %>% count(partyid)

# The levels are terse and inconsistent. 

## 1. Changing factor levels: 

# Let’s tweak them to be longer and use a parallel construction: 

gss_cat %>%
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong"    = "Strong republican",
                              "Republican, weak"      = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak"        = "Not str democrat",
                              "Democrat, strong"      = "Strong democrat"
  )) %>%
  count(partyid)

# Note that the level "Independent" was not changed.
# fct_recode() will leave levels that aren’t explicitly mentioned as is, 
# and will issue a warning if we accidentally refer to a level that doesn’t exist.

## 2. Combining factor levels:

# To combine groups, we can assign multiple old levels to the same new level:
  
gss_cat %>%
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong"    = "Strong republican",
                              "Republican, weak"      = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak"        = "Not str democrat",
                              "Democrat, strong"      = "Strong democrat",
                              "Other"                 = "No answer",
                              "Other"                 = "Don't know",
                              "Other"                 = "Other party"
  )) %>%
  count(partyid)

# Use this technique with care: 
# Grouping together categories that are truly different yields misleading results. 

## (B) fct_collapse(): ----

# fct_collapse() is a variant of fct_recode() 
# for collapsing or combining a lot of levels.

# For each new level, we provide a vector of old levels:
gss_cat %>%
  mutate(partyid = fct_collapse(partyid,
                                other = c("No answer", "Don't know", "Other party"),
                                rep = c("Strong republican", "Not str republican"),
                                ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                                dem = c("Not str democrat", "Strong democrat")
  )) %>%
  count(partyid)

## (C) fct_lump(): ----

# Sometimes we just want to lump together all the small groups 
# to make a plot or table simpler. 
# That’s the job of fct_lump():
  
gss_cat %>%
  mutate(relig = fct_lump(relig)) %>%
  count(relig)

# The default behaviour is to progressively lump together the smallest groups,
# ensuring that the aggregate is still the smallest group. 

# In this case it’s not very helpful: it is true that the majority of Americans 
# in this survey are Protestant, but we’ve probably over collapsed.

# Instead, we can use the n parameter to specify how many groups 
# (excluding "Other") we want to keep:
  
gss_cat %>%
  mutate(relig = fct_lump(relig, n = 10)) %>%
  count(relig, sort = TRUE) %>%
  print(n = Inf)  # prints all rows of a tibble

gss_cat %>%
  mutate(relig = fct_lump(relig, n = 5)) %>%
  count(relig, sort = TRUE) %>%
  print(n = Inf)  # prints all rows of a tibble



## 15.5.1 Exercises -----

# 1. How have the proportions of people identifying as 
#    Democrat, Republican, and Independent changed over time?

gss_cat

# (a) Party by year (collapsing over subtypes of partyid): 
year_party_n <- gss_cat %>%
  mutate(partyid = fct_collapse(partyid,
                                other = c("No answer", "Don't know", "Other party"),
                                rep = c("Strong republican", "Not str republican"),
                                ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                                dem = c("Not str democrat", "Strong democrat")
  )) %>%
  group_by(year) %>%
  count(partyid)
year_party_n

# (b) N per year:
year_n <- gss_cat %>%
  group_by(year) %>%
  count()
year_n

# (c) Use year_n as (relational) lookup table for gss_cat
year_party_n2 <- left_join(year_party_n, year_n, by = "year")

# (d) Show percentages as line plot: 
year_party_n2 %>%
  mutate(perc = round(n.x/n.y * 100, 1)) %>%
  # mutate(partyid = fct_rev(fct_infreq(partyid))) %>%   # sort levels by frequency
  mutate(partyid = fct_relevel(partyid, "ind", "dem", "rep")) %>%  # sort levels manually
  ggplot(aes(x = year, y = perc, colour = partyid)) +
  geom_line(aes(linetype = partyid), size = 1) + 
  geom_point(size = 2) +
  scale_x_continuous(breaks = seq(2000, 2014, 2)) +    # adjust x-axis
  theme_light()
  

# 2. How could you collapse rincome into a small set of categories?

gss_cat %>% group_by(rincome) %>% count

## +++ here now +++ ------




## Appendix ------

## Web: Regex cheatsheets: 
#  https://www.rstudio.com/wp-content/uploads/2016/09/RegExCheatsheet.pdf

## Documentation: ----- 

# For more historical context on factors, read 
# stringsAsFactors: An unauthorized biography by Roger Peng, 
# https://simplystatistics.org/2015/07/24/stringsasfactors-an-unauthorized-biography/ 
# and 
# stringsAsFactors = <sigh> by Thomas Lumley.
# http://notstatschat.tumblr.com/post/124987394001/stringsasfactors-sigh

# Vignettes of R packages: 

## Related tools:

## Ideas for test questions [test.quest]: ------

## Multiple choice [MC] questions: -----

## Practical questions: ----- 

## ------
## eof.