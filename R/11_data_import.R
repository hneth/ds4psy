## r4ds: Chapter 11: Data import  
## Code for http://r4ds.had.co.nz/data-import.html 
## hn spds uni.kn
## 2018 03 24 ------


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
dep <- read_csv("../data/Depression.csv") # copied version (in "data" subdirectory)
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

# If there are many parsing failures, you’ll need to use 
# problems() 
# to get the complete set. This returns a 
# tibble, which you can manipulate with dplyr: 

problems(x)

# Using parsers is mostly a matter of understanding what’s available and how
# they deal with different types of input. 

# There are 8 important parsers:
   
# 1. parse_logical() and 
# 2. parse_integer() parse logicals and integers. 
# 
# 3. parse_double() is a strict numeric parser, and 
# 4. parse_number() is a flexible numeric parser. 
#    These are more complicated than you might expect because 
#     different parts of the world write numbers in different ways.
# 
# 5. parse_character() seems so simple that it shouldn’t be necessary. 
#    But one complication makes it quite important: character encodings.
# 
# 6. parse_factor() create factors, the data structure that R uses 
#    to represent categorical variables with fixed and known values.
# 
# 7. parse_datetime(), 
# 8. parse_date(), and 
# 9. parse_time() allow you to parse various date & time specifications. 
#    These are the most complicated because there are so many different ways of writing dates.


## 11.3.1 Numbers -----

parse_double("1.23")

## (1) Local decimal marks: ---- 

# People write numbers differently in different parts of the world. 
# For example, while the U.S. use "." in between the integer and fractional parts of a real number, 
# many European countries use ",".

# readr has the notion of a “locale”, an object that specifies parsing options
# that differ from place to place. When parsing numbers, the most important
# option is the character you use for the decimal mark. You can override the
# default value of "." by creating a new locale and setting the decimal_mark
# argument:

parse_double("1,23", locale = locale(decimal_mark = ","))

## (2) Context (pre- and postfix: units and percentages): ----

# parse_number() ignores non-numeric characters before and after the number.
# This is particularly useful for currencies and percentages, but also works to
# extract numbers embedded in text:

parse_number("$100")
parse_number("20%")
parse_number("It cost $123.45 for the entire box!")

# Note: only 1st number extracted: 
parse_number("It cost $123.45 for the entire box, not $12.45!") 


## (3) Local grouping marks: ----

# The combination of parse_number() and the locale as parse_number() 
# will ignore the “grouping mark”:

parse_number("$123,456,789")  # U.S.: "," as grouping mark (default) 
parse_number("EUR123.456.789", locale = locale(grouping_mark = ".")) # Many European countries
parse_number("FR123'456'789", locale = locale(grouping_mark = "'"))  # The Swiss are crazy!

# Note rounding:
parse_number("$123,456,789.49")  # rounds down
parse_number("$123,456,789.50")  # rounds up


## 11.3.2 Strings ----- 

# It seems like parse_character() should be really simple — it could just return
# its input. Unfortunately life isn’t so simple, as there are multiple ways to
# represent the same string. 
# In R, we can get at the underlying representation of a string using charToRaw():

charToRaw("Hans")
charToRaw("hans")

# The mapping from hexadecimal number to character is called the encoding, 
# and in this case the encoding is called ASCII. 

# Fortunately, today there is one standard that is supported almost everywhere: UTF-8. 
# UTF-8 can encode just about every character used by humans today, 
# as well as many extra symbols (like emoji!).

# readr uses UTF-8 everywhere: it assumes your data is UTF-8 encoded when you read it, 
# and always uses it when writing. 
# This is a good default, but will fail for data produced by older systems 
# that don’t understand UTF-8.

x1 <- "El Ni\xf1o was particularly bad this year"
x2 <- "\x82\xb1\x82\xf1\x82\xc9\x82\xbf\x82\xcd"

x1
x2

# To fix the problem you need to specify the encoding in parse_character():

parse_character(x1, locale = locale(encoding = "Latin1"))
parse_character(x2, locale = locale(encoding = "Shift-JIS"))

# How do you find the correct encoding? If you’re lucky, it’ll be included
# somewhere in the data documentation. Unfortunately, that’s rarely the case, so
# readr provides guess_encoding() to help you figure it out. It’s not foolproof,
# and it works better when you have lots of text (unlike here), but it’s a
# reasonable place to start. 
# Expect to try a few different encodings before you find the right one.

guess_encoding(charToRaw(x1))
guess_encoding(charToRaw(x2))

# The first argument to guess_encoding() can either be a path to a file, or, 
# as in this case, a raw vector (useful if the strings are already in R).

# Encodings are a rich and complex topic. To learn more see 
# http://kunststube.net/encoding/. 

## 11.3.3 Factors -----

# R uses factors to represent categorical variables that have 
# a known set of possible values. 

# parse_factor() needs a vector of known levels to generate a warning 
# whenever an unexpected value is present:
  
fruit <- c("apple", "banana")  # define levels
parse_factor(c("apple", "banana", "bananana"), levels = fruit)

# if you have many problematic entries, it’s often easier to leave as character vectors 
# and then use the tools you’ll learn about in strings and factors to clean them up:
# Ch. 14: http://r4ds.had.co.nz/strings.html
# Ch. 20: http://r4ds.had.co.nz/vectors.html#factors-1 


## 11.3.4 Dates, date-times, and times -----

# 3 parsers distinguish between 

# 1. date (the number of days since 1970-01-01), 
# 2. date-time (the number of seconds since midnight 1970-01-01), or a 
# 3. time (the number of seconds since midnight). 

# When called without any additional arguments:

# 1. parse_datetime() expects an ISO8601 date-time.
#    This is the most important date/time standard. 
#    If you work with dates and times frequently, see https://en.wikipedia.org/wiki/ISO_8601.

parse_datetime("2010-12-24T2010")
parse_datetime("20101224") # omitting time, sets it to midnight

# 2. parse_date() expects a four digit year, a "-" or "/", the month, a "-" or "/", then the day:

parse_date("2010-12-24")
parse_date("2010/12/24")
parse_date("2010/12-24")
parse_date("2010-12/24")
parse_date("2010-12_24")

# 3. parse_time() expects the hour, ":", minutes, optionally ":" and seconds, 
#    and an optional am/pm specifier:

# Base R doesn’t have a great built in class for time data, 
# so we use the one provided in the hms package: 
library(hms)

parse_time("01:10 am")
parse_time("20:10:01")

# If these defaults don’t work for your data you can supply your own date-time
# format, built up of the following pieces:

# Year:

# %Y (4 digits). 
# %y (2 digits); 00-69 -> 2000-2069, 70-99 -> 1970-1999. 

# Month:

# %m (2 digits). 
# %b (abbreviated name, like “Jan”). 
# %B (full name, “January”). 

# Day:

# %d (2 digits). 
# %e (optional leading space). 

# Time:

# %H 0-23 hour. 
# %I 0-12, must be used with %p. 
# %p AM/PM indicator. 
# %M minutes. 
# %S integer seconds. 
# %OS real seconds. 
# %Z Time zone (as name, e.g. America/Chicago). Beware of abbreviations: if you’re American, note that “EST” is a Canadian time zone that does not have daylight savings time. It is not Eastern Standard Time! We’ll come back to this time zones. 
# %z (as offset from UTC, e.g. +0800). 

# Non-digits:

# %. skips one non-digit character. 
# %* skips any number of non-digits. 

## Examples: 

parse_date("01/02/15", "%m/%d/%y")
parse_date("01/02/15", "%d/%m/%y")
parse_date("01/02/15", "%y/%m/%d")


# If you’re using %b or %B with non-English month names, 
# set the lang argument to locale(). 
# See the list of built-in languages in date_names_langs().   
# If your language is not included, create your own with date_names().

date_names_langs()

parse_date("1 janvier 2015", "%d %B %Y", locale = locale("fr"))
parse_date("1. Juli 1975", "%d %. %B %Y", locale = locale("de"))

# [test.quest]:
{
# Take your ID card and type your birthday as a string exactly as it's written on the card:
#
# For instance, if you were Erika Mustermann https://de.wikipedia.org/wiki/Personalausweis_(Deutschland) 
# you would write the string "12.08.1964"

# a) Use a command to parse this into R 
# b) Now read out the date in German (i.e., "12. August 1964") 
#    and use a command parse this string into R

parse_date("12.08.1964", "%d.%m.%Y")
parse_date("12. August 1964", "%d. %B %Y", locale = locale("de"))
}


## 11.3.5 Exercises -----

# 1. What are the most important arguments to locale()?

?locale

# Usage

# locale(date_names = "en", date_format = "%AD", time_format = "%AT",
#        decimal_mark = ".", grouping_mark = ",", tz = "UTC",
#        encoding = "UTF-8", asciify = FALSE)


# 2. a. What happens if you try and set decimal_mark and grouping_mark to the same
#       character? 
#    b. What happens to the default value of grouping_mark when you set
#       decimal_mark to “,”? 
#    c. What happens to the default value of decimal_mark when
#       you set the grouping_mark to “.”?

# ad (a):
parse_number("EUR123.456.789", locale = locale(grouping_mark = "."))
parse_number("EUR123.456.789", locale = locale(decimal_mark = ".", grouping_mark = "."))
# => Error: `decimal_mark` and `grouping_mark` must be different

# ad (b):
parse_number("EUR123.456.789") # first "." is viewed as decimal mark
parse_number("EUR123.456.789", locale = locale(decimal_mark = ","))  # "." is interpreted as grouping mark!

# ad (c):
parse_number("EUR123.456,789") # first "." is viewed as decimal mark
parse_number("EUR123.456,789", locale = locale(grouping_mark = ".")) # "," is interpreted as decimal mark!

# [test.quest]:
# Parse the same amount in US$ and EUR (in the respective notation of each country):
parse_number("US$1,099.95") 
parse_number("EUR1.099,95", locale = locale(grouping_mark = "."))


# 3. I didn’t discuss the date_format and time_format options to locale(). 
#    What do they do? Construct an example that shows when they might be useful.

?locale
?date_format
?time_format # no documentation!
Sys.timezone()

parse_datetime("2017-03-23 16:23:59", locale = locale(date_format = "%Y-%m-%d", tz = "UTC"))


# 4. If you live outside the US, create a new locale object that encapsulates
#    the settings for the types of file you read most commonly.

format(Sys.time(), "%a %b %d %X %Y %Z")
format(Sys.time(), "%A %B %D %X %Y %Z")

de_locale <- locale(date_names = "de", date_format = "%AD", time_format = "%AT",
                    decimal_mark = ",", grouping_mark = ".", tz = "CET",
                    encoding = "UTF-8", asciify = FALSE)

format(Sys.time(), locale = de_locale)
parse_date(Sys.Date(), locale = de_locale)
parse_number("1.010,99", locale = de_locale)

# See also 
# http://r4ds.had.co.nz/dates-and-times.html#time-zones
# for time zones.

Sys.timezone() # shows current time zone
OlsonNames()   # lists all time zones


# 5. What’s the difference between read_csv() and read_csv2()?

?read_csv2()

# read_csv() and read_tsv() are special cases of the general read_delim().
# They're useful for reading the most common types of flat file data, comma
# separated values and tab separated values, respectively.

# read_csv2() uses ";" for separators, instead of ",". 
# This is common in European countries which use , as the decimal separator.


# 6. What are the most common encodings used in Europe? 
#    What are the most common encodings used in Asia? 
#    Do some googling to find out.

# See 
# http://kunststube.net/encoding/ 
# https://en.wikipedia.org/wiki/Character_encoding 
# https://stackoverflow.com/questions/8509339/what-is-the-most-common-encoding-of-each-language 


# 7. Generate the correct format string to parse each of the following dates and times:
  
d1 <- "January 1, 2010"
d2 <- "2015-Mar-07"
d3 <- "06-Jun-2017"
d4 <- c("August 19 (2015)", "July 1 (2015)")
d5 <- "12/30/14" # Dec 30, 2014

t1 <- "1705"
t2 <- "11:15:10.12 PM"

parse_date(d1, "%B %d, %Y")
parse_date(d2, "%Y-%b-%d")
parse_date(d3, "%d-%b-%Y")
parse_date(d4, "%B %d (%Y)")
parse_date(d5, "%m/%d/%y")

parse_time(t1, "%H%M")
parse_time(t2, "%H:%M:%OS %p")


## 11.4 Parsing a file ------

# Now that we can parse an individual vector, 
# we can understand how readr parses a file. 

# This involves 2 points:
# 1. How readr automatically guesses the type of each column.
# 2. How to override the default specification.

## 11.4.1 Strategy -----

# readr uses a heuristic to figure out the type of each column: 
# it reads the first 1000 rows and uses some (moderately conservative) 
# heuristics to figure out the type of each column. 

# To emulate this process with a character vector:  
# - guess_parser() returns readr’s best guess, and
# - parse_guess() uses that guess to parse a column:

guess_parser("2010-10-01")
guess_parser("15:01")
guess_parser(c("TRUE", "FALSE"))
guess_parser(c("1", "5", "9"))
guess_parser(c("12,352,561"))

parse_guess("2010-10-10")
str(parse_guess("2010-10-10"))

## 11.4.2 Problems -----

# These defaults don’t always work for larger files. 
# There are 2basic problems:
  
# 1. The first thousand rows might be a special case, and readr guesses a type
#    that is not sufficiently general. For example, you might have a column of
#    doubles that only contains integers in the first 1000 rows.

# 2. The column might contain a lot of missing values. 
#    If the first 1000 rows contain only NAs, readr will guess that it’s a character vector, 
#    whereas you probably want to parse it as something more specific.

# readr contains a challenging CSV that illustrates both of these problems:

challenge <- read_csv(readr_example("challenge.csv"))

# (Note the use of readr_example() which finds the path 
#  to one of the files included with the package.)

# It’s always a good idea to explicitly pull out the problems()  
# to explore them in more depth:

problems(challenge)

# A good strategy is to work column by column until there are no problems remaining. 

# Here we can see that there are a lot of parsing problems with the x column 
# - there are trailing characters after the integer value. 
# That suggests we need to use a double parser instead.

# To fix the call, start by copying and pasting the column specification 
# into your original call:

challenge <- read_csv(
  readr_example("challenge.csv"), 
  col_types = cols(
    x = col_integer(),
    y = col_character()
  )
)

# NOW we can tweak the type of the x column:

challenge <- read_csv(
  readr_example("challenge.csv"), 
  col_types = cols(
    x = col_double(),
    y = col_character()
  )
)

challenge
problems(challenge)

# That fixed the first problem, but when looking at the last few rows, 
# we see dates stored in a character vector:

tail(challenge)

# We fix this by specifying that y is a date column:
  
challenge <- read_csv(
    readr_example("challenge.csv"), 
    col_types = cols(
      x = col_double(),
      y = col_date()
    )
  )

tail(challenge)

# Every parse_xyz() function has a corresponding col_xyz() function. 
# - use parse_xyz() when the data already is a character vector in R; 
# - use col_xyz() when we want to tell readr how to load the data.

# I highly recommend always supplying col_types, 
# building up from the print-out provided by readr. 
# This ensures a consistent and reproducible data import script. 

# If you rely on the default guesses and your data changes, 
# readr will continue to read it in. 

# If you want to be really strict, use stop_for_problems(): 
# that will throw an error and stop your script if there are any parsing problems.


## 11.4.3 Other strategies -----

# There are a few other general strategies to help you parse files:
  
## (1) Increasing guess_max:

# In the previous example, we just got unlucky: 
# if we look at just one more row than the default of 1000, 
# we can correctly parse in one shot:
  
challenge2 <- read_csv(readr_example("challenge.csv"), guess_max = 1001)

tail(challenge2)

## (2) Reading as character vectors:

# Sometimes it’s easier to diagnose problems if you just 
# read in all the columns as character vectors:
  
challenge2 <- read_csv(readr_example("challenge.csv"), 
                       col_types = cols(.default = col_character())
                       )

# This is particularly useful in conjunction with type_convert(), 
# which applies the parsing heuristics to the character columns in a data frame:

df <- tribble(
  ~x,  ~y,
  "1", "1.21",
  "2", "2.32",
  "3", "4.56"
)

df  # => 2 character vectors

type_convert(df)  # => applies parsing heuristics to df


## (3) Further tips: 

# - If you’re reading a very large file, 
#   set n_max to a smallish number like 10,000 or 100,000. 
#   This accelerates iterations while eliminating common problems.

# - If you’re having major parsing problems, 
#   sometimes it’s easier to just read into a character vector of lines with read_lines(), 
#   or even a character vector of length 1 with read_file(). 
#   Then you can use the string parsing skills you’ll learn later to parse more exotic formats.


## 11.5 Writing to a file ------

# readr also comes with two useful functions for writing data to disk: 
# - write_csv() and 
# - write_tsv(). 

# Both functions increase the chances of the output file being read back in by:
# 1. Always encoding strings in UTF-8.
# 2. Saving dates and date-times in ISO8601 format 
#    so they are easily parsed elsewhere.

# If you want to export a csv file to Excel, use 
# write_excel_csv() — this writes a special character (a “byte order mark”) 
# at the start of the file which tells Excel that you’re using the UTF-8 encoding.

# The most important arguments are 
# - x (the data frame to save), and 
# - path (the location to save it). You can also specify 
# - how missing values are written with na, and 
# - if you want to append to an existing file.

## See 
?write_csv

## Note that the type information is lost when you save to csv:

challenge  # tibble with <dbl> and <date>

write_csv(challenge, "data/challenge-2.csv")
read_csv("data/challenge-2.csv")

# This makes CSVs a little unreliable for caching interim results
# -— we need to recreate column specifications every time we load data. 

# There are 2 alternatives:

# 1. Using RDS format:
# - write_rds() and 
# - read_rds() 
# are uniform wrappers around the base functions readRDS() and saveRDS(). 

# These store data in R’s custom binary format called RDS:

write_rds(challenge, "data/challenge.rds")
read_rds("data/challenge.rds")

# 2. The feather package implements a fast binary file format 
# that can be shared across programming languages:

# install.packages('feather')
library(feather)

write_feather(challenge, "data/challenge.feather")
read_feather("data/challenge.feather")

## Advantages of using RDS vs. feather:
# - Feather tends to be faster than RDS and is usable outside of R. 
# - RDS supports list-columns (which you’ll learn about in many models); 
#   feather currently does not.


## 11.6 Other types of data ------

# To get other types of data into R, we recommend 
# starting with the tidyverse packages listed below. 
# They’re certainly not perfect, but they are a good place to start. 

# (1) For rectangular data:
  
# - haven reads SPSS, Stata, and SAS files.
# - readxl reads excel files (both .xls and .xlsx).
# - DBI, along with a database specific backend (e.g. RMySQL, RSQLite, RPostgreSQL etc) 
#   allows you to run SQL queries against a database and return a data frame.

# (2) For hierarchical data: 
# - use jsonlite (by Jeroen Ooms) for json, and 
# - xml2 for XML. Jenny Bryan has some excellent worked examples at 
#   https://jennybc.github.io/purrr-tutorial/.

# (3) For other file types, try 
# - the R data import/export manual at https://cran.r-project.org/doc/manuals/r-release/R-data.html and  
# - the rio package.


## +++ here now +++ ------

## Appendix ------

# See 
vignette("readr")

# On language or region-specific encodings see 
# http://kunststube.net/encoding/ 
# https://en.wikipedia.org/wiki/Character_encoding 
# https://stackoverflow.com/questions/8509339/what-is-the-most-common-encoding-of-each-language 

# The R data import/export manual at https://cran.r-project.org/doc/manuals/r-release/R-data.html

## ------
## eof.