program test1;

uses dos, crt, allegro, sysutils;

type
komorka = record
posX      : integer;  //pozycja w x
posY      : integer;  //pozycja w y
punkty    : integer;
rozmiar   : integer;
promien   : integer;
ID        : integer;      //wielkosć komórki, rozróżniamy 3 wielkosci, im większa komorka tym szybciej produkuje points'y
spriteNr  : integer; //obrazek reprezentujący komórkę
end;


var komorkiNaPlanszy : array of komorka; //tablica dynamiczna o zmiennej dlugosci trzymająca wszystkie komórki występujące na planszy
var configTAB        : array of integer; //tablica dynamiczna zawierąca wszystkie dane z configu
var i                          : integer;
var buffer                     : al_BITMAPptr;
var wspolczynnikRozdzielczosci : integer;      //1 dla 4:3, 0 dla 16:9
var sprite                     : al_BITMAPptr;
var spriteBLUE                 : array[1..16] of al_BITMAPptr;
var spriteRED                  : array[1..64] of al_BITMAPptr;
var ilosc                      :integer;
var klik                       :integer;
var zlicz                      :integer;
var flaga                      :integer;

{$I NWatStart.pas}
{$I NWmenu.pas}
{$I NWbubbleList.pas}
{$I NWcells.pas}


procedure loadSprites;
var tmpString : string;
begin
     for i:=1 to 16 do
           begin
           tmpString := 'bc/cellB' + intToStr(i) + '.pcx';
           spriteBLUE[i] := al_load_bitmap(tmpString,NIL);
           tmpString := 'bc/cellR' + intToStr(i) + '.pcx';
           spriteRED[i] := al_load_bitmap(tmpString,NIL);
           end;
end;

procedure destroySprites;
begin
     for i:=1 to 16 do
           begin
           al_destroy_bitmap(spriteBLUE[i]);
           al_destroy_bitmap(spriteRED[i]);
           end;
end;

begin
  initAll();
  pickRes();
  //menu();
  ilosc := 10;
  klik := 0;
  zlicz := 0;
  bubbleCount := 0;

  al_clear_bitmap(buffer);
  loadSprites;
  buffer := al_create_bitmap(al_SCREEN_W,al_SCREEN_H);
  Setlength(komorkiNaPlanszy,256);                    //brzydkie rozwiązanie ale dziala :D


  for i:= 1 to ilosc do initCell(i,random(al_SCREEN_W-110)+55,random(al_SCREEN_H-110)+55,random(20)+10,1,random(2),20,random(16)+1); //ktoraKomorka, X,Y,points,size,id,promien
  while al_key[AL_KEY_ESC] = 0 do
        begin
        al_clear_bitmap(buffer);
        for i:=1 to ilosc do drawCell(i,zlicz);
        al_show_mouse(buffer);
        if (al_mouse_b AND 1) <> 0 then
           begin
           for i:=1 to ilosc do
                 begin
                 if (komorkiNaPlanszy[i].posX <= al_mouse_x) and (komorkiNaPlanszy[i].posX + 60 >= al_mouse_x) and (komorkiNaPlanszy[i].posY <= al_mouse_y) and (komorkiNaPlanszy[i].posY + 60 >= al_mouse_y) then
                    begin
                    if klik <> 0 then
                       begin
                       if klik <> i then pushFRONTbubble(bubbleList,klik,i);
                       klik := 0;
                       break;
                       end;
                    end;
                 end;
           for i:=1 to ilosc do
                 begin
                 if (komorkiNaPlanszy[i].posX <= al_mouse_x) and (komorkiNaPlanszy[i].posX + 60 >= al_mouse_x) and (komorkiNaPlanszy[i].posY <= al_mouse_y) and (komorkiNaPlanszy[i].posY + 60 >= al_mouse_y) then
                    begin
                    klik := i;
                    break;
                    end
                 else
                    klik := 0;
                 end;
           end;
        if al_key[al_KEY_SPACE] <> 0 then klik := 0;
        if klik <> 0 then
           begin
           al_line(buffer,komorkiNaPlanszy[klik].posX+30,komorkiNaPlanszy[klik].posY+30,al_mouse_x,al_mouse_y,al_makecol(1,41,213));
           al_line(buffer,komorkiNaPlanszy[klik].posX+30-1,komorkiNaPlanszy[klik].posY+30-1,al_mouse_x-1,al_mouse_y-1,al_makecol(1,41,213));
           al_line(buffer,komorkiNaPlanszy[klik].posX+30+1,komorkiNaPlanszy[klik].posY+30+1,al_mouse_x+1,al_mouse_y+1,al_makecol(1,41,213));
           end;
        if (bubbleList <> nil) then
           begin
           drawBubble(bubbleList);
           end;
        if (bubbleList <> nil) and ((zlicz mod 16) = 0) then
        begin
             checkBubble(bubbleList);
             updateBubble(bubbleList);
        end;
        updateCells(zlicz);

        al_blit(buffer,al_screen,0,0,0,0,al_SCREEN_W,al_SCREEN_H);
        zlicz := (zlicz+1) mod 100000;
        al_rest(1);
        end;
  al_destroy_bitmap(buffer);
  destroySprites;
  al_exit;
end.
