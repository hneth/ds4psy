## num_fun.R | ds4psy
## hn | uni.kn | 2022 06 29
## ---------------------------

## Main functions for manipulating/transforming numbers or numeric symbols/digits: ------ 

# Note: Most functions here are classified as belonging to the 
#       family of "numeric" AND "utility" functions. 


## (0) Note utility functions for numbers and numeric symbols/digits in num_util_fun.R! ------

# base_digits: Define base digit sequence (as global constant) ------ 

base_digit_vec        <- c(0:9, LETTERS[1:6])      # max_base value = 16
base_digit_vec        <- c(0:9, LETTERS, letters)  # max_base value = 62
names(base_digit_vec) <- 0:(length(base_digit_vec) - 1)  # zero-indexed names

#' Base digits (as named vector) 
#' 
#' \code{base_digits} provides numeral symbols (digits) 
#' for bases of notational place-value systems 
#' (as a named character vector).
#' 
#' Note that the elements (digits) are character symbols 
#' (i.e., numeral digits "0"-"9", "A"-"F", etc.), 
#' whereas their names correspond to their 
#' numeric values (from 0 to 
#' \code{length(base_digits) - 1}). 
#' 
#' Thus, the maximum base value in conversions by 
#' \code{\link{base2dec}} or \code{\link{dec2base}} 
#' is \code{length(base_digits)}. 
#' 
#' @examples 
#' base_digits          # named character vector
#' length(base_digits)  # 16 (maximum base value)
#' base_digits[10]      # 10. element ("9" with name "9") 
#' base_digits["10"]    # named element "10" ("A" with name "10")
#' base_digits[["10"]]  # element named "10" ("A")
#' 
#' @family numeric functions 
#' @family utility functions 
#' 
#' @seealso
#' \code{\link{base2dec}} converts numerals in some base into decimal numbers; 
#' \code{\link{dec2base}} converts decimal numbers into numerals in another base; 
#' \code{\link{as.roman}} converts integers into Roman numerals. 
#' 
#' @export 

base_digits <- base_digit_vec

## Check:
# base_digits
# length(base_digits)  # 16, but zero-indexed names
# base_digits[10]      # 10. element ("9" with name "9")
# base_digits["10"]    # named element "10" ("A" with name "10")
# base_digits[["10"]]  # element named "10" ("A")


## (1) Converting numerals from decimal notation to other base/radix values: ------ 

# base2dec: Convert a base N numeral string (of digits) into a decimal number: ------ 

#' Convert a string of numeral digits from some base into decimal notation. 
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
  
  # Process inputs:
  seq  <- as.character(x)  # seq is of type character (numerals, not values)!
  base <- as.numeric(base)
  
  # Initialize: 
  out_val <- 0  # output value (in decimal notation) 
  len_seq <- length(seq)
  max_base <- length(base_digits)  # maximum base value 
  
  # Catch special cases:
  if (any(is.na(seq)) | is.na(base)) { return(NA) }
  if ((len_seq == 1) && (seq == "0")){ return(0)  }  
  if ((base < 2) | (base > max_base) | (base %% 1 != 0)) { 
    message(paste0("base2dec: base must be an integer in 2:", max_base, ".")) 
    return(NA)
  }
  
  # Prepare: Convert a string seq into a character vector (of individual digits):
  if ((len_seq == 1) && (nchar(seq) > 1)) { # seq is a multi-digit string:
    
    seq <- text_to_chars(seq)  # WAS: str2vec(seq)
    len_seq <- length(seq)  # redo
    
  } # if.
  
  # print(seq)  # 4debugging
  
  # Ensure that seq only contains permissible base_digits:
  cur_base_digits    <- base_digits[1:base]  # base_digits in current base range
  seq_in_base_digits <- seq %in% cur_base_digits  # check (logical vector)
  
  if (!all(seq_in_base_digits)){
    
    seq_not_in_base_digits <- paste(seq[!seq_in_base_digits], collapse = " ")
    message(paste0("base2dec: digit(s) ", seq_not_in_base_digits, 
                   " undefined in base_digits for base = ", base, "!")) 
    
  } # if. 
  
  # Main:
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
  
  # Process output:
  out_val <- as.integer(out_val)
  
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
# # Special cases:
# base2dec(0)
# base2dec(NA)
# base2dec(1, NA)
# base2dec(c(1, NA, 3))


# base2dec_v: A vectorized version of base2dec(): -----

# Note a problem with
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


# dec2base: Conversion function from decimal to base notation (as a complement to base2dec): ------

#' Convert an integer from decimal notation into a string of numeric digits in some base. 
#' 
#' \code{dec2base} converts an integer from its standard decimal notation 
#' (i.e., using positional numerals with a base or radix of 10) 
#' into a sequence of numeric symbols (digits) in some other base. 
#' 
#' See \code{\link{base_digits}} for the sequence of default digits. 
#' 
#' To prevent erroneous interpretations of numeric outputs, 
#' \code{dec2base} returns a sequence of digits (as a character string).
#' 
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
  
  if ( is.na(x) | is.na(base) ) { 
    
    out <- NA
    
  } else {
    
    # Process inputs: 
    val_left <- as.numeric(x)  # numeric value left (in decimal notation) 
    base     <- as.numeric(base)
    max_base <- length(base_digits)  # maximum base value 
    
    if ((base < 2) | (base > max_base) | (base %% 1 != 0)) { 
      message(paste0("dec2base: base must be an integer in 2:", max_base, ".")) 
      return(NA)
    }
    
    # Prepare: 
    position <- 0     # position/order (0 is rightmost/unit/base^0)
    next_units <- 88  # number of units in next higher order
    out <- NULL       # initialize output
    
    # Main: 
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
  
  # # Process output:
  # if (!as_char){
  #   # out <- as.integer(out)  # Note: May cause problems with scientific notation!
  #   out <- base2dec(out, base = base)  # Re-converts out digits into integer in decimal notation.
  # }
  
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


# dec2base_v: Vectorized version of dec2base(): -----

# Note a problem with
# dec2base(c(9, 10, 11), base = 2)
# => Result is ok, but messages due to tests on atomic vectors.

# # (0) Vectorizing only x argument:
# dec2base_vx <- Vectorize(dec2base, vectorize.args = "x")
# dec2base_vx(c(9, 10, 11), base = 2)

# (1) Vectorizing both arguments:
dec2base_v <- Vectorize(dec2base)

## Check: 
# dec2base_v(9:11, base = 2)
# dec2base_v(10,   base = 2:5)
# dec2base_v(9:11, base = 5:10)  # Note: Warning when x and base are not of the same length!
dec2base_v(100, base = c(10, 20, NA, 30, 40, 50))

# dec2base_r: Recursive version of dec2base(): -----

dec2base_r <- function(x, base = 2){
  
  n <- as.numeric(x)
  exp <- NA
  
  if (n < base) { # stopping condition: 
    
    exp <- 0 
    out <- as.character(n) 
    
  } else { 
    
    # Simplification step:
    digit_cur <- n %% base
    exp <- exp + 1
    n_left <- n - (digit_cur * base^exp)
    
    paste0(dec2base_r(n_left, base), digit_cur)  # recursion
    
  }
  
}

## Check:
# dec2base_r(11)


# Simulation: Verify that dec2base() and base2dec() complement each other: -----

dec2base_base2dec_sim <- function(n_sim = 100, 
                                  min_val = 0, max_val = 999999,
                                  min_base = 2, max_base = 16){
  
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
  n_dec  <- rep(NA, n_sim)
  
  # Main: 
  for (i in 1:n_sim){ # loop through simulations: 
    
    n_base[i] <- dec2base(n_org[i],  base[i])  # 1. 
    n_dec[i]  <- base2dec(n_base[i], base[i])  # 2. 
    
  } # for loop. 
  
  # Collect results:
  df <- data.frame(n_org, 
                   base, 
                   n_base, 
                   n_dec, 
                   same = (n_org == n_dec))
  
  sum_same <- sum(df$same, na.rm = TRUE)  # count same cases 
  
  # Feedback:
  message(paste0("Same result in all ", n_sim, " simulations? ", 
                 (sum_same == n_sim)))  # All n_sim = same?
  
  return(invisible(df))
  
} # dec2base_base2dec_sim(). 

## Check: Run simulations... 
# dec2base_base2dec_sim()  # defaults
# 
# length(base_digits)  # maximum base value
# df <- dec2base_base2dec_sim(20, min_val = 0, max_val = 9999, min_base = 2, max_base = 62)
# df


## Done: ----------

# - Create vectorized versions of base2dec() and dec2base().

## ToDo: ------

# - Create recursive versions of base2dec() and dec2base().

## eof. ----------
