## data.R | ds4psy
## hn | uni.kn | 2020 05 14
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
#' @format A table with 295 cases (rows) and 6 variables (columns).
#' 
#' @family datasets
#' 
#' @source 
#' \strong{Articles}
#' 
#' \itemize{
#' 
#' \item Woodworth, R. J., O’Brien-Malone, A., Diamond, M. R., & Schüz, B. (2017). 
#' Web-based positive psychology interventions: A reexamination of effectiveness. 
#' \emph{Journal of Clinical Psychology}, \emph{73}(3), 218--232. 
#' doi: \code{10.1002/jclp.22328} 
#' 
#' \item Woodworth, R. J., O’Brien-Malone, A., Diamond, M. R. and Schüz, B. (2018). 
#' Data from, ‘Web-based positive psychology interventions: A reexamination of effectiveness’. 
#' \emph{Journal of Open Psychology Data}, \emph{6}(1). 
#' doi: \code{10.5334/jopd.35}
#' }
#' 
#' See \url{https://openpsychologydata.metajnl.com/articles/10.5334/jopd.35/} for details 
#' and \url{https://doi.org/10.6084/m9.figshare.1577563.v1} for original dataset. 
#' 
#' Additional references at \url{https://bookdown.org/hneth/ds4psy/B-1-datasets-pos.html}. 

"posPsy_p_info"


# (1b) posPsy_AHI_CESD: ------ 

#' Positive Psychology: AHI CESD data.
#'
#' \code{posPsy_AHI_CESD} is a dataset containing answers to the 24 items of the 
#' Authentic Happiness Inventory (AHI) and answers to the 
#' 20 items of the Center for Epidemiological Studies Depression (CES-D) scale 
#' (Radloff, 1977) for multiple (1 to 6) measurement occasions. 
#' 
#' \strong{Codebook} 
#' 
#' \itemize{
#' 
#' \item 1. \strong{id}: Participant ID. 
#' 
#' \item 2. \strong{occasion}: Measurement occasion: 
#'   0: Pretest (i.e., at enrolment),   
#'   1: Posttest (i.e., 7 days after pretest),   
#'   2: 1-week follow-up, (i.e., 14 days after pretest, 7 days after posttest),   
#'   3: 1-month follow-up, (i.e., 38 days after pretest, 31 days after posttest),   
#'   4: 3-month follow-up, (i.e., 98 days after pretest, 91 days after posttest),   
#'   5: 6-month follow-up, (i.e., 189 days after pretest, 182 days after posttest).  
#' 
#' \item 3. \strong{elapsed.days}: Time since enrolment measured in fractional days.
#'  
#' \item 4. \strong{intervention}: Type of intervention: 
#'   3 positive psychology interventions (PPIs), plus 1 control condition: 
#'     1: "Using signature strengths", 
#'     2: "Three good things", 
#'     3: "Gratitude visit", 
#'     4: "Recording early memories" (control condition). 
#' 
#' \item 5.-28. (from \strong{ahi01} to \strong{ahi24}): Responses on 24 AHI items. 
#' 
#' \item 29.-48. (from \strong{cesd01} to \strong{cesd20}): Responses on 20 CES-D items. 
#' 
#' \item 49. \strong{ahiTotal}: Total AHI score. 
#' 
#' \item 50. \strong{cesdTotal}: Total CES-D score.   
#' 
#' }
#' 
#' See codebook and references at \url{https://bookdown.org/hneth/ds4psy/B-1-datasets-pos.html}.
#' 
#' @format A table with 992 cases (rows) and 50 variables (columns).
#'  
#' @family datasets
#' 
#' @seealso 
#' \code{\link{posPsy_long}} for a corrected version of this file (in long format). 
#' 
#' @source 
#' \strong{Articles}
#' 
#' \itemize{
#' 
#' \item Woodworth, R. J., O’Brien-Malone, A., Diamond, M. R., & Schüz, B. (2017). 
#' Web-based positive psychology interventions: A reexamination of effectiveness. 
#' \emph{Journal of Clinical Psychology}, \emph{73}(3), 218--232. 
#' doi: \code{10.1002/jclp.22328} 
#' 
#' \item Woodworth, R. J., O’Brien-Malone, A., Diamond, M. R. and Schüz, B. (2018). 
#' Data from, ‘Web-based positive psychology interventions: A reexamination of effectiveness’. 
#' \emph{Journal of Open Psychology Data}, \emph{6}(1). 
#' doi: \code{10.5334/jopd.35}
#' }
#' 
#' See \url{https://openpsychologydata.metajnl.com/articles/10.5334/jopd.35/} for details 
#' and \url{https://doi.org/10.6084/m9.figshare.1577563.v1} for original dataset. 
#' 
#' Additional references at \url{https://bookdown.org/hneth/ds4psy/B-1-datasets-pos.html}. 

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
#' @format A table with 990 cases (rows) and 50 variables (columns).
#'  
#' @family datasets
#' 
#' @seealso 
#' \code{\link{posPsy_AHI_CESD}} for source of this file and codebook information;  
#' \code{\link{posPsy_wide}} for a version of this file (in wide format). 
#' 
#' @source 
#' \strong{Articles}
#' 
#' \itemize{
#' 
#' \item Woodworth, R. J., O’Brien-Malone, A., Diamond, M. R., & Schüz, B. (2017). 
#' Web-based positive psychology interventions: A reexamination of effectiveness. 
#' \emph{Journal of Clinical Psychology}, \emph{73}(3), 218--232. 
#' doi: \code{10.1002/jclp.22328} 
#' 
#' \item Woodworth, R. J., O’Brien-Malone, A., Diamond, M. R. and Schüz, B. (2018). 
#' Data from, ‘Web-based positive psychology interventions: A reexamination of effectiveness’. 
#' \emph{Journal of Open Psychology Data}, \emph{6}(1). 
#' doi: \code{10.5334/jopd.35}
#' }
#' 
#' See \url{https://openpsychologydata.metajnl.com/articles/10.5334/jopd.35/} for details 
#' and \url{https://doi.org/10.6084/m9.figshare.1577563.v1} for original dataset. 
#' 
#' Additional references at \url{https://bookdown.org/hneth/ds4psy/B-1-datasets-pos.html}. 

"posPsy_long"


# (1d) posPsy_wide: ------ 

#' Positive Psychology: All corrected data (in wide format). 
#' 
#' \code{posPsy_wide} is a dataset containing answers to the 24 items of the 
#' Authentic Happiness Inventory (AHI) and answers to the 
#' 20 items of the Center for Epidemiological Studies Depression (CES-D) scale 
#' (see Radloff, 1977) for multiple (1 to 6) measurement occasions.
#' 
#' This dataset is based on \code{\link{posPsy_AHI_CESD}} and 
#' \code{\link{posPsy_long}}, but is in wide format. 
#' 
#' @family datasets
#' 
#' @seealso 
#' \code{\link{posPsy_AHI_CESD}} for the source of this file, 
#' \code{\link{posPsy_long}} for a version of this file (in long format). 
#' 
#' @source 
#' \strong{Articles}
#' 
#' \itemize{
#' 
#' \item Woodworth, R. J., O’Brien-Malone, A., Diamond, M. R., & Schüz, B. (2017). 
#' Web-based positive psychology interventions: A reexamination of effectiveness. 
#' \emph{Journal of Clinical Psychology}, \emph{73}(3), 218--232. 
#' doi: \code{10.1002/jclp.22328} 
#' 
#' \item Woodworth, R. J., O’Brien-Malone, A., Diamond, M. R. and Schüz, B. (2018). 
#' Data from, ‘Web-based positive psychology interventions: A reexamination of effectiveness’. 
#' \emph{Journal of Open Psychology Data}, \emph{6}(1). 
#' doi: \code{10.5334/jopd.35}
#' }
#' 
#' See \url{https://openpsychologydata.metajnl.com/articles/10.5334/jopd.35/} for details 
#' and \url{https://doi.org/10.6084/m9.figshare.1577563.v1} for original dataset. 
#' 
#' Additional references at \url{https://bookdown.org/hneth/ds4psy/B-1-datasets-pos.html}. 

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
#'   \item{bird}{Imagine a restaurant you really like offered a 30 percent discount for dining between 4pm and 6pm. 
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
#' See \url{https://bookdown.org/hneth/ds4psy/B-2-datasets-false.html} for codebook and more information. 
#'
#'
#' @format A table with 78 cases (rows) and 19 variables (columns):
#' 
#' @family datasets
#' 
#' @source 
#' \strong{Articles}
#' 
#' \itemize{
#' 
#' \item Simmons, J.P., Nelson, L.D., & Simonsohn, U. (2011). 
#' False-positive psychology: Undisclosed flexibility in data collection and analysis 
#' allows presenting anything as significant. 
#' \emph{Psychological Science}, \emph{22}(11), 1359--1366. 
#' doi: \url{https://doi.org/10.1177/0956797611417632}
#' 
#' \item Simmons, J.P., Nelson, L.D., & Simonsohn, U. (2014). 
#' Data from paper "False-Positive Psychology: 
#' Undisclosed Flexibility in Data Collection and Analysis 
#' Allows Presenting Anything as Significant". 
#' \emph{Journal of Open Psychology Data}, \emph{2}(1), e1. 
#' doi: \url{http://doi.org/10.5334/jopd.aa} 
#' }
#' 
#' See files at \url{https://openpsychologydata.metajnl.com/articles/10.5334/jopd.aa/} and 
#' the archive at \url{https://zenodo.org/record/7664} for original dataset. 

"falsePosPsy_all"




# (3) Outlier data from Chapter 3: Transforming data / dplyr: ---------- 

# https://bookdown.org/hneth/ds4psy/3-6-transform-ex.html 

#' Outlier data.
#'
#' \code{outliers} is a fictitious dataset containing the id, sex, and height 
#' of 1000 non-existing, but otherwise normal people.  
#' 
#' \strong{Codebook}
#' 
#' \describe{
#'   \item{id}{Participant ID (as character code)}
#'   \item{sex}{Gender (female vs. male)}
#'   \item{height}{Height (in cm)}
#' }
#' 
#' @format A table with 100 cases (rows) and 3 variables (columns). 
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
#' @format A table with 20 cases (rows) and 4 variables (columns). 
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
#' (from a CSV file, de/European style).  
#' 
#' @format A table with 20 cases (rows) and 4 variables (columns). 
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
#' @format A table with 20 cases (rows) and 4 variables (columns). 
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
#' @format A table with 100 cases (rows) and 4 variables (columns). 
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
#' @format A table with 100 cases (rows) and 4 variables (columns). 
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
#' This dataset is a variant of the \code{table1} to \code{table5} datasets 
#' of the \bold{tidyr} package.   
#' 
#' @format A table with 6 cases (rows) and 2 variables (columns). 
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
#' This dataset is a variant of the \code{table1} to \code{table5} datasets 
#' of the \bold{tidyr} package.    
#' 
#' @format A table with 6 cases (rows) and 1 (horrendous) variable (column). 
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
#' This dataset is a variant of the \code{table1} to \code{table5} datasets 
#' of the \bold{tidyr} package.     
#' 
#' @format A table with 3 cases (rows) and 5 variables (columns). 
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
#' @format A table with 10 cases (rows) and 7 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/exp_wide.csv}. 

"exp_wide"


# (6) Chapter 7: Exercise 1: 'Four messes and one tidy table': ------ 

# https://bookdown.org/hneth/ds4psy/7-4-tidy-ex.html#tidy:ex01


# (6a): t_1.csv: ----- 

#' Data t_1.
#'
#' \code{t_1} is a fictitious dataset to practice tidying data.
#' 
#' @format A table with 8 cases (rows) and 9 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/t_1.csv}. 

"t_1"


# (6b): t_2.csv: ----- 

#' Data t_2.
#'
#' \code{t_2} is a fictitious dataset to practice tidying data.
#' 
#' @format A table with 8 cases (rows) and 5 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/t_2.csv}. 

"t_2"


# (6c): t_3.csv: ----- 

#' Data t_3.
#'
#' \code{t_3} is a fictitious dataset to practice tidying data.
#' 
#' @format A table with 16 cases (rows) and 6 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/t_3.csv}. 

"t_3"


# (6d): t_4.csv: ----- 

#' Data t_4.
#'
#' \code{t_4} is a fictitious dataset to practice tidying data.
#' 
#' @format A table with 16 cases (rows) and 8 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/t_4.csv}. 

"t_4"



# (7) Chapter 8: Joining data / dplyr: ---------- 

# https://bookdown.org/hneth/ds4psy/8-3-join-essentials.html

# (7a) data_t1.csv: ---- 
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


# (7b) data_t2.csv: ---- 

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
#' @format A table with 20 cases (rows) and 4 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/data_t2.csv}. 

"data_t2"


# Exercise 1:

# (7c) t3.csv: ---- 

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
#' @format A table with 10 cases (rows) and 4 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/t3.csv}. 

"t3"


# (7d) t4.csv: ---- 

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
#' @format A table with 10 cases (rows) and 4 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/t4.csv}. 

"t4"


# Exercise 3: 

# (7e) data_t3.csv: ---- 

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
#' @format A table with 20 cases (rows) and 4 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/data_t3.csv}. 

"data_t3"


# (7f) data_t4.csv: ---- 

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
#' @format A table with 20 cases (rows) and 4 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/data_t4.csv}. 

"data_t4"



# (8) Text data: -------- 

# ToDo: Find some book/text to analyze. 



# (9) Time data: --------

# Fame data (DOB and DOD of famous people):
# Chapter 10 (Time data), Exercise 3
# See Exercise 3 at https://bookdown.org/hneth/ds4psy/10-4-time-ex.html#time:ex03 
# See file all_DATASETs.R for raw data (as tables).

#' Data table fame.
#'
#' \code{fame} is a dataset to practice working with dates.
#'  
#' \code{fame} contains the names, areas, dates of birth (DOB), and 
#' --- if applicable --- the dates of death (DOD) of famous people.
#' 
#' @format A table with 38 cases (rows) and 4 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' Student solutions to exercises, dates from \url{https://en.wikipedia.org}. 

"fame"



# (10) Chapter 12: Iteration / loops: -------- 

# https://bookdown.org/hneth/ds4psy/10-3-iter-essentials.html

# (10a) tb data: ------ 

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
#' \code{tb} is a fictitious dataset describing 
#' 100 non-existing, but otherwise ordinary people.
#' 
#' \strong{Codebook} 
#' 
#' \itemize{
#' 
#' \item 1. \strong{id}: Participant ID.
#' 
#' \item 2. \strong{age}: Age (in years).
#' 
#' \item 3. \strong{height}: Height (in cm).
#' 
#' \item 4. \strong{shoesize}: Shoesize (EU standard).
#' 
#' \item 5. \strong{IQ}: IQ score (according Raven's Regressive Tables).
#' 
#' } 
#' 
#' \code{tb} was orginally created to practice loops and iterations 
#' (as a CSV file). 
#' 
#' @format A table with 100 cases (rows) and 5 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/tb.csv}. 

"tb"


# (10b) pi data: ------ 

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


# (11) Text data: ------ 


# (11a) countries: ---- 

# # Source: <https://www.gapminder.org/data/documentation/gd004/>
# file <- "GM_lifeExpectancy_by_country_v11.csv"
# path <- "./data-raw/raw_data_sources/_gapminder/"
# datapath <- paste0(path, file)
# datapath
# 
# GM_life_expectancy <- readr::read_csv2(file = datapath)
# GM_life_expectancy
# 
# countries <- GM_life_expectancy$country
# countries

#' Data: Names of countries.
#'
#' \code{countries} is a dataset containing the names of 
#' 197 countries (as a vector of text strings). 
#' 
#' @format A vector of type \code{character}  
#' with \code{length(countries) = 197}. 
#' 
#' @family datasets 
#' 
#' @source 
#' Data from \url{https://www.gapminder.org}: 
#' Original data at \url{https://www.gapminder.org/data/documentation/gd004/}.

"countries"


# (11b) fruits: ---- 

# Source: <https://simple.wikipedia.org/wiki/List_of_fruits>
# fruits
# length(fruits)  # 122

#' Data: Names of fruits. 
#'
#' \code{fruits} is a dataset containing the names of 
#' 122 fruits (as a vector of text strings). 
#' 
#' Botanically, "fruits" are the seed-bearing structures 
#' of flowering plants (angiosperms) formed from the ovary 
#' after flowering. 
#' 
#' In common usage, "fruits" refer to the fleshy 
#' seed-associated structures of a plant 
#' that taste sweet or sour, 
#' and are edible in their raw state.
#' 
#' @format A vector of type \code{character}  
#' with \code{length(fruits) = 122}. 
#' 
#' @family datasets 
#' 
#' @source 
#' Data based on \url{https://simple.wikipedia.org/wiki/List_of_fruits}.

"fruits"

# (11c) flowery sentences: ---- 

# Versions and variations of Gertrude Stein's popular phrase 
# "A rose is a rose is a rose".  
# Source: <https://en.wikipedia.org/wiki/Rose_is_a_rose_is_a_rose_is_a_rose>

flowery <- c(# (a) Mentions of "rose" in "Sacred Emily: # 
  "Rose is a rose is a rose is a rose.", # "Sacred Emily", Geography and Plays
  "It is rose in hen.",
  "Jack Rose Jack Rose.", 
  # (b) Versions by Gertrude Stein: # 
  "A rose is a rose is a rose",  # popular variation
  "Do we suppose that all she knows is that a rose is a rose is a rose is a rose.", # (Operas and Plays)
  "... she would carve on the tree Rose is a Rose is a Rose is a Rose is a Rose until it went all the way around.", # (The World is Round)
  "A rose tree may be a rose tree may be a rosy rose tree if watered.", # (Alphabets and Birthdays)
  "Indeed a rose is a rose makes a pretty plate...", # (Stanzas in Meditation)
  "When I said: A rose is a rose is a rose is a rose. And then later made that into a ring I made poetry and what did I do I caressed completely caressed and addressed a noun.", # (Lectures in America)
  "Civilization begins with a rose. A rose is a rose is a rose is a rose. It continues with blooming and it fastens clearly upon excellent examples.", # (As Fine as Melanctha)
  "Lifting belly can please me because it is an occupation I enjoy. Rose is a rose is a rose is a rose. In print on top.", # (Bee Time Vine)
  # (c) Variations by others: # 
  "A rose by any other name would smell as sweet.", # William Shakespeare
  "Go in the garden and ask the rose its meaning.", # Pablo Picasso
  "Evidente y secreto, como el diamante, como el agua, como el desnudo, como la rosa", # Juan Ramon Jimenez (Madrid: Sanchez Cuesta, 1929)
  "a stone is a stein is a rock is a boulder is a pebble.", # Ernest Hemingway (1940): For Whom the Bell Tolls, 
  "a rose is a rose is an onion.", # Ernest Hemingway
  "a bitch is a bitch is a bitch is a bitch.", # Ernest Hemingway
  "A Rose is a rose is a rose is a rose is / A rose is what Moses supposes his toes is / Couldn't be a lily or a taffy daphi dilli / It's gotta be a rose cuz it rhymes with mose!", # "Moses Supposes", in the 1952 musical "Singin' in the Rain"
  "A rose is a rose is a rose. But these chair legs were chair legs were St. Michael and all angels.", # Aldous Huxley (1954): "The Doors of Perception" 
  "An apple is an apple is an apple, whereas the moon is the moon is the moon.", #  Aldous Huxley (1958), "Brave New World Revisited"
  "Oh, I once heard a poem that goes / A rose is a rose is a rose / But I don't agree / Take it from me / There's one rose sweeter than any that grows!", # "Rosie" (1960) Broadway musical "Bye Bye Birdie" (film in 1963), song by character Albert Peterson
  "Stat rosa pristina nomine, nomina nuda tenemus", # Umberto Eco (1980) at the end of the book "The Name of the Rose"
  "A crime is a crime is a crime", # UK Prime Minister Margaret Thatcher (1981) on the IRA 
  "A Rose Is Not a Rose", # 1978 film "The Magic of Lassie", by Robert and Richard Sherman
  "Una rosa es una rosa es una rosa", # Spanish translation of Stein's verse, chorus of a song by the pop music group Mecano that appeared on their 1991 album, "Aidalai". 
  "a Rolls is a Rolls is a Rolls",  # Bret Easton Ellis (1991): novel "American Psycho", uttered by narrator Patrick Bateman.  
  "What I am is what I am.", # "A Rose is Still a Rose" was the title of a 1998 album and song by Aretha Franklin and Lauryn Hill 
  "The Things We Did and Didn't Do", # song on The Magnetic Fields album "69 Love Songs" (1999), frontman Stephin Merritt credited the sentence as an inspiration 
  "The Flowers She Sent and the Flowers She Said She Sent", # song on The Magnetic Fields album "69 Love Songs" (1999), frontman Stephin Merritt credited the sentence as an inspiration  
  "murder is murder is murder.", # Mordecai Richler in his novel Barney's Version ridicules the stupidity of court speeches when the prosecutor ends his opening speech with 
  "Sometimes a breast is a breast is a breast.", # Jeanette Winterson wrote in her novel "Written on the Body" 
  "La rosa es una rosa es una rosa", # used in Fernando del Paso's "Sonetos con lugares comunes" 
  "the word for word is word.", # William Burroughs wrote a linguistic variant  
  "A drink is a drink is a drink.", # late-1980s, an American public service announcement featured a message regarding identical alcohol content in three alcoholic drinks — a beer, a mixed drink, and a shot of whiskey 
  "A es A, a rose is a rose is a rose, April is the cruellest month, cada cosa en su lugar y un lugar para cada rosa es una rosa es una rosa...", # Julio Cortazar in his novel "Rayuela" 
  "Eine Rose ist eine Rose ist", # Helge Schneider shortens the sentence in German in his album "29 sehr sehr gute Erzählungen" 
  "A bank isn't a bank isn't a bank.",  # advertisment slogan by South African bank Nedbank 
  "A rose is not a rose is not a rose!", # Jonathan Safran Foer (2003): "Extremely Loud & Incredibly Close"  
  "A bullet’s a bullet’s a bullet!", # Jonathan Safran Foer (2003): "Extremely Loud & Incredibly Close"  
  "Leg is a leg is a leg" # Dr. House in a lecture on diagnosing leg pain in the 2005 House M.D. episode "Three Stories"
)

## Check: 
# flowery

## ToDo: ----------

# - generate ds4psy survey data
# - add text data (Chapter 9: Text; e.g., dinos, fruit, veggies, attention check response on "i read instructions", some eBook for sentinent analysis, ...) 
# - add date/time data (Chapter 10: Time, e.g., DOB, time of test, task start/end, etc.)
# - add more info to codebooks (see data_190807.R in archive)

## eof. ----------------------