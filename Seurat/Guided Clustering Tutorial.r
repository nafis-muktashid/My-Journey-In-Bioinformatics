# This is a regenerated R script of the Guided Clustering Tutorial from Seurat's official website.



# Step - 1 : Setting the Seurat Object

# Initializing the library to work with the data
library(dplyr)
library(Seurat)
library(patchwork)

# Creating a variable to store and work with the data more easily
pbmc.data <- Read10X(data.dir = "D:/R/R_Project/filtered_gene_bc_matrices/hg19/")

# Initializing the Seurat object with the raw data.
pbmc <- CreateSeuratObject(counts = pbmc.data, project = "pbmc3k", min.cells = 3, min.features = 200)

# Viewing the object
pbmc



# Features == Genes;   Counts == How many times a gene is found;



# Step - 2 : Standard pre-processing workflow

# Making a new column that indicates the mitochondial gene percentage. The higher the mitochondia in a cell the
#        lower the quality of that cell
pbmc[["percent.mt"]] <- PercentageFeatureSet(pbmc, pattern = "^MT-")

# Viewing the whole dataset with newly added mitochondrial percentage column
# View(pbmc@meta.data)

#Visualizing Quality Control metrics as a violin plot 
VlnPlot(pbmc, features = c("nFeature_RNA", "nCount_RNA", "percent.mt"), ncol = 3)

#There is more way to view QC metrics. One way to it is FeatureScatter. Although it is used for feature-feature
#        relationships but it can be used to see anything calculated by the object.
plot_1 <- FeatureScatter(pbmc, feature1 = "nCount_RNA", feature2 = "percent.mt")
plot_2 <- FeatureScatter(pbmc, feature1 = "nCount_RNA", feature2 = "nFeature_RNA")
plot_1 + plot_2

#Filtering the actual dataset (Size reduced from 29.7MB to 28.6MB)
pbmc <- subset(pbmc, subset = nFeature_RNA > 200 & nFeature_RNA < 2500 & percent.mt < 5)



# Step - 3 : Normalizing the data

# Normalization is employed by "LogNormalize" method with a scaling factor 
#        of 10,000 by default (Size increased to 55.6MB)
pbmc <- NormalizeData(pbmc, normalization.method = "LogNormalize", scale.factor = 10000)
# This can be also written as the following (In case of default normalizing only)
# pbmc <- NormalizeData(pbmc)



# Step - 4 : Identification of highly variable features 

# Modifying the dataset
pbmc <- FindVariableFeatures(pbmc, selection.method = "vst", nfeatures = 2000)
# Value of selection.method && nFeatures are by default "vst" && 2000 
#        respectively. So this can be written as following
# pbmc <- FindVariableFeatures(pbmc)

# Viewing the top10 highly variable genes
top10 <- head(VariableFeatures(pbmc), 10)
top10

# Plotting top10 variable with labels and without labels
plot_1 <- VariableFeaturePlot(pbmc)
plot_2 <- LabelPoints(plot = plot_1, points = top10, repel = TRUE)
plot_1 + plot_2



# Step - 5 : Scaling the data

# Scale the data using ScaleData() function. Scaled data is store at the data[["newColumn"]]$scale.data slot
# Creating new variable to all rows
all.gene <- rownames(pbmc)
# Modifying the dataset (Size increased from 55.6MB to 346.8MB)
pbmc <- ScaleData(pbmc, features = all.gene)

# To remove unwanted sources of variation (Size reduced from 346.8MB to 98.7MB)
#        In case of using this functionality, it is recommended to use SCTransform() normalization workflow
# pbmc <- ScaleData(pbmc, vars.to.regress = "percent.mt")



# Step - 6 : Linear Dimensional reduction

# Modifying the dataset
pbmc <- RunPCA(pbmc, features = VariableFeatures(object = pbmc))

# Printing Principle Component Analysis results
print(pbmc[["pca"]], dims = 1:5, nfeatures = 5)
# Visualizing : VizDimLoadings()
VizDimLoadings(pbmc, dims = 1:2, reduction = "pca")
# Visualizing : DimPlot()
DimPlot(pbmc, reduction = "pca") + NoLegend()
# Visualizing : DimHeatMap()
DimHeatmap(pbmc, dims = 1:15, cells = 500, balanced = TRUE)



# Step - 7 : Determine the dimensionality of the dataset

# Visualizing Principle Components with ElbowPlot()
ElbowPlot(pbmc)



# Step - 8 : Cluster the cells

# Optimize standard modularity and modify the dataset (Size increased from 346.8MB to 353.1MB)
pbmc <- FindNeighbors(pbmc, dims = 1:10)

# Clustering to optimize the standard modularity
pbmc <- FindClusters(pbmc, resolution = 0.5)

# Viewing cluster ID's of first 5 cells
head(Idents(pbmc), 5)




# Step - 9 : Run non linear dimensional reduction using UMAP or tSNE

# Run UMAP (Size increased from 353.1MB to 353.4MB)
pbmc <- RunUMAP(pbmc, dims = 1:10)

# Visualize the clusters using DimPlot
DimPlot(pbmc, reduction = "umap")


# Saving the data object 
# saveRDS(pbmc, file = "/pathFromTheProjectFloder")



#---------- End of scRNA-seq -----------






# Finding differentially expressed features (Cluster biomarkers)

# Finding all the markers of a single cluster
cluster2.markers <- FindMarkers(pbmc, ident.1 = 2)
# first 5 cells of cluster 2
# head(cluster2.markers, n=5)


# Finding all markers distinguishing cluster 5 from cluster 0 and 3
cluster5.markers <- FindMarkers(pbmc, ident.1 = 5, ident.2 = c(0, 3))
# first 5 cells of cluster 5
# head(cluster5.markers, n=5)


# Finding markers for every cluster compared to all remaining cells - positive only 
pbmc.markers <- FindAllMarkers(pbmc, only.pos = TRUE)
# View(pbmc.markers)
pbmc.markers %>%
  group_by(cluster) %>%
    dplyr::filter(avg_log2FC > 1)

# Classification power ( 0-random; 1-perfect)
cluster0.markers <- FindMarkers(pbmc, ident.1 = 0, logfc.threshold = 0.25, test.use = "roc", only.pos = TRUE)

# Visualize using VlnPlot()
VlnPlot(pbmc, features = c("MS4A1", "CD79A"))
# Raw counts using violin plot
VlnPlot(pbmc, features = c("NKG7", "PF4"), slot = "counts", log = TRUE)

# Visualize using FeaturePlot
FeaturePlot(pbmc, features = c("MS4A1", "GNLY", "CD3E", "CD14", "FCER1A", "FCGR3A", "LYZ", "PPBP", "CD8A"))

# Generating expression heatmap using DoHeatMap()
pbmc.markers %>%
  group_by(cluster) %>%
  dplyr::filter(avg_log2FC > 1) %>%
  slice_head(n = 10) %>%
  ungroup() -> top10
# Plot
DoHeatmap(pbmc, features = top10$gene) + NoLegend()




# Assigning cell type identity to clusters
new.cluster.ids <- c("Naive CD4 T", "CD14+ Mono", "Memory CD4 T", "B", "CD8 T", "FCGR3A+ Mono", "NK", "DC", "Platelet")

names(new.cluster.ids) <- levels(pbmc)

pbmc <- RenameIdents(pbmc, new.cluster.ids)

DimPlot(pbmc, reduction = "umap", label = TRUE, pt.size = 0.5) + NoLegend()






