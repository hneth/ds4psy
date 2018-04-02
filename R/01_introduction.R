## r4ds: Chapter 1:  
## Code for http://r4ds.had.co.nz/introduction.html 
## hn spds uni.kn
## 2018 04 01 ------

## 1.1 What you will learn ------

# Data science is a huge field, and there’s no way to master it by a single course. 
# The goal of this course is to give you a solid foundation and some useful tools. 
# Our model of the tools needed in a typical data science project looks something like this:

# - import
# - tidy
# 
# - transform
# - visualize
# - model
# 
# - communicate

# - programming:
# Surrounding all these tools is programming. Programming is a cross-cutting
# tool that you use in every part of the project:
# Programming as a tool for thinking, gaining insights, and for transparent communication. 



## 1.2 How this book is organised ------



## 1.3 What you won’t learn ------

# 1 - big data
# 2 - Python, Julia & friends
# 3 - non-rectangular data
# 4 - hypothesis confirmation (statistics): instead mostly exploration and hypothesis generation (90%)

# false dichotomy: modelling as a tool for hypothesis confirmation, 
#                    vs. visualisation as a tool for hypothesis generation.
# The key difference is how often do you look at each observation: 
# if you look only once, it’s confirmation; if you look more than once, it’s exploration.



## 1.4 Prerequisites ------


## (1) R -----

## Current version: R 3.4.4 "Someone to Lean On" released on 2018/03/15
## Download suitable binary version from:

# <https://cloud.r-project.org>

## (2) RStudio -----

## RStudio is an integrated development environment, or IDE, for R programming. 
## Download and install it from: 

# <http://www.rstudio.com/download>


## (3) 1.4.3 The tidyverse -----  

## Install tidyverse packages: 
install.packages("tidyverse")

## This includes the following datasets:

ggplot2::diamonds
dplyr::band_members
dplyr::starwars
tidyr::table1 # etc. 

## (4) Other packages ----- 

## Install additional data packages:
# install.packages("nycflights13")
# install.packages("gapminder")
# install.packages("Lahman")
# install.packages("babynames")
# install.packages("fueleconomy")

## 1.5 Running R code ------

# - console and prompt
# - objects and environment
# - functions and arguments
# - packages: dplyr::mutate(), nycflights13::flights



## 1.6 Getting help and learning more ------

# - ?command or package documentation: examples!

# - Cheatsheets:

# See 
# - https://www.rstudio.com/resources/cheatsheets/
# - https://github.com/rstudio/cheatsheets

# Currently relevant (prior to any specific packages):

# - Base R Cheat sheet: https://github.com/rstudio/cheatsheets/blob/master/base-r.pdf 
# - RStudio IDE Cheat Sheet: https://github.com/rstudio/cheatsheets/blob/master/rstudio-ide.pdf 

# - R Markdown Cheat Sheet: https://github.com/rstudio/cheatsheets/blob/master/rmarkdown-2.0.pdf
# - R Markdown Reference Guide: https://www.rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf 

# - books and scripts
# - Google
# - stackoverflow: reprex

## ------
## eof.