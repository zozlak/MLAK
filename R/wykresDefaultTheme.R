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
    rozmiarTekstu = 10
  }
  
  wykres = wykres +
    ggplot2::ylab('') +
    ggplot2::xlab('') +
    ggplot2::scale_fill_grey() +
    ggplot2::labs(fill = '') +
    ggplot2::theme_bw(base_size = rozmiarTekstu) + 
    ggplot2::theme(
      panel.border      = element_rect(fill = NA, colour=NA),
      legend.position   = 'right',
      legend.text       = element_text(size = rozmiarTekstu),
      axis.text.x       = element_text(size = rozmiarTekstu),
      axis.text.y       = element_text(size = rozmiarTekstu),
      axis.title.x      = element_text(size = rozmiarTekstu * 1.2),
      axis.title.y      = element_text(size = rozmiarTekstu * 1.2),
      plot.title        = element_text(size = rozmiarTekstu * 1.3)
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
