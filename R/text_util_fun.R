## text_util_fun.R | ds4psy
## hn | uni.kn | 2022 06 26
## ---------------------------

## Utility functions for string manipulation and text/character objects. 

## (0) Text helper/utility functions: ----------

# Source: From string_fun.R  | i2ds  | 2022 06 26
# Functions for manipulating/transforming character strings: ------ 

# vec2str: Turn a vector of symbols into a character string: ------

# (See collapse_chars() AND chars_to_text() in ds4psy package.)

vec2str <- function(v) {
  
  paste(v, collapse = "")
  
  # Note: Simply using paste(v, collapse = "") loses all spaces.
  #       ds4psy::chars_to_text() preserves spaces. 
  
} # vec2str(). 



# str2vec: Turn a character string into a vector (of 1-symbol character elements): ------ 

# (See text_to_chars() in ds4psy package.)

str2vec <- function(s){
  
  unlist(strsplit(s, split = ""))  # assumes ONLY 1-symbol elements/digits
  
} # str2vec(). 


## ToDo: ----------

# - Replace vec2str() and str2vec() by superior functions in text_fun.R 
# - etc.

## eof. ----------------------