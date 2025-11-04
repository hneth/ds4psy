## plot_fun.R | ds4psy
## hn | uni.kn | 2025 11 04
## ------------------------

## Functions for plotting. 

## Global variables: ---------- 

utils::globalVariables(c("x", "y", "char"))  # to avoid Warning NOTE "Undefined global functions or variables". 

# Source: <https://community.rstudio.com/t/how-to-solve-no-visible-binding-for-global-variable-note/28887> 


## Plotting: ---------- 

## plot_tiles: Tile plots (of n x n tiles): -------- 

#' Plot n-by-n tiles.
#'
#' \code{plot_tiles} plots an area of \code{n-by-n} tiles 
#' on fixed or polar coordinates.  
#' 
#' @param n Basic number of tiles (on either side).
#'
#' @param pal Color palette (automatically extended to \code{n x n} colors). 
#' Default: \code{pal = \link{pal_ds4psy}}. 
#' 
#' @param sort Boolean: Sort tiles? 
#' Default: \code{sort = TRUE} (i.e., sorted tiles).  
#' 
#' @param borders Boolean: Add borders to tiles? 
#' Default: \code{borders = TRUE} (i.e., use borders).
#' 
#' @param border_col Color of borders (if \code{borders = TRUE}). 
#' Default: \code{border_col = "black"}.
#' 
#' @param border_size Size of borders (if \code{borders = TRUE}). 
#' Default: \code{border_size = 0.2}.  
#' 
#' @param lbl_tiles Boolean: Add numeric labels to tiles? 
#' Default: \code{lbl_tiles = FALSE} (i.e., no labels). 
#' 
#' @param lbl_title Boolean: Add numeric label (of n) to plot? 
#' Default: \code{lbl_title = FALSE} (i.e., no title). 
#'
#' @param polar Boolean: Plot on polar coordinates? 
#' Default: \code{polar = FALSE} (i.e., using fixed coordinates). 
#' 
#' @param rseed Random seed (number).  
#' Default: \code{rseed = NA} (using random seed). 
#' 
#' @param save Boolean: Save plot as png file? 
#' Default: \code{save = FALSE}. 
#' 
#' @param save_path Path to save plot (if \code{save = TRUE}).  
#' Default: \code{save_path = "images/tiles"}. 
#' 
#' @param prefix Prefix to plot name (if \code{save = TRUE}).  
#' Default: \code{prefix = ""}.
#' 
#' @param suffix Suffix to plot name (if \code{save = TRUE}).  
#' Default: \code{suffix = ""}. 
#'
#' @examples
#' # (1) Tile plot:
#' plot_tiles()  # default plot (random n, with borders, no labels)
#' 
#' plot_tiles(n = 4, sort = FALSE)      # random order
#' plot_tiles(n = 6, borders = FALSE)   # no borders
#' plot_tiles(n = 8, lbl_tiles = TRUE,  # with tile + 
#'            lbl_title = TRUE)         # title labels 
#' 
#' # Set colors: 
#' plot_tiles(n = 4, pal = c("orange", "white", "firebrick"),
#'            lbl_tiles = TRUE, lbl_title = TRUE,
#'            sort = TRUE)
#' plot_tiles(n = 6, sort = FALSE, border_col = "white", border_size = 2)
#'
#' # Fixed rseed:
#' plot_tiles(n = 4, sort = FALSE, borders = FALSE, 
#'            lbl_tiles = TRUE, lbl_title = TRUE, 
#'            rseed = 101)
#' 
#' # (2) polar plot:  
#' plot_tiles(polar = TRUE)  # default polar plot (with borders, no labels)
#' 
#' plot_tiles(n = 4, polar = TRUE, sort = FALSE)   # random order
#' plot_tiles(n = 6, polar = TRUE, sort = TRUE,    # sorted and with 
#'            lbl_tiles = TRUE, lbl_title = TRUE)  # tile + title labels 
#' plot_tiles(n = 4, sort = FALSE, borders = TRUE,  
#'            border_col = "white", border_size = 2, 
#'            polar = TRUE, rseed = 132)           # fixed rseed
#'  
#' @family plot functions
#'
#' @seealso
#' \code{\link{pal_ds4psy}} for default color palette. 
#' 
#' @import ggplot2
#' @import grDevices 
#' @import unikn
#' 
#' @export 

plot_tiles <- function(n = NA, 
                       pal = pal_ds4psy, 
                       sort = TRUE, 
                       borders = TRUE,
                       border_col = "black", 
                       border_size = 0.2, 
                       lbl_tiles = FALSE, 
                       lbl_title = FALSE, 
                       polar = FALSE,
                       rseed = NA, 
                       save = FALSE, 
                       save_path = "images/tiles",
                       prefix = "",
                       suffix = ""){
  
  # initialize:
  cur_col  <- NA
  cur_tb   <- NA
  cur_plot <- NA
  
  # Robustness:
  if (is.na(rseed)) {
    rseed <- sample(1:999, size = 1, replace = TRUE)  # random rseed
  }
  
  if (is.na(n)) {
    n <- sample(1:12, size = 1, replace = TRUE)  # random n
  }
  
  if ((!is.numeric(n)) || (n < 1) || (n %% 1 != 0)){
    n <- sample(1:12, size = 1, replace = TRUE)  # random n
    message(paste0("n must be a natural number: Using n = ", n, "...")) 
  }
  
  # Parameters (currently fixed):
  title_col  <- grey(.00, 1)  # "black"
  
  # Use inputs: 
  set.seed(seed = rseed)    # for reproducible randomness
  
  # Tile borders:
  if (borders){
    brd_col   <- border_col
    brd_size  <- border_size
  } else {
    brd_col  <- NA  # hide label
    brd_size <- NA  # hide label
  }
  
  # Label (on top left):
  cur_lbl <- as.character(n)
  
  if (lbl_title){
    # x_lbl <- 1 
    # y_lbl <- (n + 1) # + n/15
    top_col <- title_col
  } else {
    # x_lbl <- 1
    # y_lbl <- (n + 1)
    top_col <- NA  # hide label
  }
  
  if (polar){ # polar: 
    
    x_lbl <- n   
    
    if (lbl_title){
      y_lbl <- (n + 2)
    } else {
      y_lbl <- n
    }
    
    lbl_size      <- 15/n
    lbl_size_top  <- 30/n
    
  } else { # tiles:
    
    x_lbl <- 1
    
    if (lbl_title){
      y_lbl <- (n + 1)
      
      # # special cases: 
      # if (n == 1) {y_lbl <- (n + .50)}
      
    } else {
      y_lbl <- n
    }
    
    lbl_size      <- 30/n
    lbl_size_top  <- 30/n
    
  }
  
  # data tb:
  cur_tb  <- make_tb(n = n, rseed = rseed)
  
  # colors:
  cur_col <- pal_n_sq(n = n, pal = pal)
  
  # Special case: Replace a white tile for n = 2 by a grey tile:
  if (n == 2) { 
    # print(cur_col)  # debugging
    cur_col[cur_col == "#FFFFFF"] <- "#E1E2E5"  # HEX of unikn::pal_grau[[1]] 
  }
  
  # pick variables (in cur_tb):
  if (sort){
    
    var_tile <- "sort"          # case 1: sorted tiles
    
    if (lbl_tiles){
      lbl_col <- cur_tb$col_sort  # sorted lbl colors
    } else {
      lbl_col <- NA  # no label colors (no labels)
    }
    
  } else {
    
    var_tile <- "rand"  # case 2: random tiles
    
    if (lbl_tiles){
      lbl_col <- cur_tb$col_rand  # random lbl colors
    } else {
      lbl_col <- NA  # no label colors (no labels)
    }
    
  }  # if (sort) etc.
  
  # create a n x n SQUARE of tiles:
  cur_plot <- ggplot2::ggplot(data = cur_tb) + 
    ggplot2::geom_tile(aes(x = x, y = y,  fill = !!sym(var_tile)), color = brd_col, linewidth = brd_size) +  # tiles (with borders, opt.)
    ggplot2::geom_text(aes(x = x, y = y, label = !!sym(var_tile)), color = lbl_col, size = lbl_size) +  # labels (opt.) 
    ## Label (on top left): 
    ggplot2::annotate("text", x = x_lbl, y = y_lbl, label = cur_lbl, col = top_col, 
                      size = lbl_size_top, fontface = 1) +  # label (on top left)
    # Scale:
    # ggplot2::scale_y_continuous(limits = c(0, y_lbl + 1/4)) +  # scale (to fit top label)
    # ggplot2::scale_x_continuous(limits = c(0, y_lbl)) +        # scale (to fit label)
    # coord_fixed() + 
    ## Plot labels: 
    ggplot2::labs(title = "Tiles", x = "Data", y = "Science") +
    ## Colors: 
    ggplot2::scale_fill_gradientn(colors = cur_col) +  # s2: full unikn_sort palette: seeblau > white > black [default]
    theme_empty() # theme_gray() # cowplot::theme_nothing()
  
  if (lbl_title){
    
    # scale y (to fit top label)}: 
    # if (n==1) {cur_plot <- cur_plot + ggplot2::scale_y_continuous(limits = c(0, y_lbl + 1/3))}
    # if (n==2) {cur_plot <- cur_plot + ggplot2::scale_y_continuous(limits = c(0, y_lbl + 1/4))}
    # if (n==3) {cur_plot <- cur_plot + ggplot2::scale_y_continuous(limits = c(0, y_lbl + 1/5))}
    
    cur_plot <- cur_plot + ggplot2::scale_y_continuous(limits = c(0, y_lbl + 1/(n + 2)))
    
  }
  
  # add coordinate system:
  if (polar){
    cur_plot <- cur_plot + ggplot2::coord_polar()
  } else {
    cur_plot <- cur_plot + ggplot2::coord_fixed()
  }
  
  # save plot?
  if (save) {
    
    # initialize:
    plot_name <- NA
    full_name <- NA
    
    # directories:
    # save_path  <- "images/tiles"
    # dir_images <- "images"
    # dir_plot   <- "tiles"
    
    # determine plot name (from current settings):
    if (polar) { coord <- "pole" } else { coord <- "tile" }  
    if (n < 10) { num <- paste0("_", "0", n) } else { num <- paste0("_", n) }
    if (sort) { sort_rand <- "_sort" } else { sort_rand <- "_rand" }
    if (borders) { brds <- "_brd" } else { brds <- "" }
    if (lbl_tiles) { lbls <- "_lbl" } else { lbls <- "" }
    if (lbl_title) { titl <- "_tit" } else { titl <- "" }
    filext <- ".png"
    
    ## customize name:
    # prefix <- ""  # "toc_" "color_" "cover_"  # ""  # (e.g., "cover_")
    # suffix <- ""  # "_ds4psy" "_190731" # ""  # (e.g., "_ds4psy")
    
    plot_name <- paste0(prefix, coord, num, sort_rand, brds, lbls, titl, suffix, filext)
    
    ## (a) using the here package: 
    # full_name <- here::here(save_path, plot_name)
    
    # (b) using getwd() instead:
    cur_wd   <- getwd()
    full_name <- paste0(cur_wd, "/", save_path, "/", plot_name)  
    
    # Parameters (currently fixed):
    # plot_size <-  5.0  # SMALL:  in cm (used in ggsave below): normal (small) size
    plot_size <-    7.0  # NORMAL: in cm (used in ggsave below): normal (small) size
    # plot_size <- 10.0  # BIG:    in cm (used in ggsave below): when "./../images/big_"
    
    # Save plot: 
    ggsave(full_name, width = plot_size, height = plot_size, units = c("cm"), dpi = 300)
    
  }
  
  # plot plot: 
  cur_plot
  
  # return(invisible(cur_tb))
  
} # plot_tiles().

## Check:
# # (1) Tile plot:
# plot_tiles()  # default plot (random n, with borders, no labels)
# 
# plot_tiles(n =  6, sort = FALSE)      # random order
# plot_tiles(n =  8, borders = FALSE)   # no borders
# plot_tiles(n = 10, lbl_tiles = TRUE)  # with tile labels 
# plot_tiles(n = 10, lbl_title = TRUE)  # with title label
# 
# # Set colors: 
# plot_tiles(n = 4, pal = c(rev(pal_seegruen), "white", pal_karpfenblau), 
#            lbl_tiles = TRUE, sort = TRUE)
# plot_tiles(n = 5, pal = c(rev(pal_bordeaux), "white", pal_petrol), 
#            lbl_tiles = TRUE, lbl_title = TRUE, 
#            sort = TRUE)
# 
# # Fixed rseed:
# plot_tiles(n = 10, sort = FALSE, borders = TRUE, 
#            lbl_tiles = TRUE, lbl_title = TRUE, 
#            rseed = 101)  # fix seed
# 
# # (2) polar plot:
# plot_tiles(polar = TRUE) # default plot (random n, with borders, no labels)
# 
# plot_tiles(n =  6, polar = TRUE, sort = FALSE)      # random order
# plot_tiles(n =  8, polar = TRUE, borders = FALSE)   # no borders
# plot_tiles(n = 10, polar = TRUE, lbl_tiles = TRUE)  # with tile labels 
# plot_tiles(n = 10, polar = TRUE, lbl_title = TRUE)  # with title label 
# 
# # Set colors: 
# plot_tiles(n = 4, polar = TRUE,  
#            pal = c(rev(pal_seegruen), "white", pal_karpfenblau), 
#            lbl_tiles = FALSE, lbl_title = TRUE, 
#            sort = TRUE)
# plot_tiles(n = 5, polar = TRUE, 
#            pal = c(rev(pal_bordeaux), "white", pal_petrol), 
#            lbl_tiles = TRUE, lbl_title = TRUE, 
#            sort = TRUE)
# 
# # Fixed rseed:
# plot_tiles(n = 10, polar = TRUE, 
#            sort = FALSE, borders = TRUE, 
#            lbl_tiles = TRUE, lbl_title = TRUE, 
#            rseed = 101)  # fix seed
#
# # Note: theme_empty() removed need for: #' @importFrom cowplot theme_nothing 


## plot_fun: Wrapper around plot_tiles (with fewer and cryptic options): -------- 

#' An example function to plot some plot
#'
#' \code{plot_fun} provides options for plotting a plot. 
#' 
#' \code{plot_fun} is deliberately kept cryptic and obscure to illustrate 
#' how function parameters can be explored. 
#' 
#' \code{plot_fun} also shows that brevity in argument names should not 
#' come at the expense of clarity. In fact, transparent argument names 
#' are absolutely essential for understanding and using a function. 
#' 
#' \code{plot_fun} currently requires \code{pal_seeblau}, \code{pal_grau}, and 
#' \code{Bordeaux} (from the \strong{unikn} package) for its default colors.
#' 
#' @param a Numeric (integer > 0). 
#' Default: \code{a = NA}. 
#' 
#' @param b Boolean. 
#' Default: \code{b = TRUE}. 
#' 
#' @param c Boolean. 
#' Default: \code{c = TRUE}. 
#' 
#' @param d Numeric (double). 
#' Default: \code{d = 1.0}. 
#' 
#' @param e Boolean. 
#' Default: \code{e = FALSE}.
#' 
#' @param f Boolean. 
#' Default: \code{f = FALSE}. 
#' 
#' @param g Boolean. 
#' Default: \code{g = FALSE}. 
#'
#' @param c1 A color palette (as a vector). 
#' Default: \code{c1 = c(rev(pal_seeblau), "white", pal_grau, "black", Bordeaux)} 
#' (i.e., using colors of the \strong{unikn} package by default). 
#'
#' @param c2 A color (e.g., color name, as character). 
#' Default: \code{c2 = "black"}. 
#'
#' @examples
#' # Basics: 
#' plot_fun()
#' 
#' # Exploring options: 
#' plot_fun(a = 3, b = FALSE, e = TRUE)
#' plot_fun(a = 4, f = TRUE, g = TRUE, c1 = c("steelblue", "white", "firebrick"))
#' 
#' @family plot functions
#'
#' @seealso
#' \code{\link{plot_fn}} for a related function; 
#' \code{\link{pal_ds4psy}} for color palette. 
#' 
#' @import unikn
#' 
#' @export 

plot_fun <- function(a = NA, 
                     b = TRUE, 
                     c = TRUE,
                     d = 1.0, 
                     e = FALSE, 
                     f = FALSE, 
                     g = FALSE,
                     c1 = c(rev(pal_seeblau), "white", pal_grau, "black", Bordeaux), 
                     c2 = "black"
){
  
  # pass parameters to plot_tiles(): 
  plot_tiles(n = a, 
             pal = c1, 
             sort = b, 
             borders = c,
             border_col = c2, 
             border_size = d, 
             lbl_tiles = e, 
             lbl_title = f, 
             polar = g,
             # not used as options here: 
             rseed = NA, 
             save = FALSE, 
             save_path = "images/tiles",
             prefix = "",
             suffix = "")
  
} # plot_fun(). 

## Check:
# plot_fun()       # Task 1: Explore and describe each parameter.
# plot_fun(a = 5, b = F)
# plot_fun(a = 3)  # Task 2: Find a sensible range for a.

## Task 3: Re-create the following plots:
# plot_fun(a = 5, 
#          b = T, 
#          c = T,
#          d = 3,
#          e = F,
#          f = T,
#          g = F,
#          c1 = c(rev(pal_petrol), "white", pal_bordeaux),
#          c2 = "white")


## plot_n: Simpler row or column plots (of n tiles): -------- 

#' Plot n tiles 
#'
#' \code{plot_n} plots a row or column of \code{n} tiles 
#' on fixed or polar coordinates. 
#' 
#' Note that a polar row makes a tasty pie, 
#' whereas a polar column makes a target plot.  
#' 
#' @param n Basic number of tiles (on either side).
#' 
#' @param row Plot as a row? 
#' Default: \code{row = TRUE} (else plotted as a column). 
#'
#' @param polar Plot on polar coordinates? 
#' Default: \code{polar = FALSE} (i.e., using fixed coordinates). 
#'
#' @param pal A color palette (automatically extended to \code{n} colors). 
#' Default: \code{pal = \link{pal_ds4psy}}. 
#' 
#' @param sort Sort tiles? 
#' Default: \code{sort = TRUE} (i.e., sorted tiles).  
#' 
#' @param borders Add borders to tiles? 
#' Default: \code{borders = TRUE} (i.e., use borders).
#' 
#' @param border_col Color of borders (if \code{borders = TRUE}). 
#' Default: \code{border_col = "black"}.  
#' 
#' @param border_size Size of borders (if \code{borders = TRUE}). 
#' Default: \code{border_size = 0} (i.e., invisible).  
#' 
#' @param lbl_tiles Add numeric labels to tiles? 
#' Default: \code{lbl_tiles = FALSE} (i.e., no labels). 
#' 
#' @param lbl_title Add numeric label (of n) to plot? 
#' Default: \code{lbl_title = FALSE} (i.e., no title).
#' 
#' @param rseed Random seed (number).  
#' Default: \code{rseed = NA} (using random seed). 
#' 
#' @param save Save plot as png file? 
#' Default: \code{save = FALSE}. 
#' 
#' @param save_path Path to save plot (if \code{save = TRUE}).  
#' Default: \code{save_path = "images/tiles"}. 
#' 
#' @param prefix Prefix to plot name (if \code{save = TRUE}).  
#' Default: \code{prefix = ""}.
#' 
#' @param suffix Suffix to plot name (if \code{save = TRUE}).  
#' Default: \code{suffix = ""}. 
#'
#' @examples
#' # (1) Basics (as ROW or COL): 
#' plot_n()  # default plot (random n, row = TRUE, with borders, no labels)
#' plot_n(row = FALSE)  # default plot (random n, with borders, no labels)
#' 
#' plot_n(n = 4, sort = FALSE)      # random order
#' plot_n(n = 6, borders = FALSE)   # no borders
#' plot_n(n = 8, lbl_tiles = TRUE,  # with tile + 
#'        lbl_title = TRUE)         # title labels 
#' 
#' # Set colors: 
#' plot_n(n = 5, row = TRUE, lbl_tiles = TRUE, lbl_title = TRUE,
#'        pal = c("orange", "white", "firebrick"),
#'        border_col = "white", border_size = 2)
#'   
#' # Fixed rseed:
#' plot_n(n = 4, sort = FALSE, borders = FALSE, 
#'        lbl_tiles = TRUE, lbl_title = TRUE, rseed = 101)
#' 
#' # (2) polar plot (as PIE or TARGET):    
#' plot_n(polar = TRUE)  # PIE plot (with borders, no labels)
#' plot_n(polar = TRUE, row = FALSE)  # TARGET plot (with borders, no labels)
#' 
#' plot_n(n = 4, polar = TRUE, sort = FALSE)      # PIE in random order
#' plot_n(n = 5, polar = TRUE, row = FALSE, borders = FALSE)   # TARGET no borders
#' plot_n(n = 5, polar = TRUE, lbl_tiles = TRUE)  # PIE with tile labels 
#' plot_n(n = 5, polar = TRUE, row = FALSE, lbl_title = TRUE)  # TARGET with title label 
#' 
#' # plot_n(n = 4, row = TRUE, sort = FALSE, borders = TRUE,  
#' #        border_col = "white", border_size = 2, 
#' #        polar = TRUE, rseed = 132)
#' # plot_n(n = 4, row = FALSE, sort = FALSE, borders = TRUE,  
#' #        border_col = "white", border_size = 2, 
#' #        polar = TRUE, rseed = 134)
#'  
#' @family plot functions
#'
#' @seealso
#' \code{\link{pal_ds4psy}} for default color palette. 
#' 
#' @import ggplot2
#' @import grDevices
#' @import unikn
#' 
#' @export 

plot_n <- function(n = NA, 
                   row = TRUE, 
                   polar = FALSE, 
                   pal = pal_ds4psy,
                   sort = TRUE, 
                   borders = TRUE,
                   border_col = "black", 
                   border_size = 0,
                   lbl_tiles = FALSE, 
                   lbl_title = FALSE, 
                   rseed = NA, 
                   save = FALSE, 
                   save_path = "images/tiles",
                   prefix = "",
                   suffix = ""){
  
  # initialize:
  cur_col  <- NA
  cur_tb   <- NA
  cur_plot <- NA
  
  # Robustness:
  if (is.na(rseed)) {
    rseed <- sample(1:999, size = 1, replace = TRUE)  # random rseed
  }
  
  if (is.na(n)) {
    n <- sample(1:12, size = 1, replace = TRUE)  # random n
  }
  
  if ((!is.numeric(n)) || (n < 1) || (n %% 1 != 0)){
    n <- sample(1:12, size = 1, replace = TRUE)  # random n
    message(paste0("n must be a natural number: Using n = ", n, "...")) 
  }
  
  # Parameters (currently fixed):
  title_col  <- grey(.00, 1)  # "black"
  
  # Use inputs: 
  set.seed(seed = rseed)    # for reproducible randomness
  
  # Tile borders:
  if (borders){
    brd_col   <- border_col
    brd_size  <- border_size
  } else {
    brd_col  <- NA  # hide label
    brd_size <- NA  # hide label
  }
  
  # Label (on top left):
  cur_lbl <- as.character(n)
  
  if (lbl_title){
    # x_lbl <- 1 
    # y_lbl <- (n + 1) # + n/15
    top_col <- title_col
  } else {
    # x_lbl <- 1
    # y_lbl <- (n + 1)
    top_col <- NA  # hide label
  }
  
  if (polar){ # polar: 
    
    if (row){
      x_lbl <- n  # x-coordinate of label 
    } else { # as col: 
      x_lbl <- 1
    } # if (row) etc. 
    
    if (row) {
      
      if (n == 1){
        y_lbl <- 2.5
        lbl_size      <- 25/n
        lbl_size_top  <- 50/n
      } else {
        y_lbl <- 2      
        lbl_size      <- 50/n
        lbl_size_top  <- 50/n
      }
      
    } else { # as col: 
      
      if (n == 1){
        y_lbl <- 2.5
        lbl_size      <- 25/n
        lbl_size_top  <- 50/n
      } else {
        y_lbl <- n + 1      
        lbl_size      <- 45/n
        lbl_size_top  <- 45/n
      } 
      
    } # if (row) etc. 
    
  } else { # tiles:
    
    x_lbl <- 1
    
    if (row) {
      
      if (lbl_title){
        
        y_lbl <- 2
        # # special cases: 
        # if (n == 1) {y_lbl <- (n + .50)}
        
      } else {
        
        y_lbl <- 1
        
      } # if (lbl_title). 
      
      lbl_size      <- 50/n
      lbl_size_top  <- 50/n
      
    } else { # as col:
      
      if (lbl_title){
        
        y_lbl <- n + 1 
        
      } else {
        
        y_lbl <- n
        
      } # if (lbl_title). 
      
      lbl_size      <- 50/n
      lbl_size_top  <- 50/n
      
    } # if (row) etc. 
    
  }
  
  # data tb:
  # cur_tb  <- make_tb(n = n, rseed = rseed)  # use n x n table helper function
  cur_tb  <- make_tbs(n = n, rseed = rseed)   # use simpler 1 x n table helper function
  
  # colors:
  # cur_col <- pal_n_sq(n = n, pal = pal)  # use pal_n_sq helper function
  cur_col <- grDevices::colorRampPalette(colors = pal)(n)  # scale pal to length n
  
  # Special case: Replace a white tile for n = 2 by a grey tile:
  if (n == 2) { 
    # print(cur_col)  # debugging
    cur_col[cur_col == "#FFFFFF"] <- "#E1E2E5"  # HEX of unikn::pal_grau[[1]] 
  }
  
  # pick variables (in cur_tb):
  if (sort){
    
    var_tile <- "sort"          # case 1: sorted tiles
    
    if (lbl_tiles){
      lbl_col <- cur_tb$col_sort  # sorted lbl colors
    } else {
      lbl_col <- NA  # no label colors (no labels)
    }
    
  } else {
    
    var_tile <- "rand"  # case 2: random tiles
    
    if (lbl_tiles){
      lbl_col <- cur_tb$col_rand  # random lbl colors
    } else {
      lbl_col <- NA  # no label colors (no labels)
    }
    
  }  # if (sort) etc.
  
  if (row) {
    
    # create a ROW of tiles:
    cur_plot <- ggplot2::ggplot(data = cur_tb) + 
      ggplot2::geom_tile(aes(x = x, y = y,  fill = !!sym(var_tile)), color = brd_col, size = brd_size) +  # tiles (with borders, opt.)
      ggplot2::geom_text(aes(x = x, y = y, label = !!sym(var_tile)), color = lbl_col, size = lbl_size) +  # labels (opt.) 
      ## Label (on top left): 
      ggplot2::annotate("text", x = x_lbl, y = y_lbl, label = cur_lbl, col = top_col, 
                        size = lbl_size_top, fontface = 1) +  # label (on top left)
      # Scale:
      # ggplot2::scale_y_continuous(limits = c(0, y_lbl + 1/4)) +  # scale (to fit top label)
      # ggplot2::scale_x_continuous(limits = c(0, y_lbl)) +        # scale (to fit label)
      # coord_fixed() + 
      ## Plot labels: 
      ggplot2::labs(title = "Tiles", x = "Data", y = "Science") +
      ## Colors: 
      ggplot2::scale_fill_gradientn(colors = cur_col) +  # s2: full unikn_sort palette: seeblau > white > black [default]
      theme_empty() # theme_gray() # cowplot::theme_nothing()
    
  } else { # as col: 
    
    # create a COLUMN of tiles:
    cur_plot <- ggplot2::ggplot(data = cur_tb) + 
      ggplot2::geom_tile(aes(x = y, y = ((n + 1) - x),  fill = !!sym(var_tile)), color = brd_col, size = brd_size) +  # tiles (with borders, opt.)
      ggplot2::geom_text(aes(x = y, y = ((n + 1) - x), label = !!sym(var_tile)), color = lbl_col, size = lbl_size) +  # labels (opt.) 
      ## Label (on top left): 
      ggplot2::annotate("text", x = x_lbl, y = y_lbl, label = cur_lbl, col = top_col, 
                        size = lbl_size_top, fontface = 1) +  # label (on top left)
      # Scale:
      # ggplot2::scale_y_continuous(limits = c(0, y_lbl + 1/4)) +  # scale (to fit top label)
      # ggplot2::scale_x_continuous(limits = c(0, y_lbl)) +        # scale (to fit label)
      # coord_fixed() + 
      ## Plot labels: 
      ggplot2::labs(title = "Tiles", x = "Data", y = "Science") +
      ## Colors: 
      ggplot2::scale_fill_gradientn(colors = cur_col) +  # s2: full unikn_sort palette: seeblau > white > black [default]
      theme_empty() # theme_gray() # cowplot::theme_nothing()
    
  } # if (row) etc. 
  
  if (lbl_title){
    
    # scale y (to fit top label)}: 
    # if (n==1) {cur_plot <- cur_plot + ggplot2::scale_y_continuous(limits = c(0, y_lbl + 1/3))}
    # if (n==2) {cur_plot <- cur_plot + ggplot2::scale_y_continuous(limits = c(0, y_lbl + 1/4))}
    # if (n==3) {cur_plot <- cur_plot + ggplot2::scale_y_continuous(limits = c(0, y_lbl + 1/5))}
    
    cur_plot <- cur_plot + ggplot2::scale_y_continuous(limits = c(0, y_lbl + 1/(n + 2)))
    
  }
  
  # add coordinate system:
  if (polar){
    cur_plot <- cur_plot + ggplot2::coord_polar()
  } else {
    cur_plot <- cur_plot + ggplot2::coord_fixed()
  }
  
  # save plot?
  if (save) {
    
    # initialize:
    plot_name <- NA
    full_name <- NA
    
    # directories:
    # save_path  <- "images/tiles"
    # dir_images <- "images"
    # dir_plot   <- "tiles"
    
    # determine plot name (from current settings):
    if (row) { p_type <- "row_"} else { p_type <- "col_"}  # p_type new in simple plot
    
    if (polar) { 
      coord <- "fix"                 # modified in simple plot   
      if (row) { p_type <- "pie_" }  # p_type new in simple plot
    } else { 
      coord <- "pol"                 # modified in simple plot   
      if (row) { p_type <- "tar_" }  # p_type new in simple plot
    }   
    
    if (n < 10) { num <- paste0("_", "0", n) } else { num <- paste0("_", n) }
    if (sort) { sort_rand <- "_sort" } else { sort_rand <- "_rand" }
    if (borders) { brds <- "_brd" } else { brds <- "" }
    if (lbl_tiles) { lbls <- "_lbl" } else { lbls <- "" }
    if (lbl_title) { titl <- "_tit" } else { titl <- "" }
    filext <- ".png"
    
    ## customize name:
    # prefix <- ""  # "toc_" "color_" "cover_"  # ""  # (e.g., "cover_")
    # suffix <- ""  # "_ds4psy" "_190731" # ""  # (e.g., "_ds4psy")
    
    plot_name <- paste0(prefix, p_type, coord, num, sort_rand, brds, lbls, titl, suffix, filext)
    
    ## (a) using the here package: 
    # full_name <- here::here(save_path, plot_name)
    
    # (b) using getwd() instead:
    cur_wd   <- getwd()
    full_name <- paste0(cur_wd, "/", save_path, "/", plot_name) 
    
    # Parameters (currently fixed):
    # plot_size <-  5.0  # SMALL:  in cm (used in ggsave below): normal (small) size
    plot_size <-    7.0  # NORMAL: in cm (used in ggsave below): normal (small) size
    # plot_size <- 10.0  # BIG:    in cm (used in ggsave below): when "./../images/big_"
    
    # Save plot: 
    ggsave(full_name, width = plot_size, height = plot_size, units = c("cm"), dpi = 300)
    
  }
  
  # plot plot: 
  cur_plot
  
  # return(invisible(cur_tb))
  
} # plot_n().

## Check:
# # (1) ROW: 
# plot_n()  # default plot (random n, row = TRUE, with borders, no labels)
# 
# # (1a) ROW plots:
# plot_n(n = 5, sort = FALSE)      # random order
# plot_n(n = 5, borders = FALSE)   # no borders
# plot_n(n = 7, lbl_tiles = TRUE)  # with tile labels
# plot_n(n = 7, lbl_title = TRUE)  # with title label
# 
# # Set colors:
# plot_n(n = 4, pal = c(rev(pal_seegruen), "white", pal_karpfenblau),
#        lbl_tiles = TRUE, sort = TRUE)
# plot_n(n = 5, pal = c(rev(pal_bordeaux), "white", pal_petrol),
#        lbl_tiles = TRUE, lbl_title = TRUE, sort = TRUE)
# 
# # Fixed rseed:
# plot_n(n = 10, sort = FALSE, borders = TRUE,
#        lbl_tiles = TRUE, lbl_title = TRUE,
#        rseed = 101)  # fix seed
# 
# # (1b) PIE plots (on polar coordinates): 
# plot_n(polar = TRUE) # default plot (random n, with borders, no labels)
# 
# plot_n(n = 4, polar = TRUE, sort = FALSE)      # random order
# plot_n(n = 5, polar = TRUE, borders = FALSE)   # no borders
# plot_n(n = 7, polar = TRUE, lbl_tiles = TRUE)  # with tile labels
# plot_n(n = 7, polar = TRUE, lbl_title = TRUE)  # with title label
# 
# # Set colors:
# plot_n(n = 4, polar = TRUE,
#        pal = c(rev(pal_seegruen), "white", pal_karpfenblau),
#        lbl_tiles = FALSE, lbl_title = TRUE,
#        sort = TRUE)
# plot_n(n = 5, polar = TRUE,
#        pal = c(rev(pal_bordeaux), "white", pal_petrol),
#        lbl_tiles = TRUE, lbl_title = TRUE,
#        sort = TRUE)
# 
# # Fixed rseed:
# plot_n(n = 10, polar = TRUE,
#        sort = FALSE, borders = TRUE,
#        lbl_tiles = TRUE, lbl_title = TRUE,
#        rseed = 101)  # fix seed
# 
# # (2) COLUMN: 
# plot_n(row = F)  # default plot (random n, row = FALSE, with borders, no labels)
# 
# # (1a) ROW plots:
# plot_n(n = 5, row = F, sort = FALSE)      # random order
# plot_n(n = 5, row = F, borders = FALSE)   # no borders
# plot_n(n = 7, row = F, lbl_tiles = TRUE)  # with tile labels
# plot_n(n = 7, row = F, lbl_title = TRUE)  # with title label
# 
# # Set colors:
# plot_n(n = 4, row = FALSE, 
#        pal = c(rev(pal_seegruen), "white", pal_karpfenblau),
#        lbl_tiles = TRUE, sort = TRUE)
# plot_n(n = 5, row = FALSE, 
#        pal = c(rev(pal_bordeaux), "white", pal_petrol),
#        lbl_tiles = TRUE, lbl_title = TRUE, sort = TRUE)
# 
# # Fixed rseed:
# plot_n(n = 10, row = FALSE, 
#        sort = FALSE, borders = TRUE,
#        lbl_tiles = TRUE, lbl_title = TRUE,
#        rseed = 101)  # fix seed
# 
# # (1b) PIE plots (on polar coordinates): 
# plot_n(row = FALSE, polar = TRUE) # default plot (random n, with borders, no labels)
# 
# plot_n(n = 4, row = FALSE, polar = TRUE, sort = FALSE)      # random order
# plot_n(n = 5, row = FALSE, polar = TRUE, borders = FALSE)   # no borders
# plot_n(n = 7, row = FALSE, polar = TRUE, lbl_tiles = TRUE)  # with tile labels
# plot_n(n = 7, row = FALSE, polar = TRUE, lbl_title = TRUE)  # with title label
# 
# # Set colors:
# plot_n(n = 4, row = FALSE, polar = TRUE,
#        pal = c(rev(pal_seegruen), "white", pal_karpfenblau),
#        lbl_tiles = FALSE, lbl_title = TRUE,
#        sort = TRUE)
# plot_n(n = 5, row = FALSE, polar = TRUE,
#        pal = c(rev(pal_bordeaux), "white", pal_petrol),
#        lbl_tiles = TRUE, lbl_title = TRUE,
#        sort = TRUE)
# 
# # Fixed rseed:
# plot_n(n = 10, row = FALSE, polar = TRUE,
#        sort = FALSE, borders = TRUE,
#        lbl_tiles = TRUE, lbl_title = TRUE,
#        rseed = 101)  # fix seed
#
# # Note: theme_empty() removed need for: #' @importFrom cowplot theme_nothing 


## plot_fn: Wrapper around plot_n (with fewer and cryptic options): -------- 

#' A function to plot a plot
#'
#' \code{plot_fn} is a function that uses parameters for plotting a plot. 
#' 
#' \code{plot_fn} is deliberately kept cryptic and obscure to illustrate 
#' how function parameters can be explored. 
#' 
#' \code{plot_fn} also shows that brevity in argument names should not 
#' come at the expense of clarity. In fact, transparent argument names 
#' are absolutely essential for understanding and using a function. 
#' 
#' \code{plot_fn} currently requires \code{pal_seeblau} and 
#' \code{pal_pinky} (from the \strong{unikn} package) for its default colors.
#' 
#' @param x Numeric (integer > 0). 
#' Default: \code{x = NA}. 
#' 
#' @param y Numeric (double).  
#' Default: \code{y = 1}. 
#' 
#' @param A Boolean. 
#' Default: \code{A = TRUE}. 
#' 
#' @param B Boolean. 
#' Default: \code{B = FALSE}. 
#' 
#' @param C Boolean. 
#' Default: \code{C = TRUE}. 
#' 
#' @param D Boolean. 
#' Default: \code{D = FALSE}.
#' 
#' @param E Boolean. 
#' Default: \code{E = FALSE}.
#' 
#' @param F Boolean. 
#' Default: \code{F = FALSE}.
#'
#' @param f A color palette (as a vector). 
#' Default: \code{f = c(rev(pal_seeblau), "white", pal_pinky)}. 
#' Note: Using colors of the \code{unikn} package by default. 
#'
#' @param g A color (e.g., a color name, as a character). 
#' Default: \code{g = "white"}. 
#'
#' @examples
#' # Basics: 
#' plot_fn()
#' 
#' # Exploring options: 
#' plot_fn(x = 2, A = TRUE)
#' plot_fn(x = 3, A = FALSE, E = TRUE)
#' plot_fn(x = 4, A = TRUE,  B = TRUE, D = TRUE)
#' plot_fn(x = 5, A = FALSE, B = TRUE, E = TRUE, f = c("black", "white", "gold"))
#' plot_fn(x = 7, A = TRUE,  B = TRUE, F = TRUE, f = c("steelblue", "white", "forestgreen"))
#' 
#' @family plot functions
#'
#' @seealso
#' \code{\link{plot_fun}} for a related function; 
#' \code{\link{pal_ds4psy}} for a color palette. 
#' 
#' @import unikn
#' 
#' @export 

plot_fn <- function(x = NA,
                    y = 1, 
                    A = TRUE, 
                    B = FALSE,  
                    C = TRUE,
                    D = FALSE, 
                    E = FALSE, 
                    F = FALSE,
                    f = c(rev(pal_seeblau), "white", pal_pinky), 
                    g = "white"
){
  
  # pass parameters to plot_n(): 
  plot_n(n = x, 
         row  = A, 
         polar = B, 
         sort  = C, 
         borders   = D,
         lbl_tiles = E, 
         lbl_title = F, 
         border_size = y,
         pal         = f, 
         border_col  = g, 
         # not used as options here: 
         rseed = NA, 
         save = FALSE, 
         save_path = "images/tiles",
         prefix = "plot_fn_",
         suffix = "")
  
} # plot_fn(). 



## plot_text: Plot text characters as a tile plot: -------- 

#' Plot text characters (from file or user input) 
#'
#' \code{plot_text} parses text 
#' (from a file or from user input) 
#' and plots its individual characters 
#' as a tile plot (using \strong{ggplot2}).
#' 
#' \code{plot_text} blurs the boundary between a text 
#' and its graphical representation by adding visual options 
#' for coloring characters based on their frequency counts. 
#' (Note that \code{\link{plot_chars}} provides additional 
#' support for matching regular expressions.) 
#' 
#' 
#' @details 
#' \code{plot_text} is character-based: 
#' Individual characters are plotted at equidistant x-y-positions 
#' with color settings for text labels and tile fill colors.
#' 
#' By default, the color palette \code{pal} 
#' (used for tile fill colors) is scaled 
#' to indicate character frequency. 
#' 
#' \code{plot_text} invisibly returns a 
#' description of the plot (as a data frame). 
#' 
#' @return An invisible data frame describing the plot.
#' 
#' @param x The text to plot (as a character vector). 
#' Different elements denote different lines of text. 
#' If \code{x = NA} (as per default), 
#' the \code{file} argument is used to read 
#' a text file or scan user input (entering text in Console).  
#' 
#' @param file A text file to read (or its path). 
#' If \code{file = ""} (as per default), 
#' \code{scan} is used to read user input from the Console. 
#' If a text file is stored in a sub-directory, 
#' enter its path and name here (without any leading or 
#' trailing "." or "/"). 
#' 
#' @param char_bg Character used as background. 
#' Default: \code{char_bg = " "}. 
#' If \code{char_bg = NA}, the most frequent character is used. 
#' 
#' @param lbl_tiles Add character labels to tiles? 
#' Default: \code{lbl_tiles = TRUE} (i.e., show labels). 
#' 
#' @param lbl_rotate Rotate character labels? 
#' Default: \code{lbl_rotate = FALSE} (i.e., no rotation). 
#' 
#' @param cex Character size (numeric). 
#' Default: \code{cex = 3}.
#' 
#' @param family Font family of text labels (name).
#' Default: \code{family = "sans"}. 
#' Alternative options: "sans", "serif", or "mono".
#' 
#' @param fontface Font face of text labels (numeric). 
#' Default: \code{fontface = 1}, (from 1 to 4).
#' 
#' @param col_lbl Color of text labels.
#' Default: \code{col_lbl = "black"} (if \code{lbl_tiles = TRUE}). 
#' 
#' @param col_bg Color of \code{char_bg} (if defined), 
#' or the most frequent character in text (typically \code{" "}). 
#' Default: \code{col_bg = "white"}. 
#' 
#' @param pal Color palette for filling tiles 
#' of text (used in order of character frequency). 
#' Default: \code{pal = pal_ds4psy[1:5]} 
#' (i.e., shades of \code{Seeblau}).
#' 
#' @param pal_extend Boolean: Should \code{pal} be extended 
#' to match the number of different characters in text? 
#' Default: \code{pal_extend = TRUE}. 
#' If \code{pal_extend = FALSE}, only the tiles of 
#' the \code{length(pal)} most frequent characters 
#' will be filled by the colors of \code{pal}. 
#' 
#' @param case_sense Boolean: Distinguish 
#' lower- vs. uppercase characters? 
#' Default: \code{case_sense = FALSE}. 
#' 
#' @param borders Boolean: Add borders to tiles? 
#' Default: \code{borders = TRUE} (i.e., use borders).
#' 
#' @param border_col Color of borders (if \code{borders = TRUE}). 
#' Default: \code{border_col = "white"}.  
#' 
#' @param border_size Size of borders (if \code{borders = TRUE}). 
#' Default: \code{border_size = 0.5}.
#' 
#' @examples
#' # (A) From text string(s):
#' plot_text(x = c("Hello", "world!"))
#' plot_text(x = c("Hello world!", "How are you today?"))
#' 
#' # (B) From user input:
#' # plot_text()  # (enter text in Console)
#' 
#' # (C) From text file:
#' ## Create a temporary file "test.txt":
#' # cat("Hello world!", "This is a test file.", 
#' #     "Can you see this text?", 
#' #     "Good! Please carry on...", 
#' #     file = "test.txt", sep = "\n")
#' 
#' # plot_text(file = "test.txt")
#' 
#' ## Set colors, pal_extend, and case_sense:
#' # cols <- c("steelblue", "skyblue", "lightgrey")
#' # cols <- c("firebrick", "olivedrab", "steelblue", "orange", "gold")
#' # plot_text(file = "test.txt", pal = cols, pal_extend = TRUE)
#' # plot_text(file = "test.txt", pal = cols, pal_extend = FALSE)
#' # plot_text(file = "test.txt", pal = cols, pal_extend = FALSE, case_sense = TRUE)
#' 
#' ## Customize text and grid options:
#' # plot_text(file = "test.txt", col_lbl = "darkblue", cex = 4, family = "sans", fontface = 3,
#' #           pal = "gold1", pal_extend = TRUE, border_col = NA)
#' # plot_text(file = "test.txt", family = "serif", cex = 6, lbl_rotate = TRUE,  
#' #           pal = NA, borders = FALSE)
#' # plot_text(file = "test.txt", col_lbl = "white", pal = c("green3", "black"),
#' #           border_col = "black", border_size = .2)
#' 
#' ## Color ranges:
#' # plot_text(file = "test.txt", pal = c("red2", "orange", "gold"))
#' # plot_text(file = "test.txt", pal = c("olivedrab4", "gold"))
#' 
#' # unlink("test.txt")  # clean up.
#'  
#' \donttest{
#' ## (B) From text file (in subdir):
#' # plot_text(file = "data-raw/txt/hello.txt")  # requires txt file
#' # plot_text(file = "data-raw/txt/ascii.txt", cex = 5, 
#' #           col_bg = "grey", char_bg = "-")
#'          
#' ## (C) From user input:
#' # plot_text()  # (enter text in Console)
#' }
#'
#' @family plot functions
#'
#' @seealso
#' \code{\link{plot_charmap}} for plotting character maps; 
#' \code{\link{plot_chars}} for creating and plotting character maps; 
#' \code{\link{map_text_coord}} for mapping text to a table of character coordinates; 
#' \code{\link{map_text_regex}} for mapping text to a character table and matching patterns; 
#' \code{\link{read_ascii}} for parsing text from file or user input; 
#' \code{\link{pal_ds4psy}} for default color palette. 
#' 
#' @import ggplot2
#' @importFrom grDevices colorRampPalette 
#' @importFrom stats runif
#' 
#' @export 

plot_text <- function(x = NA,     # Text string(s) to plot 
                      file = "",  # "" reads user input from console; "test.txt" reads from file
                      
                      char_bg = " ",  # A character used as background, if char_bg = NA: most frequent char.
                      
                      # text format:
                      lbl_tiles = TRUE, 
                      lbl_rotate = FALSE,  # rotate labels?  
                      cex = 3,             # size of characters
                      fontface = 1,        # font face (1:4)
                      family = "sans",     # font family: 1 of "sans" "serif" "mono"
                      
                      # 2+n colors:
                      col_lbl = "black",   # normal color of text labels (fg)
                      col_bg = "white",    # tile fill color/bg (typically most frequent character)
                      pal = pal_ds4psy[1:5],  # c("steelblue", "skyblue", "lightgrey"), # color palette for filling other bg tiles
                      pal_extend = TRUE,   # extend color pal (to n of different characters in file)
                      case_sense = FALSE,  # distinguish lower and uppercase chars (in counting freq and assigning color)? 
                      
                      # tile borders: 
                      borders = TRUE,        # show tile borders?
                      border_col = "white",  # color of tile border 
                      border_size = 0.5      # width of tile border
){
  
  # (0) Deprecation notice: ----- 
  
  message("plot_text() will be replaced by plot_charmap().\nConsider using plot_charmap() instead...")
  
  # .Deprecated("plot_charmap")
  
  
  ## (-) Default file/path:
  # file <- "test.txt"  # 4debugging
  
  ## (-) Parameters (currently fixed):
  # (a) Text:
  # fontface <- 1
  # family <- "mono"  # 1 of "sans" "serif" "mono"
  # angle <- 0
  # (b) Tile:
  height <- 1
  width  <- 1
  
  
  # (1) Interpret inputs: ------ 
  
  if (!lbl_tiles) {col_lbl <- NA}
  
  # Font family:
  family <- tolower(family)
  if (!family %in% c("sans", "serif", "mono")){
    message("plot_text: Font family should be 'sans' (default), 'serif', or 'mono'.")
    family <- "sans"
  }
  
  # Tile borders:
  if (borders){
    brd_col   <- border_col
    brd_size  <- border_size
  } else {
    brd_col  <- NA  # hide label
    brd_size <- NA  # hide label
  }
  
  
  # (2) Read text input into a text string (txt_ui) and character table (tb_txt): ------ 
  
  if (all(is.na(x))){  # Case 1: Read text from file or user input (Console): 
    
    txt_ui <- read_ascii(file = file, quiet = FALSE)     # 1. read user input (UI)
    tb_txt <- map_text_coord(x = txt_ui, flip_y = TRUE)  # 2. map UI to x/y-table
    
  } else {  # Case 2: Use the character vector provided as x:
    
    tb_txt <- map_text_coord(x = x, flip_y = TRUE)       # 3. map x to x/y-table
    
  } # if (is,na(x)) end.
  
  # tb_txt  # 4debugging
  nr_txt <- nrow(tb_txt)  # (elements/nrows of x/text)
  
  
  # (3) Determine frequency of chars: ------ 
  
  # (A+B) Pass case_sense to char_freq():
  char_freq <- count_chars(tb_txt$char, case_sense = case_sense, rm_specials = FALSE, sort_freq = TRUE)
  nr_unique_chars <- length(char_freq)
  # char_freq  # 4debugging
  # print(nr_unique_chars)  # 4debugging
  
  
  # (C) If char_bg is defined && NOT the most frequent in char_freq: Make it the most frequent character:
  if (!is.na(char_bg) && (names(char_freq)[1] != char_bg)){
    
    # # (a) char_freq as a table:    
    # # Set counter of char_freq$n for char_bg to a maximum value:
    # char_freq$n[char_freq$char == char_bg] <- max(1000, (max(char_freq$n) + 1)) 
    # # Re-arrange according to n:
    # char_freq <- char_freq %>% dplyr::arrange(desc(n))
    
    # (b) char_freq as a named vector:
    ix <- (names(char_freq) == char_bg)  # ix of char_bg in char_freq
    char_freq[ix] <- max(1000, (max(char_freq) + 1))  # some high val
    char_freq <- sort(char_freq, decreasing = TRUE)
    
  }
  # print(char_freq)  # 4debugging
  
  # # (a) char_freq as table:   
  # nr_char_freq <- nrow(char_freq)
  
  # (b) char_freq as named vector:
  nr_char_freq <- sum(char_freq)
  # nr_char_freq  # 4debugging
  
  ## (+) Check:
  # if (nr_char_freq != nr_txt){
  #   message("plot_text: nr_char_freq differs from nr_txt.")
  # } 
  
  
  # (4) Color palette and color map: ------ 
  
  # (A) Define color palette: 
  if (pal_extend){
    
    ## Stretch pal to a color gradient (of char_freq different colors): 
    # pal_ext <- unikn::usecol(pal, n = (nr_unique_chars - 1))  # extended pal (using unikn::usecol)
    pal_ext <- grDevices::colorRampPalette(pal)((nr_unique_chars - 1))  # extended pal (using grDevices)
    
    col_pal <- c(col_bg, pal_ext)
    
  } else {
    
    col_pal <- c(col_bg, pal)  # combine 2 user inputs (as is)
    
  }
  nr_colors <- length(col_pal)
  # print(col_pal)  # 4debugging
  
  
  # (B) Use color palette to create a color map (by frequency of chars in tb_txt):
  col_map <- rep(col_bg, nr_txt)       # initialize color map
  n_replace <- min(nr_colors, nr_unique_chars)  # limit number of replacements 
  # print(n_replace)  # 4debugging
  
  for (i in 1:n_replace){
    
    # # (A) char_freq as table:  
    # cur_char <- char_freq$char[i]  # i-th most freq char
    
    # (B) char_freq as named vector:  
    cur_char <- names(char_freq)[i]  # i-th char
    
    # Determine positions ix in tb_txt$char that correspond to cur_char:
    if (case_sense){  
      ix <- which(tb_txt$char == cur_char)  # case-sensitive match
    } else {
      ix <- which(tolower(tb_txt$char) == cur_char)  # case-insensitive match
    }
    
    # use i-th color in col_pal for ALL col_map positions at [ix]:
    col_map[ix] <- col_pal[i]  
    
  } # loop i.
  # col_map
  
  
  # (5) Rotation/orientation: ------ 
  
  # lbl_rotate <- TRUE  # FALSE (default)
  if (lbl_rotate){
    char_angles <- round(stats::runif(n = nr_txt, min = 0, max = 360), 0)
  } else {
    char_angles <- 0
  }
  
  # (6) Plot (using ggplot2): ------  
  
  cur_plot <- ggplot2::ggplot(data = tb_txt, aes(x = x, y = y)) +
    ggplot2::geom_tile(aes(), fill = col_map, color = brd_col, linewidth = brd_size,  # tiles (with borders, opt.)
                       height = height, width = width) +  
    ggplot2::geom_text(aes(label = char), color = col_lbl, size = cex, 
                       fontface = fontface, family = family, angle = char_angles) + 
    ggplot2::coord_equal() + 
    # theme: 
    theme_empty() # theme_gray() # theme_classic() # cowplot::theme_nothing()
  
  # plot plot: 
  print(cur_plot)
  
  
  # (7) Output: ------ 
  
  # A. Add vectors to tb_txt:
  tb_txt$col_fg <- col_lbl
  tb_txt$col_bg <- col_map 
  tb_txt$angle  <- char_angles
  
  # B. return(char_s)
  return(invisible(tb_txt))
  
} # plot_text(). 


## Check:
# # (A) From text string(s):
# plot_text(x = c("Hello", "world!"))
# plot_text(x = c("Hello world!", "Howdy?"))
# 
# # (B) From user input:
# plot_text()
# 
# # (C) From text file:
# # Create a temporary file "test.txt":
# cat("Hello world!", "This is a test file.",
#     "Can you see this text?",
#     "Good! Please carry on...",
#     file = "test.txt", sep = "\n")
# 
# plot_text(file = "test.txt")
# 
# # Set colors, pal_extend, and case_sense:
# cols <- c("firebrick", "olivedrab", "steelblue", "orange", "gold")
# plot_text(file = "test.txt", pal = cols, pal_extend = TRUE)
# plot_text(file = "test.txt", pal = cols, pal_extend = FALSE)
# plot_text(file = "test.txt", pal = cols, pal_extend = FALSE, case_sense = TRUE)
# 
# # Customize text and grid options:
# plot_text(file = "test.txt", col_lbl = "white", borders = FALSE)
# plot_text(file = "test.txt", col_lbl = "firebrick", cex = 4, fontface = 3,
#           pal = "grey90", pal_extend = TRUE, border_col = NA)
# plot_text(file = "test.txt", col_lbl = "white", pal = c("green4", "black"),
#           border_col = "black", border_size = .2)
# 
# # Color ranges:
# plot_text("test.txt", pal = c("red2", "orange", "gold"))
# plot_text("test.txt", pal = c("olivedrab4", "gold"))
# 
# # Note: plot_text() invisibly returns a description of the plot (as df):
# tb <- plot_text(file = "test.txt", lbl_rotate = TRUE)
# head(tb)
# 
# unlink("test.txt")  # clean up (by deleting file).
# 
# \donttest{
# # (B) From text file (from subdir):
# plot_text("data-raw/txt/hello.txt")  # requires txt file
# plot_text(file = "data-raw/txt/ascii.txt", cex = 5,
#           col_bg = "lightgrey", border_col = "white")
# 
# # (C) From user input:
# plot_text()  # (enter text in Console)
# 
# }


## plot_charmap: Plot a table of characters (with x- and y-coodinates): -------- 

# Note: This was the ggplot2 part of plot_chars() (below).

#' Plot a character map as a tile plot with text labels 
#'
#' \code{plot_charmap} plots a character map and some aesthetics 
#' as a tile plot with text labels (using \strong{ggplot2}).
#' 
#' \code{plot_charmap} is based on \code{\link{plot_chars}}. 
#' As it only contains the plotting-related parts, 
#' it assumes a character map generated by 
#' \code{\link{map_text_regex}} as input. 
#' 
#' The plot generated by \code{plot_charmap} is character-based: 
#' Individual characters are plotted at equidistant x-y-positions 
#' and aesthetic variables are used for text labels and tile fill colors.
#' 
#' @return A plot generated by \strong{ggplot2}.
#' 
#' @param x A character map, as generated by 
#' \code{\link{map_text_coord}} or 
#' \code{\link{map_text_regex}} (as df). 
#' Alternatively, some text to map or plot (as a character vector). 
#' Different elements denote different lines of text. 
#' If \code{x = NA} (as per default), 
#' the \code{file} argument is used to read 
#' a text file or user input from the Console. 
#' 
#' @param file A text file to read (or its path). 
#' If \code{file = ""} (as per default), 
#' \code{scan} is used to read user input from the Console. 
#' If a text file is stored in a sub-directory, 
#' enter its path and name here (without any leading or 
#' trailing "." or "/"). 
#' 
#' @param lbl_tiles Add character labels to tiles? 
#' Default: \code{lbl_tiles = TRUE} (i.e., show labels). 
#' 
#' @param col_lbl Default color of text labels 
#' (unless specified as a column \code{col_fg} of \code{x}).
#' Default: \code{col_lbl = "black"}.
#' 
#' @param angle Default angle of text labels 
#' (unless specified as a column of \code{x}).  
#' Default: \code{angle = 0}. 
#' 
#' @param cex Character size (numeric). 
#' Default: \code{cex = 3}. 
#' 
#' @param fontface Font face of text labels (numeric). 
#' Default: \code{fontface = 1}, (from 1 to 4).
#' 
#' @param family Font family of text labels (name).
#' Default: \code{family = "sans"}. 
#' Alternative options: "sans", "serif", or "mono".
#' 
#' @param col_bg Default color to fill background tiles 
#' (unless specified as a column \code{col_bg} of \code{x}).
#' Default: \code{col_bg = "grey80"}. 
#' 
#' @param borders Boolean: Add borders to tiles? 
#' Default: \code{borders = FALSE} (i.e., no borders).
#' 
#' @param border_col Color of tile borders. 
#' Default: \code{border_col = "white"}.  
#' 
#' @param border_size Size of tile borders. 
#' Default: \code{border_size = 0.5}.
#' 
#' @examples
#' # (0) Prepare: 
#' ts <- c("Hello world!", "This is a test to test this splendid function", 
#'         "Does this work?", "That's good.", "Please carry on.")
#' sum(nchar(ts))  
#' 
#' # (1) From character map:
#' # (a) simple: 
#' cm_1 <- map_text_coord(x = ts, flip_y = TRUE)
#' plot_charmap(cm_1)
#' 
#' # (b) pattern matching (regex): 
#' cm_2 <- map_text_regex(ts, lbl_hi = "\\b\\w{4}\\b", bg_hi = "[good|test]", 
#'                        lbl_rotate = "[^aeiou]", angle_fg = c(-45, +45))
#' plot_charmap(cm_2)                      
#' 
#' # (2) Alternative inputs:     
#' # (a) From text string(s):
#' plot_charmap(ts)
#'
#' # (b) From user input:
#' # plot_charmap()  # (enter text in Console)
#'  
#' # (c) From text file:
#' # cat("Hello world!", "This is a test file.",
#' #      "Can you see this text?",
#' #      "Good! Please carry on...",
#' #      file = "test.txt", sep = "\n")
#' 
#' # plot_charmap(file = "test.txt")
#' 
#' # unlink("test.txt")  # clean up (by deleting file). 
#'
#' @family plot functions
#'
#' @seealso
#' \code{\link{plot_chars}} for creating and plotting character maps; 
#' \code{\link{plot_text}} for plotting characters and color tiles by frequency; 
#' \code{\link{map_text_regex}} for mapping text to a character table and matching patterns; 
#' \code{\link{map_text_coord}} for mapping text to a table of character coordinates; 
#' \code{\link{read_ascii}} for reading text inputs into a character string; 
#' \code{\link{pal_ds4psy}} for default color palette. 
#' 
#' @import ggplot2
#' @importFrom grDevices colorRampPalette 
#' @importFrom stats runif
#' 
#' @export 

plot_charmap <- function(x = NA,     # what to plot (required): charmap OR {text/file/user input}.
                         file = "",  # text file, considered iff x = NA.
                         
                         # labels:
                         lbl_tiles = TRUE,  # show labels (using col_lbl_? below)
                         col_lbl = "black", 
                         angle = 0, 
                         cex = 3,           # character size
                         fontface = 1,      # font face (1:4)
                         family = "sans",   # font family: 1 of "sans" "serif" "mono"
                         
                         # tiles:
                         col_bg = "grey80", 
                         borders = FALSE,       # show tile borders?
                         border_col = "white",  # color of tile border 
                         border_size = 0.5      # width of tile border
){
  
  # (0) Initialize: ----
  
  tb <- NA
  
  # (1) Inputs: ----
  
  if (is.data.frame(x)){
    
    # ToDo: Ensure that columns {char, x, y} are present.  
    
    tb <- x 
    
  } else {
    
    message("plot_charmap: No character map provided. Mapping text from x or file...")
    
    tb <- map_text_or_file(x = x, file = file, flip_y = TRUE)  # use text helper function
    
  }
  
  
  # (2) Parameters: ---- 
  
  # (a) minimal required inputs (from tb):
  label <- tb$char
  x <- tb$x
  y <- tb$y
  
  tb_vars <- names(tb)  # names of tb columns
  
  # (b) Label aesthetics:
  if ("col_fg" %in% tb_vars) { col_lbl <- tb$col_fg } 
  
  if (!lbl_tiles){ col_lbl <- NA }  # hide text labels
  
  if ("angle" %in% tb_vars) { angle <- tb$angle }
  
  # (c) Tile aesthetics:
  if ("col_bg" %in% tb_vars) { col_bg <- tb$col_bg } 
  
  if (!borders){  # hide tile borders:
    border_col  <- NA
    border_size <- NA
  }
  
  # (d) Constants: 
  height <- 1
  width  <- 1
  
  # (e) Coordinates:
  ratio <- 1/1   #  ratio of height/width (y/x). Default: ratio <- 1/1 
  xlim  <- NULL  # range of x-coordinates. Default x_lim <- NULL
  ylim  <- NULL  # range of y-coordinates. Default y_lim <- NULL
  
  
  # (3) Plot tb (using ggplot2): ---- 
  
  cur_plot <- ggplot2::ggplot(data = tb, aes(x = x, y = y)) +
    ggplot2::geom_tile(aes(), fill = col_bg, color = border_col, linewidth = border_size,
                       height = height, width = width) +  
    ggplot2::geom_text(aes(label = label), color = col_lbl, size = cex, angle = angle, 
                       fontface = fontface, family = family) + 
    ggplot2::coord_fixed(ratio = ratio, xlim = xlim, ylim = ylim, expand = TRUE, clip = "on") + 
    # theme: 
    theme_empty() # theme_gray() # theme_classic() # cowplot::theme_nothing()
  
  ## plot plot: 
  # print(cur_plot)
  
  
  # (4) Return:
  return(cur_plot)  # jnd: plot_chars() returns character map/description!
  
} # plot_charmap(). 

## Check:
# # (1) Plot an existing charmap: 
# # (a) simple:
# s <- c("ene mene miste", "es rappelt", "in der kiste")
# cm_1 <- map_text_coord(s)
# plot_charmap(cm_1)
# 
# # (b) matching patterns (regex):
# ts <- c("Hello world!", "This is a test to test this splendid function",
#         "Does this work?", "That's good.", "Please carry on.")
# sum(nchar(ts))
# cm_2 <- map_text_regex(ts, lbl_hi = "\\b\\w{4}\\b", bg_hi = "[good|test]",
#                        lbl_rotate = "[^aeiou]", angle_fg = c(-45, +45))
# plot_charmap(cm_2)
# 
# # (2) Alternative inputs: 
# # (a) From text string(s):
# plot_charmap(ts)
#
# # (b) From file:
# cat("Hello world!", "This is a test file.",
#     "Can you see this text?",
#     "Good! Please carry on...",
#     file = "test.txt", sep = "\n")
# plot_charmap(file = "test.txt")
# unlink("test.txt")  # clean up (by deleting file).
#
# # (c) From user input:
# plot_charmap()


## plot_chars: Alternative to plot_text (with regex functionality): -------- 

#' Plot text characters (from file or user input) and match patterns 
#'
#' \code{plot_chars} parses text (from a file or user input) 
#' into a table and then plots its individual characters 
#' as a tile plot (using \strong{ggplot2}).
#' 
#' \code{plot_chars} blurs the boundary between a text 
#' and its graphical representation by combining options 
#' for matching patterns of text with visual features 
#' for displaying characters (e.g., their color or orientation). 
#' 
#' @details 
#' \code{plot_chars} is based on \code{\link{plot_text}}, 
#' but provides additional support for detecting and displaying characters 
#' (i.e., text labels, their orientation, and color options) 
#' based on matching regular expression (regex). 
#' 
#' Internally, \code{plot_chars} is a wrapper that calls 
#' (1) \code{\link{map_text_regex}} for creating a character map 
#' (allowing for matching patterns for some aesthetics) and 
#' (2) \code{\link{plot_charmap}} for plotting this character map. 
#' 
#' However, in contrast to \code{\link{plot_charmap}}, 
#' \code{plot_chars} invisibly returns a 
#' description of the plot (as a data frame). 
#' 
#' The plot generated by \code{plot_chars} is character-based: 
#' Individual characters are plotted at equidistant x-y-positions 
#' and the aesthetic settings provided for text labels and tile fill colors. 
#' 
#' Five regular expressions and corresponding 
#' color and angle arguments allow identifying, 
#' marking (highlighting or de-emphasizing), and rotating 
#' those sets of characters (i.e, their text labels or fill colors).
#' that match the provided patterns. 
#' 
#' @return An invisible data frame describing the plot.
#' 
#' @param x The text to plot (as a character vector). 
#' Different elements denote different lines of text. 
#' If \code{x = NA} (as per default), 
#' the \code{file} argument is used to read 
#' a text file or user input from the Console. 
#' 
#' @param file A text file to read (or its path). 
#' If \code{file = ""} (as per default), 
#' \code{scan} is used to read user input from the Console. 
#' If a text file is stored in a sub-directory, 
#' enter its path and name here (without any leading or 
#' trailing "." or "/"). 
#' 
#' @param lbl_hi Labels to highlight (as regex). 
#' Default: \code{lbl_hi = NA}. 
#' 
#' @param lbl_lo Labels to de-emphasize (as regex). 
#' Default: \code{lbl_lo = NA}. 
#' 
#' @param bg_hi Background tiles to highlight (as regex). 
#' Default: \code{bg_hi = NA}. 
#' 
#' @param bg_lo Background tiles to de-emphasize (as regex). 
#' Default: \code{bg_lo = "[[:space:]]"}.
#' 
#' @param lbl_rotate Labels to rotate (as regex). 
#' Default: \code{lbl_rotate = NA}. 
#' 
#' @param case_sense Boolean: Distinguish 
#' lower- vs. uppercase characters in pattern matches? 
#' Default: \code{case_sense = TRUE}. 
#' 
#' 
#' @param lbl_tiles Add character labels to tiles? 
#' Default: \code{lbl_tiles = TRUE} (i.e., show labels). 
#' 
#' @param angle_fg Angle(s) for rotating character labels 
#' matching the pattern of the \code{lbl_rotate} expression. 
#' Default: \code{angle_fg = c(-90, 90)}. 
#' If \code{length(angle_fg) > 1}, a random value 
#' in uniform \code{range(angle_fg)} is used for every character. 
#' 
#' @param angle_bg Angle(s) of rotating character labels 
#' not matching the pattern of the \code{lbl_rotate} expression. 
#' Default: \code{angle_bg = 0} (i.e., no rotation). 
#' If \code{length(angle_bg) > 1}, a random value 
#' in uniform \code{range(angle_bg)} is used for every character. 
#' 
#' 
#' @param col_lbl Default color of text labels.
#' Default: \code{col_lbl = "black"}. 
#' 
#' @param col_lbl_hi Highlighting color of text labels.
#' Default: \code{col_lbl_hi = pal_ds4psy[[1]]}. 
#' 
#' @param col_lbl_lo De-emphasizing color of text labels.
#' Default: \code{col_lbl_lo = pal_ds4psy[[9]]}.
#' 
#' @param col_bg Default color to fill background tiles.
#' Default: \code{col_bg = pal_ds4psy[[7]]}. 
#' 
#' @param col_bg_hi Highlighting color to fill background tiles.
#' Default: \code{col_bg_hi = pal_ds4psy[[4]]}. 
#' 
#' @param col_bg_lo De-emphasizing color to fill background tiles.
#' Default: \code{col_bg_lo = "white"}.
#' 
#' 
#' @param col_sample Boolean: Sample color vectors (within category)?
#' Default: \code{col_sample = FALSE}.
#' 
#' @param rseed Random seed (number).  
#' Default: \code{rseed = NA} (using random seed).
#' 
#' 
#' @param cex Character size (numeric). 
#' Default: \code{cex = 3}. 
#' 
#' @param fontface Font face of text labels (numeric). 
#' Default: \code{fontface = 1}, (from 1 to 4).
#' 
#' @param family Font family of text labels (name).
#' Default: \code{family = "sans"}. 
#' Alternative options: "sans", "serif", or "mono".
#' 
#' 
#' @param borders Boolean: Add borders to tiles? 
#' Default: \code{borders = FALSE} (i.e., no borders).
#' 
#' @param border_col Color of tile borders. 
#' Default: \code{border_col = "white"}.  
#' 
#' @param border_size Size of tile borders. 
#' Default: \code{border_size = 0.5}.
#' 
#' @examples 
#' # (A) From text string(s):
#' plot_chars(x = c("Hello world!", "Does this work?", 
#'                  "That's good.", "Please carry on..."))
#'
#' # (B) From user input:
#' # plot_chars()  # (enter text in Console)
#' 
#' # (C) From text file:
#' # Create and use a text file: 
#' # cat("Hello world!", "This is a test file.", 
#' #     "Can you see this text?", 
#' #     "Good! Please carry on...", 
#' #     file = "test.txt", sep = "\n")
#' 
#' # plot_chars(file = "test.txt")  # default
#' # plot_chars(file = "test.txt", lbl_hi = "[[:upper:]]", lbl_lo = "[[:punct:]]", 
#' #            col_lbl_hi = "red", col_lbl_lo = "blue")
#'  
#' # plot_chars(file = "test.txt", lbl_hi = "[aeiou]", col_lbl_hi = "red", 
#' #            col_bg = "white", bg_hi = "see")  # mark vowels and "see" (in bg)
#' # plot_chars(file = "test.txt", bg_hi = "[aeiou]", col_bg_hi = "gold")  # mark (bg of) vowels
#' 
#' ## Label options:
#' # plot_chars(file = "test.txt", bg_hi = "see", lbl_tiles = FALSE)
#' # plot_chars(file = "test.txt", cex = 5, family = "mono", fontface = 4, lbl_angle = c(-20, 20))
#' 
#' ## Note: plot_chars() invisibly returns a description of the plot (as df):
#' # tb <- plot_chars(file = "test.txt", lbl_hi = "[aeiou]", lbl_rotate = TRUE)
#' # head(tb)
#' 
#' # unlink("test.txt")  # clean up (by deleting file).
#' 
#' \donttest{
#' ## (B) From text file (in subdir):
#' # plot_chars(file = "data-raw/txt/hello.txt")  # requires txt file
#' # plot_chars(file = "data-raw/txt/ascii.txt", lbl_hi = "[2468]", bg_lo = "[[:digit:]]", 
#' #            col_lbl_hi = "red", cex = 10, fontface = 2)
#'            
#' ## (C) User input:
#' # plot_chars()  # (enter text in Console)
#' }
#'
#' @family plot functions
#'
#' @seealso
#' \code{\link{plot_charmap}} for plotting character maps; 
#' \code{\link{plot_text}} for plotting characters and color tiles by frequency; 
#' \code{\link{map_text_coord}} for mapping text to a table of character coordinates; 
#' \code{\link{map_text_regex}} for mapping text to a character table and matching patterns; 
#' \code{\link{read_ascii}} for reading text inputs into a character string; 
#' \code{\link{pal_ds4psy}} for default color palette. 
#' 
#' @import ggplot2
#' @importFrom grDevices colorRampPalette 
#' @importFrom stats runif
#' 
#' @export 

plot_chars <- function(x = NA,     # Text string(s) to plot; iff is.na(x):  
                       file = "",  # "" reads user input from console; "test.txt" reads from file
                       
                       # 5 regex patterns (to emphasize and de-emphasize matching characters in text string): 
                       lbl_hi = NA, # "asdf",   # [[:upper:]]",   # labels to highlight (as regex)
                       lbl_lo = NA, # "qwer",   # [[:punct:]]",   # labels to de-emphasize (as regex)
                       bg_hi  = NA, # "zxcv",   # background tiles to highlight (as regex)
                       bg_lo  = "[[:space:]]",  # background tiles to de-emphasize (as regex)
                       lbl_rotate = NA,         # "[^[:space:]]",  # pattern for labels to rotate (as regex)
                       case_sense = TRUE,       # distinguish lower/uppercase (in pattern matching)?
                       
                       # labels (text):
                       lbl_tiles = TRUE,  # show labels (using col_lbl_? below)
                       # lbl_angle = 0,   # angle of rotation (0 := no rotation) 
                       angle_fg = c(-90, 90),  # angle(s) of labels matching the lbl_rotate pattern
                       angle_bg = 0,           # default angle(s) & labels NOT matching the lbl_rotate pattern
                       
                       # 6 colors (of labels and tiles): 
                       col_lbl = "black",             # default text label color
                       col_lbl_hi = pal_ds4psy[[1]],  # highlighted labels (matching lbl_hi)
                       col_lbl_lo = pal_ds4psy[[9]],  # de-emphasized labels (matching lbl_lo)
                       col_bg = pal_ds4psy[[7]],      # default tile fill color
                       col_bg_hi = pal_ds4psy[[4]],   # highlighted tiles (matching bg_hi)
                       col_bg_lo = "white",           # de-emphasized tiles (matching bg_lo)
                       col_sample = FALSE,            # sample from color vectors (within category)?
                       rseed = NA,                    # reproducible randomness for sample()
                       
                       # Args only relevant for plot_charmap():  
                       
                       # fonts:
                       cex = 3,           # character size
                       fontface = 1,      # font face (1:4)
                       family = "sans",   # font family: 1 of "sans" "serif" "mono"
                       
                       # borders (of tiles): 
                       borders = FALSE,       # show tile borders?
                       border_col = "white",  # color of tile border 
                       border_size = 0.5      # width of tile border
){
  
  # (0) Deprecation notice: ----- 
  
  # Note jnd: plot_chars() invisibly returns cmap, whereas plot_charmap() returns a plot!
  
  # message("plot_chars() only combines map_text_regex() and plot_charmap().\nFor more control, consider using these functions instead...")
  # .Deprecated(new = "plot_charmap")
  
  # (1) Create character map (with regex): ------ 
  
  cmap <- map_text_regex(x = x, file = file,     # input x or file?
                         lbl_hi = lbl_hi, lbl_lo = lbl_lo,  # regex stuff: 
                         bg_hi = bg_hi, bg_lo = bg_lo, 
                         lbl_rotate = lbl_rotate, 
                         case_sense = case_sense,
                         
                         lbl_tiles = lbl_tiles,  # labels 
                         angle_fg = angle_fg, angle_bg = angle_bg,  # angles
                         
                         col_lbl = col_lbl,      # colors: 
                         col_lbl_hi = col_lbl_hi, col_lbl_lo = col_lbl_lo,
                         col_bg = col_bg, 
                         col_bg_hi = col_bg_hi, col_bg_lo = col_bg_lo,
                         col_sample = col_sample, rseed = rseed
  )
  
  
  # (2) Plot character map: ------  
  
  p <- plot_charmap(x = cmap, # input
                    cex = cex, fontface = fontface, family = family,  # labels/fonts
                    borders = borders, border_col = border_col, border_size = border_size  # borders
  )
  
  print(p)  # plot plot
  
  
  # (3) Output: ------
  
  return(invisible(cmap))  # jnd: plot_charmap() returns a plot!
  
} # plot_chars().

## Check:
# # (A) From text string(s):
# plot_chars("Hello world!")  # (A) Using x (text input)
# 
# # (B) From user input:
# plot_chars()  # # (enter text in Console)
# 
# (C) From text file:
# Create a temporary file "test.txt":
# cat("Hello world!", "This is a test file.",
#     "Can you see this text?",
#     "Good! Please carry on...",
#      file = "test.txt", sep = "\n")
# 
# # (a) Plot & mark text from file:
# plot_chars(file = "test.txt")  # default
# plot_chars(file = "test.txt", lbl_hi = "[[:upper:]]", lbl_lo = "[[:punct:]]", col_lbl_hi = "red", col_lbl_lo = "cyan")
# plot_chars(file = "test.txt", lbl_hi = "\\b\\w{4}\\b", col_lbl_hi = "red", col_bg = "white", bg_hi = "see")  # mark fg of four-letter words
# plot_chars(file = "test.txt", lbl_hi = "[aeiou]", col_lbl_hi = "red", col_bg = "white", bg_hi = "test")  # mark vowels and "see"
# plot_chars(file = "test.txt", bg_hi = "\\b\\w{4}\\b", col_bg_hi = "gold")  # mark bg of 4-letter words
# plot_chars(file = "test.txt", bg_hi = "[aeiou]", col_bg_hi = "gold")  # mark vowels (in bg)
# 
# # Case sensitivity:
# plot_chars(file = "test.txt", lbl_hi = "[tc]", bg_hi = "[gh]", case_sense = TRUE, cex = 5)
# plot_chars(file = "test.txt", lbl_hi = "[tc]", bg_hi = "[gh]", case_sense = FALSE, cex = 5)
# 
# # Label options:
# plot_chars(file = "test.txt", bg_hi = "see", lbl_tiles = FALSE, borders = TRUE)  # hide labels
# plot_chars(file = "test.txt", cex = 5, family = "mono", fontface = 2,
#            lbl_rotate = "[^[:space:]]", angle_fg = c(-45, 45))  # rotate labels
# plot_chars(file = "test.txt", cex = 5, family = "mono", fontface = 2,
#            lbl_rotate = "test|text", angle_fg = c(0, 360))
# plot_chars(file = "test.txt", cex = 5, family = "mono", fontface = 2,
#            lbl_rotate = "test|text", angle_fg = 0, angle_bg = "180")
# 
# # Multiple colors:
# plot_chars(file = "test.txt", lbl_hi = "[aeiou]", bg_hi = "te.t",
#            col_lbl = c("grey99", "grey85"),
#            col_bg = c("grey10", "grey15", "grey20"),
#            col_bg_hi = pal_ds4psy[1:3], col_bg_lo = "grey80",
#            col_lbl_hi = c("gold1", "gold2"),
#            col_sample = FALSE, cex = 5, fontface = 2)
# 
# # Sampling colors (within each category only):
# plot_chars(file = "test.txt", 
#            lbl_hi = "\\.", bg_hi = "\\.",
#            col_lbl = c("white"), col_bg = usecol(c("black", pal_grau[[5]]), n = 5),
#            col_bg_hi = c(Pinky),  col_bg_lo = usecol(c("white", pal_grau[[4]]), n = 10),
#            col_lbl_hi = c(Pinky),
#            col_sample = TRUE, cex = 4, fontface = 2, 
#            borders = TRUE, border_size = 1/3)
# 
# # Highlight labels and tiles of same matches:
# plot_chars(file = "test.txt", lbl_hi = "te.t", bg_hi = "te.t",
#            col_bg = "white", col_bg_hi = "gold", col_lbl_hi = "red",
#            borders = TRUE, border_col = "black")
# 
# plot_chars(file = "test.txt",
#            lbl_hi = "te.t", bg_hi = "te.t", lbl_rotate = ".his",
#            col_bg_hi = "gold", col_lbl_hi = "red3",
#            cex = 6, family = "mono", fontface = 2,
#            borders = TRUE, border_col = "black", border_size = .2)
# 
# # Note: plot_chars() invisibly returns a description of the plot (as df):
# tb <- plot_chars(file = "test.txt", lbl_hi = "[aeiou]", lbl_rotate = "[hlwypt?!]",
#                  case_sense = FALSE, angle_fg = 90, cex = 4)
# head(tb)
# 
# unlink("test.txt")  # clean up (by deleting file).

## Note: External file "_gitless/check_plot_fun.Rmd" contains more checks and examples. 




## plot_circ_points: Plot objects arranged on a circle: -------- 

# Task: Arrange objects (shaped as pch of points) on a circle.


#' Plot objects (as points) arranged on a circle 
#' 
#' \code{plot_circ_points} arranges a number of \code{n} 
#' on a circle (defined by its origin coordinates and radius).
#' 
#' The \code{...} is passed to \code{\link{points}} of 
#' the \strong{graphics} package. 
#' 
#' @param n The number of points (or shapes defined by \code{pch}) to plot.
#' @param x_org The x-value of circle origin.
#' @param y_org The y-value of circle origin.
#' @param radius The circle radius.
#' @param show_axes Show axes? Default: \code{show_axes = FALSE}. 
#' @param show_label Show a point label? Default: \code{show_label = FALSE}.
#'  
#' @param ... Additional aesthetics (passed to \code{\link{points}} of \strong{graphics}).
#' 
#' @examples 
#' plot_circ_points(8)  # default
#' 
#' # with aesthetics of points():
#' plot_circ_points(n =  8, r = 10, cex = 8, 
#'                  pch = sample(21:25, size = 8, replace = TRUE), bg = "deeppink")
#' plot_circ_points(n = 12, r = 8, show_axes = TRUE, show_label = TRUE,
#'                  cex = 6, pch = 21, lwd = 5, col = "deepskyblue", bg = "gold")
#' 
#' @family plot functions 
#' 
#' @importFrom graphics par points text 
#' 
#' @export

plot_circ_points <- function(n = 4, 
                             x_org = 0, y_org = 0, radius = 1, 
                             show_axes = FALSE, show_label = FALSE, 
                             ...  # additional aesthetics (passed to points())
){
  
  # Circle parameters:
  c <- c(x_org, y_org)  # coordindats of center/origin
  r <- radius           # radius of circle
  
  # Colors:
  # col_fill <- colorRampPalette(c("deepskyblue", "gold"))(n)  # a gradient of n colors
  
  # Compute coordinates: 
  
  # Compute angle (in degrees):
  # angle <- 360/n * 0:(n - 1)  # n points (starting at 0)
  # angle <- 360/n * 0:n        # n + 1 points  
  angle <- 360/n * 1:n        # n points (starting at 1)
  # print(angle)  # 4debugging 
  
  # Convert angle from degrees to radians:
  theta <- deg2rad(angle)
  
  x <- c[1] + r * sin(theta)
  # print(x)  # 4debugging 
  
  y <- c[2] + r * cos(theta) 
  # print(y)  # 4debugging 
  
  # As df:
  df <- data.frame(# ix = 1:n,  # point index/row number
    angle = angle,
    theta = theta, 
    x = x, 
    y = y)
  # Note: Circle center c and radius r not saved in df. 
  
  # Plot: ---- 
  
  # Prepare canvass:
  
  # Plot settings:
  opar <- par(no.readonly = TRUE)  # all par settings that can be changed.
  on.exit(par(opar))  # par(opar)  # restore original settings
  
  par(mar = c(2, 2, 2, 2) + 0.1)  # margins; default: par("mar") = 5.1 4.1 4.1 2.1.
  par(oma = c(0, 0, 0, 0) + 0.1)  # outer margins; default: par("oma") = 0 0 0 0.
  
  x_size <- 1.2 * r
  y_size <- 1.2 * r   
  
  
  # Draw canvass:
  if (show_axes){
    
    plot(x = c[1], type = "n", 
         axes = TRUE, xlab = NA, ylab = NA, 
         xlim = c[1] + c(-x_size, +x_size), ylim = c[2] + c(-y_size, +y_size))
    
  } else { # no axes:
    
    plot(x = c[1], type = "n", 
         axes = FALSE, xlab = NA, ylab = NA, 
         xlim = c[1] + c(-x_size, +x_size), ylim = c[2] + c(-y_size, +y_size))
    
  }
  
  
  # Add help lines:
  # grid()
  # plot(c[1], c[2], pch = 3)  # mark center/origin
  
  # Mark a circle around center (as a big point):
  # points(c[1], c[2], cex = 30, pch = 21, lwd = 1, col = "firebrick")
  
  # grid::grid.circle(c[1], c[2], r)
  
  # Draw points: 
  graphics::points(df$x, df$y, ...)
  # pch = 21, cex = 4, bg = col_fill)
  
  if (show_label){ # add text labels:
    
    # p_lbl <- as.character(round(df$angle, 1))  # angle (in degrees)
    p_lbl <- as.character(1:length(df$angle))    # nr
    
    graphics::text(df$x, df$y, label = p_lbl, cex = .85)
    
  }
  
  # Return df (invisibly):
  
  # on.exit(par(opar))  # par(opar)  # restore original settings
  invisible(df) # restores par(opar)
  
} # plot_circ_points(). 

# # Check:
# plot_circ_points()
# plot_circ_points(1, pch = 16, show_axes = TRUE)
# plot_circ_points(n = 36, pch = 22, cex = 3, show_label = TRUE)
# plot_circ_points(n = 12, pch = 21, cex = 4, lwd = 2, col = "blue", bg = "gold")
#
# # Add aesthetics (color gradients):
# col_fill <- colorRampPalette(c("deepskyblue", "gold"))(12)  # a gradient of n colors
# df <- plot_circ_points(n = 12, pch = 21, cex = 5, col = NA, bg = col_fill)
# 
# # Color ring:
# col_fill <- unikn::usecol(c("gold", "deepskyblue", "deeppink", "gold"), n = 500, alpha = .33)  # a gradient of n colors
# df <- plot_circ_points(n = 500, pch = 21, cex = 5, col = NA, bg = col_fill, show_axes = FALSE)


# +++ here now +++ :


# ToDo: Convert into an exercise:
# - Omit the conversion from degrees to radians:   
#   theta <- deg2rad(angle)




## Arrange points within a circle (using sunflower arrangement):

# # From 
# # [Stackoverflow: Uniformly distribute x points inside a circle](https://stackoverflow.com/questions/28567166/uniformly-distribute-x-points-inside-a-circle)
# # Answer by user [alex_jwb90](https://stackoverflow.com/users/1335174/alex-jwb90)
# 
# library(tibble)
# library(dplyr)
# library(ggplot2)
# library(unikn)
# 
# radius <- function(k, n, b) {
#   
#   ifelse(k > n - b, 1, sqrt(k - 1/2)/sqrt(n - (b + 1)/2))
#   
# }
# 
# plot_sunflower <- function(n, alpha = 2, geometry = c("planar", "geodesic")) {
#   
#   b <- round(alpha*sqrt(n))  # number of boundary points
#   phi <- (sqrt(5) + 1)/2     # golden ratio
#   
#   r <- radius(1:n, n, b)
#   
#   theta <- 1:n * ifelse(geometry[1] == "geodesic", 360 * phi, 2 * pi/phi^2)
#   
#   tibble(x = r * cos(theta),
#          y = r * sin(theta))
#   
# }
# 
# # example:
# n_points <- 750
# 
# plot_sunflower(n_points, 2, "planar") %>%
#   ggplot(aes(x, y)) +
#   geom_point(col = usecol(c(Pinky, pal_seeblau, "gold"), n = n_points, alpha = 2/3), size = 5) + 
#   coord_equal() + 
#   theme_void()
# 
# # Color:
# # seecol(pal_karpfenblau)


## Done: ----------

# - Clean up legacy code and moved some checks to external file "check_plot_fun.Rmd". 

# - Replaced old plot_chars() by a function that only calls the 2 more specialized functions:
#   1. map_text_regex() maps text to x/y-coords with optional regex columns => df
#   2. plot_charmap() reads/creates/uses a charmap (df) to plot it.

# - Added plot_chars() for more control over regex matches and colors
# - Revised plot_text() to invisibly return plot description (as df)
# - Added theme_empty() to remove need for: #' @importFrom cowplot theme_nothing 


## ToDo: ----------

# - Visualize char or word frequency: 
#   1. Use count_chars_words() to create color vectors (fg/bg) based on char_ or word_freq. [done]
#   2. Map freq counts to color palette (using either interval scale with bins or ordinal scale with ranks)
#   3. Use plot_charmap() or plot_text() to plot char or word frequency.

# - Revise plot_text() to use count_chars_words() and 
#   allow coloring by character or word frequency.

# - Consider adding plot_tbar() and plot_tclock() 
#   (to plot toc, see file images/art.Rmd).

## eof. ----------------------