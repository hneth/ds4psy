
# ds4psy 0.2.1.9001+

<!-- Description: --> 

All datasets and functions required for the examples and exercises of the book "Data Science for Psychologists" (by Hansjoerg Neth, Konstanz University, 2020), available at <https://bookdown.org/hneth/ds4psy/>. The book and course introduce principles and methods of data science to students of psychology and other biological or social sciences. The 'ds4psy' package primarily provides datasets, but also functions for data generation and manipulation (e.g., of text and time data) and graphics that are used in the book and its exercises. All functions included in 'ds4psy' are designed to be instructive and entertaining, rather than elegant or efficient.

<!-- Source code: --> 

The current development version of **ds4psy** (0.2.1.9001+) is hosted at <https://github.com/hneth/ds4psy/>. 

-------- 

# ds4psy 0.3.0

Release of **ds4psy** (0.3.0) on CRAN: <https://CRAN.R-project.org/package=ds4psy>. [2020-06-15] 

This release mainly adds support for text processing. 

## Major changes 

- added functions and datasets for string manipulation and text processing


## Minor changes 

- added `text_to_sentences()` and `text_to_words()` functions for text processing   
- added `count_words()` (in analogy to `count_chars()`) function for text processing  
- added `cclass` (as a named character vector) for matching character classes in regular expressions  
- added `metachar` (as a character vector) for matching meta-characters in regular expressions
- added `Umlaut` (as a named character vector) for showing and selecting German Umlaut characters    
- added datasets of `countries`, `fruits`, and `flowery` phrases (as character vectors)   
- added datasets of `Bushisms` and `Trumpisms` (as character vectors)  
- added `sample_char()` function


## Details 

- renamed `count_char()` to `count_chars()` (to use plural form) 
- renamed `sample_date()` and `sample_time()` (to use singular form)  
- renamed family of `text functions` to `text objects and functions`  
- renamed family of `random functions` to `sampling functions`  


## To do

Critical:

- none. 

Optional:

- add graphical functions for _clock plots_ (including new book chapters)  
- create a ds4psy survey (to collect user data for additional examples)
- add more data with text, date, and time variables  
- add an _ascii art_ option for converting strings or text into tile plots (with colored tiles) 


-------- 

# ds4psy 0.2.1

Release of **ds4psy** (0.2.1) on CRAN: <https://CRAN.R-project.org/package=ds4psy>. [2020-05-06] 

This is a **maintenance release** to remove some dependencies, fix bugs on CRAN platforms, and add some datasets. 

## Major changes 

- removed dependencies on the `here` and `tibble` packages 
  (and removed these packages from declared Imports). 

## Minor changes

- added 4 messy table versions of ficticious experiment data (used in 
*Exercise 1* of *Chapter 7: Tidying data* _Four messes and one tidy table_) to the package: 
`t_1`--`t_4`. 

## Details 

- bug fix: Replaced `what_day` with a simpler version that omits `unit` and `as_integer` arguments 
(to avoid WARN on CRAN for `r-devel-linux-x86_64-debian-clang`)
- bug fix: Removed `.data$...` elements from `aes()` in `ggplot` calls 
- bug fix: Added `utils::globalVariables(...)` to avoid Warning NOTE "Undefined global functions or variables"
- bug fix: Removed packages not used in this version (i.e., `dplyr`, and `magrittr`) from declared Imports 


-------- 

# ds4psy 0.2.0

Release of **ds4psy** (0.2.0) on CRAN: <https://CRAN.R-project.org/package=ds4psy>. [2020-04-20] 

## Major changes 

Changes involving new functionality include:

- added random data generation functions (e.g., for `coin()` flips and `dice()` throws)
- added `is.wholenumber()` to test for integer values (mentioned in R oddities)
- added `plot_text()` plotting function  
- added `read_ascii()` and `count_chars()` functions for text processing 
- added `caseflip()` and `capitalize()` functions for text processing 
- added random date and time generation functions (e.g., for `sample_date()` and `sample_time()`) 
- added simple date and time functions (e.g., `cur_date()`, `cur_time()`, for Chapter 10: Time data) 
- added `what_` functions for simple date and time queries (for Chapter 10: Time data) 

## Minor changes

- added data generation function `make_grid()` for an exercise on _visual illusions_ (Exercise 6 of Chapter 2)  
- added `fame` dataset to illustrate working with dates (Exercise 3 of Chapter 10) 
- added utility functions `num_as_char()` and `num_as_ordinal()` (to be used in Chapter 11: Functions)  

## Details 

- added documentations of datasets (in `data.R`)  
- bug fix: Removed redundant code (from `plot_fun.R`)    
- bug fix: Removed packages not used in this version (i.e., `readr`, `stringr`, `tidyr`, and `tidyverse`) from declared Imports


-------- 

# ds4psy 0.1.0

Initial release of **ds4psy** (0.1.0) on CRAN: <https://CRAN.R-project.org/package=ds4psy>. [2019-08-10] 

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

- The current source code of the **ds4psy_book** project (0.0.0.9001+) is hosted at <https://github.com/hneth/ds4psy> (with an additional suffix `_book`). 


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
- included _Preparation_ sections within _Introduction_ sections
- use **unikn** color schemes (in most places)


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

- use a unified theme template for all plots  


[File `News.md` updated on 2020-06-14.]

<!-- eof. -->
