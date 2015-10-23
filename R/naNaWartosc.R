#' @title znajduje sensowną wartość (liczbę lub ciąg znaków), którą można
#'   zastąpić brak danych
#' @param x wektor wartości
#' @return stosowny do typu x
naNaWartosc = function(x){
  stopifnot(is.vector(x))
  if(length(x) == 0){
    tmp = NA
  }else if(all(is.na(x))){
    tmp = 1
  }else if(is.numeric(x)){
    tmp = max(x, na.rm = TRUE) + 1
  }else{
    tmp = paste0('_', max(x, na.rm = T))
  }
  return(tmp)
}