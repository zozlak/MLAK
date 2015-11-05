#' @title błąd modalenj
#' @description
#' Oblicza błąd modalnej (1 - odsetek wystąpień modalnej).
#' Braki danych są w obliczeniach pomijane.
#' \code{w}
#' @param x wektor wartości
#' @param wyrownaj czy wyrównywać długość wyniku (jeśli NA, wybór zostanie
#'   dokonany automatycznie)
#' @param dokl liczba cyfr po przecinku, do których zaokrąglony zostanie wynik
#' @return NULL
#' @export
bMod = function(x, wyrownaj = NA, dokl = 2){
  stopifnot(
    is.vector(dokl), is.numeric(dokl), length(dokl) == 1, all(!is.na(dokl))
  )
  wyrownaj = ustawWyrownaj(wyrownaj)
  
  x[is.na(x)] = naNaWartosc(x)
  wynik = statWektor(x, table, NULL, FALSE, 0)
  wynik = round(1 - (max(wynik) / sum(wynik)), dokl)
  if(wyrownaj){
    wynik = wyrownajDl(wynik, sys.call(), dokl, 3)
  }
  return(wynik)
}
  