## text_fun.R | ds4psy
## hn | uni.kn | 2020 05 20
## ---------------------------

## Character objects and functions for string/text objects. 

## (0) Define character vectors and strings of text: ---------- 


## Umlaute / German umlauts: ------ 

# Sources: For Unicode characters, see:
# <https://home.unicode.org/>
# <https://www.unicode.org/charts/>
# <https://en.wikipedia.org/wiki/List_of_Unicode_characters>

uml_a <- "\U00E4"  # ä
uml_o <- "\U00F6"  # ö
uml_u <- "\U00FC"  # ü

uml_A <- "\U00C4"  # Ä
uml_O <- "\U00D6"  # Ö
uml_U <- "\U00DC"  # Ü

uml_s <- "\u00DF"  # ß

# As named vector:
umlaut <- c(uml_a, uml_o, uml_u, 
            uml_A, uml_O, uml_U,
            uml_s)
names(umlaut) <- c("a", "o", "u", 
                   "A", "O", "U",
                   "s") 

## Check:
# umlaut
# names(umlaut)

# paste(umlaut, collapse = " ")
# paste0("Hansj", umlaut["o"], "rg i", umlaut["s"], "t gern s", umlaut["u"], "sse ", umlaut["A"], "pfel.")


#' Umlaut provides German Umlaut letters (as Unicode characters). 
#' 
#' \code{Umlaut} provides the German Umlaut letters (aka. diaeresis/diacritic) 
#' as a named character vector. 
#' 
#' For Unicode details, see 
#' \url{https://home.unicode.org/}, 
#  \url{https://www.unicode.org/charts/}, and 
#  \url{https://en.wikipedia.org/wiki/List_of_Unicode_characters}. 
#' 
#' For details on German Umlaut letters (aka. diaeresis/diacritic), see 
#' \url{https://en.wikipedia.org/wiki/Diaeresis_(diacritic)} and 
#' \url{https://en.wikipedia.org/wiki/Germanic_umlaut}. 
#' 
#' @examples
#' Umlaut
#' names(Umlaut)
#' 
#' paste0("Hansj", Umlaut["o"], "rg i", Umlaut["s"], "t s", Umlaut["u"], "sse ", Umlaut["A"], "pfel.")
#' paste0("Das d", Umlaut["u"], "nne M", Umlaut["a"], "dchen l", Umlaut["a"], "chelt.")
#' paste0("Der b", Umlaut["o"], "se Mann macht ", Umlaut["u"], "blen ", Umlaut["A"], "rger.")
#' paste0("Das ", Umlaut["U"], "ber-Ich ist ", Umlaut["a"], "rgerlich.")
#' 
#' @family text objects and functions
#' 
#' @export

Umlaut <- umlaut 

## Check:
# Umlaut
# names(Umlaut)

## Apply:
# paste(Umlaut, collapse = " ")
# paste0("Hansj", Umlaut["o"], "rg i", Umlaut["s"], "t gern s", Umlaut["u"], "sse ", Umlaut["A"], "pfel.")
# paste0("Das d", Umlaut["u"], "nne M", Umlaut["a"], "dchen l", Umlaut["a"], "chelt sch", Umlaut["o"], "n.")
# paste0("Der b", Umlaut["o"], "se Mann macht ", Umlaut["u"], "blen ", Umlaut["A"], "rger.")



## Metachar: Metacharacters of extended regular expressions (in R): ------ 

# metachar provides the metacharacters of extended regular expressions (as a character vector)
# See documentation to ?regex 

metas <- c(". \ | ( ) [ { ^ $ * + ?")

# as vector:
mv <- unlist(strsplit(metas, split = " "))
# mv

mv[2] <- "\\"  # correction for \
# mv

## Check:
# writeLines(mv)
# nchar(paste0(mv, collapse = ""))  # 12


#' metachar provides R metacharacters 
#' (as a character vector). 
#' 
#' \code{metachar} provides the metacharacters of extended regular expressions 
#' (as a character vector).
#' 
#' See \code{?regex} for details. 
#' 
#' @examples
#' metachar
#' length(metachar)  # 12
#' nchar(paste0(metachar, collapse = ""))  # 12
#' 
#' @family text objects and functions
#' 
#' @export

metachar <- mv

# ## Check:
# metachar
# length(metachar)  # 12
# nchar(paste0(metachar, collapse = ""))  # 12
# # writeLines(metachar)


## Other text elements (for ds4psy course materials): ------ 

# course_title     <- paste0("Data science for psychologists")
# course_title_abb <- paste0("ds4psy")
# # psi <- expression(psi)
# name_hn <- "Hansjoerg Neth"
# name_course <- paste0(course_title, " (", course_title_abb, "), by ", name_hn, "")

# # Table of contents (ToC):
# toc <- tibble::tribble(
#   ~nr, ~lbl,                 ~val,  ~part,   
#    0,  "Introduction",          2,  0,
#    1,  "R basics",             10,  0, # was: "Basic R concepts and commands",
#    2,  "Visualizing data",      8,  1, 
#    3,  "Transforming data",     9,  1, 
#    4,  "Exploring data",       10,  1, # was: "Exploring data (EDA)"
#    5,  "Tibbles",               6,  2, 
#    6,  "Importing data",        5,  2,  
#    7,  "Tidying data",          7,  2,  
#    8,  "Joining data",          6,  2,  
#    9,  "Text data",             8,  2, 
#   10,  "Time data",             6,  2,   
#   11,  "Functions",            10,  3, 
#   12,  "Iteration",             8,  3)
# 
# # toc  # used in plot_tbar() and plot_tclock()


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
#' into other characters (typically symbols) to mimic 
#' leet/l33t slang (as a named character vector).
#' 
#' Old (i.e., to be replaced) characters are 
#' \code{paste(names(l33t_rul35), collapse = "")}.
#' 
#' New (i.e., replaced) characters are 
#' \code{paste(l33t_rul35, collapse = "")}.
#' 
#' See \url{https://en.wikipedia.org/wiki/Leet} for details. 
#' 
#' @family text objects and functions
#' 
#' @export

l33t_rul35 <- c(l33t_num, my_l33t)

## Check: 
# l33t_rul35

## transl33t function: ------ 

## (a) Test:
# stringr::str_replace_all(txt, l33t_rul35)

## (b) as function: 

#' transl33t text into leet slang.
#'
#' \code{transl33t} translates text into leet (or l33t) slang 
#' given a set of rules.
#' 
#' The current version of \code{transl33t} only uses \code{base R} commands, 
#' rather than the \bold{stringr} package.
#' 
#' @param txt The text (character string) to translate.
#' 
#' @param rules Rules which existing character in \code{txt} 
#' is to be replaced by which new character (as a named character vector). 
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
#'           rules = c("e" = "3", "l" = "1", "o" = "0"))  # e only capitalized
#' transl33t(txt = "hEllo world", in_case = "lo", out_case = "up", 
#'           rules = c("e" = "3", "l" = "1", "o" = "0"))  # e transl33ted
#' 
#' @family text objects and functions
#'
#' @seealso
#' \code{\link{l33t_rul35}} for default rules. 
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
  
  ## (a) using stringr pkg: 
  # out <- stringr::str_replace_all(txt, rules)
  ## If used, ADD:  
  ## @importFrom stringr str_replace_all
  ## to documentation!
  
  # (b) only base R commands:
  old_chars <- paste(names(rules), collapse = "")
  new_chars <- paste(rules, collapse = "")
  out <- chartr(old_chars, new_chars, x = txt)
  
  # handle out_case: 
  if (out_case == "lo") {
    out <- tolower(out)
  } else  if (out_case == "up") {
    out <- toupper(out)
  }
  
  return(out)
  
} # transl33t. 

# ## Check:
# transl33t(txt1)  # default rules
# transl33t(txt1, rules = c("a" = "4"))  # manual rules
# 
# # multiple strings:
# transl33t(txt = c(letters, LETTERS))
# transl33t(txt = c(txt1, txt2))
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

#' read_ascii parses text (from a file) into a table. 
#'
#' \code{read_ascii} parses text 
#' (from a file or from user input in Console) 
#' into a table that contains a row for each character. 
#' 
#' \code{read_ascii} creates a data frame with 3 variables: 
#' Each character's \code{x}- and \code{y}-coordinates (from top to bottom)  
#' and a variable \code{char} for the character at this coordinate. 
#' 
#' The \code{getwd} function is used to determine the current 
#' working directory. This replaces the \bold{here} package, 
#' which was previously used to determine an (absolute) file path. 
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
#' ## Create a temporary file "test.txt":
#' # cat("Hello world!", "This is a test.", 
#' #     "Can you see this text?", 
#' #     "Good! Please carry on...", 
#' #     file = "test.txt", sep = "\n")
#' 
#' ## (a) Read text (from file): 
#' # read_ascii("test.txt")
#' # read_ascii("test.txt", flip_y = TRUE)  # y flipped
#' 
#' # unlink("test.txt")  # clean up (by deleting file).
#'  
#' \donttest{
#' ## (b) Read text (from file in subdir):
#' # read_ascii("data-raw/txt/ascii.txt")  # requires txt file
#' 
#' ## (c) Scan user input (from console):
#' # read_ascii()
#' }
#' 
#' @family text objects and functions
#'
#' @seealso
#' \code{\link{plot_text}} for a corresponding plot function. 
#' 
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
    
    ## (a) using the here package: 
    # cur_file <- here::here(file)  # absolute path to text file
    
    # (b) using getwd() instead:
    cur_wd   <- getwd()
    cur_file <- paste0(cur_wd, "/", file) 
    
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
  
  # # Initialize a table (to store all characters as rows):  
  # # (a) as tibble:
  # tb <- tibble::tibble(x, y, char)
  
  # (b) as data frame: 
  tb <- data.frame(x, y, char,
                   stringsAsFactors = FALSE)
  
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


# (3) Read user input from console: ---------- 
# read_ascii()


## count_char: Count the frequency of characters in a string: -------- 

#' count_char counts the frequency of characters 
#' in a string of text \code{x}.
#'
#' @param x A string of text (required).
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
#' x <- c("Hello!", "This is a 1st sentence.", "This is the 2nd sentence.", "The end.")
#' count_char(x)
#' 
#' # Options: 
#' count_char(x, case_sense = FALSE)
#' count_char(x, rm_specials = FALSE)
#' count_char(x, sort_freq = FALSE)
#'  
#' @family text objects and functions
#'
#' @seealso
#' \code{\link{count_word}} for counting the frequency of words;   
#' \code{\link{plot_text}} for a corresponding plot function. 
#' 
#' @export

count_char <- function(x, # string of text to count
                       case_sense = TRUE, 
                       rm_specials = TRUE, 
                       sort_freq = TRUE
){
  
  freq <- NA  # initialize
  
  v0 <- as.character(x)  # read input (as character)
  
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
    parents <- c("(", ")", "[", "]", "{", "}", "<", ">")  # parentheses
    spec_char <- c(punct, space, hyphens, parents)
    
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
# x <- c("Hello!", "This is a 1st sentence.", "This is the 2nd sentence.", "The end.")
# 
# count_char(x)
# count_char(x, case_sense = FALSE)
# count_char(x, rm_specials = FALSE)
# count_char(x, sort_freq = FALSE)
# 
# # Note: count_char returns a named vector of type integer:
# freq <- count_char(x)
# typeof(freq)
# freq["e"]


## Text helper functions: ------- 

## text_to_sentences: Turn a text (consisting of one or more strings) into a vector of all its sentences: ------ 

#' text_to_sentences turns a string of text \code{x} 
#' (consisting of one or more character strings) 
#' into a vector of its sentences. 
#' 
#' text_to_sentences removes all (standard) punctuation marks and empty spaces 
#' and returns a vector of all remaining character sequences  
#' (as the sentences).
#'
#' @param x A string of text (required).
#' 
#' @examples
#' # Default: 
#' x <- c("Hello!", "This is a 1st sentence.  Is this a question?", " The end.")
#' text_to_sentences(x)
#' 
#' @family text objects and functions
#'
#' @seealso
#' \code{\link{text_to_words}} for turning text into a vector of words. 
#' 
#' @export

text_to_sentences <- function(x){
  
  s <- NA
  
  # Paste all into one string:
  x1 <- paste(x, collapse = "")
  
  # Split at SENTENCE punctuation:
  x2 <- unlist(strsplit(x1, split = "\\.|\\?|!"))
  
  # Remove empty LEADING spaces:
  x3 <- unlist(strsplit(x2, split = "^( ){1,}"))
  
  # Remove all instances of "":
  s <- x3[x3 != ""]
  
  return(s)
  
}

# ## Check:
# s3 <- c("A first sentence.  The second sentence?",
#         "A third --- and also the final --- sentence.")
# text_to_sentences(s3)


## text_to_words: Turn a text (consisting of one or more strings) into a vector of all its words: ------ 

#' text_to_words turns a string of text \code{x} 
#' (consisting of one or more character strings) 
#' into a vector of its words.
#' 
#' text_to_words first removes all punctuation and empty spaces 
#' and returns a vector of all remaining character symbols 
#' (as the words).
#'
#' @param x A string of text (required).
#' 
#' @examples
#' # Default: 
#' x <- c("Hello!", "This is a 1st sentence.", "This is the 2nd sentence.", "The end.")
#' text_to_words(x)
#' 
#' @family text objects and functions
#'
#' @seealso
#' \code{\link{count_word}} for counting the frequency of words. 
#' 
#' @export

text_to_words <- function(x){
  
  w <- NA
  
  # Remove punctuation:
  x2 <- unlist(strsplit(x, split = "[[:punct:]]"))
  
  # Remove empty space:
  x3 <- unlist(strsplit(x2, split = "( ){1,}"))
  
  # Remove all instances of "":
  w <- x3[x3 != ""]
  
  return(w)
  
}

# ## Check:
# s3 <- c("A first sentence.", "The second sentence.", 
#         "A third --- and also the final --- sentence.")
# wv <- text_to_words(s3)
# wv

## words_to_text: Turn a vector of words into a (single) vector: ------ 

words_to_text <- function(w, collapse = " "){
  
  paste(w, collapse = collapse)
  
}

## Check:
# words_to_text(wv)


## count_word: Count the frequency of words in a string: -------- 

#' count_word counts the frequency of words  
#' in a string of text \code{x}.
#'
#' @param x A string of text (required).
#' 
#' @param case_sense Boolean: Distinguish lower- vs. uppercase characters? 
#' Default: \code{case_sense = TRUE}. 
#' 
#' @param sort_freq Boolean: Sort output by word frequency? 
#' Default: \code{sort_freq = TRUE}. 
#' 
#' @examples
#' # Default: 
#' s3 <- c("A first sentence.", "The second sentence.", 
#'         "A third --- and also the final --- sentence.")
#' count_word(s3)  # case-sensitive, sorts by frequency 
#' 
#' # Options: 
#' count_word(s3, case_sense = FALSE)  # case insensitive
#' count_word(s3, sort_freq = FALSE)   # sorts alphabetically
#'  
#' @family text objects and functions
#'
#' @seealso
#' \code{\link{count_char}} for counting the frequency of characters;   
#' \code{\link{plot_text}} for a corresponding plot function. 
#' 
#' @export

count_word <- function(x,  # string of text to count
                       case_sense = TRUE, 
                       sort_freq = TRUE
){
  
  freq <- NA  # initialize
  
  v0 <- as.character(x)  # read input (as character)
  
  if (case_sense){
    v1 <- v0  # as is
  } else {
    v1 <- tolower(v0)  # lowercase
  }
  
  # Split input into a vector of all its words:
  w <- text_to_words(v1)
  
  if (sort_freq){
    
    freq <- sort(table(w), decreasing = TRUE)
    
  } else { # no sorting:
    
    freq <- table(w)    
    
  } # if (sort_freq).
  
  return(freq)
  
} # count_word end.


# ## Check:
# s3 <- c("A first sentence.", "The second sentence.", 
#         "A third --- and also the final --- sentence.")
# 
# count_word(s3)                      # case-sens, sorts by frequency 
# count_word(s3, case_sense = FALSE)  # case insensitive
# count_word(s3, sort_freq = FALSE)   # sorts alphabetically


# (4) Capitalization ---------- 

## caseflip: Flip lower to upper case and vice versa: --------  

#' caseflip flips the case of characters 
#' in a string of text \code{x}.
#'
#' @param x A string of text (required).
#' 
#' @examples
#' x <- c("Hello world!", "This is a 1st sentence.", "This is the 2nd sentence.", "The end.")
#' caseflip(x)
#'  
#' @family text objects and functions
#'
#' @seealso
#' \code{\link{capitalize}} for converting the case of initial letters. 
#' 
#' @export

caseflip <- function(x){
  
  out <- NA  # initialize  
  
  # Rules: 
  from <- paste0(c(letters, LETTERS), collapse = "")
  to   <- paste0(c(LETTERS, letters), collapse = "")  
  
  out <- chartr(old = from, new = to, x = x)
  
  return(out)
  
}

## Check:
# caseflip("Hello World! Hope all is well?")
# caseflip(c("Hi there", "Does this work as well?"))
# caseflip(NA)



## capitalize the first n letters of words (w/o exception): -------- 

#' capitalize converts the case of 
#' each word's \code{n} initial characters 
#' (typically to \code{upper}) 
#' in a string of text \code{x}.
#'
#' @param x A string of text (required).
#' 
#' @param n Number of initial characters to convert.
#' Default: \code{n = 1}. 
#' 
#' @param upper Convert to uppercase?
#' Default: \code{upper = TRUE}. 
#' 
#' @param as_text Return word vector as text 
#' (i.e., one character string)? 
#' Default: \code{as_text = TRUE}.
#' 
#' @examples
#' x <- c("Hello world! This is a 1st TEST sentence. The end.")
#' capitalize(x)
#' capitalize(x, n = 3)
#' capitalize(x, n = 2, upper = FALSE)
#' capitalize(x, as_text = FALSE)
#' 
#' # Note: A vector of character strings returns the same results: 
#' x <- c("Hello world!", "This is a 1st TEST sentence.", "The end.")
#' capitalize(x)
#' capitalize(x, n = 3)
#' capitalize(x, n = 2, upper = FALSE)
#' capitalize(x, as_text = FALSE)
#' 
#' @family text objects and functions
#'
#' @seealso
#' \code{\link{caseflip}} for converting the case of all letters. 
#' 
#' @export

capitalize <- function(x, # string of text to capitalize
                       n = 1,  # number of initial letters to capitalize in each word
                       upper = TRUE,   # convert to uppercase?
                       as_text = TRUE  # return words as text (1 character string)? 
                       # except = c("a", "the", "is", "do", "does", "done", "did")
                       # rm_specials = TRUE
){
  
  out <- NA  # initialize 
  
  # (1) Convert text x to vector of words:
  words <- text_to_words(x)
  
  # (2) Capitalize words:
  first <- substr(words, 1, n)      # first character of each word 
  rest  <- substr(words, n + 1, nchar(words))  # rest of each word
  rest  <- substring(words, n + 1)  # rest of each word (with default end)
  
  if (upper) {
    Words <- paste0(toupper(first), rest) # capitalize first and paste with rest
  } else {
    Words <- paste0(tolower(first), rest) # lowercase first and paste with rest
  }
  
  # (3) Convert vector of Words to text x:
  if (as_text){
    out <- words_to_text(Words)
  } else {
    out <- Words
  }
  
  return(out)
  
}

# ## Check:
# x <- c("Hello world! This is a 1st TEST sentence. The end.")
# capitalize(x)
# capitalize(x, n = 3)
# capitalize(x, n = 2, upper = FALSE)
# capitalize(x, as_text = FALSE)
# 
# # Note: Vector of character strings is merged into one string:
# x <- c("Hello world!", "This is a 1st TEST sentence.", "The end.")
# capitalize(x)
# capitalize(x, n = 3)
# capitalize(x, n = 2, upper = FALSE)
# capitalize(x, as_text = FALSE)





## count_str: count the number of occurrences of a pattern in a character vector x: -------- 

# Source of function: 
# <https://aurelienmadouasse.wordpress.com/2012/05/24/r-code-how-the-to-count-the-number-of-occurrences-of-a-substring-within-a-string/> 

# count_str_org <- function(x, pattern, split){
#   
#   unlist(
#     lapply(strsplit(x, split), 
#            function(z) stats::na.omit(length(grep(pattern, z)))
#     ))
#   
# }


# Count the number of pattern matches in a string: 

count_str <- function(x, pattern, split = ""){
  
  # initialize: 
  count   <- NA
  x_split <- NA
  
  x_split <- strsplit(x, split)
  
  # count <- unlist(lapply(x_split, function(z) stats::na.omit(length(grep(pattern = pattern, x = z, value = FALSE)))))
  
  count <- unlist(lapply(x_split, function(z) length(grep(pattern = pattern, x = z, value = FALSE))))
  
  return(count)
  
}

# ## Check:
# x <- c("hello", "world!", "This is a test sentence.", "", "The end.")
# p <- "en"
# 
# # splitting:
# x_split <- strsplit(x, split = NA)  # leaves x as is
# x_split
# 
# x_split <- strsplit(x, split = "")  # splits x into individual characters
# x_split
# 
# # grep:
# grep(pattern = p, x = x_split)
# 
# # Compare: 
# count_str(x, p)              # number within each character object
# count_str(x, p, split = NA)  # only 0 vs. 1 per character object
# 
# # Contrast with:
# stringr::str_count(x, p)     # number within each character object

# Conclusion:
# count_str*() is not reliable, as grep() only contrasts matches with non-matches (binary) and 
#              results thus depend on the segmentation of strings (into sub-strings). 
# By contrast, stringr::count_str() provides a the exact frequency counts 
# (i.e., how often a pattern is matched.)


# Longer example from
# <https://aurelienmadouasse.wordpress.com/2012/05/24/r-code-how-the-to-count-the-number-of-occurrences-of-a-substring-within-a-string/>:  

# txt <- "The message is that there are no knowns. 
# There are things we know that we know. 
# There are known unknowns. 
# That is to say there are things that we now know we don't know. 
# But there are also unknown unknowns. 
# There are things we do not know we don't know. 
# So when we do the best we can and we pull all this information together, and we then say well that's basically what we see as the situation, that is really only the known knowns and the known unknowns. 
# And each year, we discover a few more of those unknown unknowns."
# 
# count_str(tolower(txt), "know",    " ")   # 17
# count_str(tolower(txt), "^known",  " ")   #  5
# count_str(tolower(txt), "unknown", " ")   #  6
# 
# # Source: <https://en.wikipedia.org/wiki/There_are_known_knowns>
# # From: Donald Rumsfeld, United States Secretary of Defense, at a U.S. Department of Defense (DoD) news briefing on February 12, 2002:
# 
# kk <- "Reports that say that something hasn't happened are always interesting to me, 
# because as we know, there are known knowns; 
# there are things we know we know. 
# We also know there are known unknowns; 
# that is to say we know there are some things we do not know. 
# But there are also unknown unknowns -- the ones we don't know we don't know. 
# And if one looks throughout the history of our country and other free countries, 
# it is the latter category that tend to be the difficult ones."

# # Using count_str: 
# count_str(tolower(kk), "know",    " ")   # 14
# # contrast: 
# count_str(tolower(kk), "^know",  " ")    # 11
# count_str(tolower(kk), "^known",  " ")   #  3
# # and:
# count_str(tolower(kk), "unknown", " ")   #  3
# 
# # Contrast with:
# stringr::str_count(kk, "know")      # 14
# # contrast: 
# stringr::str_count(kk, "^know")     #  0 !
# stringr::str_count(kk, "^known")    #  0 !
# # but: 
# stringr::str_count(kk, " know")     # 11
# stringr::str_count(kk, " known")    #  3
# # and:
# stringr::str_count(kk, "unknown")   #  3


## ToDo: ----------

# - Add exception argument except to capitalize() function 
#   (to exclude all words matching an exception argument).
# - improve read_ascii (with regex and more efficient text wrangling)

## eof. ----------------------