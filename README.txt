Gra by³a kompilowana na lazarusie z bibliotek¹ AllegroPAS pod windows7 x64. Preferowana rozdzielczoœæ to 1366x768
Aby skompilowaæ j¹ u siebie nale¿y zainstalowaæ bibliotekê allegro 4.X i wy³¹czyæ debugger w lazarusie

sterowanie:
- po menu nale¿y przechodziæ strza³kami
- w czasie rozgrywki u¿ywamy myszki
	- lewy przycisk aby zaznaczyæ jedn¹ komórkê
	- prawy przycisk myszy aby zaznaczyæ wiele komórek
	- przycisk a na klawiaturze aby strzeliæ wszytkimi komórkami na raz.
- aby zakoñczyæ dzia³anie gdy u¿ywamy klawisza q
- aby zakoñczyæ dzia³anie konkretnego poziomu u¿ywamy klawisza ESC
- w edytorze poziomów aby zatwierdziæ pozycjê komórki naciskamy klawisz SPACE
- aby zakoñczyæ pracê z edytorem poziomów wciskamy ENTER
- wszelkie inne czynnoœci zatwierdzamy najczêœciej klawiszem ENTER.

opis struktury plików i folderów:
-.git   	  - folder stworzony przez GitHub
-backup 	  - folder stworzony przez lazarusa z backup'em plików Ÿród³owych.
-bc		  - folder z klatkami animacji
  -cellb1.pcx	  - plik graficzny komórki
  -cellr1.pcx	  - plik graficzny komórki
  -cellw1.pcx	  - plik graficzny komórki
  ..
  -cursor.pcx	  - plik graficzny kursora myszy
-grafikiXCF	  - folder z grafikami koncepcyjnymi w formacie GIMP'a
   -cellb.xcf	  - plik graficzny z komórk¹ niebiesk¹
   -cellr.xcf	  - plik graficzny z komórk¹ czerwon¹
   -cellw.xcf	  - plik graficzny z komórk¹ bia³¹
   -cursor.xcf    - plik graficzny z kursorem myszki
   -komorka.xcf	  - nie aktualny ju¿ plik z grafik¹ komórki
-lvl		  - folder trzymaj¹cy pliki z levelami
   -1.lvl	  - plik poziomu stworzony na potrzeby prezentacji
   ..
   -mojLVL	  - plik opisuj¹cy lvl stworzony przez gracza
-alleg44.dll	  - plik DLL potrzebny do poprawnego dzia³anina biblioteki allegro
-config.cfg	  - plik z zapisanymi ustawieniami rozdzielczoœci
-AI.pas		  - plik biblioteczny dla AI
-NWatStart.pas	  - plik biblioteczny 
-NWbubbleList.pas - plik biblioteczny trzymaj¹cy listê 
-NWCells	  - plik biblioteczny trzymaj¹cy funkcje z komórkami
-NWGameEngine.pas - plik biblioteczny z g³ównymi funkcjami gry
-NWmenu.pas	  - plik biblioteczny z funkcjami dla menu
-Nwsprites.pas	  - plik biblioteczny z funkcjami dla sprites
-README.txt	  - plik który w³aœnie czytasz
-test1.exe	  - plik odpalaj¹cy grê
-test1.lpi	  - plik projektowy lazarusa
-test1.lpr	  - plik projektowy lazarusa z kodem gry
-test1.lps	  - plik projektowy lazarusa
 
 
