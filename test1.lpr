program test1;

uses dos, crt, allegro, sysutils;




var configTAB                  : array of integer; //tablica dynamiczna zawierąca wszystkie dane z configu
var i,j                        : integer;          //iteratory
var rMouseBTAB                 : array of integer;
var buffer                     : al_BITMAPptr;     //glowna bitmapa na którą rysuje
var wspolczynnikRozdzielczosci : integer;      //1 dla 4:3, 0 dla 16:9
var sprite                     : al_BITMAPptr;
var spriteBLUE                 : array[1..16] of al_BITMAPptr; //tablica trzymająca poszczególne klatki animacji
var spriteRED                  : array[1..16] of al_BITMAPptr; //j.w
var spriteWHITE                : array[1..16] of al_BITMAPptr; //j.w
var ilosc                      : integer;                      //zmienna okreslajaca ile aktualnie komórek znajduje się na planszy
var klik                       : integer;                      //
var zlicz                      : integer;
var flaga                      : integer;
var zOnoFF                     : integer;
var cursor                     : al_BITMAPptr;                 //bitmapa trzymająca wygląd kursora
var cos                        : string;
var nazwaLVL                   : string;                       //string trzymający obecną nazwę poziomu
var numer                      : integer;
var jakzyc                     : integer;
{$I NWsprites.pas}             //"biblioteka" trzymająca funkcje związane z zaczytywaniem sprites
{$I NWcells.pas}               //"biblioteka" z funkcjami dotyczącymi komórek
{$I NWbubbleList.pas}          //"biblioteka" trzymająca funkcje związane z wysylaniem pocisków miedzy komorkami
{$I NWatStart.pas}             // funkcje inicjalizujące
{$I NWmenu.pas}                // funkcja obslugująca menu
{$I AI.pas}                    // biblioteka trzymająca funkcje AI
{$I NWgameEngine.pas}          // jak sama nazwa wskazuje silnik gry.




begin
  initAll();

  Setlength(komorkiNaPlanszy,256);                    //brzydkie rozwiązanie ale dziala :D

  pickRes();                                          //jesli instnieje pik config.cfg to zaczytuje z niego dane, jesli nie to tworzy nowy, pytajac o reozdzielczosc itd.
  ilosc := 10;                                        //inicjalizacja zmiennych
  klik := 0;
  zlicz := 0;
  bubbleCount := 0;
  zOnOFF := 0;
  loadSprites;
  cursor := al_load_bitmap('bc/cursor.pcx',NIL);

  buffer := al_create_bitmap(al_SCREEN_W,al_SCREEN_H); //stworzenie glownej bitmapy
  al_clear_bitmap(buffer);                             //wyczyszczenie jej

  while true do                                        //obsluga menu
  begin
  al_rest(100);
  jakzyc := menu();
  al_remove_keyboard;                                  //cos dziwnego sie dzialo i taki zabieg pomogl
  al_rest(100);
  al_install_keyboard;
  if jakzyc = 4 then exit;
  if jakzyc = 3 then leveleditor;
  if jakzyc = 2 then wczytajLvlZklawiatury();
  if jakzyc = 1 then break;
  end;

  numer := 1;                                          //numer lvlu
  while numer <> 5 do
  begin
  al_rest(100);
  nazwaLVL := intToStr(numer) + '.lvl';
  beforeStartLVL(numer);
  al_rest(100);
  loadLevel(nazwaLVL);
  if(playLevel() > 0) then begin wygrana(); numer := numer + 1; end
                      else begin przegrana(); end;
  if (al_key[al_KEY_q] <> 0) or (al_key[al_KEY_Q] <> 0) then exit; //jeżeli gracz wcisna q to chce zakonczyc gre
  end;

  al_rest(100);

  while al_key[al_KEY_ESC] = 0 do                                  //micro credit
  begin
  al_textout_centre_ex (al_screen, al_font,'Dziekuje za gre :)', al_screen_W div 2, 100, al_makecol (255, 255, 255), -1);
  al_textout_centre_ex (al_screen, al_font,'Masz jakies uwagi? Podziel sie nimi ze mna!', al_screen_W div 2, 100  + 20, al_makecol (255, 255, 255), -1);
  al_textout_centre_ex (al_screen, al_font,'evemorgen1911@gmail.com', al_screen_W div 2, 100 + 40, al_makecol (255, 255, 255), -1);
  al_textout_centre_ex (al_screen, al_font,'Nacisnij ESCAPE aby zakonczyc gre.', al_screen_W div 2, 100 + 60, al_makecol (255, 255, 255), -1);
  end;

  al_destroy_bitmap(buffer); //czyszczenie pozostalosci po grze.
  destroySprites;
  al_exit;
end.
