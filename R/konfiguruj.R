#' @title Konfiguruje działanie pakietu
#' @return wektor lub ramka danych
#' @export
.konfiguruj = function(giodo = 3){
  stopifnot(
    is.vector(giodo), is.numeric(giodo), length(giodo) == 1, all(!is.na(giodo))
  )
  ustawienia = get('.MLAK', 1)
  ustawienia[['giodo']] = giodo
  assign('.MLAK', ustawienia, pos = 1)
}