## text_fun.R | ds4psy
## hn | uni.kn | 2019 09 28
## ---------------------------

## Functions for text/string objects. 

## (0) Define text labels: ---------- 

# course_title     <- paste0("Data science for psychologists")
# course_title_abb <- paste0("ds4psy")
# # psi <- expression(psi)
# name_hn <- "Hansjoerg Neth"
# name_course <- paste0(course_title, " (", course_title_abb, "), by ", name_hn, "")
# # name_course

## (1) L33t slang: ---------- 

# Using leet / l33t slang: ------

# # l33t rul35: 
# n4me <- "h4n5j03Rg n3+h"     # e:3, a:4, s:5, o:0, t:+, r:R
# d5   <- "d4+4 5c13nc3"       # i:1 
# fp   <- "f0R p5ych0l0g15+5"
# course_l33t <- paste0(n4me, ":", " ", d5, " ", fp)
# # course_l33t


# Automation: ----- 

# txt1 <- "This is a short test string with some text to leetify."
# txt2 <- "Data science is both a craft and an art. This course introduces fundamental data types, 
#          basic concepts and commands of the R programming language, and explores key packages of the so-called tidyverse. 
#          Regular exercises will help you to make your first steps from R novice to user."

# Write functions to:  
# - switch text to lower/upper case, capitalize, etc.
# - leetify a string of text (with sets of rules)
# - mix content (letters, words, ...) with noise (punctuation, space, random characters)

## l33t_rul35: leet rules: ------ 

l33t_num <- c("a" = "4", "A" = "4", 
              "e" = "3", "E" = "3", 
              "i" = "1", "I" = "1", 
              "o" = "0", "O" = "0", 
              "s" = "5", "S" = "5", 
              "T" = "7"
)

my_l33t <- c("t" = "+",
             "r" = "R"
) 

#' l33t_rul35 provides rules for translating into leet/l33t slang. 
#' 
#' \code{l33t_rul35} specifies rules for translating characters 
#' into leet/l33t slang (as a character vector).
#' 
#' @family text functions
#' 
#' @export

l33t_rul35 <- c(l33t_num, my_l33t)

## Check: 
# l33t_rul35

## transl33t function: ------ 

## (a) Test:
# stringr::str_replace_all(txt, l33t_rul35)

## (b) as function: 

#' transl33t text into leet slang (using stringr).
#'
#' \code{transl33t} translates text into leet (or l33t) slang 
#' given a set of rules and the \bold{stringr} package.
#' 
#' @param txt The text (character string) to translate.
#' 
#' @param rules Rules which existing character in \code{txt} 
#' is to be replaced by which new character (as named character vector). 
#' Default: \code{rules = \link{l33t_rul35}}. 
#' 
#' @param in_case Change case of input string \code{txt}. 
#' Default: \code{in_case = "no"}. 
#' Set to \code{"lo"} or \code{"up"} for lower or uppercase, respectively.  
#' 
#' @param out_case Change case of output string. 
#' Default: \code{out_case = "no"}. 
#' Set to \code{"lo"} or \code{"up"} for lower or uppercase, respectively.  
#' 
#' @examples
#' # Use defaults:
#' transl33t(txt = "hello world")
#' transl33t(txt = c(letters))
#' transl33t(txt = c(LETTERS))
#' 
#' # Specify rules:
#' transl33t(txt = "hello world", 
#'           rules = c("e" = "3", "l" = "1", "o" = "0"))
#' 
#' # Set input and output case:
#' transl33t(txt = "hello world", in_case = "up", 
#'           rules = c("e" = "3", "l" = "1", "o" = "0"))
#' transl33t(txt = "hello world", out_case = "up", 
#'           rules = c("e" = "3", "l" = "1", "o" = "0"))
#' 
#' @family text functions
#'
#' @seealso
#' \code{\link{l33t_rul35}} for default rules. 
#' 
#' @importFrom stringr str_replace_all
#' 
#' @export

transl33t <- function(txt, rules = l33t_rul35,
                      in_case = "no", out_case = "no") {
  
  # robustness: 
  in_case  <- tolower(substr(in_case,  1 , 2))  # 1st 2 letters of in_case
  out_case <- tolower(substr(out_case, 1 , 2))  # 1st 2 letters of out_case  
  
  # handle in_case: 
  if (in_case == "lo") {
    txt <- tolower(txt)
  } else if (in_case == "up") {
    txt <- toupper(txt)
  }
  
  # transl33t based on rules:   
  out <- stringr::str_replace_all(txt, rules)
  
  # handle out_case: 
  if (out_case == "lo") {
    out <- tolower(out)
  } else  if (out_case == "up") {
    out <- toupper(out)
  }
  
  return(out)
  
} # transl33t. 

# ## Check: 
# transl33t(txt1, rules = c("a" = "4"))
# transl33t(txt1)
# transl33t(txt1 = c(txt, txt2))
# transl33t(txt1 = c(letters, LETTERS))
# 
# # 9 variants:
# transl33t(txt1)  # leave in_case and out_case as is.
# transl33t(txt1,  in_case = "lo")
# transl33t(txt1,  in_case = "up")
# transl33t(txt1, out_case = "lo")
# transl33t(txt1, out_case = "up")
# transl33t(txt1,  in_case = "lo", out_case = "lo")
# transl33t(txt1,  in_case = "lo", out_case = "up")
# transl33t(txt1,  in_case = "up", out_case = "lo")
# transl33t(txt1,  in_case = "up", out_case = "up")
# 
# # Check: 
# all.equal(transl33t(txt = c(letters), in_case = "up"),
#           transl33t(txt = c(LETTERS)))
# 
# all.equal(transl33t(txt = c(LETTERS), in_case = "lo"),
#           transl33t(txt = c(letters)))


## (2) Read ascii art into a tibble: ---------- 

#' read_ascii parses text (from a file) into a tibble.
#'
#' \code{read_ascii} parses text 
#' (from a file or from user input in Console) 
#' into a tibble that contains a row for each character. 
#' 
#' \code{read_ascii} creates a tibble with 3 variables: 
#' Each character's \code{x}- and \code{y}-coordinates (from top to bottom)  
#' and a variable \code{char} for the character at this coordinate. 
#' 
#' The \bold{here} package is used to determine 
#' the (absolute) file path. 
#' 
#' @param file The text file to read (or its path). 
#' If \code{file = ""} (the default), \code{scan} is used 
#' to read user input from the Console. 
#' If a text file is stored in a sub-directory, 
#' enter its path and name here (without any leading or 
#' trailing "." or "/"). 
#' Default: \code{file = ""}. 
#' 
#' @param flip_y Boolean: Should y-coordinates be flipped, 
#' so that the lowest line in the text file becomes \code{y = 1}, 
#' and the top line in the text file becomes \code{y = n_lines}? 
#' Default: \code{flip_y = FALSE}. 
#' 
#' @examples
#' # Create a temporary file "test.txt":
#' cat("Hello world!", "This is a test.", 
#'     "Can you see this text?", 
#'     "Good! Please carry on...", 
#'     file = "test.txt", sep = "\n")
#' 
#' # (a) Read text (from file): 
#' read_ascii("test.txt")
#' read_ascii("test.txt", flip_y = TRUE)  # y flipped
#' 
#' unlink("test.txt")  # clean up (by deleting file).
#'  
#' \donttest{
#' # (b) Read text (from file in subdir):
#' read_ascii("data-raw/txt/ascii.txt")  # requires txt file
#' 
#' # (c) Scan user input (from console):
#' read_ascii()
#' }
#' 
#' @family text functions
#'
#' @seealso
#' \code{\link{plot_text}} for a corresponding plot function. 
#' 
#' @import here
#' @import tibble
#' 
#' @export

read_ascii <- function(file = "", flip_y = FALSE){ 
  
  ## (0) Default file/path:
  # file <- "test.txt"
  
  # (1) Path to file:
  if (!is.na(file) && (file != "")){
    
    # (a) File path: Remove leading "." and/or "/" characters:
    if (substr(file, 1, 1) == ".") {file <- substr(file, 2, nchar(file))}
    if (substr(file, 1, 1) == "/") {file <- substr(file, 2, nchar(file))}
    # ToDo: Use regex to do this more efficiently!
    
    cur_file <- here::here(file)  # absolute path to text file
    
  } else {  # no file path given:
    
    cur_file <- ""  # use "" (to scan from Console)
    
  }
  
  # (2) Read txt: 
  # txt <- readLines(con = cur_file)                # (a) read from file
  txt <- scan(file = cur_file, what = "character",  # (b) from file or user console
              sep = "\n",     # i.e., keep " " as a space!     
              quiet = FALSE   # provide user feedback? 
  )
  # writeLines(txt)  # debugging
  
  # (3) Initialize lengths and a counter:
  n_lines <- length(txt)
  n_chars <- sum(nchar(txt))
  ct <- 0  # initialize character counter
  
  # (4) Data structure (for results): 
  # # Initialize a matrix (to store all characters in place):
  # m <- matrix(data = NA, nrow = n_lines, ncol = max(nchar(txt)))
  
  # # Initialize a tibble (to store all characters as rows):
  # # options(warn = -1) # ignore all warnings
  # tb <- tibble::tibble(x = rep(NA, n_chars),
  #                      y = rep(NA, n_chars),
  #                      char = rep("", n_chars))
  
  # # Initialize a data frame (to store all characters as rows):  
  # tb <- data.frame(x = rep(NA, n_chars),
  #                  y = rep(NA, n_chars),
  #                  c = rep("", n_chars))
  
  # Initialize 3 vectors:
  x <- rep(NA, n_chars)
  y <- rep(NA, n_chars)
  char <- rep("", n_chars)
  
  # (5a) Loop through all i lines of txt:  
  for (i in 1:n_lines){ 
    
    line <- txt[i]  # i-th line of txt
    
    # (5b) Loop through each char j of each line:
    for (j in 1:nchar(line)) { 
      
      cur_char <- substr(line, j, j)  # current char      
      ct <- ct + 1  # increase count of current char 
      
      # fill count-th row of tb:
      # tb$x[ct] <- j               # x: current pos nr
      x[ct] <- j                    # x: current pos nr
      
      if (flip_y){ # flip y values:    # y: 
        # tb$y[ct] <- n_lines - (i - 1)  # 1st line on top (of n_lines)  
        y[ct] <- n_lines - (i - 1)  # 1st line on top (of n_lines)  
      } else {
        # tb$y[ct] <- i             # current line 
        y[ct] <- i                  # current line 
      }
      
      # tb$char[ct] <- cur_char     # char: cur_char
      char[ct] <- cur_char          # char: cur_char
      
    } # for j.
  } # for i.
  
  # (6) Check that ct matches n_chars:
  if (ct != n_chars){
    message("read_ascii: Count ct differs from n_chars!")
  }
  
  # # (7) Adjust data types:
  # tb$x <- as.integer(tb$x)
  # tb$y <- as.integer(tb$y)
  # tb$char <- as.character(tb$char)  
  
  # options(warn = 0)  # back to default
  
  # # Initialize a data frame (to store all characters as rows):  
  # df <- data.frame(x, y, char)
  tb <- tibble::tibble(x, y, char)
  
  # (8) Return: 
  return(tb)
  
} # read_ascii.

# ## Check: 
# # Create a temporary file "test.txt":
# cat("Hello world!",
#     "This is a test.",
#     "Can you see this text?", 
#     "Good! Please carry on...",
#     file = "test.txt", sep = "\n")
# read_ascii("test.txt")
# plot_txt("test.txt")
#
# unlink("test.txt")  # clean up (by deleting file).

# # (2) Read other text files: 
# read_ascii("./data-raw/txt/ascii.txt")  # Note: "\" became "\\"
# read_ascii("./data-raw/txt/ascii.txt", flip_y = TRUE)
# 
# read_ascii("./data-raw/txt/ascii2.txt")
# 
# t <- read_ascii("./data-raw/txt/hello.txt")
# t
# tail(t)

# (3) Read user input from console:
# read_ascii()


## count_char: Count the frequency of characters in a string: -------- 

#' count_char counts the frequency of characters 
#' in a string of text \code{s}.
#'
#' @param s String of text (required).
#' 
#' @param case_sense Boolean: Distinguish lower- vs. uppercase characters? 
#' Default: \code{case_sense = TRUE}. 
#' 
#' @param rm_specials Boolean: Remove special characters? 
#' Default: \code{rm_specials = TRUE}. 
#' 
#' @param sort_freq Boolean: Sort output by character frequency? 
#' Default: \code{sort_freq = TRUE}. 
#' 
#' @examples
#' # Default: 
#' s <- c("Hello!", "This is a 1st sentence.", "This is the 2nd sentence.", "The end.")
#' count_char(s)
#' 
#' # Options: 
#' count_char(s, case_sense = FALSE)
#' count_char(s, rm_specials = FALSE)
#' count_char(s, sort_freq = FALSE)
#'  
#' @family text functions
#'
#' @seealso
#' \code{\link{plot_text}} for a corresponding plot function. 
#' 
#' @export

count_char <- function(s, # string of text to count
                       case_sense = TRUE, 
                       rm_specials = TRUE, 
                       sort_freq = TRUE
){
  
  freq <- NA  # initialize
  
  v0 <- as.character(s)  # read input (as character)
  
  if (case_sense){
    v1 <- v0  # as is
  } else {
    v1 <- tolower(v0)  # lowercase
  }
  
  v2 <- paste(v1, collapse = "")  # combine all into 1 string
  v3 <- strsplit(v2, split = "")  # individual characters (in 1 list)
  v4 <- unlist(v3)  # individual characters (in vector)
  
  if (rm_specials){
    
    # Define special char: 
    space <- c("", " ")
    hyphens <- c("-", "--", "---")
    punct <- c(",", ";", ":", ".", "!", "?")  # punctuation 
    spec_char <- c(punct, space, hyphens)
    
    # Remove special characters:
    char_s <- v4[!(v4 %in% spec_char)]
    
  } else {
    
    char_s <- v4  # as is 
    
  }
  
  if (sort_freq){
    
    freq <- sort(table(char_s), decreasing = TRUE)
    
  } else { # no sorting:
    
    freq <- table(char_s)    
    
  } # if (sort_freq).
  
  return(freq)
  
} # count_char. 

# ## Check:
# s <- c("Hello!", "This is a 1st sentence.", "This is the 2nd sentence.", "The end.")
# 
# count_char(s)
# count_char(s, case_sense = FALSE)
# count_char(s, rm_specials = FALSE)
# count_char(s, sort_freq = FALSE)
# 
# # Note: count_char returns a named vector of type integer:
# freq <- count_char(s)
# typeof(freq)
# freq["e"]



## ToDo: ----------

# - improve read_ascii (with regex and more efficient text wrangling)

## eof. ----------------------