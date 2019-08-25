## text_fun.R | ds4psy
## hn | uni.kn | 2019 08 25
## ---------------------------

## Functions for text and string objects. 

## (0) Define text labels: ---------- 

course_title     <- paste0("Data science for psychologists")
course_title_abb <- paste0("ds4psy")
# psi <- expression(psi)
name_hn <- "Hansjoerg Neth"
name_course <- paste0(course_title, " (", course_title_abb, "), by ", name_hn, "")
# name_course

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
#' \code{read_ascii} parses text (from a file) into 
#' a tibble that contains a row for each character. 
#' This tibble contains 3 variables: 
#' The character's \code{x}- and \code{y}-coordinates (from top to bottom)  
#' and a variable \code{char} for the character at this coordinate. 
#' 
#' The \bold{here} package is used to determine 
#' the (absolute) file path. 
#' 
#' @param file The text file to read (or its path).  
#' If the text file is stored in a sub-directory, 
#' enter its path and name here (without any leading or 
#' trailing "." or "/"). 
#' Default: \code{file = "txt/ascii.txt"}. 
#' 
#' @param flip_y Boolean: Should y-coordinates be flipped, 
#' so that the lowest line in the text file becomes \code{y = 1}, 
#' and the top line in the text file becomes \code{y = n_lines}? 
#' Default: \code{flip_y = FALSE}. 
#' 
#' @examples
#' read_ascii("txt/ascii.txt")  # requires txt file
#' read_ascii("txt/ascii.txt", flip_y = TRUE)
#' 
#' @family text functions
#'
#' @seealso
#' corresponding plot function
#' 
#' @import here
#' @import tibble
#' 
#' @export

read_ascii <- function(file = "txt/ascii.txt", flip_y = FALSE){ 
  
  ## (0) Default file/path:
  # file <- "txt/ascii.txt"
  
  # (1) File path: Remove leading "." and/or "/" characters:
  if (substr(file, 1, 1) == ".") { file <- substr(file, 2, nchar(file))}
  if (substr(file, 1, 1) == "/") { file <- substr(file, 2, nchar(file))}
  # ToDo: Use regex to do this more efficiently!
  
  path2file <- here::here(file)  # absolute path to text file
  
  # (2) Read txt: 
  txt <- readLines(path2file)
  # writeLines(txt)  # debugging
  
  # (3) Initialize lengths and a counter:
  n_lines <- length(txt)
  n_chars <- sum(nchar(txt))
  ct <- 0  # initialize character counter
  
  # (4) Data structure (for results): 
  # # initialize a matrix (to store all characters in place):
  # m <- matrix(data = NA, nrow = n_lines, ncol = max(nchar(txt)))
  
  # initialize a tibble (to store all characters as rows):
  tb <- tibble::tibble(x = rep(NA, n_chars),
                       y = rep(NA, n_chars),
                       char = rep("", n_chars))
  
  # # initialize a data frame (to store all characters as rows):  
  # df <- data.frame(x = rep(NA, n_chars),
  #                  y = rep(NA, n_chars),
  #                  c = rep("", n_chars))
  
  # (5a) Loop through all y lines of txt:  
  for (y in 1:n_lines){ 
    
    line <- txt[y]  # y-th line of txt
    
    # (5b) Loop through each char x of each line:
    for (x in 1:nchar(line)) { 
      
      cur_char <- substr(line, x, x)  # current char      
      ct <- ct + 1  # increase count of current char 
      
      # fill count-th row of tb:
      tb$x[ct] <- x                    # x: current pos nr
      
      if (flip_y){ # flip y values:    # y: 
        tb$y[ct] <- n_lines - (y - 1)  # 1st line on top (of n_lines)  
      } else {
        tb$y[ct] <- y                  # current line 
      }
      
      tb$char[ct] <- cur_char          # char: cur_char
      
    } # for x.
    
  } # for y.
  
  # (6) Check that ct matches n_chars:
  if (ct != n_chars){
    message("read_ascii: Count ct differs from n_chars!")
  }
  
  # (7) Adjust data types:
  tb$x <- as.integer(tb$x)
  tb$y <- as.integer(tb$y)
  tb$char <- as.character(tb$char)  
  
  # (8) Return tb: 
  return(tb)
  
} # read_ascii.

## Check: 
# read_ascii("./txt/ascii.txt")  # Note: "\" became "\\"
# read_ascii("./txt/ascii.txt", flip_y = TRUE)
# 
# read_ascii("./txt/ascii2.txt")  
# 
# t <- read_ascii("./txt/hello.txt")
# t
# tail(t)

## ToDo: ----------

# - improve read_ascii (with regex and more efficient text wrangling)

## eof. ----------------------