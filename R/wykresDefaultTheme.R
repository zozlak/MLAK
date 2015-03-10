#' Domyślny styl wykresów
#' @description
#' Funkcja zwracająca domyślne ostylowania wykresów, współdzielone pomiędzy
#' wszystkie funkcje rysujące wykresy
#' @param wykres obiekt gpplot2 wykresu
#' @param tytul tytuł wykresu
#' @param tytulX tytuł osi X wykresu
#' @param tytulY tytuł osi Y wykresu
#' @param rozmiarTekstu domyślny rozmiar tekstu
wykresDefaultTheme = function(wykres, tytul = NULL, tytulX = NULL, tytulY = NULL, rozmiarTekstu = NULL){
  if(is.null(rozmiarTekstu)){
    rozmiarTekstu = 14
  }
  
  wykres = wykres +
    ylab('') +
    xlab('') +
    scale_fill_grey() +
    labs(fill = '') +
    theme_bw(base_size = rozmiarTekstu) + 
    theme(
      panel.border = element_rect(fill = NA, colour=NA),
      legend.position = 'bottom',
      legend.margin = grid::unit(c(-5.5, 0, 0, 0), 'cm')
    )
  
  if(!is.null(tytul)){
    wykres = wykres + ggtitle(tytul)  
  }
  if(!is.null(tytulX)){
    wykres = wykres + xlab(tytulX)
  }
  if(!is.null(tytulY)){
    wykres = wykres + ylab(tytulY)
  }
  
  return(wykres)
}