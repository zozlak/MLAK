# PEJK
Pakiet do generowania raportów dla PEJK

## Instalacja

PEJK jest dostępny przez GitHub-a

### Za pomocą devtools

Jeśli jeszcze nie zainstalowałeś pakietu *devtools*, to czas najwyższy:

```r
install.packages('devtools')
```

Jeśli już masz pakiet *devtools*:

```r
devtools::install_github('zozlak/PEJK')
```

**Uwaga** z powodu błędu w pakiecie *devtools* metoda ta nie działa na 64-bitowych linuksach.

### Ze źródeł

W linii komend wykonaj:

```
git clone https://github.com/zozlak/PEJK.git
R CMD INSTALL PEJK
```

## Użycie

1. Przygotuj szablon raportu jako plik Markdown - patrz przykłady w katalogu raporty (pliki z rozszerzeniem *.Rmd*)
2. Przygotuj dane
3. Przygotuj i uruchom skrypt definiujący grupy odbiorców generujący raporty - patrz przykłady w katalogu raporty (pliki z rozszerzeniem *.R*)