## data.R | ds4psy
## hn | uni.kn | 2025 06 10
## Documentation of data sets included in /data. 


# (01) Positive Psychology data: ---------- 

# (01a) posPsy_p_info: ------ 

#' Positive Psychology: Participant data 
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
#' and \doi{10.6084/m9.figshare.1577563.v1} for original dataset. 
#' 
#' Additional references at \url{https://bookdown.org/hneth/ds4psy/B-1-datasets-pos.html}. 

"posPsy_p_info"



# (01b) posPsy_AHI_CESD: ------ 

#' Positive Psychology: AHI CESD data 
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
#' and \doi{10.6084/m9.figshare.1577563.v1} for original dataset. 
#' 
#' Additional references at \url{https://bookdown.org/hneth/ds4psy/B-1-datasets-pos.html}. 

"posPsy_AHI_CESD"



# (01c) posPsy_long: ------ 

#' Positive Psychology: AHI CESD corrected data (in long format) 
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
#' and \doi{10.6084/m9.figshare.1577563.v1} for original dataset. 
#' 
#' Additional references at \url{https://bookdown.org/hneth/ds4psy/B-1-datasets-pos.html}. 

"posPsy_long"



# (01d) posPsy_wide: ------ 

#' Positive Psychology: All corrected data (in wide format) 
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
#' and \doi{10.6084/m9.figshare.1577563.v1} for original dataset. 
#' 
#' Additional references at \url{https://bookdown.org/hneth/ds4psy/B-1-datasets-pos.html}. 

"posPsy_wide"




# (02) False Positive Psychology data: ---------- 

# https://bookdown.org/hneth/ds4psy/B-2-datasets-false.html

#' Data: False Positive Psychology
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
#' doi: \code{10.1177/0956797611417632} 
#' 
#' \item Simmons, J.P., Nelson, L.D., & Simonsohn, U. (2014). 
#' Data from paper "False-Positive Psychology: 
#' Undisclosed Flexibility in Data Collection and Analysis 
#' Allows Presenting Anything as Significant". 
#' \emph{Journal of Open Psychology Data}, \emph{2}(1), e1. 
#' doi: \code{10.5334/jopd.aa} 
#' }
#' 
#' See files at \url{https://openpsychologydata.metajnl.com/articles/10.5334/jopd.aa/} and 
#' the archive at \url{https://zenodo.org/record/7664} for original dataset. 

"falsePosPsy_all"




# (03) Transforming data / dplyr (Chapter 3): outliers ---------- 

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




# (03.14) pi data: --------  

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



# (06) Importing data / readr (Chapter 6): ---------- 

# https://bookdown.org/hneth/ds4psy/6-3-import-essentials.html 

# (06a) data_t1.csv: ---- 
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



# (06b) data_t1_de.csv: ---- 

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
#' \code{data_t1_de} is a fictitious dataset to practice importing data  
#' (from a CSV file, de/European style).  
#' 
#' @format A table with 20 cases (rows) and 4 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/data_t1_de.csv}. 

"data_t1_de"



# (06c) data_t1_tab.csv: ---- 

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
#' \code{data_t1_tab} is a fictitious dataset to practice importing data  
#' (from a TAB file).  
#' 
#' @format A table with 20 cases (rows) and 4 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See TAB-delimited data at \url{http://rpository.com/ds4psy/data/data_t1_tab.csv}. 

"data_t1_tab"



# (06d) data_1.dat: ---- 

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
#' \code{data_1} is a fictitious dataset to practice importing data
#' (from a DELIMITED file).  
#' 
#' @format A table with 100 cases (rows) and 4 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See DELIMITED data at \url{http://rpository.com/ds4psy/data/data_1.dat}. 

"data_1"


# (06e) data_2.dat: ---- 

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
#' \code{data_2} is a fictitious dataset to practice importing data  
#' (from a FWF file).  
#' 
#' @format A table with 100 cases (rows) and 4 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See FWF data at \url{http://rpository.com/ds4psy/data/data_2.dat}. 

"data_2"




# (07) Tidying data / tidyr (Chapter 7): ---------- 

# https://bookdown.org/hneth/ds4psy/7-3-tidy-essentials.html

# (07a) table6.csv: ------ 

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


#' Data: table6
#'
#' \code{table6} is a fictitious dataset to practice reshaping and tidying data.
#' 
#' This dataset is a further variant of the \code{table1} to \code{table5} datasets 
#' of the \bold{tidyr} package.   
#' 
#' @format A table with 6 cases (rows) and 2 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/table6.csv}. 

"table6"



# (07b) table7.csv: ------ 

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


#' Data: table7
#'
#' \code{table7} is a fictitious dataset to practice reshaping and tidying data.
#' 
#' This dataset is a further variant of the \code{table1} to \code{table5} datasets 
#' of the \bold{tidyr} package.    
#' 
#' @format A table with 6 cases (rows) and 1 (horrendous) variable (column). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/table7.csv}. 

"table7"



# (07c) table8.csv: ------ 

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


#' Data: table8 
#'
#' \code{table9} is a fictitious dataset to practice reshaping and tidying data.
#' 
#' This dataset is a further variant of the \code{table1} to \code{table5} datasets 
#' of the \bold{tidyr} package.     
#' 
#' @format A table with 3 cases (rows) and 5 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data at \url{http://rpository.com/ds4psy/data/table8.csv}. 

"table8"



# (07c2) table9: The contingency table tidyr::table2 as a 3-dimensional array (xtabs) ------ 

# # Data from tidyr::table1 as a contingency table (with a dedicated "count" variable): 
# ct <- tidyr::table2  
# 
# # Create 3-dimensional array (xtabs < table):
# table9 <- stats::xtabs(formula = count ~., data = ct)
# dim(table9)  #  3 2 2
# str(table9)
# sum(table9)  # 2940985206


#' Data table9.
#'
#' \code{table9} is a fictitious dataset to practice reshaping and tidying data.
#' 
#' This dataset is a further variant of the \code{table1} to \code{table5} datasets 
#' of the \bold{tidyr} package.     
#' 
#' @format A 3 x 2 x 2 array (of type "xtabs") with 2940985206 elements (frequency counts). 
#' 
#' @family datasets
#' 
#' @source 
#' Generated by using \code{stats::xtabs(formula = count ~., data = tidyr::table2)}. 

"table9"



# (07d) exp_wide.csv: ------ 

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



# (07e) Chapter 7: Exercise 1: 'Four messes and one tidy table': ------ 

# https://bookdown.org/hneth/ds4psy/7-4-tidy-ex.html#tidy:ex01


# (07e1): t_1.csv: ----- 

#' Data: t_1
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



# (07e2): t_2.csv: ----- 

#' Data: t_2
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



# (07e3): t_3.csv: ----- 

#' Data: t_3
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



# (07e4): t_4.csv: ----- 

#' Data: t_4
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



# (08) Joining data / dplyr (Chapter 8): ---------- 

# https://bookdown.org/hneth/ds4psy/8-3-join-essentials.html

# (08a) data_t1.csv: ---- 
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


# (08b) data_t2.csv: ---- 

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

# (08c) t3.csv: ---- 

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


#' Data: t3
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



# (08d) t4.csv: ---- 

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


#' Data: t4
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

# (08e) data_t3.csv: ---- 

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



# (08f) data_t4.csv: ---- 

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




# (09) Text data (Chapter 9): -------- 

# (09a) countries: ---- 

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

#' Data: Names of countries 
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



# (09b) fruits: ---- 

# Source: <https://simple.wikipedia.org/wiki/List_of_fruits>
# fruits
# length(fruits)  # 122

#' Data: Names of fruits 
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



# (09c) flowery phrases: ---- 

#' Data: Flowery phrases 
#'
#' \code{flowery} contains versions and variations 
#' of Gertrude Stein's popular phrase 
#' "A rose is a rose is a rose".  
#' 
#' The phrase stems from Gertrude Stein's poem "Sacred Emily" 
#' (written in 1913 and published in 1922, in "Geography and Plays").  
#' The verbatim line in the poem actually reads 
#' "Rose is a rose is a rose is a rose". 
#' 
#' See \url{https://en.wikipedia.org/wiki/Rose_is_a_rose_is_a_rose_is_a_rose} 
#' for additional variations and sources. 
#' 
#' @format A vector of type \code{character}  
#' with \code{length(flowery) = 60}. 
#' 
#' @family datasets 
#' 
#' @source 
#' Data based on \url{https://en.wikipedia.org/wiki/Rose_is_a_rose_is_a_rose_is_a_rose}.

"flowery"



# (09e) Bushisms: ---- 

#' Data: Bushisms 
#'
#' \code{Bushisms} contains phrases spoken by 
#' or attributed to U.S. president George W. Bush 
#' (the 43rd president of the United States, 
#' in office from January 2001 to January 2009).
#' 
#' @format A vector of type \code{character}  
#' with \code{length(Bushisms) = 22}. 
#' 
#' @family datasets 
#' 
#' @source 
#' Data based on \url{https://en.wikipedia.org/wiki/Bushism}. 

"Bushisms"


# (09e) Trumpisms: ---- 

#' Data: Trumpisms 
#'
#' \code{Trumpisms} contains frequent words and characteristic phrases 
#' by U.S. president Donald J. Trump (the 45th president of the United States, 
#' in office from January 20, 2017, to January 20, 2021). 
#' 
#' @format A vector of type \code{character}  
#' with \code{length(Trumpisms) = 168} 
#' (on 2021-01-28).
#' 
#' @family datasets 
#' 
#' @source 
#' Data originally based on a collection of \emph{Donald Trump's 20 most frequently used words} on \url{https://www.yourdictionary.com}  
#' and expanded by interviews, public speeches, and Twitter tweets from \code{https://twitter.com/realDonaldTrump}. 

"Trumpisms"



# (10) Time data (Chapter 10): --------

# (10a) fame: ---- 

# Fame data (DOB and DOD of famous people):
# Chapter 10 (Time data), Exercise 3
# See Exercise 3 at https://bookdown.org/hneth/ds4psy/10-4-time-ex.html#time:ex03 
# See file all_DATASETs.R for raw data (as tables).

#' Data: fame 
#'
#' \code{fame} is a dataset to practice working with dates.
#'  
#' \code{fame} contains the names, areas, dates of birth (DOB), and 
#' --- if applicable --- the dates of death (DOD) of famous people.
#' 
#' @format A table with 67 cases (rows) and 4 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' Student solutions to exercises, dates mostly from \url{https://www.wikipedia.org/}. 

"fame"



# (10b) exp_num_dt data: ---- 

# Experimental numeracy and date-time (dt) data:

# File is a combination from 2 sources:
# A. numeracy data:
# See generating code chunk "data-create-numeracy-data" in ds4psy_book file "55_datasets.Rmd".
# numeracy <- readr::read_csv("../ds4psy/data-raw/numeracy.csv")  # local csv file
# numeracy <- readr::read_csv("http://rpository.com/ds4psy/data/numeracy.csv")  # online
# numeracy  # 1000 x 12

# B. dt data: 
# See generating code chunk "data-create-time-bday-data" in ds4psy_book file "55_datasets.Rmd".
# dt <- readr::read_csv("../ds4psy/data-raw/dt.csv")  # from local file 
# dt <- readr::read_csv("http://rpository.com/ds4psy/data/dt.csv")  # online file
# dt  # 1000 x 9

## Check: 
# dim(exp_num_dt)  # 1000 observations (rows) x 15 variables (columns)
# sum(is.na(exp_num_dt))  # 130 missing values
#
## 250202: Recode the gender variable into true binary variable:
# table(exp_num_dt$gender)
# exp_num_dt$gender[exp_num_dt$gender == "male"] <- "not female"
# table(exp_num_dt$gender)
#
## Store data:
# usethis::use_data(exp_num_dt, overwrite = TRUE)

#' Data from an experiment with numeracy and date-time variables 
#'
#' \code{exp_num_dt} is a fictitious set of data describing 
#' 1000 non-existing, but surprisingly friendly people. 
#' 
#' \strong{Codebook} 
#' The data characterize 1000 individuals (rows) in 15 variables (columns):
#' 
#' \itemize{
#' 
#' \item 1. \strong{name}: Participant initials.
#' 
#' \item 2. \strong{gender}: Self-identified gender (as a binary variable).
#' 
#' \item 3. \strong{bday}: Day (within month) of DOB.
#' 
#' \item 4. \strong{bmonth}: Month (within year) of DOB.
#' 
#' \item 5. \strong{byear}: Year of DOB.
#' 
#' \item 6. \strong{height}: Height (in cm).
#' 
#' \item 7. \strong{blood_type}: Blood type. 
#'  
#' \item 8. \strong{bnt_1} to 11. \strong{bnt_4}: 
#' Correct response to corresponding BNT question? 
#' (1: correct, 0: incorrect).
#' 
#' \item 12. \strong{g_iq} and 13. \strong{s_iq}: 
#' Scores from two IQ tests (general vs. social).
#' 
#' \item 14. \strong{t_1} and 15. \strong{t_2}: 
#' Study start and end time.
#' 
#' } 
#' 
#' \code{exp_num_dt} was generated for practice purposes. 
#' It allows 
#' (1) converting data tables from wider into longer format, 
#' (2) dealing with date- and time-related variables, and 
#' (3) computing, analyzing, and visualizing test scores (e.g., numeracy, IQ). 
#' 
#' The \code{gender} variable was converted into a binary variable 
#' (i.e., using 2 categories "female" and "not female"). 
#' 
#' @format A table with 1000 cases (rows) and 15 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data files at 
#' \url{http://rpository.com/ds4psy/data/numeracy.csv} and 
#' \url{http://rpository.com/ds4psy/data/dt.csv}. 

"exp_num_dt"



# (10c) dt_10 data: 10 Danish bdays ---- 

## Sources:
# dt_10   <- readr::read_csv("./data-raw/dt_10.csv") # local file
# dt_10_o <- readr::read_csv("http://rpository.com/ds4psy/data/dt_10.csv")  # online
# all.equal(dt_10, dt_10_o)

## Check: 
# dim(dt_10)  # 10 x 7

#' Data from 10 Danish people 
#'
#' \code{dt_10} contains precise DOB information of 
#' 10 non-existent, but definitely Danish people. 
#' 
#' @format A table with 10 cases (rows) and 7 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data file at 
#' \url{http://rpository.com/ds4psy/data/dt_10.csv}. 

"dt_10"



# (11) Function data (Chapter 11): -------- 

# none yet.



# (12) Iteration / loops (Chapter 12): -------- 

# https://bookdown.org/hneth/ds4psy/10-3-iter-essentials.html


# (12a) tb data: ------ 

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
#' \code{tb} is a fictitious set of data describing 
#' 100 non-existing, but otherwise ordinary people.
#' 
#' \strong{Codebook} 
#' 
#' The table contains 5 columns/variables:
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
#' \code{tb} was originally created to practice loops and iterations 
#' (as a CSV file). 
#' 
#' @format A table with 100 cases (rows) and 5 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See CSV data file at \url{http://rpository.com/ds4psy/data/tb.csv}. 

"tb"



# (13) i2ds survey data: ------ 

# Data from i2ds online survey
# URL: https://ww3.unipark.de/uc/i2ds_survey/ 
# 2025-06-10



#' Data from the i2ds online survey 
#'
#' \code{i2ds_survey} contains pre-processed data 
#' from the i2ds online survey.
#' 
#' On 2025-06-01, this data table contains 33 participants (rows) and 112 variables (columns).
#' 
#' @details
#' 
#' The codes for the variable name prefixes are as follows:
#' 
#' \itemize{
#' 
#' \item \strong{rv}: A random variable
#' 
#' \item \strong{c(#)}: A choice variable (with # alternatives)
#' 
#' \item \strong{t}: A text variable (with any input)
#' 
#' \item \strong{tn}: A text variable (with numeric input)
#' 
#' \item \strong{crs}: A course-related variable
#' 
#' \item \strong{combined}: The prefix "combined" refers to composite variables created by averaging either 4 or 5 individual Likert-scale items.
#' Depending on the item set, the resulting score was normalized (i.e., divided by 4 or 5), and stored as a new variable.
#' }
#' 
#' \strong{Variables}
#' 
#' The variable names and their contents are as follows:
#' 
#' \itemize{
#' 
#' \item 1. \code{rv_anchor_high_low} A randomized (character) variable that indicates whether a person is to keep a relatively large or small number in memory (i.e., assignment to either 242 or 42, respectively). This manipulation is used to examine anchoring effects on later responses.
#' 
#' \item 2. \code{rv_scale_randomization} A randomized (character) variable that indicates whether a person was asked to rate XXX on a 4-point or 5-point Likert scale. The variable controls for the influence of scale granularity on ratings
#' 
#' \item 3. \code{rv_barnum_pos_neg} A randomized (character) variable that indicates whether the participant is to receiv a positive or negative Barnum statement ("positive" vs. "negative"). This is used to measure sensitivity to vague or generic personality feedback.
#' 
#' \item 4. \code{rv_sc_false_dicho_3}   A randomized (character) variable indicating which version of the scale is to be shown: a dichotomous comparison between admiration vs. respect, fear vs. love, admiration vs. love and fear, or a single undivided scale (values: "admir_resp"  "fear_love", "admir_love" fear_resp", "single_scale"). Used to examine how scale format affects evaluative judgments.
#' 
#' \item 5. \code{rv_wait_time} A randomized (character) variable that indicates whether the participant waited 10 seconds ("short") or 30 seconds ("long") before continuing. This manipulation aims to examine whether a longer waiting period increases the perceived credibility or value of a following personality feedback, in line with mechanisms underlying the Barnum effect.
#' 
#' \item 6. \code{rv_political_orientation} A randomized (character) variable indicating the order in which the two political orientation scales ("left–right" and "liberal–conservative") were presented. Possible values include "left_right, lib_cons", "left_cons, lib_right", etc. This variable is used to control for potential order effects in political self-placement tasks.
#' 
#' \item 7. \code{rv_thinkingstyle} A randomized (character) variable that indicates the order in which pairs of thinking styles are to be presented ("deliberative vs. intuitive"; "reflective vs. spontaneous";" deliberative vs. spontaneous";"reflective vs. Intuitive"). The order is counterbalanced to reduce presentation bias in self-assessment tasks.
#' 
#' \item 8. \code{c2_informed_consent}  A logical variable indicating whether the participant gave informed consent before proceeding with the study (TRUE = consent given, FALSE = not given). This variable ensures ethical compliance.
#' 
#' \item 9. \code{c2_img_sel_1}  A numeric (double) variable that represents the participant's selection between two images in choice Set 1 (1 = left image, 2 = right image). The variable captures image preferences in a binary format.
#' 
#' \item 10. \code{c2_img_sel_2}  A numeric (double) variable that represents the participant's selection between two images in choice Set 2 (1 = left image, 2 = right image).
#' 
#' \item 11. \code{c2_img_sel_3} A numeric (double) variable that represents the participant's selection between two images in choice Set 3 (1 = left image, 2 = right image).
#' 
#' \item 12. \code{c2_img_sel_4} A numeric (double) variable that represents the participant's selection between two images in choice Set 4 (1 = left image, 2 = right image).
#' 
#' \item 13. \code{c7_eating_habits} A categorical (character) variable that indicates which dietary lifestyle the participant follows (1 = "vegetarian"; 2 = "omnivore"; 3 = "vegan"; 4 = "pescetarian"; 5 = "flexitarian"; 6 = "carnivore"; 7 = "other"). 
#' 
#' \item 14. \code{t_eating_habits_other} A character variable intended to capture free-text input for other dietary descriptions; usually NA unless "other" was selected. May appear as logical if no responses were entered.
#' 
#' \item 15. \code{c7_apple} A numeric (double) variable indicating how much the participant likes apples on a 1-7 scale (1 = low preference 7 = high preference).
#' 
#' \item 16. \code{c7_cherry} A numeric (double) variable indicating how much the participant likes cherries on a 1-7 scale (1 = low preference 7 = high preference).
#' 
#' \item 17. \code{c7_broccoli} A numeric (double) variable indicating how much the participant likes broccoli on a 1-7 scale (1 = low preference 7 = high preference).
#' 
#' \item 18. \code{c7_asparagus} A numeric (double) variable indicating how much the participant likes asparagus on a 1-7 scale (1 = low preference 7 = high preference).
#' 
#' \item 19. \code{c7_spinach} A numeric (double) variable indicating how much the participant likes spinach on a 1-7 scale (1 = low preference 7 = high preference).
#'
#' \item 20. \code{c7_mud} A numeric (double) variable indicating how much the participant likes mud on a 1-7 scale (1 = low preference 7 = high preference). 
#'
#' \item 21. \code{c7_banana} A numeric (double) variable indicating how much the participant likes bananas on a 1-7 scale (1 = low preference 7 = high preference).
#'
#' \strong{Note}: Variables \code{c7_apple} to \code{c7_banana} were derived from a sorting task in which participants ordered food items by preference. 
#' Each item was subsequently coded as a numeric value between 1 and 7.
#'
#' \item 22. \code{c2_decsleep_instant} A categorical (character) variable indicating whether the participant prefers to sleep before making important decisions ("sleep") or to make them instantly ("instant"). 
#'
#' \item 23. \code{c2_shopperson_online} A categorical (character) variable indicating whether the participant prefers shopping in person ("person") or online ("online").
#' 
#' \item 24. \code{c2_town_city} A categorical (character) variable indicating whether the participant prefers living in a town ("town") or in a city ("city"). 
#' 
#' \item 25. \code{c2_club_house} A categorical (character) variable indicating whether the participant prefers to party in a club ("club") or to attend an house party ("house").
#' 
#' \item 26. \code{c2_hotel_camping} A categorical (character) variable capturing preference for staying in a hotel ("hotel") versus going camping ("camping"). 
#' 
#' \item 27. \code{c2_photo_being} A categorical (character) variable indicating whether the participant prefers photographing ("photo") or being in a moment ("being"). 
#' 
#' \item 28. \code{c2_spring_fall} A categorical (character) variable indicating whether the participant prefers the spring season ("spring") or the fall/autumn season ("fall").
#' 
#' \item 29. \code{c2_beach_mount} A categorical (character) variable reflecting whether the participant prefers the beach ("beach") or the mountains ("mount"). 
#' 
#' \item 30. \code{c2_cats_dogs} A categorical (character) variable indicating preference for cats ("cats") versus dogs ("dogs").
#' 
#' \item 31. \code{c2_indiv_team} A categorical (character) variable indicating whether the participant prefers individual ("indiv") or team sports ("team").
#' 
#' \item 32. \code{c2_movies_books} A categorical (character) variable indicating preference for movies ("movies") or books ("books").
#' 
#' \item 33. \code{c2_board_video} A categorical (character) variable indicating whether the participant prefers board games ("board") or video games ("video").
#' 
#' \item 34. \code{c2_ios_android} A categorical (character) variable indicating whether the participant prefers iOS ("ios") or Android ("android") as a mobile operating system.
#' 
#' \item 35. \code{c2_text_voice} A categorical (character) variable indicating whether the participant prefers texting ("text") or sending voice messages ("voice").
#' 
#' \item 36. \code{c2_cook_bake} A categorical (character) variable indicating whether the participant prefers cooking ("cook") or baking ("bake").
#' 
#' \item 37. \code{c2_pinapple_no} A categorical (character) variable that records whether the participant likes pineapple on pizza ("yes") or not ("no").
#' 
#' \item 38. \code{c2_ketchup_mayo} A categorical (character) variable indicating whether the participant prefers ketchup ("ketchup") or mayonnaise ("mayo").
#'
#' \item 39. \code{c2_coffee_tea} A categorical (character) variable indicating whether the participant prefers coffee ("coffee") or tea ("tea").
#'
#' \item 40. \code{c2_math_lang} A categorical (character) variable indicating whether the participant prefers mathematics ("math") or language-related subjects ("lang"). 
#'
#' \item 41. \code{c2_odd_even} A categorical (character) variable indicating whether the participant prefers odd numbers ("odd") or even numbers ("even"). 
#'
#' \item 42. \code{c3_diff_bin} A categorical (character) variable indicating how difficult it was for the participant to make their previous preference decisions (item 22 - 41) . Response options include "yes", "a little", and "no". This item captures perceived decisional difficulty and may serve as an indicator of response certainty or task engagement.
#' 
#' \item 43. \code{politics_left}  A numeric (double) variable representing the participant’s self-placement on a left–right political spectrum. Values range from 1 ("left") to 6 ("right").
#' 
#' \item 44. \code{politics_liberal}  A numeric (double) variable representing self-placement on a liberal to conservative scale, from 1 (liberal) to 6 (conservative). 
#' 
#' \item 45. \code{tn_estimate_sun}  A numeric (double) variable capturing the participant’s estimate of how many times larger the sun’s diameter is compared to that of the earth. This item serves as a manipulation check for the anchoring effect, based on previously presented numeric anchors (e.g., 42 or 242). 
#' 
#' \item 46. \code{t_att_check_1}  A character variable containing the participant’s open-text response to an attention check prompt (“Please type: I read the instructions”). Used to detect inattentive or automated responses.
#' 
#' \item 47. \code{c2_fly_invisible} A categorical (character) variable indicating whether the participant would prefer the superpower of flying ("fly") or becoming invisible ("invisible"). 
#' 
#' \item 48. \code{t_fly_invisible_explain}  A character variable where participants explain their choice between flying and invisibility. This allows for qualitative analysis of motivational reasoning.
#' 
#' \item 49. \code{combined_c_ser_hum_self} A numeric (double) variable reflecting the participant’s self-assessment on a "serious vs. humorous" scale. The score is based on a 4-point or 5-point Likert scale, depending on random assignment. This variable is used to test how scale format (presence vs. absence of a middle option) influences self-ratings.
#' 
#' \item 50. \code{combined_c_ser_hum_others} A combined numeric (double) variable   reflecting how humorous or serious participants believe others perceive them. This score is derived from either a 4-point or 5-point scale and is used to examine the effect of scale design on perceived external ratings. 
#'
#' \item 51. \code{c4_chronotype}  A categorical (character) variable indicating whether the participant identifies as a morning person ("morning"), evening person ("evening") mid-day person ("mid-day") or a never person ("never"). 
#' 
#' \item 52. \code{tn_sleep} A numeric (double) variable indicating the typical number of hours the participant typically sleeps per night. 
#' 
#' \item 53. \code{tn_bedtime} A character variable representing the participant’s usual bedtime, entered in 24-hour format (e.g., "22:30", "00:00"). 
#' 
#' \item 54. \code{tn_anchor_recall_1} A numeric (double) variable recording the number (either 42 or 242) that participants were previously asked to memorize and later recall. It is used to test memory for the anchor manipulation.
#' 
#' \item 55. \code{combined_admired} A combined numeric (double) variable reflecting how much the participant wants to be admired by others. Rated on a 1–6 Likert scale (1 = not at all, 6 = very much).
#' 
#' \item 56. \code{combined_feared} A combined numeric (double) variable reflecting how much the participant wants to be feared by others. Rated on a 1–6 Likert scale (1 = not at all, 6 = very much).
#' 
#' \item 57. \code{combined_loved} A combined numeric (double) variable reflecting how much the participant wants to be loved by others. Rated on a 1–6 Likert scale (1 = not at all, 6 = very much).
#'
#' \item 58. \code{combined_respected}  A combined numeric (double) variable reflecting how much the participant wants to be respected by others. Rated on a 1–6 Likert scale (1 = not at all, 6 = very much).
#'
#' \item 59. \code{c7_pess_opti} A numeric (double) variable capturing the participant’s self-rated tendency toward pessimism versus optimism, on a 7-point scale (1 = very pessimistic, 7 = very optimistic). 
#'
#' \item 60. \code{c7_story_list} A numeric (double)  variable indicating how much the participant enjoys listening to or reading stories, rated from 1 (not at all) to 7 (very much). 
#'
#' \item 61. \code{c7_stab_adv} A numeric (double) variable indicating the participant’s self-assessed position on a stability versus adventurousness spectrum, typically from 1 (very stable) to 7 (very adventurous). This measures personality traits related to risk-taking.
#' 
#' \item 62. \code{think_reflect} A numeric (double) variable representing the participant’s placement on a bipolar scale from "reflective" (1) to either "spontaneous" or " intuitive" (6). The specific version of the scale was randomly assigned. 
#' 
#' \item 63. \code{think_delib} A numeric (double) variable representing the participant’s placement on a bipolar scale from "deliberative" (1) to either "intuitive" or " spontaneous" (6). The specific version of the scale was randomly assigned. 
#' 
#' \item 64. \code{c4_intro_extrovert} A categorical (character) variable indicating the participant's self-rated social orientation: "introverted", "extroverted", or mixed forms such as "extro-intro" or "intro-extro". 
#' 
#' \item 65. \code{tn_favorit_number} A numeric (double) variable capturing the participant’s favorite number, freely entered. 
#' 
#' \item 66. \code{c3_cutlery} A categorical (character) variable indicating which piece of cutlery the participant most identifies with. Possible values include "knife", "fork", and "spoon". 
#' 
#' \item 67. \code{c3_rock_paper_scissors} A categorical (character) variable capturing the participant's selection in a rock–paper–scissors scenario: "rock", "paper", or "scissors".
#' 
#' \item 68. \code{c5_att_check_2} A numeric (double) variable used as an attention check. Participants were asked to select the number that most resembles the shape of a circle. The correct response is "0", which corresponds to scale point 5. Responses deviating from this may indicate inattentiveness.
#' 
#' \item 69. \code{c6_barnum_accuracy} A numeric (double) variable indicating how accurately the participant rated a generic personality description (i.e., a Barnum statement), 
#' on a scale from 1 (poor) to 6 (perfect). 
#' This variable is used to assess susceptibility to the so-called Barnum effect (i.e., the tendency to perceive vague and general statements as highly accurate). 
#' 
#' \item 70. \code{t_anchor_recall_2} A numeric (double) variable recording whether the participant correctly remembered a previously presented number (either 42 or 242). It assesses memory and anchoring manipulation success.
#'
#' \item 71. \code{c4_gender} A categorical (character) variable indicating the participant’s gender identity, with possible values including "female", "male", "non-binary" or "do not wish to respond". This variable is used for demographic analysis.
#'
#' \item 72. \code{tn_day} A numeric (double)variable indicating the day of birth provided by the participant (1–31). Used for demographic purposes and potential exploratory analyses. 
#'
#' \item 73. \code{tn_month} A numeric (double) variable indicating the participant’s birth month (1–12). This also supports demographic profiling. 
#' 
#' \item 74. \code{tn_year} A numeric (double) variable indicating the year of birth (e.g., 2001, 2003). This is used to calculate age and analyze age-related trends. 
#' 
#' \item 75. \code{t_height} A character variable where participants entered their height, using various formats (e.g., "180", "180 cm", "1,80m"). This variable may require preprocessing for analysis.
#' 
#' \item 76. \code{c9_occupation} A categorical (character) variable indicating the participant’s current occupational status (e.g., "student", "employed", "other"). This is used for demographic segmentation. 
#' 
#' \item 77. \code{t_occupation_other} A logical variable for free-text input if the participant selected "other" for occupation. This captures detailed occupational descriptions not covered by predefined options.
#' 
#' \item 78. \code{c7_education} A categorical (character) variable indicating the participant’s highest completed education level (e.g., "high school", "bachelor", "master"). Used for education-related subgroup analysis.
#' 
#' \item 79. \code{t_education_other} A logical variable where participants could enter their education level in free text if "other" was selected. Enables open-format responses for less common education paths.
#' 
#' \item 80. \code{c3_current_degree} A categorical (character) variable indicating the type of academic degree the participant is currently pursuing (e.g, "bachelor", "master"). This provides educational context for other academic measures.
#' 
#' \item 81. \code{tn_semester} A numeric (double) variable indicating the current semester of study reported by the participant (e.g., 1, 6, 10). This variable helps contextualize course experience and academic progress.
#'
#' \item 82. \code{c14_studyfield} A categorical (character) variable indicating the participant’s field of study (e.g., "psychology", "data science"). This is used to examine field-specific attitudes and skills.
#'
#' \item 83. \code{t_studyfield_other} A character variable capturing free-text responses if the participant selected "other" as their study field. This allows classification of less common disciplines. 
#'
#' \item 84. \code{crs_i2ds_1} A logical variable indicating whether the participant is currently enrolled in the course "Introduction to Data Science 1" (TRUE = enrolled). 
#'
#' \item 85. \code{crs_i2ds_2} A logical variable indicating whether the participant is enrolled in the course "Introduction to Data Science 2" (TRUE = enrolled). 
#' 
#' \item 86. \code{crs_ds4psy} A logical variable indicating whether the participant is enrolled in the course "Data Science for Psychology" (TRUE = enrolled).
#' 
#' \item 87. \code{crs_diff_kn} A logical variable indicating whether the participant is enrolled in a different course at the University of Konstanz (TRUE = yes). 
#' 
#' \item 88. \code{crs_diff_else} A logical variable indicating whether the participant is enrolled in a different course outside the University of Konstanz (TRUE = yes). Helps distinguish external learners.
#' 
#' \item 89. \code{crs_self_study} A logical variable indicating whether the participant is engaging with course materials without formal enrollment (TRUE = yes). Reflects informal learning engagement.
#' 
#' \item 90. \code{crs_only_study} A logical variable indicating whether the participant is taking the survey only, without engaging with course materials (TRUE = yes). Identifies non-learning participants.
#'
#' \item 91. \code{t_crs_other} A character variable capturing free-text input describing any other course the participant is taking. 
#' 
#' \item 92. \code{v_crs_other_dept} A character variable indicating the department of the other course(s) mentioned in \code{t_crs_other}. It helps group participants by academic discipline.
#' 
#' \item 93. \code{c5_pref_stats} A numeric (double) variable indicating the participant’s  interest in preparing data for statistical analysis, rated on a scale from 1 (no interest) to 5 (absolutely essential).
#'
#' \item 94. \code{c5_pref_visualize} A numeric (double) variable indicating the participants interest in data visualization in R, rated on a scale from 1 (no interest) to 5 (absolutely essential).
#'
#' \item 95. \code{c5_pref_sims} A numeric (double) variable indicating the participant’s interest in using R for simulations and modeling, rated on a scale from 1 (no interest) to 5 (absolutely essential).
#'
#' \item 96. \code{c5_pref_shiny} A numeric (double) variable capturing how essential the participant considers learning to build interactive web applications using R Shiny. Responses range from 1 (no interest) to 5 (absolutely essential).
#'
#' \item 97. \code{c5_pref_scrape} A numeric (double) variable capturing how essential the participant considers learning web scraping with R. Responses range from 1 (no interest) to 5 (absolutely essential).
#' 
#' \item 98. \code{c5_pref_arts} A numeric (double) variable capturing how essential the participant considers exploring artistic or creative aspects of data science (e.g., generative art in R). Responses range from 1 (no interest) to 5 (absolutely essential).
#' 
#' \item 99. \code{t_crs_expect_i2ds_1} A character variable containing free-text input describing the participant’s expectations and hopes for the course "Introduction to Data Science 1". 
#'
#' \item 100. \code{t_crs_worry_i2ds_1} A character variable capturing free-text responses regarding worries and reservations related to "Introduction to Data Science 1". 
#' 
#' \item 101. \code{t_crs_expect_i2ds_2} A character variable containing free-text input describing the participant’s expectations and hopes for the course "Introduction to Data Science 2". 
#' 
#' \item 102. \code{t_crs_worry_i2ds_2} A character variable capturing free-text input about worries and reservations concerns related to "Introduction to Data Science 2". 
#' 
#' \item 103. \code{t_crs_expect_ds4psy} A logical variable containing free-text input describing the participant’s expectations and hopes for the course "Data Science for Psychology". 
#' 
#' \item 104. \code{t_crs_worry_ds4psy} A logical variable capturing worries and reservations regarding "Data Science for Psychology", written in free text. 
#' 
#' \item 105. \code{c6_exp_math} A numeric (double) variable indicating the participant’s self-rated prior experience with mathematics, on a scale from 1 (no experience) to 6 (extremely experienced). 
#' 
#' \item 106. \code{c6_exp_statistics} A numeric (double) variable measuring the participant’s self-assessed experience with statistics, ranging from 1 (no experience) to 6 (extremely experienced). 
#' 
#' \item 107. \code{c6_exp_program} A numeric (double) variable indicating the participant’s experience with programming (any programming language), rated on a 1–6 scale (1 = no experience, 6 = extremely expercienced).
#' 
#' \item 108. \code{c6_exp_r} A numeric (double) variable indicating the participant’s experience with R programming, from 1 (no experience) to 6 (extremely experienced). 
#' 
#' \item 109. \code{c6_exp_datavisual} A numeric (double) variable capturing the participant’s prior experience with data visualization, on a scale from 1 (no experience) to 6 (extremely experienced). 
#' 
#' \item 110. \code{c2_use_data_2} A logical variable indicating whether the participant agrees to allow their data to be used for secondary analyses (TRUE = consent given). This governs data reusability in research.
#' 
#' \item 111. \code{t_pid} A character variable optionally capturing a participant ID, pseudonym, or other identifying entry. This field ís used for the participants to be able to recognize their data later in the course.
#' 
#' \item 112. \code{t_feedback} A character variable containing general feedback provided by the participant regarding the study or course. This is an open-ended item for final impressions or suggestions.
#' 
#' }
#' 
#' See the codebook and print version for additional coding details.
#' 
#' \strong{Missing values} in the dataset are represented as \code{NA} values. 
#' These indicate that a participant did not provide a response or that the question was not applicable. 
#' 
#' @format A table with 33 participants (rows) and 112 variables (columns). 
#' 
#' @family datasets
#' 
#' @source 
#' See online survey at \url{https://ww3.unipark.de/uc/i2ds_survey/}. 


"i2ds_survey"


# +++ here now +++


## Check data: ------ 

## Check for "marked UTF-8 strings":

# tools:::.check_package_datasets(".")



## ToDo: ----------

# - Add date/time data (Chapter 10: Time, e.g., DOB, time of test, task start/end, etc.)
# - Combine 2 datasets (currently online):
#   a. numeracy.csv (1000 x 12, see book chapter 55_datasets.Rmd), 
#   b. dt.csv (1000 x 9): date and time variables (see book chapter 10_times.Rmd)
# - Consider combining with dataset `outliers` (1000 x 3), BUT: different genders and height values and regularities
# - Collect ds4psy survey data
# - Find some book/text to analyze (Chapter 9: Text data).
# - Add text data (Chapter 9: Text; e.g., dinos, fruit, veggies, attention check response on "i read instructions", some eBook for sentinent analysis, ...) 
# - Add more info to codebooks (see data_190807.R in archive)

## eof. ----------------------