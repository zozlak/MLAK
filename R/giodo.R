#' @title weryfikuje czy dane spełniają kryterium minimalnej liczebności grupy
#' @description
#' Jeśli przekazane dane nie spełniają warunku minimalnej liczebności grupy,
#' wtedy wszystkie wartości zostają zamienione na braki danych (zanonimizowane)
#' @param x wektor danych lub ramka danych
#' @return wektor lub ramka danych

giodo = function(x){
  stopifnot(
    is.vector(x) | is.data.frame(x)
  )
  
  min = 2
  
  if(is.vector(x)){
    if(length(x) < min){
      x[] = NA
    }
  }
  if(is.data.frame(x)){
    if(nrow(x) < min){
      x[] = NA
    }
  }
  
  return(x)
}