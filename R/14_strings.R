## r4ds: Chapter 14: Strings
## Code for http://r4ds.had.co.nz/strings.html 
## hn spds uni.kn
## 2018 04 02 ------

## [see Book chapter 1x: "..."]

## Note: stringr is not part of the core tidyverse. 

## 14.1 Introduction ------

# This chapter introduces you to string manipulation in R:

# - how strings work and how to create them by hand

# - regular expressions, or regexps for short. 
#   strings usually contain unstructured or semi-structured data, 
#   and regexps are a concise language for describing patterns in strings. 
#   When you first look at a regexp, they look cryptic, but  
#   as your understanding improves they will soon start to make sense.

## 14.1.1 Prerequisites

# This chapter will focus on the stringr package for string manipulation. 
# stringr is not part of the core tidyverse because you don’t always have textual data, 
# so we need to load it explicitly:

library(tidyverse)
# install.packages('stringr') # also installs the (more powerful) stringi package
library(stringr)


## 14.2 String basics ------ 

# Strings can be created by double- "..." or single '...' quotes:

string1 <- "This is a string"
string2 <- 'If I want to include a "quote" inside a string, I use single quotes'

# To include a literal single or double quote in a string you can use \ to “escape” it:
  
double_quote <- "\"" # or '"'
single_quote <- '\'' # or "'"

# That means if you want to include a literal backslash, 
# you’ll need to double it up: "\\".

backslash <- "\\"
backslash

# Beware that the printed representation of a string is not the same as string itself, 
# because the printed representation shows the escapes. 

# To see the raw contents of the string, use writeLines():

writeLines(string2)
writeLines(double_quote)
writeLines(backslash)

?writeLines # is a base R function. 

# There are a handful of other special characters. 
# The most common are "\n", newline, and "\t", tab, 
# but you can see the complete list by requesting help on ": ?'"', or ?"'". 

?"'"

# You’ll also sometimes see strings like "\u00b5". 
# This is a way of writing non-English characters that works on all platforms:

x <- "\u00b5"
x
#> [1] "µ"

?Unicode

## Unicode for German Umlaute: -----

# Zeichen |	  Unicode
# --------|----------------------
# Ä, ä 		| \u00c4, \u00e4
# Ö, ö 		| \u00d6, \u00f6
# Ü, ü 		| \u00dc, \u00fc
# ß 		  | \u00df

name <- "Hansj\u00f6rg"
satz <- "Es w\u00e4re sch\u00f6n, ein bi\u00dfchen \u00dcberflu\u00df zu genie\u00dfen."

# Multiple strings are often stored in a character vector, which you can create with c():

c("one", "two", "three")
v <- c(double_quote, backslash, name, satz)
v
writeLines(v)


## 14.2.1 String length -----

# Base R contains many functions to work with strings 
# but we’ll avoid them because they can be inconsistent, 
# which makes them hard to remember. 

# Instead we’ll use functions from stringr. 
# These have more intuitive names, and all start with str_
# (try using the prefix in RStudio: str_ ...

# For example, str_length() tells you the number of characters in a string:
  
str_length(c("a", "R for data science", "R4DS", NA))
str_length(v)


## 14.2.2 Combining and collapsing strings -----

## (A) Combining ----

# str_c() combines 2 or more strings into 1:
  
str_c("x", "y")
str_c("x", "y", "z")
str_c(v)

str_c("x", "y", "z",  sep = ",")  # vs. 
str_c("x", "y", "z",  sep = ", ")

# Like most other functions in R, missing values are contagious. 
# If you want them to print as "NA", use str_replace_na():
  
x <- c("abc", NA)

str_c("|-", x, "-|")  # keeps NA at the end:
#> [1] "|-abc-|" NA

str_c("|-", str_replace_na(x), "-|")  # treats NA like a string
#> [1] "|-abc-|" "|-NA-|" 

# As shown above, str_c() is vectorised, 
# and it automatically recycles shorter vectors 
# to the same length as the longest:
  
str_c("prefix-", c("a", "b", "c"), "-suffix")

# Objects of length 0 are silently dropped. 
# This is particularly useful in conjunction with if: 
name <- "Hans"
time_of_day <- "morning"
birthday <- FALSE

mess <- str_c(
  "Good ", time_of_day, " ", name,
  if (birthday) " and HAPPY BIRTHDAY",
  "."
)
mess
#> [1] "Good morning Hans."

## (B) Collapsing ----

# To collapse a vector of strings into a single string, 
# use str_c with the collapse argument:
  
str_c(c("x", "y", "z"), collapse = ", ")
str_c(mess, collapse = ", ") 

{
  ## [test.quest]: str_c with collapse: 
  ## What result does str_c("This is a test", collapse = ", ") yield?
  
  # - [1] "This is a test"          (TRUE)
  # - [1] "This" "is" "a" "test"
  # - [1] "This", "is", "a", "test"
  # - [1] "This, is, a, test"
  
  # Note: Collapse collapses _vectors_ of strings into a single string!
}


## 14.2.3 Subsetting strings -----

# str_sub() extracts parts of a string. 

# In addition to the string, str_sub() takes 
# start and end arguments 
# as the (inclusive) position of the substring:

x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)
#> [1] "App" "Ban" "Pea"

# Note: Negative numbers count backwards from the end: 
str_sub(x, -3, -1)
#> [1] "ple" "ana" "ear"


{
  ## [test.quest]: str_sub with negative indices: 
  ## Assume: 
  
  x <- c("abc", "def", "ghi")
  
  ## What result str_sub(x, -1, 2) yield?
  
  # - "abc" "def" "ghi" 
  # - "" "" ""           (TRUE)
  # - "bc" "ef" "hi"
  # - "cb" "fe" "ih"
  # - "ghi" "def"
  
  
  ## [test.quest]: str_sub with negative indices: 
  ## Assume: 
  
  x <- c("abc", "def", "ghi")
  
  ## Which of the following command(s) yield the same result as x?
  
  # - str_c(x)
  # - str_sub(x)
  # - str_sub(x, +1, -1)
  # - str_sub(x, -3, -1)
  # - str_sub(x, +1, +3)
  
  # Answer: ALL of them!
}

# Note that str_sub() won’t fail if the string is too short: 
# It will just return as much as possible:
  
str_sub("a", 1, 5)

# We can also use the assignment form of str_sub() 
# to modify strings:

x <- c("Apple", "Banana", "Pear")

str_sub(x, 1, 1) <- str_to_lower(str_sub(x, 1, 1))
x


## 14.2.4 Locales -----

## Capitalization: ----

# Above we used str_to_lower() to change the text to lower case. 
# We can also use 
# - str_to_upper() or 
# - str_to_title(). 

# However, changing case is more complicated than it might at first appear 
# because different languages have different rules for changing case. 

# You can pick which set of rules to use by specifying a locale:
  
# Turkish has two i's: with and without a dot, and it
# has a different rule for capitalising them:
str_to_upper(c("i", "ı"))
#> [1] "I" "I"

str_to_upper(c("i", "ı"), locale = "tr")
#> [1] "İ" "I"

str_to_title("this is a title", locale = "en")
str_to_title("dies ist ein titel", locale = "de")

# The locale is specified as a ISO 639 language code, 
# which is a two or three letter abbreviation.

# List of ISO 639-1 codes
# https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes 


## (B) Sorting: ----

# Sorting is another important operation that’s affected by the locale. 
# The base R order() and sort() functions sort strings using 
# the current locale. 

# If you want robust behaviour across different computers, 
# you may want to use str_sort() and str_order() 
# which take an additional locale argument:
  
x <- c("apple", "eggplant", "banana")

str_sort(x, locale = "en")   # English
#> [1] "apple"    "banana"   "eggplant"

str_sort(x, locale = "haw")  # Hawaiian
#> [1] "apple"    "eggplant" "banana"


## 14.2.5 Exercises -----

# 1. In code that doesn’t use stringr, you’ll often see paste() and paste0().
#    - What’s the difference between the two functions? 
#    - What stringr function are they equivalent to? 
#    - How do the functions differ in their handling of NA?

a <- "Apple"
b <- "Banana"
c <- "Coin"

#    - What’s the difference between the two functions? 

# The following yield 1 string: 
paste(a, b, c)  # takes n strings (not a vector of strings) and uses " " as default separator
paste0(a, b, c) # takes n strings (not a vector of strings) and uses ""  as default separator

# Thus, paste separates strings by spaces by default, 
# whereas paste0 does not separate strings with spaces by default.

# The following yield 3 strings (which are identical):
paste(c(a, b, c))
paste0(c(a, b, c))

#    - What stringr function are they equivalent to? 

# Since str_c does not separate strings with spaces by default it is closer in behavior to paste0.
str_c(a, b, c)

# Note also: 
str_c(c(a, b, c), collapse = " ")

str_c(a, b, c)
str_c(c(a, b, c), collapse = "")


#    - How do the functions differ in their handling of NA?

d <- NA



# paste commands: 
paste(a, b, c, d)  # NA is interpreted as/treated like a string "NA"
paste0(a, b, c, d) # NA is interpreted as/treated like a string "NA"

# By contrast: 
str_c(c(a, b, c, d), collapse = " ")  # NA is contagious: everything becomes NA!



str_c(a, b, c, d)                     # NA is contagious: everything becomes NA!
str_c(c(a, b, c, d), collapse = "")   # NA is contagious: everything becomes NA!

# Thus, str_c and the paste function handle NA differently. 

# - The paste functions convert NA to the string "NA" and 
#   then treat it as any other character vector.
# - The function str_c propagates NA (as being contagious): 
#   If any argument is a missing value, it returns a missing value. 

# Optional: Use str_replace_na() around string
str_c(str_replace_na(c(a, b, c, d)), collapse = " ") 
str_c(str_replace_na(c(a, b, c, d)), collapse = "") 


# 2. In your own words, describe the difference between the 
#    sep and collapse arguments to str_c().

str_c(a, b, c, sep = "; ")          # combines 3 strings into 1 string (with elements separated by sep)
str_c(c(a, b, c), collapse = "; ")  # collapses a vector of strings into 1 string (with elements separated by collapse)



# 3. Use str_length() and str_sub() to extract the middle character 
#    from a string. 
#    What will you do if the string has an even number of characters?

# 4. What does str_wrap() do? When might you want to use it?

# 5. What does str_trim() do? What’s the opposite of str_trim()?

# 6. Write a function that turns (e.g.) a vector c("a", "b", "c") into the
# string a, b, and c. Think carefully about what it should do if given a vector
# of length 0, 1, or 2.



## +++ here now +++ ------


## Appendix ------

# See 

## Documentation: 

# stringr Vignettes 


## R packages: 

## Web: 

## Ideas for test questions [test.quest]: ------

## Multiple choice [MC] questions: -----

## Practical questions: ----- 

## ------
## eof.