#' Wykres - histogram
#' @description
#' Rysuje histogram z przekazanych danych.
#' @param dane wektor danych
#' @param n liczba przedziałów
#' @param rozmiarTekstu bazowy rozmiar tekstu
#' @param opcjeWykresu dodatkowe opcje wykresu (zostaną dodane do obiektu wykresu ggplot2)
#' @return [gg] obiekt wykresu pakietu ggplot2
#' @export
#' @import ggplot2
wykresHistogram = function(dane, n = 30, rozmiarTekstu = 16, opcjeWykresu = NULL){
  stopifnot(
    is.vector(dane) | is.factor(dane),
    is.numeric(dane) | is.character(dane) | is.logical(dane) | is.factor(dane)
  )
  
  dane = na.exclude(dane)
  
  wykres = ggplot(data = data.frame(d = dane)) +
    aes(x = get('d')) +
    geom_histogram(
      binwidth = (max(dane) - min(dane)) / (n - 1),
      colour = '#000000',
      fill = '#FFFFFF'
    )
  wykres = wykresDefaultTheme(wykres, rozmiarTekstu)
  
  if(!is.null(opcjeWykresu)){
    wykres = wykres + opcjeWykresu
  }
  
  return(wykres)
}
