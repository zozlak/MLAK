.onLoad = function(libname, pkgname){
  options(scipen = 100)
  assign('.MLAK', TRUE, envir = parent.frame())
  return(invisible(NULL))
}
