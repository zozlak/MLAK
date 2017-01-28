#' Wykres liniowy z dostosowaną skalą osi X
#' @description
#' Rysuje wykres liniowy z przekazanych danych.
#' 
#' Funkcja zapewnia, że etykiety osi X będą całkowitoliczbowe.
#' @details 
#' Przekazane dane mają postać długą, z kolumnami: x, y, n oraz opcjonalnie seria.
#' 
#' Punkty o niedostatecznej liczebności zostaną zanonimizowane.
#' @param dane ramka danych opisująca serie danych - patrz opis szczegółowy
#' @param tytul tytuł wykresu
#' @param tytulX tytuł osi X wykresu
#' @param tytulY tytuł osi Y wykresu
#' @param nMin minimalna liczebność wymagana do wyświetlenia punktu na wykresie
#' @param xNMax maksymalna liczba wyświetlanych etykiet osi X
#' @param rozmiarTekstu bazowy rozmiar tekstu
#' @param opcjeWykresu dodatkowe opcje wykresu (zostaną dodane do obiektu wykresu ggplot2)
#' @param rysuj czy funkcja ma narysować wykres czy tylko zwrócić wygenerowany obiekt wykresu
#' @return [gg] obiekt wykresu pakietu ggplot2
#' @export
#' @import ggplot2
#' @import dplyr
wykresMiesieczny = function(dane, tytul = '', tytulX = NULL, tytulY = NULL, nMin = 3, xNMax = 36, rozmiarTekstu = NULL, opcjeWykresu = NULL, rysuj = TRUE){
  wykres = wykresLiniowy(dane = dane, tytul = tytul, tytulX = tytulX, tytulY = tytulY, nMin = nMin, xNMax = xNMax, rozmiarTekstu = rozmiarTekstu, rysuj = FALSE)
  
  if (is.numeric(dane$x)) {
    xmin = min(dane$x, na.rm = TRUE)
    xmax = max(dane$x, na.rm = TRUE)
    krok = ceiling((xmax - xmin) / xNMax)
    wykres = wykres +
      scale_x_continuous(breaks = seq(xmin, xmax, krok))
  }
  
  if (!is.null(opcjeWykresu)) {
    wykres = wykres + opcjeWykresu
  }
  
  if (rysuj) {
    suppressWarnings(print(wykres))
  }
  return(invisible(wykres))
}