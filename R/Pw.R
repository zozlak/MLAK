#' @title odsetek rekordów o zadanych wartościach z pominięciem braków danych
#' @description
#' Oblicza odsetek rekordów wektora \code{x} o wartościah zawartych w wektorze
#' \code{w}, przy czym braki danych są pomijane w podstawie procentowania.
#' @param x wektor wartości
#' @param w wektor zliczanych wartości
#' @param wyrownaj czy wyrównywać długość wyniku (TRUE w wypadku osadzania w 
#'   tabelach)
#' @param dokl liczba cyfr po przecinku, do których zaokrąglony zostanie wynik
#' @param znakProcent czy dostawić do zwróconej wartości znak procenta
#' @return NULL
#' @export
Pw = function(x, w, wyrownaj = T, dokl = 1, znakProcent = TRUE){
  return(P(x[!is.na(x)], w[!is.na(w)], wyrownaj, dokl, znakProcent))
}