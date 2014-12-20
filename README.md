# PEJK
Pakiet do generowania raportów dla PEJK

## Instalacja

Praca z pakietem składa się zasadniczo z dwóch kroków:

1. Instalacji pakietu w R, co zapewnia doinstalowanie wszystkich potrzebnych 
   pakietów, itp.
   
2. Założenia nowego projektu RStudio na podstawie repozytorium _Git_, co 
   zapewnia dostęp do przykładowych szablonów raportów, jak również umożliwia 
   udostępnienie innym szablonów przygotowanych przez siebie.

### Instalacja pakietu

1. Jeśli nie masz jeszcze pakietu _devtools_, zainstaluj go:
   ```r
   install.packages('devtools')
   ```
2. Zainstaluj pakiet _PEJK_ z użyciem _devtools_:
   ```r
   devtools::install_github('zozlak/PEJK')
   ```
3. Jeśli jesteś użytkownikiem 64-bitowego linuksa, wtedy krok 2. może się nie
   powieść (z uwagi na błąd w pakiecie _devtools_). W takim wypadku musisz
   zainstalować pakiet _PEJK_ ręcznie z linii komend:
   ```
   git clone https://github.com/zozlak/PEJK.git
   R CMD INSTALL PEJK
   rm -fR PEJK
   ```

### Założenie projektu RStudio na podstawie repozytorium _Git_

1. W *RStudio* wybrać menu *File->New Project...*.

2. Wybrać *Version Control*, a następnie _Git_.

3. Wpisać `https://github.com/zozlak/PEJK.git` w pole *Repository URL* oraz 
   wskazać katalog, do którego zostaną ściągnięte źródła pakietu (pole
   *Create project as subdirectory of*), po czym kliknąć przycisk *Create
   Project*
4. Poczekać, aż wszystko się ściągnie.

5. Przejść do lektury następnego rozdziału.

## Tworzenie i edycja raportów

**Szablony raportów znajdują się w katalogu _raporty_**.  

Na chwilę obecną przygotowany został szablon raportu _R2-uczelnia_. Na jego
przykładzie opisany zostanie sposób samodzielnego tworzenia raportów.

### Użyta technologia i jej dokumentacja

Raporty generowane są za pomocą pakietu *rmarkdown*. Ten z kolei pod spodem
korzysta z pakietów *knitr* (raporty w formacie PDF) oraz *shiny* (raporty 
interaktywne).

**Dokładną dokumentację składni _Markdown_ można znaleźć na stronach:**

- http://rmarkdown.rstudio.com/authoring_basics.html
- http://rmarkdown.rstudio.com/authoring_pandoc_markdown.html

**Tworzenie raportów interaktywnych opisane zostało na stronie:**

- http://rmarkdown.rstudio.com/authoring_shiny.html

### Tworzenie raportu

Katalog z szablonem raportu (np. _raporty/R2-uczelnia/_) zawiera następujące
pliki i katalogi:

- Plik z szablonem _Markdown_ raportu (tu _R2-uczelnia.Rmd_).  
  Opisuje on zawartość raportu. Odnosząc go do _raportera_ jest on kombinacją
  _technicznego szablonu RTF_ oraz pliku _.ord_ definiującego poszczególne
  podgrupy populacji oraz obliczane dla nich statystyki.

- [opcjonalnie] Skrypt R generujący raporty dla poszczególnych grup odbiorców
  (tu _R2-uczelnia.R_). Jest to prosty skrypt, którego jedynym celem jest
  wywołanie funkcji _generujRaporty()_ z odpowiednimi parametrami.
  
- [opcjonalnie] Szablon _Markdown_ raportu interaktywnego (tu 
  _R2-uczelnia-shiny.Rmd_). Zawiera on definicje kontrolek umożliwiających
  użytkownikowi wybór parametrów raportu oraz skrypt R, który na podstawie
  pobranych od użytkownika parametrów oraz pliku z właściwym szablonem raportu
  (patrz punkt 1.) generuje i wyświetla odpowiedni raport.

- Katalog _raporty_, w którym generowane są wersje PDF raportów.

- Zbiór danych w formacie CSV lub RData
  - **Z uwagi na poufność danych zbiorów danych nigdy nie należy
    ich dodawać do repozytorium _Git_**.
  - Zbiór danych do raportu _R2-uczelnia_ to przekonwertowany za pomocą
    _konwertera_ zbiór _R2-uczelnia/dane_USOS.mfm_ w formie takiej, w jakiej
    otrzymałem go od Mikołaja Jasińskiego.

- Zbiór danych z definicją odbiorców w formacie CSV lub RData.

- Wszelkie pozostałe pliki i katalogi (także podkatalogi katalogu _raporty_)
  są plikami tymczasowymi powstającymi podczas generowania raportów. Można
  je bez żadnej szkody usuwać i nie należy ich dodawać do repozytorium _Git_.
  
### Plik z szablonem Markdown raportu

Jest to zwykły plik w _nowym formacie Markdown_, co oznacza obsługiwanie go
z użyciem pakietu _rmarkdown_. Bardzo dobre wsparcie dla edycji dokumentów
w tym formacie zapewnia _Rstudio_ od wersji 0.98.945 (zresztą pakiet 
_rmarkdown_ napisali właśnie programiści _RStudio_).

Przyjrzyjmy się plikowi szablonu _raporty/R2-uczelnia/R2-uczelnia.Rmd_.

Zaczyna się on krótkim nagłówkiem opisującym metadane szablonu, w szczególności
tytuł i format docelowy:
```
---
title: "ETAP STUDIÓW"
output: html_document
---
```
Opcje te można wygodnie edytować w okienku ustawień wywoływanym kliknięciem na
szare kółko zębate po prawej stronie belki znajdującej się nad treścią 
edytowanego szablonu.

Warto zwrócić uwagę, że obok przysiku zębatki znajduje się przycisk 
umożliwiający wygenerowanie przykładowego raportu. Do tego, jeśli klikniemy na
małą strzałeczkę obok niego, możemy wybrać alternatywne formaty (DOCX lub 
HTML).

W dalszej części plik zawiera zwykły kod _Markdown_ zgodnie z opisem na 
stronach:
- http://rmarkdown.rstudio.com/authoring_basics.html
- http://rmarkdown.rstudio.com/authoring_pandoc_markdown.html

Aby sam kod _Markdown_ pozostał przejrzysty i łatwo można było na jego 
podstawie wyobrazić sobie układ końcowego dokumentu definiowanie podgrup, 
wyliczanie bardziej złożonych statystyk, itp. najlepiej umieścić w oddzielnym
bloku na początku szablonu. W pliku _R2-uczelnia.Rmd_ służy do tego drugi
blok kodu R:
```r
# definicje grup
grupa1 = grupaGl
grupa13 = grupaGl & ERASMUS %in% 100
grupa14 = grupaGl & ERASMUS %in% 0
grupa32 = grupaGl & NPELUSOS %in% 0
grupa33 = grupaGl & NPELUSOS %in% 100
grupa37 = grupaGl & STYPEND %in% 100
grupa38 = grupaGl & STYPEND %in% 0
```
Odpowiada on za to samo, co definicje _VAR13, VAR14, itp._ wyklikiwane w
_raportrzerze_. Definicje powyższe umożliwiają przejrzyste w zapisie
obliczanie statystyk w dalszej części dokumentu z użyciem krótkich wstawek R,
np.:
```
`r N(ENKA[grupa13])`
```

Oddzielnego omówienia wymaga pierwszy blok kodu R:
```r
library(PEJK)
# przykładowe dane, jeśli nie generujemy wsadowo
attach(wczytajOdbiorce('grupy_odbiorców.csv', 'dane.csv', 1))
```

Pierwsza linia ładuje pakiet PEJK, aby możliwe było korzystanie z różnorakich
funkcji pomocniczych, np. _czytajOdbiorce()_, _funkcji formatujących_ (patrz 
dalej), itp.

W drugiej linii pobierane są przykładowe dane, aby podczas generowania podglądu 
raportu miały się na czym wykonać obliczenia.

W tym wypadku pobierany jest pierwszy odbiorca z pliku definicji odbiorców
*grupy_odbiorcow.csv* oraz dane z pliku *dane.csv*.

Podczas hurtowego generowania raportów za pomocą funkcji _generujRaporty()_
wczytywanie przykładowych danych jest automatycznie pomijane.

Reszta pliku to już najzwyklejszy kod _Markdown_.

#### Pomocnicze funkcje formatujące

Aby:

- uczynić kod _Markdown_ bardziej przejrzystym;

- ustandaryzować formatowania stosowane w raportach;

- wspomóc w radzeniu sobie z uciążliwymi problemami (patrz rozdział o tabelach)

pakiet _PEJK_ zawiera _funkcje formatujące_. Są to proste funkcje 
odpowiedzialne za:

- obliczanie najczęściej wykorzystywanych statystyk;

- formatowanie zwracanych wartości tak, by można je było łatwo umieszczać 
  w tabelach.

W chwili obecnej dostępne są:

- `N(x)` - zwraca liczbę obserwacji zmiennej _x_, które nie są brakami danych;

- `N(x, w)` - zwraca liczbę obserwacji zmiennej _x_, których wartość wynosi w;
  (w może być też wektorem wartości)

- `E(x)` - zwraca średnią wartości zmiennej _x_;

- `M(x)` - zwraca medianę wartości zmiennej _x_;

- `Q(x, q, n)` - zwraca wartość _q-tego_ kwantyla zmiennej _x_ spośród _n_ 
   kwantyli;

- `W(x)` - zwraca sformatowaną wartość zmiennej _x_ (patrz opis tworzenia 
  tablic);

- `G(x, q, n, filtr)` - zwraca zmienną definiującą podgrupę, która jest
   _q-tym_ spośród _n_ kwantyli wyznaczonych ze względu na zmienną _x_
   w grupie wyznaczonej przez _filtr_, np. 
   `G[PKTRANG, 2, 3, ERASMUS %in% 100]` wyznaczy grupę studentów o "środkowych"
   (drugi z trzech kwantyli) wynikach ze względu na zmienną _PKTRANG_ w ramach
   grupy studentów, którzy uczestniczyli w programie Erasmus

Jeśli będzie taka potrzeba, dopisywane zostaną następne.

Pozwalają one na:

- skrótowy i bardziej przejrzysty zapis wstawek R w pliku szablonu, np.:
```
`r N(ENKA[grupa32])`
```
zamiast
```
`r length(na.omit(ENKA[grupa32]))`
```

- dodanie kontroli minimalnej liczby obserwacji, dla których można obliczać
  statystyki

#### Tabele

Tablice definiować można na kilka sposobów (patrz 
http://rmarkdown.rstudio.com/authoring_pandoc_markdown.html#tables). Tutaj 
skupimy się na dwóch.

W wypadku, gdy zawartość tabeli nie wymaga łamania wierszy, najwygodniej
deifniować je jako _pipe tables_, gdzie separatorem kolumny jest znak `|`. Ma 
to tą zaletę, że kod _Markdown_ opisujący poszczególne komórki tabeli nie musi
zachowywać szerokości kolumn, tzn. poprawną definicją tabeli będzie np.:
```
nagł kol. 1 | nagł. kol. 2
-|-
12|15
```

**Jest to duża zaleta, ponieważ w wypadku osadzania kodu R przetworzony kod
_Markdown_ będzie miał zapewne inną strukturę niż ten, który widzimy w pliku
szablonu**. Weźmy jako przykład tabelkę:
```
Osoby, które                                          |       Uzyskały stypendium|   Nie uzyskały stypendium
------------------------------------------------------|-------------------------:|-------------------------:
uzyskały co najmniej raz stypendium za wyniki w nauce |      `r N(ENKA[grupa37])`|      `r N(ENKA[grupa38])`
```
Po wykonaniu osadzonego kodu R przyjmie ona postać (wartości oczywiście zmyślam):
```
Osoby, które                                          |       Uzyskały stypendium|   Nie uzyskały stypendium
------------------------------------------------------|-------------------------:|-------------------------:
uzyskały co najmniej raz stypendium za wyniki w nauce | 234| 697
```
a więc poszczególne kolumny _przestaną na siebie trafiać_. Tylko _pipe tables_ 
radzą sobie gładko w takim wypadku.

_Pipe tables_ mają jednak tą istotną wadę, że w wypadku eksportu do PDF (i 
tylko wtedy [sic!]) nie łamią zawartości komórek tabeli, gdy ta jest zbyt 
szeroka, by zmieścić się na stronie. Stąd w wypadku, **gdy mamy do czynienia z
tabelą zawierającą długie teksty, konieczne jest stosowanie _multiline 
tables_.**

Głównym problemem z _multiline tables_ jest konieczność idealnego *trafiania na
siebie* kolumn w kolejnych wierszach. Aby sobie z tym poradzić *funkcje 
formatujące* (patrz poprzedni rozdział) automatycznie dopełniają zwracaną 
wartość do takiej długości, jaką miało wywołanie funkcji formatującej plus 4 
znaki. Powoduje to, że stosowanie wstawek postaci 
```
`r f(parametry)`
```
w _multiline tables_ nie wymaga żadnych dodatkowych czynności.

Przykład tabeli w postaci _multiline tables_ (ostatnia tabela z szablonu 
_R2-uczelnia.Rmd_):
```
------------------------------------------------------------------------------------------------------------------------
Wartości wskaźników                                                 Osoby pełnosprawne             Osoby niepełnosprawne
---------------------------------------------------- --------------------------------- ---------------------------------
Procent studentów, którzy terminowo uzyskali dyplom            `r E(DTERM1[grupa33])`%           `r E(DTERM1[grupa33])`%
(licząc od rozpoczęcia studiów)        
```

#### Wykresy

Wykresy generujemy dokładnie w ten sam sposób, jak robilibyśmy to w zwykłym
kodzie R (oczywiście osadzając ten kod w pliku szablonu jako wstawkę kodu R).

Aby osiągnąć porządany rozmiar wykresu w docelowym dokumencie dostosowujemy
odpowiednio parametry _fig.height_ oraz _fig.width_ wstawki kodu R, np. 
w _R2-uczelnia.Rmd_:
```r
```{r echo = FALSE, fig.height = 3.5}
(...kod generujący wykres...)
```

Jeśli przygotowując wykresy korzystamy z *funkcji formatujących*, musimy 
pamiętać, aby jako argument _wyrownaj_ przekazać im FALSE. Inaczej zamiast
wartości liczbowych będą one zwracać łańcuchy znaków!

### Plik definicji odbiorców

Plik definicji odbiorców zasadniczo nie różni się od tego, jaki był używany
w Raporterze. Istotne różnice to:

- Format - plik powinien być w formacie CSV (separator pola: średnik, kodowanie
  znaków: Windows-1250 - są to domyślne ustawienia Excel-a pod Windows) lub
  RData.
  
- Dostosowanie kolumn definiujących grupy obserwacji w danych:
  - dodanie na początku nazwy kolumny kropki (np. _.VAR1K_ zamiast _VAR1K_);
  - dostowanie składni filtrów:
    - usunięcie wiodącego 0 lub 1 (oznaczającego ew. negację całego warunku);
    - zamianę _AND_ na _&amp;_;
    - zamianę _=_ na _%in%_.
    - np. `1 KIERUNEK=1 AND ROKDYP=2010` zamieniamy na 
      `KIERUNEK %in% 1 & ROKDYP %in% 2010`

### Skrypt R hurtowo generujący raporty

Jest to plik z kodem R odpowiedzialnym za:

- załadowanie pakietu _PEJK_;
- wykonanie funkcji _generujRaporty()_.

Sprowadza się to do załadowania pakietu PEJK oraz wykonania funkcji
_generujRaporty()_ z odpowiednimi parametrami, np. (plik _R2-uczelnia.R_):


```r
library(PEJK)

generujRaporty(
  plikSzablonu   = 'raporty/R2-uczelnia/R2-uczelnia.Rmd', 
  dane           = 'raporty/R2-uczelnia/dane.csv',
  grupyOdbiorcow = 'raporty/R2-uczelnia/grupy_odbiorców.csv',
  katalogWy      = 'raporty', 
  prefiksPlikow  = 'R2-'
)
```

Parametry funkcji _generujRaporty()_ to:

- _plikSzablonu_ - ścieżka do pliku _.Rmd_ z szablonem raportu

- dane - ścieżka do pliku danych w formacie CSV (separator pola: średnik, 
  kodowanie znaków: Windows-1250 - są to domyślne ustawienia Excel-a pod 
  Windows) lub .RData, alternatywnie po prostu ramka danych R;
  
- _grupyOdbiorcow_ ścieżka do pliku CSV (separator pola: średnik, kodowanie 
  znaków: Windows-1250 - są to domyślne ustawienia Excel-a pod Windows) z
  definicjami odbiorców, alternatywnie ramka danych lub lista z definicjami
  odbiorców;

- _katalogWy_ - katalog, do którego zapisywane będą pliki pdf raportów
  (jeśli nie istnieje, zostanie automatycznie utworzony);

- _prefiksPlikow_ - nazwa każdego pliku pdf raportu będzie się składać z 
  połączenia tego prefiksu oraz pierwszej kolumny zbioru danych opisującego
  grupy odbiorców.

### Raporty interaktywne

Korzystanie z pakietu _rmarkdown_ daje możliwość łatwego stworzenia raportów
interaktywnych. Oczywiście wtedy już nie w formacie PDF, ale w postaci stron 
WWW (choć niewymagających do działania serwera).

Najprostszym przykładem takiej interaktywności może być danie użytkownikowi
możliwości samodzielnego wyboru grupy odbiorców. Przykład taki znajduje się
w pliku _R2-uczelnia-shiny.Rmd_. Po otwarciu pliku i naciśnięciu przycisku
_Run document_ (tam, gdzie w zwykłym pliku szablonu Markdown znajdował się
przycisk tworzący PDF z raportem) otwarta zostanie strona WWW, na której
istniej możliwość wyboru etapu studiów oraz roku rozpoczęcia nauki. Po każdej
zmianie raport odświeża się prezentując wyniki dla danej wybranej grupy.

Plik definiujący taki raport (tu _R2-uczelnia-shiny.Rmd_) składa się z czterech
części:

1. Opcji pliku _Markdown_:
```
---
title: "ETAP STUDIÓW"
output: html_document
date: "06.09.2014"
runtime: shiny
---
```
   Są one analogiczne, jak dla _zwykłego_ szablonu _Markdown_ (porównaj z plikiem
   _R2-uczelnia.Rmd_), jednak zawierają linijkę `runtine: shiny`, a jako format
   wyjściowy wybrany musi być html (`output: html_document`).

2. Sekcji wczytującej dane i ładującej pakiet _PEJK_:
```
library(PEJK)

dane = read.csv2('dane.csv', stringsAsFactors = F)
lataStart = na.omit(unique(dane$ROKSTART))
lataStart = lataStart[order(lataStart)]
```

3. Sekcji opisującej kontrolki, za pomocą których użytkownik określa parametry
   raportu:
```r
inputPanel(
  selectInput(
    'etap', 
    label = 'Etap studiów',
    choices = 1:2,
    selected = 1
  ),
  selectInput(
    'rok', 
    label = 'Rok rozpoczęcia etapu studiów',
    choices = lataStart,
    selected = lataStart[1]
  )
)

```
   W tym wypadku są to dwie listy rozwijalne o nazwach, odpowiednio, _etap_ 
   oraz _rok_. Wprowadzenie do dostępnych kontrolek znaleźć można pod adresem
   http://shiny.rstudio.com/tutorial/lesson3/.

4. Sekcji generującej sparametryzowany raport:
```r
renderUI({
   dane = dane # głupie, ale potrzebne - osadza zmienną w lokalnym kontekście, żeby szablon mógł ją znaleźć
   attach(dane)
   grupaGl = STOPIEN %in% input$etap & ROKSTART %in% input$rok
   stStopienN = input$etap
   stStopienS = ifelse(input$etap == 1, '1 stopnia', '2 stopnia')
   stRok = input$rok
   
   rmarkdown::render(
       input = 'R2-uczelnia.Rmd', 
       output_format = html_document(),
       output_file = 'tmp.html'
   )
   raport = 
   return(HTML(readLines('tmp.html')))
})
```
   Sekcja ta musi:
   - przypisać wartości zmiennym używanym w szablonie _Markdown_ raportu 
     stosownie do wybranych przez użytkownika parametrów; parametry wybrane
     przez użytkownika dostępne są jako elementy listy _input_ (porównaj
     powyższy kod z nazwami kontrolek w poprzednim punkcie)
   - wygenerować kod HTML z zawartością raportu na podstawie szablonu 
     _Markdown_ (służy do tego funkcja _rmarkdown::render()_); ponieważ
     funkcja _rmarkdown::render()_ zawsze zapisuje wygenerowany raport
     do pliku, trzeba podać jakąś nazwę;
   - odczytać zapisany raport z pliku, po czym usunąć plik;
   - zwrócić treść raportu przetworzoną funkcją _HTML()_.

Chcąc samemu przygotować raport interaktywny należałoby względem pliku 
_R2-uczelnia-shiny.Rmd_ dostosować:

- sekcję wczytującą dane;

- sekcję definiującą kontrolki wyboru parametrów raportu;

- sekcję generującą sparametryzowany raport, ale jedynie w zakresie przypisania
  wartości zmiennych używanych w szablonie _Markdown_ raportu oraz ścieżki
  do pliku tego szablonu.
