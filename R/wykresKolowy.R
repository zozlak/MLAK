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
#' @param etykiety opcjonalny wektor z etykietami wartości
#' @param rozmiarTekstu bazowy rozmiar tekstu
#' @param opcjeWykresu dodatkowe opcje wykresu (zostaną dodane do obiektu wykresu ggplot2)
#' @return [gg] obiekt wykresu pakietu ggplot2
#' @export
#' @import ggplot2
wykresKolowy = function(dane, etykiety = NULL, rozmiarTekstu = 16, opcjeWykresu = NULL){
  stopifnot(
    is.vector(dane) | is.factor(dane),
    is.numeric(dane) | is.character(dane) | is.logical(dane) | is.factor(dane)
  )
  
  # logical -> factor
  if(is.logical(dane)){
    dane = factor(dane, levels = c(T, F), labels = c('TAK', 'NIE'))
  }
  
  # etykietowanie wartości
  if(is.character(etykiety)){
    wartosci = names(etykiety)
    if(is.null(wartosci)){
      wartosci = seq_along(etykiety)
    }
    dane = factor(dane, wartosci, etykiety)
  }
  
  # nieunikalne wartości lub factor -> wykonaj table()
  if(is.factor(dane) | any(duplicated(dane))){
    dane = round(100 * table(dane) / length(na.exclude(dane)), 2)
    dane[1] = 100 - sum(dane[-1], na.rm = T)
  }
  
  # upewnij się, że wektor danych ma nazwy
  if(is.null(names(dane))){
    names(dane) = dane
  }
  
  dane = data.frame(
    e = paste(names(dane), '-', as.numeric(dane)),
    y = factor(dane, dane, names(dane))
  )
  
  wykres = ggplot(data = dane) +
    aes(x = factor(1), y = get('y'), fill = get('e')) +
    geom_bar(width = 1, stat = 'identity') +
    coord_polar(theta = 'y') +
    scale_x_discrete(breaks = NULL) +
    scale_y_discrete(breaks = NULL)
  wykres = wykresDefaultTheme(wykres, rozmiarTekstu)
  
  if(!is.null(opcjeWykresu)){
    wykres = wykres + opcjeWykresu
  }
  
  return(wykres)
}