library(ggplot2)
library(tidyr)
library(patchwork)
library(readxl)
library(dplyr)

# Read the Excel file
df <- read_excel("snpeff_mic.xlsx", sheet = 1)

###################### PLOT 3A

# Assuming your data columns are named differently
df_long <- df %>%
  select(Sample, Line_ID, Ref, Het, Hom) %>%
  gather(key = "Variant_Type", value = "Count", Het, Hom, Ref)

# Specify the desired order of Variant_Type
df_long$Variant_Type <- factor(df_long$Variant_Type, levels = c("Ref", "Het", "Hom"))

# Create the plots
q <- ggplot(df_long, aes(fill = Variant_Type, y = Count, x = Sample, width = 0.8)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(
    title = "Number of variants per genotype",
    x = "Replicate",
    y = "Number of variants"
  ) +
  theme(
    axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5),
    axis.ticks.length = unit(c(0, 0.15), "cm"),
    axis.line = element_line(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill='transparent'),
    panel.border = element_blank(),
    plot.title = element_text(hjust = 0.5),  # Center the plot title
    plot.background = element_rect(fill='transparent', color=NA),
    legend.position = "top",
    legend.direction = "horizontal",
    legend.title = element_blank(),
    legend.box = "horizontal",
    legend.box.background = element_blank(),
    legend.background = element_rect(fill='transparent'),
    legend.key = element_rect(fill = "transparent")
  ) +
  scale_fill_manual(values = c("#999999", "#B4B4B3", "#CDCCCC"))
q

# Save the plot as a PDF
pdf("SNPEff_figure_3A_mic.pdf", width = 25, height = 10)
print(q)
dev.off()

###################### PLOT 3B
### 5 legend items

# Assuming data column name
df_long <- df %>%
  select(Sample, Line_ID, INTERGENIC, UPSTREAM_UTR_5_PRIME, DOWNSTREAM_UTR_3_PRIME, INTRON, SPLICE_SILENT_MISSENSE_NONSENSE) %>%
  gather(key = "Variant_Type", value = "Count", INTERGENIC, UPSTREAM_UTR_5_PRIME, DOWNSTREAM_UTR_3_PRIME, INTRON, SPLICE_SILENT_MISSENSE_NONSENSE)

# Specify the desired order of Variant_Type
variant_type_order <- c("INTERGENIC", "UPSTREAM_UTR_5_PRIME", "DOWNSTREAM_UTR_3_PRIME", "INTRON", "SPLICE_SILENT_MISSENSE_NONSENSE")
df_long$Variant_Type <- factor(df_long$Variant_Type, levels = variant_type_order)

# Stacked Bar Plot
q2 <- ggplot(df_long, aes(fill = Variant_Type, y = Count, x = Sample, width = 0.8)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(
    title = "Variant annotation (class)",
    x = "Replicate",
    y = "Number of variants"
  ) +
  theme(
    axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5),
    axis.ticks.length = unit(c(0, 0.15), "cm"),
    axis.line = element_line(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill='transparent'),
    panel.border = element_blank(),
    plot.title = element_text(hjust = 0.5),  # Center the plot title
    plot.background = element_rect(fill='transparent', color=NA),
    legend.position = "top",
    legend.direction = "horizontal",
    legend.title = element_blank(),
    legend.box = "horizontal",
    legend.box.background = element_blank(),
    legend.background = element_rect(fill='transparent'),
    legend.key = element_rect(fill = "transparent")
  ) +
  scale_fill_manual(values = c("#1D1D1B", "#999999", "#B4B4B3", "#CDCCCC", "#E4E5E4"))
  #scale_fill_manual(values = c("#E82F7F", "#82C17F", "#BEAED4", "#FABF86", "#FAF29B"))

q2

# Save the plot as a PDF
pdf("SNPEff_figure_3B_mic.pdf", width = 25, height = 10)
print(q2)
dev.off()
