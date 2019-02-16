
<!-- README.md is generated from README.Rmd. Please edit THIS file -->
ds4psy
======

Data science for psychologists
------------------------------

A course on the principles and basic methods of data science for students of psychology and social sciences.

Course Coordinates
------------------

<!-- uni.kn logo and link to SPDS: -->
<!-- ![](./inst/pix/uniKn_logo.png) -->
<a href="https://www.spds.uni-konstanz.de/"> <img src = "./inst/pix/uniKn_logo.png" alt = "spds.uni.kn" align = "right" width = "300" style = "width: 300px; float: right; border:20;"/> <!-- <img src = "./inst/pix/uniKn_logo_s.png" alt = "spds.uni.kn" style = "float: right; border:20;"/> --> </a>

-   Taught at the [University of Konstanz](https://www.uni-konstanz.de/) by [Hansjörg Neth](http://neth.de/) (<h.neth@uni.kn>, [SPDS](https://www.spds.uni-konstanz.de/), office D507).

-   Spring/summer 2018: Mondays, 13:30-15:00, C511 (from 2018.04.16 to 2018.07.16)
-   Links to [ZeUS](https://zeus.uni-konstanz.de:443/hioserver/pages/startFlow.xhtml?_flowId=showEvent-flow&unitId=5101&termYear=2018&termTypeValueId=1&navigationPosition=hisinoneLehrorganisation,examEventOverviewOwn) and [Ilias](https://ilias.uni-konstanz.de/ilias/goto_ilias_uni_crs_758039.html)

-   Winter/spring 2019: Mondays, 13:30-15:00, C511 (from 2018.10.22 to 2019.02.11)
-   Links to current [course syllabus](http://rpository.com/ds4psy/) | [ZeUS](https://zeus.uni-konstanz.de/hioserver/pages/startFlow.xhtml?_flowId=detailView-flow&unitId=5101&periodId=78&navigationPosition=hisinoneLehrorganisation,examEventOverviewOwn) | [Ilias](https://ilias.uni-konstanz.de/ilias/goto_ilias_uni_crs_809936.html)

Course Description
------------------

### Overview

Students of psychology and other social sciences are trained to analyze data. But the data they learn to work with (e.g., in courses on statistics and empirical research methods) is typically provided to them and structured in a (rectangular or "tidy") format that presupposes many steps of data processing regarding the aggregation and spatial layout of variables. When beginning to collect their own data, students inevitably struggle with these pre-processing steps which --- even for experienced data scientists --- tend to require more time and effort than choosing and conducting statistical tests.

This course develops the foundations of data analysis that allow students to collect data from real-world sources and transform and shape such data to answer scientific and practical questions. Although there are many good introductions to data science (we use [Grolemund & Wickham, 2017](http://r4ds.had.co.nz/)) they typically do not take into account the special needs (and often anxieties and reservations) of psychology students. As social scientists are not computer scientists, we introduce new concepts and commands without assuming a mathematical or computational background. Adopting a task-oriented perspective, we begin with a specific problem and then solve it with some combination of data collection, manipulation, modeling, and visualization.

### Goals

Our main goal is to develop a set of useful skills in analyzing real-world data and conducting reproducible research. Upon completing this course, you will be able to read, transform, analyze, and visualize data of various types. Many interactive exercises will allow students to continuously check their understanding, practice their skills, and monitor their progress.

### Requirements

This course assumes some basic familiarity with statistics and the [R](http://www.r-project.org/) programming language, but enthusiastic programming novices are also welcome.

### Assessment

Weekly exercises, mid-term test, and final test or project (to be discussed with instructor).

References
----------

### Textbook

-   Wickham, H., & Grolemund, G. (2017). *R for data science: Import, tidy, transform, visualize, and model data.* Sebastopol, Canada: O'Reilly Media, Inc. \[Available online at <http://r4ds.had.co.nz>.\]

### Software

-   [The R Project for Statistical Computing](http://www.r-project.org/)

-   [R Studio](http://www.rstudio.com/) is an integrated development environment (IDE) for R.

-   R packages of the [tidyverse](https://www.tidyverse.org/) and some data packages:

``` r
# R packages:
install.packages("tidyverse")

# Additional data packages:
install.packages("nycflights13", "gapminder", "Lahman", "babynames", "fueleconomy")
```

### Other resources

#### Course essentials and exercises (WPAs)

<!-- Table with links: -->
All [ds4psy](http://rpository.com/ds4psy/) essentials so far:

|  Nr.| Topic                                                                               |
|----:|:------------------------------------------------------------------------------------|
|   0.| [Syllabus](http://rpository.com/ds4psy/)                                            |
|   1.| [Basic R concepts and commands](http://rpository.com/ds4psy/essentials/basics.html) |
|   2.| [Visualizing data](http://rpository.com/ds4psy/essentials/visualize.html)           |
|   3.| [Transforming data](http://rpository.com/ds4psy/essentials/transform.html)          |
|   4.| [Exploring data (EDA)](http://rpository.com/ds4psy/essentials/explore.html)         |
|   5.| [Tibbles](http://rpository.com/ds4psy/essentials/tibbles.html)                      |
|   6.| [Importing data](http://rpository.com/ds4psy/essentials/import.html)                |
|   7.| [Tidying data](http://rpository.com/ds4psy/essentials/tidy.html)                    |
|   8.| [Joining data](http://rpository.com/ds4psy/essentials/join.html)                    |
|   9.| [Functions](http://rpository.com/ds4psy/essentials/function.html)                   |
|   +.| [Datasets](http://rpository.com/ds4psy/essentials/datasets.html)                    |

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
+.  | [Datasets](http://rpository.com/ds4psy/essentials/datasets.html) | 
-->
#### Online

-   [RStudio cheat sheets](https://www.rstudio.com/resources/cheatsheets/)

-   Further resources on the [tidyverse](https://www.tidyverse.org/):
    -   See <https://www.tidyverse.org/articles/> for current developments
    -   See <https://www.tidyverse.org/learn/> for learning resources
-   See also collection of links on <http://rpository.com/findr/>

#### Other scripts and books

-   [R manuals](https://cran.r-project.org/manuals.html) and related [books](https://www.r-project.org/doc/bib/R-books.html)

-   Free books on R and data science on <https://bookdown.org/>

-   Zumel, N., & Mount, J. (2014). *Practical data science with R*. Greenwich, CT: Manning Publications.

<!-- Update: -->
\[Updated 2019-02-16 by [hn](https://neth.de).\]

<!-- eof -->