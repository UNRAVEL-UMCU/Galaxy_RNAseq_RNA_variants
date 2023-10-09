library(ggplot2)
library(tidyr) 
library(readxl)

# Read the Excel file
df <- read_excel("BAMQC_samtoolsstats.xlsx", sheet = 1)

# Reshape the data to long format
df_long <- df %>%
  gather(key = "Read_Type", value = "Number_of_Reads", reads_mapped, reads_unmapped)

# Reorder the levels of the Read_Type factor
df_long$Read_Type <- factor(df_long$Read_Type, levels = c("reads_unmapped", "reads_mapped"))

# Stacked Bar Plot
q <- ggplot(df_long, aes(fill = Read_Type, y = Number_of_Reads, x = Sample, width = 0.8)) +
  geom_bar(stat = "identity", position = "stack") +  
  scale_fill_manual(values = c("reads_mapped" = "#CECCCC", "reads_unmapped" = "black")) +
  labs(
    title = "Number of mapped and unmapped reads per replicate",
    x = "Replicate name",
    y = "Number of reads"
  ) +
  theme(
    axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5),
    axis.ticks.length.y = unit(c(0, 0.15), "cm"),
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
  coord_cartesian(ylim = c(0, max(df_long$Number_of_Reads)))

q

ggsave("BAMQC_stackedbar_Michigan.pdf", height = 100, width = 250, units = "mm")
