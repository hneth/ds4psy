## r4ds: Chapters 2, 4, 6, 8:  
## Code for workflow chapters of http://r4ds.had.co.nz/ 
## hn spds uni.kn
## 2018 04 18 ------


## Chapter 2: Introduction -------

# Read http://r4ds.had.co.nz/explore-intro.html 
# Ok. 


## Chapter 4: Workflow: basics -------

# See http://r4ds.had.co.nz/workflow-basics.html

## 4.1 Coding basics -----

1 / 200 * 30 + 1 
#> [1] 1.15

(59 + 73 + 2) / 3
#> [1] 44.66667

sin(pi / 2)
#> [1] 1

## Creating objects by assignment: -----

# All R statements where you create objects, assignment statements, 
# have the same form:
#   object_name <- value
# When reading that code say “object name gets value” in your head.

# Examples of creating new objects: 
x <- 3 * 4
y <- 8 - 5

x      # => 12
y      # =>  3
x * y  # => 36

## 4.2 What’s in a name? -----

# Let's use descriptive variable names in snake_case to name new objects:
sum_x_y <- (x + y)

r_power <- 2 ^ 3

# Distinguish between: 
r_power     # => 8
# R_powder  # => ERROR: object not found
# R_power   # => ERROR (as R is case-sensitive)


## 4.3 Calling functions -----

# R has a large collection of built-in functions that are called like this:
# function_name(arg1 = val1, arg2 = val2, ...)

## Examples:

seq(1, 10)  # is short for: 
seq(from = 1, to = 10)

# Note: 
?seq  # shows help page for function seq()

y <- seq(1, 10, length.out = 5)
y

# Note: 
# Contents of y (and other objects) are shown in Environment pane of RStudio.


## 4.4 Practice ------

# 1. Why does this code not work?
  
my_variable <- 10
# my_varıable  # commented out as yielding ERROR

# Answer: The letter "i" is spelled differently (as "ı", i.e., without dot).
#         Thus, the dot-less object is not found by R.

# 2. Tweak each of the following R commands so that they run correctly:
library(tidyverse) # works, but should probably be
library('tidyverse')

# ad (a): 
# ggplot(dota = mpg) +  # commented out as yielding ERROR
#   geom_point(mapping = aes(x = displ, y = hwy))

# Error: ... argument "data" is missing, with no default
# => Change "dota" into "data": 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# ad (b): 
# fliter(mpg, cyl = 8)   # Error: could not find function "fliter"
# => Change "fliter" into "filter": 
# filter(mpg, cyl = 8)   # Error: `cyl` (`cyl = 8`) must not be named, do you need `==`? 
# => Change "=" into "==": 
filter(mpg, cyl == 8)  # works!

# ad (c)
# filter(diamond, carat > 3)   # Error in filter(diamond, carat > 3) : object 'diamond' not found.
# Start typing 
# ?diam... completes into "diamonds":
filter(diamonds, carat > 3)  # works!

# 3. Press Alt + Shift + K. 

# What happens? 
# Answer: We see a list of keyboard shortcuts of RStudio.

# How can you get to the same place using the menus?
# via Help > Keyboard Shortcuts Help 



## Chapter 6: Workflow: scripts -------

# See http://r4ds.had.co.nz/workflow-scripts.html

# RStudio IDE: Distinguish between different panels/windows: 
# - Editor (for scripts)
# - Console (for evaluation results)
# - Output (e.g., plots)
# - Environment (History, Files, Packages, Help, etc.)

## 6.1 Running code -----

# Place cursor and run code via Cmd/Ctrl + Enter:

# load packages: 
library(dplyr)
library(nycflights13)

# Run code 1:
not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

# Run code 2:
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))

# Observe how cursor iteratively jumps to the next code block... 

## 6.2 RStudio diagnostics ------

# RStudio detects errors and potential problems: 

# The script editor will also highlight syntax errors with a red squiggly line
# and a cross in the sidebar:

# x y <- 10  # (commented out to allow running script)

# Hover over the cross or red line to see what the problem is.
# RStudio will also lets us know about potential problems:

# 3 == NA  # (commented out to allow running script)


## 6.3 Practice -----

# 1. Go to the RStudio Tips twitter account, 
# https://twitter.com/rstudiotips 
# and find one tip that looks interesting. 
# Practice using it! Ok... 
  
# 2. What other common mistakes will RStudio diagnostics report? 
# Read https://support.rstudio.com/hc/en-us/articles/205753617-Code-Diagnostics 
# to find out.  Ok...



## Chapter 8: Workflow: projects ------ 

# See http://r4ds.had.co.nz/workflow-projects.html

## 8.1 What is real? ------

# Basic message: 
# - The basic units of reproducible research are: data + R script 
# - Do not rely on saving the current environment, but rather 
#   re-create the environment from R scripts (stored as .R or .Rmd files).
# - 


# Keyboard shortcuts 
# to check whether everything relevant is part of the current script:

# 1. Press Cmd/Ctrl + Shift + F10 to restart RStudio.
# 2. Press Cmd/Ctrl + Shift + S to rerun (aka. "source") the current script.

## 8.2 Where does your analysis live? ------ 

# Answer: in your working directory: 
getwd()

# Note: Every project (e.g., a course) 
#       should have its own directory (and RStudio project). 


## 8.3 Paths and directories -------

# - forward slashes on Mac: ./data/
# - backslashes on Windows: .\data\

# - Use relative paths 
#   (i.e., relative to current working directory).


## 8.4 RStudio projects ------

# To get organized for this course: 
# - create a "r4ds" or "ds4psy" directory and project (see ".Rproj" file)
# - create a subdirectory "R" for R scripts.
# - create a subdirectory "data" for data files.


## 8.5 Summary ------

# In summary, RStudio projects give you a solid workflow 
# that will serve you well in the future:
  
# 1. Create an RStudio project for each data analysis project 
#    (e.g., this course).
 
# 2. Keep data files in "data" directory; 
#    we’ll talk about loading them into R in data import.
 
# 3. Keep R scripts in an "R" directory; 
#    edit them, run them in bits or as a whole.
 
# 4. Save your outputs (plots and cleaned data) there 
#    or in a subdirectory.
 
# 5. Only ever use relative paths, not absolute paths.

# Everything you need is in one place, and cleanly separated 
# from all the other projects that you are working on.



# +++ here now +++ ------ 

## ------
## eof.