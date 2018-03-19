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

## (1) Coercion by as_tibble(): ----

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

## (2) Creation by tibble(): ----

## Create a new tibble from individual vectors with tibble(). 

## tibble() will automatically recycle inputs of length 1, and 
## allows you to refer to variables that you just created: 

tibble(
  x = 1:5, 
  y = 1, 
  z = x ^ 2 + y
  )

# tibble() does much less than data.frames: it 
# - never changes the type of the inputs 
#   (e.g., it never converts strings to factors!),
# - never changes the names of variables, and 
# - never creates row names.

# It’s possible for a tibble to have column names that are not valid R variable
# names, aka non-syntactic names. 

# For example, they might not start with a
# letter, or they might contain unusual characters like a space. To refer to
# these variables, you need to surround them with backticks, `:

tb <- tibble(
  `:)` = "smile", 
  ` ` = "space",
  `2000` = "number"
  )

tb

## (3) Creation by tribble(): ---- 

# Another way to create a tibble is with tribble(), short for transposed tibble.

# tribble() is customised for data entry in code: 
# - column headings are defined by formulas (i.e., they start with ~), and 
# - entries are separated by commas. 

# This makes it possible to lay out small amounts of data in easy to read form: 

tribble(
  ~x, ~y, ~z,
  #--|--|----
  "a", 2, 3.6,
  "b", 1, 8.5
)


## 10.3 Tibbles vs. data.frame ------

# There are 2 main differences in the usage of a tibble vs. a classic data.frame: 
# 1. printing and 
# 2. subsetting.

## 10.3.1 Printing -----

# Tibbles have a refined print method that shows only the first 10 rows, 
# and all the columns that fit on screen. 
# This makes it much easier to work with large data. 

# In addition to its name, each column reports its type, a nice feature
# borrowed from str():
  
tibble(
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE)
)

# Tibbles are designed so that you don’t accidentally overwhelm your console
# when you print large data frames. But sometimes you need more output than the
# default display. There are a few options that can help.

# First, you can explicitly print() the data frame and control the number of
# rows (n) and the width of the display. 
# Setting width = Inf will display all columns:
  
nycflights13::flights %>% 
  print(n = 10, width = Inf)

# You can also control the default print behaviour by setting options:
# - options(tibble.print_max = n, tibble.print_min = m): if more than m rows, print only n rows. 
# - options(dplyr.print_min = Inf) to always show all rows.
# - options(tibble.width = Inf) to always print all columns, regardless of the width of the screen.

# You can see a complete list of options by looking at the package help with
# package?tibble.

# A final option is to use RStudio’s built-in data viewer to get a scrollable
# view of the complete dataset. This is also often useful at the end of a long
# chain of manipulations:

nycflights13::flights %>% 
  View()

## 10.3.2 Subsetting -----

# So far all the tools you’ve learned have worked with complete data frames. 

# If you want to pull out a single variable, you need some new tools, $ and [[. 
# - [[ can extract by name or position; 
# - $ only extracts by name but is a little less typing.

df <- tibble(
  x = runif(5),
  y = rnorm(5)
  )

# Extract by name: 
df$x
df[["x"]]

# Extract by position: 
df[[1]]

# To use these in a pipe, you’ll need to use the special placeholder .:
  
df %>% .$x
df %>% .[["x"]]

# Compared to a data.frame, tibbles are more strict: 
# - they never do partial matching, and 
# - they will generate a warning if the column you are trying to access does not exist.


## 10.4 Interacting with older code ------

# Some older functions don’t work with tibbles. If you encounter one of these
# functions, use as.data.frame() to turn a tibble back to a data.frame:

tb  
class(tb)

df <- as.data.frame(tb)
class(df)

# The main reason that some older functions don’t work with tibble 
# is the [ function. 

# We don’t use [ much in this book because dplyr::filter() and dplyr::select() 
# allow you to solve the same problems with clearer code 
# (but you will learn a little about it in vector subsetting). 

# - With base R data frames, [ sometimes returns a data frame, 
#   and sometimes returns a vector. 
# - With tibbles, [ always returns another tibble.


# +++ here now +++ ------

## 10.5 Exercises ------

# 1. How can you tell if an object is a tibble? (Hint: try printing mtcars,
#    which is a regular data frame).

# 2. Compare and contrast the following operations on a data.frame and
#    equivalent tibble. What is different? Why might the default data frame
#    behaviours cause you frustration?
  
df <- data.frame(abc = 1, xyz = "a")
df$x
df[, "xyz"]
df[, c("abc", "xyz")]

# 3. If you have the name of a variable stored in an object, e.g. var <- "mpg",
#    how can you extract the reference variable from a tibble?
  
# 4. Practice referring to non-syntactic names in the following data frame by:
# a. Extracting the variable called 1.
# b. Plotting a scatterplot of 1 vs 2.
# c. Creating a new column called 3 which is 2 divided by 1.
# d. Renaming the columns to one, two and three.

annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)

# 5. What does tibble::enframe() do? 
#    When might you use it?
  
# 6. What option controls how many additional column names are printed at the
#    footer of a tibble?


## Appendix ------

# If this chapter leaves you wanting to learn more about tibbles, you might enjoy 

vignette("tibble")

## ------
## eof.