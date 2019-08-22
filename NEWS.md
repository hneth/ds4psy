
# ds4psy News

<!-- Description: --> 

All datasets required for the examples and exercises in the book "Data Science for Psychologists" (by Hansjoerg Neth, Konstanz University, 2019), available at <https://bookdown.org/hneth/ds4psy/>. The book and course introduce principles and methods of data science to students of psychology and other biological or social sciences. The 'ds4psy' package primarily provides datasets, but also functions for graphics and text-manipulation that are used in the book and its exercises. 

## Current development version

The current development version of **ds4psy** (0.1.0.9001+) is hosted at <https://github.com/hneth/ds4psy/>. 

### Major changes 

Changes involving new functionality include:

- added simpler date and time functions (e.g., `cur_date()`, `cur_time()`)  
- added data generation functions (e.g., for `coin()` flips and `dice()` throws)

### Minor changes

- added data generation function `make_grid()` for an exercise on _visual illusions_ (Exercise 6 of Chapter 2)  
- added utility functions `num_as_char()` and `num_as_ordinal()` (to be used in Chapter 11: Functions)  

### Details 

- enhancement: Better documentation of datasets (in `data.R`)  
- bug fix: Removed redundant code (from `plot_fun.R`)    
- bug fix: Removed non-essential packages (from Imports)  

### To do

- add graphical functions for clock plots (including new book chapters)  
- add data with text, date, and time variables  


-------- 

## ds4psy 0.1.0

- Initial release of **ds4psy** (0.1.0) on CRAN: <https://CRAN.R-project.org/package=ds4psy> [2019-08-10] 

### Features

The initial functionality is limited, as the package is designed to support the [ds4psy book](https://bookdown.org/hneth/ds4psy/): 

- re-structured book code (from examples and exercises) as a package
- provides all data sets currently used in the book (with documentation and references)
- provides an initial color scheme and plotting theme
- added plotting functions (e.g., of book graphics) for exploring functions 

---------- 

# ds4psy_book (course and textbook)

This project has not yet been released (on CRAN or GitHub). 

- The current book draft is available at <https://bookdown.org/hneth/ds4psy/>. 

- The current source code of the **ds4psy_book** project (0.0.0.9001+) is hosted at <https://github.com/hneth/ds4psy_book/>. 


## Log of changes made 

New content: 

- added a new exercise on _Visual illusions_ using `make_grid()` function (see Exercise 6 in Chapter 2).  
- added a new exercise on _Printing numbers as characters_ using `num_as_char()` function (see Exercise 6 in Chapter 11).  
- added _A tidyverse caveat_ to Clarifications (see introductory chapter). 

Structure:

- ... 

Details and cosmetics:

- removed WPA abbreviations (for both exercises and solutions)
- made figures smaller (e.g., a maximum of 75% of column width)


## To do

New content: 

- add chapter on _Text strings_ (in Part 2: Data wrangling)
- add chapter on _Dates and times_ (in Part 2: Data wrangling)
- add exercises on function exploration (`plot_fn()` and `plot_fun()`)   
- add exercises on random data generation (`coin()` and `dice()`)  
- add _factors_ to Basics chapter, or a chapter on _Factors_ (in Part 2: Data wrangling) 
- consider making _conditionals_ its own chapter (in Part 3: Programming) 
- emphasize _reproducible research_ aspects in introduction and appendix on R Markdown

Details and cosmetics:

- include _Preparation_ in _Introduction_ sections

<!-- eof. -->
