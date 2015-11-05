.onLoad = function(libname, pkgname){
  assign('.MLAK', TRUE, envir = parent.frame())
  return(invisible(NULL))
}

.onUnload = function(libname, pkgname){
  return(invisible(NULL))
}