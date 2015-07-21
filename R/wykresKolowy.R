#' Wykres kołowy
#' @description
#' Rysuje wykres kołowy, tzn. stosunek każdej z przekazanych wartości do ich
#' sumy.
#' 
#' Uwaga - wartości wyświetlane w legendzie nie są standaryzowane, lecz
#' wyświetlane dokładnie w takiej postaci, w jakiej zostały przekazane. Aby
#' legenda zawierała wystandaryzowane odsetki, użyj funkcji wykresKolowyNorm().
#' @param dane wektor danych
#' @param tytul tytuł wykresu
#' @param rozmiarTekstu bazowy rozmiar tekstu
#' @param opcjeWykresu dodatkowe opcje wykresu (zostaną dodane do obiektu wykresu ggplot2)
#' @param rysuj czy funkcja ma narysować wykres czy tylko zwrócić wygenerowany obiekt wykresu
#' @return [gg] obiekt wykresu pakietu ggplot2
#' @export
#' @import ggplot2
wykresKolowy = function(dane, tytul = '', rozmiarTekstu = NULL, opcjeWykresu = NULL, rysuj = TRUE){
  stopifnot(
    is.vector(dane), is.numeric(dane) | is.character(dane)
  )
  
  dane = na.exclude(dane)
  etykiety = dane
  if(is.character(dane)){
    dane = sub('^ +', '', dane)
    etykiety = dane
    dane = naLiczbe(dane)
    if(any(is.na(dane))){
      stop('Dane wykresu zawieraly wartosci niebedace liczbami ani procentami')
    }
  }
  
  # upewnij się, że wektor danych ma nazwy
  if(is.null(names(dane))){
    names(dane) = dane
  }
  
  dane = data.frame(
    e = polamTekst(paste(names(dane), '-', etykiety)),
    y = as.numeric(dane),
    stringsAsFactors = FALSE
  )
  dane$e = factor(dane$e, levels = dane$e, labels = dane$e)

  wykres = ggplot(data = dane) +
    aes(x = factor(1), y = get('y'), fill = get('e')) +
    geom_bar(width = 1, stat = 'identity') +
    coord_polar(theta = 'y') +
    scale_x_discrete(breaks = NULL) +
    scale_y_continuous(breaks = NULL)
  wykres = wykresDefaultTheme(wykres, tytul = tytul, rozmiarTekstu = rozmiarTekstu) +
    theme(
      panel.grid.major = element_blank()
    )
  
  if(!is.null(opcjeWykresu)){
    wykres = wykres + opcjeWykresu
  }
  
  if(rysuj){
    suppressWarnings(print(wykres))
    return(invisible(wykres))
  }
  return(wykres)
}
