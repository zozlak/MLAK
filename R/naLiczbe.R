#' Konwertuje przekazany wektor na wartości liczbowe
#' @description
#' \code{as.numeric()}, który dodatkowo zachowuje nazwy elementów i pozbywa się
#' ew. kończącego znaku procenta
#' @param dane wektor do konwersji
#' @return [numeric] skonwertowane wartości liczbowe
naLiczbe = function(dane){
  stopifnot(
    is.vector(dane)
  )
  if(is.numeric(dane)){
    return(dane)
  }
  if(is.character(dane)){
    dane = sub('%$', '', dane)
  }
  dane = setNames(suppressWarnings(as.numeric(dane)), names(dane))
  return(dane)
}
