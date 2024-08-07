% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ts_fil_remd.R
\name{ts_fil_remd}
\alias{ts_fil_remd}
\title{EMD Filter}
\usage{
ts_fil_remd(noise = 0.1, trials = 5)
}
\arguments{
\item{noise}{noise}

\item{trials}{trials}
}
\value{
a \code{ts_fil_remd} object.
}
\description{
EMD Filter
}
\examples{
# time series with noise
library(daltoolbox)
data(sin_data)
sin_data$y[9] <- 2*sin_data$y[9]

# filter
filter <- ts_fil_remd()
filter <- fit(filter, sin_data$y)
y <- transform(filter, sin_data$y)

# plot
plot_ts_pred(y=sin_data$y, yadj=y)
}
