## theme_fun.R | ds4psy
## hn | uni.kn | 2020 08 27
## ---------------------------

## Functions for ggplot2 themes. 

## Themes: ---------- 

# theme_ds4psy: A clean and flexible ggplot2 theme ------ 

#' A basic and flexible plot theme (using ggplot2 and unikn).
#'
#' \code{theme_ds4psy} provides a generic \bold{ds4psy} theme 
#' to use in \bold{ggplot2} commands. 
#' 
#' The theme is lightweight and no-nonsense, but somewhat 
#' opinionated (e.g., in using transparency and grid lines, 
#' and relying on grey tones for emphasizing data with color accents). 
#' 
#' Basic sizes and the colors of text elements, 
#' backgrounds, and lines can be specified. 
#' However, excessive customization rarely yields aesthetic improvements 
#' over the standard \strong{ggplot2} themes. 
#' 
#' @param base_size Base font size (optional, numeric). 
#' Default: \code{base_size = 11}. 
#' 
#' @param base_family Base font family (optional, character). 
#' Default: \code{base_family = ""}. 
#' Options include \code{"mono"}, \code{"sans"} (default), and "serif". 
#' 
#' @param base_line_size Base line size (optional, numeric). 
#' Default: \code{base_line_size = base_size/22}. 
#' 
#' @param base_rect_size Base rectangle size (optional, numeric). 
#' Default: \code{base_rect_size = base_size/22}. 
#' 
#' @param col_title Color of plot title (and tag). 
#' Default: \code{col_title = grey(.0, 1)} (i.e., "black").  
#' 
#' @param col_txt_1 Color of primary text (headings and axis labels).  
#' Default: \code{col_title = grey(.1, 1)}. 
#' 
#' @param col_txt_2 Color of secondary text (caption, legend, axes labels/ticks). 
#' Default: \code{col_title = grey(.2, 1)}.  
#' 
#' @param col_txt_3 Color of other text (facet strip labels).  
#' Default: \code{col_title = grey(.1, 1)}. 
#' 
#' @param col_bgrnd Color of plot background.  
#' Default: \code{col_bgrnd = "transparent"}. 
#' 
#' @param col_panel Color of panel background(s).  
#' Default: \code{col_panel = grey(1.0, 1)} (i.e., "white"). 
#'  
#' @param col_strip Color of facet strips. 
#' Default: \code{col_strip = "transparent"}. 
#' 
#' @param col_axes Color of (x and y) axes. 
#' Default: \code{col_axes = grey(.00, 1)} (i.e., "black"). 
#' 
#' @param col_grids Color of (major and minor) panel lines. 
#' Default: \code{col_grids = grey(.75, 1)} (i.e., light "grey"). 
#' 
#' @param col_brdrs Color of (panel and strip) borders. 
#' Default: \code{col_brdrs = "transparent"}. 
#' 
#' @examples
#' 
#' \donttest{
#' 
#' # Plotting iris dataset (using ggplot2 and unikn):
#'
#' library('ggplot2')  # theme_ds4psy() requires ggplot2
#' library('unikn')    # for colors and usecol() function
#'    
#' ggplot(datasets::iris) +
#'   geom_jitter(aes(x = Petal.Length, y = Petal.Width, color = Species), size = 3, alpha = 2/3) +
#'   scale_color_manual(values = usecol(pal = c(Pinky, Seeblau, Seegruen))) +
#'   labs(title = "Iris petals",
#'        subtitle = "The subtitle of this plot", 
#'        caption = "Data from datasets::iris") +
#'   theme_ds4psy()
#' 
#' ggplot(datasets::iris) +
#'   geom_jitter(aes(x = Sepal.Length, y = Sepal.Width, color = Species), size = 3, alpha = 2/3) +
#'   facet_wrap(~Species) +
#'   scale_color_manual(values = usecol(pal = c(Pinky, Seeblau, Seegruen))) +
#'   labs(tag = "A",
#'        title = "Iris sepals",
#'        subtitle = "This is a demo plot with facets and default colors", 
#'        caption = "Data from datasets::iris") + 
#'   coord_fixed(ratio = 3/2) + 
#'   theme_ds4psy()
#' 
#' # in unikn::Seeblau look:
#' 
#' ggplot(datasets::iris) +
#'   geom_jitter(aes(x = Sepal.Length, y = Sepal.Width, color = Species), size = 3, alpha = 2/3) +
#'   facet_wrap(~Species) +
#'   scale_color_manual(values = usecol(pal = c(Pinky, Seeblau, Seegruen))) +
#'   labs(tag = "B",
#'        title = "Iris sepals",
#'        subtitle = "A demo plot using unikn::Seeblau colors", 
#'        caption = "Data from datasets::iris") + 
#'   coord_fixed(ratio = 3/2) + 
#'   theme_ds4psy(col_title = pal_seeblau[[4]], col_strip = pal_seeblau[[1]], col_brdrs = Grau)
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
                         base_line_size = base_size/22, 
                         base_rect_size = base_size/22,
                         col_title = grey(.0, 1),   # (main title) "black" OR unikn::pal_seeblau[[4]], 
                         col_txt_1 = grey(.1, 1),   # (subtitle, headings, and axis labels)
                         col_txt_2 = grey(.2, 1),   # (legend and axis text/ticks)
                         col_txt_3 = grey(.1, 1),   # (labels of facet strips)
                         col_bgrnd = "transparent", # (main background):  grey(1, 1) OR "white"
                         col_panel = grey(1.0, 1),  # (panel background): grey(1, 1) OR "white"
                         col_strip = "transparent", # (strip background): "transparent" OR grey(.95, 1)/light "grey"
                         col_axes  = grey(0.0, 1),  # (axes): grey(0, 1) OR "black"
                         col_grids = grey(.75, 1),  # (grid lines): grey(.50, 1) OR "grey"
                         col_brdrs = "transparent"  # (panel and strip borders): "transparent" OR grey(.05, 1)/nearly "black" 
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
      axis.line =  ggplot2::element_line(color = col_axes, size = ggplot2::rel(1.1)), 
      axis.title = ggplot2::element_text(color = col_txt_1), 
      axis.text =  ggplot2::element_text(color = col_txt_2, size = ggplot2::rel(.90)), 
      axis.ticks = ggplot2::element_line(color = col_txt_2, size = ggplot2::rel(.80)), 
      # legend: 
      legend.title = ggplot2::element_text(color = col_txt_1), 
      legend.text = ggplot2::element_text(color = col_txt_2), 
      legend.background = ggplot2::element_blank(), 
      legend.key = ggplot2::element_blank(), 
      # strip: 
      # strip.background = ggplot2::element_blank(), 
      strip.background = ggplot2::element_rect(fill = col_strip, color = col_brdrs, size = ggplot2::rel(1.0)), 
      strip.text = ggplot2::element_text(color = col_txt_3, size = ggplot2::rel(1.0), 
                                         margin = ggplot2::margin(t = 4, r = 4, b = 4, l = 4, unit = "pt")), 
      # panel: 
      # panel.border = ggplot2::element_blank(), 
      panel.border = ggplot2::element_rect(fill = "transparent", color = col_brdrs, linetype = "solid", 
                                           size = ggplot2::rel(1.0)), 
      # panel.grid = ggplot2::element_blank(), 
      panel.grid.major = ggplot2::element_line(color = col_grids, linetype = "solid", size = ggplot2::rel(.40)), 
      panel.grid.minor = ggplot2::element_line(color = col_grids, linetype = "solid", size = ggplot2::rel(.40)), # "dotted"/"solid" 
      # panel.background = ggplot2::element_blank(),  # no panel background 
      panel.background = ggplot2::element_rect(fill = col_panel, color = NA), # panel background 
      # background:  
      plot.background = ggplot2::element_rect(fill = col_bgrnd, color = NA), # main background
      complete = TRUE)
  
} # theme_ds4psy end. 


# theme_grau: Alternative theme for ggplot2 ------ 

#' A clean alternative theme for ggplot2.  
#' 
#' \code{theme_clean} provides an alternative \bold{ds4psy} theme 
#' to use in \bold{ggplot2} commands. 
#' 
#' \code{theme_clean} is more minimal than \code{\link{theme_ds4psy}} 
#' and fills panel backgrounds with a color \code{col_panel}. 
#' 
#' This theme works well for plots with multiple panels, 
#' strong colors and bright color accents, 
#' but is of limited use with transparent colors. 
#' 
#' @param base_size Base font size (optional, numeric). 
#' Default: \code{base_size = 11}. 
#' 
#' @param base_family Base font family (optional, character). 
#' Default: \code{base_family = ""}. 
#' Options include \code{"mono"}, \code{"sans"} (default), and "serif". 
#' 
#' @param base_line_size Base line size (optional, numeric). 
#' Default: \code{base_line_size = base_size/22}. 
#' 
#' @param base_rect_size Base rectangle size (optional, numeric). 
#' Default: \code{base_rect_size = base_size/22}. 
#' 
#' @param col_title Color of plot title (and tag). 
#' Default: \code{col_title = grey(.0, 1)} (i.e., "black"). 
#' 
#' @param col_panel Color of panel background(s). 
#' Default: \code{col_panel = grey(.85, 1)} (i.e., light "grey"). 
#' 
#' @param col_grids Color of panel lines (only major lines shown). 
#' Default: \code{col_grids = grey(1.0, 1)} (i.e., "white"). 
#' 
#' @param col_ticks Color of axes text and ticks. 
#' Default: \code{col_ticks = grey(.10, 1)} (i.e., near "black").
#'  
#' @examples
#' 
#' \donttest{
#' # Plotting iris dataset (using ggplot2, theme_grau, and unikn colors):
#'   
#' library('ggplot2')  # theme_clean() requires ggplot2
#' library('unikn')    # for colors and usecol() function
#'    
#' ggplot(datasets::iris) +
#'   geom_jitter(aes(x = Sepal.Length, y = Sepal.Width, color = Species), size = 3, alpha = 3/4) +
#'   facet_wrap(~Species) +
#'   scale_color_manual(values = usecol(pal = c(Pinky, Karpfenblau, Seegruen))) +
#'   labs(tag = "B",
#'        title = "Iris sepals",
#'        caption = "Data from datasets::iris") + 
#'   coord_fixed(ratio = 3/2) + 
#'   theme_clean()
#' 
#' }
#' 
#' @family plot functions
#' 
#' @seealso 
#' \code{\link{theme_ds4psy}} for default theme. 
#' 
#' @import ggplot2 
#'                          
#' @export 

# - Definition: ---- 

theme_clean <- function(base_size = 11, 
                        base_family = "", 
                        base_line_size = base_size/22, 
                        base_rect_size = base_size/22,
                        col_title = grey(0.0, 1),  # (main title): "black" OR unikn::pal_seeblau[[4]], 
                        col_panel = grey(.85, 1),  # (panel background): grey(.85, 1) OR light "grey"
                        col_grids = grey(1.0, 1),  # (panel lines, major): grey(1, 1) or "white"
                        col_ticks = grey(.10, 1)   # (axis text and ticks): grey(.10, 1) OR "black"
) {ggplot2::theme_bw(base_size = base_size, 
                     base_family = base_family, 
                     base_line_size = base_line_size, 
                     base_rect_size = base_rect_size) %+replace% 
    ggplot2::theme(#
      # titles: 
      title = ggplot2::element_text(color = col_title, face = "bold",
                                    margin = ggplot2::margin(t = 10, r = 4, b = 4, l = 4, unit = "pt")), 
      plot.subtitle = ggplot2::element_text(color = grey(.10, 1), face = "plain", hjust = 0,
                                            margin = ggplot2::margin(t = 2, r = 4, b = 8, l = 4, unit = "pt")), 
      plot.caption = ggplot2::element_text(color =  grey(.20, 1), face = "plain", size = ggplot2::rel(.80), hjust = 1), 
      # axes:
      axis.line =  ggplot2::element_blank(), 
      # axis.line =  ggplot2::element_line(color = "black", size = ggplot2::rel(1)), 
      # axis.ticks = ggplot2::element_line(color = "black"), 
      axis.ticks = ggplot2::element_line(color = col_ticks), 
      axis.title = ggplot2::element_text(color = grey(.20, 1)), 
      axis.text =  ggplot2::element_text(color = col_ticks, size = ggplot2::rel(.90)), 
      # legend: 
      legend.title = ggplot2::element_text(color = grey(.20, 1)), 
      legend.text =  ggplot2::element_text(color = grey(.10, 1), size = ggplot2::rel(.95)), 
      legend.background = ggplot2::element_blank(), 
      legend.key = ggplot2::element_blank(), 
      # strip: 
      # strip.background = ggplot2::element_blank(),
      # strip.background = ggplot2::element_rect(fill = pal_seeblau[[1]], color = pal_seeblau[[5]], size = ggplot2::rel(5/3)), 
      # strip.background = ggplot2::element_rect(fill = grey(.90, 1), color = grey(.90, 1), size = ggplot2::rel(6/3)), 
      strip.background = ggplot2::element_rect(fill = "transparent", color = NA, size = ggplot2::rel(1.0)),  # transparent strip 
      strip.text = ggplot2::element_text(color = grey(0, 1), size = ggplot2::rel(.95), 
                                         margin = ggplot2::margin(t = 4, r = 4, b = 4, l = 4, unit = "pt")), 
      # panel: 
      panel.border = ggplot2::element_blank(), 
      # panel.border = ggplot2::element_rect(fill = "transparent", color = grey(.10, 1), linetype = "solid", size = ggplot2::rel(2/3)), 
      # panel.background = ggplot2::element_blank(), 
      panel.background = ggplot2::element_rect(fill = col_panel, color = col_panel), # panel background
      # panel.grid = ggplot2::element_blank(), 
      panel.grid.major = ggplot2::element_line(color = col_grids, linetype = "solid", size = ggplot2::rel(.90)), # major lines
      panel.grid.minor = ggplot2::element_blank(), 
      # panel.grid.minor = ggplot2::element_line(color = grey(.95, 1), linetype = "solid", size = ggplot2::rel(2/3)), 
      # background:  
      plot.background = ggplot2::element_rect(fill = "transparent", color = NA), 
      complete = TRUE)
  
} # theme_clean end. 


## ToDo: ----------

## eof. ----------------------