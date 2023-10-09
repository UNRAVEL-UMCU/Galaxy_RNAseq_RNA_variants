# Load required libraries
library(ggplot2)
library(readxl)
library(reshape2)

# Load the gene body coverage data from Excel
genebody_df <- read_excel("genebody_Mic.xlsx", sheet = 2)

# Transpose the data and select the relevant columns
b <- t(genebody_df[5:104])

# Create a data frame with the transposed data
df <- data.frame(x = seq_along(b[, 1]), b)

# Convert data to long format using melt
df <- melt(df, id.vars = "x", variable.name = 'y')

# Convert x and value columns to numeric
df$x <- as.numeric(df$x)
df$value <- as.numeric(df$value)

# Find matching indices between melted data and original data
matching_indices <- match(df$y, genebody_df$Concat)

# Add Sample_Name column to df using matching indices
df$Line_ID <- genebody_df$Line_ID[matching_indices]

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

# Create the plot using ggplot
plot <- ggplot(df, aes(x = x, y = value, group = y, colour = Line_ID)) +
  geom_line() +
  ylab("Percentage of coverage") + 
  xlab("Gene body percentile (5' -> 3') (%)") +
  ggtitle("Gene body coverage") +
  theme(legend.position = "right",
        panel.background = element_rect(fill = 'transparent'),
        panel.border = element_blank(), #rect(colour = "black", fill=NA),
        plot.background = element_rect(fill='transparent', color=NA),
        plot.title = element_text(hjust = 0.5),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "black"),  # Add axis lines
        axis.ticks.length = unit(c(-0.15, 0.15), "cm"),  # Adjust the length of ticks
        axis.ticks = element_line(colour = "black")
  ) +
  scale_colour_manual(values = order)

plot

# Save the plot as a PDF with A4 paper size and one column format
pdf("genebody_mic.pdf", width = 8, height = 4)
print(plot)
dev.off()
