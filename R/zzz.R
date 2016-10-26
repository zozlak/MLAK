.onLoad = function(libname, pkgname){
  options(scipen = 100)
  assign('.MLAK', list(giodo = 3), pos = 1)
  return(invisible(NULL))
}
