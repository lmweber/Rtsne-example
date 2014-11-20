Rtsne example
=============

This repository contains a short example demonstrating how to calculate and plot a 2-dimensional t-SNE projection from a 13-dimensional mass cytometry data set, using the Rtsne package in R.


### t-SNE and Barnes-Hut-SNE

The t-SNE algorithm (t-SNE stands for *t-Distributed Stochastic Neighbor Embedding*) was developed by Laurens van der Maaten and Geoffrey Hinton [1]. It is a sophisticated algorithm for dimensionality reduction, popular for representing high-dimensional data in 2 or 3 dimensions to allow visualization using scatter plots.

Barnes-Hut-SNE [2] is a recent extension by Laurens van der Maaten, which uses Barnes-Hut approximations to substantially improve the speed of the algorithm — to *O(N log N)* instead of *O(N<sup>2</sup>)*. This makes it feasible to apply the algorithm to larger data sets.

Laurens van der Maaten's t-SNE webpage at http://homepage.tudelft.nl/19j49/t-SNE.html [3] provides detailed information on the t-SNE and Barnes-Hut-SNE algorithms, as well as downloadable implementations in a large number of programming languages.


### Rtsne

The "Rtsne" package by Jesse Krijthe at https://github.com/jkrijthe/Rtsne [4] provides an R wrapper function for the C++ implementation of the Barnes-Hut-SNE algorithm.

In R, the Rtsne package can be installed from the CRAN R package repository as usual with the command `install.packages("Rtsne")`, and loaded with `library(Rtsne)`. For an example of usage of Rtsne, see https://github.com/jkrijthe/Rtsne.


### viSNE paper and mass cytometry data

A recent paper by Amir et al. (2013) [5] introduced "viSNE", a tool for Matlab to calculate t-SNE or Barnes-Hut-SNE projections and plot visualizations as 2-dimensional or 3-dimensional scatter plots. viSNE and its associated visualization tool "cyt" can be downloaded from the Dana Pe'er lab page at http://www.c2b2.columbia.edu/danapeerlab/html/cyt.html [6].

Mass cytometry is a recent advance in flow cytometry, which allows expression levels of up to dozens of proteins to be measured in thousands of cells per second. This creates high-dimensional data sets, with each dimension representing the expression level of one protein. However, while these data sets contain a large amount of information, they cannot be visualized easily. Tools such as viSNE aim to help in the interpretation of these data sets by generating a low-dimensional projection that can then be analyzed visually.

In the Amir et al. (2013) paper, the performance of viSNE is demonstrated using mass cytometry data from healthy and cancerous human bone marrow samples. viSNE accurately groups cells from known cell populations in clusters on the 2-dimensional projection maps (for example, see Figure 1b in the paper). The data from the paper can be downloaded from http://www.c2b2.columbia.edu/danapeerlab/html/cyt.html.


### Example using Rtsne

This repository contains a worked example showing how to calculate and plot a 2-dimensional t-SNE projection with the Barnes-Hut-SNE algorithm, using the Rtsne package for R. Performing all calculations in R allows easy integration with further statistical analysis and plotting in an open-source scripting environment.

The data set used in this example is the healthy human bone marrow data set "Marrow1" from Figure 1b of the viSNE paper (Amir et al. 2013). This figure shows an example of an ideal t-SNE projection map, where cells from different cell populations or types are grouped as distinct clusters of points in the 2-dimensional projection map, and there is clear visual separation between clusters. Amir et al. also independently verified the interpretation of the clusters using traditional 2-dimensional "gating" methods, confirming that several clusters represent known cell types (CD4 T cells, CD8 T cells, etc).

The data set can be downloaded from http://www.c2b2.columbia.edu/danapeerlab/html/cyt.html (filename "visne_marrow1.fcs"). A backup is also available in the `data` folder in this repository.

The R script `Rtsne_viSNE_example_Marrow1.R` contains all code to run through the example. The code consists of the following steps. Each step is also explained in comments in the code.

* load data and convert from .fcs format

* select appropriate columns, containing expression data for the 13 protein markers that will be used in the Barnes-Hut-SNE calculations (see Amir et al. 2013, Supplementary Tables 1 and 2)

* arcsinh transformation (see Amir et al. 2013, Online Methods, "Processing of mass cytometry data")

* subsampling

* remove duplicate values within the rounding threshold in the data set (required by Rtsne)

* export the subset of data used to calculate the projection (if required)

* run Rtsne

* plot results of the projection as a 2-dimensional scatter plot

Examples of plots generated after subsampling 1000 and 10,000 points from the "Marrow1" data set are saved in the `plots` folder.

Note that the two t-SNE projection axes are arbitrary, and do not have an intrinsic interpretation. In addition, the stochasticity of the t-SNE and Barnes-Hut-SNE algorithms, together with variability in the subsampling step, mean that the shape and location of the clusters in the 2-dimensional projection space will vary each time the code is run. The important properties of the plot are the visual separation between clusters, and the consistent allocation of cell types to clusters. In this example, we have used the `set.seed` command to ensure reproducibility in the subsampling and Rtsne steps.


### References

1. L. van der Maaten and G. Hinton (2008), "Visualizing Data using t-SNE", Journal of Machine Learning Research, 9, 2579-2605.

2. L. van der Maaten (2013), "Barnes-Hut-SNE", arXiv pre-print, 1301.3342v2.

3. http://homepage.tudelft.nl/19j49/t-SNE.html (L. van der Maaten's webpage on the t-SNE algorithm).

4. https://github.com/jkrijthe/Rtsne (J. Krijthe's GitHub repository for the Rtsne package).

5. E.D. Amir et al. (2013), "viSNE enables visualization of high dimensional single-cell data and reveals phenotypic heterogeneity of leukemia", Nature Biotechnology, 31, 545–552, http://www.ncbi.nlm.nih.gov/pubmed/23685480.

6. http://www.c2b2.columbia.edu/danapeerlab/html/cyt.html (Dana Pe'er lab page on viSNE).
