#This script allows users to change covariate assignments
#manually
# markers <- rownames(covar.flags)[5:10]
# pheno <- "ET1"
#it adds the information to the data object
#only the output from singlescan and pairscan
#make separate objects
	


marker2covar <- function(data.obj, geno.obj = NULL, singlescan.obj = NULL, covar.thresh = NULL, markers = NULL){
	
	if(!is.null(covar.thresh)){
		oneD <- singlescan.obj$singlescan.results
		if(is.null(oneD)){stop("singlescan.obj is required if setting covariates by a t threshold.\n")}
		}

	
	geno.mat <- get.geno(data.obj, geno.obj)
	
	#if the user has specified a t threshold for covariate specification
	if(!is.null(covar.thresh)){
		
		marker.names <- data.obj$geno.names[[3]]
		
		singlescan.obj$covar.thresh <- covar.thresh
	
		covar.which <- lapply(oneD, function(x) which(x[,"t.stat"] >= covar.thresh))
		covar.names <- unique(unlist(lapply(covar.which, function(x) names(x))))
		new.covar.locale <- get.marker.idx(data.obj, covar.names)
		new.covar <- geno.mat[,new.covar.locale,drop=FALSE]
		dimnames(new.covar)[[3]] <- covar.names
	
		snp.names <- get.marker.name(data.obj, covar.names)
		
		g.covar.info <- rbind(snp.names, data.obj$chromosome[new.covar.locale], data.obj$marker.location[new.covar.locale])
		colnames(g.covar.info) <- data.obj$marker.num[new.covar.locale]
		rownames(g.covar.info) <- c("name", "chromosome", "position")
		
		data.obj <- remove.markers(data.obj, markers.to.remove = snp.names)
		data.obj$g.covar.table <- new.covar
		data.obj$g.covar <- g.covar.info
		return(data.obj)		
		} #end case for setting covariates by a threshold


	if(!is.null(markers)){
		marker.names <- data.obj$geno.names[[3]]
		
		marker.locale <- get.marker.idx(data.obj, markers)		
		new.covar <- geno.mat[,,marker.locale,drop=FALSE]
		ref.locale <- which(dimnames(new.covar)[[2]] == ref.allele)
		the.rest <- setdiff(1:dim(new.covar)[[2]], ref.locale)
		covar.mat <- new.covar[,the.rest,]
		data.obj$g.covar.table <- covar.mat
		
		g.covar.info <- rbind(marker.names[marker.locale], data.obj$chromosome[marker.locale], data.obj$marker.location[marker.locale])
		colnames(g.covar.info) <- data.obj$marker.num[marker.locale]
		rownames(g.covar.info) <- c("name", "chromosome", "position")
				
		data.obj$g.covar <- g.covar.info
		data.obj <- remove.markers(data.obj, markers)

		}
	
		return(data.obj)

}