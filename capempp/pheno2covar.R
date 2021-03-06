#This script takes a variable from the phenotype matrix
#for example, diet treament or sex and creates a marker
#variable that can be used as a covariate.
#It creates a marker that is numeric and assigns the 
#numeric value to each of the allels at all loci for 
#the given individual.


pheno2covar <- function(data.obj, pheno.which){

	pheno <- data.obj$pheno
	if(length(rownames(pheno)) == 0){stop("The phenotype matrix must have rownames.")}
	
	marker.locale <- get.col.num(pheno, pheno.which)
	
	if(length(marker.locale) == 0){
		return(data.obj)
		}
	
	if(length(unique(marker.locale)) != length(pheno.which)){
		stop("Phenotype labels cannot be substrings of other phenotypes.")
		}


	#make a separate covariate table, then modify the dimnames
	#in the genotype object to include the covariates
	#do not modify the genotype object
	
	#get information for any covariates that have already been specified
	covar.info <- get.covar(data.obj)
	
	covar.table <- pheno[,marker.locale,drop=FALSE]
	rownames(covar.table) <- rownames(pheno)
	
	#the covariate's number starts after genetic markers and any existing phenotypic covariates
	start.covar <- max(as.numeric(data.obj$marker.num))+1+length(covar.info$covar.names)
	colnames(covar.table) <- start.covar:(start.covar+dim(covar.table)[2]-1)
	
	#scale the covariate(s) to be between 0 and 1
	scaled.table <- apply(covar.table, 2, function(x) x + abs(min(x, na.rm = TRUE)))
	scaled.table <- apply(scaled.table, 2, function(x) x/max(x, na.rm = TRUE))

	#add the covariates to any existing covariates
	data.obj$p.covar.table <- cbind(data.obj$p.covar.table, scaled.table)
	
		
	#take the phenotypes made into markers out of the phenotype matrix
	new.pheno <- pheno[,-marker.locale,drop=FALSE]
	data.obj$pheno <- new.pheno
	
	p.covar.names.locale <- which(names(data.obj) == "p.covar")
	if(length(p.covar.names.locale) == 0){
		data.obj$p.covar <- pheno.which
		}else{
		data.obj[[p.covar.names.locale]] <- c(data.obj[[p.covar.names.locale]], pheno.which)
		}
	return(data.obj)
	
	}