
# ds4psy 0.1.0.9010+

The current development version of **ds4psy** (0.1.0.9000+) is hosted at <https://github.com/hneth/ds4psy/>. 

<!-- Description: --> 

All datasets and functions required for the examples and exercises of the book "Data Science for Psychologists" (by Hansjoerg Neth, Konstanz University, 2019), available at <https://bookdown.org/hneth/ds4psy/>. The book and course introduce principles and methods of data science to students of psychology and other biological or social sciences. The 'ds4psy' package primarily provides datasets, but also functions for data generation and manipulation (e.g., of text and time data) and graphics that are used in the book and its exercises. All functions included in 'ds4psy' are designed to be instructive and entertaining, rather than elegant or efficient.

## Major changes 

Changes involving new functionality include:

- added `plot_text()` plotting function  
- added `read_ascii()` and `count_char()` text processing functions 
- added simple date and time functions (e.g., `cur_date()`, `cur_time()`)  
- added random data generation functions (e.g., for `coin()` flips and `dice()` throws)
- added random date and time generation functions (e.g., for `sample_dates()` and `sample_times()`)
- added `is.wholenumber()` to test for integer values (mentioned in R oddities)  
- added `cur_` and `what_` functions for simple date and time queries (for Chapter 10: Time data) 

## Minor changes

- added data generation function `make_grid()` for an exercise on _visual illusions_ (Exercise 6 of Chapter 2)  
- added `fame` dataset to illustrate working with dates (Exercise 3 of Chapter 10) 
- added utility functions `num_as_char()` and `num_as_ordinal()` (to be used in Chapter 11: Functions)  

## Details 

- added documentation of datasets (in `data.R`)  
- bug fix: Removed redundant code (from `plot_fun.R`)    
- bug fix: Removed non-essential packages (from Imports)  

## To do

- add graphical functions for _clock plots_ (including new book chapters)  
- create ds4psy survey (to collect user data for examples)
- add data with text, date, and time variables  
- add an _ascii art_ option for converting strings or text into tile plots (with colored tiles)  

-------- 

# ds4psy 0.1.0

- Initial release of **ds4psy** (0.1.0) on CRAN: <https://CRAN.R-project.org/package=ds4psy> [2019-08-10] 

## Features

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
- added exercises on function exploration (`plot_fn()` and `plot_fun()`) to Chapter 1: Exploring functions.
- added `fame` data (for Exercise 3 in Chapter 10: Time data)

Structure:

- ... 

Details and cosmetics:

- removed WPA abbreviations (for both exercises and solutions)
- made figures smaller (e.g., a maximum of 75% of column width)

## To do

New content: 

- add exercises on random data generation (`coin()` and `dice()`) to Chapter 1 or 11: Functions? 

- add _factors_ to Basics chapter, or a chapter on _Factors_ (in Part 2: Data wrangling) 
- add chapter on _Text strings_ (in Part 2: Data wrangling)
- add chapter on _Dates and times_ (in Part 2: Data wrangling)
- consider making _conditionals_ its own chapter (in Part 3: Programming) 
- emphasize _reproducible research_ aspects in introduction and appendix on R Markdown
- add appendix on _R oddities_

Details and cosmetics:

- include _Preparation_ sections within _Introduction_ sections

<!-- eof. -->
