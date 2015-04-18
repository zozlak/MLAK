#' @title buduje i instaluje lokalnie pakiet
#' @return NULL
#' @import devtools
#' @export
zainstaluj = function(){
  suppressMessages(devtools::document(roclets = c('rd', 'collate', 'namespace')))
  devtools::build(quiet = TRUE)
  tmp = list.files('../', '^MLAK.*tar.gz$')
  tmp = tmp[order(tmp, decreasing = TRUE)]
  install.packages(paste0('../', tmp[1]), repos = NULL, quiet = TRUE)
  return(invisible(TRUE))
}