#' @title liczba rekordów niebędących brakami danych
#' @description
#' Zlicza liczbę rekordów niebędących brakami danych.
#' 
#' Jeśli podano wektor w, zliczane są tylko wartości zawarte w wektorze w.
#' @param x wektor wartości
#' @param w [opcjonalny] wektor zliczanych wartości
#' @param wyrownaj czy wyrównywać długość wyniku (TRUE w wypadku osadzania w 
#'   tabelach)
#' @return NULL
#' @export
N = function(x, w = NULL, wyrownaj = T){
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
  
  if(!is.null(w)){
    f = function(d){
      return(sum(d %in% w))
    }
    # obejście funkcji giodo() przy braku wartości w wektorze
    if(f(x) == 0){
      x = c(x, rep(NA, 50))
    }
    # obejście umożliwiające zliczanie NA
    if(any(is.na(w))){
      if(all(is.na(x))){
        tmp = 1
      }else if(is.numeric(x)){
        tmp = max(x, na.rm = T) + 1
      }else{
        tmp = paste0('_', max(x, na.rm = T))
      }
      x[is.na(x)] = tmp
      w[is.na(w)] = tmp
    }
    
    return(statWektor(x, f, sys.call(), wyrownaj, 0))
  }else{
    return(statWektor(x, length, sys.call(), wyrownaj, 0))
  }
}