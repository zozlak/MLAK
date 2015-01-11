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
#' @param skumulowany czy wykres ma być skumulowany?
#' @param rozmiarTekstu bazowy rozmiar tekstu
#' @param opcjeWykresu dodatkowe opcje wykresu (zostaną dodane do obiektu wykresu ggplot2)
#' @return [gg] obiekt wykresu pakietu ggplot2
#' @export
#' @import ggplot2
#' @import reshape2
wykresSlupkowy = function(dane, skumulowany = F, rozmiarTekstu = 16, opcjeWykresu = NULL){
  stopifnot(
    is.vector(dane) | is.matrix(dane),
    is.numeric(dane)
  )
  
  if(is.vector(dane)){
    tmp = names(dane)
    dane = matrix(dane, length(dane), 1)
    rownames(dane) = tmp
  }
  
  dane = melt(dane, varnames = c('y', 'x'))
  pozycja = ifelse(skumulowany, position_stack, position_dodge)
  wykres = ggplot(data = dane) +
    aes(x = factor(get('x')), y = get('value'), fill = factor(get('y'))) +
    geom_bar(
      stat = 'identity',
      position = pozycja()
    )
  wykres = wykresDefaultTheme(wykres, rozmiarTekstu)
  
  if(length(unique(dane$x)) == 1){
    wykres = wykres + scale_x_discrete(breaks = NULL)
  }
  
  if(!is.null(opcjeWykresu)){
    wykres = wykres + opcjeWykresu
  }
  
  return(wykres)
}