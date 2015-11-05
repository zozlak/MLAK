#' @title kwadrat współczynnika korelacji liniowej
#' @param x wektor wartości pierwszej zmiennej
#' @param y wektor wartości drugiej zmiennej
#' @param wyrownaj czy wyrównywać długość wyniku (jeśli NA, wybór zostanie
#'   dokonany automatycznie)
#' @param dokl liczba cyfr po przecinku, do których zaokrąglony zostanie wynik
#' @return NULL
#' @export
R2 = function(x, y, wyrownaj = NA, dokl = 2){
  wyrownaj = ustawWyrownaj(wyrownaj)
  return(statKorelacja(x, y, wyrownaj, dokl, 'pearson', TRUE, sys.call()))
}
