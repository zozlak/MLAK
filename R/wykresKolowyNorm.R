#' Wykres kołowy z normalizacją przekazanych danych do 100%
#' @description
#' Rysuje wykres kołowy.
#' 
#' Jeśli dane nie sumują się do 100, dokonuje stosownej normalizacji.
#' @param dane wektor danych
#' @param dokl do ilu miejsc po przecinku zaokrąglić wartości
#' @param tytul tytuł wykresu
#' @param rozmiarTekstu bazowy rozmiar tekstu
#' @param opcjeWykresu dodatkowe opcje wykresu (zostaną dodane do obiektu wykresu ggplot2)
#' @return [gg] obiekt wykresu pakietu ggplot2
#' @export
#' @import ggplot2
wykresKolowyNorm = function(dane, dokl = 1, tytul = '', rozmiarTekstu = NULL, opcjeWykresu = NULL){
  stopifnot(
    is.vector(dane), is.numeric(dane) | is.character(dane)
  )
  
  dane = na.exclude(dane)
  if(is.character(dane)){
    dane = sub('%$', '', dane)
    dane = sub('^ +', '', dane)
    tmp = names(dane)
    dane = setNames(suppressWarnings(as.numeric(dane)), tmp)
    if(any(is.na(dane))){
      stop('Dane wykresu zawieraly wartosci niebedace liczbami ani procentami')
    }
  }
  
  dane = round(dane * 100 / sum(dane), dokl)
  if(length(dane) > 1){
    dane[1] = 100 - dane[-1]
  }
  tmp = names(dane)
  dane = setNames(paste0(dane, '%'), tmp)
  
  wykres = wykresKolowy(dane, tytul, rozmiarTekstu, opcjeWykresu)
  return(wykres)
}