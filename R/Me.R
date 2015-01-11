#' @title mediana
#' @param x wektor wartości
#' @param wyrownaj czy wyrównywać długość wyniku (TRUE w wypadku osadzania w tabelach)
#' @param dokl liczba cyfr po przecinku, do których zaokrąglony zostanie wynik
#' @return NULL
#' @export
Me = function(x, wyrownaj = T, dokl = 2){
  return(statWektor(x, median, sys.call(), wyrownaj, dokl))
}
