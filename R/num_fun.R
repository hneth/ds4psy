## num_fun.R | ds4psy
## hn | uni.kn | 2024 01 17
## ------------------------

## Main functions for manipulating/transforming numbers or numeric symbols/digits: ------ 

# Note: Most functions here are classified as belonging to the 
#       family of "numeric" AND "utility" functions. 


## (0) Note utility functions for numbers and numeric symbols/digits in num_util_fun.R! --------


## (1) Converting numerals from decimal notation to other base/radix values: -------- 

# base2dec: Convert a base N numeral string (of digits) into a decimal number: ------ 

#' Convert a string of numeral digits from some base into decimal notation 
#' 
#' \code{base2dec} converts a sequence of numeral symbols (digits) 
#' from its notation as positional numerals (with some base or radix)
#' into standard decimal notation (using the base or radix of 10). 
#' 
#' The individual digits provided in \code{x} (e.g., from "0" to "9", "A" to "F") 
#' must be defined in the specified base (i.e., every digit value must be lower 
#' than the base or radix value). 
#' See \code{\link{base_digits}} for the sequence of default digits. 
#' 
#' @details 
#' \code{base2dec} is the complement of \code{\link{dec2base}}. 
#' 
#' @return An integer number (in decimal notation). 
#' 
#' @param x A (required) sequence of numeric symbols 
#' (as a character sequence or vector of digits). 
#' 
#' @param base The base or radix of the symbols in \code{seq}. 
#' Default: \code{base = 2} (binary).   
#'        
#' @examples 
#' # (a) single string input:
#' base2dec("11")   # default base = 2
#' base2dec("0101")
#' base2dec("1010")
#' 
#' base2dec("11", base = 3)
#' base2dec("11", base = 5)
#' base2dec("11", base = 10)
#'
#' base2dec("11", base = 12)
#' base2dec("11", base = 14)
#' base2dec("11", base = 16)
#' 
#' # (b) numeric vectors as inputs:
#' base2dec(c(0, 1, 0))
#' base2dec(c(0, 1, 0), base = 3)
#' 
#' # (c) character vector as inputs:
#' base2dec(c("0", "1", "0"))
#' base2dec(c("0", "1", "0"), base = 3)
#' 
#' # (d) multi-digit vectors:
#' base2dec(c(1, 1))
#' base2dec(c(1, 1), base = 3)
#' 
#' # Extreme values:
#' base2dec(rep("1", 32))          # 32 x "1"
#' base2dec(c("1", rep("0", 32)))  # 2^32
#' base2dec(rep("1", 33))          # 33 x "1"
#' base2dec(c("1", rep("0", 33)))  # 2^33
#'  
#' # Non-standard inputs:
#' base2dec("  ", 2)      # no non-spaces: NA
#' base2dec(" ?! ", 2)    # no base digits: NA
#' base2dec(" 100  ", 2)  # remove leading and trailing spaces
#' base2dec("-  100", 2)  # handle negative inputs (value < 0)
#' base2dec("- -100", 2)  # handle double negations
#' base2dec("---100", 2)  # handle multiple negations
#'
#' # Special cases:
#' base2dec(NA)
#' base2dec(0)
#' base2dec(c(3, 3), base = 3)  # Note message!
#' 
#' # Note: 
#' base2dec(dec2base(012340, base =  9), base =  9)
#' dec2base(base2dec(043210, base = 11), base = 11)
#' 
#' @family numeric functions 
#' @family utility functions 
#' 
#' @seealso
#' \code{\link{dec2base}} converts decimal numbers into numerals in another base;  
#' \code{\link{as.roman}} converts integers into Roman numerals. 
#' 
#' @export 

base2dec <- function(x, base = 2){
  
  # Process inputs: ---- 
  base <- as.numeric(base)
  
  # Initialize: ---- 
  
  seq <- as.character(x)  # seq should be of type character (numerals, not values)!
  len_seq <- length(seq)
  
  # print(seq)
  
  neg_pfx <- "-"    # negation prefix/symbol   
  neg_num <- FALSE  # initialize default
  
  # Catch special cases: ---- 
  
  if (any(is.na(seq)) | is.na(base)) { return(NA) }
  if ((len_seq == 1) && (seq == "0")){ return(0)  } 
  
  # Check base digits: ---- 
  
  max_base <- length(base_digits) # maximum base value 
  
  if ((base < 2) | (base > max_base) | (base %% 1 != 0)) { 
    message(paste0("base2dec: base must be an integer in 2:", max_base, ".")) 
    return(NA)
  } else { # determine range of permissible digits:
    cur_base_digits <- base_digits[1:base]  # base_digits in current base range
  }
  
  # Pre-process character inputs: 
  seq <- trimws(seq, which = "both", whitespace = "[ \t\r\n]")  # remove leading and trailing spaces
  if (all(seq == "")) { message("dec2base: No non-space input!"); return(NA) }
  
  
  # Prepare: Convert a string seq into a character vector (of individual digits): ---- 
  
  if ((len_seq == 1) && (nchar(seq) > 1)) { # seq is a multi-digit string:
    
    seq <- text_to_chars(seq)  # update seq
    len_seq <- length(seq)     # redo
    
  } # if.
  
  # print(seq)  # 4debugging
  
  # Identify and remove prefix characters (if present) and flag an odd number of negations: ---- 
  first_matches <- match(x = cur_base_digits, table = seq)  # first matches of permissible digit in seq
  
  if (!all(is.na(first_matches))){
    ix_digit_1 <- min(first_matches, na.rm = TRUE)  # position of 1st of cur_base_digits in seq 
  } else { # no digit matches in seq: 
    message(paste0("base2dec: No base ", base, " digits in input!")); return(NA)
  }
  
  if (ix_digit_1 > 1){ # a prefix exists:
    
    prefix <- seq[1:(ix_digit_1 - 1)]  # isolate prefix (as vector)
    # print(paste0("prefix = ", prefix))  # 4debugging
    
    seq <- seq[ix_digit_1:length(seq)]  # update seq
    len_seq <- length(seq)              # redo
    
    # Flag odd number of negations:
    sum_neg <- sum(prefix == neg_pfx)  # sum of negation prefixes/symbols
    if (sum_neg %% 2 == 1){ neg_num  <- TRUE }  # flag negation
    
  } # if (ix_digit_1).
  
  # print(seq)  # 4debugging
  
  # Ensure that seq only contains permissible base_digits: ---- 
  seq_in_base_digits <- seq %in% cur_base_digits  # check (logical vector)
  
  if (!all(seq_in_base_digits)){
    
    seq_not_in_base_digits <- paste(seq[!seq_in_base_digits], collapse = " ")
    message(paste0("base2dec: digit(s) ", seq_not_in_base_digits, 
                   " undefined in base_digits for base = ", base, "!")) 
    
  } # if. 
  
  
  # Main: ---- 
  
  out_val <- 0  # output value (in decimal notation) 
  rev_seq <- rev(seq)  # move from rightmost to leftmost digit
  
  for (i in 1:len_seq){ # loop to expand polynomial of digits: 
    
    # Current digit (as character): 
    cur_digit <- rev_seq[i]
    # print(paste0("cur_digit = ", cur_digit))  # 4debugging
    
    # Translate cur_digit into cur_val (using base_digits): 
    ix_digit <- which(base_digits == cur_digit)
    cur_val  <- as.numeric(names(base_digits)[ix_digit])
    
    # Update out_val:
    out_val <- out_val + (cur_val * base^(i - 1))
    
  } # for.
  
  
  # Output: ----
  
  if (out_val < (2^32 - 1)){ # R uses 32-bit integers:
    out_val <- as.integer(out_val)  # integer value (in decimal notation)
  }
  
  if (neg_num) { out_val <- -1L * out_val }  # negate out_val 
  
  return(out_val)
  
} # base2dec().

# ## Check: 
# # (a) single string input:
# base2dec("11")  # base = 2
# base2dec("0101")
# base2dec("1010")
# 
# base2dec("11", base = 3)
# base2dec("11", base = 5)
# base2dec("11", base = 10)
# 
# base2dec("A", base = 11)
# base2dec("10", base = 11)
# base2dec("11", base = 11)
# 
# base2dec("A0", base = 11)
# base2dec("A9", base = 11)
# base2dec("AA", base = 11)
# 
# base2dec("B",  base = 12)
# base2dec("10", base = 12)
# base2dec("11", base = 12)

# # (b) numeric vectors as inputs:
# base2dec(c(0, 1, 0, 1))
# base2dec(c(0, 1, 0, 1), base = 3)
# 
# # (c) character vector as inputs:
# base2dec(c("0", "1", "0", "1"))
# base2dec(c("0", "1", "0", "1"), base = 3)
# 
# # (d) multi-digit vectors:
# base2dec(c(1, 1), base = 10)
# base2dec(c(1, 1), base = 3)
# base2dec(c(2, 3), base = 3)  # Note message.
#
# # Non-natural/non-standard inputs:
# base2dec("  100  ", 2)  # remove leading and trailing spaces
# base2dec("-100", 2)     # handle negative inputs (value < 0)
# base2dec("- -100", 2)   # handle double negations
# base2dec("---100", 2)   # handle multiple negations
# 
# # Special cases:
# base2dec(0)
# base2dec(NA)
# base2dec(1, NA)
# base2dec(c(1, NA, 3))

# +++ here now +++ 
# base2dec("10.10", 2)   # ToDo: handle non-integer inputs (using some decimal delimiter)


# base2dec_v: A vectorized version of base2dec(): -----

# Note the limitation of 
# base2dec(c(1, 2, 3), base = 10)
# => Vector for x is collapsed into sequence: Only 1 result returned.

# # (0) Vectorizing only x argument:
# base2dec_vx <- Vectorize(base2dec, vectorize.args = "x")
# base2dec_vx(c(1, 2, 3), base = 10)

# (1) Vectorizing both arguments:
base2dec_v <- Vectorize(base2dec)

## Check: 
# base2dec_v(c(1, 10, 100, 1000), base = 2)
# base2dec_v(11, base = 2:5)
# base2dec_v(c(1, 10, 100, 1000), base = 7:10)  # Note: Warning when x and base are not of the same length!
# base2dec_v(c(10, 100, 1000), base = c(20, 30, 40))


# base2dec_r: Recursive version of base2dec: ------ 

base2dec_r <- function(x, base = 2, exp = 0){
  
  # Prepare:
  x <- as.numeric(x)  # x denotes value (in decimal notation)
  
  # Warn of inaccuracies when more than 16 digits:
  fb <- TRUE  # flag: user feedback?
  
  if (fb && (exp > 16)){
    warning(paste0("Beware of rounding inaccuracies for exp = ", exp))
  }
  
  if (x == 0) { # stop:
    
    return(0)
    
  } else { # simplify:
    
    cur_dig <- (x %% 10^(exp + 1)) / 10^exp
    cur_val <- cur_dig * base^exp
    
    next_x <- x - cur_dig * 10^exp
    
    return(cur_val + base2dec_r(x = next_x, base = base, exp = (exp + 1)))
    
  }
  
} # base2dec_r().

# # Check:
# base2dec_r(x = 11, base = 2)
# base2dec_r(x = 11, base = 7)
# base2dec_r(x = 1010, base = 2)
# base2dec_r(x = 10101010101010101, base = 2)  # Warn against rounding inaccuracies (for x > 2^16)
# base2dec_r(x = 222, base = 1)  # Note: Non-sensical inputs.


# Simulation 1: Verify that the 2 recursive conversion functions complement each other: -----

sim_recursive_funs <- function(n_sim = 100){
  
  # Prepare:
  ccount <- 0
  
  # Main:
  for (i in 1:n_sim){
    
    # Frequent errors for cases involving more than 16 digits (in base notation):
    n_org <- sample(65536:99999, size = 1)  # 
    tbase <- 2 # sample(2:9, size = 1)
    
    # Correct for cases not involving more than 16 digits (in base notation):
    n_org <- sample(0:65535, size = 1)  # 
    tbase <- 2 # sample(2:9, size = 1)
    
    n_base <- dec2base_r(n_org, base = tbase)  # 1. dec > base: Works for 0:65535 in base 2 
    n_dec  <- base2dec_r(n_base, base = tbase) # 2. base > dec
    
    if (n_org == n_dec){
      ccount = ccount + 1
    } else {
      message(paste0(i, ": Difference for ", n_org, " in base ", tbase, ": n_end = ", n_dec))
    }
    
  }
  
  # Result:
  message(paste0("Recursive functions are complementary in ", ccount, " of ", n_sim, " simulations."))
  
} # sim_recursive_funs(). 

# Check:
# sim_recursive_funs(1000)  # Note: Differences occur for n_org > 65535 and base 2 conversions:
# as.character(dec2base_r(x = 65535, base = 2))  # = "1111111111111111" (16x "1")



# dec2base: Conversion function from decimal to base notation (as a complement to base2dec): ------

#' Convert an integer from decimal notation into a string of numeric digits in some base 
#' 
#' \code{dec2base} converts an integer from its standard decimal notation 
#' (i.e., using positional numerals with a base or radix of 10) 
#' into a sequence of numeric symbols (digits) in some other base. 
#' See \code{\link{base_digits}} for the sequence of default digits. 
#' 
#' To prevent erroneous interpretations of numeric outputs, 
#' \code{dec2base} returns a sequence of digits (as a character string).
#' 
#' @details 
#' \code{dec2base} is the complement of \code{\link{base2dec}}. 
#' 
#' @return A character string of digits (in base notation).
#' 
#' @param x A (required) integer in decimal (base 10) notation 
#' or corresponding string of digits (i.e., digits 0-9).
#' 
#' @param base The base or radix of the digits in the output. 
#' Default: \code{base = 2} (binary).
#' 
#' @examples 
#' # (a) single numeric input:
#' dec2base(3)  # base = 2
#' 
#' dec2base(8, base = 2)
#' dec2base(8, base = 3)
#' dec2base(8, base = 7)
#' 
#' dec2base(100, base = 5)
#' dec2base(100, base = 10)
#' dec2base(100, base = 15)
#' 
#' dec2base(14, base = 14)
#' dec2base(15, base = 15)
#' dec2base(16, base = 16)
#' 
#' dec2base(15, base = 16)
#' dec2base(31, base = 16)
#' dec2base(47, base = 16)
#' 
#' # (b) single string input:
#' dec2base("7", base = 2)
#' dec2base("8", base = 3)
#'
#' # Extreme values:
#' dec2base(base2dec(rep("1", 32)))          # 32 x "1"
#' dec2base(base2dec(c("1", rep("0", 32))))  # 2^32
#' dec2base(base2dec(rep("1", 33)))          # 33 x "1"
#' dec2base(base2dec(c("1", rep("0", 33))))  # 2^33
#' 
#' # Non-standard inputs:
#' dec2base("  ")          # only spaces: NA
#' dec2base("?")           # no decimal digits: NA
#' dec2base(" 10 ", 2)     # remove leading and trailing spaces
#' dec2base("-10", 2)      # handle negative inputs (in character strings)
#' dec2base(" -- 10", 2)   # handle multiple negations
#' dec2base("xy -10 ", 2)  # ignore non-decimal digit prefixes
#' 
#' # Note: 
#' base2dec(dec2base(012340, base =  9), base =  9)
#' dec2base(base2dec(043210, base = 11), base = 11)
#' 
#' @family numeric functions 
#' @family utility functions 
#' 
#' @seealso
#' \code{\link{base2dec}} converts numerals in some base into decimal numbers; 
#' \code{\link{as.roman}} converts integers into Roman numerals. 
#' 
#' @export 

dec2base <- function(x, base = 2){ # as_char = TRUE  # removed, as it would only re-compute input.
  
  # Version 1: ----
  # - calculate n_digits 
  # - use for loop
  # 
  # # Process inputs: 
  # dec  <- as.numeric(x)     # numeric value (in decimal notation) 
  # base <- as.numeric(base)
  #
  # # Catch some special cases:
  # if (is.na(dec) | is.na(base)) { return(NA) }
  # if (dec == 0){ return(0) }  
  # if ( any(base < 2) | any(base > 10) | any(base %% 1 != 0) ) { 
  #   message("dec2base: base must be an integer in 2:10.")
  #   return(NA)
  # }
  # 
  # # Initialize: 
  # out <- NULL
  # dec_left <- dec 
  # 
  # # Prepare:
  # n_digits <- floor(log(dec)/log(base) + 1)
  # # print(paste("n_digits =", n_digits))  # 4debugging
  # 
  # # Main: 
  # for (i in n_digits:1){
  #   
  #   cur_digit <- dec_left %/% base^(i - 1)
  #   
  #   dec_left <- dec_left - (cur_digit * base^(i - 1))
  #   
  #   out <- paste0(out, cur_digit)
  #   
  # } # for.
  
  # Version 2: ---- 
  # - without computing n_digits
  # - while loop
  
  neg_pfx <- "-"    # negation prefix/symbol   
  neg_num <- FALSE  # initialize default
  
  if ( is.na(x) | is.na(base) ) { 
    
    out <- NA
    
  } else {
    
    # Process inputs: Check base digits: ---- 
    
    base     <- as.numeric(base)
    max_base <- length(base_digits)  # maximum base value 
    
    if ((base < 2) | (base > max_base) | (base %% 1 != 0)) { 
      
      message(paste0("dec2base: base must be an integer in 2:", max_base, ".")) 
      return(NA)
      
    } else { # determine range of permissible input digits/decimal digits: 
      
      decimal_digits <- base_digits[1:10]  # permissible base_digits in decimal range (base = 10)
      
    } # if base.
    
    
    if (is.character(x)){ # Pre-process string inputs (spaces, prefixes, negations): ---- 
      
      x1 <- trimws(x, which = "both", whitespace = "[ \t\r\n]")  # remove leading and trailing spaces
      if (x1 == "") { message("dec2base: No non-space input!"); return(NA) }
      
      # Analyze seq (as vector) and flag an odd number of negations:
      seq <- text_to_chars(x1)        # as vector
      # print(paste0("seq = ", seq))  # 4debugging
      
      # Identify and remove prefix characters (if present) and flag an odd number of negations:
      first_matches <- match(x = decimal_digits, table = seq)  # all positions of 1st matches
      
      if (!all(is.na(first_matches))){
        ix_decimal_1 <- min(first_matches, na.rm = TRUE)  # position of 1st decimal digit in seq 
      } else { # no digit matches in seq: 
        message("dec2base: No decimal digits in input!"); return(NA)
      }
      # print(paste0("ix_decimal_1 = ", ix_decimal_1))  # 4debugging
      
      if (ix_decimal_1 > 1){ # a prefix exists:
        
        prefix <- seq[1:(ix_decimal_1 - 1)]  # isolate prefix (as vector)
        # print(paste0("prefix = ", prefix))  # 4debugging
        
        seq <- seq[ix_decimal_1:length(seq)]  # update seq
        x1   <- chars_to_text(seq)  # update x (as 1 string)
        
        # Flag odd number of negations:
        sum_neg <- sum(prefix == neg_pfx)  # sum of negation prefixes/symbols
        if (sum_neg %% 2 == 1){ neg_num  <- TRUE }  # flag negation
        
      } # if (ix_decimal_1).
      
      val_left <- as.numeric(x1)  # read x1 as the numeric value left (in decimal notation)
      
    } else { # x is no string:
      
      val_left <- as.numeric(x)
      
    }  # if (is.character(x)).
    
    
    # Prepare: ---- 
    
    position   <- 0   # position/order (0 is rightmost/unit/base^0)
    next_units <- 88  # number of units in next higher order
    out <- NULL       # initialize output
    
    if (val_left < 0){ 
      neg_num  <- TRUE  # flag input as negative number
      val_left <- abs(val_left)  # use absolute value
    }  
    
    
    # Main: ---- 
    
    # while (val_left > 0){
    while (next_units > 0){
      
      # print(paste0("position = ", position, ": val_left = ", val_left))  # 4debugging
      
      next_units <- val_left %/% base^(position + 1)  # divisor on NEXT position (higher order)
      # print(paste0("- next_units = ", next_units))  # 4debugging
      
      next_rem <- val_left %%  base^(position + 1)  # remainder on NEXT position (higher order)
      # print(paste0("- next_rem = ", next_rem))    # 4debugging
      
      if (next_rem > 0){  
        
        cur_left <- val_left - (next_units * base^(position + 1))
        
        cur_val <- cur_left %/% base^(position)   # current divisor
        # print(paste0("- cur_val = ", cur_val))  # 4debugging
        
        # cur_rem <- val_left %%  base^(position)  # current remainder
        # print(paste0("- cur_rem = ", cur_rem))   # 4debugging    
        
      } else { 
        
        cur_val   <- 0
        
      }
      
      # print(paste0("- cur_val = ", cur_val))  # 4debugging
      
      # Translate cur_val into cur_digit (using base_digits): 
      # cur_digit <- as.character(cur_val)     # (a) base <= 10
      cur_digit <- base_digits[[cur_val + 1]]  # (b) base <= max_base 
      # print(paste0("- cur_digit = ", cur_digit))  # 4debugging    
      
      # Collect outputs:
      out <- paste0(cur_digit, out)  # as characters
      
      # Update val_left and position counter:
      val_left <- val_left - (cur_val * base^(position))
      position <- position + 1 
      
    } # while. 
  } # else.
  
  
  # Output: ---- 
  
  # if (!as_char){
  #   # out <- as.integer(out)  # Note: May cause problems with scientific notation!
  #   out <- base2dec(out, base = base)  # Re-converts out digits into integer in decimal notation.
  # }
  
  if (neg_num) { out <- paste0(neg_pfx, out) }  # negate out
  
  return(out)
  
} # dec2base(). 

## Check:
# dec2base(0)
# dec2base(1)
# dec2base(2)
# dec2base(7)
# dec2base(8)
# dec2base(8, base = 3)
# dec2base(8, base = 7)
# dec2base(8, base = 10)
# 
# dec2base(14, base = 14)
# dec2base(15, base = 15)
# dec2base(16, base = 16)
# 
# dec2base(15, base = 16)
# dec2base(31, base = 16)
# dec2base(47, base = 16)
# 
# base2dec(111, base = 3)
# 
# # Note:
# base2dec(dec2base(012340, base = 5), base = 5)
# dec2base(base2dec(043210, base = 5), base = 5)
# 
# # Special cases:
# dec2base(0)
# dec2base(NA)
# dec2base(1, NA)
#
# # Handle non-natural/non-standard inputs:
# dec2base("  ")          # no non-spaces: NA
# dec2base("?")           # no decimal digits: NA
# dec2base(" 10 ", 2)     # remove leading and trailing spaces
# dec2base("-10", 2)      # handle negative inputs (in character strings)
# dec2base("- - 10", 2)   # handle multiple negations
# dec2base("xy -10 ", 2)  # ignore non-decimal prefixes
#
# +++ here now +++: 
# dec2base("10.10", 2)    # ToDo: handle non-integer inputs (using some decimal delimiter)
#
# # With an as_char argument (removed): 
# dec2base(1000, 50, as_char = TRUE)
# dec2base(1000, 50, as_char = FALSE)  # re-converts into base digits
#
# # Documentation (removed):
# @param as_char Return the output as a character string?
# Default: \code{as_char = TRUE} (as symbol sequence is NOT a
# decimal number unless \code{base = 10}).
# 
# When using \code{as_char = FALSE}, its output string \code{out}
# is processed by \code{base2dec(out, base = base)},
# but this would only re-compute the input values.
# (Note that simply using \code{as.integer(out)} would fail,
# as outputs for any base/radix other than 10 do NOT denote decimal numbers.)



# dec2base_v: Vectorized version of dec2base(): ------ 

# Note the limitation of 
# dec2base(c(9, 10, 11), base = 2)
# => Result is ok, but messages due to tests on atomic vectors.

# # (0) Vectorizing only x argument:
# dec2base_vx <- Vectorize(dec2base, vectorize.args = "x")
# dec2base_vx(c(9, 10, 11), base = 2)

# (1) Vectorizing both arguments:
dec2base_v <- Vectorize(dec2base)

## Check: 
# dec2base_v(-10:10, base = 2)
# dec2base_v(10,   base = 2:5)
# dec2base_v(9:11, base = 5:10)  # Note: Warning when x and base are not of the same length!
# dec2base_v(100, base = c(10, 20, NA, 30, 40, 50))



# dec2base_r: Recursive version of dec2base(): -----

dec2base_r <- function(x, base, exp = 0) {
  
  # Prepare:
  x <- as.numeric(x)  # x denotes value (in decimal notation)
  
  # Warn of inaccuracies when more than 16 digits:
  fb <- TRUE  # flag: user feedback?
  
  if (fb && (exp > 16)){
    warning(paste0("Beware of rounding inaccuracies for exp = ", exp))
  }
  
  if (x == 0) { # stop: 
    
    return(0)
    
  } else { # simplify: 
    
    rest    <- x %%  base
    nxt_num <- x %/% base
    
    add_2 <- rest * (10^exp)
    
    # recurse: 
    return(add_2 + dec2base_r(x = nxt_num, base = base, exp = (exp + 1)))
    
  }
  
} # dec2base_r(). 

# # Check:
# dec2base_r(10, base = 2)
# 
# # NOTE accuracy boundary / limit case:
# as.character(dec2base_r(x = 65535, base = 2))  # 2^16 = "1111111111111111" (16x "1")
# Larger values x > 65535 would require more than 16 digits, which can yield rounding effects: 
# dec2base_r(x = 65535, base = 2)  # limit case
# dec2base_r(x = 65536, base = 2)  # Warn against rounding inaccuracies (for x > 2^16)
#
# See re-analysis of Nina's i2ds-2 project "nonDecAr_NinaEhmann_hn.Rmd" and ".html" 



# Simulation 2: Verify that dec2base() and base2dec() complement each other: -----

dec2base_base2dec_sim <- function(n_sim = 100, 
                                  min_val = 0, max_val = 65535,
                                  min_base = 2, max_base = 9){
  
  # Use inputs as parameters: 
  n_sim <- n_sim
  n_org <- sample(min_val:max_val, size = n_sim, replace = TRUE)
  
  if (min_base < max_base){
    base <- sample(min_base:max_base, size = n_sim, replace = TRUE)
  } else { # Avoid sample(x:x, ) quirk: 
    base <- sample(c(min_base, max_base), size = n_sim, replace = TRUE)
  }
  
  # Store results:
  n_base <- rep(NA, n_sim)
  # n_base_r <- rep(NA, n_sim)
  n_dec  <- rep(NA, n_sim)
  
  # Main: 
  for (i in 1:n_sim){ # loop through simulations: 
    
    n_base[i] <- dec2base(n_org[i],  base[i])      # 1a.
    # n_base_r[i] <- dec2base_r(n_org[i],  base[i])  # 1b. (works up to x = 65535 in base 2)
    
    n_dec[i]  <- base2dec(n_base[i], base[i])  # 2. 
    
  } # for loop. 
  
  # Collect results:
  df <- data.frame(n_org, 
                   base, 
                   n_base, 
                   # n_base_r, 
                   n_dec, 
                   # same_base_r = (n_base == as.character(n_base_r)), 
                   same_org_dec = (n_org == n_dec))
  
  # Report results:
  
  # # 1: Do dec2base() and dec2base_r() yield identical results: 
  # sum_same_base_r <- sum(df$same_base_r, na.rm = TRUE)  # count same cases 
  # 
  # # Feedback:
  # message(paste0("Same result in ", sum_same_base_r, " of ", n_sim, " simulations? ", 
  #                (sum_same_base_r == n_sim)))  # All n_sim = same?
  
  # 2: Do dec2base() and base2dec() yield complementary results: 
  sum_same_org_dec <- sum(df$same_org_dec, na.rm = TRUE)  # count same cases 
  
  # Feedback:
  message(paste0("Same result in ", sum_same_org_dec, " of ", n_sim, " simulations? ", 
                 (sum_same_org_dec == n_sim)))  # All n_sim = same?
  
  # Output: 
  return(invisible(df))
  
} # dec2base_base2dec_sim(). 


## Check: Run simulations... 
# dec2base_base2dec_sim()  # defaults
# 
# length(base_digits)  # maximum base value
# df <- dec2base_base2dec_sim(1000, min_val = 0, max_val = 999999, min_base = 2, max_base = 2)
# df



## (3) Letter arithmetic: -------- 

# Goal: Display arithmetic expressions (in any base, with options for replacing digits): 


# Replacement digits (named vector, as in l33t_rul35): ------  
digits <- 0:9
# Replacement rules: Replace each digit by a random symbol (as named vector): 
rdigit <- sample(LETTERS[1:length(digits)], size = length(digits), replace = FALSE)
names(rdigit) <- digits  # (names encode position values)
# rdigit  # is lookup table 


# encrypt_arithm_expr: Compute, translate, and print an arithmetic expression: ------ 

encrypt_arithm_expr <- function(x, y, op = "+", base = 10, dig_sym = NULL){
  
  # 1. Compute result r: 
  # switch(op, 
  #        "+" = r <- x + y,
  #        "-" = r <- x - y, 
  #        "*" = r <- x * y,
  #        "/" = r <- x / y)
  
  # Use do.call() to evaluate arbitrary expressions: 
  r <- do.call(op, list(x, y))
  
  # 2. Translate numerals into a different base (if specified): ---- 
  
  if (base != 10){
    x <- dec2base(x, base = base)
    y <- dec2base(y, base = base)
    r <- dec2base(r, base = base)
  }
  
  
  # 3. Get output numerals (as character strings): ---- 
  
  if (!is.null(dig_sym)){
    
    # Translate numerals (using rules specified in dig_sym): 
    x_2 <- transl33t(as.character(x), rules = dig_sym)
    y_2 <- transl33t(as.character(y), rules = dig_sym) 
    r_2 <- transl33t(as.character(r), rules = dig_sym)
    
  } else { # no translation of digit symbols: 
    
    x_2 <- as.character(x)
    y_2 <- as.character(y)
    r_2 <- as.character(r)
    
  }
  
  # 4. Process and print output: ---- 
  
  eq <- c(x_2, op, y_2, "=", r_2)
  names(eq) <- c(x, op, y, "=", r)
  
  eq_1 <- paste(eq, collapse = " ")  # collapse to string
  # print(eq_1)
  
  # As multi-line (cat):
  max_nchar <- max(nchar(c(x_2, y_2, r_2)))
  cat_width <- max_nchar + 2
  
  if (nchar(y_2) == max_nchar){ # y_2 is longest numeral: 
    op_sep <- " "
  } else { # y_2 is not longest numeral:
    sp_sep <- rep(" ", (max_nchar - nchar(y_2) + 1))
    op_sep <- paste(sp_sep, collapse = "")
  }
  
  dashes <- paste(rep("-", cat_width - 2), collapse = "")
  
  # eq_2 <- paste(c(x_2, paste(op, y_2, sep = op_sep), paste("=", r_2, sep = " ")), sep = "\n")  # with "="
  eq_2 <- paste(c(x_2, paste(op, y_2, sep = op_sep), dashes, r_2), sep = "\n")  # without "="
  
  # Show formatted eq_2 (on screen):  
  cat(format(eq_2, width = cat_width, justify = "right"), sep = "\n")
  
  
  # 5. Return: ---- 
  
  return(invisible(eq))
  
} # encrypt_arithm_expr(). 

# # Check: 
# 
# # Create problems:
# set.seed(2468)
# n <- sample(1:999, 2, replace = TRUE)
# 
# # (a) without translating base or symbols (dig_sym):
# p_1a <- encrypt_arithm_expr(n[1], n[2], "%/%")
# p_2a <- encrypt_arithm_expr(n[1], n[2], "-")
# p_3a <- encrypt_arithm_expr(n[1], n[2], "*")
# p_4a <- encrypt_arithm_expr(n[1], n[2], "/")
# 
# # (b) with translating base:
# p_1b <- encrypt_arithm_expr(n[1], n[2], "+", base = 2)
# p_2b <- encrypt_arithm_expr(n[1], n[2], "-", base = 2)
# p_3b <- encrypt_arithm_expr(n[1], n[2], "*", base = 2)
# p_4b <- encrypt_arithm_expr(n[1], n[2], "/", base = 2)
# 
# # (c) with translating symbols (dig_sym):
# p_1c <- encrypt_arithm_expr(n[1], n[2], "+", dig_sym = rdigit)
# p_2c <- encrypt_arithm_expr(n[1], n[2], "-", dig_sym = rdigit)
# p_3c <- encrypt_arithm_expr(n[1], n[2], "*", dig_sym = rdigit)
# p_4c <- encrypt_arithm_expr(n[1], n[2], "/", dig_sym = rdigit)


## Done: ----------

# - base2dec() and dec2base(): Remove leading and trailing spaces.  
# - base2dec() and dec2base(): Identify prefixes and negations.


## ToDo: ------

# - Handle non-integer/decimal inputs in base2dec() and dec2base()?
# - Create vectorized versions of base2dec() and dec2base() as defaults.
# - Create recursive versions of base2dec() and dec2base()? 


## eof. ----------
