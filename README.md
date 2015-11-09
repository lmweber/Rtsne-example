Rtsne example
=============

This repository contains a short example showing how to calculate and plot a 2-dimensional t-SNE projection from a 13-dimensional mass cytometry data set, using the Rtsne package in R.


### t-SNE and Barnes-Hut-SNE

The t-SNE algorithm (t-SNE stands for *t-Distributed Stochastic Neighbor Embedding*) was developed by Laurens van der Maaten and Geoffrey Hinton [1]. It is a nonlinear dimensionality reduction algorithm, popular for representing high-dimensional data in two or three dimensions to allow visualization using scatter plots.

Barnes-Hut-SNE is a further improvement of the algorithm by Laurens van der Maaten [2], which uses Barnes-Hut approximations to significantly improve computational speed — to *O(N log N)* instead of *O(N<sup>2</sup>)*. This makes it feasible to apply the algorithm to larger data sets.

Laurens van der Maaten's [t-SNE webpage](http://lvdmaaten.github.io/tsne/) provides detailed information on the t-SNE and Barnes-Hut-SNE algorithms, as well as links to implementations for a large number of programming languages.


### Rtsne

The "Rtsne" package by Jesse Krijthe provides an R wrapper function for the C++ implementation of the Barnes-Hut-SNE algorithm.

Rtsne is available through the CRAN R package repository, and can be installed and loaded with the commands `install.packages("Rtsne")` and `library(Rtsne)`. For an example showing how to use Rtsne, see [Jesse Krijthe's Rtsne GitHub repository](https://github.com/jkrijthe/Rtsne).


### viSNE paper and mass cytometry data

Amir et al. (2013) [3] introduced "viSNE", a tool for Matlab to calculate t-SNE or Barnes-Hut-SNE projections and plot visualizations as 2-dimensional or 3-dimensional scatter plots. viSNE and its associated Matlab tool "cyt" can be downloaded from the [Dana Pe'er lab webpage](http://www.c2b2.columbia.edu/danapeerlab/html/cyt.html). Data from their paper can also be accessed from the same page.

Mass cytometry is a recent advance in flow cytometry, which allows expression levels of up to 40 proteins per cell to be measured in hundreds of cells per second. This creates high-dimensional data sets, where each dimension represents the expression level of one protein. However, while these data sets contain a large amount of information, they cannot be visualized easily. Tools such as viSNE aim to help in the interpretation of these data sets by generating low-dimensional projections, which can be visualized more easily.

In their paper, Amir et al. (2013) demonstrate the performance of viSNE using mass cytometry data from human bone marrow samples. The 2-dimensional viSNE projections accurately group cells into clusters representing known cell populations (see Figure 1b in the paper).


### Example using Rtsne

This repository contains a worked example showing how to calculate and plot a 2-dimensional t-SNE projection with the Barnes-Hut-SNE algorithm, using the Rtsne package for R. Performing all calculations in R allows easy integration with further statistical analysis and plotting in an open-source scripting environment.

The data set used in this example is the healthy human bone marrow data set "Marrow1", seen in Figure 1b of Amir et al. (2013). This figure shows an example of an ideal t-SNE projection, where cells from different cell populations (types) are grouped as distinct clusters of points in the 2-dimensional projection, and there is clear visual separation between clusters. Amir et al. (2013) also independently verified the interpretation of the clusters using "manual gating" methods (visual inspection of 2-dimensional scatter plots), confirming that several clusters represent well-known cell types from immunology.

The data set can be downloaded from the [Dana Pe'er lab webpage](http://www.c2b2.columbia.edu/danapeerlab/html/cyt.html) (filename "visne_marrow1.fcs"). A copy is also saved in the [data](data/) folder in this repository.

The R script [Rtsne_viSNE_example_Marrow1.R](Rtsne_viSNE_example_Marrow1.R) contains all the R code for this example. The code consists of the following steps. Additional details are included in comments in the code.

* load data and convert from FCS file format

* select columns containing expression values for the 13 protein markers that will be used in the Barnes-Hut-SNE calculations (see Amir et al. 2013, Supplementary Tables 1 and 2)

* arcsinh transformation (see Amir et al. 2013, Online Methods, "Processing of mass cytometry data")

* subsampling

* remove rows containing duplicate values within the rounding threshold (required by Rtsne)

* export the subsampled data

* run Rtsne

* plot the resulting t-SNE projection as a 2-dimensional scatter plot

Examples of plots generated after subsampling 1,000 and 10,000 points from the "Marrow1" data set are saved in the [plots](plots/) folder.

Note that the two t-SNE projection axes are arbitrary, and do not have a meaningful interpretation. In addition, the shape and location of clusters in the projected space can vary each time they are calculated, due to the stochasticity of the Barnes-Hut-SNE algorithm and the random subsampling step. In this example we set random seeds to ensure reproducibility. The important features of the plot are the visual separation between clusters, and the consistent allocation of cell populations to clusters.


### References

1. L. van der Maaten and G. Hinton (2008), "Visualizing Data using t-SNE", Journal of Machine Learning Research, 9, 2579-2605, available from [http://lvdmaaten.github.io/tsne/](http://lvdmaaten.github.io/tsne/)

2. L. van der Maaten (2014), "Accelerating t-SNE using Tree-Based Algorithms", Journal of Machine Learning Research, 15, 1-21, available from [http://lvdmaaten.github.io/tsne/](http://lvdmaaten.github.io/tsne/)

3. E.D. Amir et al. (2013), "viSNE enables visualization of high dimensional single-cell data and reveals phenotypic heterogeneity of leukemia", Nature Biotechnology, 31, 545–552, [http://www.ncbi.nlm.nih.gov/pubmed/23685480](http://www.ncbi.nlm.nih.gov/pubmed/23685480)

