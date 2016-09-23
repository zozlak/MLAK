#' @title odsetek rekordów o zadanych wartościach z pominięciem braków danych
#' @description
#' Oblicza odsetek rekordów wektora \code{x} o wartościah zawartych w wektorze
#' \code{w}, przy czym braki danych są pomijane w podstawie procentowania.
#' @param x wektor wartości
#' @param w wektor zliczanych wartości
#' @param wyrownaj czy wyrównywać długość wyniku (jeśli NA, wybór zostanie
#'   dokonany automatycznie)
#' @param dokl liczba cyfr po przecinku, do których zaokrąglony zostanie wynik
#' @param znakProcent czy dostawić do zwróconej wartości znak procenta
#' @return NULL
#' @export
Pw = function(x, w = TRUE, wyrownaj = NA, dokl = 1, znakProcent = NA){
  wyrownaj = ustawWyrownaj(wyrownaj)
  return(P(x[!is.na(x)], w[!is.na(w)], wyrownaj, dokl, znakProcent))
}
