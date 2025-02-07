####################################
# Project_name : Reproducibility
# Script_name : 03_Plot_length.R
# Script_function : Plot length data for Crassostrea gasar
# Contact : t.soldourdin@gmail.com
####################################

Plot_length <- function(Resume){
  ggplot(data = Resume, aes(x=Station, y=length, color=Lot)) +
    geom_point()
}