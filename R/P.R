#' @title odsetek rekordów o zadanych wartościach
#' @description
#' Oblicza odsetek rekordów wektora x o wartościah zawartych w wektorze w.
#' @param x wektor wartości
#' @param w wektor zliczanych wartości
#' @param wyrownaj czy wyrównywać długość wyniku (TRUE w wypadku osadzania w 
#'   tabelach)
#' @param dokl liczba cyfr po przecinku, do których zaokrąglony zostanie wynik
#' @param znakProcent czy dostawić do zwróconej wartości znak "%"
#' @return NULL
#' @export
P = function(x, w, wyrownaj = T, dokl = 1, znakProcent = TRUE){
  stopifnot(
    is.vector(znakProcent), is.logical(znakProcent), length(znakProcent) == 1, all(!is.na(znakProcent))
  )
  
  wynik = N(x, w, F)
  if(is.numeric(wynik)){
    wynik = round(100 * wynik / length(x), dokl)
  }
  if(wyrownaj){
    wynik = wyrownajDl(wynik, sys.call(), dokl, 3)
  }
  if(znakProcent){
    wynik = paste0(wynik, '%')
  }
  return(wynik)
}