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
N = function(x){
  return(length(na.omit(x)))
}

#' @title średnia wartość z pominięciem braków danych
#' @param x wektor wartości
#' @param dokl liczba cyfr po przecinku, do których zaokrąglony zostanie wynik
#' @return NULL
#' @export
E = function(x, dokl = 2){
  return(round(mean(x, na.rm=T), dokl))
}
