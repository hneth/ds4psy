## plot_fun.R | ds4psy
## hn | uni.kn | 2019 07 28
## ---------------------------

## Functions for plotting. 

## Plotting: ---------- 

# plot_tiles: Tile plot (with options): -------- 

plot_tiles <- function(n = NA, 
                       pal = pal_ds4psy, 
                       sort = TRUE, 
                       borders = TRUE,
                       lbl_tiles = FALSE, 
                       lbl_title = FALSE, 
                       rseed = NA){
  
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
  set.seed(seed = rseed)  # for reproducible randomness
  bg_col    <-  grey(0, 1)
  lbl_size  <- 42/n
  plot_size <-  5.0    # NORMAL: in cm (used in ggsave below): normal (small) size
  # plot_size <- 10.0  # BIG:    in cm (used in ggsave below): when "./../images/big_"
  
  # Tile borders:
  if (borders){
    brd_col   <- bg_col
    brd_size  <- 0.2
  } else {
    brd_col  <- NA
    brd_size <- NA
  }
  
  # Label (on top left):
  if (lbl_title){
    cur_lbl <- as.character(n)
    x_lbl <- 1 
    y_lbl <- (n + 1) # + n/15
    top_col <- bg_col
  } else {
    cur_lbl <- as.character(n)
    x_lbl <- 1
    y_lbl <- n + 1
    top_col <- NA  # hide label
  }
  
  # data tb:
  cur_tb  <- make_tb(n = n, rseed = rseed)
  
  # colors:
  cur_col <- pal_n_sq(n = n, pal = pal)
  
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
  cur_plot <- ggplot(cur_tb) + 
    geom_tile(aes(x = x, y = y,  fill = !!sym(var_tile)), color = brd_col, size = brd_size) +  # tiles (with borders, opt.)
    geom_text(aes(x = x, y = y, label = !!sym(var_tile)), color = lbl_col, size = lbl_size) +  # labels (opt.) 
    ## Label (on top left): 
    annotate("text", x = x_lbl, y = y_lbl, label = cur_lbl, col = top_col, size = lbl_size, fontface = 1) +  # label (on top left)
    scale_y_continuous(limits = c(0, y_lbl)) +                    # scale (to fit label)
    coord_fixed() + 
    ## Plot labels: 
    labs(title = "Tiles", x = "Data", y = "Science") +
    ## Colors: 
    scale_fill_gradientn(colors = cur_col) +  # s2: full unikn_sort palette: seeblau > white > black [default]
    # theme_gray()
    cowplot::theme_nothing()
  
  # plot plot: 
  cur_plot
  
  # return(invisible(cur_tb))
  
} # plot_tiles end.

## Check:
plot_tiles()  # default plot (random n, with borders, no labels)

plot_tiles(n =  6, sort = FALSE)      # random order
plot_tiles(n =  8, borders = FALSE)   # no borders
plot_tiles(n = 10, lbl_tiles = TRUE)  # with tile labels 
plot_tiles(n = 10, lbl_title = TRUE)  # with tile labels 

# Set colors: 
plot_tiles(n = 4, pal = c(rev(pal_seegruen), "white", pal_karpfenblau), 
           lbl_tiles = TRUE, sort = TRUE)
plot_tiles(n = 5, pal = c(rev(pal_bordeaux), "white", pal_petrol), 
           lbl_tiles = TRUE, lbl_title = TRUE, 
           sort = TRUE)

# Fixed rseed:
plot_tiles(n = 10, sort = FALSE, borders = TRUE, 
           lbl_tiles = TRUE, lbl_title = TRUE, 
           rseed = 101)  # fix seed

# +++ here now +++ 

## ToDo: ----------

## eof. ----------------------