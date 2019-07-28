## color_fun.R | ds4psy
## hn | uni.kn | 2019 07 28
## ---------------------------

## Functions for plotting. 

## (1) Colors: ----------

## Defining colors:

#' ds4psy default color palette.
#' 
#' \code{pal_ds4psy} provides a dedicated color palette.
#' 
#' By default, \code{pal_ds4psy} is initialized to 
#' \code{unikn::pal_unikn} of the \bold{unikn} package. 
#' 
#' @family color objects and functions
#' 
#' @import unikn 
#' 
#' @export

pal_ds4psy <- unikn::pal_unikn
# seeblau  <- unikn::Seeblau

## Check: 
# seeblau  # seeblau3: "#59C7EB"
# seeblau == Seeblau
# seecol(pal_ds4psy)


# pal_n_sq: Get n^2 (n x n) specific colors of a palette [pal]: ------ 

# - Documentation: ---- 

#' Get n^2 dedicated colors of a color palette.
#'
#' \code{pal_n_sq} returns \code{n^2} dedicated colors of a color palette \code{pal} 
#' (up to a maximum of \code{n = "all"} colors). 
#' 
#' Note that \code{pal_n_sq} was originally created for \code{pal = unikn::pal_unikn} 
#' for small values of \code{n} (\code{n = 1, 2, 3}) and 
#' returned the 11 colors of \code{unikn::pal_unikn} for any \code{n > 3}. 
#' 
#' Use the more specialized function \code{unikn::usecol} for choosing 
#' \code{n} dedicated colors of a known color palette. 
#' 
#' @param n A number specifying the desired number colors of pal (as a number) 
#' or the character string \code{"all"} (to get all colors of \code{pal}). 
#' Default: \code{n = "all"}. 
#'
#' @param pal A color palette (as a data frame). 
#' Default: \code{pal = \link{pal_ds4psy}}. 
#'
#' @examples
#' pal_n_sq(1)  #  1 color: seeblau3
#' pal_n_sq(2)  #  4 colors
#' pal_n_sq(3)  #  9 colors (5: white)
#' pal_n_sq(4)  # 11 colors (6: white)
#' 
#' @family color objects and functions
#'
#' @seealso
#' \code{\link{plot_tiles}} to plot tile plots. 
#' 
#' @import unikn
#' 
#' @export 

# - Definition: ---- 

pal_n_sq <- function(n = "all", pal = pal_ds4psy){
  
  # Handle inputs:
  stopifnot(length(pal) > 0)
  
  # Robustness:
  if (is.character(n) && tolower(n) == "all") { n <- length(pal) }
  stopifnot(is.numeric(n))
  stopifnot(n > 0)
  
  out <- NA  # initialize
  
  # # OLD version: ----
  # if (n == 1) {
  #   
  #   out <- pal[3]  #  1 preferred color: seeblau3
  #   
  # } else if (n == 2) {
  #   
  #   out <- pal[c(2, 4, 6, 10)]  #  4 colors: seeblau4, seeblau2, white, grey
  #   
  # } else if (n == 3) {
  #   
  #   out <- pal[-7]  #  9 colors: seeblau > white > black
  #   
  # } else { # n > 3: 9+ colors:
  #   
  #   if (isTRUE(all.equal(pal, unikn::pal_unikn))) {
  #     
  #     # out <- pal[c(1:2, 2:10)]   # 11 colors: seeblau (seeblau.3: 2x) > white (6 = mid) > black (11) [default]
  #     
  #     out <- unikn::pal_unikn        # 11 colors: seeblau.5 > white (6 = mid) > black (11)
  #     
  #   } else { # any other pal:
  #     
  #     out <- pal
  #     
  #   } # if (isTRUE(all.equal(pal, unikn::pal_unikn))) etc. 
  #   
  # } # if (n == etc.)
  
  # NEW version: ---- 
  if (n < 4) {
    
    out <- unikn::usecol(pal = pal, n = n^2)  # use unikn::usecol() to get n^2 colors of pal
    
  } else {
    
    out <- unikn::usecol(pal, n = "all")  # get entire pal as is (i.e., without scaling it)
    
  } # if (n == etc.)
  
  return(out)
  
}

## Check:
# pal_n_sq(1)
# pal_n_sq(2)
# pal_n_sq(3)
# pal_n_sq(4)
# pal_n_sq(99)


## ToDo: ----------

## eof. ----------------------