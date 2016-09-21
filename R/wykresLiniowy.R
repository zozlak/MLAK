#' Wykres liniowy
#' @description
#' Rysuje wykres liniowy z przekazanych danych.
#' @details 
#' Przekazane dane mają postać długą, z kolumnami: seria, x, y, n.
#' 
#' Punkty o niedostatecznej liczebności zostaną zanonimizowane.
#' @param dane ramka danych opisująca serie danych - patrz opis szczegółowy
#' @param tytul tytuł wykresu
#' @param tytulX tytuł osi X wykresu
#' @param tytulY tytuł osi Y wykresu
#' @param nMin minimalna liczebność wymagana do wyświetlenia punktu na wykresie
#' @param rozmiarTekstu bazowy rozmiar tekstu
#' @param opcjeWykresu dodatkowe opcje wykresu (zostaną dodane do obiektu wykresu ggplot2)
#' @param rysuj czy funkcja ma narysować wykres czy tylko zwrócić wygenerowany obiekt wykresu
#' @return [gg] obiekt wykresu pakietu ggplot2
#' @export
#' @import ggplot2
#' @import dplyr
wykresLiniowy = function(dane, tytul = '', tytulX = NULL, tytulY = NULL, nMin = 50, rozmiarTekstu = NULL, opcjeWykresu = NULL, rysuj = TRUE){
  stopifnot(
    is.data.frame(dane), length(setdiff(c('seria', 'x', 'y', 'n'), names(dane))) == 0,
    is.vector(nMin), is.numeric(nMin), length(nMin) == 1, all(!is.na(nMin))
  )
  stopifnot(
    is.numeric(dane$y), is.numeric(dane$n)
  )
  dane = ungroup(dane)
  if (is.null(rozmiarTekstu)) {
    rozmiarTekstu = 10
  }
  
  dane$seria = factor(dane$seria)
  dane$y[dane$n < nMin] = NA
  
  # przycinanie osi X do wartości niebędących brakami danych
  limity = dane %>%
    filter_(~ !is.na(y)) %>%
    summarize_(
      xmin = ~ min(x),
      xmax = ~ max(x)
    )
  dane = dane %>%
    filter_(~ x >= limity$xmin & x <= limity$xmax)
  
  if (nrow(dane) == 0) {
    return(wykresPusty(tytul = tytul, tytulX = tytulX, tytulY = tytulY, rysuj = rysuj))
  }
  
  # wycięcie braków danych dla geometry_line()
  daneBezNa = dane %>%
    filter_(~ !is.na(y))

  wykres = ggplot(data = dane) +
    aes(x = get('x'), y = get('y'), group = get('seria'), shape = get('seria'), linetype = get('seria')) +
    geom_point(size = 2) +
    geom_line(data = daneBezNa)
  wykres = wykresDefaultTheme(wykres, tytul = tytul, tytulX = tytulX, tytulY = tytulY, rozmiarTekstu = rozmiarTekstu) +
    theme(
      title = element_text(vjust = 2),
      axis.title.x = element_text(size = rozmiarTekstu, vjust = 0),
      axis.title.y = element_text(size = rozmiarTekstu, vjust = 1),
      legend.position = 'bottom',
      legend.title = element_blank(),
      legend.text = element_text(size = rozmiarTekstu * 0.7)
    )
  if (is.character(dane$x)) {
    wykres = wykres +
      theme(axis.text.x = element_text(angle = 270, size = rozmiarTekstu * 0.7, vjust = 0.3))
  }
  
  if (!is.null(opcjeWykresu)) {
    wykres = wykres + opcjeWykresu
  }
  
  if (rysuj) {
    suppressWarnings(print(wykres))
  }
  return(invisible(wykres))
}
