#This function takes in a vector of marker names
#and returns their number

get.marker.num <- function(data.obj, markers){

	if(is.null(markers)){
		return(NULL)
		}

	und.check <- grep("_", markers[1])
	if(length(und.check) > 0){
		markers <- sapply(strsplit(markers, "_"), function(x) x[1])
		}

	is.char <- as.logical(is.na(suppressWarnings(as.numeric(markers[1]))))
	
	
	if(is.char){
		#use the markers vector first to translate
		marker.num <- data.obj$marker.num[match(markers, data.obj$geno.names[[3]])]
		
		#if there are any markers we didn't translate, look in the 
		#covariate tables for marker numbers
		na.locale <- which(is.na(marker.num))
		
		if(length(na.locale) > 0){
			covar.info <- get.covar(data.obj)
			marker.num[na.locale] <- colnames(covar.info$covar.table)[match(markers[na.locale], covar.info$covar.names)]
			}
		}else{
		#use the markers vector first to translate
		marker.num <- data.obj$marker.num[match(markers, data.obj$marker.num)]
		
		#if there are any markers we didn't translate, look in the 
		#covariate tables for marker numbers
		na.locale <- which(is.na(marker.num))
		
		if(length(na.locale) > 0){
			covar.info <- get.covar(data.obj)
			marker.num[na.locale] <- colnames(covar.info$covar.table)[match(markers[na.locale], colnames(covar.info$covar.table))]
			}
		}


	return(marker.num)
}