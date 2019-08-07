## data.R | ds4psy
## hn | uni.kn | 2019 08 07
## ---------------------------

## Documentation of datasets included in /data. 


# (1) Positive Psychology data: ---------- 

# (1a) posPsy_p_info: ------ 

#' Positive Psychology: Participant data.
#'
#' \code{posPsy_p_info} is a dataset containing details of 295 participants. 
#' 
#' \describe{
#'   
#'   \item{id}{Participant ID.}
#'   
#'   \item{intervention}{Type of intervention: 
#'   3 positive psychology interventions (PPIs), plus 1 control condition: 
#'     1: "Using signature strengths", 
#'     2: "Three good things", 
#'     3: "Gratitude visit",  
#'     4: "Recording early memories" (control condition).}
#'     
#'   \item{sex}{Sex: 1 = female, 2 = male.}
#'   
#'   \item{age}{Age (in years).}
#'   
#'   \item{educ}{Education level: Scale from 1: less than 12 years, to 5: postgraduate degree.}
#'   
#'   \item{income}{Income: Scale from 1: below average, to 3: above average.} 
#'   
#' }
#' 
#' See codebook and references at \url{https://bookdown.org/hneth/ds4psy/B-1-datasets-pos.html}.
#'
#' @format A tibble with 295 cases (rows) and 6 variables (columns).
#' 
#' @family datasets
#' 
#' @source 
#' Woodworth, R. J., O’Brien‐Malone, A., Diamond, M. R., & Schüz, B. (2017). 
#' Web‐based positive psychology interventions: A reexamination of effectiveness. 
#' \emph{Journal of Clinical Psychology}, \emph{73}(3), 218-232. 
#' doi: \code{10.1002/jclp.22328} 
#' 
#' Woodworth, R. J., O’Brien-Malone, A., Diamond, M. R. and Schüz, B. (2018). 
#' Data from, ‘Web-based positive psychology interventions: A reexamination of effectiveness’. 
#' \emph{Journal of Open Psychology Data}, \emph{6}(1). 
#' doi: \code{10.5334/jopd.35}
#' 
#' Additional references at \url{https://bookdown.org/hneth/ds4psy/B-1-datasets-pos.html}.
#' 
#' See \url{https://openpsychologydata.metajnl.com/articles/10.5334/jopd.35/} for details 
#' and \url{https://doi.org/10.6084/m9.figshare.1577563.v1} for original dataset. 
#' 

"posPsy_p_info"


# (1b) posPsy_AHI_CESD: ------ 

#' Positive Psychology: AHI CESD data.
#'
#' \code{posPsy_AHI_CESD} is a dataset containing answers to the 24 items of the 
#' Authentic Happiness Inventory (AHI) and answers to the 
#' 20 items of the Center for Epidemiological Studies Depression (CES-D) scale 
#' (Radloff, 1977) for multiple (1 to 6) measurement occasions. 
#' 
#' See codebook and references at \url{https://bookdown.org/hneth/ds4psy/B-1-datasets-pos.html}.
#' 
#' @format A tibble with 992 cases (rows) and 50 variables (columns).
#'  
#' @family datasets
#' 
#' @seealso 
#' \code{\link{posPsy_long}} for a corrected version of this file (in long format). 
#' 
#' @source 
#' Woodworth, R. J., O’Brien‐Malone, A., Diamond, M. R., & Schüz, B. (2017). 
#' Web‐based positive psychology interventions: A reexamination of effectiveness. 
#' \emph{Journal of Clinical Psychology}, \emph{73}(3), 218-232. 
#' doi: \code{10.1002/jclp.22328} 
#' 
#' Woodworth, R. J., O’Brien-Malone, A., Diamond, M. R. and Schüz, B. (2018). 
#' Data from, ‘Web-based positive psychology interventions: A reexamination of effectiveness’. 
#' \emph{Journal of Open Psychology Data}, \emph{6}(1). 
#' doi: \code{10.5334/jopd.35}
#' 
#' Additional references at \url{https://bookdown.org/hneth/ds4psy/B-1-datasets-pos.html}.
#' 
#' See \url{https://openpsychologydata.metajnl.com/articles/10.5334/jopd.35/} for details 
#' and \url{https://doi.org/10.6084/m9.figshare.1577563.v1} for original dataset. 
#' 

"posPsy_AHI_CESD"


# (1c) posPsy_long: ------ 

#' Positive Psychology: AHI CESD corrected data (in long format). 
#'
#' \code{posPsy_long} is a dataset containing answers to the 24 items of the 
#' Authentic Happiness Inventory (AHI) and answers to the 
#' 20 items of the Center for Epidemiological Studies Depression (CES-D) scale 
#' (see Radloff, 1977) for multiple (1 to 6) measurement occasions.
#' 
#' This dataset is a corrected version of \code{\link{posPsy_AHI_CESD}} 
#' and in long-format. 
#' 
#' See codebook and references at \url{https://bookdown.org/hneth/ds4psy/B-1-datasets-pos.html}.
#' 
#' @format A tibble with 990 cases (rows) and 50 variables (columns).
#'  
#' @family datasets
#' 
#' @seealso 
#' \code{\link{posPsy_AHI_CESD}} for source of this file, 
#' \code{\link{posPsy_wide}} for a version of this file (in wide format). 
#' 
#' @source 
#' Woodworth, R. J., O’Brien‐Malone, A., Diamond, M. R., & Schüz, B. (2017). 
#' Web‐based positive psychology interventions: A reexamination of effectiveness. 
#' \emph{Journal of Clinical Psychology}, \emph{73}(3), 218-232. 
#' doi: \code{10.1002/jclp.22328} 
#' 
#' Woodworth, R. J., O’Brien-Malone, A., Diamond, M. R. and Schüz, B. (2018). 
#' Data from, ‘Web-based positive psychology interventions: A reexamination of effectiveness’. 
#' \emph{Journal of Open Psychology Data}, \emph{6}(1). 
#' doi: \code{10.5334/jopd.35}
#' 
#' Additional references at \url{https://bookdown.org/hneth/ds4psy/B-1-datasets-pos.html}.
#' 
#' See \url{https://openpsychologydata.metajnl.com/articles/10.5334/jopd.35/} for details 
#' and \url{https://doi.org/10.6084/m9.figshare.1577563.v1} for original dataset. 
#' 

"posPsy_long"


# (1d) posPsy_wide: ------ 

#' Positive Psychology: All corrected data (in wide format). 
#' 
#' \code{posPsy_wide} is a dataset containing answers to the 24 items of the 
#' Authentic Happiness Inventory (AHI) and answers to the 
#' 20 items of the Center for Epidemiological Studies Depression (CES-D) scale 
#' (see Radloff, 1977) for multiple (1 to 6) measurement occasions.
#' 
#' This dataset is based on \code{\link{posPsy_long}},  
#' but in wide format. 
#' 
#' See codebook and references at \url{https://bookdown.org/hneth/ds4psy/B-1-datasets-pos.html}.
#' 
#' @family datasets
#' 
#' @seealso 
#' \code{\link{posPsy_AHI_CESD}} for the source of this file, 
#' \code{\link{posPsy_long}} for a version of this file (in long format). 
#' 
#' @source 
#' Woodworth, R. J., O’Brien‐Malone, A., Diamond, M. R., & Schüz, B. (2017). 
#' Web‐based positive psychology interventions: A reexamination of effectiveness. 
#' \emph{Journal of Clinical Psychology}, \emph{73}(3), 218-232. 
#' doi: \code{10.1002/jclp.22328} 
#' 
#' Woodworth, R. J., O’Brien-Malone, A., Diamond, M. R. and Schüz, B. (2018). 
#' Data from, ‘Web-based positive psychology interventions: A reexamination of effectiveness’. 
#' \emph{Journal of Open Psychology Data}, \emph{6}(1). 
#' doi: \code{10.5334/jopd.35}
#' 
#' Additional references at \url{https://bookdown.org/hneth/ds4psy/B-1-datasets-pos.html}.
#' 
#' See \url{https://openpsychologydata.metajnl.com/articles/10.5334/jopd.35/} for details 
#' and \url{https://doi.org/10.6084/m9.figshare.1577563.v1} for original dataset. 
#' 

"posPsy_wide"




# (2) False Positive Psychology data: ---------- 

# https://bookdown.org/hneth/ds4psy/B-2-datasets-false.html

#' False Positive Psychology data.
#'
#' \code{falsePosPsy_all} is a dataset containing the data from 2 studies designed to 
#' highlight problematic research practices within psychology. 
#' 
#' Simmons, Nelson and Simonsohn (2011) published a controversial article 
#' with a necessarily false finding. By conducting simulations and 2 simple behavioral experiments, 
#' the authors show that flexibility in data collection, analysis, and reporting 
#' dramatically increases the rate of false-positive findings. 
#' 
#' \describe{
#'   \item{study}{Study ID.}
#'   \item{id}{Participant ID.}
#'   \item{aged}{Days since participant was born (based on their self-reported birthday).}
#'   \item{aged365}{Age in years.}
#'   \item{female}{Is participant a woman? 1: yes, 2: no.}
#'   \item{dad}{Father's age (in years).}
#'   \item{mom}{Mother's age (in years).}
#'   \item{potato}{Did the participant hear the song 'Hot Potato' by The Wiggles? 1: yes, 2: no.}
#'   \item{when64}{Did the participant hear the song 'When I am 64' by The Beatles? 1: yes, 2: no.}      
#'   \item{kalimba}{Did the participant hear the song 'Kalimba' by Mr. Scrub? 1: yes, 2: no.}
#'   \item{cond}{In which condition was the participant? 
#'   control: Subject heard the song 'Kalimba' by Mr. Scrub; 
#'   potato: Subject heard the song 'Hot Potato' by The Wiggles; 
#'   64: Subject heard the song 'When I am 64' by The Beatles.}
#'   \item{root}{Could participant report the square root of 100? 1: yes, 2: no.}      
#'   \item{bird}{Imagine a restaurant you really like offered a 30% discount for dining between 4 pm and 6 pm. 
#'   How likely would you be to take advantage of that offer? 
#'   Scale from 1: very unlikely, 7: very likely.}
#'   \item{political}{In the political spectrum, where would you place yourself? 
#'   Scale: 1: very liberal, 2: liberal, 3: centrist, 4: conservative, 5: very conservative.}
#'   \item{quarterback}{If you had to guess who was chosen the quarterback of the year in Canada last year, 
#'   which of the following four options would you choose? 
#'   1: Dalton Bell, 2: Daryll Clark, 3: Jarious Jackson, 4: Frank Wilczynski.}      
#'   \item{olddays}{How often have you referred to some past part of your life as “the good old days”? 
#'   Scale: 11: never, 12: almost never, 13: sometimes, 14: often, 15: very often.}
#'   \item{feelold}{How old do you feel? 
#'   Scale: 1: very young, 2: young, 3: neither young nor old, 4: old, 5: very old.}
#'   \item{computer}{Computers are complicated machines. 
#'   Scale from 1: strongly disagree, to 5: strongly agree.}      
#'   \item{diner}{Imagine you were going to a diner for dinner tonight, how much do you think you would like the food? 
#'   Scale from 1: dislike extremely, to 9: like extremely.}
#'   }
#' 
#' See \url{https://bookdown.org/hneth/ds4psy/B-2-datasets-false.html} for background information and codebook. 
#'
#'
#' @format A tibble with 78 cases (rows) and 19 variables (columns):
#' 
#' @family datasets
#' 
#' @source 
#' Simmons, J.P., Nelson, L.D., & Simonsohn, U. (2011). 
#' False-positive psychology: Undisclosed flexibility in data collection and analysis 
#' allows presenting anything as significant. 
#' \emph{Psychological Science}, \emph{22}(11), 1359-1366. 
#' doi: \url{https://doi.org/10.1177/0956797611417632}
#' 
#' Simmons, J.P., Nelson, L.D., & Simonsohn, U. (2014). 
#' Data from paper “False-Positive Psychology: 
#' Undisclosed Flexibility in Data Collection and Analysis 
#' Allows Presenting Anything as Significant”. 
#' \emph{Journal of Open Psychology Data}, \emph{2}(1), e1. 
#' doi: \url{http://doi.org/10.5334/jopd.aa} 
#' 
#' Download files at \url{https://openpsychologydata.metajnl.com/articles/10.5334/jopd.aa/} and 
#' the zip-archive at \url{https://zenodo.org/record/7664} for original dataset.
#' 

"falsePosPsy_all"



# (3) Outlier data from Chapter 3: Transforming data / dplyr: ---------- 

# https://bookdown.org/hneth/ds4psy/3-6-transform-ex.html 

#' Outlier data.
#'
#' \code{outliers} is a fictitious dataset containing the sex and height of 1,000 people.  
#' 
#' @format A tibble with 100 cases (rows) and 3 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/out.csv}. 

"outliers"




# (4) Tables from Chapter 6: Importing data / readr: ---------- 

# https://bookdown.org/hneth/ds4psy/6-3-import-essentials.html 

# (4a) data_t1.csv: ---- 
# Note: Same as (6a) below. 

# data_t1 <- readr::read_csv("http://rpository.com/ds4psy/data/data_t1.csv")
# 
# # Check: 
# dim(data_t1)  #  20 observations (rows) x 4 variables (columns)
# 
# # Check number of missing values: 
# sum(is.na(data_t1))  #  3 missing values
# 
# # Save to /data:
# usethis::use_data(data_t1, overwrite = TRUE)


#' Data table data_t1.
#'
#' \code{data_t1} is a fictitious dataset to practice importing and joining data 
#' (from a CSV file).  
#' 
#' @format A tibble with 20 cases (rows) and 4 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/data_t1.csv}. 

"data_t1"


# (4b) data_t1_de.csv: ---- 

# data_t1_de <- readr::read_csv2("http://rpository.com/ds4psy/data/data_t1_de.csv")
# 
# # Check: 
# dim(data_t1_de)  #  20 observations (rows) x 4 variables (columns)
# 
# # Check number of missing values: 
# sum(is.na(data_t1_de))  #  3 missing values
# 
# # Save to /data:
# usethis::use_data(data_t1_de, overwrite = TRUE)

#' Data import data_t1_de.
#'
#' \code{data_t1_de} is a fictitious dataset to practice data import 
#' (from a CSV file, European/de style).  
#' 
#' @format A tibble with 20 cases (rows) and 4 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/data_t1_de.csv}. 

"data_t1_de"


# (4c) data_t1_tab.csv: ---- 

# data_t1_tab <- read_tsv("http://rpository.com/ds4psy/data/data_t1_tab.csv")
# 
# # Check: 
# dim(data_t1_tab)  #  20 observations (rows) x 4 variables (columns)
# 
# # Check number of missing values: 
# sum(is.na(data_t1_tab))  #  3 missing values
# 
# # Save to /data:
# usethis::use_data(data_t1_tab, overwrite = TRUE)


#' Data import data_t1_tab.
#'
#' \code{data_t1_tab} is a fictitious dataset to practice data import 
#' (from a TAB file).  
#' 
#' @format A tibble with 20 cases (rows) and 4 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See TAB-delimited data at \url{http://rpository.com/ds4psy/data/data_t1_tab.csv}. 

"data_t1_tab"


# (4d) data_1.dat: ---- 

# my_file <- "http://rpository.com/ds4psy/data/data_1.dat"
# 
# data_1 <- readr::read_delim(my_file, delim = ".", 
#                             col_names = c("initials", "age", "tel", "pwd"), 
#                             na = c("-77", "-99"))
# 
# # Check: 
# dim(data_1)  #  100 observations (rows) x 4 variables (columns)
# 
# # Check number of missing values: 
# sum(is.na(data_1))  #  15 missing values
# 
# # Save to /data:
# usethis::use_data(data_1, overwrite = TRUE)

#' Data import data_1.
#'
#' \code{data_1} is a fictitious dataset to practice data import 
#' (from a DELIMITED file).  
#' 
#' @format A tibble with 100 cases (rows) and 4 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See DELIMITED data at \url{http://rpository.com/ds4psy/data/data_1.dat}. 

"data_1"


# (4e) data_2.dat: ---- 

# my_file_path <- "http://rpository.com/ds4psy/data/data_2.dat"  # from online source
# 
# # read_fwf: 
# data_2 <- readr::read_fwf(my_file_path, 
#                           fwf_cols(initials = c(1, 2), 
#                                    age = c(4, 5), 
#                                    tel = c(7, 10), 
#                                    pwd = c(12, 17)))
# 
# # Check: 
# dim(data_2)  #  100 observations (rows) x 4 variables (columns)
# 
# # Check number of missing values: 
# sum(is.na(data_2))  #  0 missing values
# 
# # Save to /data:
# usethis::use_data(data_2, overwrite = TRUE)


#' Data import data_2.
#'
#' \code{data_2} is a fictitious dataset to practice data import 
#' (from a FWF file).  
#' 
#' @format A tibble with 100 cases (rows) and 4 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See FWF data at \url{http://rpository.com/ds4psy/data/data_2.dat}. 

"data_2"




# (5) Chapter 7: Tidying data / tidyr: ---------- 

# https://bookdown.org/hneth/ds4psy/7-3-tidy-essentials.html

# (5a) table6.csv: ------ 

# ## Load data (as comma-separated file): 
# table6 <- readr::read_csv("http://rpository.com/ds4psy/data/table6.csv")  # from online source
# 
# # Check: 
# dim(table6)  #  6 observations (rows) x 2 variables (columns)
# 
# # Check number of missing values: 
# sum(is.na(table6))  #  0 missing values
# 
# # Save to /data:
# usethis::use_data(table6, overwrite = TRUE)

#' Data table6.
#'
#' \code{table6} is a fictitious dataset to practice tidying data.
#' 
#' This dataset is a variant of the \code{tidyr::table1} to \code{tidyr::table5} dataset.   
#' 
#' @format A tibble with 6 cases (rows) and 2 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/table6.csv}. 

"table6"


# (5b) table7.csv: ------ 

# # Load data (as comma-separated file): 
# table7 <- readr::read_csv("http://rpository.com/ds4psy/data/table7.csv")  # from online source
# 
# # Check: 
# dim(table7)  #  6 observations (rows) x 1 (horrendous) variable (column)
# 
# # Check number of missing values: 
# sum(is.na(table7))  #  0 missing values
# 
# # Save to /data:
# usethis::use_data(table7, overwrite = TRUE)

#' Data table7.
#'
#' \code{table7} is a fictitious dataset to practice tidying data.
#' 
#' This dataset is a variant of the \code{tidyr::table1} to \code{tidyr::table5} dataset.   
#' 
#' @format A tibble with 6 cases (rows) and 1 (horrendous) variable (column). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/table7.csv}. 

"table7"


# (5c) table8.csv: ------ 

# # Load data (as comma-separated file): 
# table8 <- readr::read_csv("http://rpository.com/ds4psy/data/table8.csv")  # from online source
# 
# # Check: 
# dim(table8)  #  3 observations (rows) x 5 variables (columns)
# 
# # Check number of missing values: 
# sum(is.na(table8))  #  0 missing values
# 
# # Save to /data:
# usethis::use_data(table8, overwrite = TRUE)

#' Data table8.
#'
#' \code{table8} is a fictitious dataset to practice tidying data.
#' 
#' This dataset is a variant of the \code{tidyr::table1} to \code{tidyr::table5} dataset.   
#' 
#' @format A tibble with 3 cases (rows) and 5 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/table8.csv}. 

"table8"


# (5d) exp_wide.csv: ------ 

# https://bookdown.org/hneth/ds4psy/7-5-tidy-ex.html

# exp_wide <- readr::read_csv("http://rpository.com/ds4psy/data/exp_wide.csv")  # from online source 
# 
# # Check: 
# dim(exp_wide)  #  10 observations (rows) x 7 variables (columns)
# 
# # Check number of missing values: 
# sum(is.na(exp_wide))  #  0 missing values
# 
# # Save to /data:
# usethis::use_data(exp_wide, overwrite = TRUE)


#' Data exp_wide.
#'
#' \code{exp_wide} is a fictitious dataset to practice tidying data 
#' (here: converting from wide to long format).
#' 
#' @format A tibble with 10 cases (rows) and 7 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/exp_wide.csv}. 

"exp_wide"



# (6) Chapter 8: Joining data / dplyr: ---------- 

# https://bookdown.org/hneth/ds4psy/8-3-join-essentials.html

# (6a) data_t1.csv: ---- 
# Note: Same as (4a) above. 

# data_t1 <- readr::read_csv("http://rpository.com/ds4psy/data/data_t1.csv")
# 
# # Check: 
# dim(data_t1)  #  20 observations (rows) x 4 variables (columns)
# 
# # Check number of missing values: 
# sum(is.na(data_t1))  #  3 missing values
# 
# # Save to /data:
# usethis::use_data(data_t1, overwrite = TRUE)

# See (4a) above.


# (6b) data_t2.csv: ---- 

# data_t2 <- readr::read_csv(file = "http://rpository.com/ds4psy/data/data_t2.csv")
# 
# # Check: 
# dim(data_t2)  #  20 observations (rows) x 4 variables (columns)
# 
# # Check number of missing values: 
# sum(is.na(data_t2))  #  3 missing values
# 
# # Save to /data:
# usethis::use_data(data_t2, overwrite = TRUE)


#' Data table data_t2.
#'
#' \code{data_t2} is a fictitious dataset to practice importing and joining data 
#' (from a CSV file).  
#' 
#' @format A tibble with 20 cases (rows) and 4 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/data_t2.csv}. 

"data_t2"


# Exercise 1:

# (6c) t3.csv: ---- 

# t3 <- readr::read_csv(file = "http://rpository.com/ds4psy/data/t3.csv")
# 
# # Check: 
# dim(t3)  #  10 observations (rows) x 4 variables (columns)
# 
# # Check number of missing values: 
# sum(is.na(t3))  #  3 missing values
# 
# # Save to /data:
# usethis::use_data(t3, overwrite = TRUE)

#' Data table t3.
#'
#' \code{t3} is a fictitious dataset to practice importing and joining data 
#' (from a CSV file).  
#' 
#' @format A tibble with 10 cases (rows) and 4 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/t3.csv}. 

"t3"

# (6d) t4.csv: ---- 

# t4 <- readr::read_csv(file = "http://rpository.com/ds4psy/data/t4.csv")
# 
# # Check: 
# dim(t4)  #  10 observations (rows) x 4 variables (columns)
# 
# # Check number of missing values: 
# sum(is.na(t4))  #  2 missing values
# 
# # Save to /data:
# usethis::use_data(t4, overwrite = TRUE)


#' Data table t4.
#'
#' \code{t4} is a fictitious dataset to practice importing and joining data 
#' (from a CSV file).  
#' 
#' @format A tibble with 10 cases (rows) and 4 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/t4.csv}. 

"t4"


# Exercise 3: 

# (6e) data_t3.csv: ---- 

# data_t3 <- readr::read_csv(file = "http://rpository.com/ds4psy/data/data_t3.csv")
# 
# # Check: 
# dim(data_t3)  #  20 observations (rows) x 4 variables (columns)
# 
# # Check number of missing values: 
# sum(is.na(data_t3))  #  3 missing values
# 
# # Save to /data:
# usethis::use_data(data_t3, overwrite = TRUE)


#' Data table data_t3.
#'
#' \code{data_t3} is a fictitious dataset to practice importing and joining data 
#' (from a CSV file).  
#' 
#' @format A tibble with 20 cases (rows) and 4 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/data_t3.csv}. 

"data_t3"


# (6f) data_t4.csv: ---- 

# data_t4 <- readr::read_csv(file = "http://rpository.com/ds4psy/data/data_t4.csv")
# 
# # Check: 
# dim(data_t4)  #  20 observations (rows) x 4 variables (columns)
# 
# # Check number of missing values: 
# sum(is.na(data_t4))  #  3 missing values
# 
# # Save to /data:
# usethis::use_data(data_t4, overwrite = TRUE)


#' Data table data_t4.
#'
#' \code{data_t4} is a fictitious dataset to practice importing and joining data 
#' (from a CSV file).  
#' 
#' @format A tibble with 20 cases (rows) and 4 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/data_t4.csv}. 

"data_t4"



# (7) Chapter 10: Iteration / loops: -------- 

# https://bookdown.org/hneth/ds4psy/10-3-iter-essentials.html

# (7a) tb data: ------ 

# tb <- readr::read_csv2("http://rpository.com/ds4psy/data/tb.csv") 
# 
# # Check:
# dim(tb)  #  100 cases x 5 variables
# 
# # Check number of missing values: 
# sum(is.na(tb))  #  0 missing values
# 
# # Save to /data:
# usethis::use_data(tb, overwrite = TRUE)


#' Data table tb.
#'
#' \code{tb} is a fictitious dataset to practice loops and iteration 
#' (from a CSV file).  
#' 
#' @format A tibble with 100 cases (rows) and 5 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/tb.csv}. 

"tb"


# (7b) pi data: ------ 

# https://bookdown.org/hneth/ds4psy/10-3-iter-essentials.html 
# Orig. data source <http://www.geom.uiuc.edu/~huberty/math5337/groupe/digits.html>

# # pi_all <- readLines("./data/pi_100k.txt")                # from local data file
# pi_data <- "http://rpository.com/ds4psy/data/pi_100k.txt"  # URL of online data file
# pi_100k <- readLines(pi_data)                              # read from online source
# 
# # Check:
# dim(pi_100k)  #  NULL !
# 
# # Check number of missing values: 
# sum(is.na(pi_100k))  #  0 missing values
# 
# # Save to /data:
# usethis::use_data(pi_100k, overwrite = TRUE)


#' Data: 100k digits of pi.
#'
#' \code{pi_100k} is a dataset containing the first 100k digits of pi. 
#' 
#' @format A character of \code{nchar(pi_100k) = 100001}. 
#' 
#' @family datasets 
#' 
#' @source 
#' See TXT data at \url{http://rpository.com/ds4psy/data/pi_100k.txt}. 
#' 
#' Original data at \url{http://www.geom.uiuc.edu/~huberty/math5337/groupe/digits.html}. 

"pi_100k"


## ToDo: ----------

## - Complete codebooks (see LaTeX codes in data_190807.R in archive).

## eof. ----------------------