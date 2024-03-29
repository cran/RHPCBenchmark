% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/classes.R
\name{SparseMatrixMicrobenchmark}
\alias{SparseMatrixMicrobenchmark}
\title{This class specifies a sparse matrix microbenchmark.}
\description{
This class specifies a sparse matrix microbenchmark.
}
\section{Fields}{

\describe{
\item{\code{active}}{a logical indicating whether the microbenchmark is to be
executed (TRUE) or not (FALSE).}

\item{\code{benchmarkName}}{a character string that is the name of the
microbenchmark.}

\item{\code{benchmarkDescription}}{a character string describing the microbenchmark.}

\item{\code{matrixObjectName}}{a character string specifying the name of the sparse
matrix object that is input to the benchmark; the object must be stored in
the R data file with name \code{matrixObjectName}.RData
Setting the field to NA_character_ indicates that the test data will
be generated dynamically by the function given in the
\code{allocatorFunction} field instead of read from a data file.}

\item{\code{numberOfRows}}{an integer specifying the expected number of rows in the
input sparse matrix.}

\item{\code{numberOfColumns}}{an integer specifying the expected number of columns
in the input sparse matrix.}

\item{\code{numberOfNonzeros}}{an integer specifying the expected number of nonzeros
in the input sparse matrix.}

\item{\code{numberOfTrials}}{an integer vector specifying the number of performance
trials conducted for each matrix to be tested.}

\item{\code{numberOfWarmupTrials}}{an integer vector specifying the number of warmup
trials to be performed for each matrix to be tested.}

\item{\code{allocatorFunction}}{the function that allocates and initializes input
to the benchmark function.  The function takes a
\code{SparseMatrixMicrobenchmark} object and an integer index indicating
which matrix parameter from \code{numberOfRows}, \code{numberOfColumns},
and \code{numberOfNonzeros} should be used to generate the matrix.}

\item{\code{benchmarkFunction}}{the benchmark function which executes the
functionality to be timed.  The function takes a
\code{SparseMatrixMicrobenchmark} and a list of kernel parameters
returned by the allocator function.}
}}

