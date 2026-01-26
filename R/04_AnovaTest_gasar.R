####################################
# Project_name : Reproducibility
# Script_name : 04_AnovaTest_gasar.R
# Script_function : Test for length differences between stations for Crassostrea gasar using ANOVA
# Contact : t.soldourdin@gmail.com
####################################

AnovaTest <- function(data, a, b){
  Obj <- aov(a ~ b, data=data)
  Shap <-  shapiro.test(Obj$residuals)
  if(Shap["p.value"] > 0.05){
    Lev <- leveneTest(Obj$residuals, b)
  } else(return("No residual normality"))
  if(Lev["group","Pr(>F)"] > 0.05){
    Res <- anova(Obj)
  } else(return(paste0("No homoscedasticity, p-value = ", (Lev["group","Pr(>F)"]))))
  if(Res["b", "Pr(>F)"] < 0.05){
    Post <- TukeyHSD(Obj)
    return(list(data.frame(Post$b) %>%
                  rownames_to_column(var="b") %>%
                  filter(p.adj<0.05),
                p_value = as.numeric(Res["b", "Pr(>F)"])))
  } else (return("null"))
}