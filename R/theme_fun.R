## theme_fun.R | ds4psy
## hn | uni.kn | 2020 08 25
## ---------------------------

## Functions for ggplot2 themes. 

## Themes: ---------- 

# theme_ds4psy: Define a generic ds4psy ggplot theme ------ 

#' ds4psy default plot theme (using ggplot2 and unikn).
#'
#' \code{theme_ds4psy} provides a basic \bold{ds4psy} theme 
#' to use in \bold{ggplot2} commands. 
#' 
#' The theme is lightweight and no-nonsense, but somewhat 
#' opinionated (e.g., in using mostly grey scales to 
#' allow emphasizing data points with color accents). 
#' 
#' Whereas the colors of text elements and the plot background can be specified, 
#' the panel background is assumed to be white. 
#' 
#' @param base_size Base font size (optional, numeric). 
#' Default: \code{base_size = 11}. 
#' 
#' @param base_family Base font family (optional, character). 
#' Default: \code{base_family = ""}. 
#' Options include \code{"mono"}, \code{"sans"} (default), and "serif". 
#' 
#' @param base_line_size Base line size (optional, numeric). 
#' Default: \code{base_line_size = base_size/20}. 
#' 
#' @param base_rect_size Base rectangle size (optional, numeric). 
#' Default: \code{base_rect_size = base_size/20}. 
#' 
#' @param col_title Color of plot title (text) elements (optional).  
#' Default: \code{col_title = grey(.0, 1)} (i.e., "black").  
#' 
#' @param col_txt_1 Color of text headings and axis labels (optional).  
#' Default: \code{col_title = grey(.1, 1)}. 
#' 
#' @param col_txt_2 Color of legend and axis text/ticks (optional).  
#' Default: \code{col_title = grey(.2, 1)}.  
#' 
#' @param col_txt_3 Color of facet strip text (optional).  
#' Default: \code{col_title = grey(.1, 1)}. 
#' 
#' @param col_bg_1 Color of plot background (optional).  
#' Default: \code{col_bg_1 = "transparent"}. 
#' 
#' @param col_bg_2 Color of panel background (optional).  
#' Default: \code{col_bg_2 = grey(1.0, 1)} (i.e., "white"). 
#'  
#' @param col_bg_3 Color of facet strip background (optional).  
#' Default: \code{col_bg_3 = grey(.95, 1)} (i.e., nearly "white"). 
#' 
#' @examples
#' 
#' \donttest{
#'   # Plotting iris dataset (using ggplot2 and theme_ds4psy):
#'   
#'   library("ggplot2")  # theme_ds4psy requires ggplot2 
#'   
#'   ggplot(datasets::iris) +
#'     geom_jitter(aes(x = Petal.Length, y = Petal.Width, color = Species), size = 3, alpha = 2/3) +
#'     labs(title = "Iris species",
#'          caption = "Data from datasets::iris") +
#'     theme_ds4psy()
#'     
#' }
#'
#' @family plot functions
#'
#' @seealso
#' \code{unikn::theme_unikn} for the source of the current theme. 
#' 
#' @import ggplot2
#' @import unikn
#' @import datasets
#' 
#' @export

theme_ds4psy <- function(base_size = 11, 
                         base_family = "", 
                         base_line_size = base_size/20, 
                         base_rect_size = base_size/20,
                         col_title = grey(.0, 1),  # (main title) "black" OR unikn::pal_seeblau[[4]], 
                         col_txt_1 = grey(.1, 1),  # (subtitle, headings, and axis labels)
                         col_txt_2 = grey(.2, 1),  # (legend and axis text/ticks)
                         col_txt_3 = grey(.1, 1),  # (labels of facet strips)
                         col_bg_1 = "transparent", # (main background)  grey(1, 1) OR "white"
                         col_bg_2 = grey(1.0, 1),  # (panel background) grey(1, 1) OR "white"
                         col_bg_3 = grey(.95, 1)   # (strip background) grey(.95, 1) OR "lightgrey"
) {ggplot2::theme_bw(base_size = base_size, 
                     base_family = base_family, 
                     base_line_size = base_line_size, 
                     base_rect_size = base_rect_size) %+replace% 
    ggplot2::theme(#
      # titles: 
      title = ggplot2::element_text(color = col_title, face = "bold", 
                                    margin = ggplot2::margin(t = 10, r = 4, b = 4, l = 4, unit = "pt")), 
      plot.subtitle = ggplot2::element_text(color = col_txt_1, face = "plain", hjust = 0,
                                            margin = ggplot2::margin(t = 2, r = 4, b = 8, l = 4, unit = "pt")),  
      plot.caption  = ggplot2::element_text(color = col_txt_2, face = "plain", size = ggplot2::rel(.80), hjust = 1), 
      # axes:
      axis.line =  ggplot2::element_line(color = "black", size = ggplot2::rel(1)), 
      axis.title = ggplot2::element_text(color = col_txt_1), 
      axis.text =  ggplot2::element_text(color = col_txt_2), 
      axis.ticks = ggplot2::element_line(color = col_txt_2), 
      # legend: 
      legend.title = ggplot2::element_text(color = col_txt_1), 
      legend.text = ggplot2::element_text(color = col_txt_2), 
      legend.background = ggplot2::element_blank(), 
      legend.key = ggplot2::element_blank(), 
      # strip: 
      # strip.background = ggplot2::element_blank(), 
      strip.background = ggplot2::element_rect(fill = col_bg_3, color = grey(.10, 1),  # strip background  
                                               size = ggplot2::rel(1.0)), 
      strip.text = ggplot2::element_text(color = col_txt_3, size = ggplot2::rel(1.0), 
                                         margin = ggplot2::margin(t = 4, r = 4, b = 4, l = 4, unit = "pt")), 
      # panel: 
      # panel.border = ggplot2::element_blank(), 
      panel.border = ggplot2::element_rect(fill = "transparent", color = grey(.10, 1), linetype = "solid", 
                                           size = ggplot2::rel(2/3)), 
      # panel.grid = ggplot2::element_blank(), 
      panel.grid.major = ggplot2::element_line(color = grey(.80, 1), linetype = "solid",  size = ggplot2::rel(.35)), 
      panel.grid.minor = ggplot2::element_line(color = grey(.80, 1), linetype = "dotted", size = ggplot2::rel(.25)), 
      # panel.background = ggplot2::element_blank(),  # no panel background 
      panel.background = ggplot2::element_rect(fill = col_bg_2, color = NA), # panel background 
      # background:  
      plot.background = ggplot2::element_rect(fill = col_bg_1, color = NA), # main background
      complete = TRUE)
  
} # theme_ds4psy end. 

## ToDo: ----------

## eof. ----------------------