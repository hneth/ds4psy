## text_fun.R | ds4psy
## hn | uni.kn | 2021 04 19
## ---------------------------

## Character objects and functions for string/text objects. 


## (0) Define character vectors and strings of text: ---------- 


## Umlaute / German umlauts: ------ 

# Sources: For Unicode characters, see:
# <https://home.unicode.org/>
# <https://www.unicode.org/charts/>
# <https://en.wikipedia.org/wiki/List_of_Unicode_characters>

uml_a <- "\u00E4"  # ä
uml_o <- "\u00F6"  # ö
uml_u <- "\u00FC"  # ü

uml_A <- "\u00C4"  # Ä
uml_O <- "\u00D6"  # Ö
uml_U <- "\u00DC"  # Ü

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



## metachar: Meta-characters of extended regular expressions (in R): ------ 

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
#' \code{metachar} allows illustrating the notion of 
#' meta-characters in regular expressions 
#' (and provides corresponding exemplars). 
#' 
#' See \code{?base::regex} for details. 
#' 
#' @examples
#' metachar
#' length(metachar)  # 12
#' nchar(paste0(metachar, collapse = ""))  # 12
#' 
#' @family text objects and functions
#' 
#' @seealso
#' \code{\link{cclass}} for a vector of character classes. 
#' 
#' @export

metachar <- mv

# ## Check:
# metachar
# length(metachar)  # 12
# nchar(paste0(metachar, collapse = ""))  # 12
# # writeLines(metachar)



## cclass: A (named) vector of different character classes (in R): ------ 

# letters:
ltr <- paste(letters, collapse = "")  # lowercase
LTR <- paste(LETTERS, collapse = "")  # uppercase

# digits: "0 1 2 3 4 5 6 7 8 9"
dig <- paste(0:9, collapse = "")
# hex: "0 1 2 3 4 5 6 7 8 9 A B C D E F a b c d e f"
hex <- paste(c(0:9, LETTERS[1:6], letters[1:6]), collapse = "")

# punctuation:
# pun <- "! # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \\ ] ^ _ ` { | } ~"  # with space
pun <- "!#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"  # w/o space

# spaces (4 different kinds):
sp1 <- " "   # space
sp2 <- "\t"  # tab
sp3 <- "\n"  # new line
sp4 <- "\r"  # return
# spc <- paste(sp1, sp2, sp3, sp4, collapse = " ")  # with space
spc <- paste(sp1, sp2, sp3, sp4, collapse = "")  # w/o space

# Combine (to ccv):
ccv <- c(ltr, LTR, dig, hex, pun, spc)
names(ccv) <- c("ltr", "LTR", "dig", "hex", "pun", "spc")

## Check: 
# ccv
# ccv["hex"]  # select by name
# writeLines(ccv["pun"])
# stringr::str_view(ccv, "\\.", match = TRUE)
# stringr::str_view(ccv, "\\\\", match = TRUE)
# stringr::str_view(ccv, "[:punct:]", match = TRUE)
# stringr::str_view(ccv, "[:space:]", match = TRUE)
# stringr::str_view(ccv, "[:blank:]", match = TRUE)
# stringr::str_view(ccv, "\t", match = TRUE)
# grep("\r", ccv, value = TRUE)

#' cclass provides character classes   
#' (as a named vector).
#' 
#' \code{cclass} provides different character classes  
#' (as a named character vector).
#' 
#' \code{cclass} allows illustrating matching 
#' character classes via regular expressions. 
#' 
#' See \code{?base::regex} for details. 
#' 
#' @examples
#' cclass["hex"]  # select by name
#' writeLines(cclass["pun"])
#' grep("[[:alpha:]]", cclass, value = TRUE)
#' 
#' @family text objects and functions
#' 
#' @seealso
#' \code{\link{metachar}} for a vector of metacharacters. 
#' 
#' @export

cclass <- ccv

## Check:
# cclass
# cclass["hex"]  # select by name
# writeLines(cclass["pun"])
# grep("[[:alpha:]]", cclass, value = TRUE)
# grep("[[:space:]]", cclass, value = TRUE)


## Other/specific text elements (for ds4psy course materials): ------ 

# course_title     <- paste0("Data science for psychologists")
# course_title_abb <- paste0("ds4psy")
# # psi <- expression(psi)
# name_hn <- "Hansjoerg Neth"
# name_course <- paste0(course_title, " (", course_title_abb, "), by ", name_hn, "")

# # Table of contents (ToC) [Spring 2020]: 
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
#    9,  "Text data",             9,  2, # increased value 
#   10,  "Time data",             8,  2, # increased value 
#   11,  "Functions",            10,  3, 
#   12,  "Iteration",             8,  3)
# 
# # toc  # used in plot_tbar() and plot_tclock()



## (1) Leet/l33t slang: ---------- 

## l33t ex4mpl35: ----

# n4me <- "h4n5j03Rg n3+h"     # e:3, a:4, s:5, o:0, t:+, r:R
# d5   <- "d4+4 5c13nc3"       # i:1 
# fp   <- "f0R p5ych0l0g15+5"
# course_l33t <- paste0(n4me, ":", " ", d5, " ", fp)


## l33t_rul35: leet rules: ----

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

#' l33t_rul35 provides rules for translating text 
#' into leet/l33t slang. 
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
#' @seealso
#' \code{\link{transl33t}} for a corresponding function. 
#' 
#' @export

l33t_rul35 <- c(l33t_num, my_l33t)

## Check: 
# l33t_rul35


## transl33t function: ----

## (a) Test:
# stringr::str_replace_all(txt, l33t_rul35)

## (b) as function: 

#' transl33t translates text into leet slang.
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
#' @return A character vector. 
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
#' \code{\link{l33t_rul35}} for default rules used. 
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
# txt1 <- "This is a short test string with some text to leetify."
# txt2 <- "Data science is both a craft and an art. This course introduces fundamental data types,
#          basic concepts and commands of the R programming language, and explores key packages of the so-called tidyverse.
#          Regular exercises will help you to make your first steps from R novice to user."

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




## (2) Read ascii text (from file) into a tibble: ---------- 

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
#' @return A data frame with 3 variables: 
#' Each character's \code{x}- and \code{y}-coordinates (from top to bottom)  
#' and a variable \code{char} for the character at this coordinate. 
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



## (3) Locating the positions and IDs of text strings matching a pattern: ---------- 


## locate_str: Locate pattern matches in a string of text ------ 

# locate_str locates all sub-strings matching a pattern in a string of text 
# and returns a data frame of their IDs and positions (start, end, len). 

# This is merely a more convenient version of gregexpr() 
# similar to stringr::str_locate(). 

locate_str <- function(pattern, text){
  
  # (1) Using gregexpr(): Locations of matches
  m_l <- gregexpr(pattern = pattern, text = text)  # LIST of matches
  
  m_start <- unlist(m_l)  # start positions of all matches
  
  if (m_start[1] == -1){  # NO matches were found:  
    return(NA)  # return early!
  } 
  
  # ELSE: matches were found:  
  
  # (2) Get match locations:  
  m_l_1 <- m_l[[1]]  # 1st element of list
  m_len <- attr(m_l_1, "match.length")  # len of all matches
  m_end <- m_start + m_len - 1  # end position of all matches
  
  # (3) Get match IDs:
  nr_match <- length(m_start)
  id_txt <- rep(NA, nr_match)
  
  for (i in 1:nr_match){
    id_txt[i] <- substr(x = text, start = m_start[i], stop = m_end[i])
  }
  
  # (4) Output: 
  df <- data.frame(id_txt, m_start, m_end, m_len)
  names(df) <- c("id", "start", "end", "len")
  
  return(df) 
  
} # locate_str(). 

## Check:
# s <- "This is a test that tests this function."
# locate_str("t|T", s)
# locate_str("t..t", s)
# locate_str("t.t", s)


## locate_str_logical: Variant of locate_str() that returns a logical vector ------ 

# - TRUE  for all matching locations (positions) in text
# - FALSE for all non-matching locations (positions) in text

locate_str_logical <- function(pattern, text){
  
  # Initialize:
  df  <- NA
  out <- rep(FALSE, nchar(text))  # initialize logical vector
  
  # Locate all matches of pattern in text:
  df <- locate_str(pattern = pattern, text = text)  # use util function (above)
  
  if (!all(is.na(df))){  # matches were found:
    
    # Set logical vector to TRUE for matches:
    for (i in 1:nrow(df)){  # for each match in df:
      
      out[df$start[i]:df$end[i]] <- TRUE  # identify matching positions
      
    }
    
  }
  
  # Return: 
  return(out)
  
} # locate_str_logical(). 

# ## Check:
# txt <- "This is a test that tests this function."
# locate_str_logical("t..t", txt)
# locate_str_logical("xyz", txt)
# 
# s_v <- unlist(strsplit(s, ""))  # as vector elements
# 
# # Apply logical string to s_v:
# s_v[locate_str_logical("t|T", txt)]
# s_v[locate_str_logical("t..t", txt)]
# s_v[locate_str_logical("t.t", txt)]


## color_map_match: Assign 2 colors to string positions based on matching a pattern ------ 

# Inputs: A text and pattern, and 2 color vectors (col_fg for matches vs. col_bg for non-matches)
# Return: A vector of colors (with length of nchar(text), i.e., for each char in text):
#         either col_fg for maching positions, OR col_bg for non-matching positions
# Note:   col_sample = TRUE randomizes color sequence WITHIN category (fg/bg). 

color_map_match <- function(text, pattern = "[^[:space:]]", 
                            col_fg = "black", col_bg = "white",
                            col_sample = FALSE){
  
  # Initialize:
  nr_char <- nchar(text)
  col_vec <- recycle_vec(col_bg, len = nr_char)  # recycle col_bg to len of nr_char!
  
  # Locate all matches of pattern in text (as a logical vector):
  logical_vec_matches <- locate_str_logical(pattern = pattern, text = text)
  
  # Recycle col_fg to number of matches:
  col_fg <- recycle_vec(col_fg, len = sum(logical_vec_matches))
  
  # Sample colors (within category only): 
  if (col_sample){
    # col_vec <- sample(col_vec) # destructive in iterative applications!
    col_fg  <- sample(col_fg)
  }
  
  # Change col_vec to col_fg (by applying logical vector):
  col_vec[logical_vec_matches] <- col_fg  
  
  # Return: 
  return(col_vec)
  
} # color_map_match(). 

# ## Check:
# s <- "This  is a test that tests..."
# color_map_match(s)
# color_map_match(s, "\\.")
# color_map_match(s, "test")
# color_map_match(s, " ")
# color_map_match(s, "t|T")
# color_map_match(s, "t..t")
# color_map_match(s, "t.t")
# 
# # Longer lengths of col_fg and col_bg:
# color_map_match(s, "test", col_fg = c("fore11", "fore22"))
# color_map_match(s, "test", col_bg = c("back11", "back22"))
#
# # Stack iterative color maps (always using previous ones as bg):
# cm_1 <- color_map_match(s, "[[:graph:]]", col_fg = "f_1", col_bg = c("b_1", "b_2"))
# cm_2 <- color_map_match(s, "test", col_fg = "f_2", col_bg = cm_1)
# cm_3 <- color_map_match(s, "t|T",  col_fg = "f_3", col_bg = cm_2)
# cm_3


## (4) Counting and converting text strings: ---------- 


## count_chars: Count the frequency of characters in a string: -------- 

#' Count the frequency of characters in a string of text \code{x}.
#' 
#' \code{count_chars} distinguishes and counts the characters in 
#' a character vector \code{x} and returns their frequency counts 
#' as a named numeric vector.
#' 
#' Arguments allow some options for case sensitivity, removing special 
#' characters, and sorting the output by frequency. Note that all these 
#' currently work without using regular expressions.
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
#' @return A named numeric vector. 
#'
#' @examples
#' # Default: 
#' x <- c("Hello!", "This is a 1st sentence.", "This is the 2nd sentence.", "The end.")
#' count_chars(x)
#' 
#' # Options: 
#' count_chars(x, case_sense = FALSE)
#' count_chars(x, rm_specials = FALSE)
#' count_chars(x, sort_freq = FALSE)
#'
#' @family text objects and functions
#'
#' @seealso
#' \code{\link{count_words}} for counting the frequency of words; 
#' \code{\link{plot_chars}} for a corresponding plot function. 
#' 
#' @export

count_chars <- function(x, # string of text to count
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
    
    # Define special chars: 
    space <- c("", " ")  # [[:space:]]
    hyphens <- c("-", "--", "---")
    punct <- c(",", ";", ":", ".", "!", "?")  # punctuation [[:punct:]]  
    parents <- c("(", ")", "[", "]", "{", "}", "<", ">")  # parentheses
    spec_char <- c(punct, space, hyphens, parents)
    
    # Note: cclass includes additional symbols.
    
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
  
} # count_chars(). 

## Check:
# x <- c("Hello!", "This is a 1st sentence.", "This is the 2nd sentence.", "The end.")
# 
# count_chars(x)
# count_chars(x, case_sense = FALSE)
# count_chars(x, rm_specials = FALSE)
# count_chars(x, sort_freq = FALSE)
# 
# # Note: count_chars returns a named vector of type integer:
# freq <- count_chars(x)
# typeof(freq)
# freq["e"]


## text_to_sentences: Turn a text (consisting of one or more strings) into a vector of all its sentences: ------ 

#' Split strings of text \code{x} into sentences. 
#' 
#' \code{text_to_sentences} splits text \code{x} 
#' (consisting of one or more character strings) 
#' into a vector of its constituting sentences. 
#' 
#' The splits of \code{x} will occur at given punctuation marks 
#' (provided as a regular expression, default: \code{split_delim = "\\.|\\?|!"}).   
#' Empty leading and trailing spaces are removed before returning 
#' a vector of the remaining character sequences (i.e., the sentences).
#' 
#' The Boolean argument \code{force_delim} distinguishes between 
#' two splitting modes: 
#' 
#' \enumerate{
#' 
#'   \item If \code{force_delim = FALSE} (as per default), 
#'   the function assumes a standard sentence-splitting pattern: 
#'   A sentence delimiter in \code{split_delim} must be followed by 
#'   a single space and a capital letter starting the next sentence. 
#'   Sentence delimiters in \code{split_delim} are not removed 
#'   from the output.
#'   
#'   \item If \code{force_delim = TRUE}, 
#'   the function enforces splits at each delimiter in \code{split_delim}. 
#'   For instance, any dot (i.e., the metacharacter \code{"\\."}) is  
#'   interpreted as a full stop, so that sentences containing dots 
#'   mid-sentence (e.g., for abbreviations, etc.) are split into parts. 
#'   Sentence delimiters in \code{split_delim} are removed 
#'   from the output.
#'   
#'   }
#' 
#' Internally, \code{text_to_sentences} uses \code{\link{strsplit}} to 
#' split strings.
#' 
#' @param x A string of text (required), 
#' typically a character vector. 
#' 
#' @param split_delim Sentence delimiters (as regex) 
#' used to split \code{x} into substrings. 
#' By default, \code{split_delim = "\\.|\\?|!"}. 
#' 
#' @param force_delim Boolean: Enforce splitting at 
#' \code{split_delim}? 
#' If \code{force_delim = FALSE} (as per default), 
#' the function assumes a standard sentence-splitting pattern: 
#' \code{split_delim} is followed by a single space and a capital letter. 
#' If \code{force_delim = TRUE}, splits at \code{split_delim} are 
#' enforced (regardless of spacing or capitalization).
#' 
#' @return A character vector. 
#' 
#' @examples
#' x <- c("A first sentence. Exclamation sentence!", 
#'        "Any questions? But etc. can be tricky. A fourth --- and final --- sentence.")
#' text_to_sentences(x)
#' text_to_sentences(x, force_delim = TRUE)
#' 
#' # Changing split delimiters:
#' text_to_sentences(x, split_delim = "\\.")  # only split at "."
#' 
#' text_to_sentences("Buy apples, berries, and coconuts.")
#' text_to_sentences("Buy apples, berries; and coconuts.", 
#'                   split_delim = ",|;|\\.", force_delim = TRUE)
#'                   
#' text_to_sentences(c("123. 456? 789! 007 etc."), force_delim = TRUE)
#' text_to_sentences("Dr. Who is problematic.")
#' 
#' 
#' @family text objects and functions
#'
#' @seealso
#' \code{\link{text_to_words}} for splitting text into a vector of words; 
#' \code{\link{count_words}} for counting the frequency of words; 
#' \code{\link{strsplit}} for splitting strings. 
#' 
#' @export

text_to_sentences <- function(x,  # string(s) of text
                              split_delim = "\\.|\\?|!",  # sentence delimiters (as regex)
                              force_delim = FALSE         # force split at delimiters
){
  
  # 0. Initialize:
  st <- NA
  regex <- NA
  # split_delim <- "([[:punct:]])"  # as user argument
  
  # 1. Handle inputs:
  x1 <- as.character(x)
  
  # 2. Main:
  
  # Paste all into one string:
  x2 <- paste(x1, collapse = " ")
  
  # Split at SENTENCE punctuation provided by split_delim:
  if (!force_delim){
    
    # (1) Smart splitting: Expect well-formatted pattern: 
    #     Sentence delimiter, single space, capital letter to start sentence: 
    
    regex <- paste("(?<=(", split_delim, "))\\s(?=[A-Z])", sep = "") # require single space and capitalization
    
    x3 <- unlist(strsplit(x2, split = regex, perl = TRUE))
    
  } else {
    
    # (2) Force split at delimiter provided by split_delim 
    #     (e.g., if multiple spaces, or no capitalization of first letter in sentence): 
    
    # regex <- paste("(", split_delim, ")\\s(?=[A-Z])", sep = "")  # require single space and capitalization
    regex <- split_delim  # force split at split_delim 
    
    x3 <- unlist(strsplit(x2, split = regex, perl = TRUE))
    
  }
  
  # Remove empty LEADING and TRAILING spaces:
  x4 <- unlist(strsplit(x3, split = "^( ){1,}"))
  
  x5 <- unlist(strsplit(x4, split = "$( ){1,}"))  
  
  # Remove all instances of "":
  st <- x5[x5 != ""]
  
  # 3. Output: 
  return(st)
  
} # text_to_sentences(). 

## Check:
# x <- c("A first sentence. Exclamation sentence!",
#        "Any questions? But etc. can be tricky. A fourth --- and final --- sentence.")
# text_to_sentences(x)
# text_to_sentences(x, force_delim = TRUE)
# 
# 
# # Changing split delimiters:
# text_to_sentences(x, split_delim = "\\.")  # only split at "."
# 
# text_to_sentences("Buy apples, berries, and coconuts.")
# text_to_sentences("Buy apples, berries; and coconuts.", 
#                   split_delim = ",|;|\\.", force_delim = TRUE)
# 
# text_to_sentences(c("123. 456? 789! 007 etc."), force_delim = TRUE)
# text_to_sentences("Dr. Who is problematic.")


## text_to_words: Turn a text (consisting of one or more strings) into a vector of its words: ------ 

#' Split strings text \code{x} into words. 
#' 
#' \code{text_to_words} splits a string of text \code{x} 
#' (consisting of one or more character strings) 
#' into a vector of its constituting words. 
#' 
#' \code{text_to_words} removes all (standard) punctuation marks 
#' and empty spaces in the resulting parts, 
#' before returning a vector of the remaining character symbols 
#' (as the words).
#' 
#' Internally, \code{text_to_words} uses \code{\link{strsplit}} to 
#' split strings.
#'
#' @param x A string of text (required), 
#' typically a character vector. 
#' 
#' @return A character vector. 
#'
#' @examples
#' # Default: 
#' x <- c("Hello!", "This is a 1st sentence.", "This is the 2nd sentence.", "The end.")
#' text_to_words(x)
#' 
#' @family text objects and functions
#'
#' @seealso
#' \code{\link{text_to_sentences}} for splitting text into a vector of sentences;  
#' \code{\link{count_words}} for counting the frequency of words; 
#' \code{\link{strsplit}} for splitting strings. 
#' 
#' @export

text_to_words <- function(x  # string(s) of text
){
  
  # 0. Initialize:
  wds <- NA
  
  # 1. Handle inputs:
  x1 <- as.character(x)
  
  # 2. Main: 
  x2 <- unlist(strsplit(x1, split = "[[:punct:]]"))  # remove punctuation
  x3 <- unlist(strsplit(x2, split = "( ){1,}"))      # remove spaces
  wds <- x3[x3 != ""]  # remove instances of ""
  
  # 3. Output: 
  return(wds)
  
} # text_to_words(). 

## Check:
# s3 <- c("A first sentence.", "The second sentence.", 
#         "A third --- and also the final --- sentence.")
# wv <- text_to_words(s3)
# wv


## words_to_text: Turn a vector of words into a (single) vector: ------ 

words_to_text <- function(w, collapse = " "){
  
  paste(w, collapse = collapse)
  
} # words_to_text(). 

## Check:
# words_to_text(wv)


## count_words: Count the frequency of words in a string: -------- 

#' Count the frequency of words in a string of text \code{x}.
#'
#' @param x A string of text (required).
#' 
#' @param case_sense Boolean: Distinguish lower- vs. uppercase characters? 
#' Default: \code{case_sense = TRUE}. 
#' 
#' @param sort_freq Boolean: Sort output by word frequency? 
#' Default: \code{sort_freq = TRUE}. 
#'
#' @return A named numeric vector. 
#' 
#' @examples
#' # Default: 
#' s3 <- c("A first sentence.", "The second sentence.", 
#'         "A third --- and also the final --- sentence.")
#' count_words(s3)  # case-sensitive, sorts by frequency 
#' 
#' # Options: 
#' count_words(s3, case_sense = FALSE)  # case insensitive
#' count_words(s3, sort_freq = FALSE)   # sorts alphabetically
#'
#' @family text objects and functions
#'
#' @seealso
#' \code{\link{count_chars}} for counting the frequency of characters;   
#' \code{\link{plot_chars}} for a character plotting function. 
#' 
#' @export

count_words <- function(x,  # string(s) of text
                        case_sense = TRUE, 
                        sort_freq = TRUE
){
  
  # 0. Initialize: 
  freq <- NA
  
  # 1. Handle inputs: 
  v0 <- as.character(x)
  
  if (case_sense){
    v1 <- v0  # as is
  } else {
    v1 <- tolower(v0)  # lowercase
  }
  
  # 2. Main: Split input into a vector of all its words:
  w <- text_to_words(v1)
  
  # 3. Prepare outputs: 
  if (sort_freq){
    
    freq <- sort(table(w), decreasing = TRUE)
    
  } else { # no sorting:
    
    freq <- table(w)    
    
  } # if (sort_freq).
  
  return(freq)
  
} # count_words().

# ## Check:
# s3 <- c("A first sentence.", "The second sentence.", 
#         "A third --- and also the final --- sentence.")
# 
# count_words(s3)                      # case-sens, sorts by frequency 
# count_words(s3, case_sense = FALSE)  # case insensitive
# count_words(s3, sort_freq = FALSE)   # sorts alphabetically



## (5) Capitalization ---------- 

## caseflip: Flip lower to upper case and vice versa: --------  

#' Flip the case of characters in a string of text \code{x}.
#' 
#' \code{caseflip} flips the case of all characters 
#' in a string of text \code{x}.
#' 
#' Internally, \code{caseflip} uses the \code{letters} and \code{LETTERS} 
#' constants of \strong{base} R and the \code{chartr} function 
#' for replacing characters in strings of text. 
#'
#' @param x A string of text (required).
#' 
#' @return A character vector. 
#' 
#' @examples
#' x <- c("Hello world!", "This is a 1st sentence.", "This is the 2nd sentence.", "The end.")
#' caseflip(x)
#'  
#' @family text objects and functions
#'
#' @seealso
#' \code{\link{capitalize}} for converting the case of initial letters; 
#' \code{chartr} for replacing characters in strings of text. 
#' 
#' @export

caseflip <- function(x){
  
  out <- NA  # initialize  
  
  # Rules: 
  from <- paste0(c(letters, LETTERS), collapse = "")
  to   <- paste0(c(LETTERS, letters), collapse = "")  
  
  out <- chartr(old = from, new = to, x = x)
  
  return(out)
  
} # caseflip(). 

## Check:
# caseflip("Hello World! Hope all is well?")
# caseflip(c("Hi there", "Does this work as well?"))
# caseflip(NA)



## capitalize the first n letters of words (w/o exception): -------- 

#' Capitalize initial characters in strings of text \code{x}.  
#' 
#' \code{capitalize} converts the case of 
#' each word's \code{n} initial characters 
#' (typically to \code{upper}) 
#' in a string of text \code{x}.
#'
#' @return A character vector. 
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
  
} # capitalize(). 

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
  
} # count_str(). 

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



## Done: ---------- 

# Write functions to:  
# - switch text to lower/upper case, capitalize, etc.
# - leetify a string of text (with sets of rules)

## ToDo: ----------

# Write functions to:
# - mix content (letters, words, ...) with noise (punctuation, space, random characters)
# - Add exception argument except to capitalize() function 
#   (to exclude all words matching an exception argument).
# - improve read_ascii (with regex and more efficient text wrangling)

## eof. ----------------------