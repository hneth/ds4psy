## color_fun.R | ds4psy
## hn | uni.kn | 2019 08 01
## ---------------------------

## Functions for plotting. 

## (1) Colors: ----------

# library(unikn)

pal_unikn_web <- data.frame(                                 #  element: 
  "seeblau1" = rgb(204, 238, 249, maxColorValue = 255),  #  1. seeblau1 (non-transparent)
  "seeblau2" = rgb(166, 225, 244, maxColorValue = 255),  #  2. seeblau2 (non-transparent)
  "seeblau3" = rgb( 89, 199, 235, maxColorValue = 255),  #  3. seeblau3 (non-transparent) == preferred color: "Seeblau"
  "seeblau4" = rgb(  0, 169, 224, maxColorValue = 255),  #  4. seeblau4 (= OLD seeblau base color)
  "black"    = rgb(  0,   0,   0, maxColorValue = 255),  #  5. black
  "seegrau4" = rgb(102, 102, 102, maxColorValue = 255),  #  6. grey40 (non-transparent)
  "seegrau3" = rgb(153, 153, 153, maxColorValue = 255),  #  7. grey60 (non-transparent)
  "seegrau2" = rgb(204, 204, 204, maxColorValue = 255),  #  8. grey80 (non-transparent)
  "seegrau1" = rgb(229, 229, 229, maxColorValue = 255),  #  9. grey90 (non-transparent)
  "white"    = rgb(255, 255, 255, maxColorValue = 255),  # 10. white
  stringsAsFactors = FALSE)

pal_seeblau <- data.frame(                               #  element: 
  "seeblau1" = rgb(204, 238, 249, maxColorValue = 255),  #  1. seeblau1 (non-transparent):  20%
  "seeblau2" = rgb(166, 225, 244, maxColorValue = 255),  #  2. seeblau2 (non-transparent):  35%
  "seeblau3" = rgb( 89, 199, 235, maxColorValue = 255),  #  3. seeblau3 (non-transparent):  65%: preferred color: "seeblau"
  "seeblau4" = rgb(  0, 169, 224, maxColorValue = 255),  #  4. seeblau4 (non-transparent): 100%
  "seeblau5" = rgb(  0, 142, 206, maxColorValue = 255),  #  5. seeblau5 (non-transparent): neu
  stringsAsFactors = FALSE)

pal_unikn_2 <- cbind(rev(pal_seeblau), rev(pal_unikn_web[5:10]))
# unikn::seecol(pal_unikn_2)


## Defining colors:

#' ds4psy default color palette.
#' 
#' \code{pal_ds4psy} provides a dedicated color palette.
#' 
#' By default, \code{pal_ds4psy} is initialized to 
#' \code{pal_unikn} of the \bold{unikn} package. 
#' 
#' @family color objects and functions
#' 
#' @export

pal_ds4psy <- pal_unikn_2

## Check: 
# unikn::seecol(pal_ds4psy)


## seeblau:
#
# seeblau <- unikn::Seeblau
# seeblau  # seeblau3: "#59C7EB"
# seeblau == Seeblau



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