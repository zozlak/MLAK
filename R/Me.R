#' @title mediana
#' @param x wektor wartości
#' @param wyrownaj czy wyrównywać długość wyniku (jeśli NA, wybór zostanie
#'   dokonany automatycznie)
#' @param dokl liczba cyfr po przecinku, do których zaokrąglony zostanie wynik
#' @return NULL
#' @export
Me = function(x, wyrownaj = NA, dokl = 2){
  wyrownaj = ustawWyrownaj(wyrownaj)
  return(statWektor(x, median, sys.call(), wyrownaj, dokl))
}
