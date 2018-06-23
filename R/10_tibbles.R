## r4ds: Chapter 10: Tibbles  
## Code for http://r4ds.had.co.nz/tibbles.html 
## hn spds uni.kn
## 2018 06 21 ------



## 10.1 Introduction ------

# In this chapter we’ll explore the tibble package, part of the core tidyverse:

library(tidyverse)

# From 

vignette("tibble")

# Tibbles are a reduced form of and modern take on data frames. 
# They keep the features that have stood the test of time, 
# and drop the features that used to be convenient but are now frustrating 
# (e.g., converting character vectors to factors).




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
glimpse(it)

## [test.quest]: Explore iris (it).
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
  geom_point(size = 3, alpha = 1/3) + 
  theme_light()

# Insights: 
# - 3 clusters (partly overlapping)
# - low positive correlation

ggplot(it, aes(x = Petal.Length, y = Petal.Width, color = Species)) + 
  geom_point(size = 3, alpha = 1/3) + 
  theme_light()

# Insight:
# - 3 clear clusters (by species)
# - positive correlation (overall)

}

## Using mtcars data:
?mtcars

mtc <- as_tibble(mtcars)
mtc
glimpse(mtc)

## [test.quest]: Explore mtcars (mtc).


## (2) Creation by tibble(): ----

## Create a new tibble from individual vectors with tibble(). 

## tibble() will automatically recycle inputs of length 1, and 
## allows you to refer to variables that you just created: 

tibble(
  x = 1:5, 
  y = 1, 
  z = x ^ 2 + y
  )

# tibble() does much less than data.frames: 
# tibble  
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

# [in.class]: Creating a tibble for an experimental design ----- 
{
  # (1) 2-factorial experiment:  ----
  # A total of n = 180 people took part in an experiment.
  # Their unique IDs and final test scores are as follows:
  
  n <- 180
  ids <- 1:n
  set.seed(101)  # for reproducible results
  scores <- round(rnorm(n, 80, 15), 0)
  
  mean(scores)
  
  
  
  
  # (a) Create a tibble `dt` that contains 180 rows (1 for each participant)  
  #     and assigns them in turn to 2 experimental factors so that there are 
  #     an equal number of people in all (4 x 3 = 12) factor levels.
  
  # Use the following factor names and levels:
  # - `cond`, with 4 levels: "A", "B", "C", "D" 
  # - `drug`, with 3 levels: "beer", "coffee", "water"
  
  # To repeat a vector v to a length of l elements, 
  # use rep(v, length.out = l): 
  v <- c(0, 1)
  v
  rep(v, length.out = 11)
  
  conds <- rep(c("A", "B", "C", "D"), length.out = n)
  drugs <- rep(c("beer", "coffee", "water"), length.out = n)  
  
  e <- tibble(
    id = ids,
    cond = conds,
    drug = drugs, 
    score = scores
  )
  e
  
  # Note: Getting scores again:
  e$score      # as vector 
  e[["score"]] # as vector
  e[,4]        # as column vector
  
  
  # (b) What are the mean scores for each of the 12 conditions?
  
  # (c) Visualize the distribution of scores (overall)
  #     and the average scores for each level of `drug``
  
  
  # ad (a): Creating tibble: ----
  
  # Define vectors:
  cond_levels  <- c("A", "B", "C", "D")
  drug_levels <- c("beer", "coffee", "water")
  
  # Define tibble: 
  dt <- tibble(
    id = ids,
    cond = rep(cond_levels, length.out = n),  # to make length n
    drug = rep(drug_levels, length.out = n),  # to make length n
    score = scores 
  )
  
  # Note:
  # expand.grid(cond_levels, drug_levels)
  
  ## ad (b): Mean scores per condition: ---- 
  
  ## Counts and mean scores by experimental condition:
  dt %>% 
    group_by(cond, drug) %>%
    summarise(n = n(),
              mn_score = mean(score),
              sd_score = sd(score))
  
  ## ad (c): Visualizations: ----
  
  # - Distribution of scores:
  ggplot(dt, aes(x = scores)) +
    geom_histogram()
  
  # - Score as a function of drug (boxplots or density plots):
  ggplot(dt, aes(x = drug, y = score, color = drug)) +
    geom_boxplot() +
    # geom_violin() +
    geom_jitter(alpha = 2/3, width = .1) +
    coord_flip() +
    theme_bw()
  
  # - Score by cond and by drug (facets):
  #   ... 
  
}


## (3) Creation by tribble(): ---- 

# Another way to create a tibble is with tribble(), short for transposed tibble.

# tribble() is customised for data entry in code: 
# - column headings are defined by formulas (i.e., they start with ~), and 
# - entries are separated by commas. 

# This makes it possible to lay out small amounts of data in easy to read form: 

tribble(
  ~x, ~y, ~z,
  #--|--|---
  "a", 2, 3.6,
  "b", 1, 8.5
)



## 10.3 Tibbles vs. data.frame ------

# There are 2 main differences in the usage of a tibble vs. a classic data.frame: 
# 1. printing and 
# 2. subsetting.


## 10.3.1 Printing -----

## Basics: ---- 

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

## print() and print options: ----

# First, you can explicitly print() the data frame and control the number of
# rows (n) and the width of the display. 
# Setting width = Inf will display all columns:
  
nycflights13::flights %>% 
  print(n = 10, width = Inf)

# You can also control the default print behavior by setting options:
# - options(tibble.print_max = n, tibble.print_min = m): if more than m rows, print only n rows. 
# - options(dplyr.print_min = Inf) to always show all rows.
# - options(tibble.width = Inf) to always print all columns, regardless of the width of the screen.

# You can see a complete list of options by looking at the package help with
# package?tibble.

?tibble

## View(): ----

# A final option is to use RStudio’s built-in data viewer to get a scrollable
# view of the complete dataset. This is also often useful at the end of a long
# chain of manipulations:

nycflights13::flights %>% 
  View()

## glimpse(): ---- 

glimpse(nycflights13::flights)



## 10.3.2 Subsetting -----

# So far all the tools you’ve learned have worked with complete data frames. 

## Extracting variables from data frames: ---- 

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

## Subsetting with the pipe %>%: ---- 

# To use these in a pipe, you’ll need to use the special placeholder .:
  
df %>% .$x
df %>% .[["x"]]

# Compared to a data.frame, tibbles are more strict: 
# - they never do partial matching, and 
# - they will generate a warning if the column you are trying to access does not exist.

# [in.class]: Extracting parts of a tibble ----- 
{
  ## (1) Variables (columns): ---- 
  diamonds
  
  ## Individual variables (columns): 
  
  ## Task 1: Extract the variable `price` (as a vector):
  ## 2 ways: by name ($ vs. [[]])
  diamonds$price
  diamonds[["price"]]  
  
  ##         by position ([[]]):
  diamonds[[7]]
  
  
  all.equal(diamonds$price, diamonds[["price"]])
  all.equal(diamonds$price, diamonds[[7]])
  
  # Contrast this with: 
  diamonds %>% select(price) # returns a tibble
  
  ## Task 2: How many diamonds with a price over $10k?  What is their mean price?
  
  
  
  ## (2) Cases (rows): ---- 
  
  ## Task 1: By line numbers: Use only rows 1000 to 1100. 
  
  ## (a) subsetting matrices by indices:
  diamonds[1000:1100, ]
  
  ## (b) By adding an indexing variable and then filter:
  
  # Add indexing variable:
  diamonds %>%
    mutate(line = 1:nrow(diamonds)) %>%
    filter(line >= 1000, line <= 1100)
  
  # See also: 
  # add_rownames(diamonds)
  # rownames_to_column(diamonds)
  
  # Task 2: By conditions: Use only diamonds with a price over $10k.
  #         Plot their price as a function of carat. 
  
  
  
  diamonds %>%
    filter(price > 10000) %>%
    ggplot(aes(x = carat, y = price)) + 
    # facet_wrap(~cut) +
    geom_point(alpha = 1/3) +
    # geom_hex() +
    theme_bw()
  
}


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




## 10.5 Exercises ------

# 1. How can you tell if an object is a tibble? (Hint: try printing mtcars,
#    which is a regular data frame).

# printing tibble:
df %>% 
 print(n = 2, width = Inf)

# printing data frame:
head(mtcars)

mtcars # prints entire data frame, but no additional info (type of variable, dimensions etc.)

# contrast with:
print(as_tibble(mtcars))


# 2. Compare and contrast the following operations on a 
#    data.frame and equivalent tibble. 
#    What is different? 
#    Why might the default data frame behaviours cause you frustration?
  
df <- data.frame(abc = 1, xyz = "a")
df

tb <- as_tibble(df)
tb  

df$x  # partial matching of variable name?
tb$x  # NULL + warning: unknonwn column

df[, "xyz"]  # a and "Levels: a"
tb[, "xyz"]  # a and <fctr>

df[, c("abc", "xyz")]  # returns df
tb[, c("abc", "xyz")]  # returns tb + meta info (size, type)


# 3. If you have the name of a variable stored in an object (e.g., var <- "mpg"),
#    how can you extract the reference variable from a tibble?

mpg
var <- mpg

# Extracting the values of the "model" variable: 
var$model
var[ , 2]
var %>% .$model

# Extracing the name of the "model" variable:
names(var)[2]


# 4. Practice referring to non-syntactic names in the following data frame by:
#    a. Extracting the variable called 1.
#    b. Plotting a scatterplot of 1 vs 2.
#    c. Creating a new column called 3 which is 2 divided by 1.
#    d. Renaming the columns to one, two and three.

annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)

annoying

annoying$`1`                                    # a.
ggplot(annoying, aes(`1`, `2`)) + geom_point()  # b.
annoying$`3` <- annoying$`2`/annoying$`1`       # c. 
names(annoying) <- c("one", "two", "three")     # d. 

annoying

# 5. What does tibble::enframe() do? 
#    When might you use it?

?enframe


# Description: 

# enframe() converts named atomic vectors or lists to two-column data frames.
# For unnamed vectors, the natural sequence is used as name column.

# deframe() converts two-column data frames to a named vector or list, 
# using the first column as name and the second column as value.

# Example: 

# Create a named vector describing German flag:
de <- c("black", "red", "gold")
names(de) <- c("top", "mid", "bot")
de

# Enframe:
flag <- enframe(de)
flag

# Note: 
as_tibble(de) # does not work!

# Deframe: 
deframe(flag)

# [test.quest]: Create a tibble from a named vector.


# 6. What option controls how many additional column names are printed at the
#    footer of a tibble?

?print.tbl

# n_extra:

# - Number of extra columns to print abbreviated information for, 
#   if the width is too small for the entire tibble. 
# If NULL, the default, will print information about 
#    at most tibble.max_extra_cols extra columns.

print(x = nycflights13::flights, n = 5, width = 75, n_extra = 2)


## +++ here now +++ ------


## Appendix ------

# If this chapter leaves you wanting to learn more about tibbles, 
# 
# - study `vignette("tibble")` and the documentation for `?tibble`;
# - study <https://tibble.tidyverse.org/> and its examples; 

## ------
## eof.