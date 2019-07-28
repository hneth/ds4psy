## plot_functions.R | ds4psy
## hn | uni.kn | 2019 07 28
## ---------------------------

## Functions for plotting. 



## (1) Colors: ----------

## Defining colors:

# library(unikn)  # use dedicated color package

#' ds4psy default color palette.
#' 
#' \code{pal_ds4psy} provides a dedicated color palette.
#' 
#' By default, \code{pal_ds4psy} is initialized to 
#' \code{pal_unikn} of the \bold{unikn} package. 
#' 
#' @family plot functions
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
#' Note that \code{pal_n_sq} was originally created for \code{pal = \link{pal_unikn}} 
#' for small values of \code{n} (\code{n = 1, 2, 3}) and 
#' returned the 11 colors of \code{\link{pal_unikn_plus}} for any \code{n > 3}. 
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
#' @family plot functions
#'
#' @seealso
#' \code{\link{unikn::seecol}} to plot color palettes; 
#' \code{\link{unikn::usecol}} to use color palettes; 
#' \code{\link{unikn::pal_unikn}} for the default unikn color palette. 
#' 
#' @import unikn

# - Definition: ---- 

pal_n_sq <- function(n = "all", pal = pal_ds4psy){
  
  # handle inputs:
  stopifnot(length(pal) > 0)
  
  if (is.character(n) && tolower(n) == "all") { n <- length(pal) }
  stopifnot(is.numeric(n))
  stopifnot(n > 0)
  
  out <- NA    # initialize
  
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
  #   if (isTRUE(all.equal(pal, pal_unikn))) {
  #     
  #     # out <- pal[c(1:2, 2:10)]   # 11 colors: seeblau (seeblau.3: 2x) > white (6 = mid) > black (11) [default]
  #     
  #     out <- pal_unikn        # 11 colors: seeblau.5 > white (6 = mid) > black (11)
  #     
  #   } else { # any other pal:
  #     
  #     out <- pal
  #     
  #   } # if (isTRUE(all.equal(pal, pal_unikn))) etc. 
  #   
  # } # if (n == etc.)
  
  # NEW version: ---- 
  if (n < 4) {
    
    out <- unikn::usecol(pal = pal, n = n^2)  # use unikn::usecol() to get n^2 colors of pal
    
  } else {
    
    out <- pal  # get entire pal
    
  } # if (n == etc.)
  
  return(out)
  
}

## Check:
# pal_n_sq(1)
# pal_n_sq(2)
# pal_n_sq(3)
# pal_n_sq(4)
# pal_n_sq(99)



## (2) Themes: ---------- 

## theme_ds4psy: ToDo: Define a generic ds4psy ggplot theme ------ 

#' ds4psy default plot theme (using ggplot2).
#'
#' \code{theme_ds4psy} provides a basic \bold{ds4psy} theme 
#' to use in \bold{ggplot2} commands. 
#' 
#' Note that \code{theme_ds4psy} is currently just passed to 
#' \code{theme_unikn} of \bold{unikn}. 
#' 
#' The theme is lightweight and no-nonsense, but somewhat 
#' opinionated (e.g., in using mostly grey scales to 
#' allow emphasizing data points with color accents). 
#' 
#' @param col_title Color of title (text) elements (optional, numeric).  
#' Default: \code{col_title = "black"}.  
#' Consider using \code{col_title = unikn::pal_seeblau[[4]]} 
#' in combination with black or grey data points. 
#' 
#' @param base_size Base font size (optional, numeric). 
#' Default: \code{base_size = 11}. 
#' 
#' @param base_family Base font family (optional, character). 
#' Default: \code{base_family = ""}.  
#' 
#' @param base_line_size Base line size (optional, numeric). 
#' Default: \code{base_line_size = base_size/20}.  
#' 
#' @param base_rect_size Base rectangle size (optional, numeric). 
#' Default: \code{base_rect_size = base_size/20}. 
#' 
#' @examples
#' # ???
#' 
#' @family plot functions
#'
#' @seealso
#' \code{\link{unikn::theme_unikn}} for the source of the current theme. 
#' 
#' @import ggplot2
#' @import unikn
#' 
#' @export

theme_ds4psy <- function(col_title = "black", 
                         base_size = 11,
                         base_family = "",
                         base_line_size = base_size/20,
                         base_rect_size = base_size/20) {
  
  
  out <- NA
  
  out <- unikn::theme_unikn(col_title = col_title, 
                            base_size = base_size,
                            base_family = base_family,
                            base_line_size = base_line_size,
                            base_rect_size = base_rect_size)
  
  return(out)
  
}  # theme_ds4psy end. 


## (1) Plots: ---------- 



## ToDo: ----------

## eof. ----------------------