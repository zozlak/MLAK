# MLAK

[![Travis-CI Build Status](https://travis-ci.org/zozlak/MLAK.png?branch=master)](https://travis-ci.org/zozlak/MLAK)
[![Coverage Status](https://coveralls.io/repos/zozlak/MLAK/badge.svg)](https://coveralls.io/r/zozlak/MLAK)

Pakiet do generowania raportów 

## Instalacja

1. Jeśli nie masz jeszcze pakietu _devtools_, zainstaluj go:
   ```r
   install.packages('devtools')
   ```
   
2. Zainstaluj pakiet _MLAK_ z użyciem _devtools_:
   ```r
   devtools::install_github('zozlak/MLAK')
   ```
   
3. Jeśli jesteś użytkownikiem 64-bitowego linuksa, wtedy krok 2. może się nie
   powieść ([patrz tutaj](https://github.com/hadley/devtools/issues/650) ). 
   W takim wypadku musisz zainstalować pakiet _MLAK_ ręcznie z linii komend:
   ```
   git clone https://github.com/zozlak/MLAK.git
   R CMD INSTALL MLAK
   rm -fR MLAK
   ```
### Zależności

Do poprawnego działania pakiet _MLAK_ potrzebuje, aby w systmie zainstalowany był program [Pandoc](http://pandoc.org/).

Aby możliwe było generowanie raportów w formacie PDF niezbędna jest również obecność w systemie dystrybucji _LaTeX-a_.

Dokładniejsze informacje znaleźć można na [stronie wiki](https://github.com/zozlak/MLAK/wiki/1.1-Instalacja).


## Korzystanie z pakietu

Patrz [strona wiki](https://github.com/zozlak/MLAK/wiki).

## Dokumentacja techniczna

Patrz [strona wiki](https://github.com/zozlak/MLAK/wiki).
