####################################
# Project_name : Reproducibility
# Script_name : 02_Res_gasar.R
# Script_function : Summarise data for Crassostrea gasar
# Contact : t.soldourdin@gmail.com
####################################

Res_gasar <- function(data) {
  data %>%
    group_by(Station, Lot) %>%
    summarise(length=mean(Longueurs) )
}