% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/predict.sven.R
\name{predict.sven}
\alias{predict.sven}
\title{Make predictions from a fitted "sven" object.}
\usage{
\method{predict}{sven}(
  object,
  newdata,
  model = c("WAM", "MAP"),
  interval = c("none", "MC", "Z"),
  return.draws = FALSE,
  Nsim = 10000,
  level = 0.95,
  alpha = 1 - level,
  ...
)
}
\arguments{
\item{object}{A fitted "sven" object}

\item{newdata}{Matrix of new values for \code{X} at which predictions are to be made. Must be a matrix;
can be sparse as in Matrix package.}

\item{model}{The model to be used to make predictions. Model "MAP" gives the predictions calculated
using the MAP model; model "WAM" gives the predictions calculated using the WAM. Default: "WAM".}

\item{interval}{Type of interval calculation. If \code{interval} = \code{"none"}, only point predictions are returned;
if \code{interval} = \code{"MC"}, Monte Carlo prediction intervals are returned; if \code{interval} = \code{"Z"}, Z prediction 
intervals are returned.}

\item{return.draws}{only required if \code{interval} = \code{"MC"}. if \code{TRUE}, the Monte Carlo samples are returned.
Default: \code{FALSE}.}

\item{Nsim}{only required if \code{interval} = \code{"MC"}. The Monte Carlo sample size. Default: 10000.}

\item{level}{Confidence level of the interval. Default: 0.95.}

\item{alpha}{Type one error rate. Default: 1-\code{level}.}

\item{...}{Further arguments passed to or from other methods.}
}
\value{
The object returned depends on "interval" argument. If \code{interval} = \code{"none"}, the object is an 
\eqn{\code{ncol(newdata)}\times 1} vector of the point predictions; otherwise, the object is an
\eqn{\code{ncol(newdata)}\times 3} matrix with the point predictions in the first column and the lower and upper bounds 
of prediction intervals in the second and third columns, respectively.

if return.draws is \code{TRUE}, a list with the following components is returned:
\item{prediction}{vector or matrix as above}
\item{mc.draws}{an \eqn{\code{ncol(newdata)} \times \code{Nsim}} matrix of the Monte Carlo samples}
}
\description{
This function makes point predictions and computes prediction intervals
from a fitted "sven" object.
}
\examples{
n = 80; p = 100; nonzero = 5
trueidx <- 1:5
nonzero.value <- c(0.50, 0.75, 1.00, 1.25, 1.50)
TrueBeta = numeric(p)
TrueBeta[trueidx] <- nonzero.value

X <- matrix(rnorm(n*p), n, p)
y <- 0.5 + X \%*\% TrueBeta + rnorm(n)
res <- sven(X=X, y=y)
newx <- matrix(rnorm(20*p), 20, p)
# predicted values at a new data matrix using MAP model
yhat <- predict(object = res, newdata = newx, model = "MAP", interval = "none")
# 95\% Monte Carlo prediction interval using WAM
MC.interval <- predict(object = res, model = "WAM", newdata = newx, interval = "MC", level=0.95)
# 95\% Z-prediction interval using MAP model
Z.interval <- predict(object = res, model = "MAP", newdata = newx, interval = "Z", level = 0.95)
}
\references{
Li, D., Dutta, S., Roy, V.(2020) Model Based Screening Embedded Bayesian Variable Selection for Ultra-high 
Dimensional Settings http://arxiv.org/abs/2006.07561
}
\author{
Dongjin Li and Somak Dutta\cr Maintainer:
Dongjin Li <dongjl@iastate.edu>
}
