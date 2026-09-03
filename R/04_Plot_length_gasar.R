####################################
# Project_name : gasar
# Script_name : 04_Plot_length.R
# Script_function : Plot length data for Crassostrea gasar
# Contact : t.soldourdin@gmail.com
####################################

# 1-Build box plot to display shell length by station
Plot_length <- function(data, resume, letters){

  ggplot(data = data, aes(x=Station, y=Longueurs, fill=Station, color=Station)) +
    geom_boxplot(alpha=0.25) +
    geom_jitter(width=0.25) +
    geom_hline(yintercept = resume$length, color = "red", linewidth=0.8, linetype="dashed") +
    geom_text(data = letters, aes(label = letter, y = 7.7 ), colour="black", size=5) + 
    theme_bw() +
    theme(axis.text = element_text(size=12)) +
    labs(x="")
}

# 2-Export the plot in .png format
PlotExport <- function(file, plot, W=NA, H=NA, U="in") {
  
  ggsave(file, plot, dpi = 300, width=W, height=H, units=U, create.dir=TRUE)
}
  