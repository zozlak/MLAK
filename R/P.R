#' @title odsetek rekordów o zadanych wartościach
#' @description
#' Oblicza odsetek rekordów wektora \code{x} o wartościah zawartych w wektorze
#' \code{w}
#' @param x wektor wartości
#' @param w wektor zliczanych wartości
#' @param wyrownaj czy wyrównywać długość wyniku (jeśli NA, wybór zostanie
#'   dokonany automatycznie)
#' @param dokl liczba cyfr po przecinku, do których zaokrąglony zostanie wynik
#' @param znakProcent czy dostawić do zwróconej wartości znak procenta
#' @return NULL
#' @export
P = function(x, w, wyrownaj = NA, dokl = 1, znakProcent = NA){
  stopifnot(
    is.vector(dokl), is.numeric(dokl), length(dokl) == 1, all(!is.na(dokl)),
    is.vector(znakProcent), is.logical(znakProcent), length(znakProcent) == 1
  )
  wyrownaj = ustawWyrownaj(wyrownaj)
  if(is.na(znakProcent)){
    znakProcent = wyrownaj
  }
  
  wynik = N(x, w, FALSE)
  if(is.numeric(wynik)){
    wynik = round(100 * wynik / length(x), dokl)
  }
  if(wyrownaj){
    wynik = wyrownajDl(wynik, sys.call(), dokl, 3)
  }
  if(znakProcent){
    wynik[is.na(wynik)] = '-'
    wynik = sub('NA', ' -', wynik)
    wynik = paste0(wynik, '%')
  }
  return(wynik)
}
