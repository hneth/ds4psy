% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_fun.R
\name{plot_n}
\alias{plot_n}
\title{Plot n tiles}
\usage{
plot_n(
  n = NA,
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
  suffix = ""
)
}
\arguments{
\item{n}{Basic number of tiles (on either side).}

\item{row}{Plot as a row? 
Default: \code{row = TRUE} (else plotted as a column).}

\item{polar}{Plot on polar coordinates? 
Default: \code{polar = FALSE} (i.e., using fixed coordinates).}

\item{pal}{A color palette (automatically extended to \code{n} colors). 
Default: \code{pal = \link{pal_ds4psy}}.}

\item{sort}{Sort tiles? 
Default: \code{sort = TRUE} (i.e., sorted tiles).}

\item{borders}{Add borders to tiles? 
Default: \code{borders = TRUE} (i.e., use borders).}

\item{border_col}{Color of borders (if \code{borders = TRUE}). 
Default: \code{border_col = "black"}.}

\item{border_size}{Size of borders (if \code{borders = TRUE}). 
Default: \code{border_size = 0} (i.e., invisible).}

\item{lbl_tiles}{Add numeric labels to tiles? 
Default: \code{lbl_tiles = FALSE} (i.e., no labels).}

\item{lbl_title}{Add numeric label (of n) to plot? 
Default: \code{lbl_title = FALSE} (i.e., no title).}

\item{rseed}{Random seed (number).
Default: \code{rseed = NA} (using random seed).}

\item{save}{Save plot as png file? 
Default: \code{save = FALSE}.}

\item{save_path}{Path to save plot (if \code{save = TRUE}).
Default: \code{save_path = "images/tiles"}.}

\item{prefix}{Prefix to plot name (if \code{save = TRUE}).
Default: \code{prefix = ""}.}

\item{suffix}{Suffix to plot name (if \code{save = TRUE}).
Default: \code{suffix = ""}.}
}
\description{
\code{plot_n} plots a row or column of \code{n} tiles 
on fixed or polar coordinates.
}
\details{
Note that a polar row makes a tasty pie, 
whereas a polar column makes a target plot.
}
\examples{
# (1) Basics (as ROW or COL): 
plot_n()  # default plot (random n, row = TRUE, with borders, no labels)
plot_n(row = FALSE)  # default plot (random n, with borders, no labels)

plot_n(n = 4, sort = FALSE)      # random order
plot_n(n = 6, borders = FALSE)   # no borders
plot_n(n = 8, lbl_tiles = TRUE,  # with tile + 
       lbl_title = TRUE)         # title labels 

# Set colors: 
plot_n(n = 5, row = TRUE, lbl_tiles = TRUE, lbl_title = TRUE,
       pal = c("orange", "white", "firebrick"),
       border_col = "white", border_size = 2)
  
# Fixed rseed:
plot_n(n = 4, sort = FALSE, borders = FALSE, 
       lbl_tiles = TRUE, lbl_title = TRUE, rseed = 101)

# (2) polar plot (as PIE or TARGET):    
plot_n(polar = TRUE)  # PIE plot (with borders, no labels)
plot_n(polar = TRUE, row = FALSE)  # TARGET plot (with borders, no labels)

plot_n(n = 4, polar = TRUE, sort = FALSE)      # PIE in random order
plot_n(n = 5, polar = TRUE, row = FALSE, borders = FALSE)   # TARGET no borders
plot_n(n = 5, polar = TRUE, lbl_tiles = TRUE)  # PIE with tile labels 
plot_n(n = 5, polar = TRUE, row = FALSE, lbl_title = TRUE)  # TARGET with title label 

# plot_n(n = 4, row = TRUE, sort = FALSE, borders = TRUE,  
#        border_col = "white", border_size = 2, 
#        polar = TRUE, rseed = 132)
# plot_n(n = 4, row = FALSE, sort = FALSE, borders = TRUE,  
#        border_col = "white", border_size = 2, 
#        polar = TRUE, rseed = 134)
 
}
\seealso{
\code{\link{pal_ds4psy}} for default color palette.

Other plot functions: 
\code{\link{plot_charmap}()},
\code{\link{plot_chars}()},
\code{\link{plot_circ_points}()},
\code{\link{plot_fn}()},
\code{\link{plot_fun}()},
\code{\link{plot_text}()},
\code{\link{plot_tiles}()},
\code{\link{theme_clean}()},
\code{\link{theme_ds4psy}()},
\code{\link{theme_empty}()}
}
\concept{plot functions}
