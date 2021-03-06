#This is an internal function that gets the geno 
#object whether it is put in separately or with 
#the data.obj it warns the user if it can't find 
#the genotypes
#If the data object specifies that only a subset
#of loci, individuals, or alleles should be used
#the genotype object is subset before being returned
#This function essentially recreates the geno used
#in the original cape, so modifications to the code
#should be fairly minimal otherwise

get.geno <- function(data.obj, geno.obj){
	
	require(abind)
	
	geno.names <- data.obj$geno.names
	
	if(is.null(geno.obj)){
		geno <- data.obj$geno
		}else{
		if(class(geno.obj) == "array"){
			geno <- geno.obj
			}else{
			geno <- geno.obj$geno	
			}
		}
		
	
	if(is.null(geno)){
		stop("I can't find the genotype data. Please make sure it is in either data.obj or geno.obj.")
		}
	
	mouse.dim <- which(names(geno.names) == "mouse")
	locus.dim <- which(names(geno.names) == "locus")
	allele.dim <- which(names(geno.names) == "allele")

	#subset the genotype object to match the 
	#individuals and markers we want to scan
	ind.locale <- match(geno.names[[mouse.dim]], dimnames(geno)[[mouse.dim]])
	allele.locale <- match(geno.names[[allele.dim]], dimnames(geno)[[allele.dim]])
	locus.locale <- match(geno.names[[locus.dim]], dimnames(geno)[[locus.dim]])

	#check for NAs, meaning the locus from the data object cannot be
	#found in the genotyope object
	na.locale <- which(is.na(locus.locale))
	locus.locale <- locus.locale[which(!is.na(locus.locale))]
		
	gene <- geno[ind.locale, allele.locale, locus.locale]
		
	#if there is a covariate table in the data object, this is added
	#to the genotype object
	if(!is.null(data.obj$covar.table)){
		covar.vals <- data.obj$covar.table
		covar.names <- colnames(covar.vals)
		covar.table <- array(NA, dim = c(length(geno.names[[mouse.dim]]), length(geno.names[[allele.dim]]), dim(covar.vals)[2]))
		for(i in 1:dim(covar.vals)[2]){
			covar.table[,1:dim(covar.table)[2],i] <- covar.vals[,i]
			}
		dimnames(covar.table)[[3]]  <- covar.names
		gene <- abind(gene, covar.table, along = 3)
		}
		
	names(dimnames(gene)) <- names(dimnames(geno))
	
	return(gene)	
}