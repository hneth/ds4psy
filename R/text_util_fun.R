## text_util_fun.R | ds4psy
## hn | uni.kn | 2022 06 28
## ---------------------------

## (0) Utility functions for string manipulation and text/character objects. ------ 

## (A) Defining character vectors and strings of text: ---------- 

# Umlaute / German umlauts: ------ 

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


# metachar: Meta-characters of extended regular expressions (in R): ------ 

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


# cclass: A (named) vector of different character classes (in R): ------ 

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


# Other/specific text elements (for ds4psy course materials): ------ 

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




## (B) Converting text strings (between units, e.g., sentences, words, characters): ---------- 


# collapse_chars: Turn a multi-element character string into a 1-element character string: ------ 

# Goal: A utility function to ensure that multi-element text inputs are handled consistently.
# Note: sep is ONLY used when collapsing multi-element strings and inserted BETWEEN elements. 

#' Collapse character inputs \code{x} into a single string. 
#' 
#' \code{collapse_chars} converts multi-element character inputs \code{x} 
#' into a single string of text (i.e., a character object of length 1), 
#' separating its elements by \code{sep}. 
#' 
#' As \code{collapse_chars} is mostly a wrapper around 
#' \code{paste(x, collapse = sep)}. 
#' It preserves spaces within the elements of \code{x}. 
#' 
#' The separator \code{sep} is only used when collapsing multi-element vectors 
#' and inserted between elements.
#' 
#' See \code{\link{chars_to_text}} for combining character vectors into text. 
#' 
#' @param x A vector (required), typically a character vector. 
#' 
#' @param sep A character inserted as separator/delimiter 
#' between elements when collapsing multi-element strings of \code{x}.  
#' Default: \code{sep = " "} (i.e., insert 1 space between elements). 
#' 
#' @return A character vector (of length 1). 
#' 
#' @examples
#' collapse_chars(c("Hello", "world", "!"))
#' collapse_chars(c("_", " _ ", "  _  "), sep = "|")  # preserves spaces
#' writeLines(collapse_chars(c("Hello", "world", "!"), sep = "\n"))
#' collapse_chars(1:3, sep = "")
#' 
#' @family text objects and functions
#'
#' @seealso
#' \code{\link{chars_to_text}} for combining character vectors into text; 
#' \code{\link{text_to_chars}} for splitting text into a vector of characters; 
#' \code{\link{text_to_words}} for splitting text into a vector of words; 
#' \code{\link{strsplit}} for splitting strings. 
#' 
#' @export

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
  
} # collapse_chars(). 

## Check:
# collapse_chars(c("Hello", "world", "!"))
# collapse_chars(c("_", " _ ", "  _  "), sep = "|")  # preserves spaces
# writeLines(collapse_chars(c("Hello", "world", "!"), sep = "\n"))  # new line sep
# collapse_chars(1:3, sep = "")  # works for numeric vectors!
# # Special cases:
# collapse_chars(NA)
# collapse_chars("")



# text_to_sentences: Turn a text (consisting of one or more strings) into a vector of all its sentences: ------ 

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


# text_to_words: Turn a text (consisting of one or more strings) into a vector of its words: ------ 

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
#' \code{\link{text_to_words}} for splitting a text into its words; 
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


# text_to_words_regex: Alternative to text_to_words (using 1 regex): -------- 

# (Note: Currently not exported, and not used.)

text_to_words_regex <- function(x){
  
  unlist(regmatches(x, gregexpr(pattern = "\\w+", x)))
  
}

## Check:
# s2 <- c("This is  a  test.", "Does this work?")
# text_to_words_regex(s2)
# text_to_words_regex(s3)


# text_to_chars: Turn a text (consisting of one or more strings) into a vector of its characters: ------ 

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
#' \code{text_to_chars} is an inverse function of \code{\link{chars_to_text}}. 
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
#' @aliases str2vec
#'
#' @seealso
#' \code{\link{chars_to_text}} for combining character vectors into text; 
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
    space   <- c("", " ")  # [[:space:]]
    hyphens <- c("-", "--", "---")
    punct   <- c(",", ";", ":", ".", "!", "?")  # punctuation [[:punct:]]  
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


# words_to_text: Turn a vector of words x into a (single) vector: ------ 

#' Paste or collapse words \code{x} into a text. 
#' 
#' \code{words_to_text} pastes or collapses 
#' a character string \code{x} into a text. 
#' 
#' Internally, \code{words_to_text} only invokes the \strong{base} R function 
#' \code{\link{paste}} with the \code{collapse} argument. 
#' 
#' @param x A string of text (required), typically a character vector. 
#' 
#' @param collapse A character string to separate the elements of \code{x} 
#' in the resulting text. 
#' Default: \code{collapse = " "}. 
#' 
#' @return A text (as a collapsed character vector). 
#'
#' @examples
#' x <- c("Hello world!", "A 1st sentence.", "A 2nd sentence.", "The end.")
#' words_to_text(x)
#' cat(words_to_text(x, collapse = "\n"))
#' 
#' @family text objects and functions
#'
#' @seealso
#' \code{\link{text_to_words}} for splitting a text into its words; 
#' \code{\link{text_to_sentences}} for splitting text into a vector of sentences;  
#' \code{\link{text_to_chars}} for splitting text into a vector of characters;  
#' \code{\link{count_words}} for counting the frequency of words; 
#' \code{\link{strsplit}} for splitting strings. 
#' 
#' @export

words_to_text <- function(x, collapse = " "){
  
  paste(x, collapse = collapse)
  
} # words_to_text(). 

## Check:
# words_to_text(wv)  # (using wv from above)
# words_to_text(c("This", "is only", "a test"))
# cat(words_to_text(wv, collapse = "\n"))


# chars_to_text: Turn a character vector x into a (single) string of text (preserving punctuation and spaces): ------

# Inverse of text_to_chars() above:  
# Assume that x consists of individual characters, but may contain spaces. 
# Goal: Exactly preserve all characters (e.g., punctuation and spaces).
# (Note: Simply using paste(x, collapse = "") would lose all spaces.) 

#' Combine character inputs \code{x} into a single string of text. 
#' 
#' \code{chars_to_text} combines multi-element character inputs \code{x} 
#' into a single string of text (i.e., a character object of length 1), 
#' while preserving punctuation and spaces. 
#' 
#' \code{chars_to_text} is an inverse function of \code{\link{text_to_chars}}. 
#' 
#' Note that using \code{paste(x, collapse = "")} would remove spaces. 
#' See \code{\link{collapse_chars}} for a simpler alternative with 
#' a \code{sep} argument. 
#' 
#' @param x A vector (required), typically a character vector. 
#' 
#' @return A character vector (of length 1). 
#' 
#' @examples
#' # (a) One string (with spaces and punctuation):
#' t1 <- "Hello world! This is _A   TEST_. Does this work?"
#' (cv <- unlist(strsplit(t1, split = "")))
#' (t2 <- chars_to_text(cv))
#' t1 == t2
#' 
#' # (b) Multiple strings (nchar from 0 to >1):
#' s <- c("Hi", " ", "", "there!", " ", "", "Does  THIS  work?")
#' chars_to_text(s)
#' 
#' # Note: Not inserting spaces between elements:
#' chars_to_text(c("Hi there!", "How are you today?"))
#' chars_to_text(1:3)
#'  
#' @alias vec2str 
#' 
#' @family text objects and functions
#'
#' @seealso
#' \code{\link{collapse_chars}} for collapsing character vectors with \code{sep}; 
#' \code{\link{text_to_chars}} for splitting text into a vector of characters; 
#' \code{\link{text_to_words}} for splitting text into a vector of words; 
#' \code{\link{strsplit}} for splitting strings. 
#' 
#' @export

chars_to_text <- function(x){
  
  # Initialize:
  x0 <- as.character(x)
  char_t <- NA
  
  # Ensure that x0 consists only of individual characters:
  if (any(nchar(x0) > 1)){
    one_cv <- paste(x0, collapse = "")  # paste/collapse all into a single char vector
    char_v <- unlist(strsplit(one_cv, split = ""))  # split into a vector of individual characters
  } else {
    char_v <- x0  # use vector of single characters
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
# # (a) One string (with spaces and punctuation):
# t1 <- "Hello world! This is _A   TEST_. Does this work?"
# (cv <- unlist(strsplit(t1, split = "")))
# (t2 <- chars_to_text(cv))
# t1 == t2
# 
# # (b) Multiple strings (nchar from 0 to >1):
# s <- c("Hi", " ", "", "there!", " ", "", "Does  THIS  work?")
# chars_to_text(s)
# 
# # Note: Not inserting spaces between elements:
# chars_to_text(c("Hi there!", "How are you today?"))
# chars_to_text(1:3)


## (C) Miscellaneous text/string utility functions: ------ 

# Source: From string_fun.R  | i2ds  | 2022 06 26
# Redundant functions for manipulating/transforming character strings: ------ 

# vec2str: Turn a vector of symbols into a character string: ------
#          (Redundant to chars_to_text() and collapse_chars() above.)

# vec2str <- function(v) {
#   
#   paste(v, collapse = "")
#   
#   # Note: Simply using paste(v, collapse = "") loses all spaces.
#   # Better: chars_to_text() preserves spaces (see above). 
#   
# } # vec2str(). 


# str2vec: Turn a character string into a vector (of 1-symbol character elements): ------ 
#          (Redundant to text_to_chars() above.)

# str2vec <- function(s){
#   
#   unlist(strsplit(s, split = ""))  # assumes ONLY 1-symbol elements/digits
#   
# } # str2vec(). 


## Done: ----------

# - Document and export collapse_chars() AND chars_to_text().  
# - Replace vec2str() and str2vec() by superior functions in text_fun.R 


## ToDo: ----------

# - etc.

## eof. ----------------------