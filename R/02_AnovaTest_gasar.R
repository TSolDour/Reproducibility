####################################
# Project_name : gasar
# Script_name : 02_AnovaTest_gasar.R
# Script_function : Test for length differences between stations for Crassostrea gasar using ANOVA
# Contact : t.soldourdin@gmail.com
####################################

# 1-Anova test
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



# 2- If Anova not possible, then run Kruskal-Wallis
KruskalTest <- function(data, a, b){
  
  tri.to.squ<-function(x) # fonction récupérée depuis le blog de Fabio Marroni: https://fabiomarroni.wordpress.com/2017/03/25/perform-pairwise-wilcoxon-test-classify-groups-by-significance-and-plot-results/
  {
    rn <- row.names(x)
    cn <- colnames(x)
    an <- unique(c(cn,rn))
    myval <-  x[!is.na(x)]
    mymat <-  matrix(1,nrow=length(an),ncol=length(an),dimnames=list(an,an))
    for(ext in 1:length(cn))
    {
      for(int in 1:length(rn))
      {
        if(is.na(x[row.names(x)==rn[int],colnames(x)==cn[ext]])) next
        mymat[row.names(mymat)==rn[int],colnames(mymat)==cn[ext]]<-x[row.names(x)==rn[int],colnames(x)==cn[ext]]
        mymat[row.names(mymat)==cn[ext],colnames(mymat)==rn[int]]<-x[row.names(x)==rn[int],colnames(x)==cn[ext]]
      }
      
    }
    return(mymat)
  }
  
  Obj <- kruskal.test(a ~ b, data=data)
  if(Obj$p.value < 0.05){
    pp <- pairwise.wilcox.test(a, b, p.adjust.method ="holm")
    mymat <-tri.to.squ(pp$p.value)
    myletters <- multcompLetters(mymat,compare="<=", threshold=0.05, Letters=letters)
    myletters_df <- data.frame(Station=names(myletters$Letters),letter = myletters$Letters)
    return(myletters_df)
  } else (return("No significant differences"))
}

    