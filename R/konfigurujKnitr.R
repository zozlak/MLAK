# funkcja ustawiająca opcje konfiguracyjne knitr-a,
# tak by bardziej odpowiadały naszym potrzebom
#' @import knitr
konfigurujKnitr = function(){
  opts_chunk$set(
    'error' = FALSE, 'warnings' = FALSE, 'message' = FALSE,
    'echo' = FALSE, 'results' = 'asis'
  )
  
  cairo = capabilities()['cairo']
  if(cairo %in% TRUE){
    opts_chunk$set('dev' = 'cairo_pdf')
  }else{
    pdf.options(encoding = 'CP1250')
  }
}