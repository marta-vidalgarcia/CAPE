\name{writeVariantInfluences}
\alias{writeVariantInfluences}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Write the final results to a file
}
\description{
This function takes in the final data object and writes the variant influences that are at or below the specified significance level
to a file in the current working directory.
}
\usage{
writeVariantInfluences(data.obj, p.or.q = 0.05, 
filename = "Variant.Influences.csv", delim = ",", 
mark.covar = FALSE, write.file = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data.obj}{
	The object in which all results are stored. See \code{\link{capeDO}}.
}
  \item{p.or.q}{
	A threshold indicating the maximum adjusted p value considered significant. If an fdr method has been used to correct for multiple testing, this value specifies the maximum q value considered significant. Only marker pairs with p or q values below this threshold will be plotted.
}
  \item{filename}{
	A character vector specifying the name of the file.
	}
	\item{delim}{
		A character string indicating the delimeter in the data file. The default indicates a comma-separated file (",").
	}
	\item{mark.covar}{
		A logical value. If TRUE, an asterisk is appended the names of markers used as covariates in the pair scan.
		}
	\item{write.file}{
		A logical value indicating whether the table should be written to a file or simply returned.
		}
}
\value{
This function writes a table of direct influences to a file. It also returns the table invisibly, i.e. if the output of the function is assigned to an object, the object will contain the table of influences. Otherwise, nothing is returned.
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{IO}

