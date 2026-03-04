##########################################################
#
# Training script for reproducibility
# Author: Thomas Sol Dourdin
#
##########################################################

library(readr)
library(dplyr)
library(ggplot2)
library(car)
library(tibble)


# Load data

data <- read_table(file=here::here("Data", "Allo.csv"), locale = locale(decimal_mark = ",")) %>%
  data.frame() %>%
  filter(Espece == "Crassotrea_gasar")

# Summarise data
SumData <-  data %>%
    group_by(Station, Lot) %>%
    summarise(length=mean(Longueurs) )

# Plot data
p <- ggplot(data = SumData, aes(x=Station, y=length, color=Lot)) +
  geom_point()


# Run analysis of variance (ANOVA)
# Anova
  Obj <- aov(Longueurs ~ Station, data=data)

# Check assumptions 
  Shap <- shapiro.test(Obj$residuals)
  Lev <- leveneTest(Obj$residuals, data$Station)

# Return anova results    
  Res <- anova(Obj)
  
# Run post-hoc test
  Post <- TukeyHSD(Obj)

# Summarise the results in a list object
  list(data.frame(Post$Station) %>%
         tibble::rownames_to_column(var="Station") %>%
         filter(p.adj<0.05),
       p_value = as.numeric(Res["Station", "Pr(>F)"]))

pvalue <- Res[["Pr(>F)"]][1]
