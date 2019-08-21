
# ds4psy News

<!-- Description: --> 

All datasets required for the examples and exercises in the book "Data Science for Psychologists" (by Hansjoerg Neth, Konstanz University, 2019), available at <https://bookdown.org/hneth/ds4psy/>. The book and course introduce principles and methods of data science to students of psychology and other biological or social sciences. The 'ds4psy' package primarily provides datasets, but also functions for graphics and text-manipulation that are used in the book and its exercises. 

## Current development version

The current development version of **ds4psy** (0.1.0.9001+) is hosted at <https://github.com/hneth/ds4psy/>. 

### Major changes 

Changes involving new functionality include:

- ... 

### Minor changes

- add utility function `make_grid()` 
- add utility function `num_as_char()` 

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

## To do

New content: 

- add chapter on _Text strings_ (in Part 2: Data wrangling)
- add chapter on _Dates and times_ (in Part 2: Data wrangling)
- add _factors_ to Basics chapter, or a chapter on _Factors_ (in Part 2: Data wrangling) 
- consider making _conditionals_ its own chapter (in Part 3: Programming) 
- emphasize _reproducible research_ aspects in introduction and appendix on R Markdown

Details and cosmetics:

- include _Preparation_ in _Introduction_ sections

## Done

- remove WPA abbreviations (for both exercises and solutions)
- make figures smaller (e.g., a maximum of 75% of column width)

<!-- eof -->
