Gra by�a kompilowana na lazarusie z bibliotek� AllegroPAS pod windows7 x64. Preferowana rozdzielczo�� to 1366x768
Aby skompilowa� j� u siebie nale�y zainstalowa� bibliotek� allegro 4.X i wy��czy� debugger w lazarusie

sterowanie:
- po menu nale�y przechodzi� strza�kami
- w czasie rozgrywki u�ywamy myszki
	- lewy przycisk aby zaznaczy� jedn� kom�rk�
	- prawy przycisk myszy aby zaznaczy� wiele kom�rek
	- przycisk a na klawiaturze aby strzeli� wszytkimi kom�rkami na raz.
- aby zako�czy� dzia�anie gdy u�ywamy klawisza q
- aby zako�czy� dzia�anie konkretnego poziomu u�ywamy klawisza ESC
- w edytorze poziom�w aby zatwierdzi� pozycj� kom�rki naciskamy klawisz SPACE
- aby zako�czy� prac� z edytorem poziom�w wciskamy ENTER
- wszelkie inne czynno�ci zatwierdzamy najcz�ciej klawiszem ENTER.

opis struktury plik�w i folder�w:
-.git   	  - folder stworzony przez GitHub
-backup 	  - folder stworzony przez lazarusa z backup'em plik�w �r�d�owych.
-bc		  - folder z klatkami animacji
  -cellb1.pcx	  - plik graficzny kom�rki
  -cellr1.pcx	  - plik graficzny kom�rki
  -cellw1.pcx	  - plik graficzny kom�rki
  ..
  -cursor.pcx	  - plik graficzny kursora myszy
-grafikiXCF	  - folder z grafikami koncepcyjnymi w formacie GIMP'a
   -cellb.xcf	  - plik graficzny z kom�rk� niebiesk�
   -cellr.xcf	  - plik graficzny z kom�rk� czerwon�
   -cellw.xcf	  - plik graficzny z kom�rk� bia��
   -cursor.xcf    - plik graficzny z kursorem myszki
   -komorka.xcf	  - nie aktualny ju� plik z grafik� kom�rki
-lvl		  - folder trzymaj�cy pliki z levelami
   -1.lvl	  - plik poziomu stworzony na potrzeby prezentacji
   ..
   -mojLVL	  - plik opisuj�cy lvl stworzony przez gracza
-alleg44.dll	  - plik DLL potrzebny do poprawnego dzia�anina biblioteki allegro
-config.cfg	  - plik z zapisanymi ustawieniami rozdzielczo�ci
-AI.pas		  - plik biblioteczny dla AI
-NWatStart.pas	  - plik biblioteczny 
-NWbubbleList.pas - plik biblioteczny trzymaj�cy list� 
-NWCells	  - plik biblioteczny trzymaj�cy funkcje z kom�rkami
-NWGameEngine.pas - plik biblioteczny z g��wnymi funkcjami gry
-NWmenu.pas	  - plik biblioteczny z funkcjami dla menu
-Nwsprites.pas	  - plik biblioteczny z funkcjami dla sprites
-README.txt	  - plik kt�ry w�a�nie czytasz
-test1.exe	  - plik odpalaj�cy gr�
-test1.lpi	  - plik projektowy lazarusa
-test1.lpr	  - plik projektowy lazarusa z kodem gry
-test1.lps	  - plik projektowy lazarusa
 
 
