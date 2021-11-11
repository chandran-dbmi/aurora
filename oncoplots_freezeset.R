if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("maftools")
install.packages("dplyr")
install.packages("ggplot2")



library(maftools)
library(readxl)
library(dplyr)
library(ggplot2)
library(RColorBrewer)

dna_freeze <- read.delim("../../Results/DNA-Seq/WES/Vcf2maf/134_FreezeSet/134_freezeset.maf")

# convert coord id to aliquot id
coord.mapping <- read_xlsx("../../Metadata/Variants/180718_Aurora_NCH.xlsx")
coord.mapping <- coord.mapping[c("Coord", "BCR Aliquot Barcode", "Patient ID", "Preservation Method")]

dna_freeze$T_BCR <- coord.mapping$`BCR Aliquot Barcode`[ match(dna_freeze$Tumor_Sample_Barcode, coord.mapping$Coord)]
dna_freeze$N_BCR <- coord.mapping$`BCR Aliquot Barcode`[ match(dna_freeze$Matched_Norm_Sample_Barcode, coord.mapping$Coord)]


# check for NA
tmp <- dna_freeze[is.na(dna_freeze$T_BCR),]

dna_freeze$Tumor_Sample_Barcode <- NULL
dna_freeze$Matched_Norm_Sample_Barcode <- NULL

# dna_freeze.renamed <- dna_freeze.renamed[,c(1,4,5,2,3)] # re-order
names(dna_freeze)[names(dna_freeze) == "T_BCR"] <- "Tumor_Sample_Barcode"
names(dna_freeze)[names(dna_freeze) == "N_BCR"] <- "Matched_Norm_Sample_Barcode"

# add allele frequencies
dna_freeze$t_vaf <- dna_freeze$t_alt_count/dna_freeze$t_depth

# new request to filter by depth (t_depth >= 20) and allele frequency (t_vaf >= 0.03)
# new request to filter by depth (t_depth >= 50) and allele frequency (t_vaf >= 0.05). Date: Oct 29, 2021
dna_freeze <- dna_freeze[dna_freeze$t_vaf >= 0.05,] # vaf filter
dna_freeze <- dna_freeze[dna_freeze$t_depth >= 50,] # tumor depth

# subset primaries and metastatic samples
dna.ttp <- dna_freeze[grepl("TTP", dna_freeze$Tumor_Sample_Barcode),]
dna.ttm <- dna_freeze[grepl("TTM", dna_freeze$Tumor_Sample_Barcode),]

# modified tumor barcodes all 136 samples
write.table(dna_freeze, file = "../../Results/DNA-Seq/WES/Vcf2maf/134_FreezeSet/134_freezeset_TumorBarcodeRenamed.maf",
            quote = FALSE, sep = "\t", row.names = FALSE)
# modified tumor barcodes for TTP samples only
write.table(dna.ttp, file = "../../Results/DNA-Seq/WES/Vcf2maf/134_FreezeSet/134_freezeset_TTP_TumorBarcodeRenamed.maf",
            quote = FALSE, sep = "\t", row.names = FALSE)
# modified tumor barcodes TTM samples only
write.table(dna.ttm, file = "../../Results/DNA-Seq/WES/Vcf2maf/134_FreezeSet/134_freezeset_TTM_TumorBarcodeRenamed.maf",
            quote = FALSE, sep = "\t", row.names = FALSE)

### read the main maf file
clin_data <- read.delim("../../Results/DNA-Seq/WES/Vcf2maf/134_FreezeSet/134_clinical_data.txt")
clin_data$patient_id <- substr(clin_data$Tumor_Sample_Barcode, 5, 8)
df.maf = read.maf(maf = "../../Results/DNA-Seq/WES/Vcf2maf/134_FreezeSet/134_freezeset_TumorBarcodeRenamed.maf",
                  clinicalData = clin_data,
                  useAll = T)


# read significant genes list
sig_genes <- read.delim("Input/Significant_genes_list.txt", header = FALSE)
sig_genes2 <- read.delim("Input/Significant_genes_list_nonzero_oncoplot.txt", header = FALSE)
sig_genes3 <- read.delim("Input/Significant_genes_list_RUNX1_cutoff.txt", header = FALSE) # Percentage cutoff with RUNX1 as min percent

# get tmb from maf
tmb <- df.maf@variants.per.sample

tmb$Tumor_Sample_Barcode <- as.character(tmb$Tumor_Sample_Barcode)
tmb$patient_id <- substr(tmb$Tumor_Sample_Barcode, 5,8)
tmb$subtype <- substr(tmb$Tumor_Sample_Barcode, 10, 13)
tmb$subtype <- gsub("\\d+", "", tmb$subtype)
#samples_ordered <- tmb[order(tmb$subtype, tmb$Variants, tmb$Tumor_Sample_Barcode),]
#samples_ordered <- tmb[order(-tmb$Tumor_Sample_Barcode, -tmb$subtype, tmb$Variants),] # reverse order to bring TTP ahead of TTM
samples_ordered <- tmb[order(tmb$patient_id, -tmb$subtype, tmb$Variants),] # reverse order to bring TTP ahead of TTM

# subtype: TTP, TTM (Tumor Tissue Primary, Tumor Tissue Metastic)
# Variants: #Variants per sample in MAF produced also known as TMB in oncoplots
# Tumor Sample Barcode: BCR Aliqout Barcode for each sample
# If needed to be sorted by sample above code:
# samples_ordered <- tmb[order(tmb$Tumor_Sample_Barcode, tmb$subtype, tmb$Variants),]
# 2nd order and 3rd order here by subtype and Variants is optional.

# add preservation method
tmb.preservation <- merge(tmb, coord.mapping, 
      by.x = "Tumor_Sample_Barcode",
      by.y = "BCR Aliquot Barcode")

tmb.preservation$`Patient ID` <- NULL
# Order tmb preservation before printing 
tmb.preservation2 <- tmb.preservation[order(tmb.preservation$patient_id, -tmb.preservation$subtype, tmb.preservation$Variants),]

# write tmb with preservation output
write.table(tmb.preservation, 
            file = "../../Results/DNA-Seq/WES/Vcf2maf/134_FreezeSet/134_freezeset_tmb_preservation_method.txt", 
            sep = "\t", quote = FALSE, row.names = FALSE)
write.table(tmb.preservation2, 
            file = "../../Results/DNA-Seq/WES/Vcf2maf/134_FreezeSet/134_freezeset_tmb_preservation_method.ordered.txt", 
            sep = "\t", quote = FALSE, row.names = FALSE)

## plots
pdf("../../Plots/Oncoplots/134_Freezeset/MAF_summary.pdf","a4")
plotmafSummary(maf = df.maf,
               addStat = 'median',
               dashboard = TRUE)
dev.off()

#Color coding for Patient, Sample type, Preservation method

#Patient ID
n <- length(unique(samples_ordered$patient_id)) # number of patients
qual_col_pals = brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector = unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals))) # Generates a list of 74 different colors
patient_id_colors = sample(col_vector, n) # Sample list of colors equal to number of patients
names(patient_id_colors) <- unique(samples_ordered$patient_id)
patient_id_colors = list(patient_id = patient_id_colors)

# Sample Type
sampletype_colors = c("firebrick", "darkblue")
names(sampletype_colors) = c("Primary", "Metastatic")
sampletype_colors = list(Sample_Type = sampletype_colors)

# Preservation Method
preservation_colors = c("darkorange", "darkgreen")
names(preservation_colors) = c("FFPE", "Frozen")
preservation_colors = list(Preservation_Method = preservation_colors)

### Susana provided color codes
# patient_id
patient_id_colors = c ("AFEA"="#01D83A","AFE7"="#66CDAA","AD9G"="#C1CDCD","AFE5"="#E8B174","AG0N"="#0000FF",
                       "AG0M"="#FFC6CC","AG0J"="#9932CC","AFSP"="#8B7355","AF9A"="#53868B","AF98"="#458B00",
                       "AF95"="#77DBC0","AFSL"="#8B3E2F","AFR5"="#99CAFF","AE6Y"="#00CDCD","AE5H"="#FFB90F"          ,
                       "AFUI"="#BDB76B","AER7"="#FFBB67","AER6"="#FF6C3D","AFEC"="#B6FF8D" ,
                       "AG12"="#C6C600","AERX"="#00CED1","AERW"="#CD1076","AFSO"="#009ACD",          
                       "AFR3"="#1874CD","AE5G"="#CD2626","AF94"="#361100","AFE4"="#E50079","AFUN"="#8B6914",      
                       "AFUL"="#008B00","AFKB"="#C1CDC1","AEPZ"="#CD6090","AER8"="#CD5555","AFKF"="#FFC147",       
                       "AFUM"="#CDC673","AFE9"="#B77D95","AER2"="#DFABFF","AFE6"="#8cb315","AFR4"="#FDF500",
                       "AE6X"="#EEDD82","AERY"="#8B8378","ADCB"="#458B74","AD9I"="#838B8B","AD9F"="#CDB79E",
                       "AFUG"="#3C3C54","AFR2"="#68228B","AD9J"="#DEB887","AFKD"="#5F9EA0",
                       "AER4"="#7FFF00","AFUP"="#8B4500","AFUK"="#FF7F50","AD9H"="#6495ED",
                       "AD9E"="#8B8878","AFUO"="#008B8B","AER5"="#DAAA00","AF99"="#91AC00")
patient_id_colors = list(patient_id = patient_id_colors)

# Sample_Type
sampletype_colors = c("Primary"="#17598f","Metastatic"="#fad975")
sampletype_colors = list(Sample_Type = sampletype_colors)

# Preservation_Method
preservation_colors = c("Frozen"="#DCDCDC","FFPE"="#404040")
preservation_colors = list(Preservation_Method = preservation_colors)

annotation_colors = append(patient_id_colors, sampletype_colors)
annotation_colors2 = append(annotation_colors, preservation_colors)

## Oncoplot
# top 50 genes
pdf("../../Plots/Oncoplots/134_Freezeset/oncoplot_134_freezeset_top50_annotation_colors.pdf", "a4")
oncoplot(maf = df.maf, 
         top = 50,
         fontSize = 0.4,
         removeNonMutated = FALSE,
         sampleOrder = samples_ordered$Tumor_Sample_Barcode,
         clinicalFeatures = c('patient_id', 'Sample_Type', 'Preservation_Method'),
         annotationColor = annotation_colors2,
         annotationFontSize = 0.55,
         legendFontSize = 0.6,
         titleFontSize = 1,
         logColBar = TRUE
         )

dev.off()
# with significant genes
pdf("../../Plots/Oncoplots/134_Freezeset/oncoplot_134_freezeset_sig_genes_annotation_colors.pdf","a4")
oncoplot(maf = df.maf, 
         genes = sig_genes$V1,
         fontSize = 0.4,
         removeNonMutated = FALSE,
         sampleOrder = samples_ordered$Tumor_Sample_Barcode,
         clinicalFeatures = c('patient_id', 'Sample_Type', 'Preservation_Method'),
         annotationColor = annotation_colors2,
         annotationFontSize = 0.55,
         legendFontSize = 0.6,
         titleFontSize = 1
         )

dev.off()

# with significant genes without 0%
pdf("../../Plots/Oncoplots/136_Freezeset/oncoplot_134_freezeset_sig_genes2_annotation_colors.pdf","a4")
oncoplot(maf = df.maf, 
         genes = sig_genes2$V1,
         fontSize = 0.4,
         removeNonMutated = FALSE,
         sampleOrder = samples_ordered$Tumor_Sample_Barcode,
         clinicalFeatures = c('patient_id', 'Sample_Type', 'Preservation_Method'),
         annotationColor = annotation_colors2,
         annotationFontSize = 0.55,
         legendFontSize = 0.6,
         titleFontSize = 1
         )

dev.off()

# with RUNX1 significant genes cutoff (3%)
pdf("../../Plots/Oncoplots/134_Freezeset/oncoplot_134_freezeset_sig_genes3_annotation_colors.pdf","a4")
oncoplot(maf = df.maf, 
         genes = sig_genes3$V1,
         fontSize = 0.4,
         removeNonMutated = FALSE,
         sampleOrder = samples_ordered$Tumor_Sample_Barcode,
         clinicalFeatures = c('patient_id', 'Sample_Type', 'Preservation_Method'),
         annotationColor = annotation_colors2,
         annotationFontSize = 0.55,
         legendFontSize = 0.6,
         titleFontSize = 1
         )

dev.off()


# vaf
sig_genes_vaf = subsetMaf(maf = df.maf,
                          genes = sig_genes$V1,
                          fields = "t_vaf", 
                          mafObj = FALSE)
#"5'Flank", "3'Flank","5'UTR", "3'UTR"
sig_genes_vaf <- subset(sig_genes_vaf, 
       Variant_Classification != c('Silent', 'Intron'))
sig_genes_vaf <- sig_genes_vaf[,mean(t_vaf, na.rm = TRUE), c("Hugo_Symbol", "Tumor_Sample_Barcode")]

# Add Preservation method to sig_genes_vaf for plotting variant frequencies on Preservation method
sig_genes_vaf.preservation <- merge(sig_genes_vaf, coord.mapping, 
                                    by.x = "Tumor_Sample_Barcode", by.y = "BCR Aliquot Barcode")

## Box Plots

# Box plot of Frequency vs. genes split on Preservation method
box_plot <- ggplot(sig_genes_vaf.preservation, aes(x = Hugo_Symbol, y = V1, color = Hugo_Symbol))
box_plot + geom_boxplot() + theme_classic() + labs(title = "Frozen vs. FFPE \n Boxplots of 74 Sig Genes", x = "Genes (HUGO Symbol)", y = "Variant Allele Freq") + theme(plot.title = element_text(hjust = 0.5)) + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

# Box plot of VAF vs. Preservation Method
box_plot <- ggplot(sig_genes_vaf.preservation, aes(x = `Preservation Method`, y = V1, color = `Preservation Method`))
box_plot + geom_boxplot() + theme_classic() + labs(title = "Frozen vs. FFPE Allele Frequencies", x = "Preservation Method", y = "Variant Allele Freq") + theme(plot.title = element_text(hjust = 0.5)) + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

write.table(df.maf@data, 
            file = "../../Results/DNA-Seq/WES/Vcf2maf/134_FreezeSet/134_freezeset_coding_variants.maf", 
            sep = "\t", quote = FALSE, row.names = FALSE)

## Co-oncoplots between TTM and TTP
# maf comparison between groups
df.maf.ttp = read.maf(maf = "../../Results/DNA-Seq/WES/Vcf2maf/134_FreezeSet/134_freezeset_TTP_TumorBarcodeRenamed.maf", 
                        useAll = T)

df.maf.ttm = read.maf(maf = "../../Results/DNA-Seq/WES/Vcf2maf/134_FreezeSet/134_freezeset_TTM_TumorBarcodeRenamed.maf", 
                       useAll = T)

ttp.vs.ttm <- mafCompare(m1 = df.maf.ttp, 
                            m2 = df.maf.ttm, 
                            m1Name = 'TTP', 
                            m2Name = 'TTM', 
                            minMut = 1)
print(ttp.vs.ttm)
write.table(ttp.vs.ttm$results, 
            file = "../../Results/DNA-Seq/WES/Vcf2maf/136_FreezeSet/Fishers_TTP_TTM_134_freezeset.txt", 
            sep = "\t", quote = FALSE, row.names = FALSE)

# CoOncoplot top 50 genes
pdf("../../Plots/Oncoplots/134_Freezeset/CoOncoplot_TTP_TTM_134_Freezeset.pdf","a4")
coOncoplot(m1 = df.maf.ttp, m2 = df.maf.ttm, 
           m1Name = 'TTP', m2Name = 'TTM', 
            genes = head(ttp.vs.ttm$results$Hugo_Symbol, 50),
           #genes = sig_genes$V1,
           geneNamefont = 0.5,
           removeNonMutated = FALSE)
dev.off()

# CoOncoplot significant genes
pdf("../../Plots/Oncoplots/134_Freezeset/CoOncoplot_TTP_TTM_134_Freezeset_sig_genes.pdf","a4")
coOncoplot(m1 = df.maf.ttp, m2 = df.maf.ttm, 
           m1Name = 'TTP', m2Name = 'TTM', 
           #genes = head(ttp.vs.ttm$results$Hugo_Symbol, 50),
           genes = sig_genes$V1,
           geneNamefont = 0.5,
           removeNonMutated = FALSE)
dev.off()

# CoOncoplot significant genes without 0% frequency
pdf("../../Plots/Oncoplots/134_Freezeset/CoOncoplot_TTP_TTM_134_Freezeset_sig_genes2.pdf","a4")
coOncoplot(m1 = df.maf.ttp, m2 = df.maf.ttm, 
           m1Name = 'TTP', m2Name = 'TTM', 
           #genes = head(ttp.vs.ttm$results$Hugo_Symbol, 50),
           genes = sig_genes2$V1,
           geneNamefont = 0.5,
           removeNonMutated = FALSE)
dev.off()

# CoOncoplot significant genes RUNX1 cutoff (3%)
pdf("../../Plots/Oncoplots/134_Freezeset/CoOncoplot_TTP_TTM_134_Freezeset_sig_genes3.pdf","a4")
coOncoplot(m1 = df.maf.ttp, m2 = df.maf.ttm, 
           m1Name = 'TTP', m2Name = 'TTM', 
           #genes = head(ttp.vs.ttm$results$Hugo_Symbol, 50),
           genes = sig_genes2$V1,
           geneNamefont = 0.5,
           removeNonMutated = FALSE)
dev.off()

