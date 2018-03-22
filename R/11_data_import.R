## r4ds: Chapter 11: Data import  
## Code for http://r4ds.had.co.nz/data-import.html 
## hn spds uni.kn
## 2018 03 22 ------


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

# In both cases above, read_csv() uses the 1st line of data 
# for detecting column names, which is a very common convention. 

# There are 2 cases where you might want to tweak this behavior:

# Sometimes there are a few lines of metadata at the top of the file. 
# You can use skip = n to skip the first n lines; 
# or use comment = "#" to drop all lines that start with (e.g., "#"):

read_csv("The first line of metadata
      The second line of metadata 
      x,y,z
      1,2,3", skip = 2) 

read_csv("# A comment I want to skip
  x,y,z
  1,2,3", comment = "#") 

# The data might not have column names. 
# You can use col_names = FALSE to tell read_csv() 
# not to treat the first row as headings, and 
# instead label them sequentially from X1 to Xn:

read_csv("1,2,3\n4,5,6", 
         col_names = FALSE)

# ("\n" is a convenient shortcut for adding a new line. 
# You’ll learn more about it and other types of string escape in 
# string basics: http://r4ds.had.co.nz/strings.html#string-basics )

# Alternatively you can pass col_names a character vector 
# which will be used as the column names:
  
read_csv("1,2,3\n4,5,6", 
         col_names = c("x", "y", "z"))

# Another option that commonly needs tweaking is NA: 
# This specifies the value (or values) that are used 
# to represent missing values in your file:
  
read_csv("a,b,c\n1,2,.", 
         na = ".")

# This is all you need to know to read ~75% of CSV files that 
# you’ll encounter in practice. 

# You can also easily adapt what you’ve learned to read 
# - tab separated files with read_tsv() and 
# - fixed width files with read_fwf(). 

# To read in more challenging files, you’ll need to learn more 
# about how readr parses each column, turning them into R vectors.

## 11.2.1 Compared to base R ------

# If you’ve used R before, you might wonder why we’re not using read.csv().
# There are a few good reasons to favour readr functions over the base
# equivalents:
  
# 1. They are typically much faster (~10x) than their base equivalents. 
#    Long running jobs have a progress bar, so you can see what’s happening. 
#    If you’re looking for raw speed, try data.table::fread(). 
#    It doesn’t fit quite so well into the tidyverse, but it can be quite a bit faster.

# 2. They produce tibbles, they don’t convert character vectors to factors, 
#    use row names, or munge the column names. 
#    These are common sources of frustration with the base R functions.

# 3. They are more reproducible. 
#    Base R functions inherit some behaviour from your operating system and 
#    environment variables, so import code that works on your computer 
#    might not work on someone else’s.


## 11.2.2 Exercises ------

# 1. What function would you use to read a file where fields were separated with “|”?

?read_delim

read_delim("a|b\n1.0|2.0", delim = "|")

# 2. Apart from file, skip, and comment, what other arguments do read_csv() and read_tsv() have in common?

?read_csv # see lists of arguments in Usage and Arguments


# 3. What are the most important arguments to read_fwf()?

?read_fwf

fwf_sample <- readr_example("fwf-sample.txt")
cat(read_lines(fwf_sample))

# You can specify column positions in several ways:

# a. Guess based on position of empty columns
read_fwf(fwf_sample, fwf_empty(fwf_sample, col_names = c("first", "last", "state", "ssn")))

# b. A vector of field widths
read_fwf(fwf_sample, fwf_widths(c(20, 10, 12), c("name", "state", "ssn")))

# c. Paired vectors of start and end positions
read_fwf(fwf_sample, fwf_positions(c(1, 30), c(10, 42), c("name", "ssn")))

# d. Named arguments with start and end positions
read_fwf(fwf_sample, fwf_cols(name = c(1, 10), ssn = c(30, 42)))

# e. Named arguments with column widths
read_fwf(fwf_sample, fwf_cols(name = 20, state = 10, ssn = 12))


# 4. Sometimes strings in a CSV file contain commas. 
#    To prevent them from causing problems they need to be 
#    surrounded by a quoting character, like " or '. 
#    By convention, read_csv() assumes that the quoting character will be ", 
#    and if you want to change it you’ll need to use read_delim() instead. 
#    What arguments do you need to specify to read the following text into a data frame?
   
"x,y\n1,'a,b'"

read_csv("x,y\n1,'a,b'", quote = "'")   
   

# 5. Identify what is wrong with each of the following inline CSV files. 
#    What happens when you run the code?
  
read_csv("a,b\n1,2,3\n4,5,6")    # yields 2 x 2 tibble and Warning: 2 parsing failures 
read_csv("a,b,c\n1,2,3\n4,5,6")  # corrected to 3 variables (columns)

read_csv("a,b,c\n1,2\n1,2,3,4")  # yields 2 x 3 tibble (with NA) and Warning: 2 parsing failures 
read_csv("a,b,c\n1,2,3\n1,2,4")  # a plausible correction

read_csv("a,b\n\"1")  # yields 1 x 2 tibble (with NA) and Warning: 2 parsing failures 
read_csv("a,b\n1,2") 

read_csv("a,b\n1,2\na,b")  # yields 2x2 tibble of characters!
read_csv("a,b\n1,2\n3,4")  # yields 2x2 tibble of integers

read_csv("a;b\n1;3")                 # yields 1x1 tibble (due to ;)
read_delim("a;b\n1;3", delim = ";")  # yields1 x 2 tibble


## 11.3 Parsing a vector ------

# Before we get into the details of how readr reads files from disk, 
# we need to talk about the parse_*() functions. 

# These functions take a character vector and return a more specialised vector 
# like a logical, integer, or date:
  
str(parse_logical(c("TRUE", "FALSE", "NA")))

str(parse_integer(c("1", "2", "3")))

str(parse_date(c("2010-01-01", "1979-10-14")))

# These functions are useful in their own right, 
# but are also an important building block for readr.

# Like all functions in the tidyverse, 
# the parse_*() functions are uniform: 
# - the first argument is a character vector to parse, and 
# - the na argument specifies which strings should be treated as missing:

parse_integer(c("1", "231", ".", "456"), na = ".")

# If parsing fails, you’ll get a warning:
  
x <- parse_integer(c("123", "345", "abc", "123.45"))

# and the failures will be missing in the output:

x

# If there are many parsing failures, 
# you’ll need to use problems() to get the complete set. 
# This returns a tibble, which you can then manipulate with dplyr: 

problems(x)



## +++ here now +++ ------



## Appendix ------

vignette("readr")

## ------
## eof.