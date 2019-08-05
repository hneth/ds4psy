## data.R | ds4psy
## hn | uni.kn | 2019 08 05
## ---------------------------

## Documentation of datasets included in /data. 

# (1) Positive Psychology: ---------- 

# (1a) posPsy_p_info: ---------- 

#' Positive Psychology: Participant data.
#'
#' A dataset containing details of 295 participants. 
#'
#' @format A tibble with 295 cases (rows) and 6 variables (columns).
#'  
#' \strong{Codebook}  
#' 
#' \describe{
#'   \item{id}{Participant ID.}
#'   \item{intervention}{Type of intervention: 
#'   3 positive psychology interventions (PPIs), plus 1 control condition: 
#'     1 = “Using signature strengths”, 
#'     2 = “Three good things”, 
#'     3 = “Gratitude visit”, 
#'     4 = “Recording early memories” (control condition).}
#'   \item{sex}{Sex: 1 = female, 2 = male.}
#'   \item{age}{Age (in years).}
#'   \item{educ}{Education level: Scale from 1 - less than 12 years, to 5 = postgraduate degree.}
#'   \item{income}{Income: Scale from 1 = below average, to 3 = above average.} 
#' }
#' 
#' @family datasets
#' 
#' @source 
#' \strong{Articles}
#' 
#' Woodworth, R. J., O’Brien‐Malone, A., Diamond, M. R., & Schüz, B. (2017). 
#' Web‐based positive psychology interventions: A reexamination of effectiveness. 
#' \emph{Journal of Clinical Psychology}, \emph{73}(3), 218–232. 
#' doi: \code{10.1002/jclp.22328} 
#' 
#' Woodworth, R. J., O’Brien-Malone, A., Diamond, M. R. and Schüz, B. (2018). 
#' Data from, ‘Web-based positive psychology interventions: A reexamination of effectiveness’. 
#' \emph{Journal of Open Psychology Data}, \emph{6}(1). 
#' doi: \code{10.5334/jopd.35} 
#' 
#' \strong{Data}
#' 
#' See details at \url{https://doi.org/10.6084/m9.figshare.1577563.v1}.  

"posPsy_p_info"

# (1b) posPsy_AHI_CESD: ---------- 

#' Positive Psychology: AHI_CESD data.
#'
#' This dataset contains answers to the 24 items of the 
#' Authentic Happiness Inventory (AHI) and answers to the 
#' 20 items of the Center for Epidemiological Studies Depression (CES-D) scale 
#' (see Radloff, 1977) for multiple (1 to 6) measurement occasions. 
#' 
#' @format A tibble with 992 cases (rows) and 50 variables (columns).
#'  
#' \strong{Codebook} 
#' 
#' 1. id: Particpant ID. 
#' 
#' 2. occasion: Measurement occasion:  
#'   0 = Pretest (i.e., at enrolment),
#'   1 = Posttest (i.e., 7 days after pretest),
#'   2 = 1-week follow-up, (i.e., 14 days after pretest, 7 days after posttest),
#'   3 = 1-month follow-up, (i.e., 38 days after pretest, 31 days after posttest),
#'   4 = 3-month follow-up, (i.e., 98 days after pretest, 91 days after posttest),
#'   5 = 6-month follow-up, (i.e., 189 days after pretest, 182 days after posttest).
#' 
#' 3. elapsed.days: Time since enrolment measured in fractional days. 
#' 
#' 4. intervention: Intervention group (1 to 4). 
#' 
#' - Block ahi01–ahi24: Responses on 24 AHI items. 
#' 
#' - Block cesd01–cesd20: Responses on 20 CES-D items. 
#' 
#' 49. ahiTotal: Total AHI score. 
#' 
#' 50. cesdTotal: Total CES-D score. 
#' 
#' @family datasets
#' 
#' @seealso 
#' \code{\link{posPsy_long}} for a corrected version of this file (in long format). 
#' 
#' @source 
#' \strong{Articles}
#' 
#' Woodworth, R. J., O’Brien‐Malone, A., Diamond, M. R., & Schüz, B. (2017). 
#' Web‐based positive psychology interventions: A reexamination of effectiveness. 
#' \emph{Journal of Clinical Psychology}, \emph{73}(3), 218–232. 
#' doi: \code{10.1002/jclp.22328} 
#' 
#' Woodworth, R. J., O’Brien-Malone, A., Diamond, M. R. and Schüz, B. (2018). 
#' Data from, ‘Web-based positive psychology interventions: A reexamination of effectiveness’. 
#' \emph{Journal of Open Psychology Data}, \emph{6}(1). 
#' doi: \code{10.5334/jopd.35} 
#' 
#' \strong{Data}
#' 
#' See details at \url{https://doi.org/10.6084/m9.figshare.1577563.v1}.  

"posPsy_AHI_CESD"

# (1c) posPsy_long: ---------- 

#' Positive Psychology: AHI_CESD corrected data (in long format). 
#'
#' This dataset contains answers to the 24 items of the 
#' Authentic Happiness Inventory (AHI) and answers to the 
#' 20 items of the Center for Epidemiological Studies Depression (CES-D) scale 
#' (see Radloff, 1977) for multiple (1 to 6) measurement occasions.
#' 
#' @format A tibble with 990 cases (rows) and 50 variables (columns).
#'  
#' \strong{Codebook}  
#' 
#' See \code{\link{posPsy_AHI_CESD}}.
#' 
#' 
#' @family datasets
#' 
#' @seealso 
#' \code{\link{posPsy_AHI_CESD}} for source of this file, 
#' \code{\link{posPsy_wide}} for a version of this file (in wide format). 
#' 
#' @source 
#' \strong{Articles}
#' 
#' Woodworth, R. J., O’Brien‐Malone, A., Diamond, M. R., & Schüz, B. (2017). 
#' Web‐based positive psychology interventions: A reexamination of effectiveness. 
#' \emph{Journal of Clinical Psychology}, \emph{73}(3), 218–232. 
#' doi: \code{10.1002/jclp.22328} 
#' 
#' Woodworth, R. J., O’Brien-Malone, A., Diamond, M. R. and Schüz, B. (2018). 
#' Data from, ‘Web-based positive psychology interventions: A reexamination of effectiveness’. 
#' \emph{Journal of Open Psychology Data}, \emph{6}(1). 
#' doi: \code{10.5334/jopd.35} 
#' 
#' \strong{Data}
#' 
#' See details at \url{https://doi.org/10.6084/m9.figshare.1577563.v1}.  

"posPsy_long"

# (1d) posPsy_wide: ---------- 

#' Positive Psychology: All corrected data (in wide format). 
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
#' Woodworth, R. J., O’Brien‐Malone, A., Diamond, M. R., & Schüz, B. (2017). 
#' Web‐based positive psychology interventions: A reexamination of effectiveness. 
#' \emph{Journal of Clinical Psychology}, \emph{73}(3), 218–232. 
#' doi: \code{10.1002/jclp.22328} 
#' 
#' Woodworth, R. J., O’Brien-Malone, A., Diamond, M. R. and Schüz, B. (2018). 
#' Data from, ‘Web-based positive psychology interventions: A reexamination of effectiveness’. 
#' \emph{Journal of Open Psychology Data}, \emph{6}(1). 
#' doi: \code{10.5334/jopd.35} 
#' 
#' \strong{Data}
#' 
#' See details at \url{https://doi.org/10.6084/m9.figshare.1577563.v1}.  

"posPsy_wide"


# (2) False Positive Psychology: ---------- 

# https://bookdown.org/hneth/ds4psy/B-2-datasets-false.html

#' False Positive Psychology data.
#'
#' A dataset containing the data from 2 studies designed to 
#' highlight problematic research practices within psychology. 
#' Simmons, Nelson and Simonsohn (2011) published a controversial article 
#' with a necessarily false finding. By conducting simulations and 2 simple behavioral experiments, 
#' the authors show that flexibility in data collection, analysis, and reporting 
#' dramatically increases the rate of false-positive findings. 
#'
#' @format A tibble with 78 cases (rows) and 19 variables (columns):
#' 
#' \strong{Codebook} 
#' 
#' \describe{
#'   \item{study}{Study ID.}
#'   \item{id}{Participant ID.}
#'   \item{aged}{Days since participant was born (based on their self-reported birthday).}
#'   \item{aged365}{Age in years.}
#'   \item{female}{Is participant a woman? 1: yes, 2: no.}
#'   \item{dad}{Father's age (in years).}
#'   \item{mom}{Mother's age (in years).}
#'   \item{potato}{Did the participant hear the song ‘Hot Potato’ by The Wiggles? 1: yes, 2: no.}
#'   \item{when64}{Did the participant hear the song ‘When I am 64’ by The Beatles? 1: yes, 2: no.}      
#'   \item{kalimba}{Did the participant hear the song ‘Kalimba’ by Mr. Scrub? 1: yes, 2: no.}
#'   \item{cond}{In which condition was the participant? 
#'   - control: Subject heard the song ‘Kalimba’ by Mr. Scrub; 
#'   - potato: Subject heard the song ‘Hot Potato’ by The Wiggles; 
#'   - 64: Subject heard the song ‘When I am 64’ by The Beatles.}
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
#'   \item{diner}{Imagine you were going to a diner for dinner tonight, 
#'   how much do you think you would like the food? 
#'   Scale from 1: dislike extremely, to 9: like extremely.}
#'   }
#' 
#' @family datasets
#' 
#' @source 
#' \strong{Articles}
#' 
#' Simmons, J.P., Nelson, L.D., & Simonsohn, U. (2011). 
#' False-positive psychology: Undisclosed flexibility in data collection and analysis 
#' allows presenting anything as significant. 
#' \emph{Psychological Science}, \emph{22}(11), 1359–1366. 
#' doi: \url{https://doi.org/10.1177/0956797611417632}
#' 
#' Simmons, J.P., Nelson, L.D., & Simonsohn, U. (2014). 
#' Data from paper “False-Positive Psychology: 
#' Undisclosed Flexibility in Data Collection and Analysis 
#' Allows Presenting Anything as Significant”. 
#' \emph{Journal of Open Psychology Data}, \emph{2}(1), e1. 
#' doi: \url{http://doi.org/10.5334/jopd.aa} 
#' 
#' \strong{Data}
#' 
#' Download files at \url{https://openpsychologydata.metajnl.com/articles/10.5334/jopd.aa/}.
#' 
#' Zip-archive at \url{https://zenodo.org/record/7664}.

"falsePosPsy_all"


## ToDo: ----------

## eof. ----------------------