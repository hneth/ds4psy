## plot_fun.R | ds4psy
## hn | uni.kn | 2019 08 11
## ---------------------------

## Functions for plotting. 

## Plotting: ---------- 

## plot_tiles: Tile plots (of n x n tiles): -------- 

#' Plot n-by-n tiles.
#'
#' \code{plot_tiles} plots an area of \code{n-by-n} tiles 
#' on fixed or polar coordinates.  
#' 
#' 
#' @param n Basic number of tiles (on either side).
#'
#' @param pal A color palette (automatically extended to \code{n x n} colors). 
#' Default: \code{pal = \link{pal_ds4psy}}. 
#' 
#' @param sort Sort tiles? 
#' Default: \code{sort = TRUE} (i.e., sorted tiles).  
#' 
#' @param borders Add borders to tiles? 
#' Default: \code{borders = TRUE} (i.e., use borders).
#' 
#' @param border_col Color of borders (if \code{borders = TRUE}). 
#' Default: \code{border_col = grey(0, 1)} (i.e., black).  
#' 
#' @param border_size Size of borders (if \code{borders = TRUE}). 
#' Default: \code{border_size = 0.2} (i.e., thin).  

#' @param lbl_tiles Add numeric labels to tiles? 
#' Default: \code{lbl_tiles = FALSE} (i.e., no labels). 
#' 
#' @param lbl_title Add numeric label (of n) to plot? 
#' Default: \code{lbl_title = FALSE} (i.e., no title). 
#'
#' @param polar Plot on polar coordinates? 
#' Default: \code{polar = FALSE} (i.e., using fixed coordinates). 
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
#'
#' @examples
#' # (1) Tile plot:
#' plot_tiles()  # default plot (random n, with borders, no labels)
#' 
#' plot_tiles(n =  6, sort = FALSE)      # random order
#' plot_tiles(n =  8, borders = FALSE)   # no borders
#' plot_tiles(n = 10, lbl_tiles = TRUE)  # with tile labels 
#' plot_tiles(n = 10, lbl_title = TRUE)  # with title label 
#' 
#' # Set colors: 
#' plot_tiles(n = 3, pal = c("steelblue", "white", "black"),
#'            lbl_tiles = TRUE, sort = TRUE)
#' plot_tiles(n = 5, pal = c("orange", "white", "firebrick"),
#'            lbl_tiles = TRUE, lbl_title = TRUE,
#'            sort = TRUE)
#' plot_tiles(n = 10, sort = FALSE, border_col = "white", border_size = 2)
#'   
#' # Fixed rseed:
#' plot_tiles(n = 4, sort = FALSE, borders = FALSE, 
#'            lbl_tiles = TRUE, lbl_title = TRUE, 
#'            rseed = 101)
#' 
#' # (2) polar plot:  
#' plot_tiles(polar = TRUE)  # default polar plot (with borders, no labels)
#' 
#' plot_tiles(n =  6, polar = TRUE, sort = FALSE)      # random order
#' plot_tiles(n =  8, polar = TRUE, borders = FALSE)   # no borders
#' plot_tiles(n = 10, polar = TRUE, lbl_tiles = TRUE)  # with tile labels 
#' plot_tiles(n = 10, polar = TRUE, lbl_title = TRUE)  # with title label 
#' 
#' plot_tiles(n = 4, sort = FALSE, borders = TRUE,  
#'            border_col = "white", border_size = 2, 
#'            polar = TRUE, rseed = 132)
#'  
#' @family plot functions
#'
#' @seealso
#' \code{\link{pal_ds4psy}} for default color palette. 
#' 
#' @import ggplot2
#' @import grDevices
#' @import here
#' @import unikn
#' @importFrom cowplot theme_nothing 
#' 
#' @export 

plot_tiles <- function(n = NA, 
                       pal = pal_ds4psy, 
                       sort = TRUE, 
                       borders = TRUE,
                       border_col = grey(0, 1), 
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
  
  # Catch special case: Replace the white tile for n = 2 by a grau[[1]] tile:
  if (n == 2) { 
    cur_col[cur_col == "#FFFFFF"] <- unikn::pal_grau[[1]] 
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
  cur_plot <- ggplot2::ggplot(cur_tb) + 
    ggplot2::geom_tile(aes(x = cur_tb$x, y = cur_tb$y,  fill = !!sym(var_tile)), color = brd_col, size = brd_size) +  # tiles (with borders, opt.)
    ggplot2::geom_text(aes(x = cur_tb$x, y = cur_tb$y, label = !!sym(var_tile)), color = lbl_col, size = lbl_size) +  # labels (opt.) 
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
    # theme_gray()
    cowplot::theme_nothing()
  
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
    full_name <- here(save_path, plot_name)
    
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
  
} # plot_tiles end.

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



# Production loop (all chapters): -------- 

## Settings for current loop:
# n_chapters <- 10
# save_now <- FALSE
# 
# col_brd <- "white"
# siz_brd <- 1.6
# 
# i    <- 2
# rfac <- 137  # constant rfac (to use as rseed in loop)
# 
# for (i in 1:n_chapters){
# 
#   # (1) tile plots:
#   plot_tiles(n = i, sort = F, polar = F,
#              border_col = col_brd, border_size = siz_brd,
#              rseed = i*rfac, save = save_now)  # tile rand
#   plot_tiles(n = i, sort = T, polar = F,
#              border_col = col_brd, border_size = siz_brd,
#              rseed = i*rfac, save = save_now)  # tile sort
# 
#   plot_tiles(n = i, sort = F, polar = F, lbl_title = T,
#              border_col = col_brd, border_size = siz_brd,
#              rseed = i*rfac, save = save_now)  # tile rand with title lbl
#   plot_tiles(n = i, sort = T, polar = F, lbl_title = T,
#              border_col = col_brd, border_size = siz_brd,
#              rseed = i*rfac, save = save_now)  # tile sort with title lbl
# 
#   # (2) pole plots:
#   plot_tiles(n = i, sort = F, polar = T,
#              border_col = col_brd, border_size = siz_brd,
#              rseed = i*rfac, save = save_now)  # pole rand
#   plot_tiles(n = i, sort = T, polar = T,
#              border_col = col_brd, border_size = siz_brd,
#              rseed = i*rfac, save = save_now)  # pole sort
# 
#   plot_tiles(n = i, sort = F, polar = T, lbl_title = T,
#              border_col = col_brd, border_size = siz_brd,
#              rseed = i*rfac, save = save_now)  # pole rand with title lbl
#   plot_tiles(n = i, sort = T, polar = T, lbl_title = T,
#              border_col = col_brd, border_size = siz_brd,
#              rseed = i*rfac, save = save_now)  # pole sort with title lbl
# 
# }



## plot_fun: Wrapper around plot_tiles (with fewer and cryptic options): -------- 

#' A function to plot some plot.
#'
#' \code{plot_fun} is a function that uses parameters to plot a plot. 
#' 
#' \code{plot_fun} is deliberately kept cryptic and obscure to illustrate 
#' how function parameters can be explored (and why transparent variable 
#' names are essential for understanding and using a function). 
#' 
#' @param a A (natural) number. 
#' Default: \code{a = NA}. 
#' 
#' @param b A Boolean value. 
#' Default: \code{b = TRUE}. 
#' 
#' @param c A Boolean value. 
#' Default: \code{c = TRUE}. 
#' 
#' @param d A (decimal) number. 
#' Default: \code{d = 1.0}. 
#' 
#' @param e A Boolean value. 
#' Default: \code{e = FALSE}.
#' 
#' @param f A Boolean value. 
#' Default: \code{f = FALSE}. 
#' 
#' @param g A Boolean value. 
#' Default: \code{g = FALSE}. 
#'
#' @param c1 A color palette (e.g., as a vector). 
#' Default: \code{c1 = c(rev(pal_seeblau), "white", pal_grau, "black", Bordeaux)}. 
#' Note: Using colors of the \code{unikn} package by default. 
#'
#' @param c2 A color (e.g., as a character). 
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
  
} # plot_fun end. 

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
#' Default: \code{border_col = grey(0, 1)} (i.e., black).  
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
#' plot_n(n =  6, sort = FALSE)      # random order
#' plot_n(n =  8, borders = FALSE)   # no borders
#' plot_n(n = 10, lbl_tiles = TRUE)  # with tile labels 
#' plot_n(n = 10, lbl_title = TRUE)  # with title label 
#' 
#' # Set colors: 
#' plot_n(n = 3, pal = c("forestgreen", "white", "black"),
#'        lbl_tiles = TRUE, sort = TRUE)
#' plot_n(n = 5, row = FALSE,  
#'        pal = c("orange", "white", "firebrick"),
#'        lbl_tiles = TRUE, lbl_title = TRUE, sort = TRUE)
#' plot_n(n = 10, sort = FALSE, border_col = "white", border_size = 2)
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
#' plot_n(n = 7, polar = TRUE, lbl_tiles = TRUE)  # PIE with tile labels 
#' plot_n(n = 7, polar = TRUE, row = FALSE, lbl_title = TRUE)  # TARGET with title label 
#' 
#' plot_n(n = 4, row = TRUE, sort = FALSE, borders = TRUE,  
#'        border_col = "white", border_size = 2, 
#'        polar = TRUE, rseed = 132)
#' plot_n(n = 4, row = FALSE, sort = FALSE, borders = TRUE,  
#'        border_col = "white", border_size = 2, 
#'        polar = TRUE, rseed = 134)
#'  
#' @family plot functions
#'
#' @seealso
#' \code{\link{pal_ds4psy}} for default color palette. 
#' 
#' @import ggplot2
#' @import grDevices
#' @import here
#' @import unikn
#' @importFrom cowplot theme_nothing 
#' 
#' @export 

plot_n <- function(n = NA, 
                   row = TRUE, 
                   polar = FALSE, 
                   pal = pal_ds4psy,
                   sort = TRUE, 
                   borders = TRUE,
                   border_col = grey(0, 1), 
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
  
  # Catch special case: Replace the white tile for n = 2 by a grau[[1]] tile:
  if (n == 2) { 
    cur_col[cur_col == "#FFFFFF"] <- unikn::pal_grau[[1]] 
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
    cur_plot <- ggplot2::ggplot(cur_tb) + 
      ggplot2::geom_tile(aes(x = cur_tb$x, y = cur_tb$y,  fill = !!sym(var_tile)), color = brd_col, size = brd_size) +  # tiles (with borders, opt.)
      ggplot2::geom_text(aes(x = cur_tb$x, y = cur_tb$y, label = !!sym(var_tile)), color = lbl_col, size = lbl_size) +  # labels (opt.) 
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
      # theme_gray()
      cowplot::theme_nothing()
    
  } else { # as col: 
    
    # create a COLUMN of tiles:
    cur_plot <- ggplot2::ggplot(cur_tb) + 
      ggplot2::geom_tile(aes(x = cur_tb$y, y = ((n + 1) - cur_tb$x),  fill = !!sym(var_tile)), color = brd_col, size = brd_size) +  # tiles (with borders, opt.)
      ggplot2::geom_text(aes(x = cur_tb$y, y = ((n + 1) - cur_tb$x), label = !!sym(var_tile)), color = lbl_col, size = lbl_size) +  # labels (opt.) 
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
      # theme_gray()
      cowplot::theme_nothing()
    
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
    full_name <- here(save_path, plot_name)
    
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
  
} # plot_n end.

# +++ here now +++ 

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






## plot_fn: Wrapper around plot_n (with fewer and cryptic options): -------- 

#' A function to plot a plot.
#'
#' \code{plot_fn} is a function that uses parameters for plotting a plot. 
#' 
#' \code{plot_fn} is deliberately kept cryptic and obscure to illustrate 
#' how function parameters can be explored (and why transparent variable 
#' names are essential for understanding and using a function). 
#' 
#' @param x A (natural) number. 
#' Default: \code{x = NA}. 
#' 
#' @param y A (decimal) number. 
#' Default: \code{y = 0}. 
#' 
#' @param A A Boolean value. 
#' Default: \code{A = TRUE}. 
#' 
#' @param B A Boolean value. 
#' Default: \code{B = FALSE}. 
#' 
#' @param C A Boolean value. 
#' Default: \code{C = TRUE}. 
#' 
#' @param D A Boolean value. 
#' Default: \code{D = FALSE}.
#' 
#' @param E A Boolean value. 
#' Default: \code{E = FALSE}.
#' 
#' @param F A Boolean value. 
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
  
} # plot_fn end. 


## ToDo: ----------

# - ...

## eof. ----------------------