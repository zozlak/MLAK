#' @title odsetek rekordów o zadanych wartościach
#' @description
#' Oblicza odsetek rekordów wektora x o wartościah zawartych w wektorze w.
#' @param x wektor wartości
#' @param w wektor zliczanych wartości
#' @param wyrownaj czy wyrównywać długość wyniku (TRUE w wypadku osadzania w 
#'   tabelach)
#' @param dokl liczba cyfr po przecinku, do których zaokrąglony zostanie wynik
#' @return NULL
#' @export
P = function(x, w, wyrownaj = T, dokl = 1){
  wynik = N(x, w, F)
  if(is.numeric(wynik)){
    wynik = round(100 * wynik / length(x), dokl)
  }
  if(wyrownaj){
    return(wyrownajDl(wynik, sys.call(), dokl))
  }
  return(wynik)  
}