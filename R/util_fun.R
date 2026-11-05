## util_fun.R | ds4psy
## hn | uni.kn | 2026 11 05
## ------------------------

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


#' Randomly assign individuals to balanced groups
#'
#' \code{assign_group} randomly assigns a set of individuals
#' (provided as a vector \code{x}, e.g., of names)
#' to \code{n} groups of balanced sizes.
#'
#' By default, \code{assign_group} uses \emph{balanced} assignment:
#' Group labels are recycled to the number of individuals and
#' then randomly permuted, so that group sizes differ by at most 1.
#'
#' Setting \code{balance = FALSE} uses random sampling (with replacement)
#' instead, but still guarantees that each of the \code{n} groups
#' contains at least 1 individual.
#'
#' If \code{n} exceeds the number of individuals \code{length(x)},
#' \code{n} is reduced to \code{length(x)} (with a message).
#'
#' @param x The individuals to assign to groups,
#' as an (atomic) vector (e.g., a character vector of names).
#'
#' @param n The number of groups to create (as a positive integer).
#' Default: \code{n = 2}.
#'
#' @param balance Use balanced assignment (so that group sizes
#' differ by at most 1)?
#' Default: \code{balance = TRUE}.
#' If \code{balance = FALSE}, individuals are assigned by random
#' sampling (with replacement), ensuring that groups are non-empty.
#'
#' @param labels Optional labels for the \code{n} groups
#' (as a vector of length \code{n}), used to identify groups
#' (e.g., by team name or color).
#' Default: \code{labels = NULL} (i.e., number groups from \code{1} to \code{n}).
#'
#' @param as_list Return the result as a named list of separate tables
#' (one per group) rather than a single data frame?
#' Default: \code{as_list = FALSE}.
#'
#' @param seed An optional random seed (for reproducibility).
#' Default: \code{seed = NA} (i.e., no seed is set).
#'
#' @param ... Other arguments (passed to \code{\link{sample}}
#' when \code{balance = FALSE}).
#'
#' @return A data frame with 2 columns (\code{name} and \code{group}),
#' sorted by \code{group}.
#' If \code{as_list = TRUE}, a named list of such data frames
#' (one per group, named by group number or \code{labels}) is returned instead.
#'
#' @examples
#' name <- c("Alma", "Bea", "Cedric", "Dan", "Eva",  "Xi", "Yo", "Za")
#'
#' assign_group(name)                       # 2 balanced groups (default)
#' assign_group(name, n = 4, seed = 123)    # 4 groups, reproducible
#'
#' # More groups than individuals (n is reduced, with a message):
#' assign_group(name, n = 100)
#'
#' # Random assignment (with replacement, but no empty groups):
#' assign_group(name, n = 3, balance = FALSE)
#'
#' # Custom labels and separate tables (one per group):
#' assign_group(name, n = 3, labels = c("A", "B", "C"), as_list = TRUE)
#'
#' @family sampling functions
#'
#' @seealso
#' \code{\link{sample}} for random sampling.
#'
#' @export

assign_group <- function(x, 
                         n = 2, balance = TRUE,
                         labels = NULL, as_list = FALSE,
                         seed = NA, ...) {
  
  # Validate x: ----
  if (is.factor(x)) x <- as.character(x)
  
  if (!is.atomic(x) || is.null(x)) {
    stop("'x' must be an (atomic) vector of individuals (e.g., names).")
  }
  
  n_x <- length(x)
  
  if (n_x < 1L) {
    stop("'x' must contain at least 1 individual.")
  }
  
  # Validate n: ----
  if (!is.numeric(n) || length(n) != 1L || is.na(n) || !is.finite(n) || n < 1) {
    
    stop("'n' must be a single integer > 0.")
    
  }
  
  n <- as.integer(round(n))
  
  # Ensure n (groups) <= n_x (individuals): ----
  
  if (n > n_x) {
    
    message("Fewer individuals than groups: Setting n = length(x) = ", n_x, ".")
    
    n <- n_x
    
  }
  
  n_g <- seq_len(n)  # group indices 1:n
  
  # Group labels (number or label): ----
  if (is.null(labels)) {
    
    lab <- n_g
    
  } else {
    
    if (length(labels) != n) {
      
      stop("'labels' must provide exactly n = ", n, " label(s).")
      
    }
    
    lab <- labels
  }
  
  # Set seed (for reproducibility): ----
  if (!is.na(seed)) {
    
    set.seed(seed)
    
  }
  
  # Main: Assign groups ----
  if (balance) {
    
    # A: Balanced sample (recycle group indices, then permute):
    group <- rep_len(n_g, length.out = n_x)  # balanced: sizes differ by <= 1
    group <- sample(group)                   # random permutation
    
  } else {
    
    # B: Random sample (with replacement; ensure every group occurs):
    repeat {
      group <- sample(x = n_g, size = n_x, replace = TRUE, ...)
      if (length(unique(group)) == n) break  # all groups present
    }
    
  }
  
  # Data (map indices to labels, order by group, reset row names): ----
  df <- data.frame(name  = x,
                   group = factor(lab[group], levels = lab),
                   stringsAsFactors = FALSE)
  df <- df[order(df$group), , drop = FALSE]
  rownames(df) <- NULL
  
  # Output: ----
  if (as_list) {
    # Split into one table per group (named by number or label):
    out <- split(df, df$group)                       # named list of data.frames
    out <- lapply(out, function(d) { rownames(d) <- NULL; d })
    return(out)
  }
  
  return(df)
  
} # assign_group().


# get_name: Get an object's name (e.g., inside a function): ------ 

get_name <- function(x){
  
  deparse(substitute(expr = x))
  
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


# get_name_in_parenv: Get an object's name in parent environment: ------ 

get_name_in_parenv <- function(x){
  
  deparse(substitute(expr = x, env = parent.frame()))
  
} # get_name_in_parenv(). 



# get_list_names: Get names of list objects: ------ 

get_list_names <- function(l){
  
  # sapply(l, FUN = get_name)
  
  # sapply(l, FUN = get_name_in_parenv)
  
  # names(l) # extracts names of named list elements
  
  # enquote(l)
  
  deparse1(l)
  
} # get_list_names().

# # Check:
# l1 <- list("A", 1, TRUE)
# l2 <- list(FALSE, 1:3)
# l3 <- list(l1, l2)
#  
# get_name(l1)
# get_name(l3)
# get_list_names(l3)
# 
# library(unicol)
# my_pals <- list(uni_freiburg_1, uni_goettingen_1, mpg, uni_konstanz_1)
# get_list_names(my_pals)  # ERROR +++ here now +++





# deg2rad & rad2deg: Convert angles from degrees to radians (and vice versa): ------ 

deg2rad <- function(deg) {
  (deg * pi) / 180
}

rad2deg <- function(rad) {
  (rad * 180) / pi
}


# kill_all: Kill all objects in current environment (without warning): ------

kill_all <- function(){
  
  rm(list = ls())
  
} # kill_all(). 

## Check: 
# kill_all()


## ToDo: ----------

# - etc.

## eof. ----------------------