#' Wykres - histogram
#' @description
#' Rysuje histogram z przekazanych danych.
#' @param dane wektor danych
#' @param n liczba przedziałów
#' @param tytul tytuł wykresu
#' @param tytulX tytuł osi X wykresu
#' @param tytulY tytuł osi Y wykresu
#' @param rozmiarTekstu bazowy rozmiar tekstu
#' @param opcjeWykresu dodatkowe opcje wykresu (zostaną dodane do obiektu wykresu ggplot2)
#' @param rownePrzedzialy czy przedziały na osi X powinny być równe (TRUE) czy wyznaczane przez kwantyle (FALSE)
#' @param rysuj czy funkcja ma narysować wykres czy tylko zwrócić wygenerowany obiekt wykresu
#' @return [gg] obiekt wykresu pakietu ggplot2
#' @export
#' @import ggplot2
wykresHistogram = function(dane, n = 9, tytul = '', tytulX = NULL, tytulY = NULL, rozmiarTekstu = NULL, opcjeWykresu = NULL, rownePrzedzialy = FALSE, rysuj = TRUE){
  stopifnot(
    is.vector(dane) | is.factor(dane),
    is.numeric(dane) | is.character(dane) | is.logical(dane) | is.factor(dane)
  )
  
  dane = na.exclude(dane)
  
  wykres = ggplot(data = data.frame(d = dane))
  if(rownePrzedzialy){
    wykres = wykres + aes(x = get('d'))
  }else{
    wykres = wykres + aes(x = get('d'), y = ..density..)
  }
    
  
  if(is.numeric(dane)){
    if(rownePrzedzialy){
      breaks = seq(min(dane), max(dane), length.out = n + 1)
    }else{
      n = min(n, length(unique(dane)))
      breaks = quantile(dane, seq(0, 1, length.out = n + 1))
      while(length(breaks) != length(unique(breaks))){
        n = n - 1
        breaks = quantile(dane, seq(0, 1, length.out = n + 1))
      }
    }

    wykres = wykres +
      suppressWarnings( # różna szerokość słupków generuje "position_stack requires constant width: output may be incorrect"
        geom_histogram(
          breaks = breaks,
          colour = '#000000',
          fill = '#FFFFFF'
        )
      )
  }else{
    wykres = wykres +
      geom_histogram(
        colour = '#000000',
        fill = '#FFFFFF'
      )
  }
  
  wykres = wykresDefaultTheme(wykres, tytul = tytul, tytulX = tytulX, tytulY = tytulY, rozmiarTekstu = rozmiarTekstu) + 
    theme(axis.line = element_line(colour = '#000000', linetype = 'solid'), axis.line.x = element_blank())
  
  if(rownePrzedzialy == FALSE){
    wykres = wykres + theme(axis.line.y = element_blank(), axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank())
  }
  
  if(is.numeric(dane)){
    wykres = wykres + scale_x_continuous(breaks = breaks, labels = round(breaks))
  }
  
  if(!is.null(opcjeWykresu)){
    wykres = wykres + opcjeWykresu
  }
  
  if(rysuj){
    suppressWarnings(print(wykres))
    return(invisible(wykres))
  }
  return(wykres)
}
