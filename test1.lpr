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

{$I NWsprites.pas}
{$I NWcells.pas}
{$I NWbubbleList.pas}
{$I NWatStart.pas}
{$I NWmenu.pas}


function doSpacji(var tekst:string):string;
var i : integer;
var tmpString : string;
begin
  i := 1;
  tmpString := tekst;
  while(tekst[i] <> ' ') and (i <= length(tekst)) do i:=i+1;
  tmpString := copy(tekst,1,i-1);
  tekst := copy(tekst,i+1,length(tekst));
  doSpacji := tmpString;
end;



procedure loadLevel(levelFile:string);
var level     : text;
    tmpString : string;
    i         : integer;
    X,Y,P,S,ID: integer;
begin
     i := 1;
     tmpString := 'lvl/'+levelFile;
     writeln(tmpString);
     assign(level,tmpString);
     reset(level);

     while eof(level) = false do
           begin
           readln(level,tmpString);
           X  := strToInt(doSpacji(tmpString));
           Y  := strToInt(doSpacji(tmpString));
           P  := strToInt(doSpacji(tmpString));
           S  := strToInt(doSpacji(tmpString));
           ID := strToInt(doSpacji(tmpString));
           initCell(i,X,Y,P,S,ID,random(16)+1);
           i := i+1;
           end;
     ilosc := i-1;
     close(level);
end;


procedure playLevel;
var i,j   : integer;
var klik  : integer;
begin
  klik := 0;
  while (al_key[AL_KEY_ESC] = 0) and (ifEnd() = 0) do
        begin
        al_clear_bitmap(buffer);
        for i:=1 to ilosc do drawCell(i,zlicz); //tu trzeba potem poprawic
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
                 if (komorkiNaPlanszy[i].posX <= al_mouse_x) and (komorkiNaPlanszy[i].posX + 60 >= al_mouse_x) and (komorkiNaPlanszy[i].posY <= al_mouse_y) and (komorkiNaPlanszy[i].posY + 60 >= al_mouse_y) and (komorkiNaPlanszy[i].ID = 0) then
                    begin
                    klik := i;
                    break;
                    end
                 else
                    klik := 0;
                 end;
           end;
        if al_key[al_KEY_SPACE] <> 0 then klik := 0;
        if (al_key[al_KEY_a] <> 0) then
           begin
           klik := 0;
           for i:= 1 to ilosc do
                 begin
                 if komorkiNaPlanszy[i].ID = 0 then
                    begin
                    if komorkiNaPlanszy[i].rozmiar < 3 then
                       begin
                       al_line(buffer,komorkiNaPlanszy[i].posX+30,komorkiNaPlanszy[i].posY+30,al_mouse_x,al_mouse_y,al_makecol(1,41,213));
                       al_line(buffer,komorkiNaPlanszy[i].posX+30-1,komorkiNaPlanszy[i].posY+30-1,al_mouse_x-1,al_mouse_y-1,al_makecol(1,41,213));
                       al_line(buffer,komorkiNaPlanszy[i].posX+30+1,komorkiNaPlanszy[i].posY+30+1,al_mouse_x+1,al_mouse_y+1,al_makecol(1,41,213));
                       end
                    else
                       begin
                       al_line(buffer,komorkiNaPlanszy[i].posX+45,komorkiNaPlanszy[i].posY+45,al_mouse_x,al_mouse_y,al_makecol(1,41,213));
                       al_line(buffer,komorkiNaPlanszy[i].posX+45-1,komorkiNaPlanszy[i].posY+45-1,al_mouse_x-1,al_mouse_y-1,al_makecol(1,41,213));
                       al_line(buffer,komorkiNaPlanszy[i].posX+45+1,komorkiNaPlanszy[i].posY+45+1,al_mouse_x+1,al_mouse_y+1,al_makecol(1,41,213));
                       end;
                    end;
                 end;
           if (al_mouse_b AND 1) <> 0 then
              begin
              for j:=1 to ilosc do
                  if (komorkiNaPlanszy[j].posX <= al_mouse_x) and (komorkiNaPlanszy[j].posX + 60 >= al_mouse_x) and (komorkiNaPlanszy[j].posY <= al_mouse_y) and (komorkiNaPlanszy[j].posY + 60 >= al_mouse_y) then
                     begin
                     for i:=1 to ilosc do
                        begin
                        if komorkiNaPlanszy[i].ID = 0 then pushFrontBubble(bubbleList,i,j);
                        end;
                     end;
              al_rest(50);
              end;
           end;

        for i:= 1 to ilosc do
                 begin
                 if (komorkiNaPlanszy[i].ID = 0) and (komorkiNaPlanszy[i].rmbc <> 0) then
                    begin
                    if komorkiNaPlanszy[i].rozmiar < 3 then
                       begin
                       al_line(buffer,komorkiNaPlanszy[i].posX+30,komorkiNaPlanszy[i].posY+30,al_mouse_x,al_mouse_y,al_makecol(1,41,213));
                       al_line(buffer,komorkiNaPlanszy[i].posX+30-1,komorkiNaPlanszy[i].posY+30-1,al_mouse_x-1,al_mouse_y-1,al_makecol(1,41,213));
                       al_line(buffer,komorkiNaPlanszy[i].posX+30+1,komorkiNaPlanszy[i].posY+30+1,al_mouse_x+1,al_mouse_y+1,al_makecol(1,41,213));
                       end
                    else
                       begin
                       al_line(buffer,komorkiNaPlanszy[i].posX+45,komorkiNaPlanszy[i].posY+45,al_mouse_x,al_mouse_y,al_makecol(1,41,213));
                       al_line(buffer,komorkiNaPlanszy[i].posX+45-1,komorkiNaPlanszy[i].posY+45-1,al_mouse_x-1,al_mouse_y-1,al_makecol(1,41,213));
                       al_line(buffer,komorkiNaPlanszy[i].posX+45+1,komorkiNaPlanszy[i].posY+45+1,al_mouse_x+1,al_mouse_y+1,al_makecol(1,41,213));
                       end;
                    end;
                 end;
           if (al_mouse_b AND 2) <> 0 then
                 begin
                 for j:=1 to ilosc do
                  if (komorkiNaPlanszy[j].posX <= al_mouse_x) and (komorkiNaPlanszy[j].posX + 60 >= al_mouse_x) and (komorkiNaPlanszy[j].posY <= al_mouse_y) and (komorkiNaPlanszy[j].posY + 60 >= al_mouse_y) and (komorkiNaPlanszy[j].ID = 0) then
                     begin
                     komorkiNaPlanszy[j].rmbc:= 1;
                     end;
                 end;
           if (al_mouse_b AND 1) <> 0 then
                 begin
                 for j:=1 to ilosc do
                  if (komorkiNaPlanszy[j].posX <= al_mouse_x) and (komorkiNaPlanszy[j].posX + 60 >= al_mouse_x) and (komorkiNaPlanszy[j].posY <= al_mouse_y) and (komorkiNaPlanszy[j].posY + 60 >= al_mouse_y) and (komorkiNaPlanszy[j].ID <> 0) then
                     begin
                     for i:=1 to ilosc do
                       begin
                       if komorkiNaPlanszy[i].rmbc <> 0 then pushFRONTbubble(bubbleList,i,j);
                       komorkiNaPlanszy[i].rmbc := 0;
                       end;
                     end;
                 end;


        if klik <> 0 then
           begin
           if komorkiNaPlanszy[klik].rozmiar < 3 then
                       begin
                       al_line(buffer,komorkiNaPlanszy[klik].posX+30,komorkiNaPlanszy[klik].posY+30,al_mouse_x,al_mouse_y,al_makecol(1,41,213));
                       al_line(buffer,komorkiNaPlanszy[klik].posX+30-1,komorkiNaPlanszy[klik].posY+30-1,al_mouse_x-1,al_mouse_y-1,al_makecol(1,41,213));
                       al_line(buffer,komorkiNaPlanszy[klik].posX+30+1,komorkiNaPlanszy[klik].posY+30+1,al_mouse_x+1,al_mouse_y+1,al_makecol(1,41,213));
                       end
                    else
                       begin
                       al_line(buffer,komorkiNaPlanszy[klik].posX+45,komorkiNaPlanszy[klik].posY+45,al_mouse_x,al_mouse_y,al_makecol(1,41,213));
                       al_line(buffer,komorkiNaPlanszy[klik].posX+45-1,komorkiNaPlanszy[klik].posY+45-1,al_mouse_x-1,al_mouse_y-1,al_makecol(1,41,213));
                       al_line(buffer,komorkiNaPlanszy[klik].posX+45+1,komorkiNaPlanszy[klik].posY+45+1,al_mouse_x+1,al_mouse_y+1,al_makecol(1,41,213));
                       end;
           end;
        if (bubbleList <> nil) then drawBubble(bubbleList);
        checkBubble(bubbleList);
        if (bubbleList <> nil) and ((zlicz mod configTAB[4]) = 0) then  //wrazliwe na predkosc lecenia babelkow
        begin
             updateBubble(bubbleList,zlicz);
        end;
        updateCells(zlicz);

        al_blit(buffer,al_screen,0,0,0,0,al_SCREEN_W,al_SCREEN_H);
        zlicz := (zlicz+1) mod 100000;
        al_rest(1);
        end;
  bubbleList := nil;
end;



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

  buffer := al_create_bitmap(al_SCREEN_W,al_SCREEN_H);
  al_clear_bitmap(buffer);

  //for i:= 1 to 7 do initCell(i,random(al_SCREEN_W-110)+55,random(al_SCREEN_H-110)+55,random(20)+10,1,random(3),random(16)+1); //ktoraKomorka, X,Y,points,size,id,promien
  //for i:= 8 to 10 do initCell(i,random(al_SCREEN_W-110)+55,random(al_SCREEN_H-110)+55,random(20)+10,3,random(3),random(16)+1); //ktoraKomorka, X,Y,points,size,id,promien
  loadLevel('1.lvl');
  playLevel();

  loadLevel('2.lvl');
  playLevel();

  al_destroy_bitmap(buffer);
  destroySprites;
  al_exit;
end.
