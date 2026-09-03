####################################
# Project_name : Reproducibility
# Script_name : 03_Res_gasar.R
# Script_function : Summarise data for Crassostrea gasar
# Contact : t.soldourdin@gmail.com
####################################

Res_gasar <- function(data) {
  data %>%
    summarise(length=mean(Longueurs) )
}