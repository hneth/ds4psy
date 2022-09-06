## util_fun.R | ds4psy
## hn | uni.kn | 2022 06 28
## ---------------------------

## Utility functions. 

## (1) Testing and manipulating vectors: ------ 

# is_vect: Testing for a vector (which is.vector does not) ------ 

#' Test for a vector (i.e., atomic vector or list). 
#'
#' \code{is_vect} tests if \code{x} is a vector.
#' 
#' \code{is_vect} does what the \strong{base} R function \code{is.vector} is \strong{not} designed to do: 
#' 
#' \itemize{ 
#'   \item \code{is_vect()} returns TRUE if \code{x} is an atomic vector or a list (irrespective of its attributes). 
#' 
#'   \item \code{is.vector()} returns TRUE if \code{x} is a vector of the specified \code{mode} having no attributes other than names, otherwise FALSE.
#' }
#' 
#' Internally, the function is a wrapper for \code{is.atomic(x) | is.list(x)}. 
#' 
#' Note that data frames are also vectors.
#' 
#' See the \code{is_vector} function of the \strong{purrr} package 
#' and the \strong{base} R functions 
#' \code{\link{is.atomic}}, \code{\link{is.list}}, and \code{\link{is.vector}}, 
#' for details.
#' 
#' @param x Vector(s) to test (required).
#'
#' @examples
#' # Define 3 types of vectors:
#' v1 <- 1:3  # (a) atomic vector
#' names(v1) <- LETTERS[v1]  # with names
#' 
#' v2 <- v1   # (b) copy vector
#' attr(v2, "my_attr") <- "foo"  # add an attribute
#' ls <- list(1, 2, "C")  # (c) list
#' 
#' # Compare:
#' is.vector(v1)
#' is.list(v1)
#' is_vect(v1)
#' 
#' is.vector(v2)  # FALSE
#' is.list(v2)
#' is_vect(v2)  # TRUE
#' 
#' is.vector(ls)
#' is.list(ls)
#' is_vect(ls)
#' 
#' # Data frames are also vectors: 
#' df <- as.data.frame(1:3)
#' is_vect(df)  # is TRUE
#' 
#' @family utility functions
#'
#' @seealso 
#' \code{is_vect} function of the \strong{purrr} package; 
#' \code{\link{is.atomic}} function of the R \strong{base} package; 
#' \code{\link{is.list}} function of the R \strong{base} package;  
#' \code{\link{is.vector}} function of the R \strong{base} package.  
#'
#' @export

is_vect <- function(x) {
  
  is.atomic(x) | is.list(x)
  
} # is_vect().

# ## Check: 
# # 3 types of vectors:
# v1 <- 1:3  # (a) atomic vector
# names(v1) <- LETTERS[v1]  # with names
# 
# v2 <- v1   # (b) copy vector
# attr(v2, "my_attr") <- "foo"  # add an attribute
# 
# ls <- list(1, 2, "C")  # (c) list
# 
# # Compare:
# is.vector(v1)
# is.list(v1)
# is_vect(v1)
# 
# is.vector(v2)  # FALSE
# is.list(v2)
# is_vect(v2)  # TRUE
# 
# is.vector(ls)
# is.list(ls)
# is_vect(ls)
# 
# # Vectors of vectors:
# vs <- c(v1, v2, ls)
# df <- data.frame(v1, v2)
# 
# is.vector(vs)
# is.vector(df)
# 
# # Data frames are also vectors: 
# df <- as.data.frame(1:3)
# is_vect(df)  # is TRUE



# vrep: A vectorized version of rep(): ------

vrep <- Vectorize(rep.int, "times") # vrep().

## Check:
# vrep(x = 1,   times = 1:3)
# vrep(x = "a", times = 2:4)
## => works, but returns a list.


# recycle_vec: Recycle (extend or truncate) a vector v to a length len: ------

recycle_vec <- function(v, len){
  
  # Special cases:  
  if (is.na(len)) { return(NA) }
  if (len == 0) { return(v[0]) }
  
  # Initialize: 
  v_len <- length(v)
  
  # Main: Compare v_len with len:  
  if (v_len > len){ # truncate v:
    
    v[1:len]  # first len elements
    
  } else if (v_len < len) { # extend v:
    
    rep(v, ceiling(len/v_len))[1:len]
    
  } else {
    
    v  # no change
    
  }
  
} # recycle_vec() end.


## Check:
# recycle_vec(1:4, NA)
# recycle_vec(1:4, 6)
# recycle_vec(1:4, 2)
# recycle_vec(1:4, 4)
# # Note: 
# recycle_vec(1:3, 0)
# recycle_vec(letters[1:3], 0)
# recycle_vec(c(1, NA, 3), 5)


# align_vec: Recycle or truncate a vector v to the length of a main one: ------

# Return the modified vector (with a different length).

align_vec <- function(v_mod, v_fix){
  
  v_out <- v_mod  # default: original v_mod
  
  # Lengths:
  n_fix <- length(v_fix)
  n_org <- length(v_mod)
  
  # Main:
  if (n_fix != n_org){  # different lengths:
    
    if (n_org > n_fix){ # 1. truncate v_mod to the length of n_fix:
      
      v_out <- v_mod[1:n_fix]
      
    } else { # 2. recycle v_mod to the length of n_fix:
      
      v_out <- rep(v_mod, ceiling(n_fix/n_org))[1:n_fix]
      
    } # end else.
  } # end if.
  
  return(v_out)
  
} # align_vec().

# ## Check:
# align_vec(LETTERS[1:4], 1:4)  # same length
# align_vec(LETTERS[1:4], 1:6)  # lengthen v_mod
# align_vec(LETTERS[1:6], 1:4)  # shorten v_mod
# 
# # Note:
# align_vec(LETTERS[1:3], NA)
# align_vec(NA, 1:4)


# align_vec_pair: Recycle a pair of vectors to the length of the longer one: ------ 

# Return the pair of both vectors (as a list). 

align_vec_pair <- function(v1, v2){
  
  # Initialize: 
  lo <- NA
  o1 <- v1
  o2 <- v2 
  
  # Length of vectors: 
  n1 <- length(v1)
  n2 <- length(v2)
  
  # Main: 
  if (n1 != n2){  # different lengths:
    
    if (n2 > n1){ # 1. recycle v1 to length of v2:
      
      o1 <- rep(v1, ceiling(n2/n1))[1:n2]
      
    } else { # 2. recycle v2 to the length of v1: 
      
      o2 <- rep(v2, ceiling(n1/n2))[1:n1]
      
    } # end else. 
  } # end if.  
  
  # Output: Return both vectors (as a list): 
  lo <- list(o1, o2) 
  
  return(lo)
  
} # align_vec_pair(). 

# ## Check:
# align_vec_pair(1:5, LETTERS[1:5])  # same length
# align_vec_pair(1:5, LETTERS[1:3])  # 2nd vector is recycled
# align_vec_pair(1:5, LETTERS[1:10]) # 1st vector is recycled
# 
# # Note: Handling NA cases
# align_vec_pair(NA, LETTERS[1:3])
# align_vec_pair(1:5, NA)


## (+) Miscellaneous utility functions: ------ 


# get_name: Get an object's name (e.g., inside a function): ------ 

get_name <- function(x){
  
  nm <- NA
  
  nm <- deparse(substitute(x))
  
  return(nm)
  
} # get_name().

# # Check:
# nv <- 1:10
# av <- letters[1:10]
# (ls <- list(e1 = nv, e2 = av))
# (df <- data.frame(v1 = nv, v2 = av))
# (fc <- factor(av))
# 
# get_name(nv) # vector
# get_name(ls) # list
# get_name(df) # data.frame
# get_name(fc) # factor


# kill_all: Kill all objects in current environment (without warning): ------

kill_all <- function(){
  
  rm(list = ls())
  
} # kill_all(). 

## Check: 
# kill_all()


## ToDo: ----------

# - etc.

## eof. ----------------------