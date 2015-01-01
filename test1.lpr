program test1;

uses dos, crt, allegro, sysutils;




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

{$I NWsprites.pas}
{$I NWcells.pas}
{$I NWatStart.pas}
{$I NWmenu.pas}
{$I NWbubbleList.pas}

begin
  initAll();

  Setlength(komorkiNaPlanszy,256);                    //brzydkie rozwiązanie ale dziala :D

  pickRes();
  //menu();
  ilosc := 10;
  klik := 0;
  zlicz := 0;
  bubbleCount := 0;
  loadSprites;

  buffer := al_create_bitmap(al_SCREEN_W,al_SCREEN_H);
  al_clear_bitmap(buffer);

  for i:= 1 to ilosc do initCell(i,random(al_SCREEN_W-110)+55,random(al_SCREEN_H-110)+55,random(20)+10,1,random(2),20,random(16)+1); //ktoraKomorka, X,Y,points,size,id,promien
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
        checkBubble(bubbleList);
        if (bubbleList <> nil) and ((zlicz mod 5) = 0) then  //wrazliwe na predkosc lecenia babelkow
        begin
             updateBubble(bubbleList,zlicz);
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
