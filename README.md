
<!-- README.md is generated from README.Rmd. Please edit THIS (Rmd) file. -->
<!-- Use status badges: 

[![CRAN_status](http://www.r-pkg.org/badges/version/ds4psy)](https://CRAN.R-project.org/package=ds4psy) 
[![Downloads](http://cranlogs.r-pkg.org/badges/ds4psy?color=brightgreen)](http://www.r-pkg.org/pkg/ds4psy) 

-->
<!-- Possible status badges:

[![CRAN_status](http://www.r-pkg.org/badges/version/ds4psy)](https://CRAN.R-project.org/package=ds4psy) 
[![Build_status](https://travis-ci.org/hneth/ds4psy.svg?branch=master)](https://travis-ci.org/hneth/ds4psy) 
[![Downloads](http://cranlogs.r-pkg.org/badges/ds4psy?color=brightgreen)](http://www.r-pkg.org/pkg/ds4psy)
[![Downloads](http://cranlogs.r-pkg.org/badges/grand-total/ds4psy?color=brightgreen)](http://www.r-pkg.org/pkg/ds4psy)
[![Rdoc](http://www.rdocumentation.org/badges/version/ds4psy)](http://www.rdocumentation.org/packages/ds4psy)

-->
<!-- ds4psy logo 1: -->
<a href="https://bookdown.org/hneth/ds4psy/"> <img src = "./inst/images/ds4psy.png" alt = "ds4psy" width = "150px" align = "right" style = "width: 150px; float: right; border:11;"/> </a>

Data Science for Psychologists (ds4psy)
=======================================

Welcome to the R package **ds4psy** — a software companion to the book and course</br> [Data Science for Psychologists](https://bookdown.org/hneth/ds4psy/).

This R package provides datasets and functions used in the [ds4psy book](https://bookdown.org/hneth/ds4psy/) and course.
The book and course introduce the principles and methods of data science for students of psychology and other biological or social sciences.

<!-- Description of ds4psy package:  -->
<!-- All datasets and functions required for the examples and exercises of the book "Data Science for Psychologists" (by Hansjoerg Neth, Konstanz University, 2019), available at <https://bookdown.org/hneth/ds4psy/>. The book and course introduce principles and methods of data science to students of psychology and other biological or social sciences.  -->
<!-- The 'ds4psy' package primarily provides datasets, but also functions for data generation and manipulation (e.g., of text and time data) and graphics that are used in the book and its exercises.  -->
<!-- All functions included in 'ds4psy' are designed to be instructive and entertaining, rather than elegant or efficient. -->
Installation
------------

The current release of **ds4psy** is available from [CRAN](https://CRAN.R-project.org/) at <https://CRAN.R-project.org/package=ds4psy>:

``` r
install.packages('ds4psy')  # install ds4psy from CRAN client
library('ds4psy')           # load to use the package
```

The current development version of **ds4psy** can be installed from its [GitHub](https://github.com) repository at <https://github.com/hneth/ds4psy/>:

``` r
# install.packages('devtools')  # (if not installed yet)
devtools::install_github('hneth/ds4psy')
library('ds4psy')  # load to use the package
```

The most recent version of the [ds4psy book](https://bookdown.org/hneth/ds4psy/) is available at <https://bookdown.org/hneth/ds4psy/>.

Course Coordinates
------------------

<!-- uni.kn logo, but link to SPDS: -->
<!-- ![](./inst/images/uniKn_logo.png) -->
<a href="https://www.spds.uni-konstanz.de/"> <img src = "./inst/images/uniKn_logo.png" alt = "spds.uni.kn" width = "300px" align = "right" style = "width: 300px; float: right; border:20;"/> </a>

-   PSY-15150, at the [University of Konstanz](https://www.uni-konstanz.de/) by [Hansjörg Neth](https://neth.de/) (<h.neth@uni.kn>, [SPDS](https://www.spds.uni-konstanz.de/), office D507).
-   Summer 2020: Mondays, 13:30–15:00, D522/online.
-   The [ds4psy book](https://bookdown.org/hneth/ds4psy/) with examples and weekly programming exercises (WPAs) is available at <https://bookdown.org/hneth/ds4psy/>.
-   The R package [ds4psy](https://CRAN.R-project.org/package=ds4psy) is available at <https://CRAN.R-project.org/package=ds4psy>.

Description
-----------

This book and course provide an introduction to data science that is tailored to the needs of psychologists, but is also suitable for students of the humanities and other biological or social sciences. This audience typically has some knowledge of statistics, but rarely an idea how data is prepared and shaped to allow for statistical testing. By using various data types and working with many examples, we teach tools for transforming, summarizing, and visualizing data. By keeping our eyes open for the perils of misleading representations, the book fosters fundamental skills of data literacy and cultivates reproducible research practices that enable and precede any practical use of statistics.

### Audience

Students of psychology and other social sciences are trained to analyze data. But the data they learn to work with (e.g., in courses on statistics and empirical research methods) is typically provided to them and structured in a (rectangular or "tidy") format that presupposes many steps of data processing regarding the aggregation and spatial layout of variables. When beginning to collect their own data, students inevitably struggle with these pre-processing steps which — even for experienced data scientists — tend to require more time and effort than choosing and conducting statistical tests.

This course develops the foundations of data analysis that allow students to collect data from real-world sources and transform and shape such data to answer scientific and practical questions. Although there are many good introductions to data science (e.g., [Grolemund & Wickham, 2017](http://r4ds.had.co.nz/)) they typically do not take into account the special needs — and often anxieties and reservations — of psychology students. As social scientists are not computer scientists, we introduce new concepts and commands without assuming a mathematical or computational background. Adopting a task-oriented perspective, we begin with a specific problem and then solve it with some combination of data collection, manipulation, and visualization.

### Goals

Our main goal is to develop a set of useful skills in analyzing real-world data and conducting reproducible research. Upon completing this course, you will be able to use R to read, transform, analyze, and visualize data of various types. Many interactive exercises allow students to continuously check their understanding, practice their skills, and monitor their progress.

### Requirements

This course assumes some basic familiarity with statistics and the [R](https://www.R-project.org/) programming language, but enthusiastic programming novices are also welcome.

Resources
---------

This package and the corresponding book are still being developed and are updated as new materials become available.

-   A current version of the book is available at <https://bookdown.org/hneth/ds4psy/>.

-   There are 2 GitHub repositories to be distinguished:

    -   The repository for the [ds4psy book](https://bookdown.org/hneth/ds4psy/) is <https://github.com/hneth/ds4psy> (with an additional suffix `_book`).

    -   The repository for the [ds4psy package](https://CRAN.R-project.org/package=ds4psy) is <https://github.com/hneth/ds4psy>.

<!-- - The current course syllabus and raw versions of all data files used in examples and exercises are available at <http://rpository.com/ds4psy/>. -->
References
----------

### Course materials

-   A current version of [Data science for psychologists](https://bookdown.org/hneth/ds4psy/) is available online at
    <https://bookdown.org/hneth/ds4psy/>.

The script was originally based on the following textbook:

-   Wickham, H., & Grolemund, G. (2017). *R for data science: Import, tidy, transform, visualize, and model data.* Sebastopol, Canada: O'Reilly Media, Inc. \[Available online at <http://r4ds.had.co.nz>.\]

### Software

Please install the following open-source programs on your computer:

-   [The R Project for Statistical Computing](https://www.R-project.org/)

-   [R Studio](http://www.rstudio.com/) is an integrated development environment (IDE) for R.

-   R packages of the [tidyverse](https://www.tidyverse.org/), [ds4psy](https://CRAN.R-project.org/package=ds4psy), and [unikn](https://CRAN.R-project.org/package=unikn):

``` r
# Tidyverse packages: 
install.packages("tidyverse")

# Course packages: 
install.packages("ds4psy", "unikn")

# Additional data packages (optional): 
install.packages("nycflights13", "babynames", "fueleconomy")
```

### Other resources

<!-- #### Course essentials and exercises (WPAs) -->
<!-- ds4psy logo: -->
<a href="https://bookdown.org/hneth/ds4psy/"> <img src = "./inst/images/ds4psy.png" alt = "ds4psy" width = "150px" align = "right" style = "width: 150px; float: right; border:11;"/> </a>

<!-- Table with links: -->
<!-- All [ds4psy](http://rpository.com/ds4psy/) essentials (from) previous courses):  -->
<!--
Nr. | Topic       |
---:|:------------| 
0.  | [Syllabus](http://rpository.com/ds4psy/) | 
1.  | [Basic R concepts and commands](http://rpository.com/ds4psy/essentials/basics.html) | 
2.  | [Visualizing data](http://rpository.com/ds4psy/essentials/visualize.html) | 
3.  | [Transforming data](http://rpository.com/ds4psy/essentials/transform.html) |
4.  | [Exploring data (EDA)](http://rpository.com/ds4psy/essentials/explore.html) | 
5.  | [Tibbles](http://rpository.com/ds4psy/essentials/tibbles.html) |
6.  | [Importing data](http://rpository.com/ds4psy/essentials/import.html) |
7.  | [Tidying data](http://rpository.com/ds4psy/essentials/tidy.html) |
8.  | [Joining data](http://rpository.com/ds4psy/essentials/join.html) |
9.  | [Functions](http://rpository.com/ds4psy/essentials/function.html) |
10. | [Iteration](http://rpository.com/ds4psy/essentials/iteration.html) |
+.  | [Datasets](http://rpository.com/ds4psy/essentials/datasets.html) | 
-->
#### Online

-   [RStudio cheat sheets](https://www.rstudio.com/resources/cheatsheets/)

-   Further resources on the [tidyverse](https://www.tidyverse.org/):
    -   See <https://www.tidyverse.org/articles/> for current developments
    -   See <https://www.tidyverse.org/learn/> for learning resources
-   See also the link collections at the end of each chapter of the [ds4psy book](https://bookdown.org/hneth/ds4psy/).

#### R manuals and books

-   [R manuals](https://cran.r-project.org/manuals.html) and related [books](https://www.r-project.org/doc/bib/R-books.html)

-   See the free books on R and data science on <https://bookdown.org/>

<!-- - Zumel, N., & Mount, J. (2014). _Practical data science with R_. Greenwich, CT: Manning Publications. -->
About
-----

If you find these materials useful, or want to adopt or alter them for your purposes, please [let me know](https://www.spds.uni-konstanz.de/hans-neth).

### Citation

To cite **ds4psy** in derivations and publications, please use:

-   Neth, H. (2020). ds4psy: Data Science for Psychologists.
    Social Psychology and Decision Sciences, University of Konstanz, Germany.
    Textbook and R package (version 0.2.0, April 20, 2020).
    Retrieved from <https://bookdown.org/hneth/ds4psy/>.

A **BibTeX** entry for LaTeX users is:

``` text
@Manual{ds4psy,
  title = {ds4psy: Data Science for Psychologists},
  author = {Hansjörg Neth},
  year = {2020},
  organization = {Social Psychology and Decision Sciences, University of Konstanz},
  address = {Konstanz, Germany},
  note = {Textbook and R package (version 0.2.0, April 20, 2020)},
  url = {https://bookdown.org/hneth/ds4psy/} 
}
```

The URL of the **ds4psy** R package is <https://CRAN.R-project.org/package=ds4psy>.

### License

<!-- (a) Use online image: -->
<!-- <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a> -->
<!-- (b) Use local image: -->
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src = "./images/CC_BY_NC_SA.png" /></a>

<!-- License text:  -->
<span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">**Data science for psychologists** (**ds4psy**)</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://neth.de" property="cc:attributionName" rel="cc:attributionURL">Hansjörg Neth</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.

<!-- Update: -->
\[Updated 2020-04-22 by [hn](https://neth.de).\]

<!-- eof. -->
