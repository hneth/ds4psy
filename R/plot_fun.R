## plot_fun.R | ds4psy
## hn | uni.kn | 2019 07 30
## ---------------------------

## Functions for plotting. 

## Plotting: ---------- 

# plot_tiles: Tile plot (with options): -------- 

#' Plot n-by-n tiles.
#'
#' \code{plot_tiles} plots \code{n^2} tiles on fixed or polar coordinates.  
#' 
#' @param n Basic number of tiles (on either side).
#'
#' @param pal A color palette (automatically extended to n x n colors). 
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
#' plot_tiles(n = 4, pal = c(rev(pal_seegruen), "white", pal_karpfenblau), 
#'            lbl_tiles = TRUE, sort = TRUE)
#' plot_tiles(n = 5, pal = c(rev(pal_bordeaux), "white", pal_petrol), 
#'            lbl_tiles = TRUE, lbl_title = TRUE, 
#'            sort = TRUE)
#' plot_tiles(n = 10, sort = FALSE, border_col = "white", border_size = 1)
#'  
#' # Fixed rseed:
#' plot_tiles(n = 10, sort = FALSE, borders = TRUE, 
#'            lbl_tiles = TRUE, lbl_title = TRUE, 
#'            rseed = 101)  # fix seed
#' 
#' # (2) polar plot:  
#' plot_tiles(polar = TRUE)  # default polar plot (with borders, no labels)
#' 
#' plot_tiles(n =  6, polar = TRUE, sort = FALSE)      # random order
#' plot_tiles(n =  8, polar = TRUE, borders = FALSE)   # no borders
#' plot_tiles(n = 10, polar = TRUE, lbl_tiles = TRUE)  # with tile labels 
#' plot_tiles(n = 10, polar = TRUE, lbl_title = TRUE)  # with title label 
#' 
#' plot_tiles(n = 10, sort = F, border_col = "white", border_size = 1/2, polar = T)
#'  
#' @family plot functions
#'
#' @seealso
#' \code{\link{pal_ds4psy}} for default color palette. 
#' 
#' @import ggplot2
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
                       save_path = "images/tiles"){
  
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
  
  if (polar){
    x_lbl <- n   
    y_lbl <- (n + 2)
    lbl_size      <- 15/n
    lbl_size_top  <- 30/n
  } else {
    x_lbl <- 1
    y_lbl <- (n + 1)
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
  
  # create plot of tiles:
  cur_plot <- ggplot2::ggplot(cur_tb) + 
    ggplot2::geom_tile(aes(x = x, y = y,  fill = !!sym(var_tile)), color = brd_col, size = brd_size) +  # tiles (with borders, opt.)
    ggplot2::geom_text(aes(x = x, y = y, label = !!sym(var_tile)), color = lbl_col, size = lbl_size) +  # labels (opt.) 
    ## Label (on top left): 
    ggplot2::annotate("text", x = x_lbl, y = y_lbl, label = cur_lbl, col = top_col, 
                      size = lbl_size_top, fontface = 1) +  # label (on top left)
    # Scale:
    ggplot2::scale_y_continuous(limits = c(0, y_lbl + 1/2)) +  # scale (to fit top label)
    # ggplot2::scale_x_continuous(limits = c(0, y_lbl)) +        # scale (to fit label)
    # coord_fixed() + 
    ## Plot labels: 
    ggplot2::labs(title = "Tiles", x = "Data", y = "Science") +
    ## Colors: 
    ggplot2::scale_fill_gradientn(colors = cur_col) +  # s2: full unikn_sort palette: seeblau > white > black [default]
    # theme_gray()
    cowplot::theme_nothing()
  
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
    suffix <- ""
    filext <- ".png"
    
    plot_name <- paste0(coord, num, sort_rand, brds, lbls, titl, suffix, filext)
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

# +++ here now +++ 

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


## Production loop: -------- 

# # Settings for current loop:
# n_chapters <- 10
# save_now <- TRUE
# 
# col_brd <- "white"
# siz_brd <- 1.6
# i <- 2
# 
# for (i in 1:n_chapters){
#   
#   # (1) tile plots:
#   plot_tiles(n = i, sort = F, polar = F, 
#              border_col = col_brd, border_size = siz_brd, 
#              rseed = i*137, save = save_now)  # tile rand
#   plot_tiles(n = i, sort = T, polar = F,
#              border_col = col_brd, border_size = siz_brd, 
#              rseed = i*137, save = save_now)  # tile sort
# 
#   plot_tiles(n = i, sort = F, polar = F, lbl_title = T,
#              border_col = col_brd, border_size = siz_brd, 
#              rseed = i*137, save = save_now)  # tile rand with title lbl
#   plot_tiles(n = i, sort = T, polar = F, lbl_title = T,
#              border_col = col_brd, border_size = siz_brd, 
#              rseed = i*137, save = save_now)  # tile sort with title lbl
# 
#   # (2) pole plots:
#   plot_tiles(n = i, sort = F, polar = T,
#              border_col = col_brd, border_size = siz_brd, 
#              rseed = i*137, save = save_now)  # pole rand
#   plot_tiles(n = i, sort = T, polar = T,
#              border_col = col_brd, border_size = siz_brd, 
#              rseed = i*137, save = save_now)  # pole sort
# 
#   plot_tiles(n = i, sort = F, polar = T, lbl_title = T,
#              border_col = col_brd, border_size = siz_brd, 
#              rseed = i*137, save = save_now)  # pole rand with title lbl
#   plot_tiles(n = i, sort = T, polar = T, lbl_title = T,
#              border_col = col_brd, border_size = siz_brd, 
#              rseed = i*137, save = save_now)  # pole sort with title lbl
# 
# }


## ToDo: ----------

# - add option to save generated plots 

## eof. ----------------------