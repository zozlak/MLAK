###########################################################
#
# Plik z funkcjami wykonującymi proste agregaty
# i formatującymi wynik, które ułatwiają pisanie
# szablonów
#
###########################################################

#' @title liczba rekordów niebędących brakami danych
#' @param x wektor wartości
#' @return NULL
#' @export
N = function(x, rozmiar = NULL){
  wynik = length(na.omit(x))
  if(is.null(rozmiar)){
    return(wynik)
  }else{
    return(sprintf(paste0('% ', rozmiar, 'd'), wynik))
  }
}

#' @title średnia wartość z pominięciem braków danych
#' @param x wektor wartości
#' @param dokl liczba cyfr po przecinku, do których zaokrąglony zostanie wynik
#' @return NULL
#' @export
E = function(x, rozmiar = NULL, dokl = 2){
  wynik = round(mean(x, na.rm=T), dokl)
  if(is.null(rozmiar)){
    return(wynik)
  }else{
    return(sprintf(paste0('% ', rozmiar, '.', dokl, 'f'), wynik)) 
  }
}
