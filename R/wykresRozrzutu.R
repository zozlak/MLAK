#' Wykres rozrzutu
#' @description
#' Rysuje wykres rozrzutu (X-Y).
#' @param x wektor pozycji na osi X
#' @param y wektor pozycji na osi Y
#' @param etykiety etykiety punktów na wykresie
#' @param rozmiar rozmiar poszczególnych punktów
#' @param tytul tytuł wykresu
#' @param tytulX tytuł osi X wykresu
#' @param tytulY tytuł osi Y wykresu
#' @param maxRozmPkt rozmiar punktu na wykresie odpowiadający największej
#'   wartości parametru \code{rozmiar}#' 
#' @param rozmiarMin minimalna wartość rozmiaru danego punktu, aby został
#'   zaprezentowany na wykresie (brana pod uwagę tylko gdy podano parametr
#'   \code{rozmiar})
#' @param rozmiarTekstu bazowy rozmiar tekstu na wykresie
#' @param opcjeWykresu dodatkowe opcje wykresu (zostaną dodane do obiektu wykresu ggplot2)
#' @param rysuj czy funkcja ma narysować wykres czy tylko zwrócić wygenerowany obiekt wykresu
#' @return [gg] obiekt wykresu pakietu ggplot2
#' @export
#' @import ggplot2
wykresRozrzutu = function(x, y, etykiety = NULL, rozmiar = NULL, tytul = '', tytulX = NULL, tytulY = NULL, maxRozmPkt = 5, rozmiarMin = 10, rozmiarTekstu = NULL, opcjeWykresu = NULL, rysuj = TRUE){
  stopifnot(
    is.vector(x), is.vector(y), length(x) == length(y),
    (is.vector(rozmiar) & length(rozmiar) == length(x)) | is.null(rozmiar),
    ((is.vector(etykiety) | is.factor(etykiety)) & length(etykiety) == length(x)) | is.null(etykiety),
    is.vector(maxRozmPkt), is.numeric(maxRozmPkt), length(maxRozmPkt) == 1, all(!is.na(maxRozmPkt)),
    is.vector(rozmiarMin), is.numeric(rozmiarMin), length(rozmiarMin) == 1, all(!is.na(rozmiarMin))
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
    rozmiar[rozmiar < rozmiarMin] = NA
  }
  rozmiar[rozmiar < 0] = 0
  
  filtr = !is.na(x) & !is.na(y) & !is.na(rozmiar)
  dane = data.frame(
    x = x,
    y = y,
    rozmiar = rozmiar,
    etykiety = etykiety,
    offset = suppressWarnings(maxRozmPkt * 0.004 * rozmiar / max(rozmiar, na.rm = TRUE))
  )
  dane = dane[filtr, ]
  
  if(nrow(dane) == 0){
    return(wykresPusty(tytul = tytul, tytulX = tytulX, tytulY = tytulY, rysuj = rysuj))
  }
  
  rozmiarTekstu = ifelse(is.null(rozmiarTekstu), 10, 0)

  wykres = ggplot(data = dane) +
    aes(x = get('x'), y = get('y'), label = get('etykiety')) +
    geom_point()
  if(min(dane$rozmiar, na.rm = TRUE) != max(dane$rozmiar, na.rm = TRUE)){
    wykres = wykres +
      geom_point(aes(size = get('rozmiar'))) +
      scale_size_continuous(name = 'Liczebność grup\na wielkość punktów', range = c(0, maxRozmPkt)) +
      geom_text(aes(y = get('y') + get('offset')), vjust = -0.5, size = 3)
  }else{
    wykres = wykres +
      geom_point() +
      geom_text(vjust = -0.5, size = 3)
  }
  wykres = wykresDefaultTheme(wykres, tytul = tytul, tytulX = tytulX, tytulY = tytulY, rozmiarTekstu = rozmiarTekstu) +
    theme(
      title = element_text(vjust = 2),
      axis.title.x = element_text(size = rozmiarTekstu, vjust = 0),
      axis.title.y = element_text(size = rozmiarTekstu, vjust = 1)
    )

  if(!is.null(opcjeWykresu)){
    wykres = wykres + opcjeWykresu
  }
  
  if(rysuj){
    suppressWarnings(print(wykres))
  }
  return(invisible(wykres))
}
