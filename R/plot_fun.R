## plot_fun.R | ds4psy
## hn | uni.kn | 2021 04 16
## ---------------------------

## Functions for plotting. 

## Global variables: ---------- 

utils::globalVariables(c("x", "y", "char"))  # to avoid Warning NOTE "Undefined global functions or variables". 

# Source: 
# <https://community.rstudio.com/t/how-to-solve-no-visible-binding-for-global-variable-note/28887> 

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
  
} # plot_tiles.

# ## Check:
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

#' Another function to plot some plot.
#'
#' \code{plot_fun} is a function that provides options for plotting a plot. 
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
#' @param a A (natural) number. 
#' Default: \code{a = NA}. 
#' 
#' @param b Boolean. 
#' Default: \code{b = TRUE}. 
#' 
#' @param c Boolean. 
#' Default: \code{c = TRUE}. 
#' 
#' @param d A (decimal) number. 
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
#' @param c1 A color palette (e.g., as a vector). 
#' Default: \code{c1 = c(rev(pal_seeblau), "white", pal_grau, "black", Bordeaux)}. 
#' Note: Using colors of the \code{unikn} package by default. 
#'
#' @param c2 A color (e.g., as a character). 
#' Default: \code{c2 = "black"}. 
#'
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
  
} # plot_fun. 

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

#' Plot n tiles. 
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
  
} # plot_n.

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

#' A function to plot a plot.
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
#' @param x A (natural) number. 
#' Default: \code{x = NA}. 
#' 
#' @param y A (decimal) number. 
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
#' @param f A color palette (e.g., as a vector). 
#' Default: \code{f = c(rev(pal_seeblau), "white", pal_pinky)}. 
#' Note: Using colors of the \code{unikn} package by default. 
#'
#' @param g A color (e.g., as a character). 
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
#' \code{\link{pal_ds4psy}} for color palette. 
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
  
} # plot_fn. 




## plot_text: Plot text characters as a tile plot: -------- 

#' Plot text characters (from file or user input).
#'
#' \code{plot_text} parses text 
#' (from a file or from user input in Console) 
#' into a table and then plots its individual characters 
#' as a tile plot (using \strong{ggplot2}).
#' 
#' @param file The text file to read (or its path). 
#' If \code{file = ""} (the default), \code{scan} is used 
#' to read user input from the Console. 
#' If a text file is stored in a sub-directory, 
#' enter its path and name here (without any leading or 
#' trailing "." or "/"). 
#' Default: \code{file = ""}. 
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
#' @param case_sense Boolean: Should lower- and 
#' uppercase characters be distinguished 
#' (in applying color \code{pal})? 
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
#' ## Create a temporary file "test.txt":
#' # cat("Hello world!", "This is a test.", 
#' #     "Can you see this text?", 
#' #     "Good! Please carry on...", 
#' #     file = "test.txt", sep = "\n")
#' 
#' ## (a) Plot text (from file): 
#' # plot_text("test.txt")
#' 
#' ## Set colors, pal_extend, and case_sense:
#' # cols <- c("steelblue", "skyblue", "lightgrey")
#' # cols <- c("firebrick", "olivedrab", "steelblue", "orange", "gold")
#' # plot_text("test.txt", pal = cols, pal_extend = TRUE)
#' # plot_text("test.txt", pal = cols, pal_extend = FALSE)
#' # plot_text("test.txt", pal = cols, pal_extend = FALSE, case_sense = TRUE)
#' 
#' ## Customize text and grid options:
#' # plot_text("test.txt", col_lbl = "darkblue", cex = 4, family = "sans", fontface = 3,
#' #           pal = "gold1", pal_extend = TRUE, border_col = NA)
#' # plot_text("test.txt", family = "serif", cex = 6, lbl_rotate = TRUE,  
#' #           pal = NA, borders = FALSE)
#' # plot_text("test.txt", col_lbl = "white", pal = c("green3", "black"),
#' #           border_col = "black", border_size = .2)
#' 
#' ## Color ranges:
#' # plot_text("test.txt", pal = c("red2", "orange", "gold"))
#' # plot_text("test.txt", pal = c("olivedrab4", "gold"))
#' 
#' # unlink("test.txt")  # clean up (by deleting file).
#'  
#' \donttest{
#' ## (b) Plot text (from file in subdir):
#' # plot_text("data-raw/txt/hello.txt")  # requires txt file
#' # plot_text(file = "data-raw/txt/ascii.txt", cex = 5, 
#' #           col_bg = "grey", char_bg = "-")
#'          
#' ## (c) Plot text input (from console):
#' # plot_text()
#'  
#' }
#'
#' @family plot functions
#'
#' @seealso
#' \code{\link{read_ascii}} for reading text into a table; 
#' \code{\link{pal_ds4psy}} for default color palette. 
#' 
#' @import ggplot2
#' @importFrom grDevices colorRampPalette 
#' @importFrom stats runif
#' 
#' @export 

plot_text <- function(file = "",  # "" read from console; "test.txt" read from file
                      char_bg = " ",  # character used as background, if char_bg = NA: most frequent char.
                      # text format:
                      lbl_tiles = TRUE, 
                      lbl_rotate = FALSE,  # TRUE rotates labels 
                      cex = 3,             # size of characters
                      fontface = 1,        # font face (1:4)
                      family = "sans",     # font family: 1 of "sans" "serif" "mono"
                      # colors: 
                      col_lbl = "black",   # color of text characters
                      col_bg = "white",    # bg color (for most frequent character in file)
                      pal = pal_ds4psy[1:5],  # c("steelblue", "skyblue", "lightgrey"),  # color palette for other replacements
                      pal_extend = TRUE,   # extend color palette (to n of different characters in file)
                      case_sense = FALSE,
                      # tile borders: 
                      borders = TRUE,        # show tile borders?
                      border_col = "white",  # color of tile border 
                      border_size = 0.5      # width of tile border
){
  
  ## (-) Default file/path:
  # file <- "test.txt"  # 4debugging
  
  ## (-) Parameters (currently fixed):
  # (a) Text:
  # fontface <- 1
  # family <- "mono"  # 1 of "sans" "serif" "mono"
  # angle <- 0
  # (b) Tile:
  height <- 1
  width <- 1
  
  # (0) Interpret inputs:
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
  
  # (1) Read text file into a table: 
  tb_txt <- read_ascii(file = file, flip_y = TRUE)
  nr_chars <- nrow(tb_txt)
  # tb_txt  # 4debugging
  
  
  # (2) Determine frequency of chars:
  
  ## Too complicated: 
  # if (case_sense){
  #   
  #   # (a) case-sensitive match: 
  #   
  #   # # (A) char_freq as table:   
  #   # # Using dplyr + pipe:
  #   # char_freq <- tb_txt %>%
  #   #   dplyr::count(char) %>%   # Note: Upper- and lowercase are counted separately!
  #   #   dplyr::arrange(desc(n))
  #   # 
  #   # # # Without pipe:
  #   # # t2 <- dplyr::count(tb_txt, char)
  #   # # char_freq <- dplyr::arrange(t2, desc(n))
  #   
  #   # (B) char_freq as named vector:
  #   char_freq <- count_chars(tb_txt$char, case_sense = TRUE, rm_specials = FALSE, sort_freq = TRUE)
  #   nr_unique_chars <- length(char_freq)
  #   
  # } else {
  #   
  #   # (b) case-INsensitive match:
  #   
  #   # # (A) char_freq as table:   
  #   # tb_txt$char_lc <- tolower(tb_txt$char)  # all in lowercase!
  #   # 
  #   # # Using dplyr + pipe:
  #   # char_freq <- tb_txt %>%
  #   #   dplyr::count(char_lc) %>% # Note: Upper- and lowercase are counted together!
  #   #   dplyr::mutate(char = char_lc) %>%
  #   #   dplyr::select(char, n) %>%
  #   #   dplyr::arrange(desc(n))
  #   # 
  #   # # # Without pipe:
  #   # # t2 <- dplyr::count(tb_txt, char_lc)
  #   # # t3 <- dplyr::mutate(t2, char = char_lc)
  #   # # t4 <- dplyr::select(t3, char, n)
  #   # # char_freq <- dplyr::arrange(t4, desc(n))
  #   
  #   # (B) char_freq as named vector:
  #   char_freq <- count_chars(tb_txt$char, case_sense = FALSE, rm_specials = FALSE, sort_freq = TRUE)
  #   nr_unique_chars <- length(char_freq)
  #   
  # }
  
  # (A+B) Simplify: Pass case_sense to char_freq():
  char_freq <- count_chars(tb_txt$char, case_sense = case_sense, rm_specials = FALSE, sort_freq = TRUE)
  nr_unique_chars <- length(char_freq)
  
  # char_freq  # 4debugging
  # print(nr_unique_chars)  # 4debugging
  
  # (3) If char_bg is defined && NOT the most frequent in char_freq: Make it the most frequent character:
  if (!is.na(char_bg) && (names(char_freq)[1] != char_bg)){
    
    # # (A) char_freq as table:    
    # # Set counter of char_freq$n for char_bg to a maximum value:
    # char_freq$n[char_freq$char == char_bg] <- max(1000, (max(char_freq$n) + 1))
    # 
    # # Re-arrange according to n:
    # char_freq <- char_freq %>% dplyr::arrange(desc(n))
    
    # (B) char_freq as named vector:
    ix <- (names(char_freq) == char_bg)  # ix of char_bg in char_freq
    char_freq[ix] <- max(1000, (max(char_freq) + 1))  # some high val
    char_freq <- sort(char_freq, decreasing = TRUE)
    
  }
  # print(char_freq)  # 4debugging
  
  # # (A) char_freq as table:   
  # nr_char_freq <- nrow(char_freq)
  
  # (B) char_freq as named vector:
  nr_char_freq <- sum(char_freq)
  # nr_char_freq  # 4debugging
  
  ## (+) Check:
  # if (nr_char_freq != nr_chars){
  #   message("plot_text: nr_char_freq differs from nr_chars.")
  # } 
  
  # (4) Create color palette:
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
  
  
  # (5) Use color palette to create a color map for frequent chars of tb_txt:
  col_map <- rep(col_bg, nr_chars)       # initialize color map
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
  
  # (6) Randomize text orientation:
  # lbl_rotate <- TRUE  # FALSE (default)
  if (lbl_rotate){
    char_angles <- round(stats::runif(n = nr_chars, min = 0, max = 360), 0)
  } else {
    char_angles <- 0
  }
  
  # (7) Use ggplot2: 
  cur_plot <- ggplot2::ggplot(data = tb_txt, aes(x = x, y = y)) +
    ggplot2::geom_tile(aes(), fill = col_map, color = brd_col, size = brd_size,  # tiles (with borders, opt.)
                       height = height, width = width) +  
    ggplot2::geom_text(aes(label = char), color = col_lbl, size = cex, 
                       fontface = fontface, family = family, angle = char_angles) + 
    ggplot2::coord_equal() + 
    # theme: 
    theme_empty() # theme_gray() # theme_classic() # cowplot::theme_nothing()
  
  # (8) plot plot: 
  cur_plot
  
  # (+) return(invisible(tb_txt))
  
} # plot_text. 

# ## Check:
# # Create a temporary file "test.txt":
# cat("Hello world!", "This is a test.",
#     "Can you see this text?",
#     "Good! Please carry on...",
#     file = "test.txt", sep = "\n")
# 
# # (a) Plot text from file:
# plot_text("test.txt")
# 
# # Set colors, pal_extend, and case_sense:
# cols <- c("firebrick", "olivedrab", "steelblue", "orange", "gold")
# plot_text("test.txt", pal = cols, pal_extend = TRUE)
# plot_text("test.txt", pal = cols, pal_extend = FALSE)
# plot_text("test.txt", pal = cols, pal_extend = FALSE, case_sense = TRUE)
# 
# # Customize text and grid options:
# plot_text("test.txt", col_lbl = "white", borders = FALSE)
# plot_text("test.txt", col_lbl = "firebrick", cex = 4, fontface = 3,
#           pal = "grey90", pal_extend = TRUE, border_col = NA)
# plot_text("test.txt", col_lbl = "white", pal = c("green4", "black"),
#           border_col = "black", border_size = .2)
# 
# # Color ranges:
# plot_text("test.txt", pal = c("red2", "orange", "gold"))
# plot_text("test.txt", pal = c("olivedrab4", "gold"))
# 
# unlink("test.txt")  # clean up (by deleting file). 
# 
# \donttest{
# # (b) Read text file (from subdir):
# plot_text("data-raw/txt/hello.txt")  # requires txt file
# plot_text(file = "data-raw/txt/ascii.txt", cex = 5,
#           col_bg = "lightgrey", border_col = "white")
# 
# # (c) Read user input (from console):
# plot_text()
# 
# }
#
# # Note: theme_empty() removed need for: #' @importFrom cowplot theme_nothing 

## plot_text_hi: Alternative to plot_text (with regex functionality): -------- 

# Note: As the above plot_text() function is character-based, 
#       it should probably be called plot_char()?

plot_text_hi <- function(file = "",  # "" read from console; "test.txt" read from file
                         
                         # regex (for highlighting matching patterns in text string):
                         # char_bg = " ",  # character used as background, if char_bg = NA: most frequent char.
                         lbl_hi = "[[:upper:]]",   # label to highlight (as regex)
                         bg_hi  = "[^[:space:]]",  # background to highlight (as regex)
                         
                         # text format:
                         lbl_tiles = TRUE, 
                         lbl_rotate = FALSE,  # TRUE rotates labels 
                         cex = 3,             # size of characters
                         fontface = 1,        # font face (1:4)
                         family = "sans",     # font family: 1 of "sans" "serif" "mono"
                         
                         # colors: 
                         col_lbl = "black",     # color of text labels
                         col_lbl_hi = pal_ds4psy[[1]],  # color of highlighted text labels
                         col_bg = "white",      # fill color of background tiles
                         col_bg_hi = pal_ds4psy[[7]],   # fill color of highlighted tiles
                         
                         # pal = pal_ds4psy[1:5],  # c("steelblue", "skyblue", "lightgrey"),  # color palette for other replacements
                         # pal_extend = TRUE,   # extend color palette (to n of different characters in file)
                         # case_sense = FALSE,
                         
                         # tile borders: 
                         borders = TRUE,        # show tile borders?
                         border_col = "white",  # color of tile border 
                         border_size = 0.5      # width of tile border
){
  
  ## (-) Default file/path:
  # file <- "test.txt"  # 4debugging
  
  ## (-) Parameters (currently fixed):
  # (a) Text:
  # fontface <- 1
  # family <- "mono"  # 1 of "sans" "serif" "mono"
  # angle <- 0
  # (b) Tile:
  height <- 1
  width <- 1
  
  # (0) Interpret inputs:
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
  
  # (1) Read text file into a table: 
  tb_txt <- read_ascii(file = file, flip_y = TRUE)
  nr_chars <- nrow(tb_txt)
  # tb_txt  # 4debugging
  
  
  # NEW PARTS: ------  
  
  
  # (2) Get chars in tb_txt$char (as a single string):
  char_v <- tb_txt$char   # char vector
  
  # Translate vector of characters (char_v) into a string (char_s): 
  my_space <- "_136473_"  # some cryptic replacement for " " (in character string)
  char_v_hlp <- gsub(pattern = " ", replacement = my_space, x = char_v)  # helper (with replaced spaces)
  char_s_hlp <- paste(char_v_hlp, collapse = "")  # char string helper (with spaces as my_space)
  char_s <- gsub(pattern = my_space, replacement = " ", x = char_s_hlp)  # char string (with original spaces)
  
  # Check (for debugging): Does nchar(char_s) equal nr_chars = nrow(tb_txt)? 
  if (nchar(char_s) != nrow(tb_txt)){
    message(paste0("plot_text_hi: nchar(char_s) = ", nchar(char_s), " differs from nrow(tb_txt) = ", nrow(tb_txt), "."))
  }
  
  
  # (3) Apply 2 regex patterns to color char_s:
  # Use util function that matches a regex to a text string and returns a vector of colors: 
  col_lbl <- color_map_match(text = char_s, pattern = lbl_hi, col_fg = col_lbl_hi,  col_bg = col_lbl)
  col_tls <- color_map_match(text = char_s, pattern = bg_hi,  col_fg = col_bg_hi, col_bg = col_bg)  
  # +++ here now: +++
  
  
  # (4) Randomize text orientation:
  # lbl_rotate <- TRUE  # FALSE (default)
  if (lbl_rotate){
    char_angles <- round(stats::runif(n = nr_chars, min = 0, max = 360), 0)
  } else {
    char_angles <- 0
  }
  
  # (5) Use ggplot2: 
  cur_plot <- ggplot2::ggplot(data = tb_txt, aes(x = x, y = y)) +
    ggplot2::geom_tile(aes(), fill = col_tls, color = brd_col, size = brd_size,  # tiles (with borders, opt.)
                       height = height, width = width) +  
    ggplot2::geom_text(aes(label = char), color = col_lbl, size = cex, 
                       fontface = fontface, family = family, angle = char_angles) + 
    ggplot2::coord_equal() + 
    # theme: 
    theme_empty() # theme_gray() # theme_classic() # cowplot::theme_nothing()
  
  # (6) plot plot: 
  cur_plot
  
  # (7) Return:
  # return(invisible(tb_txt))
  # return(char_s)
  
} # plot_text_hi(). 

## Check:
# plot_text_hi()  # (A) Use interactive user input.
# 
# # (B) Create a temporary file "test.txt":
# cat("Hello world!", "This is a test.",
#     "Can you see this text?",
#     "Good! Please carry on...",
#     file = "test.txt", sep = "\n")
# 
# # (a) Plot text from file:
# plot_text_hi("test.txt")  # default 
# plot_text_hi("test.txt", lbl_hi = "test", col_lbl_hi = "red")
# plot_text_hi("test.txt", lbl_hi = "\\b\\w{4}\\b", col_lbl_hi = "red")  # mark fg of four-letter words
# plot_text_hi("test.txt", lbl_hi = "asdf", bg_hi = "\\b\\w{4}\\b", col_bg_hi = "gold")  # mark bg of 4-letter words
# 
# unlink("test.txt")  # clean up (by deleting file).


## Done: ----------

# - theme_empty() removed need for: #' @importFrom cowplot theme_nothing 

## ToDo: ----------

# - Consider adding plot_tbar() and plot_tclock() 
#   (to plot toc, see file images/art.Rmd).

## eof. ----------------------