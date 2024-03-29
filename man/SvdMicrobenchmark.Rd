% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dense_matrix_kernels.R
\name{SvdMicrobenchmark}
\alias{SvdMicrobenchmark}
\title{Conducts a single performance trial with the singular value decomposition
(SVD) dense matrix kernel}
\usage{
SvdMicrobenchmark(benchmarkParameters, kernelParameters)
}
\arguments{
\item{benchmarkParameters}{an object of type
\code{\link{DenseMatrixMicrobenchmark}} specifying various parameters
for microbenchmarking the dense matrix kernel}

\item{kernelParameters}{a list of matrices or vectors to be used as input to
the dense matrix kernel}
}
\description{
\code{SvdMicrobenchmark} conducts a single performance trial of the
SVD dense matrix kernel for the matrix given in the \code{kernelParameters}
parameter.  The function times the single function call
\code{svd(kernelParameters$A)}.
}
\examples{
\dontrun{
# Allocate input to the singular value decomposition microbenchmark for the
# first matrix size to be tested
microbenchmarks <- GetDenseMatrixDefaultMicrobenchmarks()
kernelParameters <- SvdAllocator(microbenchmarks[["svd"]], 1)
# Execute the microbenchmark
timings <- SvdMicrobenchmark(microbenchmarks[["svd"]], kernelParameters)
}

}
