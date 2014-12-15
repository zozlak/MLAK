###########################################################
#
# Plik z funkcjami wykonującymi proste agregaty
# i formatującymi wynik, które ułatwiają pisanie
# szablonów
#
###########################################################

#' @title liczba rekordów niebędących brakami danych
#' @param x wektor wartości
#' @param wyrownaj czy wyrównywać długość wyniku (TRUE w wypadku osadzania w tabelach)
#' @return NULL
#' @export
N = function(x, wyrownaj = T){
  wynik = length(na.omit(x))
  if(wyrownaj){
    dl = 4 + nchar(deparse(sys.call()))
    if(length(wynik) > length(dl)){
      warning('Wyrównanie długości nie było możliwe')
    }
    return(sprintf(paste0('% ', dl, 'd'), wynik))
  }
  return(wynik)
}

#' @title średnia wartość z pominięciem braków danych
#' @param x wektor wartości
#' @param wyrownaj czy wyrównywać długość wyniku (TRUE w wypadku osadzania w tabelach)
#' @param dokl liczba cyfr po przecinku, do których zaokrąglony zostanie wynik
#' @return NULL
#' @export
E = function(x, wyrownaj = T, dokl = 2){
  wynik = round(mean(x, na.rm=T), dokl)
  if(wyrownaj){
    dl = 4 + nchar(deparse(sys.call()))
    if(length(wynik) > length(dl)){
      warning('Wyrównanie długości nie było możliwe')
    }
    return(sprintf(paste0('% ', dl, '.', dokl, 'f'), wynik)) 
  }
  return(wynik)
}
