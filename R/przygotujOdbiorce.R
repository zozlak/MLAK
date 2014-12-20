#' @export
przygotujOdbiorce = function(odbiorca, dane){
  kolEval = grep('^[.]', names(grupyOdbiorcow))
  for(i in kolEval){
    grupyOdbiorcow[, i] = sapply(grupyOdbiorcow[, i], function(x){
      return(parse(text = x))
    })
  }
  
}