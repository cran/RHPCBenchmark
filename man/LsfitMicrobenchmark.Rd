% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dense_matrix_kernels.R
\name{LsfitMicrobenchmark}
\alias{LsfitMicrobenchmark}
\title{Conducts a single performance trial with the matrix least squares fit dense
matrix kernel}
\usage{
LsfitMicrobenchmark(benchmarkParameters, kernelParameters)
}
\arguments{
\item{benchmarkParameters}{an object of type
\code{\link{DenseMatrixMicrobenchmark}} specifying various parameters
for microbenchmarking the dense matrix kernel}

\item{kernelParameters}{a list of matrices or vectors to be used as input to
the dense matrix kernel}
}
\description{
\code{LsfitMicrobenchmark} conducts a single performance trial of the
matrix least squares fit dense matrix kernel for the matrix given in the
\code{kernelParameters} parameter.  The function times the single function
call \code{lsfit(kernelParameters$A, kernelParameters$b, intercept=FALSE)}.
}
\examples{
\dontrun{
# Allocate input to the least-squares fit microbenchmark for the
# first matrix size to be tested
microbenchmarks <- GetDenseMatrixDefaultMicrobenchmarks()
kernelParameters <- LsfitAllocator(microbenchmarks[["lsfit"]], 1)
# Execute the microbenchmark
timings <- LsfitMicrobenchmark(microbenchmarks[["lsfit"]], kernelParameters)
}

}
