## plot_fun.R | ds4psy
## hn | uni.kn | 2019 07 28
## ---------------------------

## Functions for plotting. 

## Plotting: ---------- 

# plot_tile: Tile plot (with options): -------- 

plot_tile <- function(n = NA, pal = pal_ds4psy, 
                      sort = TRUE, rseed = NA){
  
  # initialize:
  cur_col  <- NA
  cur_tb   <- NA
  cur_plot <- NA
  
  # Robustness:
  if (is.na(n)) {
    n <- sample(1:10, size = 1, replace = TRUE)  # random dim_x
  }
  if (is.na(rseed)) {
    rseed <- sample(1:999, size = 1, replace = TRUE)  # random rseed
  }
  if (sort){
    type <- "sort"  # case 1: sorted tiles    
  } else {
    type <- "rand"  # case 2: random tiles
  }
  
  # Parameters: 

  brd_col   <- "black" # grey(0, 1)
  brd_size  <- .10
  plot_size <-  3.0  # NORMAL: in cm (used in ggsave below): normal (small) size
  # plot_size <- 10.0  # BIG:    in cm (used in ggsave below): when "./../images/big_"
  lbl_size  <- 1.5
  
  # colors:
  cur_col <- pal_n_sq(n = n, pal = pal)
  
  # data tb:
  cur_tb <- make_tb(n = n, rseed = rseed)
  
  # create plot:
  tile_plot <- ggplot2::ggplot(cur_tb) + 
    geom_tile(aes(x = x, y = y, fill = !!sym(type), col = brd_col, size = brd_size)) +
    # geom_text(aes(x = x, y = y, label = rand), col = col_rand, size = lbl_size) +  # with tile labels 
    coord_fixed() + 
    # labs(title = "ds4psy") + 
    labs(x = "Data", y = "Science") +
    ## Color schemes: 
    # scale_fill_continuous(low = seeblau, high = grey(1, 1)) +   # s1: light: seeblau > white
    scale_fill_gradientn(colors = cur_col) +                   # s2: full unikn_sort palette: seeblau > white > black [default]
    # scale_fill_gradientn(colors = c(cur_col, "gold")) +      # s3: highlight final row
    cowplot::theme_nothing()
  
  # plot plot: 
  tile_plot
  
} # plot_tile end.

## Check:
# plot_tile()

# +++ here now +++ 

## ToDo: ----------

## eof. ----------------------