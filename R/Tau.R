#' @title współczynnik korelacji rangowej Kendalla
#' @param x wektor wartości pierwszej zmiennej
#' @param y wektor wartości drugiej zmiennej
#' @param wyrownaj czy wyrównywać długość wyniku (TRUE w wypadku osadzania w tabelach)
#' @param dokl liczba cyfr po przecinku, do których zaokrąglony zostanie wynik
#' @return NULL
#' @export
Tau = function(x, y, wyrownaj = T, dokl = 2){
  return(statKorelacja(x, y, wyrownaj, dokl, 'kendall', FALSE, sys.call()))
}
