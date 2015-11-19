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
    ((is.vector(etykiety) | is.factor(etykiety)) & length(etykiety) == length(x)) | is.null(etykiety)
  )
  if(is.factor(etykiety)){
    etykiety = levels(etykiety)[etykiety]
  }
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
  
  rozmiarTekstu = ifelse(is.null(rozmiarTekstu), 10, 0)
  
  wykres = ggplot(data = dane) +
    aes(x = get('x'), y = get('y'), label = get('etykiety'), size = get('rozmiar')) +
    geom_point() +
    geom_text(vjust = -0.5, size = 3) +
    scale_size_continuous(name = 'Liczebność grup\na wielkość punktów')
  wykres = wykresDefaultTheme(wykres,  tytul = tytul, tytulX = tytulX, tytulY = tytulY, rozmiarTekstu = rozmiarTekstu) +
    theme(
      title = element_text(vjust = 2),
      axis.title.x = element_text(size = rozmiarTekstu, vjust = 0),
      axis.title.y = element_text(size = rozmiarTekstu, vjust = 1)
    ) 
  if(max(dane$x) <= 1 & min(dane$x) >= 0 & max(dane$y) <= 1 & min(dane$y) >= 0){
    wykres = wykres + ggplot2::coord_cartesian(xlim = c(-0.1, 1.1), ylim = c(-0.1, 1.1)) + xlim(0, 1) + ylim(0, 1)
  }
  
  if(!is.null(opcjeWykresu)){
    wykres = wykres + opcjeWykresu
  }
  
  if(rysuj){
    suppressWarnings(print(wykres))
  }
  return(invisible(wykres))
}
