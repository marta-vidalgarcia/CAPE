\name{draw.pie}
\alias{draw.pie}
%- Also NEED an \alias for EACH other topic documented here.
\title{ 
	Draw a pie chart at specific xy coordinates with a specified number of slices and color for each slice.
}
\description{
This function uses error propagation formulas for quantities computed from regression coefficients to estimate the error for all regression coefficients.
}
\usage{
draw.pie(x = 0.5, y = 0.5, radius = 1, cols = c("red", "green"), labels = NULL, edges = 200, label.cex = 1, xlim = NULL, ylim = NULL, add = TRUE)
}
%- maybe also usage for other objects documented here.
\arguments{
  \item{data.obj}{
	The object in which all results are stored. See \code{\link{capeDO}}.
	}
  \item{perm}{
A logical value to indicate whether error propagation should be performed on the test statistics (FALSE) or the permuted test statistics (TRUE).
}
  \item{verbose}{
	A logical value to indicate whether the progress of the function should be printed to the screen.
	}
}
\value{
This function returns the data object with a new list element: var.to.var.influences if perm is set to FALSE and var.to.var.influences.perm if perm is set to TRUE. These tables include the errors calculated for the marker1 to marker2 influences as well as the marker2 to marker1 influences. These results are used by \code{\link{calc.p}} to calculate empirical p values.
}
\references{
Carter, G. W., Hays, M., Sherman, A., & Galitski, T. (2012). Use of pleiotropy to model genetic interactions in a population. PLoS genetics, 8(10), e1003010. doi:10.1371/journal.pgen.1003010

Bevington PR (1969) Data Reduction and Error Analysis for the Physical Sciences. New York: McGraw-Hill.
}
% Add one or more standard keywords, see file KEYWORDS in the
% R documentation directory.
\keyword{math}
\keyword{symbolmath}

