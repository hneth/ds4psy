## r4ds: Chapter 14: Strings
## Code for http://r4ds.had.co.nz/strings.html 
## hn spds uni.kn
## 2018 04 09 ------

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

get_mid <- function(string) {
  
  l <- str_length(string)
  
  start <- ceiling(l/2)
  
  # if (l %% 2 == 0) {
  #   start <- l/2
  #   end <- start + 1
  # } else {
  #   start <- ceiling(l/2)
  #   end <- start + 1 - (l %% 2)
  # }

  start <- ceiling(l/2)
  end <- start + 1 - (l %% 2)
  
  mid <- str_sub(string, start, end)
    
  return(mid)
  }
  
get_mid(c("1", "12", "123", "1234", "12345", "123456"))

# 4. What does str_wrap() do? When might you want to use it?

?str_wrap # wrap strings into nicely formatted paragraphs.

# Example:
thanks_path <- file.path(R.home("doc"), "THANKS")
thanks <- str_c(readLines(thanks_path), collapse = "\n")
thanks <- word(thanks, 1, 3, fixed("\n\n"))
cat(str_wrap(thanks), "\n")
cat(str_wrap(thanks, width = 40), "\n")
cat(str_wrap(thanks, width = 60, indent = 2), "\n")
cat(str_wrap(thanks, width = 60, exdent = 2), "\n")
cat(str_wrap(thanks, width = 0, exdent = 2), "\n")

# 5. What does str_trim() do? What’s the opposite of str_trim()?

?str_trim()   # removes whitespace from start and end of string; 
?str_squish() # also reduces repeated whitespace inside a string.

?str_pad() # adds whitespace

s <- " this string has  added  white space "
str_trim(s)
str_squish(s)

str_pad(s, width = 50, side = "both")

# 6. Write a function that turns (e.g.) a vector c("a", "b", "c") into the
#    string "a, b, and c". 
#    Think carefully about what it should do if given a vector of length 0, 1, or 2. 

# yet ToDo



## 14.3 Matching patterns with regular expressions ------

# Regexps are a very terse language that allow you to describe patterns in strings. 

# To learn regular expressions, we’ll use str_view() and str_view_all(). 
# These functions take a character vector and a regular expression, 
# and show you how they match:


## 14.3.1 Basic matches and escapes -----

# 1. The simplest patterns match exact strings:
  
x <- c("apple", "banana", "pear")

str_view(x, "an") # Note: only 1st "an" in "banana" is found.
str_view(x, "a")  # Note: only 1st "a"  in "banana" is found.


# 2. The next step up in complexity is ., 
#    which matches any character (except a newline):

str_view(x, ".a.")  # Note: Start of "apple" is NOT matched.


# 3. But if “.” matches any character, how do you match the character “.”? 
#    You need to use an “escape” to tell the regular expression that you want to match it exactly, 
#    rather than use its special behaviour. 

#   Like strings, regexps use the backslash, \, to escape special behaviour. 
#   So to match an ., you need the regexp \.. 

#   Unfortunately this creates a problem:  
#   We use _strings_ to represent regular expressions, 
#   and \ is also used as an escape symbol in strings. 

#   So to create the regular expression \. we need the string "\\.".

# To create the regular expression \., we need the string "\\." 
dot <- "\\."  # a string

# But the expression itself only contains one backslash: 
writeLines(dot)
#> \.

# And this tells R to look for an explicit ".": 
str_view(c("abc", "a.c", "bef"), "a\\.c")

s <- "This is a sentence."
str_view(s, "\\.")

# 4. If \ is used as an escape character in regular expressions, 
#    how do you match a literal \? 

# Well you need to escape it, creating the regular expression \\. 
# To create that regular expression, you need to use a string, 
# which also needs to escape \. 
# That means to match a literal \ you need to write "\\\\" 
# — you need four backslashes to match one!

x <- "a\\b"
writeLines(x)
#> a\b

str_view(x, "\\\\")


## 14.3.1.1 Exercises -----

# 1. Explain why each of these strings don’t match a \: 
#    "\", "\\", "\\\".

#    "\" is the escape character in a regular expression, 
#    "\\" is a regular expression that escapes the escape character \.
#         However, we need a string that represents this expression.
#    "\\\" escapes 1 of the 2 \, but we need to escape both.

# Solution from 
# https://jrnold.github.io/r4ds-exercise-solutions/strings.html#basic-matches :
# "\": This will escape the next character in the R string.
# "\\": This will resolve to \ in the regular expression, which will escape the next character in the regular expression.
# "\\\": The first two backslashes will resolve to a literal backslash in the regular expression, the third will escape the next character. So in the regular expression, this will escape some escaped character.


# 2. How would you match the (3-symbol) sequence "'\?

seq <- "\"\'\\"
writeLines(seq)

teststring <- str_c("a", seq, "df")
regex <- "\"\'\\\\"  # written as a string
writeLines(regex)    # as regex

str_view(teststring, regex)

# Note: The single quote (') does not require escape (\):
regex2 <- "\"'\\\\"  # written as a string
writeLines(regex2)   # as regex

str_view(teststring, regex2)


# 3. What patterns will the regular expression \..\..\.. match? 
#    How would you represent it as a string?

# It will match any 3 single letters following a period (e.g. (".a.b.c", ".x.y.z", ...):

teststring <- c(".a.b.c", ".x.y.z", ".aa.bb.cc", "some.T.N.Tstuff")

regex <- "\\..\\..\\.."  # written as a string
writeLines(regex)    # as regex

str_view(teststring, regex)


## 14.3.2 Anchors -----

# By default, regular expressions will match _any part_ of a string. 

# It’s often useful to anchor the regular expression so that 
# it matches from the start or end of the string. 

# Use:
# - ^ (at the front) to match the start of the string.
# - $ (at the back)  to match the end of the string.

x <- c("apple", "banana", "pear")

str_view(x, "^a") # matches only 1st letter of apple
str_view(x, "a$") # matches only the last letter of banana

# Mnemonic: if you begin with power (^), you end up with money ($).

# To force a regular expression to only match a complete string, 
# anchor it with both ^ and $:

x <- c("apple pie", "apple", "apple cake", "big apple", "applebees")

str_view(x, "apple")   # matches all 5 instances of "apple"
str_view(x, "^apple$") # matches only "apple" by itself

# You can also match the boundary between words with \b 
# (using a string "\\b")

str_view(x, "apple\\b") # fails to find "applebees"

# I don’t often use this in R, but I will sometimes use it 
# when I’m doing a search in RStudio when I want to find 
# the name of a function that’s a component of other functions. 

# For example, I’ll search for \bsum\b to avoid matching 
# summarise, summary, rowsum and so on.


## 14.3.2.1 Exercises -----

# 1. How would you match the literal string "$^$"?

s <- "$^$"
writeLines(s)

regex <- "\\$\\^\\$" # written as a string 
writeLines(regex)    # as regex

str_view(s, regex)

# alternatively (if we wanted to match entire strings only):

regex2 <- "^\\$\\^\\$$" # written as a string 
writeLines(regex2)      # as regex

str_view(s, regex2)


# 2. Given the corpus of common words in stringr::words, 
#    create regular expressions that find all words that:
#    a. Start with “y”.
#    b. End with “x”
#    c. Are exactly three letters long. (Don’t cheat by using str_length()!)
#    d. Have seven letters or more.

# Since this list is long, you might want to use the match argument to
# str_view() to show only the matching or non-matching words.

w <- stringr::words

# ad a. Start with “y”.
str_view(w, "^y", match = TRUE)

# ad b. End with “x”
str_view(w, "x$", match = TRUE)

# ad c. Are exactly three letters long. (Don’t cheat by using str_length()!)
str_view(w, "^...$", match = TRUE)

# ad d. Have seven letters or more.
str_view(w, ".......", match = TRUE)


## 14.3.3 Character classes and alternatives -----

## Wildcard characters: ----

# There are a number of special patterns 
# that match more than one character. 
# You’ve already seen ., which matches 
# any character apart from a newline. 

# There are four other useful tools:
#
# - \d:     matches any digit.
# - \s:     matches any whitespace (e.g. space, tab, newline).
# - [abc]:  matches a, b, or c.
# - [^abc]: matches anything except a, b, or c.

# As before, to create a regular expression containing \d or \s, 
# we need to escape the \ for the string, 
# so we type "\\d" or "\\s". 


## Alternation (|) and precedence: ----

# We can use _alternation_ (|) to pick between 
# alternative patterns. 
# For example, abc|d..f will match either 
# - ‘“abc”’, or 
# - "deaf". 

# Note that the precedence for | is low, so that abc|xyz 
# matches abc or xyz 
# not abcyz or abxyz. 

s <- c("abc", "xyz", "abcyz", "abxyz")
str_view(s, "abc|xyz")  # seems to match all 4 ???

# Difference: 
str_view(s, "(abc)|(xyz)") # matches all 4 strings 
str_view(s, "ab(c|x)yz")   # matches only last 2 

# As with mathematical expressions, 
# if precedence ever gets confusing, 
# use parentheses to make it clear what you want:

str_view(c("grey", "gray"), "gr(e|a)y")


## 14.3.3.1 Exercises -----

# 1. Create regular expressions to find all words that:
#    a. Start with a vowel.
#    b. That only contain consonants. (Hint: thinking about matching “not”-vowels.)
#    c. End with ed, but not with eed.
#    d. End with ing or ise.

w <- stringr::words

# ad a. Start with a vowel.
regex <- "^[aeiou]"
writeLines(regex)

str_view(w, regex, match = TRUE)

# ad b. That only contain consonants. (Hint: thinking about matching “not”-vowels.)
regex <- "^[^aeiou]+$"
writeLines(regex)

str_view(w, regex, match = TRUE)

# [test.quest]: Words that only contain vowels:
regex <- "^[aeiou]+$"
str_view(w, regex, match = TRUE)

# [test.quest]: Words that start with a vowel and end with a consonant:  
regex <- "^[aeiou]*[^aeiou]$"
str_view(w, regex, match = TRUE)

# ad c. End with ed, but not with eed.
regex <- "[^e]ed$"
str_view(w, regex, match = TRUE)

# ad d. End with ing or ise.
regex <- "(ing)|(ise)$"
str_view(w, regex, match = TRUE)

regex <- "i(ng|se)$"
str_view(w, regex, match = TRUE)


# 2. Empirically verify the rule “i before e except after c”.
regex <- "(c|i)e"  # finds only positive instances
regex <- "[^ci]e"  # finds falsification cases

str_view(w, regex, match = TRUE)

# From https://jrnold.github.io/r4ds-exercise-solutions/strings.html#character-classes-and-alternatives
# Using only what has been introduced thus far:
  
str_view(stringr::words, "(cei|[^c]ie)", match = TRUE)
str_view(stringr::words, "(cie|[^c]ei)", match = TRUE)

# 3. Is “q” always followed by a “u”?
regex <- "q[^u]"  # finds falsification cases
str_view(w, regex, match = TRUE) # fails to find anything => TRUE (in this dataset)
str_view(w, "qu", match = TRUE) # finds positive cases
str_view(w, "q", match = TRUE)  # finds the same positive cases

# 4. Write a regular expression that matches a word if it’s probably written in
# British English, not American English.

# yet ToDo

# 5. Create a regular expression that will match telephone numbers 
#    as commonly written in your country.

# yet ToDo


## 14.3.4 Repetition -----

## Repetitions: ----

# The next step up in power involves controlling 
# how many times a pattern matches:

# - ?: 0 or 1
# - +: 1 or more
# - *: 0 or more

x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"
str_view(x, "CC?")  # finds 1st match
str_view(x, "CC+")  # finds 1st and 2nd match
str_view(x, "CC*")  # finds 1st and 2nd match

# But note: 
str_view(x, 'C[LX]+')

# Note that the precedence of these operators is high, 
# so you can write: colou?r to match either American or British spellings. 
# That means most uses will need parentheses, like bana(na)+.

# ???

## Number of matches: ----

# To precisely specify the number of matches:

# - {n}:   exactly n
# - {n,}:  n or more
# - {,m}:  at most m
# - {n,m}: between n and m

str_view(x, "C{2}")  # finds CC
str_view(x, "C{2,}") # finds CCC
str_view(x, "C{2,3}") # finds CCC (greedy: longest match possible)

# By default these matches are “greedy”: 
# they will match the longest string possible. 
# You can make them “lazy”, matching the shortest string possible 
# by putting a ? after them. 
# This is an advanced feature of regular expressions, 
# but it’s useful to know that it exists:
  
str_view(x, 'C{2,3}?') # finds CC (lazy: shortest match possible)
str_view(x, 'C[LX]+?') # finds CL (lazy: shortest match possible)

# Note: 
str_view(x, "X+")    # finds XXX
str_view(x, "X{1}+") # finds X only


## 14.3.4.1 Exercises -----

# 1. Describe the equivalents of ?, +, * in {m,n} form.

# - ?: 0 or 1:    {0, 1}
# - +: 1 or more: {1, inf}
# - *: 0 or more: {0, inf}
 
# 2. Describe in words what these regular expressions match: 
#   (read carefully to see if we're using a regular expression 
#    or a string to define a regular expression.)
#    - ^.*$ 
#    - "\\{.+\\}"
#    - \d{4}-\d{2}-\d{2}
#    - "\\\\{4}"
 
#    - ^.*$  : a regex matching any string
str_view(c("a", "abc", "abc def", "..."), "^.*$")

#    - "\\{.+\\}": a string matching any word with at least 1 character inside curly braces {...} 
str_view(c("a", "abc", "abc def", "...", "{}", "{a}", "x {a b} z"), "\\{.+\\}")

#    - \d{4}-\d{2}-\d{2}: a regex matching 4-2-2 digit sequence (separated by -): 
str_view(c("a", "abc", "abc def", "...", "{}", "{a}", "x {a b} z", 
           "1234-56-78", "01234-56-7880"), "\\d{4}-\\d{2}-\\d{2}")

#    - "\\\\{4}":  a string matching 4 backslashes "\"
str_view( c("\\\\", "\\\\\\", "\\\\\\\\", "\\\\\\\\\\") , "\\\\{4}")


# 3. Create regular expressions to find all words that:
#    a. Start with three consonants.
#    b. Have three or more vowels in a row.
#    c. Have two or more vowel-consonant pairs in a row.

w <- stringr::words

#    a. Start with three consonants.
regex <- "^[^aeiou]{3}"
str_view(w, regex, match = TRUE)

#    b. Have three or more vowels in a row.
regex <- "[aeiou]{3,}"
str_view(w, regex, match = TRUE)

#    c. Have two or more vowel-consonant pairs in a row.
regex <- "([aeiou][^aeiou]){2,}"
str_view(w, regex, match = TRUE)

# [test.quest]:
# Words beginning with 4 consonants:
regex <- "^[^aeiou]{4}"
str_view(w, regex, match = TRUE) # => "system"

# Words with 4 vowel-consonant pairs in a row:
regex <- "([aeiou][^aeiou]){4}"
str_view(w, regex, match = TRUE) # => "original"

# 4. Solve the beginner regexp crosswords at 
#    https://regexcrossword.com/challenges/beginner.

# yet ToDo


## 14.3.5 Grouping and backreferences -----

# Earlier, we learned about parentheses as a way 
# to disambiguate complex expressions. 
# They also define “groups” that you can refer to with backreferences, 
# like \1, \2 etc. 

# For example, the following regular expression 
# finds all fruits that have a repeated pair of letters: 
str_view(fruit, "(..)\\1", match = TRUE)

# (Shortly, we’ll also see how they’re useful 
#  in conjunction with str_match().)


## 14.3.5.1 Exercises -----

# 1. Describe, in words, what these expressions will match:
#    a. (.)\1\1
#    b. "(.)(.)\\2\\1"
#    c. (..)\1
#    d. "(.).\\1.\\1"
#    e. "(.)(.)(.).*\\3\\2\\1"

#    a. (.)\1\1 := same letter 3 times in a row
str_view(c("ttt", "axxxz", "whazzzup", "anananas"), "(.)\\1\\1")

#    b. "(.)(.)\\2\\1" := a sequence of 2 letters in reversed order
str_view(c("banana", "abba", "Hannah", "ottonormal"), "(.)(.)\\2\\1")

#    c. (..)\1 := a sequence of 2 letters twice
str_view(c("banana", "abba", "Hannah", "ottonormal"), "(..)\\1")

#    d. "(.).\\1.\\1" := a letter 3 times with 2 arbitrary characters in between
str_view(c("banana", "aabbccdd", "hohoho", "iiiii", "attttta", "xi.i,i.x"), "(.).\\1.\\1")

#    e. "(.)(.)(.).*\\3\\2\\1" := a sequence of 3 letters in forward and reversed order.
str_view(c("abccba", "abba xyz abba", "Hannah", "hannah", "123.etc.321"), "(.)(.)(.).*\\3\\2\\1")

# 2. Construct regular expressions to match _words_ that:
#    a. Start and end with the same character.
regex <- "^.$"
regex <- "^(.)(.)\\1$" # does not match words yet.
regex <- "^(.).*\\1$"

str_view(w, regex, match = TRUE)

# [test.quest]: 
# Words that end with the same letter twice:
regex <- "(.)\\1$"
str_view(w, regex, match = TRUE)

#    b. Contain a repeated pair of letters 
#       (e.g., “church” contains “ch” repeated twice).
regex <- "(.)*.\\1" # does not match words yet.
str_view(w, regex, match = TRUE) 

#   c. Contain one letter repeated in at least three places 
#      (e.g., “eleven” contains three “e”s).
regex <- "(.).*\\1.*\\1"
# regex <- "([a-z]).*\\1.*\\1"
str_view(w, regex, match = TRUE) 


## 14.4 Tools ------

# Now that you’ve learned the basics of regular expressions, 
# it’s time to learn how to apply them to real problems. 

# In this section you’ll learn a wide array of stringr functions 
# that let you:
  
# - Determine which strings match a pattern.
# - Find the positions of matches.
# - Extract the content of matches.
# - Replace matches with new values.
# - Split a string based on a match.

# Cautionary tale: Beware of complicated regular expressions
# See the stackoverflow discussion on detecting valid email address 
# at http://stackoverflow.com/a/201378 for more details. 


## 14.4.1 Detect matches

# To determine if a character vector matches a pattern, 
# use str_detect(). 

# It returns a logical vector the same length as the input:
  
x <- c("apple", "banana", "pear")
str_detect(x, "e")

# Remember that when you use a logical vector in a numeric context, 
# FALSE becomes 0 and TRUE becomes 1. 
# That makes sum() and mean() useful if you want to answer questions 
# about matches across a larger vector:
  
# How many common words start with t?
words <- stringr::words
sum(str_detect(words, "^t"))

# What proportion of common words end with a vowel?
mean(str_detect(words, "[aeiou]$"))

# When you have complex logical conditions 
# (e.g., match a or b but not c unless d) 
# it’s often easier to combine multiple str_detect() calls 
# with logical operators, rather than trying to create 
# a single regular expression. 

# For example, here are two ways to find all words that 
# don’t contain any vowels:

# Find all words containing at least one vowel, and negate: 
no_vowels_1 <- !str_detect(words, "[aeiou]")

# Find all words consisting only of consonants (non-vowels): 
no_vowels_2 <- str_detect(words, "^[^aeiou]+$")

# Check for identity: 
identical(no_vowels_1, no_vowels_2)

# The results are identical, but the 1st approach is simpler and 
# easier to understand. 

# Lesson: If a regular expression gets overly complicated, 
# try breaking it up into smaller pieces, giving each piece a name, 
# and then combining the pieces with logical operations.


# A common use of str_detect() is to select the elements 
# that match a pattern. 
# We  can do this with logical subsetting, or the convenient 
# str_subset() wrapper:
  
words[str_detect(words, "x$")]  # words ending with "x"
str_subset(words, "x$")

# Typically, however, our strings will be a column of a data frame, 
# and we’ll want to use filter instead:

df <- tibble(
  word = words, 
  i = seq_along(word)
)

# ?seq_along

df %>% 
  filter(str_detect(words, "x$"))

# A variation on str_detect() is str_count(): 
# rather than a simple yes or no, it tells us 
# how many matches there are in a string:

x <- c("apple", "banana", "pear")
str_count(x, "a")

# On average, how many vowels are there per word?
mean(str_count(words, "[aeiou]"))

# In a typical use case, it makes sense to use 
# str_count() with mutate():

df %>% 
  mutate(
    chars = str_length(word), 
    vowels = str_count(word, "[aeiou]"),
    consonants = str_count(word, "[^aeiou]")
  )

# Note that matches never overlap. 
# For example, in "abababa", 
# how many times will the pattern "aba" match? 
# Regular expressions say 2 times, not 3:

str_count("abababa", "aba")

str_view_all("abababa", "aba")

# Note the use of str_view_all(). 
# As we’ll shortly learn, many stringr functions come in pairs: 
# one function works with a single match, and 
# the other works with all matches. 
# The 2nd function will have the suffix "_all".


# 14.4.2 Exercises -----

# 1. For each of the following challenges, try solving it by using both 
#    a singleregular expression, and 
#    a combination of multiple str_detect() calls.

# a. Find all words that start or end with x.
# b. Find all words that start with a vowel and end with a consonant.
# c. Are there any words that contain at least one of each different vowel?

# a. Find all words that start or end with x.

# 1 regex: 
regex <- "^x|x$"
str_view(words, regex, match = TRUE)
words[str_detect(words, regex)]

# 2 regex:
regex1 <- "^x"
regex2 <- "x$"
words[str_detect(words, regex1) | str_detect(words, regex2)]

# b. Find all words that start with a vowel and end with a consonant.
# 1 regex: 
regex <- "^[aeiou]|[^aeiou]$"
words[str_detect(words, regex)]

# 2 regex:
regex1 <- "^[aeiou]"
regex2 <- "[^aeiou]$"
words[str_detect(words, regex1) | str_detect(words, regex2)]

# c. Are there any words that contain at least one of each different vowel?

# many regex:
rx1 <- "a"
rx2 <- "e"
rx3 <- "i"
rx4 <- "o"
rx5 <- "u"

words[str_detect(words, rx1) & str_detect(words, rx2) & 
      str_detect(words, rx3) & str_detect(words, rx4) ]  # still exist

words[str_detect(words, rx1) & str_detect(words, rx2) & 
      str_detect(words, rx3) & str_detect(words, rx4) &
      str_detect(words, rx5) ]                           # no longer exist

   
# 2. What word has the highest number of vowels? 
#    What word has the highest proportion of vowels? 
#    (Hint: what is the denominator?)

# What word has the highest number of vowels? 
max <- max(str_count(words, "[aeiou]"))
words[str_count(words, "[aeiou]") == max]

#    What word has the highest proportion of vowels? 
#    (Hint: what is the denominator?)
nvow <- str_count(words, "[aeiou]")
len <- str_length(words)

words[nvow/len == max(nvow/len)]  # ==> "a"

## 14.4.3 Extract matches ----- 

# To extract the actual text of a match, use 
# str_extract().

stringr::sentences # 720 Harvard sentences
# see https://en.wikipedia.org/wiki/Harvard_sentences 

length(sentences) #> [1] 720
head(sentences)

# Imagine we want to find all sentences that contain a colour. 
# We first create a vector of colour names, and then 
# turn it into a single regular expression:

colours <- c("red", "orange", "yellow", "green", "blue", "purple")
colour_match <- str_c(colours, collapse = "|")
colour_match

# Now we can select the sentences that contain a colour, 
# and then extract the colour to figure out which one it is:
  
has_colour <- str_subset(sentences, colour_match)
has_colour

matches <- str_extract(has_colour, colour_match)
head(matches)
table(matches)

# Note that str_extract() only extracts the 1st match. 
# We can see that by first selecting all sentences 
# that have more than 1 match:
  
more <- sentences[str_count(sentences, colour_match) > 1]
str_view_all(more, colour_match)

str_extract(more, colour_match)

# This is a common pattern for stringr functions, 
# because working with a single match allows you to use 
# much simpler data structures. 

# To get all matches, use str_extract_all(). 
# It returns a list:

str_extract_all(more, colour_match)

# We’ll learn more about lists in lists and iteration:
# http://r4ds.had.co.nz/vectors.html#lists 
# http://r4ds.had.co.nz/iteration.html#iteration 

# If we use simplify = TRUE, str_extract_all() 
# will return a matrix with short matches expanded to the same length 
# as the longest:
  
str_extract_all(more, colour_match, simplify = TRUE)

x <- c("a", "a b", "a b c")
str_extract_all(x, "[a-z]", simplify = TRUE)


## 14.4.3.1 Exercises ----- 

# 1. In the previous example, you might have noticed that the 
# regular expression matched “flickered”, which is not a colour. 
# Modify the regex to fix the problem.

## +++ here now +++ ------

# 2. From the Harvard sentences data, extract: 
#    a. The first word from each sentence.
#    b. All words ending in "ing".
#    c. All plurals.




# [test.quest]: Extract all sentences with family names:
family <- c("mother", "father", "son$", "daughter", "sister", "brother")
family_match <- str_c(family, collapse = "|")
has_family <- str_subset(sentences, family_match)
has_family 





## Appendix ------

# See 

## Documentation: 

# stringr Vignettes 


## R packages: 

## Web: 

## Ideas for test questions [test.quest]: ------

## Multiple choice [MC] questions: -----

## Practical questions: ----- 

library(tidyverse)
library("stringr")
w <- stringr::words

# [test.quest]: Based on 14.3.4.1, Exercise 3

# Words beginning with 4 consonants:
regex <- "^[^aeiou]{4}"
str_view(w, regex, match = TRUE) # => "system"

# Words with 4 vowel-consonant pairs in a row:
regex <- "([aeiou][^aeiou]){4}"
str_view(w, regex, match = TRUE) # => "original"



# [test.quest]: Baby name, 3 letters, starting with letter "Z"?
n <- unique(babynames::babynames$name)
as_tibble(n)

str_view(n, "^Z..$", match = TRUE)


## ------
## eof.