#########################################################################################
# R script to calculate and plot a 2-dimensional t-SNE (Barnes-Hut-SNE) projection map 
# from a 13-dimensional mass cytometry data set ("Marrow1" from Amir et al. 2013, see
# Figure 1b), using Rtsne package
#
# References:
#
# Amir et al. (2013), "viSNE enables visualization of high dimensional single-cell data 
# and reveals phenotypic heterogeneity of leukemia", Nature Biotechnology, 
# http://www.ncbi.nlm.nih.gov/pubmed/23685480 (in particular see Figure 1b)
#
# Rtsne package (R wrapper for C++ implementation of Barnes-Hut-SNE) by Jesse Krijthe,
# https://github.com/jkrijthe/Rtsne
#
# Lukas M. Weber, October 2015
#########################################################################################


# install flowCore package from Bioconductor (to read FCS files)

source("https://bioconductor.org/biocLite.R")
biocLite("flowCore")

# install Rtsne package from CRAN (R implementation of Barnes-Hut-SNE algorithm)

install.packages("Rtsne")

# load packages

library(flowCore)
library(Rtsne)


# load data
# source: downloaded from http://www.c2b2.columbia.edu/danapeerlab/html/cyt.html

data <- exprs(read.FCS("data/visne_marrow1.fcs", transformation = FALSE))
head(data)

unname(colnames(data))  # isotope and marker (protein) names


# select markers to use in calculation of t-SNE projection
# CD11b, CD123, CD19, CD20, CD3, CD33, CD34, CD38, CD4, CD45, CD45RA, CD8, CD90
# (see Amir et al. 2013, Supplementary Tables 1 and 2)

colnames_proj <- unname(colnames(data))[c(11, 23, 10, 16, 7, 22, 14, 28, 12, 6, 8, 13, 30)]
colnames_proj  # check carefully!


# arcsinh transformation
# (see Amir et al. 2013, Online Methods, "Processing of mass cytometry data")

asinh_scale <- 5
data <- asinh(data / asinh_scale)  # transforms all columns! including event number etc


# subsampling

nsub <- 10000
set.seed(123)  # set random seed
data <- data[sample(1:nrow(data), nsub), ]

dim(data)


# prepare data for Rtsne

data <- data[, colnames_proj]      # select columns to use
data <- data[!duplicated(data), ]  # remove rows containing duplicate values within rounding

dim(data)


# export subsampled data in TXT format

file <- paste("data/viSNE_Marrow1_nsub", nsub, ".txt", sep = "")
write.table(data, file = file, row.names = FALSE, quote = FALSE, sep = "\t")


# run Rtsne (Barnes-Hut-SNE algorithm)
# without PCA step (see Amir et al. 2013, Online Methods, "viSNE analysis")

set.seed(123)  # set random seed
rtsne_out <- Rtsne(as.matrix(data), pca = FALSE, verbose = TRUE)


# plot 2D t-SNE projection

file_plot <- paste("plots/Rtsne_viSNE_Marrow1_nsub", nsub, ".png", sep = "")
png(file_plot, width = 900, height = 900)
plot(rtsne_out$Y, asp = 1, pch = 20, col = "blue", 
     cex = 0.75, cex.axis = 1.25, cex.lab = 1.25, cex.main = 1.5, 
     xlab = "t-SNE dimension 1", ylab = "t-SNE dimension 2", 
     main = "2D t-SNE projection")
dev.off()

