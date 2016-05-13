#' Wykres rozrzutu dla skal ilorazowych
#' @description
#' Rysuje wykres rozrzutu (X-Y) zakładając, że na obydwu osiach znajdują się
#' ilorazy, a więc początek układu współrzędnych powinien wypadać w punkcie (0, 0).
#' @param x wektor pozycji na osi X
#' @param y wektor pozycji na osi Y
#' @param rozmiar rozmiar poszczególnych punktów
#' @param etykiety etykiety punktów na wykresie
#' @param tytul tytuł wykresu
#' @param tytulX tytuł osi X wykresu
#' @param tytulY tytuł osi Y wykresu
#' @param minX minimalna wartość końca osi X
#' @param minY minimalna wartość końca osi Y
#' @param margX margines na etykiety punktów (obszar wykresu będzie większy o
#'   margines od skrajnych wartości danych)
#' @param margY margines na etykiety punktów (obszar wykresu będzie większy o
#'   margines od skrajnych wartości danych)
#' @param maxRozmPkt rozmiar punktu na wykresie odpowiadający największej
#'   wartości parametru \code{rozmiar}
#' @param rozmiarMin minimalna wartość rozmiaru danego punktu, aby został
#'   zaprezentowany na wykresie (brana pod uwagę tylko gdy podano parametr
#'   \code{rozmiar})
#' @param rozmiarTekstu bazowy rozmiar tekstu na wykresie
#' @param opcjeWykresu dodatkowe opcje wykresu (zostaną dodane do obiektu wykresu ggplot2)
#' @param rysuj czy funkcja ma narysować wykres czy tylko zwrócić wygenerowany obiekt wykresu
#' @return [gg] obiekt wykresu pakietu ggplot2
#' @export
#' @import ggplot2
wykresRozrzutuIloraz = function(x, y, etykiety = NULL, rozmiar = NULL, tytul = '', tytulX = NULL, tytulY = NULL, minX = 1, minY = 1, margX = 0.2, margY = 0.1, maxRozmPkt = 5, rozmiarMin = 10, rozmiarTekstu = NULL, opcjeWykresu = NULL, rysuj = TRUE){
  wykres = wykresRozrzutu(x = x, y = y, etykiety = etykiety, rozmiar = rozmiar, tytul = tytul, tytulX = tytulX, tytulY = tytulY, maxRozmPkt = maxRozmPkt, rozmiarMin = rozmiarMin, rozmiarTekstu = rozmiarTekstu, rysuj = FALSE)
  dane = wykres$data
  
  wykres = suppressWarnings(
    wykres +
    coord_cartesian(
      xlim = c(-margX, max(max(dane$x) + margX, minX)), 
      ylim = c(-margY, max(max(dane$y) + margY, minY))
    ) + 
    xlim(0, max(c(dane$x, minX))) + 
    ylim(0, max(c(dane$y, minY)))
  )
  
  
  if(rysuj){
    suppressWarnings(print(wykres))
  }
  return(invisible(wykres))
}
  