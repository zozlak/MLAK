#' Wykres rozrzutu
#' @description
#' Rysuje wykres rozrzutu (X-Y).
#' @param x wektor pozycji na osi X
#' @param y wektor pozycji na osi Y
#' @param rozmiar rozmiar poszczególnych punktów
#' @param etykiety etykiety punktów na wykresie
#' @param tytul tytuł wykresu
#' @param tytulX tytuł osi X wykresu
#' @param tytulY tytuł osi Y wykresu
#' @param rozmiarTekstu bazowy rozmiar tekstu
#' @param opcjeWykresu dodatkowe opcje wykresu (zostaną dodane do obiektu wykresu ggplot2)
#' @param rysuj czy funkcja ma narysować wykres czy tylko zwrócić wygenerowany obiekt wykresu
#' @return [gg] obiekt wykresu pakietu ggplot2
#' @export
#' @import ggplot2
wykresRozrzutu = function(x, y, rozmiar = NULL, etykiety = NULL, tytul = '', tytulX = NULL, tytulY = NULL, rozmiarTekstu = NULL, opcjeWykresu = NULL, rysuj = TRUE){
  stopifnot(
    is.vector(x), is.vector(y), length(x) == length(y),
    (is.vector(rozmiar) & length(rozmiar) == length(x)) | is.null(rozmiar),
    (is.vector(etykiety) & length(etykiety) == length(x)) | is.null(etykiety)
  )
  x = naLiczbe(x)
  y = naLiczbe(y)
  if(is.null(etykiety)){
    etykiety = rep('', length(x))
  }else{
    etykiety = as.character(etykiety)
    etykiety[is.na(etykiety)] = ''
  }
  if(is.null(rozmiar)){
    rozmiar = rep(1, length(x))
  }else{
    rozmiar = naLiczbe(rozmiar)
  }
  rozmiar[rozmiar < 0] = 0
  
  filtr = !is.na(x) & !is.na(y) & !is.na(rozmiar)
  dane = data.frame(
    x = x,
    y = y,
    rozmiar = rozmiar,
    etykiety = etykiety
  )
  dane = dane[filtr, ]
  
  if(nrow(dane) == 0){
    return(wykresPusty(tytul = tytul, tytulX = tytulX, tytulY = tytulY, rysuj = rysuj))
  }
  
  wykres = ggplot(data = dane) +
    aes(x = get('x'), y = get('y'), label = get('etykiety')) +
    geom_point(aes(size = get('rozmiar'))) +
    geom_text(vjust = -0.5)
  wykres = wykresDefaultTheme(wykres,  tytul = tytul, tytulX = tytulX, tytulY = tytulY, rozmiarTekstu = rozmiarTekstu)

  if(!is.null(opcjeWykresu)){
    wykres = wykres + opcjeWykresu
  }
  
  if(rysuj){
    suppressWarnings(print(wykres))
  }
  return(invisible(wykres))
}
