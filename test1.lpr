program test1;

uses dos, crt, allegro, sysutils;




var configTAB                  : array of integer; //tablica dynamiczna zawierąca wszystkie dane z configu
var i,j                        : integer;
var rMouseBTAB                 : array of integer;
var buffer                     : al_BITMAPptr;
var wspolczynnikRozdzielczosci : integer;      //1 dla 4:3, 0 dla 16:9
var sprite                     : al_BITMAPptr;
var spriteBLUE                 : array[1..16] of al_BITMAPptr;
var spriteRED                  : array[1..16] of al_BITMAPptr;
var spriteWHITE                : array[1..16] of al_BITMAPptr;
var ilosc                      : integer;
var klik                       : integer;
var zlicz                      : integer;
var flaga                      : integer;
var zOnoFF                     : integer;
var cursor                     : al_BITMAPptr;

{$I NWsprites.pas}
{$I NWcells.pas}
{$I NWbubbleList.pas}
{$I NWatStart.pas}
{$I NWmenu.pas}
{$I AI.pas}

{$I NWgameEngine.pas}



var cos : string;

begin
  initAll();

  Setlength(komorkiNaPlanszy,256);                    //brzydkie rozwiązanie ale dziala :D

  pickRes();
  //menu();
  ilosc := 10;
  klik := 0;
  zlicz := 0;
  bubbleCount := 0;
  zOnOFF := 0;
  loadSprites;
  cursor := al_load_bitmap('bc/cursor.pcx',NIL);

  buffer := al_create_bitmap(al_SCREEN_W,al_SCREEN_H);
  al_clear_bitmap(buffer);

  //levelEditor();

  //for i:= 1 to 7 do initCell(i,random(al_SCREEN_W-110)+55,random(al_SCREEN_H-110)+55,random(20)+10,1,random(3),random(16)+1); //ktoraKomorka, X,Y,points,size,id,promien
  //for i:= 8 to 10 do initCell(i,random(al_SCREEN_W-110)+55,random(al_SCREEN_H-110)+55,random(20)+10,3,random(3),random(16)+1); //ktoraKomorka, X,Y,points,size,id,promien
  loadLevel('44.lvl');
  playLevel();

  al_destroy_bitmap(buffer);
  destroySprites;
  al_exit;
end.
