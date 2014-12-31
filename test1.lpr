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

{$I NWatStart.pas}
{$I NWmenu.pas}
{$I NWbubbleList}

procedure initCell(ktoraKomorka, X,Y,points,size,id,promien,spriteNr : integer);
var i:integer;
begin
     komorkiNaPlanszy[ktoraKomorka].spriteNr := spriteNr;
     komorkiNaPlanszy[ktoraKomorka].posX := X;
     komorkiNaPlanszy[ktoraKomorka].posY := Y;
     komorkiNaPlanszy[ktoraKomorka].punkty := points;
     komorkiNaPlanszy[ktoraKomorka].rozmiar := size;
     komorkiNaPlanszy[ktoraKomorka].promien := promien;
     komorkiNaPlanszy[ktoraKomorka].ID := id;
end;

procedure drawCell(ktoraKomorka,zlicz: integer);
begin
     if komorkiNaPlanszy[ktoraKomorka].ID = 1 then
        begin
        al_draw_sprite(buffer,spriteBLUE[komorkiNaPlanszy[ktoraKomorka].spriteNr],komorkiNaPlanszy[ktoraKomorka].posX,komorkiNaPlanszy[ktoraKomorka].posY);
        end
     else
        begin
        al_draw_sprite(buffer,spriteRED[komorkiNaPlanszy[ktoraKomorka].spriteNr],komorkiNaPlanszy[ktoraKomorka].posX,komorkiNaPlanszy[ktoraKomorka].posY);
       end;
     if zlicz = 15 then komorkiNaPlanszy[ktoraKomorka].spriteNr := ((komorkiNaPlanszy[ktoraKomorka].spriteNr + 1) mod 16) + 1;
     al_textout_centre_ex (buffer, al_font, intToStr(komorkiNaPlanszy[ktoraKomorka].punkty),komorkiNaPlanszy[ktoraKomorka].posX + 30,komorkiNaPlanszy[ktoraKomorka].posY + 30, al_makecol (255, 255, 255), -1);
end;

procedure gameEngine();
begin
     while al_key[al_KEY_ESC] = 0 do
           begin
           //trolololo
           end;
end;


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



{procedure sendBubble(odd,doo:integer);
var tmpX,destX,destY,incdecX,incdecY:integer;
var pkt,tmpY : integer;
begin
     bubbleCount := bubbleCount + 1;
     //setlength(bubbleTab,bubbleCount);
     bubbleTab[bubbleCount].punkty := komorkiNaPlanszy[odd].punkty div 2;
     if komorkiNaPlanszy[odd].punkty mod 2 <> 0 then komorkiNaPlanszy[odd].punkty := (komorkiNaPlanszy[odd].punkty div 2)+1
     else                                            komorkiNaPlanszy[odd].punkty := (komorkiNaPlanszy[odd].punkty div 2);
     bubbleTab[bubbleCount].toNr := doo;
     bubbleTab[bubbleCount].fromNr := odd;
     bubbleTab[bubbleCount].posX := komorkiNaPlanszy[odd].posX+30;
     bubbleTab[bubbleCount].posY := komorkiNaPlanszy[odd].posY+30;
     bubbleTab[bubbleCount].destX := komorkiNaPlanszy[doo].posX+30;
     bubbleTab[bubbleCount].destY := komorkiNaPlanszy[doo].posY+30;
     if bubbleTab[bubbleCount].destX > bubbleTab[bubbleCount].posX then bubbleTab[bubbleCount].incDecX := 1
                                                                   else bubbleTab[bubbleCount].incDecX := -1;
     if bubbleTab[bubbleCount].destY > bubbleTab[bubbleCount].posY then bubbleTab[bubbleCount].incDecY := 1
                                                                   else bubbleTab[bubbleCount].incDecY := -1;

     while (bubbleTab[bubbleCount].posX <> bubbleTab[bubbleCount].destX) and (bubbleTab[bubbleCount].posY <> bubbleTab[bubbleCount].destY) do
           begin
           al_circle(al_screen,bubbleTab[bubbleCount].posX,bubbleTab[bubbleCount].posY,5,al_makecol(1,41,213));
           bubbleTab[bubbleCount].posX := bubbleTab[bubbleCount].posX + bubbleTab[bubbleCount].incDecX;
           bubbleTab[bubbleCount].posY := (komorkiNaPlanszy[bubbleTab[bubbleCount].toNr].posY+30) - (komorkiNaPlanszy[bubbleTab[bubbleCount].fromNr].posY+30);
           bubbleTab[bubbleCount].posY := bubbleTab[bubbleCount].posY * (bubbleTab[bubbleCount].posX - (komorkiNaPlanszy[bubbleTab[bubbleCount].fromNr].posX+30));
           bubbleTab[bubbleCount].posY := bubbleTab[bubbleCount].posY div ((komorkiNaPlanszy[bubbleTab[bubbleCount].toNr].posX+30) - (komorkiNaPlanszy[bubbleTab[bubbleCount].fromNr].posX+30));
           bubbleTab[bubbleCount].posY := bubbleTab[bubbleCount].posY + komorkiNaPlanszy[bubbleTab[bubbleCount].fromNr].posY + 30;
           al_rest(10);
           end;

           if komorkiNaPlanszy[bubbleTab[bubbleCount].fromNr].ID <> komorkiNaPlanszy[bubbleTab[bubbleCount].toNr].ID then komorkiNaPlanszy[bubbleTab[bubbleCount].toNr].punkty := komorkiNaPlanszy[bubbleTab[bubbleCount].toNr].punkty - bubbleTab[bubbleCount].punkty
                                                                   else komorkiNaPlanszy[bubbleTab[bubbleCount].toNr].punkty := komorkiNaPlanszy[bubbleTab[bubbleCount].toNr].punkty + bubbleTab[bubbleCount].punkty;
           if komorkiNaPlanszy[bubbleTab[bubbleCount].toNr].punkty < 0 then begin komorkiNaPlanszy[bubbleTab[bubbleCount].toNr].ID := 1-komorkiNaPlanszy[bubbleTab[bubbleCount].toNr].ID; komorkiNaPlanszy[bubbleTab[bubbleCount].toNr].punkty := (-1)*(komorkiNaPlanszy[bubbleTab[bubbleCount].toNr].punkty); end;
end;
}

var ilosc :integer;
var klik  :integer;
var zlicz :integer;
var flaga :integer;

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
  //Setlength(bubbleTab,256);                           //j.w


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

        al_blit(buffer,al_screen,0,0,0,0,al_SCREEN_W,al_SCREEN_H);
        zlicz := (zlicz+1) mod 16;
        al_rest(1);
        end;
  al_destroy_bitmap(buffer);
  destroySprites;
  al_exit;
end.
