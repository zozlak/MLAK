#' Pusty wykres
#' @description
#' Funkcja używana do obsługi błędów, np. przy próbie narysowania wykresu z
#' pustych lub niepoprawnych danych.
#' @return [gg] obiekt wykresu pakietu ggplot2
#' @param tytul tytuł wykresu
#' @param tytulX tytuł osi X wykresu
#' @param tytulY tytuł osi Y wykresu
#' @param rysuj czy funkcja ma narysować wykres czy tylko zwrócić wygenerowany obiekt wykresu
#' @export
#' @import ggplot2
wykresPusty = function(tytul = NULL, tytulX = NULL, tytulY = NULL, rysuj = TRUE){
  wykres = ggplot(data.frame(x = 0)) +
    aes(x = get('x'), y = get('x')) + 
    geom_point()
  wykres = wykresDefaultTheme(wykres,  tytul = tytul, tytulX = tytulX, tytulY = tytulY) + 
    theme(axis.line.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
    theme(axis.line.x = element_blank(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
  if(rysuj){
    suppressWarnings(print(wykres))
  }
  return(invisible(wykres))
}