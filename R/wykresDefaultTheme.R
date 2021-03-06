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
  if (is.null(rozmiarTekstu)) {
    rozmiarTekstu = 10
  }
  
  wykres = wykres +
    ggplot2::ylab('') +
    ggplot2::xlab('') +
    ggplot2::scale_fill_grey(start = 0.6, end = 0.96) +
    ggplot2::scale_color_grey(start = 0.6, end = 0.6) +
    ggplot2::labs(fill = '') +
    ggplot2::theme_bw(base_size = rozmiarTekstu) + 
    ggplot2::theme(
      text              = ggplot2::element_text(family = 'Montserrat'),
      panel.border      = ggplot2::element_rect(fill = NA, colour = NA),
      legend.position   = 'right',
      legend.text       = ggplot2::element_text(size = rozmiarTekstu),
      axis.text.x       = ggplot2::element_text(size = rozmiarTekstu),
      axis.text.y       = ggplot2::element_text(size = rozmiarTekstu),
      axis.title.x      = ggplot2::element_text(size = rozmiarTekstu),
      axis.title.y      = ggplot2::element_text(size = rozmiarTekstu),
      plot.title        = ggplot2::element_text(size = rozmiarTekstu, hjust = 0)
    )
  
  if (!is.null(tytul)) {
    wykres = wykres + ggtitle(tytul)  
  }
  if (!is.null(tytulX)) {
    wykres = wykres + xlab(tytulX)
  }
  if (!is.null(tytulY)) {
    wykres = wykres + ylab(tytulY)
  }
  
  return(wykres)
}
