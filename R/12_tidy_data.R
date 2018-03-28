## r4ds: Chapter 12: Tidy data  
## Code for http://r4ds.had.co.nz/tidy-data.html
## hn spds uni.kn
## 2018 03 27 ------

## Quotes: ------

## “Happy families are all alike; every unhappy family is unhappy in its own way.” 
##  Leo Tolstoy

## “Tidy datasets are all alike, but every messy dataset is messy in its own way.” 
##  Hadley Wickham


## 12.1 Introduction ------

# In this chapter, we learn a consistent way to organise data (in R)  
# -- an organisation called "tidy" data. 

# Getting data into this format requires some work, 
# but that work pays off in the long term. 

# The tidyr package addresses practical problems.
# For more theory, see the Tidy Data paper published in the Journal of Statistical Software
# at http://www.jstatsoft.org/v59/i10/paper. 

# In this chapter we’ll focus on tidyr, a package that provides tools that help tidying up messy datasets. 
# tidyr is a core member of the tidyverse: 

library(tidyverse)

## 12.2 Tidy data (Definition and Motivation) ------

# Data can be represented in multiple ways. 

# Example of the same data organised in 4 different ways:

table1
table2
table3
table4a
table4b
table5

# See 
?table1 # for semantics and source of data

# These are all representations of the same underlying data, 
# but they are not equally easy to use. 

# Note: What is "easy" or "hard" depends not just on the data (and its format), 
#       but also on (its degree of fit/match to) the task and methods/tools.

# One dataset, the tidy dataset, will be much easier to work with inside the tidyverse.


## Definition: There are 3 interrelated rules which make a dataset "tidy":

# 1. Each variable must have its own column.
# 2. Each observation must have its own row.
# 3. Each value must have its own cell.

# Figure 12.1 shows the rules visually: 
# http://r4ds.had.co.nz/tidy-data.html#fig:tidy-structure 

# These three rules are interrelated because it’s impossible to only satisfy 2 of the 3. 
# That interrelationship leads to an even simpler set of practical instructions:

# A. Put each dataset in a tibble.
# B. Put each variable in a column.

# In the above example, only table1 is tidy. 
# It’s the only representation in which each column is a variable.
# (Note that you need to interpret the semantics of the variables 
#  to make and understand this statement.)


## Advantages of tidy data:

# 1. Consistency: Consistent data structures make it easier to learn the tools 
#    that work with it because they have an underlying uniformity.

# 2. Vectorization: Placing variables in columns allows R’s vectorised nature to shine. 
#    For instance, mutate and summary functions (and most built-in R functions) work with vectors of values. 
#    That makes transforming tidy data feel particularly natural.

# 3. Matching data and tools: 
#    dplyr, ggplot2, and other packages are designed to work with tidy data.


## Examples of working with tidy table1:

table1

# (a) Compute expected rate per 10,000 people: 
table1 %>% 
  mutate(per_10k = (cases / population) * 10000)

# (b) # Compute number of cases expected per year:
table1 %>% 
  count(year, wt = cases)

# Compute number of cases expected per country:
table1 %>% 
  count(country, wt = cases)

# by country and year (as in original table1):
table1 %>% 
  group_by(country) %>%
  count(year, wt = cases)

# Visualise changes over time: 
library(ggplot2)

ggplot(table1, aes(year, cases, group = country, color = country)) + 
  geom_line(aes(linetype = country), size = 1) + 
  geom_point(aes(shape = country), size = 3) + 
  theme_light()


## [test.quest]: Make a corresponding bar chart: 

# ?geom_bar

ggplot(table1, aes(x = year, y = cases)) + 
  geom_bar(aes(fill = country), stat = "identity", position = "dodge") + 
  theme_light()


## 12.2.1 Exercises -----

# 1. Using prose, describe how the variables and observations 
#    are organised in each of the sample tables.

table1  # is tidy (3 criteria), but also in long format 
table2  # is table1 in long format (type - count)
table3  # combines cases/population into rate
table4a # contains cases in wide format
table4b # contains populations in wide format 
table5  # splits year of table3 into 2 variables (century, year)

# 2. Compute the rate for (a) table2, and (b) table4a + table4b. 
#    You will need to perform four operations:
#    a. Extract the number of TB cases per country per year.
#    b. Extract the matching population per country per year.
#    c. Divide cases by population, and multiply by 10000.
#    d. Store back in the appropriate place.

# (A) from table2: 
table2

cases <- table2 %>%
  filter(type == "cases") %>%
  group_by(country, year)
cases

population <- table2 %>%
  filter(type == "population") %>%
  group_by(country, year)
population

rate <- cases$count/population$count * 10000
rate # contains desired rates

# ???: How to add column(s) to an existing tibble with dplyr?
mutate(cases, 
       rate = rate) # does not work... 

# Solutions: 
# (a) Combine individual vectors into a tibble: 
tibble(country = cases$country,
       cases = cases$count, 
       population = population$count,
       rate = rate)

# (b) Using left_join from Chapter 13: 
#     http://r4ds.had.co.nz/relational-data.html#relational-data [???]:

# Note: The "count" columns of cases and population contain different counts,
#       but have the same name.  We should name them more informatively: 

# cases <- as_data_frame(cases)
names(cases[4]) <- "n_cases"  # How to change the name of a tibble column?
cases

names(population$count) <- "pop"
population

# After renaming them, we can join the two tibbles: 
left_join(cases, population) # => population is missing! [???]


# (B) from table4a and table4b: 

table4a # contains cases
table4b # contains populations

table4c <- table4a[, -1]/table4b[, -1] * 10000
table4c # contains desired rates

# Combine into a tibble:
tibble(country = table4a$country,
       rate_99 = table4c$`1999`,
       rate_00 = table4c$`2000`)

# 3. Which representation is easiest to work with? Which is hardest? Why?

#    Answer: This (generally) depends on the type of task and tools.
  
# 4. Recreate the plot showing change in cases over time using table2 
#    instead of table1. What do you need to do first?

cases <- filter(table2, type == "cases")  # 1. filter to remove population counts 
cases

ggplot(cases, aes(x = year, y = count, group = country, color = country)) +
  geom_line(aes(linetype = country), size = 1) + 
  geom_point(aes(shape = country), size = 3) + 
  theme_light()


## 12.3 Spreading and gathering ------

# Why is data not always tidy?  
# 2 main reasons:

# 1. Ignorance:  Most people aren’t familiar with the principles of tidy data. 
# 2. Other priorities: Ensure easy of entry, 
#    particular methods require particular (e.g., wide or long) formats.

# This means for most real analyses, you’ll need to do some tidying. 

# Step 1: Figure out what the variables and observations are. 
# Sometimes this is easy; otherwise consult whoever generated the data. 

# Step 2: Resolve one of two common problems:
# a. One variable might be spread across multiple columns.
# b. One observation might be scattered across multiple rows.

# Typically a dataset will only suffer from one of these problems; 
# it’ll only suffer from both if you’re really unlucky! 

# To fix these problems, you’ll need the two most important functions in tidyr: 
# - gather() and 
# - spread().


## 12.3.1 Gathering -----

# Change format: From wide to long... 

# A common problem is a dataset where some of the column names are  
# NOT names of variables, but values of a variable. 

# Consider table4a: 
# the column names 1999 and 2000 represent values of the year variable, 
# and each row represents 2 observations, not 1:

table4a

# Note: This is common in the wide format which some programs require 
#       (to show each case/observation in 1 row, and multiple measurements in columns).

# To tidy a dataset like this, we need to _gather_ columns into a new pair of variables. 

# To describe that operation we need 3 parameters:
  
# 1. The set of columns that represent values, not variables. 
#    In this example, those are the columns 1999 and 2000.

# 2. The name of the variable whose values form the column names. 
#    I call that the "key", and here it is "year".

# 3. The name of the variable whose values are spread over the cells. 
#    I call that "value", and here it’s the number of "cases".

# Together these 3 parameters generate the call to gather():

table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")

# See Figure 12.2 for a visualization of this operation: 
# http://r4ds.had.co.nz/tidy-data.html#fig:tidy-gather

# Notes: 
# - The columns to gather are specified with dplyr::select() style notation. 
#   Here there are only 2 columns, so we list them individually. 

# - Note that “1999” and “2000” are non-syntactic names 
#   -- because they don’t start with a letter --  
#   so we have to surround them in backticks. 

# - To refresh your memory of the other ways to select columns, 
#   see http://r4ds.had.co.nz/transform.html#select 


# We can use gather() to tidy table4b in a similar fashion. 
# The only difference is the variable stored in the cell values:

table4b 

table4b %>% 
  gather(`1999`:`2000`, key = "year", value = "pop")

# To combine the tidied versions of table4a and table4b into a single tibble, 
# we need to use dplyr::left_join(), which you’ll learn about in 
# relational data: http://r4ds.had.co.nz/relational-data.html#relational-data 

tidy4a <- table4a %>% 
  gather(`1999`:`2000`, key = "year", value = "cases")

tidy4b <- table4b %>% 
  gather(`1999`:`2000`, key = "year", value = "pop")

left_join(tidy4a, tidy4b)


## 12.3.2 Spreading -----

# Change format: From long to wide...

# Spreading is the opposite of gathering. 
# Use it when an observation is scattered across multiple rows. 

# For example, take table2: 

table2

# Definition: An "observation" is the state (or several values) of a country in a year, 
# but in table2 each observation is spread across 2 rows.

# To tidy this up, we first analyse the representation in similar way to gather(). 
# This time, however, we only need two parameters:
  
# 1. The column that contains variable names, the "key" column. 
#    Here, it’s "type".

# 2. The column that contains values forms multiple variables, the "value" column. 
#    Here it’s "count".

# Once we’ve figured that out, we can use spread(), 
# a) programmatically:

spread(table2, key = type, value = count)

# b) visually in Figure 12.3: 
#    http://r4ds.had.co.nz/tidy-data.html#fig:tidy-spread 


# As you might have guessed from the common key and value arguments, 
# spread() and gather() are complements. 

# 1. gather() makes wide tables narrower and longer; 
# 2. spread() makes long tables shorter and wider.


## 12.3.3 Exercises -----

# 1. Why are gather() and spread() not perfectly symmetrical?
#    Carefully consider the following example:
  
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
  )

stocks

stocks %>% 
  spread(year, return) %>% 
  gather("year", "return", `2015`:`2016`)

# - Order of year and half changed
# - Year changed to character type.

# (Hint: look at the variable types and think about column names.)

# Both spread() and gather() have a convert argument. What does it do?

?gather

# convert ... If TRUE will automatically run type.convert() on the key column. 
#             This is useful if the column names are actually numeric, integer, or logical.

# Try convert = TRUE on gather():

stocks %>% 
  spread(year, return) %>% 
  gather("year", "return", `2015`:`2016`, convert = TRUE)

# => year is now of type "integer" (rather than "character").


## 2. Why does this code fail?

table4a %>% 
  gather(1999, 2000, key = "year", value = "cases")

# Non-regular column names in table4a: When variables do not start with a character, 
# they must be enclosed in ``:

table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")

# 3. Why does spreading this tibble fail? 
#    How could you add a new column to fix the problem?

people <- tribble(
  ~name,             ~key,    ~value,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
  )

glimpse(people)

people %>%
  spread(key, value)

# Error: Duplicate identifiers for rows (1, 3)
# PW has 2 age values (or 2 observations).

# To fix this, add the observation column:

people <- tribble(
  ~name,             ~key,    ~value,  ~obs, 
  #-----------------|--------|------|-------
  "Phillip Woods",   "age",       45,  1, 
  "Phillip Woods",   "height",   186,  1, 
  "Phillip Woods",   "age",       50,  2, 
  "Jessica Cordero", "age",       37,  1, 
  "Jessica Cordero", "height",   156,  1  
)

glimpse(people)

people %>%
  spread(key, value)

# Note: PW's height is NA for obs == 2. 

# 4. Tidy the simple tibble below. 
#    Do you need to spread or gather it? 
#    What are the variables?

preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)

preg

# - gather from 2x2 into 4 lines.
# - variables: sex, preg, count

preg %>%
  gather("male":"female", key = "sex", value = "count")

# [test.quest]: Turn any 2x2 contingency table into a tidy table. 

# See also the more complicated solution from 
# https://jrnold.github.io/r4ds-exercise-solutions/tidy-data.html#spreading-and-gathering
# turns pregnant and female into logical values:

gather(preg, sex, count, male, female) %>%
  mutate(pregnant = pregnant == "yes",
         female = sex == "female") %>%
  select(-sex)

# Converting pregnant and female from character vectors to logical 
# was not necessary to tidy it, but it makes it easier to work with.



## 12.4 Separating and uniting ------


# So far we’ve learned how to tidy table2 and table4, but not table3. 

table3

# table3 has a different problem: 
# 1 column (rate) contains 2 variables (cases and population). 

# To fix this problem, we’ll need the separate() function. 

# The complement of separate() is unite(), which we use if 
# a single variable is spread across multiple columns.

## 12.4.1 Separate -----

# separate() pulls apart one column into multiple columns, 
# by splitting wherever a separator character appears. 
# Take table3:

table3 

# The rate column contains both cases and population variables, 
# and we need to split it into 2 variables. 

## (1) Separating by regular expression (i.e., some pattern or character): 

# separate() takes the name of the column to separate, 
# and the names of the columns to separate into, as shown in 
# Figure 12.4 at http://r4ds.had.co.nz/tidy-data.html#fig:tidy-separate 
# and the code:

table3 %>% 
  separate(rate, into = c("cases", "population"))

# By default, separate() will split values wherever it sees a 
# non-alphanumeric character (i.e. a character that isn’t a number or letter). 

# For example, in the code above, separate() split the values of rate 
# at the forward slash characters "/". 

# If you wish to use a specific character to separate a column, 
# you can pass the character to the sep argument of separate(). 
# For example, we could rewrite the code above as:

table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/")

# (Formally, sep is a regular expression, which you’ll learn more about 
#  in strings at http://r4ds.had.co.nz/strings.html#strings  )

# Look carefully at the column types: 
# you’ll notice that case and population are character columns. 
# This is the default behaviour in separate(): 
# it leaves the type of the column as is. 

# Here, however, it’s not very useful as those really are numbers. 
# We can ask separate() to try and convert to better types using 
# convert = TRUE:

table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/", convert = TRUE)

## (2) Separating by position:

# You can also pass a vector of integers to sep. 
# separate() will interpret the integers as positions to split at. 
# Positive values start at 1 on the far-left of the strings; 
# negative value start at -1 on the far-right of the strings. 

# When using integers to separate strings, the length of sep 
# should be one less than the number of names in into:

# You can use this arrangement to separate the last two digits of each year. 
# This make this data less tidy, but is useful in other cases, 
# as you’ll see in a little bit:

table3 %>% 
  separate(year, into = c("century", "year"), sep = 2)


## 12.4.2 Unite -----

# unite() is the inverse of separate(): 
# it combines multiple columns into a single column. 

# We need it much less frequently than separate(), 
# but it’s still a useful tool.  

# We can use unite() to rejoin the century and year columns 
# that we created in the last example. 

# That data is saved as tidyr::table5:

tidyr::table5

# unite() takes a data frame, the name of the new variable to create, 
# and a set of columns to combine, again specified in dplyr::select() style:

table5 %>% 
  unite(new, century, year)

# In this case we also need to use the sep argument. 
# The default will place an underscore (_) between the values from different columns. 
# Here we don’t want any separator so we use "":

table5 %>% 
  unite(new, century, year, sep = "")

## 12.4.3 Exercises -----

# 1. What do the extra and fill arguments do in separate()? 
#    Experiment with the various options for the following two toy datasets: 

?separate

# (a) extra controls what happens when there are too many pieces:
#     (as determined by in 1st line): 

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))  # yields warning: Too many values at 1 locations: 2

t1 <- tibble(x = c("a,b,c", "d,e,f,g", "h,i,j"))
t1

t1 %>% 
  separate(x, c("one", "two", "three"), extra = "warn") # default

t1 %>%
  separate(x, c("one", "two", "three"), extra = "drop") # drops extra element

t1 %>%
  separate(x, c("one", "two", "three"), extra = "merge") # merges 2 elements into 1


# (b) fill controls what happens when there are not enough pieces 
#     (as determined by in 1st line): 

tibble(x = c("a,b,c", "d,e", "f,g,i")) %>% 
  separate(x, c("one", "two", "three"))  # yields warning: Too few values at 1 locations: 2  

t2 <- tibble(x = c("a,b,c", "d,e", "f,g,i"))

t2 %>%
  separate(x, c("one", "two", "three"), fill = "warn")  # default

t2 %>%
  separate(x, c("one", "two", "three"), fill = "right")  # fill with missing values (NA) on right

t2 %>%
  separate(x, c("one", "two", "three"), fill = "left")  # fill with missing values (NA) on left

# 2. Both unite() and separate() have a remove argument. 
#    What does it do? Why would you set it to FALSE?

?unite

# If remove = TRUE (as by default), input columns are removed 
# from output data frame.
# remove = FALSE keeps the input columns:

table5 %>% 
  unite(yr, century, year, sep = "", remove = FALSE)

table5 %>%
  separate(rate, into = c("n_cases", "n_popu"), remove = FALSE)

# 3. Compare and contrast separate() and extract(). 
#    Why are there three variations of separation (
#  - by position, 
#  - by separator, and 
#  - with groups),
#    but only one unite?

?separate # separates 
# - by separator 
# - by position

?extract
# - Given a regular expression with capturing groups, 
#   extract() turns each group into a new column.

# Unite presumably works with all of the above?

# The function extract uses a regular expression 
# to find groups and split into columns. 

# In unite it is unambiguous since it combines many columns into 1, 
# and once the columns are specified, there is only one way to do it, 
# the only choice is the sep. 
# By contrast, separate, splits 1 column into many, 
# and there are different ways to split a character string.


## 12.5 Missing values ------

# Changing the representation of a dataset brings up 
# an important subtlety of missing values. Surprisingly, 
# a value can be missing in 1 of 2 possible ways:
  
# 1. Explicitly, i.e. flagged with NA.
# 2. Implicitly, i.e. simply not present in the data.

# Example: 
stocks <- tibble(
  year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr    = c(   1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
)

stocks

# Note the 2 missing values in this dataset:
# - return of 2015 q4 is explicitly missing
# - anything of 2016 q1 is implicitly missing

# Zen-like koan: 
# - An explicit missing value is the presence of an absence; 
# - an implicit missing value is the absence of a presence.

# (cute, but an explicit missing value is also absence of a presence)

# The way that a dataset is represented can make implicit values explicit. 
# For example, we can make the implicit missing value explicit 
# by putting years in the columns:

stocks %>% 
  spread(year, return)

# or putting qtr in columns: 

stocks %>% 
  spread(qtr, return)

# or both???

stocks %>%
  spread(c(year, qtr), return)

# [test.quest]: How to spread 2 factors 
# (in repeated-measurement design with 2 within-subjects factors)?

# See Solution and Discussion at 

# a) Long to wide:
# https://stackoverflow.com/questions/29775461/how-can-i-spread-repeated-measures-of-multiple-variables-into-wide-format?noredirect=1&lq=1
# b) Wide to long:
# https://stackoverflow.com/questions/29473399/tidyr-wide-to-long-with-two-repeated-measures


## Making implicit NAs explicit -----

## (1) na.rm = TRUE/FALSE

# Because these explicit missing values may not be important 
# in other representations of the data, you can set na.rm = TRUE 
# in gather() to turn explicit missing values implicit:
  
stocks %>% 
  spread(year, return) %>% 
  gather(year, return, `2015`:`2016`, na.rm = TRUE)

# Contrast with na.rm = FALSE:

stocks %>% 
  spread(year, return) %>% 
  gather(year, return, `2015`:`2016`, na.rm = FALSE)


## (2) complete 

# Another important tool for making missing values explicit in tidy data 
# is complete():

stocks %>% 
  complete(year, qtr)

# complete() takes a set of columns, and finds all unique combinations. 
# It then ensures the original dataset contains all those values, 
# filling in explicit NAs where necessary.


## (3) fill 

# Sometimes when a data source has primarily been used for data entry, 
# missing values indicate that the previous value should be carried forward:
  
treatment <- tribble(
    ~person,           ~treatment, ~response,
    "Derrick Whitmore", 1,           7,
    NA,                 2,           10,
    NA,                 3,           9,
    "Katherine Burke",  1,           4
  )

# We can fill in these missing values with fill(). 
# Fill() takes a set of columns where you want missing values 
# to be replaced by the most recent non-missing value 
# (sometimes called last observation carried forward).

treatment %>%
  fill(person)


## 12.5.1 Exercises -----

# 1. Compare and contrast the fill() arguments 
#    to spread() and complete().

?fill
?spread

# 2. What does the direction argument to fill() do?
  
# .direction = c("down", "up"))

treatment %>%
  fill(person, .direction = "up")


## 12.6 Case Study ------

# Let’s pull together everything we’ve learned to tackle a realistic data tidying problem. 

# The tidyr::who dataset contains tuberculosis (TB) cases broken down by 
# year, country, age, gender, and diagnosis method. 
# The data comes from the 2014 World Health Organization Global Tuberculosis Report, 
# available at http://www.who.int/tb/country/data/download/en/.

# There’s a wealth of epidemiological information in this dataset, 
# but it’s challenging to work with the data in the form that it’s provided:
  
tidyr::who

# This is a very typical real-life example dataset. 
# It contains redundant columns, odd variable codes, and many missing values. 
# In short, who is messy, and we’ll need multiple steps to tidy it.

# The best place to start is almost always to gather together the columns 
# that are not variables. Let’s have a look at what we’ve got:

# 1. It looks like country, iso2, and iso3 are 3 variables that 
#    redundantly specify the country.

# 2. year is clearly also a variable.

# 3. We don’t know what all the other columns are yet, 
#    but given the structure in the variable names 
#   (e.g. new_sp_m014, new_ep_m014, new_ep_f014) 
#   these are likely to be values, not variables.

# => So we need to gather together all the columns from new_sp_m014 to newrel_f65. 
# 1. We don’t know what those values represent yet, so we’ll give them 
#    the generic name "key". 
# 2. We know the cells represent the count of cases, so we’ll use the variable cases. 
# 3. There are a lot of missing values in the current representation, 
#    so for now we’ll use na.rm just so we can focus on the values that are present.

who1 <- who %>% 
  gather(new_sp_m014:newrel_f65, key = "key", value = "cases", na.rm = TRUE)

who1

# We can get some hint of the structure of the values in the new key column 
# by counting them:
  
who1 %>% 
  count(key)

# The data dictionary tells us:

# 1. The first three letters of each column denote whether the column contains
#    "new" or "old" cases of TB. In this dataset, each column contains "new" cases.

# 2. The next two letters describe the type of TB:
#    - rel stands for cases of relapse
#    - ep stands for cases of extrapulmonary TB
#    - sn stands for cases of pulmonary TB that could not be diagnosed by a pulmonary smear (smear negative)
#    - sp stands for cases of pulmonary TB that could be diagnosed be a pulmonary smear (smear positive)

# 3. The sixth letter gives the sex of TB patients. 
#    The dataset groups cases by males (m) and females (f).

# 4. The remaining numbers gives the age group. 
#    The dataset groups cases into seven age groups:
#   - 014 = 0 – 14 years old
#   - 1524 = 15 – 24 years old
#   - 2534 = 25 – 34 years old
#   - 3544 = 35 – 44 years old
#   - 4554 = 45 – 54 years old
#   - 5564 = 55 – 64 years old
#   - 65 = 65 or older

# We need to make a minor fix to the format of the column names: 
# unfortunately the names are slightly inconsistent because instead of 
# new_rel we have newrel (it’s hard to spot this here 
# but if you don’t fix it we’ll get errors in subsequent steps). 

# You’ll learn about str_replace() in strings, but the basic idea 
# is pretty simple: replace the characters “newrel” with “new_rel”. 
# This makes all variable names consistent.

who2 <- who1 %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))

who2

# We can separate the values in each code with two passes of separate(). 

# 1. The first pass will split the codes at each underscore:

who3 <- who2 %>% 
  separate(key, c("new", "type", "sexage"), sep = "_")

who3

# 2. Next we’ll separate sexage into sex and age by splitting after the first character:

who4 <- who3 %>% 
  separate(sexage, c("sex", "age"), sep = 1)

who4

# Dropping redundant variables:

# We might as well drop the "new" column 
# because it’s constant in this dataset: 

who4 %>% 
  count(new)

# While we’re dropping columns, let’s also drop 
# "iso2" and "iso3" since they’re redundant:

who5 <- who4 %>% 
  select(-new, -iso2, -iso3)

who5

# The who dataset is now tidy!

## Note:

# The above steps illustrate the code a piece at a time, 
# assigning each interim result to a new variable. 

# This is often a good idea -- as it makes intermediate steps transparent -- but 
# if the intermediate steps are never needed, there is a shorter way:  
# Typically, you’d gradually build up a complex pipe:
  
who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = stringr::str_replace(code, "newrel", "new_rel")) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  separate(sexage, c("sex", "age"), sep = 1) %>% 
  select(-new, -iso2, -iso3)



## 12.6.1 Exercises -----

# 1. In this case study I set na.rm = TRUE just to make it easier 
#    to check that we had the correct values. Is this reasonable? 
#    Think about how missing values are represented in this dataset. 
#    Are there implicit missing values? 
#    What’s the difference between an NA and zero?

who
dim(who)

# Number of cases and NA cases: 
N <- nrow(who) * ncol(who)
n_NA <- sum(is.na(who))
n_not_NA <- sum(!is.na(who))

(n_NA + n_not_NA) == N # should be true
n_NA/N  # percentage of NA cases

# => 76% pf all cases are NA, hence dropping them is reasonable.

## Any implicit missing values?

who1 <- who %>% 
  gather(new_sp_m014:newrel_f65, key = "key", value = "cases", na.rm = TRUE)
# who1

who1 %>%
  filter(cases == 0) %>%
  nrow()

# There are 11080 country/year/key combinations with an
# explicit value of 0.


# For how many countries and years is there data?
# who
dim(who)

# => 219 countries
# => beyond 4 variables for country and year, 
#    there are 56 count variables (containing explicit NAs)

# Numerically: 
# 1 "new" x 4 types of TB x 2 genders x 7 age groups:
(1 * 4 * 2 * 7)  # => 56 count variables per country

# What about the existing range of years per country? 
ct <- who %>%
  count(country)
table(ct$n)

with(who, table(country, year))

# => Most countries (210 of 219) have data for 34 years,
#    but 9 have data from fewer years. 

#    Thus, it's possible that there are implicit missing values. 

#    However, removing explicit NAs does not change anything
#    as it treats explictly missing values like implicitly missing ones. 


# 2. What happens if you neglect the mutate() step? 
#    (mutate(key = stringr::str_replace(key, "newrel", "new_rel")))

who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  # mutate(code = stringr::str_replace(code, "newrel", "new_rel")) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  separate(sexage, c("sex", "age"), sep = 1) %>% 
  select(-new, -iso2, -iso3)

# Warning: Too few values at 2580 locations: 73467, 73468, 73469, ... 

who3e <- who1 %>% 
  separate(key, c("new", "type", "sexage"), sep = "_")

# Printing problematic rows:
who3e[73460:73480, ]

# => "new" is "newrel" and "type" becomes "m014" (rather than "sexage")...

## Filter out problematic range: 
filter(who3e, new == "newrel") # %>% head()


# 3. I claimed that iso2 and iso3 were redundant with country. 
#    Confirm this claim.

# "Redundancy" implies that using "iso2" or "iso3" instead of "country" 
# would yield the same result (in terms of table contents):

# However, the variable "country" was not used in the above pipe of commands 
# (i.e., cannot be replaced by "iso2" or "iso3".) 

# Count cases by country in 3 ways:

cs_country <- who1 %>%
  group_by(country) %>%
  summarise(count = n(),
            sum   = sum(cases)) %>%
  arrange(sum)

cs_iso2 <- who1 %>%
  group_by(iso2) %>%
  summarise(count = n(),
            sum   = sum(cases)) %>%
  arrange(sum)

cs_iso3 <- who1 %>%
  group_by(iso3) %>%
  summarise(count = n(),
            sum   = sum(cases)) %>%
  arrange(sum)


# Check for equality of counts and sums:
all.equal(select(cs_country, count, sum), select(cs_iso2, count, sum))
all.equal(select(cs_iso2, count, sum), select(cs_iso3, count, sum))

## Alternative solution:

select(who, country, iso2, iso3) %>%
  distinct() %>%
  group_by(country) %>%
  filter(n() > 1)

?distinct 

# 4. For each country, year, and sex compute the total number of cases of TB.
#    Make an informative visualisation of the data.
 





## +++ here now +++ ------




## [test.quest]:

## (1) Understand, redo, and improve on 
##     http://www.sharpsightlabs.com/blog/us-metro-gdp/



## Appendix ------

# See 

vignette("tidy-data")
?tidyr # and http://tidyr.tidyverse.org 

# This chapter provided a practical introduction to tidy data and the tidyr package. 

# To learn more about the underlying theory, see the Tidy Data paper 
# in the Journal of Statistical Software: http://www.jstatsoft.org/v59/i10/paper.

## ------
## eof.