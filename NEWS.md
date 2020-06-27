
# ds4psy 0.3.0.9001+

<!-- Description: --> 

All datasets and functions required for the examples and exercises of the book "Data Science for Psychologists" (by Hansjoerg Neth, Konstanz University, 2020), available at <https://bookdown.org/hneth/ds4psy/>. The book and course introduce principles and methods of data science to students of psychology and other biological or social sciences. The 'ds4psy' package primarily provides datasets, but also functions for data generation and manipulation (e.g., of text and time data) and graphics that are used in the book and its exercises. All functions included in 'ds4psy' are designed to be instructive and entertaining, rather than elegant or efficient.

<!-- Links: --> 

- The most recent release of **ds4psy** (0.3.0) is available from CRAN: <https://CRAN.R-project.org/package=ds4psy>.

- The current development version of **ds4psy** (0.3.0.9001+) is hosted at <https://github.com/hneth/ds4psy/>. 

- The textbook **Data Science for Psychologists** is hosted at <https://bookdown.org/hneth/ds4psy/>.


## Major changes 

- Provide better support for date and time data: 

    - Key date and time functions now include options for returning dates or times, rather than formatted strings.
    - `what_date()` and `what_time()` support time zones `tz`.

## Minor changes 

- `cur_date()` and `cur_time()` now print date/time (as string) or return a "Date"/"POSIXct" object.  
- `what_date()` and `what_time()` gain support for adding time zones `tz` (but no active conversion). 
- `sample_time()`: Switch default to sampling "POSIXct" objects (making "POSIXlt" optional) and allow specifying time zones `tz`.  
- All date and time functions based primarily on dates (`cur_date()`, `what_date()`, etc.) now use `Sys.Date()` (i.e., an object of class "Date") rather than `Sys.time()` (i.e., a "POSIXct" calendar time) as defaults. 

## Details 

- bug fix: Distinguish `is.wholenumber()` from `is.integer()`  
- bug fix: Use `\u...` rather than `\U...` in `Umlaut` definitions  
- bug fix: Removed non-ASCII characters from `fruits` and `flowery`  


## To do

Critical:

- none 

Current:

- add `convert_date()` and `convert_time()` functions for converting dates/times from current into other time zones `tz`  
- return (invisible) dates and times (rather than format strings) in all date and time functions 

Optional:

- add graphical functions for _clock plots_ (including new book chapters)  
- create a ds4psy survey (to collect user data for additional examples)
- add more data with text, date, and time variables  
- add an _ascii art_ option for converting strings or text into tile plots (with colored tiles) 

-------- 

# ds4psy 0.3.0

Release of **ds4psy** (0.3.0) on CRAN: <https://CRAN.R-project.org/package=ds4psy>. [2020-06-15] 

This release adds support for text processing. 


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

- added Travis integration to `README.Rmd` 
- renamed `count_char()` to `count_chars()` (to use plural form) 
- renamed `sample_date()` and `sample_time()` (to use singular form)  
- renamed family of `text functions` to `text objects and functions`  
- renamed family of `random functions` to `sampling functions`  


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

[File `News.md` updated on 2020-06-27.]

<!-- eof. -->
