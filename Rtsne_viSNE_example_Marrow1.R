################################################################################
##
## R script to calculate and plot 2-dimensional t-SNE (Barnes-Hut-SNE) projection 
## maps from 13-dimensional mass cytometry data set "Marrow1" from viSNE paper 
## (see Figure 1b), using Rtsne package in R.
##
## References:
## - Amir et al (2013), viSNE enables visualization of high dimensional single-cell 
##   data and reveals phenotypic heterogeneity of leukemia, Nature Biotechnology, 
##   http://www.ncbi.nlm.nih.gov/pubmed/23685480. (In particular see Figure 1b).
## - Rtsne package (R wrapper for Barnes-Hut-SNE algorithm): J. Krijthe, 
##   https://github.com/jkrijthe/Rtsne.
##
## Lukas M Weber, Nov 2014
##
################################################################################


library(flowCore)  # package to read FCS files
library(Rtsne)     # Barnes-Hut-SNE algorithm

# load data
# source: http://www.c2b2.columbia.edu/danapeerlab/html/cyt.html
data <- exprs(read.FCS("data/visne_marrow1.fcs", transformation=FALSE))
head(data)
unname(colnames(data))  # isotope and marker (protein) names

# select markers to use in calculation of t-SNE projections
# (see Amir et al 2013, Supplementary Tables 1 and 2)
markers_proj <- c("CD11b","CD123","CD19","CD20","CD3","CD33","CD34","CD38",
                  "CD4","CD45","CD45RA","CD8","CD90")
markers_proj
colnames_proj <- unname(colnames(data))[c(11,23,10,16,7,22,14,31,12,6,8,13,30)]
colnames_proj  # check carefully!

# arcsinh transformation
# (see Amir et al 2013, Online Methods, "Processing of mass cytometry data")
asinh.scale <- 5
data <- asinh(data / asinh.scale)  # transforms all columns! including event no. etc

# subsampling
nsub <- 10000
set.seed(123)  # random seed
data <- data[sample(1:nrow(data),nsub),]

# run Rtsne (Barnes-Hut-SNE algorithm, Rtsne package)
data <- data[,colnames_proj]      # select columns
data <- data[!duplicated(data),]  # remove duplicates within rounding (required by algorithm)
dim(data)
fn_table <- paste("data/viSNE_Marrow1_nsub",nsub,".txt",sep="")
write.table(data,file=fn_table,row.names=FALSE,sep="\t")  # export data (if required)
set.seed(123)  # random seed
rtsne_out <- Rtsne(as.matrix(data),pca=FALSE)  # no PCA step (see Amir et al 2013, 
                                               # Online Methods, "viSNE analysis")

# plot projection map
fn_plot <- paste("plots/Rtsne_viSNE_Marrow1_nsub",nsub,".png",sep="")
png(fn_plot, width=900, height=900)
plot(rtsne_out$Y, asp=1, pch=20, col="blue", 
     cex=0.75, cex.axis=1.25, cex.lab=1.25, cex.main=1.5, 
     xlab="t-SNE dimension 1", ylab="t-SNE dimension 2", 
     main="2-D t-SNE projection map")
dev.off()


