## r4ds: Chapter 11: Data import  
## Code for http://r4ds.had.co.nz/data-import.html 
## hn spds uni.kn
## 2018 03 20 ------

## 11.1 Introduction ------

# Working with data provided by R packages is a great way to learn 
# the tools of data science, but at some point you want to stop learning 
# and start working with your own data. 

# This chapter shows how to read plain-text rectangular files into R. 
# It only scratches the surface of data import, but many of the principles
# will translate to other forms of data.
# Below are some pointers to packages that are useful for other types of data.

# This chapter addresses the readr package, which is part of the core tidyverse:

library(tidyverse)

# See also vignette("readr")


## 11.2 Getting started ------

# Most of readr’s functions are concerned with turning flat files into data frames:

# 1. read_csv() reads comma delimited files, 
#    read_csv2() reads semicolon separated files (common in countries where , is used as the decimal place),
#    read_tsv() reads tab delimited files, and 
#    read_delim() reads in files with any delimiter.

# 2. read_fwf() reads fixed width files. You can specify fields either by their
#               widths with fwf_widths() or their position with fwf_positions(). 
#    read_table() reads a common variation of fixed width files where columns are separated by
#                 white space.

# 3. read_log() reads Apache style log files. 
#    (But also check out webreadr which is built on top of 
#     read_log() and provides many more helpful tools.)

# These functions all have similar syntax: once you’ve mastered one, you can use
# the others. 

# For the rest of this chapter we’ll focus on read_csv().
# Not only are csv files one of the most common forms of data storage, but once
# you understand read_csv(), you can easily apply your knowledge to all the
# other functions in readr.

## (1) Reading an existing file:

# The first argument to read_csv() is the most important: 
# the path to the file to read:

dep <- read_csv("data/_FieldEtAl12_DiscoveringStatisticsUsingR/data/Depression.csv")
dep <- read_csv("data/Depression.csv") # copied version (in "data" subdirectory)
dep

# EDA: [test.quest]
{
  
## Distributions:

# Distributions before:
ggplot(dep, aes(x = treat, y = before, color = treat)) +
  geom_violin() + 
  geom_jitter(width = .1) +
  theme_light()
  
# Distributions after:
ggplot(dep, aes(x = treat, y = after, color = treat)) +
  geom_violin() + 
  geom_jitter(width = .1) +
  theme_light()

# Same with boxplots:
ggplot(dep, aes(x = treat, y = before, color = treat)) +
  geom_boxplot() +
  theme_light()

ggplot(dep, aes(x = treat, y = after, color = treat)) +
  geom_boxplot() +
  theme_light()

# Scatterplots faceted by treatments:
ggplot(dep, aes(x = before, y = after, color = treat)) +
  facet_wrap(~treat) + 
  geom_point() + 
  theme_light()

}

# read_csv() prints out a column specification with the name and type of each column. 
# That’s an important part of readr, which we’ll come back to in parsing a file.

## (2) Supplying an inline csv file:

# We can also supply an inline csv file. 
# This is useful for experimenting with readr 
# and for creating reproducible examples to share:
  
read_csv("a,b,c
          1,2,3
          4,5,6")




## +++ here now +++ ------


## Appendix ------

vignette("readr")

## ------
## eof.