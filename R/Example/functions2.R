fit_model <- function(data) {
  lm(Ozone ~ Temp, data) %>%
    coefficients()
}