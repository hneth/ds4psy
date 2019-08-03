## data.R | ds4psy
## hn | uni.kn | 2019 08 03
## ---------------------------

## Documentation of datasets. 

# (1) Positive Psychology: ---------- 

# (1a) posPsy_p_info: ---------- 

#' Positive Psychology: Participant data.
#'
#' A dataset containing details of 295 participants. 
#'
#' @format A tibble with 295 cases (rows) and 6 variables (columns):
#' \describe{
#'   \item{id}{Participant ID.}
#'   \item{intervention}{Type of intervention: 1-3: PPI, 4: control condition.}
#'   \item{sex}{Sex: 1 = female, 2 = male.}
#'   \item{age}{Age in years.}
#'   \item{educ}{Education level: 1: less than 12 years, 5: Postgraduate degree.}
#'   \item{income}{Income: 1: below average, 3: above average.}
#' }
#' 
#' @source 
#' Woodworth, R. J., O’Brien‐Malone, A., Diamond, M. R., & Schüz, B. (2017). 
#' Web‐based positive psychology interventions: A reexamination of effectiveness. 
#' Journal of Clinical Psychology, 73(3), 218–232. doi: 10.1002/jclp.22328
#' 
#' Woodworth, R. J., O’Brien-Malone, A., Diamond, M. R. and Schüz, B. (2018). 
#' Data from, ‘Web-based positive psychology interventions: A reexamination of effectiveness’. 
#' Journal of Open Psychology Data, 6: 1. doi: 10.5334/jopd.35
#' 
#' See details at \url{https://doi.org/10.6084/m9.figshare.1577563.v1}.  

"posPsy_p_info"

# (1b) posPsy_AHI_CESD: ---------- 

#' Positive Psychology: AHI_CESD data.
#'
#' This dataset contains answers to the 24 items of the 
#' Authentic Happiness Inventory (AHI) and answers to the 
#' 20 items of the Center for Epidemiological Studies Depression (CES-D) scale 
#' (see Radloff, 1977) for multiple (1 to 6) measurement occasions:
#' 
#' 1. id: Particpant ID
#' 
#' 2. occasion: Measurement occasion:
#'   0 = Pretest (i.e., at enrolment),
#'   1 = Posttest (i.e., 7 days after pretest),
#'   2 = 1-week follow-up, (i.e., 14 days after pretest, 7 days after posttest),
#'   3 = 1-month follow-up, (i.e., 38 days after pretest, 31 days after posttest),
#'   4 = 3-month follow-up, (i.e., 98 days after pretest, 91 days after posttest),
#'   5 = 6-month follow-up, (i.e., 189 days after pretest, 182 days after posttest).
#' 
#' 3. elapsed.days: Time since enrolment measured in fractional days
#' 
#' 4. intervention: Intervention group (1 to 4)
#' 
#' - ahi01–ahi24: Responses on 24 AHI items
#' 
#' - cesd01–cesd20: Responses on 20 CES-D items
#' 
#' - ahiTotal: Total AHI score
#' 
#' - cesdTotal: Total CES-D score
#' 
#' 
#' @source 
#' Woodworth, R. J., O’Brien‐Malone, A., Diamond, M. R., & Schüz, B. (2017). 
#' Web‐based positive psychology interventions: A reexamination of effectiveness. 
#' Journal of Clinical Psychology, 73(3), 218–232. doi: 10.1002/jclp.22328
#' 
#' Woodworth, R. J., O’Brien-Malone, A., Diamond, M. R. and Schüz, B. (2018). 
#' Data from, ‘Web-based positive psychology interventions: A reexamination of effectiveness’. 
#' Journal of Open Psychology Data, 6: 1. doi: 10.5334/jopd.35
#' 
#' See details at \url{https://doi.org/10.6084/m9.figshare.1577563.v1}. 

"posPsy_AHI_CESD"

# (1c) posPsy_long: ---------- 

#' Positive Psychology: AHI_CESD corrected data (in long format). 
#'
#' This dataset contains answers to the 24 items of the 
#' Authentic Happiness Inventory (AHI) and answers to the 
#' 20 items of the Center for Epidemiological Studies Depression (CES-D) scale 
#' (see Radloff, 1977) for multiple (1 to 6) measurement occasions:
#' 
#' 1. id: Particpant ID
#' 
#' 2. occasion: Measurement occasion:
#'   0 = Pretest (i.e., at enrolment),
#'   1 = Posttest (i.e., 7 days after pretest),
#'   2 = 1-week follow-up, (i.e., 14 days after pretest, 7 days after posttest),
#'   3 = 1-month follow-up, (i.e., 38 days after pretest, 31 days after posttest),
#'   4 = 3-month follow-up, (i.e., 98 days after pretest, 91 days after posttest),
#'   5 = 6-month follow-up, (i.e., 189 days after pretest, 182 days after posttest).
#' 
#' 3. elapsed.days: Time since enrolment measured in fractional days
#' 
#' 4. intervention: Intervention group (1 to 4)
#' 
#' - ahi01–ahi24: Responses on 24 AHI items
#' 
#' - cesd01–cesd20: Responses on 20 CES-D items
#' 
#' - ahiTotal: Total AHI score
#' 
#' - cesdTotal: Total CES-D score
#' 
#' 
#' @source 
#' Woodworth, R. J., O’Brien‐Malone, A., Diamond, M. R., & Schüz, B. (2017). 
#' Web‐based positive psychology interventions: A reexamination of effectiveness. 
#' Journal of Clinical Psychology, 73(3), 218–232. doi: 10.1002/jclp.22328
#' 
#' Woodworth, R. J., O’Brien-Malone, A., Diamond, M. R. and Schüz, B. (2018). 
#' Data from, ‘Web-based positive psychology interventions: A reexamination of effectiveness’. 
#' Journal of Open Psychology Data, 6: 1. doi: 10.5334/jopd.35
#' 
#' See details at \url{https://doi.org/10.6084/m9.figshare.1577563.v1}.

"posPsy_long"

# (1d) posPsy_wide: ---------- 

#' Positive Psychology: All corrected data (in wide format). 
#' 
#' @source 
#' Woodworth, R. J., O’Brien‐Malone, A., Diamond, M. R., & Schüz, B. (2017). 
#' Web‐based positive psychology interventions: A reexamination of effectiveness. 
#' Journal of Clinical Psychology, 73(3), 218–232. doi: 10.1002/jclp.22328
#' 
#' Woodworth, R. J., O’Brien-Malone, A., Diamond, M. R. and Schüz, B. (2018). 
#' Data from, ‘Web-based positive psychology interventions: A reexamination of effectiveness’. 
#' Journal of Open Psychology Data, 6: 1. doi: 10.5334/jopd.35
#' 
#' See details at \url{https://doi.org/10.6084/m9.figshare.1577563.v1}.

"posPsy_wide"


## ToDo: ----------

## eof. ----------------------