#' Wykres - histogram ze wskazanych centyli
#' @description
#' Rysuje histogram na podstawie już policzonego rozkładu.
#' @param dane wektor wartości centyli
#' @param centyle wektor centyli (na skali 0-1); musi być tej samej długości co
#'   parametr \code{dane} lub mieć wartość \code{NULL}; jeśli \code{NULL},
#'   funkcja zakłada równomierne rozłożenie centyli przekazanych w parametrze
#'   \code{dane} (\code{centyle = seq(0, 1, length.out = length(dane))})
#' @param tytul tytuł wykresu
#' @param tytulX tytuł osi X wykresu
#' @param tytulY tytuł osi Y wykresu
#' @param rozmiarTekstu bazowy rozmiar tekstu
#' @param opcjeWykresu dodatkowe opcje wykresu (zostaną dodane do obiektu
#'   wykresu ggplot2)
#' @param rysuj czy funkcja ma narysować wykres czy tylko zwrócić wygenerowany
#'   obiekt wykresu
#' @param pomijajEtykiety wartość, na podstawie której funkcja decyduje, które
#'   etykiety będą na siebie nachodzić i należy je pomijać; nie ma żadnej
#'   intuicyjnej interpretacji, wiadomo jedynie, że im ona mniejsza, tym
#'   szybciej etykiety będą pomijane; odpowiedią wartość należy dobrać
#'   eksperymentalnie
#' @return [gg] obiekt wykresu pakietu ggplot2
#' @export
#' @import ggplot2
wykresCentyle = function(dane, centyle = NULL, tytul = '', tytulX = NULL, tytulY = NULL, rozmiarTekstu = NULL, opcjeWykresu = NULL, rysuj = TRUE, pomijajEtykiety = 500) {
  stopifnot(
    is.vector(dane) & is.numeric(dane),
    is.null(centyle) | is.vector(centyle) & length(centyle) == length(dane)
  )
  if (any(is.na(dane)) | any(is.na(centyle))) {
    return(wykresPusty(tytul = tytul, tytulX = tytulX, tytulY = tytulY, rysuj = rysuj))
  }
  if (is.null(centyle)) {
    centyle = seq(0, 1, length.out = length(dane))
  }
  pow = centyle[-1] - centyle[-length(centyle)]
  szer = (dane[-1] - dane[-length(dane)])
  wys = pow / szer
  daneGg = data.frame(x = dane[-length(dane)] + szer / 2, y = wys / 2, wys = wys, szer = szer)

  wykres = ggplot(daneGg, aes(x = get('x'), y = get('y'), width = get('szer'), height = get('wys'))) +
    geom_tile(colour = '#000000', fill = '#FFFFFF', size = 0.2)

  wykres = wykresDefaultTheme(wykres, tytul = tytul, tytulX = tytulX, tytulY = tytulY, rozmiarTekstu = rozmiarTekstu) + 
    theme(
      axis.line.y = element_blank(), 
      axis.ticks.y = element_blank(),
      axis.text.y = element_blank(), 
      axis.line.x = element_blank(),
      axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)
    )
  if (is.null(tytulY)) {
    wykres = wykres + theme(axis.title.y = element_blank())
  }
  wykres = etykietyHistogramu(wykres, dane, rozmiarTekstu, pomijajEtykiety)

  if (!is.null(opcjeWykresu)) {
    wykres = wykres + opcjeWykresu
  }
  
  if (rysuj) {
    suppressWarnings(print(wykres))
  }
  return(invisible(wykres))
}