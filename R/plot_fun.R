## plot_fun.R | ds4psy
## hn | uni.kn | 2019 08 25
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



## plot_txt: Plot text characters as a tile plot: -------- 

#' Plot text characters (from file).
#'
#' \code{plot_txt} parses text (from a file) 
#' into a tibble and then plots all 
#' its characters as a tile plot (using \strong{ggplot2}).
#' 
#' @param file The text file to read (or its path).  
#' If the text file is stored in a sub-directory, 
#' enter its path and name here (without any leading or 
#' trailing "." or "/"). 
#' Default: \code{file = "txt/hello.txt"}. 
#' 
#' @param lbl_tiles Add numeric labels to tiles? 
#' Default: \code{lbl_tiles = TRUE} (i.e., show labels). 
#' 
#' @param cex Character size (numeric). 
#' Default: \code{cex = 3}.
#' 
#' @param fontface Font face (numeric). 
#' Default: \code{fontface = 1}, (from 1 to 4).
#' 
#' @param col_txt Color of text characters.
#' Default: \code{col_txt = "black"} (if \code{lbl_tiles = TRUE}). 
#' 
#' @param col_bg Color of most frequent character in text 
#' (typically " ", i.e., background). 
#' Default: \code{col_bg = "white"}. 
#' 
#' @param pal Color palette to use for tiles 
#' of text (used in order of character frequency). 
#' Default: \code{pal = pal_ds4psy[1:5]}. 
#' 
#' @param pal_extend Boolean: Should pal be extended 
#' to match the number of different characters in text? 
#' Default: \code{pal_extend = TRUE}. 
#' If \code{pal_extend = FALSE}, only the tiles of 
#' the \code{length(pal)} most frequent characters 
#' will be filled by the colors of \code{pal}. 
#' 
#' @param case_sense Boolean: Should lower- and 
#' uppercase characters be distinguished? 
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
#' 
#' \donttest{
#' plot_txt("txt/hello.txt")  # requires txt file
#' 
#' # Colors, pal_extend, and case_sense:
#' cols <- c("firebrick", "olivedrab", "steelblue", "orange", "gold")
#' plot_txt(pal = cols, pal_extend = TRUE)
#' plot_txt(pal = cols, pal_extend = FALSE)
#' plot_txt(pal = cols, pal_extend = FALSE, case_sense = TRUE)
#' 
#' # Customize:
#' plot_txt(col_txt = "white", borders = FALSE)
#' plot_txt(col_txt = "white", pal = c("green4", "black"),
#'          border_col = "black", border_size = .2)
#' 
#' # Color ranges:
#' plot_txt(pal = c("red2", "orange", "gold"))
#' plot_txt(pal = c("olivedrab4", "gold"))
#' 
#' # Text and grid options:
#' plot_txt(col_txt = "firebrick", cex = 4, fontface = 3,
#'          pal = "grey90", pal_extend = TRUE,
#'          border_col = NA)
#' 
#' # Other text file:
#' plot_txt(file = "txt/ascii.txt", cex = 5, 
#'          col_bg = "lightgrey", border_col = "white")
#' }
#'
#' @family plot functions
#'
#' @seealso
#' \code{\link{read_ascii}} for reading text files into a tibble; 
#' \code{\link{pal_ds4psy}} for default color palette. 
#' 
#' @import dplyr  
#' @import ggplot2
#' @import here
#' @import unikn
#' @importFrom magrittr "%>%"
#' @importFrom cowplot theme_nothing 
#' 
#' @export 

plot_txt <- function(file = "txt/hello.txt",
                     # text format:
                     lbl_tiles = TRUE, 
                     cex = 3,   # size of characters
                     fontface = 1,  # font face (1:4)
                     # colors: 
                     col_txt = "black",  # color of text characters
                     col_bg = "white",   # bg color (for most frequent character in file)
                     pal = pal_ds4psy[1:5],  # color palette for other replacements
                     pal_extend = TRUE,  # extend color palette (to n of different characters in file)
                     case_sense = FALSE,
                     # tile borders: 
                     borders = TRUE,       # show tile borders?
                     border_col = "white", # color of tile border 
                     border_size = 0.5     # width of tile border
){
  
  # (0) Interpret inputs:
  if (!lbl_tiles) {col_txt <- NA}
  
  # Tile borders:
  if (borders){
    brd_col   <- border_col
    brd_size  <- border_size
  } else {
    brd_col  <- NA  # hide label
    brd_size <- NA  # hide label
  }
  
  # (1) Read text file into tibble: 
  tb <- read_ascii(file, flip_y = TRUE)
  n  <- nrow(tb)
  # tb
  
  # (2) Determine frequency of chars:
  if (case_sense){
    
    # (a) case-sensitive match: 
    
    # # Using a dplyr pipe:     
    # char_freq <- tb %>%
    #  dplyr::count(char) %>%   # Note: Upper- and lowercase are counted separately!
    #  dplyr::arrange(desc(n))
    
    # Re-write without pipe:
    t2 <- dplyr::count(tb, char)
    char_freq <- dplyr::arrange(t2, desc(n))    
    
  } else {
    
    # (b) case-INsensitive match:
    tb$char_lc <- tolower(tb$char)  # all in lowercase!
    
    # # Using a dplyr pipe:     
    # char_freq <- tb %>% 
    #   dplyr::count(char_lc) %>% # Note: Upper- and lowercase are counted together!
    #   dplyr::mutate(char = char_lc) %>%  
    #   dplyr::select(char, n) %>% 
    #   dplyr::arrange(desc(n))
    
    # Re-write without pipe:
    t2 <- dplyr::count(tb, char_lc)
    t3 <- dplyr::mutate(t2, char = char_lc)
    t4 <- dplyr::select(t3, char, n)
    char_freq <- dplyr::arrange(t4, desc(n))
    
  }
  # char_freq
  n_char <- nrow(char_freq)
  
  # (3) Create color palette:
  if (pal_extend){
    
    # Stretch pal to a color gradient (of char_freq different colors): 
    pal_ext <- unikn::usecol(pal, n = (n_char - 1))  # extended pal
    col_pal <- c(col_bg, pal_ext)
    
  } else {
    
    col_pal <- c(col_bg, pal)  # combine 2 user inputs
    
  }
  n_col <- length(col_pal)
  
  # (4) Use color palette to create a color map for frequent chars of tb:
  col_map <- rep(col_pal[1], n) # initialize color map
  n_replace <- min(n_col, n_char)  # Limit number of replacements 
  
  for (i in 1:n_replace){
    
    cur_char <- char_freq$char[i]  # i-th most freq char
    
    # Determine positions ix in tb$char that correspond to cur_char:
    if (case_sense){  
      ix <- which(tb$char == cur_char)  # case-sensitive match
    } else {
      ix <- which(tolower(tb$char) == cur_char)  # case-insensitive match
    }
    
    # use i-th color in col_pal for ALL col_map positions at [ix]:
    col_map[ix] <- col_pal[i]  
    
  } # loop i.
  # col_map
  
  # (5) Use ggplot2: 
  cur_plot <- ggplot2::ggplot(data = tb, aes(x = tb$x, y = tb$y)) +
    ggplot2::geom_tile(aes(), fill = col_map, color = brd_col, size = brd_size) +  # tiles (with borders, opt.)
    ggplot2::geom_text(aes(label = char), color = col_txt, size = cex, fontface = fontface) + 
    ggplot2::coord_equal() + 
    # theme: 
    # theme_classic() +
    cowplot::theme_nothing()
  
  # (6) plot plot: 
  cur_plot
  
  # (+) return(invisible(tb))
  
} # plot_txt. 

# ## Check:
# plot_txt("txt/hello.txt")
# plot_txt("txt/ascii.txt", cex = 6, col_bg = "grey")
# 
# cols <- c("steelblue3", "steelblue2", "steelblue1", 
#           "red3", "red2", "red1", 
#           "orange3", "orange2", "orange1",
#           "gold3", "gold2", "gold1")
# plot_txt("txt/ascii.txt", cex = 6, pal = cols)
# plot_txt("txt/ascii.txt", cex = 6, pal = cols, col_bg = "steelblue4")
# 
# # Colors, pal_extend, and case_sense:
# cols <- c("firebrick", "olivedrab", "steelblue", "orange", "gold")
# plot_txt(pal = cols, pal_extend = TRUE)
# plot_txt(pal = cols, pal_extend = FALSE)
# plot_txt(pal = cols, pal_extend = FALSE, case_sense = TRUE)
# 
# # Customize:
# plot_txt(col_txt = "white", borders = FALSE)
# plot_txt(col_txt = "white", pal = c("green4", "black"),
#          border_col = "black", border_size = .1)
# 
# # Other colors:
# plot_txt(pal = c("red2", "orange", "gold"))
# plot_txt(pal = c("olivedrab4", "gold"))
# 
# # Text and grid options:
# plot_txt(col_txt = "firebrick", cex = 4, fontface = 3,
#          pal = "grey90", pal_extend = TRUE,
#          border_col = NA)
# 
# # Other files:
# plot_txt(file = "txt/ascii2.txt",
#          col_bg = "lightgrey", border_col = "white")


## ToDo: ----------

# - add option for reading ascii art (into tile plots). 

## eof. ----------------------