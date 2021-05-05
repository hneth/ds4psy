## text_fun.R | ds4psy
## hn | uni.kn | 2021 05 05
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


#' metachar provides metacharacters (as a character vector). 
#' 
#' \code{metachar} provides the metacharacters of extended regular expressions 
#' (as a character vector).
#' 
#' \code{metachar} allows illustrating the notion of 
#' meta-characters in regular expressions 
#' (and provides corresponding exemplars). 
#' 
#' See \code{?base::regex} for details on regular expressions 
#' and \code{?"'"} for a list of character constants/quotes in R.
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
sp4 <- "\r"  # carriage return
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
#
## Note: See ?"'" for character constants in R.


#' cclass provides character classes (as a named vector).
#' 
#' \code{cclass} provides different character classes  
#' (as a named character vector).
#' 
#' \code{cclass} allows illustrating matching 
#' character classes via regular expressions. 
#' 
#' See \code{?base::regex} for details on regular expressions 
#' and \code{?"'"} for a list of character constants/quotes in R. 
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



## (1) Converting text strings (between units, e.g., sentences, words, characters): ---------- 

## collapse_chars: Turn a multi-element character string into a 1-element character string: ------ 

# Goal A utility function to ensure that multi-element text inputs are handled consistently.
# Note: sep is ONLY used when collapsing multi-element strings and inserted BETWEEN elements. 

# (Note: Currently not exported, but used.)

collapse_chars <- function(x, sep = " "){
  
  # Initialize: 
  x0 <- as.character(x)
  x1 <- NA
  
  # Main: 
  if (length(x0) > 1){  # A multi-element character vector: Insert sep BETWEEN elements
    
    # sep <- " " # Use "" OR " " OR "\n" "\r" "\t" # (see ?"'" for character constants in R)
    x1 <- paste(x0, collapse = sep)  # collapse multi-element strings (ADDING sep between elements). 
    
  } else {  # NO collapse and NO use of sep: 
    
    x1 <- x0  
    
  }
  
  # Output: 
  return(x1)
  
}

## Check:
# collapse_chars(c("Hello", "world", "!"))
# collapse_chars(c(".", " . ", "  .  "), sep = "|")
# writeLines(collapse_chars(c("Hello", "world", "!"), sep = "\n"))
# collapse_chars(NA)
# collapse_chars("")
# collapse_chars(1:3)


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
#'   a standard sentence-splitting pattern is assumed: 
#'   A sentence delimiter in \code{split_delim} must be followed by 
#'   one or more blank spaces and a capital letter starting the next sentence. 
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
#' Internally, \code{text_to_sentences} first uses \code{\link{paste}} 
#' to collapse strings (adding \code{sep} between elements) and then 
#' \code{\link{strsplit}} to split strings at \code{split_delim}.
#' 
#' @param x A string of text (required), 
#' typically a character vector. 
#' 
#' @param sep A character inserted as separator/delimiter 
#' between elements when collapsing multi-element strings of \code{x}.  
#' Default: \code{sep = " "} (i.e., insert 1 space between elements). 
#' 
#' @param split_delim Sentence delimiters (as regex) 
#' used to split the collapsed string of \code{x} into substrings. 
#' Default: \code{split_delim = "\\.|\\?|!"} (rather than \code{"[[:punct:]]"}).  
#' 
#' @param force_delim Boolean: Enforce splitting at \code{split_delim}? 
#' If \code{force_delim = FALSE} (as per default), 
#' a standard sentence-splitting pattern is assumed: 
#' \code{split_delim} is followed by one or more blank spaces and a capital letter. 
#' If \code{force_delim = TRUE}, splits at \code{split_delim} are 
#' enforced (without considering spacing or capitalization).
#' 
#' @return A character vector (of sentences). 
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
#' 
#' # Split multi-element strings (w/o punctuation):
#' e3 <- c("12", "34", "56")
#' text_to_sentences(e3, sep = " ")  # Default: Collapse strings adding 1 space, but: 
#' text_to_sentences(e3, sep = ".", force_delim = TRUE)  # insert sep and force split.
#' 
#' # Punctuation within sentences:
#' text_to_sentences("Dr. who is left intact.")
#' text_to_sentences("Dr. Who is problematic.")
#' 
#' @family text objects and functions
#'
#' @seealso
#' \code{\link{text_to_words}} for splitting text into a vector of words; 
#' \code{\link{text_to_chars}} for splitting text into a vector of characters; 
#' \code{\link{count_words}} for counting the frequency of words; 
#' \code{\link{strsplit}} for splitting strings. 
#' 
#' @export

text_to_sentences <- function(x,  # string(s) of text
                              sep = " ",  # separator/delimiter inserted between multi-element strings of x 
                              split_delim = "\\.|\\?|!",  # sentence delimiters used (as regex). ToDo: Consider "[[:punct:]]".
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
  # WAS: x2 <- paste(x1, collapse = " ")
  x2 <- collapse_chars(x = x1, sep = sep)
  
  # Split at SENTENCE punctuation provided by split_delim:
  if (!force_delim){ # more specific: 
    
    # (A) Smart splitting: Expect well-formatted pattern: 
    #     Sentence delimiter, single space, capital letter to start sentence: 
    
    # regex_1sC <- paste("(?<=(", split_delim, "))\\s(?=[A-Z])", sep = "")   # require exactly 1 space and capitalization
    regex_nsC <- paste("(?<=(", split_delim, "))\\s{1,}(?=[A-Z])", sep = "") # require 1 or more spaces and capitalization
    
    x3 <- unlist(strsplit(x2, split = regex_nsC, perl = TRUE))
    
  } else { # more general: 
    
    # (B) Force split at delimiter provided by split_delim 
    #     (e.g., if multiple spaces, or no capitalization of first letter in sentence): 
    
    regex_fd <- split_delim  # force split at split_delim 
    
    x3 <- unlist(strsplit(x2, split = regex_fd, perl = TRUE))
    
  }
  
  # 3. Post-process split sentences:
  x4 <- unlist(strsplit(x3, split = "^( ){1,}"))  # a. Remove LEADING spaces
  x5 <- unlist(strsplit(x4, split = "$( ){1,}"))  # b. Remove TRAILING spaces
  st <- x5[x5 != ""]   # c. Remove all instances of ""
  
  # 4. Output: 
  return(st)
  
} # text_to_sentences(). 

## Check:
# x <- c("A first sentence. Exclamation sentence!",
#        "Any questions? But etc. can be tricky. A fourth --- and final --- sentence.")
# text_to_sentences(x)
# text_to_sentences(x, force_delim = TRUE)
# 
# # Number of spaces between sentences:
# s1 <- c("One space! Between sentences.", "Split ok?")
# text_to_sentences(s1)
# s2 <- c("Two or more spaces!  Between sentences. ", " Split ok?")
# text_to_sentences(s2)
# 
# # Changing split delimiters:
# text_to_sentences(x, split_delim = "\\.")  # only split at "."
# 
# text_to_sentences("Buy apples, berries, and coconuts.")
# text_to_sentences("Buy apples, berries; and coconuts.",
#                   split_delim = ",|;|\\.", force_delim = TRUE)
# 
# text_to_sentences(c("123. 456? 789! 007 etc."), force_delim = TRUE)
# 
# # Splitting multi-element strings (w/o punctuation):
# text_to_sentences(c("123", "456", "789"), sep = " ")  # Default: collapse strings with 1 added space, but:
# text_to_sentences(c("123", "456", "789"), sep = ".", force_delim = TRUE)  # inserts sep and forces split.
# 
# # Punctuation within sentences:
# text_to_sentences("Dr. who is left intact.")
# text_to_sentences("Dr. Who is problematic.")


## text_to_words: Turn a text (consisting of one or more strings) into a vector of its words: ------ 

#' Split string(s) of text \code{x} into words. 
#' 
#' \code{text_to_words} splits a string of text \code{x} 
#' (consisting of one or more character strings) 
#' into a vector of its constituting words. 
#' 
#' \code{text_to_words} removes all (standard) punctuation marks 
#' and empty spaces in the resulting text parts, 
#' before returning a vector of the remaining character symbols 
#' (as its words).
#' 
#' Internally, \code{text_to_words} uses \code{\link{strsplit}} to 
#' split strings at punctuation marks (\code{split = "[[:punct:]]"}) 
#' and blank spaces (\code{split = "( ){1,}"}).
#'
#' @param x A string of text (required), 
#' typically a character vector. 
#' 
#' @return A character vector (of words). 
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
#' \code{\link{text_to_chars}} for splitting text into a vector of characters;  
#' \code{\link{count_words}} for counting the frequency of words; 
#' \code{\link{strsplit}} for splitting strings. 
#' 
#' @export

text_to_words <- function(x){
  
  # 0. Initialize:
  wds <- NA
  
  # 1. Handle inputs:
  x1 <- as.character(x)
  
  # 2. Main: 
  x2 <- unlist(strsplit(x1, split = "[[:punct:]]"))  # remove punctuation
  x3 <- unlist(strsplit(x2, split = "( ){1,}"))      # remove 1+ spaces
  wds <- x3[x3 != ""]  # remove instances of ""
  
  # 3. Output: 
  return(wds)
  
} # text_to_words(). 

## Check:
# s3 <- c("A first sentence.", "The second sentence.",
#         "A third --- and also the final --- sentence.")
# (wv <- text_to_words(s3))


## text_to_words_regex: Alternative to text_to_words (using 1 regex): -------- 

# (Note: Currently not exported, and not used.)

text_to_words_regex <- function(x){
  
  unlist(regmatches(x, gregexpr(pattern = "\\w+", x)))
  
}

## Check:
# s2 <- c("This is  a  test.", "Does this work?")
# text_to_words_regex(s2)
# text_to_words_regex(s3)


## text_to_chars: Turn a text (consisting of one or more strings) into a vector of its characters: ------ 

#' Split string(s) of text \code{x} into its characters. 
#' 
#' \code{text_to_chars} splits a string of text \code{x} 
#' (consisting of one or more character strings) 
#' into a vector of its individual characters.  
#' 
#' If \code{rm_specials = TRUE}, 
#' most special (or non-word) characters are 
#' removed. (Note that this currently works 
#' without using regular expressions.)
#' 
#' @param x A string of text (required).
#' 
#' @param rm_specials Boolean: Remove special characters? 
#' Default: \code{rm_specials = TRUE}. 
#' 
#' @param sep Character to insert between the elements 
#' of a multi-element character vector as input \code{x}? 
#' Default: \code{sep = ""} (i.e., add nothing).
#'
#' @return A character vector (containing individual characters). 
#'
#' @examples
#' s3 <- c("A 1st sentence.", "The 2nd sentence.",
#'         "A 3rd --- and  FINAL --- sentence.")
#' text_to_chars(s3)
#' text_to_chars(s3, sep = "\n")
#' text_to_chars(s3, rm_specials = TRUE) 
#'
#' @family text objects and functions
#'
#' @seealso
#' \code{\link{text_to_sentences}} for splitting text into a vector of sentences; 
#' \code{\link{text_to_words}} for splitting text into a vector of words; 
#' \code{\link{count_chars}} for counting the frequency of characters; 
#' \code{\link{count_words}} for counting the frequency of words; 
#' \code{\link{strsplit}} for splitting strings. 
#' 
#' @export

text_to_chars <- function(x, rm_specials = FALSE, sep = ""){
  
  # 0. Initialize:
  chars <- NA
  
  # 1. Inputs:
  if (all(is.na(x))){ return(x) }  # handle NAs (by returning x unaltered)
  x0 <- as.character(x)
  
  x1 <- collapse_chars(x0, sep = sep)  # collapse multi-element strings (ADDING sep between elements). 
  
  # 2. Remove special characters: 
  # x2 <- unlist(strsplit(x1, split = "[[:punct:]]"))  # remove punctuation
  # x3 <- unlist(strsplit(x2, split = "( ){1,}"))      # remove 1+ spaces
  # x4 <- x3[x3 != ""]  # remove instances of ""
  
  # 3. Main: 
  x2 <- unlist(strsplit(x1, split = ""))
  
  # 4. Remove special characters: 
  if (rm_specials){
    
    # Define special chars: 
    space <- c("", " ")  # [[:space:]]
    hyphens <- c("-", "--", "---")
    punct <- c(",", ";", ":", ".", "!", "?")  # punctuation [[:punct:]]  
    parents <- c("(", ")", "[", "]", "{", "}", "<", ">")  # parentheses
    spec_char <- c(punct, space, hyphens, parents)
    
    # Note: cclass includes additional symbols.
    
    # Remove special characters:
    chars <- x2[!(x2 %in% spec_char)]
    
  } else {
    
    chars <- x2  # as is 
    
  } # if (rm_specials). 
  
  # 4. Output: 
  return(chars)
  
} # text_to_chars(). 

## Check:
# s3 <- c("A first sentence.", "The second sentence.",
#        "A third --- and also THE   FINAL --- sentence.")
# (wv <- text_to_chars(s3))
# (wv_2 <- text_to_chars(s3, sep = "\n"))
# (wv_3 <- text_to_chars(s3, rm_specials = TRUE))
# 
# text_to_chars(c("See 3 spaces:   ?"))
# # Note:
# text_to_chars(c(1:3))
# text_to_chars(c(NA, NA))
# text_to_chars(c(NA))


## words_to_text: Turn a vector of words x into a (single) vector: ------ 

# Inverse of text_to_words() above:
# Currently only adds spaces between words 
# (collapsing multiple strings into one).
# (Note: Currently not exported, but used.)

words_to_text <- function(x, collapse = " "){
  
  paste(x, collapse = collapse)
  
} # words_to_text(). 

## Check:
# words_to_text(wv)
# words_to_text(c("This", "is only", "a test"))


## chars_to_text: Turn a character vector x into a (single) string of text: ------

# Inverse of text_to_chars() above: 
# Assume that x consists of individual characters, but may contain spaces. 
# Goal: Exactly preserve all characters (e.g., punctuation and spaces).
# (Note: Simply using paste(x, collapse = "") would lose all spaces.) 
# (Note: Currently not exported, but used.)

chars_to_text <- function(x){
  
  # Initialize:
  char_t <- NA
  
  # Ensure that x consists only of individual characters:
  if (any(nchar(x) > 1)){
    one_cv <- paste(x, collapse = "")  # paste all into a single char vector
    char_v <- unlist(strsplit(one_cv, split = ""))  # split into a vector of individual characters
  } else {
    char_v <- x  # use vector of single characters
  }
  # print(char_v)  # 4debugging
  
  # Main: Convert char_v into char_t (preserving spaces): 
  my_space <- "_h3d8o5m1v7z4_"  # some cryptic replacement for any " " (in character string)
  char_v_hlp <- gsub(pattern = " ", replacement = my_space, x = char_v)  # helper (with spaces replaced)
  char_s_hlp <- paste(char_v_hlp, collapse = "")  # char string helper (with spaces as my_space)
  char_t <- gsub(pattern = my_space, replacement = " ", x = char_s_hlp)  # char string (with original spaces)
  
  # Check: Does nchar(char_s) equal length(char_v)? 
  n_char_v <- length(char_v)
  n_char_t <- nchar(char_t)
  if (n_char_t != n_char_v){
    message(paste0("chars_to_text: nchar(char_t) = ", n_char_t, 
                   " differs from length(char_v) = ", n_char_v, "."))
  }
  
  return(char_t)
  
} # chars_to_text().

## Check:
# t <- "Hello world! This is _A   TEST_. Does this work?"
# (cv <- unlist(strsplit(t, split = "")))
# chars_to_text(cv)
# # Use with longer input strings (nchar > 1):
# s <- c("Abc", "   ", "Xyz.")
# chars_to_text(s)
# # Note: 
# chars_to_text("Hi there!")
# chars_to_text(1:3)



## (2) Capitalization: ---------- 

## capitalize: the first n letters of words (w/o exception): -------- 

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



## (3) Reading ascii text (from a file) into a table (data frame): ---------- 

## read_ascii: Parse text (from a file) into string(s) of text (txt). -------- 

#' read_ascii parses text (from file or user input) into string(s) of text. 
#'
#' \code{read_ascii} parses text inputs 
#' (from a file or from user input in the Console) 
#' into a character vector. 
#' 
#' Different lines of text are represented by different elements 
#' of the character vector returned. 
#' 
#' The \code{getwd} function is used to determine the current 
#' working directory. This replaces the \bold{here} package, 
#' which was previously used to determine an (absolute) file path. 
#' 
#' Note that \code{read_ascii} originally contained  
#' \code{\link{map_text_coord}}, but has been separated to 
#' enable independent access to separate functionalities. 
#' 
#' @param file The text file to read (or its path). 
#' If \code{file = ""} (the default), \code{scan} is used 
#' to read user input from the Console. 
#' If a text file is stored in a sub-directory, 
#' enter its path and name here (without any leading or 
#' trailing "." or "/"). 
#' Default: \code{file = ""}. 
#' 
#' @param quiet Boolean: Provide user feedback? 
#' Default: \code{quiet = FALSE}. 
#' 
#' @return A character vector, with its elements 
#' denoting different lines of text. 
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
#' # read_ascii("test.txt", quiet = TRUE)  # y flipped
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
#' \code{\link{map_text_coord}} for mapping text to a table of character coordinates;  
#' \code{\link{plot_chars}} for a character plotting function. 
#' 
#' @export

read_ascii <- function(file = "", quiet = FALSE){ 
  
  ## Read a file/user input into text string(s) txt:
  
  # (0) Initialize:  
  txt <- NA 
  # file <- "test.txt"  # default file/path
  
  # (1) Path to a file:
  if (!is.na(file) && (file != "")){
    
    # (a) File path: Remove leading "." and/or "/" characters:
    if (substr(file, 1, 1) == ".") {file <- substr(file, 2, nchar(file))}
    if (substr(file, 1, 1) == "/") {file <- substr(file, 2, nchar(file))}
    # ToDo: Use regex to detect path-related patterns.
    
    ## (a) using the here package: 
    # cur_file <- here::here(file)  # absolute path to text file
    
    # (b) using getwd() instead:
    cur_wd   <- getwd()
    cur_file <- paste0(cur_wd, "/", file) 
    
  } else {  # no file path given:
    
    cur_file <- ""  # use "" (to scan from Console)
    
  } # if (file). 
  
  
  # (2) Scan file or user input: 
  
  # txt <- readLines(con = cur_file)                # (a) read from file
  txt <- scan(file = cur_file, what = "character",  # (b) from file OR user console
              sep = "\n",     # i.e., keep " " as a space!     
              quiet = quiet   # provide user feedback? 
  )
  # writeLines(txt)  # 4debugging
  
  # (3) User feedback: 
  
  if (!quiet){
    
    n_lines <- length(txt)
    n_chars <- sum(nchar(txt))
    msg <- paste0("read_ascii: Read ", n_lines, " lines, ", n_chars, " characters")
    message(msg)
    
  }
  
  # (4) Output: 
  return(txt)
  
} # read_ascii(). 

## Check:
# # Create a temporary file "test.txt":
# cat("Hello world!",
#     "This is a test.",
#     "Can you see this text?",
#     "Good! Please carry on...",
#     file = "test.txt", sep = "\n")
# read_ascii("test.txt")
# # plot_text(file = "test.txt")
# 
# unlink("test.txt")  # clean up (by deleting file).
# 
# # (2) Read other text files:
# read_ascii("./data-raw/txt/ascii.txt")  # Note: "\" became "\\"
# read_ascii("./data-raw/txt/ascii.txt", flip_y = TRUE)
# 
# read_ascii("./data-raw/txt/ascii2.txt")
# 
# t <- read_ascii("./data-raw/txt/hello.txt")
# t
# tail(t)


## read_text_or_file: Read text (from string, file, or user input) into a single character string --------

# Note: sep is ONLY used when collapsing multi-element strings and inserted BETWEEN elements. 

# Goal: Read text from string x or file/user input into a single text string (of length 1). 
#       A sep argument separates different elements/lines of text.

# (Note: Currently not exported, but used.)

read_text_or_file <- function(x = NA, file = "", collapse = TRUE, sep = " "){
  
  # (0) Initialize: 
  txt <- NA
  
  # (1) If no x: 
  if (all(is.na(x))){  # If NO x provided:
    
    x <- read_ascii(file = file, quiet = FALSE)  # Read text from file or user input (in Console)
    
  } # if (is.na(x)) end.
  
  
  # (2) Should txt be collapsed into 1 or left as multiple elements/strings of text? 
  if (collapse){
    
    txt <- collapse_chars(x = x, sep = sep)  # Collapse x into a single string (using sep)
    
  } else { # NO collapse: NO use of sep: 
    
    txt <- as.character(x)  # Convert any non-characters into character
    
  }
  
  # (3) Output:
  return(txt)
  
} # read_text_or_file(). 

## Check: 
# read_text_or_file("No change here.")  # trivial case
# read_text_or_file(1:3)  # returned as character string of length 1
# read_text_or_file(1:3, collapse = FALSE)  # returned as character string(s) of length 3
# 
# # # 3 alternative inputs:
# # # (1) From text string:
# read_text_or_file(c("Line 1.", "2nd line."))
# read_text_or_file(c("Line 1.", "2nd line."), collapse = FALSE)
# read_text_or_file(c("Line 1.", "2nd line."), sep = "\n")
# 
# # Note that sep is only used when collapsing multi-element strings: 
read_text_or_file(c(123, 456), collapse = TRUE, sep = " vs. ")  # uses sep between collapsed strings of x
read_text_or_file(c(123, 456), collapse = FALSE, sep = "asdf")  # does NOT use sep, as nothing collapsed
# 
# # # (2) From user input (in Console):
# # read_text_or_file(x = NA)
# 
# # (3) From text file "test.txt":
# cat("Hello world!", "This is a test.",
#     "Can you see this text?", "Good! Please carry on...",
#      file = "test.txt", sep = "\n")
# 
# read_text_or_file(file = "test.txt")  # => 1 element/line string, unless:
# read_text_or_file(file = "test.txt", collapse = FALSE)
# 
# unlink("test.txt")  # clean up (by deleting file).



## map_text_chars: Map text (from a text string) to a table/df of characters (with x/y-coordinates) --------   

# (Note: Replaced by map_text_coord() below.)
# (Note: Currently not exported/used.)

#' map_text_chars maps the characters of a text string into a table (with x/y coordinates).  
#'
#' \code{map_text_chars} parses text 
#' (from a text string \code{x}) 
#' into a table that contains a row for each character 
#' and x/y-coordinates corresponding to the character positions in \code{x}.  
#' 
#' \code{map_text_chars} creates a data frame with 3 variables: 
#' Each character's \code{x}- and \code{y}-coordinates (from top to bottom)  
#' and a variable \code{char} for the character at these coordinates. 
#' 
#' Note that \code{map_text_chars} was originally a part of 
#' \code{\link{read_ascii}}, but has been separated to 
#' enable independent access to separate functionalities. 
#' 
#' Note that \code{map_text_chars} is replaced by the simpler 
#' \code{map_text_coord} function. 
#' 
#' @param x The text string(s) to map (required). 
#' If \code{length(x) > 1}, elements are mapped to different lines 
#' (i.e., y-coordinates). 
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
#' @family text objects and functions
#'
#' @seealso
#' \code{\link{read_ascii}} for parsing text from file or user input;  
#' \code{\link{plot_chars}} for a character plotting function. 

map_text_chars <- function(x, flip_y = FALSE){ 
  
  # (0) Inputs:
  if (all(is.na(x))){ return(x) }  # handle NAs (by returning x unaltered)
  tb  <- NA 
  txt <- as.character(x)
  
  ## WAS originally Part B of read_ascii(): Turn text string txt into a table (df with x/y-coordinates): ------ 
  
  # (1) Initialize lengths and a counter:
  n_lines <- length(txt)
  n_chars <- sum(nchar(txt))
  
  # (2) Data structure (for results): 
  # # Initialize a matrix (to store all characters in place):
  # m <- matrix(data = NA, nrow = n_lines, ncol = max(nchar(txt)))
  
  # (3) Main: Data structure (for results) and loops through txt: ----    
  
  if (n_chars > 0) { # there is something to map: 
    
    # Initialize:
    ct <- 0                # character counter
    x <- rep(NA, n_chars)  # 3 vectors
    y <- rep(NA, n_chars)
    char <- rep("", n_chars)
    
    # (3a) Loop through all i lines of txt:  
    for (i in 1:n_lines){ 
      
      line <- txt[i]  # i-th line of txt
      
      # (3b) Loop through each char j of each line:
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
    
    # (4) Check that ct matches n_chars (if > 0):
    if ((n_chars > 0) & (ct != n_chars)){
      msg <- paste0("map_text_chars: Count ct = ", ct, " differs from n_chars = ", n_chars, "!")
      message(msg)
    }
    
    ## (5) Prepare output:
    # tb$x <- as.integer(tb$x)
    # tb$y <- as.integer(tb$y)
    # tb$char <- as.character(tb$char)  
    
    # options(warn = 0)  # back to default
    
    # Initialize a table (to store all characters as rows):  
    tb <- data.frame(char, x, y, 
                     stringsAsFactors = FALSE)
    
  } # if (n_chars > 0) end. 
  
  # (6) Return: 
  return(tb)
  
} # map_text_chars().

## Check: 
# map_text_chars("Hello world!")             # 1 line of text
# map_text_chars(c("Hello", "world!"))       # 2 lines of text
# map_text_chars(c("Hello", " ", "world!"))  # 3 lines of text
# 
# txt <- c("1: AB", "2: C", "3.")
# map_text_chars(txt)
# map_text_chars(txt, flip_y = TRUE)
#
# # Note: 
# map_text_chars(NA)   # => NA
# map_text_chars("")   # => NA
# map_text_chars(" ")  # yields table
# 
# # Reading text from file (using read_ascii()): 
# # Create a temporary file "test.txt":
# cat("Hello world!", "This is a test.",
#     "Can you see this text?", "Good! Please carry on...",
#     file = "test.txt", sep = "\n")
# txt <- read_ascii("test.txt")
# map_text_chars(txt)
# unlink("test.txt")  # clean up (by deleting file).



## map_text_coord: Map text (from a text string) to a table/df of characters (with x/y-coordinates) --------   

# Note: A newer and simpler version of map_text_chars: 
#       Just describe the text string txt as 2 vectors x and y: 

#' map_text_coord maps the characters of a text string into a table (with x/y-coordinates).  
#'
#' \code{map_text_coord} parses text (from a text string \code{x}) 
#' into a table that contains a row for each character 
#' and x/y-coordinates corresponding to the character positions in \code{x}.  
#' 
#' \code{map_text_coord} creates a data frame with 3 variables: 
#' Each character's \code{x}- and \code{y}-coordinates (from top to bottom)  
#' and a variable \code{char} for the character at these coordinates. 
#' 
#' Note that \code{map_text_coord} was originally a part of 
#' \code{\link{read_ascii}}, but has been separated to 
#' enable independent access to separate functionalities. 
#' 
#' @param x The text string(s) to map (required). 
#' If \code{length(x) > 1}, elements are mapped to different lines 
#' (i.e., y-coordinates). 
#' 
#' @param flip_y Boolean: Should y-coordinates be flipped, 
#' so that the lowest line in the text file becomes \code{y = 1}, 
#' and the top line in the text file becomes \code{y = n_lines}? 
#' Default: \code{flip_y = FALSE}. 
#' 
#' @param sep Character to insert between the elements 
#' of a multi-element character vector as input \code{x}? 
#' Default: \code{sep = ""} (i.e., add nothing).
#' 
#' @return A data frame with 3 variables: 
#' Each character's \code{x}- and \code{y}-coordinates (from top to bottom)  
#' and a variable \code{char} for the character at this coordinate. 
#' 
#' @examples
#' map_text_coord("Hello world!")             # 1 line of text
#' map_text_coord(c("Hello", "world!"))       # 2 lines of text
#' map_text_coord(c("Hello", " ", "world!"))  # 3 lines of text
#'  
#' \donttest{
#' ## Read text from file:
#' 
#' ## Create a temporary file "test.txt":
#' # cat("Hello world!", "This is a test.",
#' #     "Can you see this text?", "Good! Please carry on...",
#' #      file = "test.txt", sep = "\n")
#'  
#' # txt <- read_ascii("test.txt")
#' # map_text_coord(txt)
#' 
#' # unlink("test.txt")  # clean up (by deleting file). 
#' }
#' 
#' @family text objects and functions
#'
#' @seealso
#' \code{\link{map_text_regex}} for mapping text to a character table and matching patterns; 
#' \code{\link{plot_charmap}} for plotting character maps; 
#' \code{\link{plot_chars}} for creating and plotting character maps; 
#' \code{\link{read_ascii}} for parsing text from file or user input. 
#' 
#' @export

map_text_coord <- function(x, flip_y = FALSE, sep = ""){
  
  # (0) Inputs and initialize:
  if (all(is.na(x))){ return(x) }  # handle NAs (by returning x unaltered)
  x0 <- as.character(x)
  df <- NA
  
  # (1) Get individual characters: 
  chars <- text_to_chars(x0, sep = sep)  # Note: (ADDING sep between elements).
  # WAS: chars <- unlist(strsplit(x0, split = "")) 
  
  # (2) Assign coordinates:
  n_rows    <- length(x0)
  n_per_row <- nchar(x0) + c(rep(nchar(sep), n_rows -1), 0)  # sep only BETWEEN rows (NOT last)!!!
  N_chars   <- sum(n_per_row)
  if (N_chars == 0){ return(NA) }  # handle empty string inputs
  
  v_x <- rep(NA, N_chars)
  v_y <- rep(NA, N_chars)
  
  pos <- 0 # position counter
  
  for (i in 1:n_rows){ # loop for each row:
    
    v_x[(pos + 1):(pos + n_per_row[i])] <- 1:n_per_row[i]
    
    #if (flip_y){
    #  v_y[(pos + 1):(pos + n_per_row[i])] <- (n_rows - i + 1)
    #} else {
    
    v_y[(pos + 1):(pos + n_per_row[i])] <- i
    
    #}
    
    pos <- pos + n_per_row[i]  # increment position counter
    
  } # loop i end.
  
  # (3) Handle flip_y:
  if (flip_y){
    v_y <- (n_rows + 1) - v_y  # invert values of v_y
  }
  
  # (4) Output: 
  df <- data.frame(chars, v_x, v_y, stringsAsFactors = FALSE)
  names(df) <- c("char", "x", "y")
  
  return(df)
  
} # map_text_coord(). 

## Check:
# map_text_coord("Hello world!")             # 1 line of text
# map_text_coord(c("Hello", "world!"))       # 2 lines of text
# map_text_coord(c("Hello", "world!"), sep = " ") # 2 lines of text (+ 1 space BTW rows)
# map_text_coord(c("Hello", "_:_", "world!"))  # 3 lines of text
# map_text_coord(c("Hello", "_:_", "world!"), sep = "\n")  # 3 lines of text (+ \n BTW rows)
# 
# txt <- c("1:AB", "2:C", "3.")
# map_text_coord(txt)
# map_text_coord(txt, sep = " ")
# map_text_coord(txt, sep = " ", flip_y = TRUE)
# 
# # Note:
# map_text_coord(NA)   # NA
# map_text_coord(c(NA, NA))  # NA NA
# map_text_coord("")   # NA
# map_text_coord(" ")  # yields a primitive table
# 
# # Reading text from file (using read_ascii()):
# # Create a temporary file "test.txt":
# cat("Hello world!", "This is a test.",
#     "Can you see this text?", "Good! Please carry on...",
#     file = "test.txt", sep = "\n")
# txt <- read_ascii("test.txt")
# map_text_coord(txt)
# map_text_coord(txt, sep = " ")
# map_text_coord(txt, sep = " ", flip_y = TRUE)
# unlink("test.txt")  # clean up (by deleting file).




## map_text_or_file: Read text (from string, file, or user input) into a character map (with x/y-coordinates) --------

# Goal: Read text from string x or file into a text string (using read_ascii())
#       Use map_text_coord() to create a character map (as df)
# 
# (Note: Currently not exported, but used.)

map_text_or_file <- function(x = NA, file = "", flip_y = TRUE){
  
  # Initialize:
  tbl <- NA
  
  # Main: 
  if (all(is.na(x))){  # Case 1: Read text from file or user input (enter text in Console):
    
    txt <- read_ascii(file = file, quiet = FALSE)    # 1. read file/user input (UI) into MULTI-LINE string(s) of text!
    tbl <- map_text_coord(x = txt, flip_y = flip_y)  # 2. map txt to x/y-table (different elements to different y values)
    
  } else {  # Case 2: Use the character vector x:
    
    tbl <- map_text_coord(x = x, flip_y = flip_y)    # 3. map x to x/y-table
    
  } # if (is.na(x)) end.
  
  # ## SIMPLER (but WRONG!):
  # txt <- read_text_or_file(x = x, file = file, sep = sep)  # 1. read into 1 string of text (NO MULTI-LINE strings!)
  # 
  # tbl <- map_text_coord(x = txt, flip_y = flip_y)  # 2. map text string to character map (ALL y-values identical!)
  
  # Output:
  return(tbl)
  
} # map_text_or_file(). 

## Check: 
# map_text_or_file("test.")  # trivial case
# 
# # 3 alternative inputs:
# # (1) From text string(s):
# map_text_or_file(c("Line 1?", "2nd line."))
# 
# # (2) From user input (in Console):
# # map_text_or_file(x = NA)
# 
# # (3) From text file "test.txt":
# cat("Hello world!", "This is a test.",
#     "Can you see this text?", "Good! Please carry on...",
#      file = "test.txt", sep = "\n")
# 
# map_text_or_file(file = "test.txt")
# map_text_or_file(file = "test.txt", flip_y = FALSE)
# 
# unlink("test.txt")  # clean up (by deleting file).



## (4) Mapping/replacing characters (e.g., Leet/l33t slang): ---------- 

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






## (5) Locating the positions and IDs of text strings matching a pattern: ---------- 


## locate_str: Locate pattern matches in a string of text ------ 

# locate_str locates all sub-strings matching a pattern in a string of text 
# and returns a data frame of their IDs and positions (start, end, len). 
#
# This is merely a more convenient version of gregexpr() 
# similar to stringr::str_locate(). 
#
# (Note: Currently not exported, but used.)

locate_str <- function(pattern, text, case_sense = TRUE){
  
  # (1) Locate matches (using gregexpr()):
  m_l <- gregexpr(pattern = pattern, text = text, ignore.case = !case_sense)  # LIST of matches
  
  # (2) Match positions (in list):
  m_start <- unlist(m_l)  # start positions of all matches
  
  # (3) Cases: 
  # (A) NO matches were found:  
  if (m_start[1] == -1){  
    return(NA)  # return early!
  } 
  
  # (B) ELSE: matches were found:  
  # (a) Get match locations:  
  m_l_1 <- m_l[[1]]  # 1st element of list
  m_len <- attr(m_l_1, "match.length")  # len of all matches
  m_end <- m_start + m_len - 1  # end position of all matches
  
  # (b) Get match IDs:
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
# s <- "This is a test that tests THIS function."
# locate_str("t|T", s)
# locate_str("T", s, case_sense = TRUE)
# locate_str("T", s, case_sense = FALSE)
# locate_str("t..t", s)
# locate_str("t.t", s)


## locate_str_logical: Variant of locate_str() that returns a logical vector ------ 

# - TRUE  for all matching locations (positions) in text
# - FALSE for all non-matching locations (positions) in text
# (Note: Currently not exported, but used.)

locate_str_logical <- function(pattern, text, case_sense = TRUE){
  
  # Initialize:
  df  <- NA
  out <- rep(FALSE, nchar(text))  # initialize logical vector
  
  # Locate all matches of pattern in text:
  df <- locate_str(pattern = pattern, text = text, case_sense = case_sense)  # util function (above)
  
  if (!all(is.na(df))){  # matches were found:
    
    # Set logical vector to TRUE for matches:
    for (i in 1:nrow(df)){  # for each match in df:
      
      out[df$start[i]:df$end[i]] <- TRUE  # identify matching positions
      
    }
    
  }
  
  # Return: 
  return(out)
  
} # locate_str_logical(). 

## Check:
# s <- "This is a test that tests THIS function."
# locate_str_logical("t..t", s)
# sum(locate_str_logical("t", s, case_sense = TRUE))
# sum(locate_str_logical("T", s, case_sense = TRUE))
# sum(locate_str_logical("T", s, case_sense = FALSE))
# locate_str_logical("xyz", s)
# 
# # Use case: Logical indexing on a vector of s:
# s_v <- unlist(strsplit(s, ""))  # as vector elements
# # Apply logical string to s_v:
# s_v[locate_str_logical("t|T", s)]
# s_v[locate_str_logical("T", s, case_sense = FALSE)]
# s_v[locate_str_logical("t..t", s)]
# s_v[locate_str_logical("t.t", s)]


## color_map_match: Assign 2 colors to string positions based on matching a pattern ------ 

# Inputs: A text and pattern, and 2 color vectors (col_fg for matches vs. col_bg for non-matches)
# Return: A vector of colors (with length of nchar(text), i.e., for each char in text):
#         either col_fg for matching positions, OR col_bg for non-matching positions
# Note:   col_sample = TRUE randomizes color sequence WITHIN category (fg/bg). 
# (Note: Currently not exported, but used.)

color_map_match <- function(text, pattern = "[^[:space:]]", case_sense = TRUE, 
                            col_fg = "black", col_bg = "white", col_sample = FALSE){
  
  # Initialize:
  nr_char <- nchar(text)
  col_vec <- recycle_vec(col_bg, len = nr_char)  # recycle col_bg to len of nr_char!
  
  # Locate all matches of pattern in text (as a logical vector):
  logical_vec_matches <- locate_str_logical(pattern = pattern, text = text, case_sense = case_sense)
  
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

## Check:
# s <- "This  is a test that tests THIS function..."
# color_map_match(s)
# color_map_match(s, "\\.")
# color_map_match(s, "test")
# color_map_match(s, " ")
# color_map_match(s, "t|T")
# color_map_match(s, "H", case_sense = TRUE)
# color_map_match(s, "H", case_sense = FALSE)
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
# 
# color_map_match(s, pattern = NA)  # => Error!


## angle_map_match: Assign a numeric angle to string positions based on matching a pattern ------ 

# Inputs: A text and pattern, and 2 numeric angle values (angle_fg for matches vs. angle_bg for default/non-matches)
# Return: A vector of numeric angle values (with length of nchar(text), i.e., for each char in text):
#         either angle_fg for matching positions, OR angle_bg for non-matching default positions
# Note:   If a length of angle values > 1: Get a random value from (uniform) range of angle values.
# (Note: Currently not exported, but used.)

angle_map_match <- function(text, pattern = "[^[:space:]]", case_sense = TRUE, 
                            angle_fg = 0, angle_bg = 0){
  
  # (0) Initialize:
  nr_char <- nchar(text)
  ang_vec <- rep(NA, nr_char)
  
  # (1) Define default angles:
  if (length(angle_bg) > 1){  # random value from uniform range:
    
    range_bg <- range(angle_bg)
    ang_vec  <- round(stats::runif(n = nr_char, min = range_bg[1], max = range_bg[2]), 0)
    
  } else { # recycle angle_bg to len of nr_char: 
    
    ang_vec <- recycle_vec(angle_bg, len = nr_char)  
    
  }
  
  # (2) Locate all matches of pattern in text (as a logical vector):
  logical_vec_matches <- locate_str_logical(pattern = pattern, text = text, case_sense = case_sense)
  nr_matches <- sum(logical_vec_matches)
  
  # (3) Define angles ang_hit of matching chars:
  if (length(angle_fg) > 1){  # random value from uniform range:
    
    range_fg <- range(angle_fg)
    ang_hits <- round(stats::runif(n = nr_matches, min = range_fg[1], max = range_fg[2]), 0)
    
  } else { # recycle angle_fg to len of nr_matches: 
    
    ang_hits <- recycle_vec(angle_fg, len = nr_matches)  
    
  }
  
  # (4) Combine default and matching angles (by logical indexing):
  ang_vec[logical_vec_matches] <- ang_hits   
  
  # Return: 
  return(ang_vec)
  
} # angle_map_match(). 

## Check:
# s <- "This  is a test that tests THIS function..."
# angle_map_match(s, angle_fg = 1)
# angle_map_match(s, "t", angle_fg = 3:9, case_sense = FALSE)
# angle_map_match(s, angle_fg = 1, angle_bg = -1)
# angle_map_match(s, angle_fg = 1:5, angle_bg = -6:-9)
# angle_map_match(s, "xyz", angle_fg = 8)  # no matches!
# 
# angle_map_match(s, pattern = NA)  # => Error!



## (6) Counting text strings (i.e., frequency of characters or words): ---------- 

## count_chars: Count the frequency of characters (in a text string x, as vector): -------- 

#' Count the frequency of characters in a string of text \code{x}.
#' 
#' \code{count_chars} provides frequency counts of the 
#' characters in a string of text \code{x} 
#' as a named numeric vector.
#' 
#' If \code{rm_specials = TRUE} (as per default), 
#' most special (or non-word) characters are 
#' removed and not counted. (Note that this currently works 
#' without using regular expressions.)
#' 
#' The quantification is case-sensitive and the resulting  
#' vector is sorted by name (alphabetically) or 
#' by frequency (per default). 
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
#' x <- c("Hello world!", "This is a 1st sentence.", 
#'        "This is the 2nd sentence.", "THE END.")
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
#' \code{\link{count_chars_words}} for counting both characters and words; 
#' \code{\link{plot_chars}} for a corresponding plotting function. 
#' 
#' @export

count_chars <- function(x, # string of text to count
                        case_sense = TRUE, 
                        rm_specials = TRUE, 
                        sort_freq = TRUE
){
  
  freq  <- NA  # initialize
  chars <- NA
  
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
    chars <- v4[!(v4 %in% spec_char)]
    
  } else {
    
    chars <- v4  # as is 
    
  } # if (rm_specials). 
  
  if (sort_freq){
    
    freq <- sort(table(chars), decreasing = TRUE)
    
  } else { # no sorting:
    
    freq <- table(chars)    
    
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
# (freq <- count_chars(x))
# typeof(freq)
# length(freq)
# freq["e"]


## count_words: Count the frequency of words (in a text string x, as vector): -------- 

#' Count the frequency of words in a string of text \code{x}.
#' 
#' \code{count_words} provides frequency counts of the 
#' words in a string of text \code{x} 
#' as a named numeric vector.
#' 
#' Special (or non-word) characters are removed and not counted. 
#' 
#' The quantification is case-sensitive and the resulting  
#' vector is sorted by name (alphabetically) or 
#' by frequency (per default).  
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
#'         "A third --- and also THE FINAL --- SENTENCE.")
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
#' \code{\link{count_chars_words}} for counting both characters and words; 
#' \code{\link{plot_chars}} for a character plotting function. 
#' 
#' @export

count_words <- function(x,  # string(s) of text
                        case_sense = TRUE, 
                        sort_freq = TRUE
){
  
  # 0. Initialize: 
  freq  <- NA
  words <- NA
  
  # 1. Handle inputs: 
  v0 <- as.character(x)
  
  if (case_sense){
    v1 <- v0  # as is
  } else {
    v1 <- tolower(v0)  # lowercase
  }
  
  # 2. Main: Split input into a vector of its words:
  words <- text_to_words(v1)
  
  # 3. Prepare outputs: 
  if (sort_freq){
    
    freq <- sort(table(words), decreasing = TRUE)
    
  } else { # no sorting:
    
    freq <- table(words)    
    
  } # if (sort_freq).
  
  return(freq)
  
} # count_words().

## Check:
# s3 <- c("A first sentence.", "The second sentence.",
#         "A third --- and also THE  FINAL --- sentence.")
# 
# count_words(s3)                      # case-sens, sorts by frequency
# count_words(s3, case_sense = FALSE)  # case insensitive
# count_words(s3, sort_freq = FALSE)   # sorts alphabetically
# 
# # Note: count_words returns a named vector of type integer:
# (freq <- count_words(s3))
# typeof(freq)
# length(freq)
# freq["and"]


## count_str: Count the number of occurrences of a pattern in a character vector x: -------- 

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

## Count the number of pattern matches in a string:

# (Note: Currently not exported, and not used.)

count_str <- function(x, pattern, split = ""){
  
  # initialize: 
  count   <- NA
  x_split <- NA
  
  x_split <- strsplit(x, split)
  
  # count <- unlist(lapply(x_split, function(z) stats::na.omit(length(grep(pattern = pattern, x = z, value = FALSE)))))
  
  count <- unlist(lapply(x_split, function(z) length(grep(pattern = pattern, x = z, value = FALSE))))
  
  return(count)
  
} # count_str(). 

## Check:
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


## cur_word_rest: Get rest of cur word (or next word part) in text string x from a current position i: ------

# (Note: Currently not exported, but used.)

cur_word_rest <- function(x, i){
  
  len_x <- nchar(x)
  no_word <- "[[:space:][:punct:]]"  # regex
  nwp <- NA 
  
  if (i > len_x){
    
    return(NA)
    
  } else {
    
    # Main: 
    remaining_chars <- substr(x, i, len_x)
    bounds_ls <- gregexpr(pattern = no_word, remaining_chars)  # location/lengths of all bounds (as list)
    bounds_vc <- unlist(bounds_ls[[1]])  # locations of all bounds (as vector)
    
    if (bounds_vc[1] == -1){  # no more bounds:
      nwp <- remaining_chars  # new word is all of remaining_chars
    } else {  # there are bounds: 
      nwp <- substr(remaining_chars, 1, (bounds_vc[1] - 1))  # word rest goes from HERE to (next bound - 1)
    }
    
  }
  
  return(nwp)
  
} # cur_word_rest(). 

## Check: 
# ts <- "=A test!"
# nchar(ts)
# cur_word_rest(ts, i = 1)
# cur_word_rest(ts, i = 2)
# cur_word_rest(ts, i = 3)
# cur_word_rest(ts, i = 4)
# cur_word_rest(ts, i = 7)
# cur_word_rest(ts, i = 8)


## char_word: Get all characters and their corresponding words (of a text string x, as df): ------ 

# Note: A special character is interpreted as a line break (between elements of x) 
#       and signaled by sep = "\n" in the function, but removed at the end.
# (Note: Currently not exported, but used.)

char_word <- function(x, sep = "\n", rm_sep = TRUE){
  
  # Initialize:
  no_word <- "[[:space:][:punct:]]"  # regex  
  # line_break_signal <- sep # "\n"  # carriage return (see ?"'" for character constants in R)
  
  # Inputs:
  x0 <- as.character(x)
  
  if (length(x0) > 1){ #  multi-element strings as input:
    # sep <- paste0(sep, line_break_signal) # signal line break
    x0 <- collapse_chars(x0, sep = sep)   # collapse (ADDING sep between elements). 
  }
  
  len_x <- nchar(x0)
  
  
  cur_char  <- rep("", len_x) 
  # first_char <- rep(NA, len_x)  # 4debugging 
  cur_word  <- rep("", len_x)
  
  
  if (len_x == 0){ # trivial case: 
    
    df <- data.frame(cur_char,
                     # first_char, # 4debugging 
                     cur_word, 
                     stringsAsFactors = FALSE)
    names(df) <- c("char", "word")
    
    return(df)  # return early!
    
  } else { # len_x > 0: 
    
    # (A) initial char:
    cur_char[1]  <- substr(x0, 1, 1)
    
    # Is initial char a new first char?
    if (grepl(no_word, x = cur_char[1])){
      
      # first_char[1] <- FALSE
      cur_word[1] <- ""  # no word
      
    } else { # cur_char is first_char:
      
      # first_char[1] <- TRUE
      cur_word[1] <- cur_word_rest(x0, i = 1)  # get new cur_word!
      
    } # if first char end.
    
    if (len_x > 2){  
      for (i in 2:len_x){
        
        # (B) middle chars:
        cur_char[i]  <- substr(x0, i, i)
        
        # Is current char a new first char?
        if (grepl(no_word, x = cur_char[(i - 1)])){ # previous char was NOT a word:
          
          if (grepl(no_word, x = cur_char[i])){ # If cur_char is NOT a word: 
            
            # first_char[i] <- FALSE
            cur_word[i]   <- ""  # no word
            
          } else { # cur_char is a new first_char:
            
            # first_char[i] <- TRUE
            cur_word[i] <- cur_word_rest(x0, i = i)  # get new cur_word!
            
          }
          
        } else { # previous char WAS (part of) a word:
          
          # first_char[i] <- FALSE 
          
          if (grepl(no_word, x = cur_char[i])){ # Is cur char NOT a word?
            
            cur_word[i]   <- ""  # no word
            
          } else { # cur_char is a new first_char:
            
            cur_word[i] <- cur_word[(i - 1)]  # keep last word
            
          }
        }
        
      } # loop i end. 
    } # (len_x > 2) end.
  } # (len_x > 0) end.  
  
  # Output: ---- 
  
  # Create df:
  df <- data.frame(cur_char,
                   # first_char, # 4debugging 
                   cur_word, 
                   stringsAsFactors = FALSE)
  names(df) <- c("char", "word")
  
  if (rm_sep) { # Remove any row with sep character: 
    df <- df[df$char != sep, ]
    row.names(df) <- 1:nrow(df)
  }
  
  return(df)
  
} # char_word(). 

## Check:
# char_word("Trivial case")
# # Key cases:
# st <- c("Does", "this", "work   well?")
# sum(nchar(st)) # 20 chars, 2 element breaks:
# char_word(st)  # works!
# # Note 2 problematic cases: 
# char_word(st, sep = "")  # FAILS to distinguish words at element boundaries!
# char_word(st, sep = " ", rm_sep = TRUE)  # works, but adds 2 spaces and remove ALL of them!
# # Working variants:
# char_word(st, sep = "\r")                  # adds and removes sep (by default)
# char_word(st, sep = "\r", rm_sep = FALSE)  # adds and keeps sep
# char_word(c("Does", "this", "work?"), sep = " ", rm_sep = TRUE)   # adds spaces and removes them
# char_word(c("Does", "this", "work?"), sep = " ", rm_sep = FALSE)  # adds spaces, without removing them
# # Single strings:
# char_word("The ? test etc.")
# char_word(" Hi! WOW?? Good!!!")
# char_word(" Hi! WOW?? Good!!!", sep = "asdf")  # no change, as only 1 string (no sep)
# ## Note:
# ms <- c("Nr. 1", "2nd etc.")
# char_word(ms)  # Numbers viewed as (parts of) words
# char_word(ms, sep = "|", rm_sep = FALSE)
# char_word("")


## count_chars_words: Count the frequency of chars and corresponding words in string(s) of text (by char): -------- 

#' Count the frequency of characters and words in a string of text \code{x}.
#'
#' \code{count_chars_words} provides frequency counts of the 
#' characters and words of a string of text \code{x} 
#' on a per character basis.
#' 
#' \code{count_chars_words} calls both \code{\link{count_chars}} and 
#' \code{\link{count_words}} and maps their results 
#' to a data frame that contains a row for each 
#' character of \code{x}. 
#' 
#' The quantifications are case-sensitive. 
#' Special characters (e.g., parentheses, punctuation, and spaces) 
#' are counted as characters, but removed from word counts. 
#' 
#' If input \code{x} consists of multiple text strings, 
#' they are collapsed with an added " " (space) between them. 
#'
#' @param x A string of text (required).
#' 
#' @param case_sense Boolean: Distinguish lower- vs. uppercase characters? 
#' Default: \code{case_sense = TRUE}. 
#' 
#' @param sep Dummy character(s) to insert between elements/lines 
#' when parsing a multi-element character vector \code{x} as input. 
#' This character is inserted to mark word boundaries in multi-element 
#' inputs \code{x} (without punctuation at the boundary).  
#' It should NOT occur anywhere in \code{x}, 
#' so that it can be removed again (by \code{rm_sep = TRUE}). 
#' Default: \code{sep = "|"} (i.e., insert a vertical bar between lines). 
#' 
#' @param rm_sep Should \code{sep} be removed from output? 
#' Default: \code{rm_sep = TRUE}.  
#' 
#' @return A data frame with 4 variables 
#' (\code{char}, \code{char_freq}, \code{word}, \code{word_freq}). 
#' 
#' @examples
#' s1 <- ("This test is to test this function.")
#' head(count_chars_words(s1))
#' head(count_chars_words(s1, case_sense = FALSE))
#' 
#' s3 <- c("A 1st sentence.", "The 2nd sentence.", 
#'         "A 3rd --- and also THE  FINAL --- SENTENCE.")
#' tail(count_chars_words(s3))
#' tail(count_chars_words(s3, case_sense = FALSE))
#' 
#' @family text objects and functions
#'
#' @seealso
#' \code{\link{count_chars}} for counting the frequency of characters;  
#' \code{\link{count_words}} for counting the frequency of words;   
#' \code{\link{plot_chars}} for a character plotting function. 
#' 
#' @export

count_chars_words <- function(x, case_sense = TRUE, sep = "|", rm_sep = TRUE){
  
  # Initialize:
  # no_word <- "[[:space:][:punct:]]"  # regex  
  # line_break_signal <- "\r"  # carriage return (see ?"'" for character constants in R)
  
  # Inputs:
  x0 <- as.character(x)
  
  if (length(x0) > 1){ #  multi-element strings as input:
    # sep <- paste0(sep, line_break_signal) # signal line break
    
    if (sep %in% text_to_chars(x, sep = "")){
      # print(text_to_chars(x, sep = ""))  # 4debugging
      message("count_chars_words: sep character should not occur in x!")
    }
    
    x0 <- collapse_chars(x0, sep = sep)   # collapse (ADDING sep between elements). 
  }
  
  
  
  if (!case_sense) {
    x0 <- tolower(x0)  # work with lowercase x (everywhere)
  }
  
  # Convert x0 into vector & data frame:
  char_vc <- text_to_chars(x = x0)
  char_df <- as.data.frame(char_vc)  # as df
  names(char_df) <- c("char_0")
  char_df$ix <- 1:nrow(char_df)  # add ix of row (to enable sorting by it later)
  
  # Get stats (using x0, NOT char_df$char):
  # 1. Get character frequency:
  char_freq_vc <- count_chars(x = x0, case_sense = case_sense, rm_specials = FALSE, sort_freq = FALSE)  # (named) vector
  char_freq_df <- as.data.frame(char_freq_vc)  # as df
  names(char_freq_df) <- c("char_1", "char_freq")
  
  
  # 2. Map/merge char_freq to char_df:
  # NOTE that merge() has trouble merging characters with different ("t" vs. "T") cases!
  mdf <- merge(x = char_df, y = char_freq_df, 
               by.x = "char_0", by.y = "char_1", 
               all.x = TRUE, sort = FALSE, no.dups = FALSE)
  
  # Note that merge changes row order:
  mdf <- mdf[order(mdf$ix), ]  # restore original char order (ix)
  
  
  # 3. Determine the containing word for each char in char_vc:
  char_word_df <- char_word(x = x0, sep = sep, rm_sep = FALSE)  # use helper function (on x0)!  
  # char_word_df <- char_word(x = x, sep = sep)  # use helper function (on x, yields ERROR)!
  
  if (nrow(char_word_df) == nrow(mdf)){  # check for same nrow() in both df:
    
    mdf$word <- char_word_df$word  # add word to mdf  
    
  } else {
    
    message("count_chars_words: nrow() of 2 dfs differ, but should not.")
    
  }
  
  
  # 4. Get word frequency (using x0): 
  word_freq_vc <- count_words(x = x0, case_sense = case_sense, sort_freq = FALSE)  # (named) vector
  word_freq_df <- as.data.frame(word_freq_vc)  # as df
  names(word_freq_df) <- c("word_2", "word_freq")
  
  
  # 5. Map/merge word_freq to char_df: 
  mdf <- merge(x = mdf, y = word_freq_df, 
               by.x = "word", by.y = "word_2", 
               all.x = TRUE, sort = FALSE, no.dups = FALSE)
  
  # Note that merge changes row and col order:
  mdf <- mdf[order(mdf$ix), ]  # restore original char order (ix):
  mdf <- mdf[ , order(names(mdf))]  # sort column order
  
  
  # 6. Output: 
  row.names(mdf) <- 1:nrow(mdf)             # add row names 1:n
  mdf <- mdf[, -which(names(mdf) == "ix")]  # remove "ix" column
  names(mdf) <- c("char", "char_freq", "word", "word_freq")  # set names
  
  if (rm_sep) { # Remove sep char at line breaks:
    mdf <- mdf[mdf$char != sep, ]
    row.names(mdf) <- 1:nrow(mdf)
  }
  
  return(mdf)
  
} # count_chars_words(). 

## Check:
# s1 <- "A TEST to test a fn."
# count_chars_words(s1)
# count_chars_words(s1, sep = "asdf")  # no effect, as only 1 string in x.
# count_chars_words(s1, case_sense = FALSE)  # counts change
# 
# # Multiple text strings:
# s2 <- c("Hello world", "This is a TEST to test this great function",
#         "Does this work?", "That's very good", "Please carry on.")
# sum(nchar(s2)) # 100 chars, 
# length(s2)     #   5 elements => 4 line breaks!
# count_chars_words(s2)  # seems to work, BUT note:
# count_chars_words(s2, case_sense = FALSE)
# count_chars_words(s2, sep = "")  # ==> ERROR at line boundaries without delimiters!    +++ here now +++
# count_chars_words(s2, sep = "|", rm_sep = TRUE)  # works, but requires a unique sep character!!!
# count_chars_words(s2)  # works, but requires a unique sep character!!!
# count_chars_words(s2, sep = "|", rm_sep = FALSE)  # Shows & counts sep char (without removing it)
# # Note warnings:
# count_chars_words(s2, sep = " ", rm_sep = FALSE)  # Works, but adds space as sep char (without removing it)
# count_chars_words(s2, sep = " ")  # Adds space as sep char (AND removes it -- with ALL other spaces)!
# # Note some remaining issues:
# count_chars_words(s2, sep = "\n")  # fails to count words at line boundaries, unfortunately!
# count_chars_words(s2, sep = "\n", rm_sep = FALSE) # fails to count words at line boundaries, unfortunately!
# 
# s3 <- c("A 1st sentence", "The 2nd sentence.",
#         "A 3rd --- and THE  FINAL --- sentence.")
# head(count_chars_words(s3))
# head(count_chars_words(s3, case_sense = FALSE))  # Check counts for a/A, i/I, and t/T!
# tail(count_chars_words(s3))
# tail(count_chars_words(s3, case_sense = FALSE))


## map_text_regex: Map text to coordinates, with regex magic for additional columns: -------- 

# Goal: Use the non-visual/non-plotting related parts of plot_chars() to create a 
#       map_text_regex() function that calls map_text_coord(), plus optional   
#       regular expressions (regex) for creating additional custom columns (col_fg/col_bg/angle).

#' Map text to character table (allowing for matching patterns).
#'
#' \code{map_text_regex} parses text (from a file or user input) 
#' into a data frame that contains a row for each 
#' character of \code{x}. 
#' 
#' \code{map_text_regex} allows for regular expression (regex) 
#' to match text patterns and create corresponding variables 
#' (e.g., for color or orientation). 
#' 
#' Five regular expressions and corresponding 
#' color and angle arguments allow identifying, 
#' marking (highlighting or de-emphasizing), and rotating 
#' those sets of characters (i.e, their text labels or fill colors).
#' that match the provided patterns. 
#' 
#' The plot generated by \code{plot_chars} is character-based: 
#' Individual characters are plotted at equidistant x-y-positions 
#' and the aesthetic settings provided for text labels and tile fill colors.
#' 
#' \code{map_text_regex} returns a plot description (as a data frame). 
#' Using this output as an input to \code{\link{plot_charmap}} plots 
#' text in a character-based fashion (i.e., individual characters are 
#' plotted at equidistant x-y-positions). 
#' Together, both functions replace the over-specialized 
#' \code{\link{plot_chars}} and \code{\link{plot_text}} functions.
#' 
#' @return A data frame describing a plot.
#' 
#' @param x The text to map or plot (as a character vector). 
#' Different elements denote different lines of text. 
#' If \code{x = NA} (as per default), 
#' the \code{file} argument is used to read 
#' a text file or user input from the Console. 
#' 
#' @param file A text file to read (or its path). 
#' If \code{file = ""} (as per default), 
#' \code{scan} is used to read user input from the Console. 
#' If a text file is stored in a sub-directory, 
#' enter its path and name here (without any leading or 
#' trailing "." or "/"). 
#' 
#' @param lbl_hi Labels to highlight (as regex). 
#' Default: \code{lbl_hi = NA}. 
#' 
#' @param lbl_lo Labels to de-emphasize (as regex). 
#' Default: \code{lbl_lo = NA}. 
#' 
#' @param bg_hi Background tiles to highlight (as regex). 
#' Default: \code{bg_hi = NA}. 
#' 
#' @param bg_lo Background tiles to de-emphasize (as regex). 
#' Default: \code{bg_lo = "[[:space:]]"}.
#' 
#' @param lbl_rotate Labels to rotate (as regex). 
#' Default: \code{lbl_rotate = NA}. 
#' 
#' @param case_sense Boolean: Distinguish 
#' lower- vs. uppercase characters in pattern matches? 
#' Default: \code{case_sense = TRUE}. 
#' 
#' @param lbl_tiles Are character labels shown? 
#' This enables pattern matching for (fg) color and 
#' angle aesthetics. 
#' Default: \code{lbl_tiles = TRUE} (i.e., show labels). 
#' 
#' @param col_lbl Default color of text labels.
#' Default: \code{col_lbl = "black"}. 
#' 
#' @param col_lbl_hi Highlighting color of text labels.
#' Default: \code{col_lbl_hi = pal_ds4psy[[1]]}. 
#' 
#' @param col_lbl_lo De-emphasizing color of text labels.
#' Default: \code{col_lbl_lo = pal_ds4psy[[9]]}.
#' 
#' @param col_bg Default color to fill background tiles.
#' Default: \code{col_bg = pal_ds4psy[[7]]}. 
#' 
#' @param col_bg_hi Highlighting color to fill background tiles.
#' Default: \code{col_bg_hi = pal_ds4psy[[4]]}. 
#' 
#' @param col_bg_lo De-emphasizing color to fill background tiles.
#' Default: \code{col_bg_lo = "white"}.
#' 
#' @param col_sample Boolean: Sample color vectors (within category)?
#' Default: \code{col_sample = FALSE}. 
#' 
#' @param angle_fg Angle(s) for rotating character labels 
#' matching the pattern of the \code{lbl_rotate} expression. 
#' Default: \code{angle_fg = c(-90, 90)}. 
#' If \code{length(angle_fg) > 1}, a random value 
#' in uniform \code{range(angle_fg)} is used for every character. 
#' 
#' @param angle_bg Angle(s) of rotating character labels 
#' not matching the pattern of the \code{lbl_rotate} expression. 
#' Default: \code{angle_bg = 0} (i.e., no rotation). 
#' If \code{length(angle_bg) > 1}, a random value 
#' in uniform \code{range(angle_bg)} is used for every character. 
#' 
#' @examples 
#' ## (1) From text string(s): 
#' ts <- c("Hello world!", "This is a test to test this splendid function",
#'         "Does this work?", "That's good.", "Please carry on.")
#' sum(nchar(ts))
#' 
#' # (a) simple use:
#' map_text_regex(ts) 
#' 
#' # (b) matching patterns (regex):
#' map_text_regex(ts, lbl_hi = "\\b\\w{4}\\b", bg_hi = "[good|test]",
#'                lbl_rotate = "[^aeiou]", angle_fg = c(-45, +45))
#' 
#' ## (2) From user input:
#' # map_text_regex()  # (enter text in Console)
#'  
#' ## (3) From text file:
#' # cat("Hello world!", "This is a test file.",
#' #     "Can you see this text?",
#' #     "Good! Please carry on...",
#' #     file = "test.txt", sep = "\n")
#' # 
#' # map_text_regex(file = "test.txt")  # default
#' # map_text_regex(file = "test.txt", lbl_hi = "[[:upper:]]", lbl_lo = "[[:punct:]]",
#' #                col_lbl_hi = "red", col_lbl_lo = "blue")
#' # 
#' # map_text_regex(file = "test.txt", lbl_hi = "[aeiou]", col_lbl_hi = "red",
#' #                col_bg = "white", bg_hi = "see")  # mark vowels and "see" (in bg)
#' # map_text_regex(file = "test.txt", bg_hi = "[aeiou]", col_bg_hi = "gold")  # mark (bg of) vowels
#' # 
#' # # Label options:
#' # map_text_regex(file = "test.txt", bg_hi = "see", lbl_tiles = FALSE)
#' # map_text_regex(file = "test.txt", angle_bg = c(-20, 20))
#' # 
#' # unlink("test.txt")  # clean up (by deleting file). 
#'
#' @family text objects and functions
#'
#' @seealso
#' \code{\link{map_text_coord}} for mapping text to a table of character coordinates; 
#' \code{\link{plot_charmap}} for plotting character maps; 
#' \code{\link{plot_chars}} for creating and plotting character maps; 
#' \code{\link{plot_text}} for plotting characters and color tiles by frequency; 
#' \code{\link{read_ascii}} for reading text inputs into a character string. 
#' 
#' @import ggplot2
#' @importFrom grDevices colorRampPalette 
#' @importFrom stats runif
#' 
#' @export 

map_text_regex <- function(x = NA,     # Text string(s) to plot 
                           file = "",  # "" reads user input from console; "test.txt" reads from file
                           
                           # 5 regex patterns (to emphasize and de-emphasize matching characters in text string): 
                           lbl_hi = NA, # "asdf",   # [[:upper:]]",   # labels to highlight (as regex)
                           lbl_lo = NA, # "qwer",   # [[:punct:]]",   # labels to de-emphasize (as regex)
                           bg_hi  = NA, # "zxcv",   # background tiles to highlight (as regex)
                           bg_lo  = "[[:space:]]",  # background tiles to de-emphasize (as regex)
                           lbl_rotate = NA,         # "[^[:space:]]",  # pattern for labels to rotate (as regex)
                           case_sense = TRUE,       # distinguish lower/uppercase (in pattern matching)?
                           
                           # labels (text):
                           lbl_tiles = TRUE,  # show labels (using col_lbl_? below)
                           
                           # 6 colors (of labels and tiles): 
                           col_lbl = "black",             # default text label color
                           col_lbl_hi = pal_ds4psy[[1]],  # highlighted labels (matching lbl_hi)
                           col_lbl_lo = pal_ds4psy[[9]],  # de-emphasized labels (matching lbl_lo)
                           col_bg = pal_ds4psy[[7]],      # default tile fill color
                           col_bg_hi = pal_ds4psy[[4]],   # highlighted tiles (matching bg_hi)
                           col_bg_lo = "white",           # de-emphasized tiles (matching bg_lo)
                           col_sample = FALSE,            # sample from color vectors (within category)?
                           
                           # 2 angles (of labels):
                           angle_fg = c(-90, 90),  # angle(s) of labels matching the lbl_rotate pattern
                           angle_bg = 0            # default angle(s) & labels NOT matching the lbl_rotate pattern 
){
  
  # (0) Inputs: ------  
  
  # Labels: 
  if (!lbl_tiles) {col_lbl <- NA}
  
  
  # (1) Read text input into a text string (txt) and character table (tb_txt): ------ 
  
  tb_txt <- map_text_or_file(x = x, file = file, flip_y = TRUE)  # use text helper function
  # nr_txt <- nrow(tb_txt)  # (elements/nrows of x/text)
  
  
  # (2) Get chars in tb_txt$char (as a single string): ------ 
  
  char_s <- chars_to_text(x = tb_txt$char)  # turns char vector into a text string (of length 1) 
  n_char <- nchar(char_s)
  
  
  # (3) Color maps (for fg/labels and bg/tiles, based on regex matches): ------  
  
  # Apply 2x2 regex patterns to color char_s (to highlight/de-emphasize both labels and tiles, i.e., fg and bg): 
  # Meth: Use color_map_match() repeatedly to match a regex to a text string and return a vector of colors. 
  # Goal: Create 2 color vectors (fg/bg, with 3 levels of color each). 
  
  # (a) Text labels (fg):
  if (lbl_tiles) {
    
    # col_lbl <- rep(col_lbl, n_char)  # 0. initialize col_lbl (as a vector)
    col_lbl <- recycle_vec(col_lbl, len = n_char)  # 0. initialize (to len of n_char)
    
    if (col_sample) { col_lbl <- sample(col_lbl) }
    
    if (!is.na(lbl_lo)){  # 1. add col_lbl_lo to matches of lbl_lo: 
      col_lbl <- color_map_match(char_s, pattern = lbl_lo, case_sense = case_sense, 
                                 col_fg = col_lbl_lo, col_bg = col_lbl, col_sample = col_sample) 
    }
    
    if (!is.na(lbl_hi)){  # 2. add col_lbl_hi to matches of lbl_hi: 
      col_lbl <- color_map_match(char_s, pattern = lbl_hi, case_sense = case_sense, 
                                 col_fg = col_lbl_hi, col_bg = col_lbl, col_sample = col_sample) 
    }
    
  } # if (lbl_tiles) end.
  
  # (b) Tile fill colors (bg):
  
  # col_bgv <- rep(col_bg, n_char)  # 0. initialize col_bgv (as a vector)
  col_bgv <- recycle_vec(col_bg, len = n_char)  # 0. initialize (to len of n_char)
  
  if (col_sample) { col_bgv <- sample(col_bgv) }
  
  if (!is.na(bg_lo)){  # 1. add col_bg_lo to matches of bg_lo: 
    col_bgv <- color_map_match(char_s, pattern = bg_lo, case_sense = case_sense, 
                               col_fg = col_bg_lo, col_bg = col_bgv, col_sample = col_sample) 
  }
  
  if (!is.na(bg_hi)){  # 2. add col_bg_hi to matches of bg_hi:
    col_bgv <- color_map_match(char_s, pattern = bg_hi, case_sense = case_sense, 
                               col_fg = col_bg_hi, col_bg = col_bgv, col_sample = col_sample)
  }
  
  
  # (4) Angle/rotation/orientation maps (for labels, based on regex matches): ------
  
  char_angles <- 0  # initialize
  
  if (lbl_tiles) {
    
    if (!is.na(lbl_rotate)){  # Apply angle_fg and angle_bg (based on pattern matching):
      
      char_angles <- angle_map_match(char_s, pattern = lbl_rotate, case_sense = case_sense, 
                                     angle_fg = angle_fg, angle_bg = angle_bg)
      
    } else {  # Default: Apply the value(s) of angle_bg to ALL characters: 
      
      if (length(angle_bg) > 1){
        rangel <- range(angle_bg)
        char_angles <- round(stats::runif(n = n_char, min = rangel[1], max = rangel[2]), 0)
      } else {
        char_angles <- angle_bg
      }
      
    }
    
  } # if (lbl_tiles) end.
  
  
  # (5) Add aesthetic (color/angle) vectors to tb_txt: ------ 
  
  tb_txt$col_fg <- col_lbl
  tb_txt$col_bg <- col_bgv
  tb_txt$angle  <- char_angles
  
  
  # (-) Plot tb_txt (using ggplot2): ------  
  
  # Moved plotting functionality to a specialized plot_charmap() function! 
  
  
  # (6) Output: ------ 
  
  return(tb_txt)
  
} # map_text_regex(). 

## Check:
# ts <- c("Hello world!", "This is a test to test this splendid function",
#          "Does this work?", "That's good.", "Please carry on.")
# sum(nchar(ts))
# 
# ## (a) basic use:
# map_text_regex(ts)
#
# ## (b) with pattern matching:
# cm <- map_text_regex(ts, lbl_hi = "\\b\\w{4}\\b", bg_hi = "[good|test]",
#                      lbl_rotate = "[^aeiou]", angle_fg = c(-45, +45))
# cm
# 
# plot_charmap(cm)  # intended use in pipe: map_text_regex(x) %>% plot_charmap()


## map_text_freqs: Map text to coordinates, with character and word frequency counts: -------- 

# Goal: Combine functionalities of 
# 1. map_text_or_file() 
# 2. count_chars_words()
# into a single character map (with 2 numeric columns for character and word frequency). 

# +++ here now +++ 

map_text_freqs <- function(x = NA,     # Text string(s) to plot 
                           file = "",  # "" reads user input from console; "test.txt" reads from file
                           case_sense = TRUE,  # distinguish lower/uppercase (in frequency counts)?
                           sep = "|"   # line break, temporarily added and removed (must NOT be in x)
){
  
  # (0) Initialize: 
  txt <- NA
  mdf <- NA
  out <- NA
  
  # (1) Read text input into a single text string (txt) without collapsing multiple strings: ------ 
  
  txt <- read_text_or_file(x = x, file = file, collapse = FALSE, sep = sep)
  # Note: NOT collapsing x does also not use sep here!
  n_char <- sum(nchar(txt)) 
  
  
  # (2) Map text string input into a character table (tb_txt): ------ 
  
  tb_txt <- map_text_or_file(x = txt, file = NA, flip_y = TRUE)  # use text helper function
  nr_txt <- nrow(tb_txt)  # (elements/nrows of x/text)
  
  tb_txt$ix <- 1:nr_txt  # add ix of row (to enable sorting by it later) 
  
  
  ## (+) Get chars in tb_txt$char (as a single string): ------ 
  
  # char_s <- chars_to_text(x = tb_txt$char)  # turns char vector into a text string (of length 1)
  # n_char <- nchar(char_s)
  
  if (nr_txt != n_char){  # Check: 
    message(paste0("map_text_freqs: nr_txt = ", nr_txt, " and n_char = ", n_char, " differ!"))
  }
  
  
  # (3) Get frequency counts of characters and words: ------ 
  
  # tb_freq <- count_chars_words(x = char_s, case_sense = case_sense, sep = "")  # use char_s (with no extra spaces)!
  tb_freq <- count_chars_words(x = txt, case_sense = case_sense, sep = sep, rm_sep = TRUE)  # use txt (with no extra spaces)!
  
  tb_freq$ix_2 <- 1:nrow(tb_freq)  # add ix_2 of row (to enable sorting by it later) 
  
  names(tb_freq) <- c("char_2", "char_freq", "word", "word_freq", "ix_2")
  
  
  # (4) Combine both tables: ------ 
  
  # NOTE that merge() has trouble merging characters with different ("t" vs. "T") cases!
  mdf <- merge(x = tb_txt, y = tb_freq, 
               by.x = "ix", by.y = "ix_2", 
               all.x = TRUE, sort = FALSE, no.dups = FALSE)
  
  # Note that merge changes row order:
  mdf <- mdf[order(mdf$ix), ]  # restore original char order (ix)
  mdf <- mdf[, sort(names(mdf))]   
  
  # (5) Output: ------ 
  
  ix_ix <- which("ix" == names(mdf))
  ix_c2 <- which("char_2" == names(mdf))
  out <- mdf[ , c(-ix_ix, -ix_c2)]
  
  
  return(out)
  
} # map_text_freqs(). 

## Check:
# ts <- c("Hello world! ", "This is a TEST to test this splendid function",
#         "Does this work?", "That's good", "Please carry on.")
# sum(nchar(ts))
# 
## (a) basic use:
# map_text_freqs(x = ts)
# map_text_freqs(x = ts, case_sense = FALSE)
# 
# ## Note: sep must not occur in x:
# map_text_freqs(x = c("a", "b|", "c||"))  # problematic, as sep = "|" 
# map_text_freqs(x = c("a", "b|", "c||", " d| "), sep = "*")  # problematic, as sep = "|" 
# map_text_freqs(x = c("one|two", "one|four", " two "), sep = ":")



## Done: ---------- 

# - Added map_text_regex() that performs all non-plotting parts of plot_chars(). [2021-04-26]
# - Added map_text_or_file() that combines read_ascii() with map_text_coord(). [2021-04-26]
# 
# - Split read_ascii() into 2 functions [2021-04-22]:
#   A. new read_ascii(): Read a file into a string of text x.
#   B. new map_text_chars() and simpler map_text_coord(): Turn a string of text x into a table (with x/y-coordinates). 
#   Reason: Enabled use of map_text_coord() separately (i.e., mapping strings of text)!
# 
# - Added more character/word/text combination/splitting functions.


## ToDo: ----------

# Specific:
# - improve read_ascii() and map_text_chars() (with regex and more efficient text wrangling)
# - Add an exception argument except to capitalize() function 
#   (to exclude all words matching an exception argument).
# 
# General: Write functions to:
# - mix alpha-numeric content (letters, words, numbers...) with noise (punctuation, space, random characters)


## eof. ----------------------