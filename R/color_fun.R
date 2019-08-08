## color_fun.R | ds4psy
## hn | uni.kn | 2019 08 08
## ---------------------------

## Functions for plotting. 

## (1) Colors: ----------

## Defining colors:

#' ds4psy default color palette.
#' 
#' \code{pal_ds4psy} provides a dedicated color palette.
#' 
#' By default, \code{pal_ds4psy} is based on   
#' \code{pal_unikn} of the \bold{unikn} package. 
#' 
#' @family color objects and functions
#' 
#' @import unikn 
#' 
#' @export

pal_ds4psy <- unikn::pal_unikn

## Check: 
# unikn::seecol(pal_ds4psy)


# pal_n_sq: Get n^2 (n x n) specific colors of a palette [pal]: ------ 

# - Documentation: ---- 

#' Get n^2 dedicated colors of a color palette.
#'
#' \code{pal_n_sq} returns \code{n^2} dedicated colors of a color palette \code{pal} 
#' (up to a maximum of \code{n = "all"} colors). 
#' 
#' Use the more specialized function \code{unikn::usecol} for choosing 
#' \code{n} dedicated colors of a known color palette. 
#' 
#' @param n The desired number colors of pal (as a number) 
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
#' @import grDevices 
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
  
  if (n < 4) {
    
    # (a) using unikn:    
    # out <- unikn::usecol(pal = pal, n = n^2)  # use unikn::usecol() to get n^2 colors of pal
    
    # (b) NOT using unikn:
    if (n == 1){
      out <- unikn::Seeblau
    } else {
      out <- grDevices::colorRampPalette(colors = pal)(n^2)  
    }
    
  } else {
    
    # (a) using unikn: 
    # out <- unikn::usecol(pal, n = "all")  # get entire pal as is (i.e., without scaling it)
    
    # (b) NOT using unikn:    
    out <- pal
    
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