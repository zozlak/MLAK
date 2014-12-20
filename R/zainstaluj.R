#' @title buduje i instaluje lokalnie pakiet
#' @return NULL
#' @export
zainstaluj = function(){
  devtools::document(roclets = c('rd', 'collate', 'namespace'))
  devtools::build()
  tmp = list.files('../', '^PEJK.*tar.gz$')
  tmp = tmp[order(tmp, decreasing = TRUE)]
  install.packages(paste0('../', tmp[1]), repos = NULL)
  return(NULL)
}