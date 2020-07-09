#' Usuwa nachodzące na siebie etykiety osi
#' @param wykres obiekt wykresu ggplot
#' @param breaks wektor pozycji (i jednocześnie etykiet) osi
#' @param rozmiarTekstu rozmiar tekstu na wykresie
#' @param pomijajEtykiety liczba określająca minimalną odległość między
#'   wyświetlanymi etykietami
#' @return zmodyfikowany obiekt wykresu ggplot
etykietyHistogramu = function(wykres, breaks, rozmiarTekstu, pomijajEtykiety) {
  odstepMin = (breaks[length(breaks)] - breaks[1]) * ifelse(is.null(rozmiarTekstu), 10, rozmiarTekstu) / pomijajEtykiety
  etykiety = round(breaks)
  pop = 1
  for (i in 1 + seq_along(breaks[-1])) {
    if (breaks[i] - breaks[pop] < odstepMin) {
      etykiety[i] = ''
    } else {
      pop = pop + 1
      while (etykiety[pop] == '') {
        pop = pop + 1
      }
    }
  }
  
  return(wykres + scale_x_continuous(breaks = breaks, labels = etykiety))
}