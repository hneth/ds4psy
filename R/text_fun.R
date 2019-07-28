## text_fun.R | ds4psy
## hn | uni.kn | 2019 07 28
## ---------------------------

## Functions for text and string objects. 

## (0) Define text labels: ---------- 

course_title     <- paste0("Data science for psychologists")
course_title_abb <- paste0("ds4psy")
# psi <- expression(psi)
name_hn <- "Hansjörg Neth"
name_course <- paste0(course_title, " (", course_title_abb, "), by ", name_hn, "")
# name_course

## (1) L33t slang: ---------- 

# Using leet / l33t slang: ------

# l33t rul35: 
n4me <- "h4n5j03Rg n3+h"     # e:3, a:4, s:5, o:0, t:+, r:R
d5   <- "d4+4 5c13nc3"       # i:1 
fp   <- "f0R p5ych0l0g15+5"
course_l33t <- paste0(n4me, ":", " ", d5, " ", fp)
# course_l33t


# Automation: ----- 

txt1 <- "This is a short test string with some text to leetify."
txt2 <- "Data science is both a craft and an art. This course introduces fundamental data types, basic concepts and commands of the R programming language, and explores key packages of the so-called tidyverse. Regular exercises will help you to make your first steps from R novice to user."

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
#' @import stringr
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
  
}

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

## ToDo: ----------

## eof. ----------------------