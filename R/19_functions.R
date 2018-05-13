## r4ds: Chapter 19: 
## Code for http://r4ds.had.co.nz/functions.html
## hn spds uni.kn
## 2018 05 13 ------


# Programming with pipes:
#  Learn how to use the pipe, %>%, how it works, 
#  what the alternatives are, and when not to use it.



## Quotes: ------

# Programs should be written for people to read, 
# and only incidentally for machines to execute.

# Abelson and Sussman, Structure and Interpretation of Computer Programs



## 19.1 Introduction -------


# Functions allow you to automate common tasks in a more powerful and 
# general way than copy-and-pasting. 

## Advantages: 

# - Clarity: an evocative name that makes code more transparent.
# - Modularity: updating code in one place, instead of many.
# - Robustness and debugging: reducing the chance of making incidental mistakes

# Writing good functions is a lifetime journey. 

# As well as practical advice for writing functions, this chapter also gives you
# some suggestions for how to style your code. Good code style is like correct
# punctuation. Youcanmanagewithoutit, but it sure makes things easier to read!


## 19.1.1 Prerequisites -----

# Base R, no extra packages.


## 19.2 When should you write a function? ------

# - When abstracting away from concrete to more general cases.
# - When steps repeat.

## Example:

df <- tibble::tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

df

df$a <- (df$a - min(df$a, na.rm = TRUE)) / 
  (max(df$a, na.rm = TRUE) - min(df$a, na.rm = TRUE))
df$b <- (df$b - min(df$b, na.rm = TRUE)) / 
  (max(df$b, na.rm = TRUE) - min(df$a, na.rm = TRUE))
df$c <- (df$c - min(df$c, na.rm = TRUE)) / 
  (max(df$c, na.rm = TRUE) - min(df$c, na.rm = TRUE))
df$d <- (df$d - min(df$d, na.rm = TRUE)) / 
  (max(df$d, na.rm = TRUE) - min(df$d, na.rm = TRUE))

df

# Code appears to normalize each column.
# However, repetitive and contains an error (in normalizing df$b).

## Steps to write a function: ----- 

# 1. name the function; 
# 2. analyze the repeated steps and its inputs (as arguments); 
# 3. identify and name the intermediate components (in body). 

rescale01 <- function(x) {         # inputs
  rng <- range(x, na.rm = TRUE)    # intermediate step
  (x - rng[1]) / (rng[2] - rng[1]) # output
}

# 4. Check any new function with a range of different inputs:  
rescale01(c(0, 5, 10))
#> [1] 0.0 0.5 1.0

rescale01(c(-10, 0, 10))
#> [1] 0.0 0.5 1.0

rescale01(c(1, 2, 3, NA, 5))
#> [1] 0.00 0.25 0.50   NA 1.00

# Note: For automated testing of functions, see
#       http://r-pkgs.had.co.nz/tests.html 

# Given the new function, 
# we can simplify the original example code to:
  
df$a <- rescale01(df$a)
df$b <- rescale01(df$b)
df$c <- rescale01(df$c)
df$d <- rescale01(df$d)

# Compared to the original code above, 
# this is easier to understand and 
# we’ve eliminated one class of copy-and-paste errors. 

# There is still quite a bit of duplication 
# since we’re doing the same thing to multiple columns. 

# We’ll learn how to eliminate that duplication in 
# - iteration: http://r4ds.had.co.nz/iteration.html 
# once we’ve learned more about R’s data structures in 
# - vectors: http://r4ds.had.co.nz/vectors.html 

# Another advantage of functions is that if our requirements change, 
# we only need to make the change in one place. 

# For example, we might discover that some of our variables 
# include infinite values, and rescale01() fails:
  
x <- c(1:10, Inf)
rescale01(x)
#>  [1]   0   0   0   0   0   0   0   0   0   0 NaN

# Because we’ve abstracted the code into a function, 
# we only need to fix it in one place:
  
rescale01 <- function(x) {
  rng <- range(x, na.rm = TRUE, finite = TRUE)  # Add finite argument
  (x - rng[1]) / (rng[2] - rng[1])
}

rescale01(x) # now returns:
#> [1] 0.0000000 0.1111111 0.2222222 0.3333333 0.4444444 0.5555556 0.6666667 0.7777778 0.8888889 1.0000000 Inf


## DRY principle: ----- 

# This is an important part of the “do not repeat yourself” (or DRY) principle.
# The more repetition we have in our code, the more places we need to
# remember to update when things change (and they always do!), 
# and the more likely we are to create bugs over time. 

## 19.2.1 Practice / Exercises ----- 

# 1. Why is TRUE not a parameter to rescale01()? 
#    What would happen if x contained a single missing value, and na.rm was FALSE?

# TRUE is not a parameter because it never changes 
# (or rather: changing it to FALSE would not make sense here) .

x <- c(1, 2, 3, NA)

# setting na.rm to FALSE in range
range(x, na.rm = FALSE) # returns: 
# => NA NA

rescale01b <- function(x) {
  rng <- range(x, na.rm = FALSE)  # change na.rm to FALSE
  (x - rng[1]) / (rng[2] - rng[1])
}
rescale01b(x) 


# 2. In the 2nd variant of rescale01(), infinite values are left unchanged. 
#    Rewrite rescale01() so that -Inf is mapped to 0, and Inf is mapped to 1.

# 2nd variant: 
rescale01 <- function(x) {
  rng <- range(x, na.rm = TRUE, finite = TRUE) 
  (x - rng[1]) / (rng[2] - rng[1])
}

x <- c(1, 2, -Inf, +Inf, 3)
rescale01(x)
#> [1]  0.0  0.5 -Inf  Inf  1.0 

# 3rd variant: 
rescale01b <- function(x) {
  
  rng <- range(x, na.rm = TRUE, finite = TRUE) 
  result <- (x - rng[1]) / (rng[2] - rng[1])  # store result as object
  
  # Change any -Inf and +Inf values: 
  result[ result == -Inf ] <- 0  
  result[ result == +Inf ] <- 1
  result 
  
}

rescale01b(x)
#> [1] 0.0 0.5 0.0 1.0 1.0 


# 3. Practice turning the following code snippets into functions. 
#    Think about what each function does. 
#    - What would you call it?  
#    - How many arguments does it need? 
#    - Can you rewrite it to be more expressive or less duplicative?

# (a) mean(is.na(x))
x <- c(1, 2, NA, 4)
mean(is.na(x))

x <- c(NA, NA, NA)
mean(is.na(x))

# Proportion of NA values: 
prop_na <- function(x) {
  nas <- is.na(x)
  mean(nas)
}

x <- c(1, 2, NA, 4)
x <- c(NA, NA, NA)
prop_na(x)

# (b) x / sum(x, na.rm = TRUE)

x <- c(1, 2, NA, 4)
x <- c(NA, NA, NA)
x / sum(x, na.rm = TRUE)

# Percentage or weights (summing to 1): 
perc <- function(x) {
  (x / sum(x, na.rm = TRUE))
}

perc(x)


# (c) sd(x, na.rm = TRUE) / mean(x, na.rm = TRUE)
# SD over mean, aka. coefficient of variation or 
# relative standard deviation (RSD): 
# https://en.wikipedia.org/wiki/Coefficient_of_variation 

x <- c(1, 2, NA, 4)
x <- c(NA, NA, NA)
sd(x, na.rm = TRUE) / mean(x, na.rm = TRUE)

cv <- function(x) {
  (sd(x, na.rm = TRUE) / mean(x, na.rm = TRUE))  
}

x <- c(1, 2, NA, 4)
x <- c(NA, NA, NA)

cv(x)

# 4. Follow http://nicercode.github.io/intro/writing-functions.html 
#    to write your own functions to compute the variance and skew 
#    of a numeric vector.

# (a) sample variance:
var(1:10)

# own version: 
variance <- function(x) {
  # remove missing values
  x <- x[!is.na(x)]
  n <- length(x)
  m <- mean(x)
  sq_err <- (x - m) ^ 2
  sum(sq_err) / (n - 1)
}

variance(1:10)

# (b) skewness:
skewness <- function(x) {
  x <- x[!is.na(x)]
  n <- length(x)
  m <- mean(x)
  m3 <- sum((x - m) ^ 3) / n
  s3 <- sqrt(sum((x - m) ^ 2) / (n - 1))
  m3 / s3
}

set.seed(101)
skewness(rgamma(10, 1, 1))

# 5. Write both_na(), a function that takes two vectors of the same length and
#    returns the number of positions that have an NA in both vectors.

both_na <- function(x, y) {
  sum(is.na(x) & is.na(y))
}

x <- c(1, NA, 2, NA)
y <- c(NA, 2, NA, 4)
both_na(x, y)  # => 0

x <- c(NA, NA, 2, NA)
y <- c(NA, 2, NA, NA)
both_na(x, y)  # => 2

x <- c(NA, NA, NA, NA)
y <- c(NA, NA, NA, NA)
both_na(x, y)  # => 4


# 6. What do the following functions do? Why are they useful even though they are so short?
  
is_directory <- function(x) file.info(x)$isdir
is_readable <- function(x) file.access(x, 4) == 0

is_directory("data")
is_directory("stuff")

# Function names are more mnemonic than general-purpose commands.


# 7. Read the complete lyrics to “Little Bunny Foo Foo”. 
# There’s a lot of duplication in this song. 
# Extend the initial piping example to recreate the
# complete song, and use functions to reduce the duplication.

# Lyrics at
# https://en.wikipedia.org/wiki/Little_Bunny_Foo_Foo 

# Solution by 
# https://jrnold.github.io/r4ds-exercise-solutions/functions.html#when-should-you-write-a-function 

{
  # ## 3 functions:
  # threat <- function(chances) {
  #   give_chances(from = Good_Fairy,
  #                to = foo_foo,
  #                number = chances,
  #                condition = "Don't behave",
  #                consequence = turn_into_goon)  
  # }
  # 
  # lyric <- function() {
  #   foo_foo %>%
  #     hop(through = forest) %>%
  #     scoop(up = field_mouse) %>%
  #     bop(on = head)
  #   
  #   down_came(Good_Fairy)
  #   said(Good_Fairy,
  #        c("Little bunny Foo Foo",
  #          "I don't want to see you",
  #          "Scooping up the field mice",
  #          "And bopping them on the head.")
  # }
  # 
  # ## Call functions: 
  # lyric()
  # threat(3)
  # 
  # lyric()
  # threat(2)
  # 
  # lyric()
  # threat(1)
  # 
  # lyric()
  # turn_into_goon(Good_Fairy, foo_foo)
}


## 19.3 Functions are for humans and computers ------ 

## Recommendations: ---- 

# 1. The name of a function should be short, but clearly evoke what the function does. 
#    When in conflict, it’s better to be clear than short.

# 2. Function names should be verbs, and arguments should be nouns.
#    Avoid common terms like "get_" and "compute_" unless there's a good reason for them.

# 3. For multiple words, snake_case seems clearer than camelCase. 
#    But be consistent.

# 4. For family of functions (with common goals or elements), use a common prefix.

# 5. Avoid overriding existing functions and variables (unless there's a good reason). 

# 6. Use comments, lines starting with #, to explain the "why" of your code
#    (and make sure that the "what" and "how" are self-explanatory).

# 7. Use named sections (Cmd - Shift - R) to structure code.


## 19.3.1 Exercises -----

# 1. Read the source code for each of the following three functions, 
#    puzzle out what they do, and then brainstorm better names.

f1 <- function(string, prefix) {
  substr(string, 1, nchar(prefix)) == prefix
}

f1("prefix", "pre") # => TRUE
f1("suffix", "pre") # => FALSE
# Better name: has_prefix(string, prefix)

f2 <- function(x) {
  if (length(x) <= 1) return(NULL)
  x[-length(x)]
}

f2(c(1, 2, 3))
f2(c(1))
f2(c(NA))
# Better name: remove_last(x)

f3 <- function(x, y) {
  rep(y, length.out = length(x))
}

f3(c(1, 2, 3), 2)
f3(c(NA, NA), 2)
# Better name: replace_elements()

# 2. Take a function that you’ve written recently and spend 5 minutes
#    brainstorming a better name for it and its arguments.

# 3. Compare and contrast rnorm() and MASS::mvrnorm(). 
#    How could you make them more consistent?

set.seed(1)
r1 <- rnorm(n = 10, mean = 0, sd = 1) # returns a vector.

set.seed(1)
r2 <- MASS::mvrnorm(n = 10, mu = 0, Sigma = 1) # returns a matrix.

all.equal(r1, r2[,1]) # => TRUE


# 4. Make a case for why norm_r(), norm_d() etc would be better 
#    than rnorm(), dnorm(). Make a case for the opposite.

rnorm(n = 10, mean = 10, sd = 2)
?rnorm

dnorm(x = 1:4, mean= 10, sd = 2)
?dnorm

# - Good: common argument names and default values.
# - pro norm_: Emphasize common family of function.
# - against norm_: Emphasize differences and 
#   relation to other families (like runif(), etc.). 


## 19.4 Conditional execution ------

## +++ here now +++ ------



## 19.5 Function arguments ------


## 19.6 Return values ------


## 19.7 Environment ----- 


## Appendix ------

## Web:  

# Best practices for scientific computing:
# - http://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1001745

# Nice R code:
# - https://nicercode.github.io/ 
# - https://nicercode.github.io/blog/2013-04-05-why-nice-code/ 
# - https://nicercode.github.io/guides/functions/

# Cheatsheets: 
# See Base-R and Advanced-R at  
# https://www.rstudio.com/resources/cheatsheets/

## Documentation: ----- 

## Links to many books, manuals and scripts:
## https://www.r-project.org/doc/bib/R-books.html 
## https://cran.r-project.org/manuals.html
## https://bookdown.org/ 


## ------
## eof.