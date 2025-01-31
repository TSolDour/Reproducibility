linear_regression<-function(data){
  x<-data$Petal.Length
  y<-data$Petal.Width
  reg<-lm(x~y)
  plot(x~y)
  abline(reg,col="red")
  return(reg)
}
