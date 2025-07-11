#'@title Time Series Global Min-Max
#'@description Rescales data, so the minimum value is mapped to 0 and the maximum value is mapped to 1.
#'@param outliers Indicate outliers transformation class. NULL can avoid outliers removal.
#'@return returns a `ts_norm_gminmax` object.
#'@examples
#'# time series to normalize
#'library(daltoolbox)
#'data(tsd)
#'
#'# convert to sliding windows
#'ts <- ts_data(tsd$y, 10)
#'ts_head(ts, 3)
#'summary(ts[,10])
#'
#'# normalization
#'preproc <- ts_norm_gminmax()
#'preproc <- fit(preproc, ts)
#'tst <- transform(preproc, ts)
#'ts_head(tst, 3)
#'summary(tst[,10])
#'@importFrom daltoolbox outliers_boxplot
#'@export
ts_norm_gminmax <- function(outliers = outliers_boxplot()) {
  obj <- dal_transform()
  obj$outliers <- outliers
  class(obj) <- append("ts_norm_gminmax", class(obj))
  return(obj)
}

#'@exportS3Method fit ts_norm_gminmax
fit.ts_norm_gminmax <- function(obj, data, ...) {
  if (!is.null(obj$outliers)) {
    out <- obj$outliers
    out <- fit(out, data)
    data <- transform(out, data)
  }

  obj$gmin <- min(data)
  obj$gmax <- max(data)

  return(obj)
}

#'@importFrom daltoolbox transform
#'@exportS3Method transform ts_norm_gminmax
transform.ts_norm_gminmax <- function(obj, data, x=NULL, ...) {
  if (!is.null(x)) {
    x <- (x-obj$gmin)/(obj$gmax-obj$gmin)
    return(x)
  }
  else {
    data <- (data-obj$gmin)/(obj$gmax-obj$gmin)
    return(data)
  }
}

#'@importFrom daltoolbox inverse_transform
#'@exportS3Method inverse_transform ts_norm_gminmax
inverse_transform.ts_norm_gminmax <- function(obj, data, x=NULL, ...) {
  if (!is.null(x)) {
    x <- x * (obj$gmax-obj$gmin) + obj$gmin
    return(x)
  }
  else {
    data <- data * (obj$gmax-obj$gmin) + obj$gmin
    return (data)
  }
}
