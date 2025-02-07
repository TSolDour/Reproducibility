####################################
# Project_name : Reproducibility
# Script_name : Load_gasar.R
# Script_function : Loading data for Crassostrea gasar
# Contact : t.soldourdin@gmail.com
####################################

load_gasar <- function(file){
  read_table(file=file, locale = locale(decimal_mark = ",")) %>%
    data.frame() %>%
    filter(Espece == "Crassotrea_gasar")
}