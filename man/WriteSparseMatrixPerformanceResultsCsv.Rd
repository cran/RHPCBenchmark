% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/benchmarking_utils.R
\name{WriteSparseMatrixPerformanceResultsCsv}
\alias{WriteSparseMatrixPerformanceResultsCsv}
\title{Appends sparse matrix performance test results to a file in CSV format}
\usage{
WriteSparseMatrixPerformanceResultsCsv(numberOfThreads, numberOfRows,
  numberOfColumns, numberOfNonzeros, averageWallClockTime, standardDeviation,
  csvResultsFileName)
}
\arguments{
\item{numberOfThreads}{the number of threads all of the performance trials
were conducted with}

\item{numberOfRows}{the number of rows in the matrix}

\item{numberOfColumns}{the number of columns in the matrix}

\item{numberOfNonzeros}{the number of non-zero elements in the matrix}

\item{averageWallClockTime}{average wall clock time computed for the matrix
tested during the performance trials}

\item{standardDeviation}{standard deviation of the wall clock times obtained
for the performance trials}

\item{csvResultsFileName}{the CSV results file the performance result will be
appended to}
}
\description{
\code{WriteSparseMatrixPerformanceResultsCsv} appends performance results
for a single sparse matrix performance test to a CSV file.
}
\details{
This function appends the performance results obtained by a single sparse
matrix microbenchmark conducted for a specific matrix.
If the CSV file does not exist, header information is printed on the first
line to describe the subsequent entries.  Each entry consists of the
dimension parameter used to specify the dimensions of the matrix, the
average of the wall clock times obtained for the performance trials, the
standard deviation of the performance trial wall clock times, and the number
of threads the performance trials were conducted with.
}
