#install.packages("ggplot2")
#install.packages("ggfortify")

# Library
library(readr)
library(DESeq2)
library(ggfortify)
library(factoextra)
library(readxl)

library(ggplot2)
library(dplyr)

# Read your data
rlog_data <- read_tsv("rLog-Normalized_counts.tabular")
rlog_matrix <- as.matrix(rlog_data[,-1])

replicate_name <- read_excel("names_to_replicate_mic.xlsx", sheet = 1)

# Specify the number of top genes for PCA
ntop <- 500

# Calculate the row variances and select the top genes
rv <- rowVars(rlog_matrix)
select <- order(rv, decreasing = TRUE)[seq_len(min(ntop, length(rv)))]

# Perform PCA
pca_rlog <- prcomp(t(rlog_matrix[select, ]), scale = FALSE)

# Create a data frame with PCA results
pca_df <- as.data.frame(pca_rlog$x)

# Get the current row names and sort them
sorted_row_names <- sort(rownames(pca_df))

# Reorder the rows of pca_df based on sorted_row_names
sorted_pca_df <- pca_df[sorted_row_names, ]

# Assuming your DataFrames are named pca_df and replicate_name
merged_df <- cbind(sorted_pca_df, replicate_name)

order <- c("CtlA1" = "#1f77b4", 
           "CtlA2" = "#4a90e2", 
           "CtlA3" = "#6ab7ff", 
           "CtlA4" = "#99c2ff", 
           "CtlA5" = "#b3d9ff", 
           "Ex1Het1" = "#2ca02c", 
           "Ex1Het2" = "#50d050", 
           "Ex1Het3" = "#7fff7f",
           "Ex1Het4" = "#a3ffa3",
           "Ex1Het5" = "#c2ffc2",
           "Ex27Het1" = "#d62728", 
           "Ex27Het2" = "#ff5555", 
           "Ex27Het3" = "#ff7f7f",
           "Ex27Het4" = "#ff9999",
           "Ex27Het5" = "#ffc2c2",
           "CtlB1" = "#9467bd", 
           "CtlB2" = "#b399e6", 
           "CtlB3"= "#ccace6", 
           "CtlB4" = "#e6ccff", 
           "CtlB5" = "#f2dbff",
           "Ex27Hom1" = "#ff7f0e", 
           "Ex27Hom2" = "#ffb84d", 
           "Ex27Hom3" = "#ffd699",
           "Ex27Hom4" = "#ffecb3", 
           "Ex27Hom5" = "#fff3cc",
           "PromHet1" = "#007c86", 
           "PromHet2" = "#0099a4", 
           "PromHet3" = "#00b7c1",
           "PromHet4" = "#00d5de", 
           "PromHet5" = "#00f3f8", 
           "RIN10" = "black")

# Plot the PCA with colored samples and labels
plot <- ggplot(merged_df, aes(x = PC1, y = PC2)) +
  geom_point(aes(color = Line_ID)) +
  labs(title = "PCA based on the variables with the most variance coloured per sample",
       x = paste("PC1 (", scales::percent(pca_rlog$sdev[1]^2 / sum(pca_rlog$sdev^2)), ")", sep = ""),
       y = paste("PC2 (", scales::percent(pca_rlog$sdev[2]^2 / sum(pca_rlog$sdev^2)), ")", sep = "")) +
  theme(panel.background = element_rect(fill='transparent'),
        plot.title = element_text(hjust = 0.5),
        panel.border = element_blank(), #rect(colour = "black", fill=NA),
        plot.background = element_rect(fill='transparent', color=NA),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "none",
        axis.ticks.length = unit(c(-0.15, 0.15), "cm"),  # Adjust the length of ticks
        axis.ticks = element_line(colour = "black"),  # Crossed ticks
        axis.line = element_line(colour = "black")
  ) +
  scale_colour_manual(values = order)
plot

# Save the plot as a PDF
pdf("PCA_norm_counts_rlog_mic.pdf", width = 4, height = 4)
print(plot)
dev.off()

