
# Data Science for Psychologists (ds4psy)

<!-- Description: --> 

All datasets and functions required for the examples and exercises of the books 
[Data Science for Psychologists](https://bookdown.org/hneth/ds4psy/) and 
[Introduction to Data Science](https://bookdown.org/hneth/i2ds/) 
(by Hansjoerg Neth, Konstanz University, 2025), 
freely available at <https://bookdown.org/hneth/ds4psy/> and <https://bookdown.org/hneth/i2ds/>. 

These books and corresponding courses introduce principles and methods of data science to students of psychology and other biological or social sciences. 
The R package **ds4psy** primarily provides datasets, but also functions for data generation and manipulation (e.g., of text and time data) and graphics that are used in the book and its exercises. 
All functions included in **ds4psy** are designed to be explicit and instructive, rather than efficient or elegant. 

<!-- ds4psy logo 1: -->
<a href="https://bookdown.org/hneth/ds4psy/">
<img src = "./inst/images/logo.png" alt = "ds4psy" width = "150px" align = "right" style = "width: 150px; float: right; border:11;"/>
</a>


## Overview {-}

The books and courses [Data Science for Psychologists](https://bookdown.org/hneth/ds4psy/) include the following resources:

<!-- Links: --> 

- The textbook **Data Science for Psychologists** is hosted at <https://bookdown.org/hneth/ds4psy/>. 
- The textbook **Introduction to Data Science** is hosted at <https://bookdown.org/hneth/i2ds/>. 
- The most recent release of **ds4psy** (1.1.0) is available on CRAN: <https://CRAN.R-project.org/package=ds4psy>.
- The current development version of **ds4psy** (1.1.0.9001+) is hosted at <https://github.com/hneth/ds4psy/>. 

<!-- Current version:  --> 


-------- 


# ds4psy 1.1.0.9004

This is the current development version of **ds4psy** hosted at <https://github.com/hneth/ds4psy/>. 
[2025-09-28]

<!-- Log of changes: --> 


**Changes** since last release: 


<!-- major: --> 

## Major changes

- none yet


<!-- minor: --> 

## Minor changes

- Fix bugs in `i2ds_survey` data:
    - Add variable names to art preference tasks 
    - Reverse scale in ranking of food items (e.g., apple, ..., mud)


<!-- details: --> 

## Details

- Improve documentation:
  - Enumerate and re-arrange variables in `i2ds_survey` data 
  - Update online documentation


<!-- ## ToDo --> 

<!-- Changes to be implemented prior to the next release: --> 

<!-- - improve `base2dec()` and `dec2base()` functions (e.g., with recursive and vectorized versions). --> 

<!-- - split the mixed functionality of `plot_text()` into 2 functions: --> 

<!-- 1. Combine `count_chars_words()` with `map_text_coord()` or `map_text_regex()` 
    to create a df with two color vectors (fg/bg) based on `char_freq` and/or `word_freq`. --> 
    
<!-- 2. `plot_charmap()` directly plots the resulting df. --> 


<!-- Development version: --> 

<!-- The current development version of **ds4psy** is hosted at <https://github.com/hneth/ds4psy/>. --> 



<!-- Published versions: --> 

<!-- Versions of **ds4psy** published on [on CRAN](https://CRAN.R-project.org/package=ds4psy): --> 


-------- 

# ds4psy 1.1.0

Release of **ds4psy** (1.1.0) [on CRAN](https://CRAN.R-project.org/package=ds4psy) 
adds functionality, provides new data, and fixes some bugs. [2025-09-13]

<!-- Log of changes: --> 

**Changes** since last release: 


## Major changes

- add `i2ds_survey` data (36 participants/rows, 112 variables)
- add `plot_circ_points()` function 


## Minor changes

- change `gender` in  `exp_num_dt` into a binary variable (with values "female" vs. "not female")
- add `deg2rad()` and `rad2deg()` conversion functions 


## Details

- new logo


-------- 

# ds4psy 1.0.0

Release of **ds4psy** (1.0.0) [on CRAN](https://CRAN.R-project.org/package=ds4psy) fixes some bugs, 
but mostly acknowledges the package's stable state. [2023-09-15]

<!-- Log of changes: --> 

**Changes** since last release: 


## Minor changes 

- bug fix: Update time zones

## Details 

- update status badges
- update URLs


<!-- Development version: -->

The current development version of **ds4psy** is hosted at <https://github.com/hneth/ds4psy/>.


-------- 

# ds4psy 0.9.0

<!-- Release version: --> 

Release of **ds4psy** (0.9.0) [on CRAN](https://CRAN.R-project.org/package=ds4psy) adds functionality, implements minor changes, and fixes some bugs. [2022-10-20]

<!-- Log of changes: --> 

**Changes** since last release: 

## Major changes 

- add `base2dec()` and `dec2base()` functions for converting numerals into non-decimal notations, and back. 
- add `chars_to_text()` and `text_to_chars()` functions for converting character vectors into text, and back. 
 
## Minor changes 

- add `rseed` argument to `map_text_regex()` and `plot_chars()` for reproducible results. 
- add `collapse_chars()` as a wrapper around `paste()` with a `collapse` argument. 
- rearrange contents (by creating dedicated utility files). 

## Details 

- fix minor bugs. 
- add Zenodo doi [10.5281/zenodo.7229812](https://doi.org/10.5281/zenodo.7229812) for citations. 



<!-- ToDo -->

<!-- Changes to be implemented prior to the next release: -->

<!-- - split the mixed functionality of `plot_text()` into 2 functions:  --> 

<!--     1. Combine `count_chars_words()` with `map_text_coord()` or `map_text_regex()`  --> 
<!--     to create a df with 2 color vectors (fg/bg) based on `char_freq` and/or `word_freq`.  --> 
    
<!--     2. `plot_charmap()` directly plots the resulting df.  --> 


<!-- Previous CRAN releases:  --> 

-------- 

# ds4psy 0.8.0

<!-- Release version: --> 

Release of **ds4psy** (0.8.0) [on CRAN](https://CRAN.R-project.org/package=ds4psy) 
adds functionality, increases modularity, and fixes some bugs. [2022-04-08] 

<!-- Log of changes: --> 

**Changes** since last release: 

## Major changes 

- add a `invert_rules()` function (for decoding encoded messages by inverting the rules used for encoding). 
- add a `words_to_text()` function as the inverse of `text_to_words()`. 
- add a `zodiac()` function (with multiple outputs formats and options for redefining date boundaries). 

<!-- Blank line. --> 

## Minor changes 

- add `table9` as a variant of `tidyr::table2` as a 3-dimensional array (xtabs). 
- improved `capitalize()` to also work for character vectors (i.e., setting the case of each element to upper- or lowercase). 

<!-- Blank line. --> 

## Details 

- fix minor bugs.  

<!-- Previous CRAN releases:  --> 

-------- 

# ds4psy 0.7.0

Release of **ds4psy** (0.7.0) [on CRAN](https://CRAN.R-project.org/package=ds4psy) 
adds functionality, increases modularity, and fixes a bug in text data. [2021-05-12] 

<!-- Log of changes: --> 

**Changes** since last release: 

## Major changes 

- Breaking change: The function `read_ascii()` was split into 2\ parts (to enable independent access to their functionality): 

    1. A new `read_ascii()` version reads text (from file or user input) into a character string;  
    2. A new `map_text_coord()` function converts a text string into a table of individual characters (with x/y-coordinates).  

<!-- Blank line. --> 

- Added `plot_chars()` for plotting characters of text and visualizing pattern matches (specified as regular expressions) by highlighting labels (color/angle) or background tiles (color). The function uses 2\ auxiliary functions: 

    1. `map_text_regex()` adds pattern matching options (for colors and angles) to `map_text_coord()`.  
    2. `plot_charmap()` plots character maps as text and tile plots (with aesthetics for labels and tiles).  

<!-- Blank line. --> 

- Added `count_chars_words()` for counting the frequency of both characters and words in text strings.  


## Minor changes 

- add `plot_mar` argument to `theme_empty()` 
- add functionality to `plot_text()` (but see `plot_chars()`) 
- add utility functions for locating, identifying, and assigning vectors (of color/angle maps) to text strings matching a pattern 
- add `text_to_chars()` and related functions for converting character strings (e.g., text to characters, preserving spaces) 
- add utility functions for counting the frequency of characters and words in text strings 
- rename `is_vector()` to `is_vect()` as an `is_vector()` function is defined by the **purrr** package 


## Details 

- signal deprecation status in `plot_text()`   
- bug fix: remove marked UTF-8 strings from `Trumpisms` 

<!-- Note:  --> 

The current development version of **ds4psy** is hosted at <https://github.com/hneth/ds4psy/>. 

<!-- Latest CRAN release:  --> 

-------- 

# ds4psy 0.6.0

Release of **ds4psy** (0.6.0) [on CRAN](https://CRAN.R-project.org/package=ds4psy) 
adds functionality, updates data, and reduces dependencies. [2021-04-08] 

<!-- Log of changes: --> 

**Changes** since last release: 

## Major changes 

- add `is_vector()` to check for vectors (i.e., atomic vectors or lists)
- add `get_set()` for motivating visualizations 

<!-- Blank line. --> 

## Minor changes 

- update data in `fame` and `Trumpisms` 

<!-- Blank line. --> 

## Details 

- remove import of **cowplot** by adding `theme_empty()` 
- reduce reliance on **unikn** by replacing some colors with corresponding HEX codes 

<!-- Previous release:  --> 

-------- 

# ds4psy 0.5.0

Release of **ds4psy** (0.5.0) [on CRAN](https://CRAN.R-project.org/package=ds4psy) 
adds and revises functionality, updates data, and fixes bugs. [2020-09-01] 

**Changes** since last release:

## Major changes 

- Additional functions for **dates** and **times**:

    - add `diff_dates()` to compute temporal differences between dates (in human time units of years, months, and days) 
    - add `diff_times()` to compute temporal differences between times (in human time units of years, ..., and seconds) 
    - add `diff_tz()` to compute time difference based on time zone differences  
    - add `days_in_month()` to obtain number of days in months for given dates (accounting for leap years)  
    
<!-- Blank line. --> 

- add `is_equal()` and `num_equal()` to check pairwise (near) equality of vectors  
- add `theme_clean()` as an alternative to `theme_ds4psy()`  

<!-- Blank line. --> 

## Minor changes 

- rename `is.wholenumber()` to `is_wholenumber()`  
- revise arguments of `sample_date()` and `sample_time()` to align with `sample()` 
- revise `theme_ds4psy()` to provide control over colors of backgrounds, lines, and text elements 
- update `fame` data  

<!-- Blank line. --> 


## Details 

- bug fix: `num_as_char()` now also works for negative numbers.  
- bug fix: Remove alternative solution in `is_leap_year()` (which yielded `FALSE` for `NA` inputs).  
- bug fix: Replace `\u2212` (minus sign) by `-` (dash) in `exp_num_dt$blood_type` to prevent **Note** on "marked UTF-8 strings".  

<!-- Previous release:  --> 

-------- 

# ds4psy 0.4.0

Release of **ds4psy** (0.4.0) [on CRAN](https://CRAN.R-project.org/package=ds4psy) 
adds new functionality and fixes minor bugs. [2020-07-06] 

**Changes** since last release:

## Major changes 

- This version adds support for processing data with **dates** and **times**:   

    - simple date and time functions now include options for returning dates or times, rather than strings.
    - add time zone support to various functions.
    - add datasets with date and time variables. 

<!-- Blank line. --> 

## Minor changes 

- `change_tz()` and `change_time()` functions for changing the display of calendar times ("POSIXct") to local times ("POSIXlt") in different time zones `tz`, and vice versa (i.e., changing actual time, but preserving time display).  
- `is_leap_year()` function checks dates and times (or integers denoting years in 4-digit "%Y" format) for falling within a leap year.  
- data in `dt_10` and `exp_num_dt` support exercises on dates and times.  
- `cur_date()` and `cur_time()` now print date/time (as string) or return a "Date"/"POSIXct" object.  
- `what_date()` and `what_time()` gain support for adding time zones `tz` (but no active conversion).  
- `sample_time()`: Switch default to sampling "POSIXct" objects (making "POSIXlt" optional) and allow specifying time zones `tz`.   
- All date and time functions based primarily on dates (`cur_date()`, `what_date()`, etc.) now use `Sys.Date()` (i.e., an object of class "Date") rather than `Sys.time()` (i.e., a "POSIXct" calendar time) as default.  

<!-- Blank line. --> 

## Details 

- bug fix: Distinguish `is.wholenumber()` from `is.integer()`  
- bug fix: Use `\u...` rather than `\U...` in `Umlaut` definitions  
- bug fix: Remove non-ASCII characters from `fruits` and `flowery`  

<!-- Previous release:  --> 

-------- 

# ds4psy 0.3.0

Release of **ds4psy** (0.3.0) [on CRAN](https://CRAN.R-project.org/package=ds4psy) 
adds new functionality (e.g., support for processing text data, new datasets, and functions). [2020-06-15] 

**Changes** since last release:

## Major changes 

- add functions and datasets for string manipulation and text processing

<!-- Blank line. --> 

## Minor changes 

- add `text_to_sentences()` and `text_to_words()` functions for text processing   
- add `count_words()` (in analogy to `count_chars()`) function for text processing  
- add `cclass` (as a named character vector) for matching character classes in regular expressions  
- add `metachar` (as a character vector) for matching meta-characters in regular expressions
- add `Umlaut` (as a named character vector) for showing and selecting German Umlaut characters    
- add datasets of `countries`, `fruits`, and `flowery` phrases (as character vectors)   
- add datasets of `Bushisms` and `Trumpisms` (as character vectors)  
- add `sample_char()` function

<!-- Blank line. --> 

## Details 

- add Travis integration to `README.Rmd` 
- rename `count_char()` to `count_chars()` (to use plural form) 
- rename `sample_date()` and `sample_time()` (to use singular form)  
- rename family of `text functions` to `text objects and functions`  
- rename family of `random functions` to `sampling functions`  

<!-- Previous release:  --> 

-------- 

# ds4psy 0.2.1

Release of **ds4psy** (0.2.1) [on CRAN](https://CRAN.R-project.org/package=ds4psy) 
is a **maintenance release** (to remove some dependencies, fix bugs on CRAN platforms, and add some datasets). [2020-05-06] 

**Changes** since last release:

## Major changes 

- remove dependencies on the **here** and **tibble** packages (and remove from declared Imports). 

## Minor changes

- add 4 messy table versions of ficticious experiment data (used in 
*Exercise 1* of *Chapter 7: Tidying data* _Four messes and one tidy table_) to the package: 
`t_1`--`t_4`. 

## Details 

- bug fix: Replace `what_day` with a simpler version that omits `unit` and `as_integer` arguments 
(to avoid WARN on CRAN for `r-devel-linux-x86_64-debian-clang`)
- bug fix: Remove `.data$...` elements from `aes()` in `ggplot` calls 
- bug fix: Add `utils::globalVariables(...)` to avoid Warning NOTE "Undefined global functions or variables"
- bug fix: Remove packages not used in this version (i.e., `dplyr`, and `magrittr`) from declared Imports 


<!-- Previous release:  --> 

-------- 

# ds4psy 0.2.0

Release of **ds4psy** (0.2.0) [on CRAN](https://CRAN.R-project.org/package=ds4psy) adds functionality and fixes some bugs. [2020-04-20] 

**Changes** since last release:

## Major changes 

Changes involving new functionality include:

- add random data generation functions (e.g., for `coin()` flips and `dice()` throws)
- add `is.wholenumber()` to test for integer values (mentioned in R oddities)
- add `plot_text()` plotting function  
- add `read_ascii()` and `count_chars()` functions for text processing 
- add `caseflip()` and `capitalize()` functions for text processing 
- add random date and time generation functions (e.g., for `sample_date()` and `sample_time()`) 
- add simple date and time functions (e.g., `cur_date()`, `cur_time()`, for Chapter\ 10: Time data) 
- add `what_` functions for simple date and time queries (for Chapter\ 10: Time data) 

## Minor changes

- add data generation function `make_grid()` for an exercise on _visual illusions_ (Exercise\ 6 of Chapter\ 2)  
- add `fame` dataset to illustrate working with dates (Exercise\ 3 of Chapter\ 10) 
- add utility functions `num_as_char()` and `num_as_ordinal()` (to be used in Chapter\ 11: Functions)  

## Details 

- add documentations of datasets (in `data.R`)  
- bug fix: Remove redundant code (from `plot_fun.R`)    
- bug fix: Remove packages not used in this version (i.e., **readr**, **stringr**, **tidyr**, and **tidyverse**) from declared Imports


<!-- Previous release:  --> 

-------- 

# ds4psy 0.1.0

Initial release of **ds4psy** (0.1.0) [on CRAN](https://CRAN.R-project.org/package=ds4psy). [2019-08-10] 

**Contents** in this release: 

The initial functionality is limited, as the package is designed to support the emerging [ds4psy book](https://bookdown.org/hneth/ds4psy/): 

- provide book code (from examples and exercises) as a package
- provide all data sets currently used in the book (with documentation and references)
- provide an initial color scheme and plotting theme
- add plotting functions (e.g., of book graphics) for function exploration purposes 


<!-- Footer: --> 

---------- 

[File `NEWS.md` updated on 2025-09-28.]

<!-- eof. -->
