#' Wykres kołowy
#' @description
#' Rysuje wykres kołowy.
#' 
#' Jeśli dane zawierają duplikaty wartości lub są factor-em, wtedy narysowane
#' zostaną częstości występowania poszczególnych wartości.
#' W przeciwnym wypadku narysowane zostaną przekazane dane.
#' 
#' Właściwe etykiety wartości uzyskać można w dwojaki sposób - albo przekazując
#' do funkcji factor (wektor z przypisanymi etykietami wartości) albo używając
#' argumentu "etykiety". Argument "etykiety" powinien mieć postać:
#' 
#' c('wartość1' = 'etykieta1', 'wartość2' = 'etykieta2', ...)
#' @param dane wektor danych
#' @param tytul tytuł wykresu
#' @param rozmiarTekstu bazowy rozmiar tekstu
#' @param opcjeWykresu dodatkowe opcje wykresu (zostaną dodane do obiektu wykresu ggplot2)
#' @return [gg] obiekt wykresu pakietu ggplot2
#' @export
#' @import ggplot2
wykresKolowy = function(dane, tytul = '', rozmiarTekstu = NULL, opcjeWykresu = NULL){
  stopifnot(
    is.vector(dane), is.numeric(dane) | is.character(dane)
  )
  
  dane = na.exclude(dane)
  etykiety = dane
  if(is.character(dane)){
    dane = sub('^ +', '', dane)
    etykiety = dane
    dane = sub('%$', '', dane)
    tmp = names(dane)
    dane = setNames(suppressWarnings(as.numeric(dane)), tmp)
    if(any(is.na(dane))){
      stop('Dane wykresu zawieraly wartosci niebedace liczbami ani procentami')
    }
  }
  
  # upewnij się, że wektor danych ma nazwy
  if(is.null(names(dane))){
    names(dane) = dane
  }
  
  dane = data.frame(
    e = paste(names(dane), '-', etykiety),
    y = as.numeric(dane)
  )

  wykres = ggplot(data = dane) +
    aes(x = factor(1), y = get('y'), fill = get('e')) +
    geom_bar(width = 1, stat = 'identity') +
    coord_polar(theta = 'y') +
    scale_x_discrete(breaks = NULL) +
    scale_y_continuous(breaks = NULL)
  plot(wykres)
  wykres = wykresDefaultTheme(wykres, tytul = tytul, rozmiarTekstu = rozmiarTekstu)
  
  if(!is.null(opcjeWykresu)){
    wykres = wykres + opcjeWykresu
  }
  
  return(wykres)
}