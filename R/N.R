#' @title liczba rekordów niebędących brakami danych
#' @description
#' Zlicza liczbę rekordów niebędących brakami danych.
#' 
#' Jeśli podano wektor w, zliczane są tylko wartości zawarte w wektorze w.
#' @param x wektor wartości
#' @param w [opcjonalny] wektor zliczanych wartości
#' @param wyrownaj czy wyrównywać długość wyniku (jeśli NA, wybór zostanie
#'   dokonany automatycznie)
#' @return NULL
#' @export
N = function(x, w = NULL, wyrownaj = NA){
  stopifnot(
    is.vector(x),
    is.numeric(x) | is.character(x) | is.logical(x),
    is.vector(w) | is.null(w)
  )
  if(!is.null(w)){
    stopifnot(
      is.numeric(w) | is.character(w) | is.logical(w)
    )
  }
  wyrownaj = ustawWyrownaj(wyrownaj)

  if(!is.null(w)){
    # obejście umożliwiające zliczanie NA
    if(any(is.na(w))){
      tmp = naNaWartosc(x)
      x[is.na(x)] = tmp
      w[is.na(w)] = tmp
    }

    # obejście funkcji giodo() przy braku wartości w wektorze
    f = function(d){
      return(sum(d %in% w))
    }
    if(f(x) == 0){
      x = c(x, rep(NA, 50))
    }
    
    return(statWektor(x, f, sys.call(), wyrownaj, 0))
  }else{
    return(statWektor(x, length, sys.call(), wyrownaj, 0))
  }
}
