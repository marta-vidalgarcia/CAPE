#This function performs a pairscan for when there 
#is no kinship correction required.



pairscan.noKin <- function(data.obj, pheno.mat, geno.mat, covar.table, paired.markers, n.perm, verbose, run.parallel = TRUE, n.cores = NULL){

	num.pheno <- dim(pheno.mat)[2]
	# cat("num.pheno:", num.pheno, "\n")

	results.list <- vector(mode = "list", length = num.pheno)
	names(results.list) <- colnames(pheno.mat)


	for(p in 1:num.pheno){ 
		if(verbose){
			cat("\nScanning phenotype ", colnames(pheno.mat)[p], ":\n", sep = "")
			}
		pairscan.results <- one.pairscan.parallel(data.obj, phenotype.vector = pheno.mat[,p], genotype.matrix = geno.mat, covar.vector = covar.table, paired.markers = paired.markers, n.perm = 0, verbose = verbose, n.cores = n.cores, run.parallel = run.parallel)
		results.list[[p]] <- pairscan.results[[1]]
		} #end looping over phenotypes

	return(results.list)
	
	
	}