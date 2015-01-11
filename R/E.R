#' @title średnia
#' @param x wektor wartości
#' @param wyrownaj czy wyrównywać długość wyniku (TRUE w wypadku osadzania w tabelach)
#' @param dokl liczba cyfr po przecinku, do których zaokrąglony zostanie wynik
#' @return NULL
#' @export
E = function(x, wyrownaj = T, dokl = 2){
  return(statWektor(x, mean, sys.call(), wyrownaj, dokl))
}