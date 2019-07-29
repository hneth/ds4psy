## theme_fun.R | ds4psy
## hn | uni.kn | 2019 07 28
## ---------------------------

## Functions for ggplot2 themes. 

## Themes: ---------- 

# theme_ds4psy: ToDo: Define a generic ds4psy ggplot theme ------ 

#' ds4psy default plot theme (using ggplot2 and unikn).
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




## ToDo: ----------

## eof. ----------------------