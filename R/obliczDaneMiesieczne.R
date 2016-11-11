#' Agreguje dane do wykresów miesięcznych
#' @description 
#' Funkcja wymaga jawnie przekazanych danych w odpowiednim formacie (ramki
#' danych \code{daneAbs} i \code{daneMies} muszą być łączliwe (zawierać zmienną
#' o takiej samej nazwie, typowo \code{ID_ZDAU}), a ramka danych \code{daneMies}
#' musi zawierać zmienną \code{OKRES}).
#' @param daneAbs ramka danych ze zmiennymi na poziomie absolwenta na kierunku
#'   studiów
#' @param daneMies ramka danych ze zmiennymi na poziomie absolwenta na kierunku
#'   studiów w posczególnych miesiącach
#' @param zmienne wektor nazw zmiennych, które będą agregowane (zmienne muszą
#'   się znajdować albo w ramce danych \code{daneAba} albo w \code{daneMies})
#' @param grupy wektor nazw zmiennych grupujących (zmienne muszą
#'   się znajdować albo w ramce danych \code{daneAba} albo w \code{daneMies})
#' @param od minimalna wartość zmiennej \code{OKRES} w ramce danych
#'   \code{daneAbs}, aby rekord został uwzględniony w analizie
#' @param do maksymalna wartość zmiennej \code{OKRES} w ramce danych
#'   \code{daneAbs}, aby rekord został uwzględniony w analizie
#' @param dataRel nazwa zmiennej względem której liczony będzie czas (typowo
#'   \code{DATA_ZAK} lub \code{DATA_ROZP} przekazywane w ramce danych
#'   \code{daneAbs}); jeśli nie zostanie podana, czas liczony będzie w
#'   miesiącach kalendarzowych
#' @param odRel minimalna wartość relatywnie wyliczonego okresu, aby rekord
#'   został uwzględniony w analizach
#' @param doRel maksymalna wartość relatywnie wyliczonego okresu, aby rekord
#'   został uwzględniony w analizach
#' @param statystyka nazwa funkcji agregującej dane (domyślnie średnia); funkcja
#'   musi obsługiwać parametr \code{na.rm = TRUE}
#' @return [data.frame] ramka danych z obliczonymi wartościami
#' @export
#' @import dplyr
obliczDaneMiesieczne = function(daneAbs, daneMies, zmienne, grupy = character(), dataRel = character(), od = character(), do = character(), odRel = numeric(), doRel = numeric(), statystyka = 'mean'){
  stopifnot(
    is.data.frame(daneAbs), 
    is.data.frame(daneMies) & 'OKRES' %in% names(daneMies),
    is.vector(zmienne) & is.character(zmienne) & length(zmienne) > 0 & all(zmienne %in% names(daneMies)), 
    is.vector(od) & length(od) <= 1 & all(!is.na(od)),
    is.vector(do) & length(do) <= 1 & all(!is.na(do)),
    is.vector(dataRel) & is.character(dataRel) & length(dataRel) <= 1 & all(dataRel %in% c(names(daneAbs), names(daneMies))),
    is.vector(odRel) & is.numeric(odRel) & length(odRel) <= length(dataRel) & all(!is.na(odRel)),
    is.vector(doRel) & is.numeric(doRel) & length(doRel) <= length(dataRel) & all(!is.na(doRel)),
    is.vector(grupy) & is.character(grupy) & sum(!is.na(grupy)) == length(grupy),
    is.character(statystyka) & length(statystyka) == 1 & all(!is.na(statystyka))
  )

  zmienneAbs = intersect(
    names(daneAbs),
    c(setdiff(names(daneMies), zmienne), dataRel, grupy)
  )
  daneAbs = select_(daneAbs, .dots = zmienneAbs)
  
  zmienneMies = intersect(
    names(daneMies),
    c(names(daneAbs), zmienne, dataRel, grupy, 'OKRES')
  )
  daneMies = select_(daneMies, .dots = zmienneMies)
  if (length(od) > 0) {
    daneMies = daneMies %>%
      filter_(~ OKRES >= od)
  }
  if (length(do) > 0) {
    daneMies = daneMies %>%
      filter_(~ OKRES <= do)
  }
  
  dane = inner_join(daneAbs, daneMies)
  if (length(dataRel) > 0) {
    if (is.character(unlist(dane[, dataRel]))) {
      dane = dane %>%
        mutate_(.dots = setNames(paste0('MLAK:::data2okres(', dataRel, ')'), dataRel))
    }
    if (is.character(unlist(dane$OKRES))) {
      dane = dane %>%
        mutate_(OKRES = ~ data2okres(OKRES))
    }
    dane = dane %>%
      mutate_(.dots = list(OKRES = paste0('OKRES - ', dataRel)))
  }

  dane = dane %>%
    group_by_(.dots = c('OKRES', grupy))
  flaga = TRUE
  try({
    zmienneWynik = setNames(as.list(paste0(statystyka, '(', zmienne, ', na.rm = TRUE)')), zmienne)
    zmienneWynik$n = 'n()'
    dane = dane %>%
      summarize_(.dots = zmienneWynik)
    flaga = FALSE
  }, silent = TRUE)
  if (flaga) {
    zmienneWynik = setNames(as.list(paste0(statystyka, '(', zmienne, ')')), zmienne)
    zmienneWynik$n = 'n()'
    dane = dane %>%
      summarize_(.dots = zmienneWynik)
  }
  
  if (length(grupy) > 0) {
    zmienneGrupy = setNames(paste0('paste(', paste0(grupy, collapse = ', '), ')'), 'seria')
    filtr = paste0('!is.na(', grupy, ')', collapse = ' | ')
    dane = dane %>%
      filter_(filtr) %>%
      mutate_(.dots = zmienneGrupy)
  }
  
  dane = dane %>%
    ungroup() %>%
    rename_(x = 'OKRES') %>%
    select_(.dots = c('seria', 'n', 'x', zmienne)) %>%
    melt(id.vars = c('seria', 'n', 'x')) %>%
    rename_(y = 'value')
  
  if(length(odRel) > 0){
    dane = dane %>%
      filter_(~x >= odRel)
  }
  if(length(doRel) > 0){
    dane = dane %>%
      filter_(~x <= doRel)
  }
  
  if(length(zmienne) > 1){
    dane = dane %>%
      mutate_(seria = ~ paste(variable, seria))
  }
  
  dane = dane %>%
    select_('-variable') %>%
    mutate_(seria = ~ as.factor(seria))
  
  return(dane)
}