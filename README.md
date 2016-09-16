# MLAK

[![Travis-CI Build Status](https://travis-ci.org/zozlak/MLAK.png?branch=master)](https://travis-ci.org/zozlak/MLAK)
[![Coverage Status](https://coveralls.io/repos/zozlak/MLAK/badge.svg?branch=master&service=github)](https://coveralls.io/github/zozlak/MLAK?branch=master)

Pakiet ułatwiający generowanie raportów w R z wykorzystaniem pakietu [rmarkdown](http://rmarkdown.rstudio.com/)

Pierwotnie pakiet powstał w celu wygenerowania [raportów o ekonomicznych losach absolwentów szkół wyższych](http://absolwenci.nauka.gov.pl).

## Instalacja

1. Jeśli nie masz jeszcze pakietu _devtools_, zainstaluj go:
   ```r
   install.packages('devtools')
   ```
   
2. Zainstaluj pakiet _MLAK_ z użyciem _devtools_:
   ```r
   devtools::install_github('zozlak/MLAK')
   ```
   
### Zależności

Do poprawnego działania pakiet _MLAK_ potrzebuje, aby w systmie zainstalowany był program [Pandoc](http://pandoc.org/).

Aby możliwe było generowanie raportów w formacie PDF niezbędna jest również obecność w systemie dystrybucji _LaTeX-a_.

Dokładniejsze informacje znaleźć można na [stronie wiki](https://github.com/zozlak/MLAK/wiki/1.1-Instalacja).


## Korzystanie z pakietu

Patrz [strona wiki](https://github.com/zozlak/MLAK/wiki).

## Dokumentacja techniczna

Patrz [strona wiki](https://github.com/zozlak/MLAK/wiki).
