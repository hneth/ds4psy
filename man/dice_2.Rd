% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data_fun.R
\name{dice_2}
\alias{dice_2}
\title{Throw a questionable dice (with a given number of sides) n times}
\usage{
dice_2(n = 1, sides = 6)
}
\arguments{
\item{n}{Number of dice throws.
Default: \code{n = 1}.}

\item{sides}{Number of sides.
Default: \code{sides = 6}.}
}
\description{
\code{dice_2} is a variant of \code{\link{dice}} that 
generates a sequence of events that 
represent the results of throwing a dice 
(with a given number of \code{sides}) \code{n} times.
}
\details{
Something is wrong with this dice. 
Can you examine it and measure its problems 
in a quantitative fashion?
}
\examples{
# Basics:
dice_2()
table(dice_2(100))

# 10-sided dice:
dice_2(sides = 10)
table(dice_2(100, sides = 10))

# Note:
dice_2(10, 1)
table(dice_2(5000, sides = 5))

# Note an oddity:
dice_2(n = 10, sides = 8:9)  # works, but 
dice_2(n = 10, sides = 9:9)  # odd: see sample() for an explanation.

}
\seealso{
Other sampling functions: 
\code{\link{coin}()},
\code{\link{dice}()},
\code{\link{sample_char}()},
\code{\link{sample_date}()},
\code{\link{sample_time}()}
}
\concept{sampling functions}
