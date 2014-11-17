Rtsne example
=============

This repository contains a detailed example demonstrating how to calculate and plot a 2-dimensional t-SNE projection from a 13-dimensional mass cytometry data set, using the `Rtsne` package in R.


### t-SNE and Barnes-Hut-SNE

The t-SNE algorithm (t-SNE stands for *t-Distributed Stochastic Neighbor Embedding*) was developed by Laurens van der Maaten and Geoffrey Hinton [1]. It is a sophisticated algorithm for dimensionality reduction, popular for representing high-dimensional data in 2 or 3 dimensions to allow visualization using scatter plots.

Barnes-Hut-SNE [2] is a recent extension by Laurens van der Maaten, which uses Barnes-Hut approximations to substantially improve the speed of the algorithm --- to *O(N log N)* instead of *O(N<sup>2</sup>)*. This makes it feasible to apply the algorithm to larger data sets.

Laurens van der Maaten's website at http://homepage.tudelft.nl/19j49/t-SNE.html [3] provides detailed information on the t-SNE and Barnes-Hut-SNE algorithms, as well as downloadable implementations in a large number of programming languages.


### Rtsne

The `Rtsne` package by Jesse Krijthe [4] provides an R wrapper function for the C++ implementation of Barnes-Hut-SNE. It can be found via the link above or the CRAN R package repository.

In R, the `Rtsne` package can be installed and loaded as usual with `install.packages("Rtsne")` and `library(Rtsne)`. For an example of usage of the `Rtsne` function, see https://github.com/jkrijthe/Rtsne.


### viSNE paper and mass cytometry data

A recent paper by Amir et al. (2013) [5] introduced `viSNE`, a tool for Matlab to calculate t-SNE or Barnes-Hut-SNE projections and plot visualizations as 2-dimensional or 3-dimensional scatter plots. `viSNE` and its associated visualization tool `cyt` can be downloaded from http://www.c2b2.columbia.edu/danapeerlab/html/cyt.html.

Mass cytometry is a recent advance in flow cytometry, which allows expression levels of up to dozens of proteins to be measured in thousands of cells per second. This creates high-dimensional data sets, with each dimension representing the expression level of one protein. However, while these data sets contain a lot of information, they cannot be visualized easily. Tools such as `viSNE` aim to help in the interpretation of these data sets by generating a low-dimensional projection, which can then be analyzed visually.

In the Amir et al. (2013) paper, the performance of `viSNE` is demonstrated on mass cytometry data from healthy and cancerous human bone marrow samples. `viSNE` accurately groups cells from known cell populations in clusters on the 2-dimensional projection maps (for example, see Figure 1b in the paper). The data can be downloaded from http://www.c2b2.columbia.edu/danapeerlab/html/cyt.html.


### Example using Rtsne

In this repository, we demonstrate how to calculate and plot 2-dimensional t-SNE projections (with the Barnes-Hut-SNE algorithm) using the `Rtsne` package for R. Performing all calculations in R allows easy integration with further statistical analysis or plotting in an open-source scripting environment.

For the example calculations, we use the healthy human bone marrow data set "Marrow1" from Figure 1b of the Amir et al. (2013) paper. This figure shows an example of an "ideal" t-SNE projection map, where cells from different cell populations (types) are grouped as distinct clusters of points in the 2-dimensional projection map, and there is clear visual separation between clusters. The authors also independently verified the interpretation of the clusters using traditional 2-dimensional "gating" methods, confirming that several clusters represent known cell types (CD4 T cells, CD8 T cells, etc).

The data set can be downloaded from http://www.c2b2.columbia.edu/danapeerlab/html/cyt.html (filename "visne_marrow1.fcs"). A backup is also available in the `data` folder in this repository.

The R script `Rtsne_viSNE_example_Marrow1.R` contains all code to run through the example. The resulting 2-dimensional t-SNE (Barnes-Hut-SNE) projection maps are saved in the `plots` folder. The example consists of the following steps. Each step is explained in more detail in comments in the code.

* loading data and selecting appropriate columns
* arcsinh transformation
* subsampling
* removing duplicates within rounding
* exporting data if required
* running `Rtsne` and plotting the projection map

Note that due to the stochastic nature of the t-SNE and Barnes-Hut-SNE algorithms, the exact shape and orientation of the clusters will vary each time the algorithm is run --- the important thing is the visual separation between clusters. We have used the `set.seed` command to ensure reproducibility in the subsampling and `Rtsne` steps.


### References

1. t-SNE paper

2. Barnes-Hut t-SNE paper

3. L. v.d.Maaten's t-SNE website

4. J. Krijthe's github page for Rtsne

5. viSNE paper
