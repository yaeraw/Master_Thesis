setwd("C:/Users/yarab/OneDrive/uni/Master_Biochemie/Masterarbeit/Single_cell_data/")

install.packages("Seurat")
install.packages("hdf5r")

library("Seurat")
library("hdf5r")

setwd("C:/Users/yarab/OneDrive/uni/Master_Biochemie/Masterarbeit/Single_cell_data/hMSCs_1874_outs")
sc_data_1874  <- Read10X_h5("filtered_feature_bc_matrix.h5")

#create Seurat Object

msc_1874 <- CreateSeuratObject(counts = sc_data_1874)

msc_1874

#check if data has been normalized allready -> it has not
head(GetAssayData(msc_1874, assay = "RNA", slot = "counts"))
head(GetAssayData(msc_1874, assay = "RNA", slot = "data"))

bmp_genes <- c("ACVR1", "BMPR1A", "BMPR1B", "ACVRL1", "BMPR2", "ACVR2A", "ACVR2B", "TGFBR1", "TGFBR2", "Yara")
SMAD_genes <- c("SMAD1", "SMAD2", "SMAD3", "SMAD4", "SMAD5", "SMAD6", "SMAD7", "SMAD9")
target_genes <- c("ID1", "ID2", "ID3", "DLX5", "RUNX2")

present_1874 <- intersect(bmp_genes, row.names(msc_1874))

present_1874                          

# Violin plot
VlnPlot(msc_1874, features = present_1874)

setwd("C:/Users/yarab/OneDrive/uni/Master_Biochemie/Masterarbeit/Single_cell_data/all_data")

p1874 <- Read10X_h5("1874_filtered_feature_bc_matrix.h5")
p1937 <- Read10X_h5("1937_filtered_feature_bc_matrix.h5")
p1961 <- Read10X_h5("1961_filtered_feature_bc_matrix.h5")
p1996 <- Read10X_h5("1996_filtered_feature_bc_matrix.h5")

# create seurat objects
msc_p1874 <- CreateSeuratObject(counts = p1874)
msc_p1937 <- CreateSeuratObject(counts = p1937)
msc_p1961 <- CreateSeuratObject(counts = p1961)
msc_p1996 <- CreateSeuratObject(counts = p1996)

#add patient ID
msc_p1874$patient_id <- "1874"
msc_p1937$patient_id <- "1937"
msc_p1961$patient_id <- "1961"
msc_p1996$patient_id <- "1996"

#merge into one dataset
msc_all <- merge(msc_p1874, y = list(msc_p1937, msc_p1961, msc_p1996), add.cell.ids = c("1874", "1937", "1961", "1996"))

msc_all
table(msc_all$patient_id)
head(colnames(msc_all))

#install for mormalization

install.packages("BiocManager")
BiocManager::install("glmGamPoi")

#normalize data with SCTransform
msc_all <- SCTransform(msc_all, verbose = TRUE)

#Is the Assay normalized
DefaultAssay(msc_all)
  #shows SCT -> so everything worked

#Scaling genes
msc_all <- ScaleData(msc_all)

#Dimensional Reduction (PCA)
msc_all <- RunPCA(msc_all)

#deciding how many dimensions to use
ElbowPlot(msc_all)

#Make UMAP
msc_all <- RunUMAP(msc_all, reduction = "pca", dims = 1:20)

#visualize UMAP
DimPlot(msc_all, reduction = "umap")
DimPlot(msc_all, reduction = "umap", group.by = "patient_id")

FeaturePlot(msc_all, features = bmp_genes)
FeaturePlot(msc_all, features = SMAD_genes)

VlnPlot(msc_all, features = "BMPR2", group.by = "patient_id")
VlnPlot(msc_all, features = bmp_genes, group.by = "patient_id")

VlnPlot(msc_all, features = SMAD_genes, group.by = "patient_id")
VlnPlot(msc_all, features = target_genes, group.by = "patient_id")

VlnPlot(msc_all, features = "SMAD9",
        group.by = "patient_id",
        assay = "RNA",
        slot = "counts")

VlnPlot(msc_all, features = "nCount_RNA", group.by = "patient_id")
VlnPlot(msc_all, features = "nFeature_RNA", group.by = "patient_id")

msc_all_n <- FindNeighbors(msc_all, dims = 1:20)
msc_all_n <- FindClusters(msc_all_n, resolution = 0.4)

DimPlot(msc_all_n, group.by = "seurat_clusters")
FeaturePlot(msc_all_n, features = "SMAD9")

DimPlot(msc_all_n, reduction = "umap", group.by = "patient_id")

