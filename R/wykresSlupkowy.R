#' Wykres słupkowy
#' @description
#' Rysuje wykres słupkowy.
#' @param dane wektor danych
#' @param skumulowany czy wykres ma być skumulowany?
#' @param tytul tytuł wykresu
#' @param tytulX tytuł osi X wykresu
#' @param tytulY tytuł osi Y wykresu
#' @param sufiksY ew. ciąg znaków dołączany do etykiet osi Y (np. znak procenta)
#' @param rozmiarTekstu bazowy rozmiar tekstu
#' @param opcjeWykresu dodatkowe opcje wykresu (zostaną dodane do obiektu wykresu ggplot2)
#' @param rysuj czy funkcja ma narysować wykres czy tylko zwrócić wygenerowany obiekt wykresu
#' @return [gg] obiekt wykresu pakietu ggplot2
#' @export
#' @import ggplot2
#' @import reshape2
wykresSlupkowy = function(dane, skumulowany = F, tytul = '', tytulX = NULL, tytulY = NULL, sufiksY = '', rozmiarTekstu = NULL, opcjeWykresu = NULL, rysuj = TRUE){
  stopifnot(
    is.vector(dane) | is.matrix(dane)
  )
  # ew. konwersja na liczby
  if(is.character(dane)){
    tmp = sum(is.na(dane))
    dane = naLiczbe(dane)
    if(sum(is.na(dane)) != tmp){
      stop('dane nie są liczbami')
    }
  }
  stopifnot(
    is.numeric(dane)
  )
  
  if(is.vector(dane)){
    tmp = names(dane)
    dane = matrix(dane, length(dane), 1)
    rownames(dane) = tmp
  }
  
  dane = melt(dane, varnames = c('y', 'x'))
  dane$y = polamTekst(dane$y)
  dane$y = factor(dane$y, levels = dane$y, labels = dane$y)
  pozycja = ifelse(skumulowany, position_stack, position_dodge)
  wykres = ggplot(data = dane) +
    aes(x = factor(get('x')), y = get('value'), fill = get('y')) +
    geom_bar(
      stat = 'identity',
      position = pozycja()
    )
  wykres = wykresDefaultTheme(wykres,  tytul = tytul, tytulX = tytulX, tytulY = tytulY, rozmiarTekstu = rozmiarTekstu) +
    theme(axis.line = element_line(colour = '#000000', linetype = 'solid'), axis.line.x = element_blank()) +
    scale_y_continuous(labels = function(x){
      return(paste0(x, sufiksY))
    })
  
  if(length(unique(dane$x)) == 1){
    wykres = wykres + scale_x_discrete(breaks = NULL)
  }

  if(!is.null(opcjeWykresu)){
    wykres = wykres + opcjeWykresu
  }
  
  if(rysuj){
    suppressWarnings(print(wykres))
  }
  return(invisible(wykres))
}
