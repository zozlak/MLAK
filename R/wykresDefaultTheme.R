#' Domyślny styl wykresów
#' @description
#' Funkcja zwracająca domyślne ostylowania wykresów, współdzielone pomiędzy
#' wszystkie funkcje rysujące wykresy
#' @param wykres obiekt gpplot2 wykresu
#' @param rozmiarTekstu domyślny rozmiar tekstu
wykresDefaultTheme = function(wykres, rozmiarTekstu){
  return(
    wykres +
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
  )
}