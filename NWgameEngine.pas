procedure wygrana();    //procedura wypisująca komunikat o wygranej
begin
  al_rest(100);
  al_clear_bitmap(al_screen);
  while (al_key[al_key_ENTER] = 0) and (al_key[al_KEY_q] = 0) and (al_key[al_KEY_Q] = 0) do
        begin
        al_textout_centre_ex (al_screen, al_font,'Brawo! Wygrales lamusie. Teraz nie bedzie tak latwo.', al_screen_W div 2, al_screen_H div 2, al_makecol (255, 255, 255), -1);
        al_textout_centre_ex (al_screen, al_font,'wcisnij enter aby kontynuowac.', al_screen_W div 2, al_screen_H div 2 + 20, al_makecol (255, 255, 255), -1);
        end;
end;

procedure przegrana();  //procedura wypisująca komunikat o przegranej
begin
  al_clear_bitmap(al_screen);
  while (al_key[al_key_ENTER] = 0) and (al_key[al_KEY_q] = 0) and (al_key[al_KEY_Q] = 0) do
        begin
        al_textout_centre_ex (al_screen, al_font,'Lamus. Nie martw sie, nastepnym razem bedzie lepiej. Moze.', al_screen_W div 2, al_screen_H div 2, al_makecol (255, 255, 255), -1);
        al_textout_centre_ex (al_screen, al_font,'wcisnij enter aby kontynuowac.', al_screen_W div 2, al_screen_H div 2 + 20, al_makecol (255, 255, 255), -1);
        end;
end;

procedure beforeStartLVL(lvlNr : integer);  //plansza przed poziomem z ambitnym tekstem.
var doWyswietlenia : string;
var bufforek       : al_BITMAPptr;
var nazwy          : array of string;
begin
  Setlength(nazwy,6);
  nazwy[1] := 'Here journey begins';
  nazwy[2] := 'Learning fast, huh?';
  nazwy[3] := 'That was easy. Wasnt it?';
  nazwy[4] := 'Circles, circles everywhere';
  nazwy[5] := 'utlimate FUCKING HARD challenge.';
  bufforek := al_create_bitmap(al_SCREEN_W,al_SCREEN_H);
  al_clear_bitmap(bufforek);
  doWyswietlenia := 'Stage ' + intToStr(lvlNr) + '. ' + nazwy[lvlNr];
  while al_key[al_KEY_ENTER] = 0 do
        begin
        al_textout_centre_ex (bufforek, al_font,doWyswietlenia, al_screen_W div 2, al_screen_H div 2, al_makecol (255, 255, 255), -1);
        al_textout_centre_ex (bufforek, al_font,'enter', al_screen_W div 2, al_screen_H div 2 + 20, al_makecol (255, 255, 255), -1);

        al_blit(bufforek,al_screen,0,0,0,0,al_SCREEN_W,al_SCREEN_H);
        end;
end;

procedure levelEditor(); //procedura pozwalająca graczowi na tworzenie wlasnych leveli
var levelName : string;
    znak      : integer;
    bufforek  : al_BITMAPptr;
    level     : text;
    i,j       : integer;
    ilosc     : integer;
    zlicz     : integer;
    stala     : integer;
begin
  al_rest(100);
  ilosc := 0;
  zlicz := 0;
  stala := 100;
  levelName := '';
  bufforek := al_create_bitmap(al_SCREEN_W,al_SCREEN_H);
  while al_key[al_KEY_ENTER] = 0 do                     //modul obslugujący wczytywanie nazwy dla lvlu
        begin
        al_clear_bitmap(bufforek);
        al_textout_centre_ex (bufforek, al_font,'wpisz nazwe swojego lvlu', al_SCREEN_W DIV 2, (al_SCREEN_H DIV 2), al_makecol (255, 255, 255), -1);
        al_textout_centre_ex (bufforek, al_font,'zatwierdz klawiszem ENTER', al_SCREEN_W DIV 2, (al_SCREEN_H DIV 2)+20, al_makecol (255, 255, 255), -1);
        al_textout_centre_ex (bufforek, al_font,levelName, al_SCREEN_W DIV 2, (al_SCREEN_H DIV 2)+40, al_makecol (255, 255, 255), -1);
        al_blit(bufforek,al_screen,0,0,0,0,al_SCREEN_W,al_SCREEN_H);
        znak := al_readkey();
        if znak = 16136 then levelName := copy(levelName,0,length(levelName)-1)
        else levelName := levelName + char(znak);
        end;
  levelName := 'lvl\' + copy(levelName,0,length(levelName)-1) + '.lvl';
  assign(level,levelName);                              //Otwieram plik dla poziomu
  rewrite(level);

  initCell(1,al_SCREEN_W-120,60+stala,10,1,0,random(16)+1);        //komórki z boku do przeciągania
  initCell(2,al_SCREEN_W-120,120+stala,10,3,0,random(16)+1);
  initCell(3,al_SCREEN_W-120,210+stala,10,1,1,random(16)+1);
  initCell(4,al_SCREEN_W-120,270+stala,10,3,1,random(16)+1);
  initCell(5,al_SCREEN_W-120,360+stala,10,1,2,random(16)+1);
  initCell(6,al_SCREEN_W-120,420+stala,10,3,2,random(16)+1);
  al_rest(100);

  while (al_key[al_KEY_ENTER] = 0) do                       //gdy gracz wcisnie enter kończymy pracę z edytorem
        begin
        al_clear_bitmap(buffer);
        al_textout_centre_ex (buffer, al_font,'Nacisnij na komorke z prawej strony ekranu,', al_SCREEN_W DIV 2, 20, al_makecol (255, 255, 255), -1);
        al_textout_centre_ex (buffer, al_font,'nastepnie przeciagnij ja we wlasciwe miejsce', al_SCREEN_W DIV 2, 40, al_makecol (255, 255, 255), -1);
        al_textout_centre_ex (buffer, al_font,'aby zatwierdzic pozycje nacisnij spacje.', al_SCREEN_W DIV 2, 60, al_makecol (255, 255, 255), -1);
        al_textout_centre_ex (buffer, al_font,'ABY ZAKOŃCZYĆ PRACĘ Z EDYTOREM NACIŚNIJ ENTER', al_SCREEN_W DIV 2, 80, al_makecol (255, 255, 255), -1);


        for i := 1 to ilosc + 6 do
            drawCell(i,zlicz);
        for i := 1 to ilosc+6 do
               begin
               //ten dlugawy if sprawdza czy wcisnieto LKM i czy kursor znajduje się na którejs komorce
               if ((al_mouse_b AND 1) <> 0) and (al_mouse_x >= komorkiNaPlanszy[i].posX) and (al_mouse_x <= komorkiNaPlanszy[i].posX + 60) and (al_mouse_y >= komorkiNaPlanszy[i].posY) and (al_mouse_y <= komorkiNaPlanszy[i].posY + 60) then
                  begin
                  ilosc := ilosc + 1;
                  initCell(ilosc+6,al_mouse_x,al_mouse_y,10,komorkiNaPlanszy[i].rozmiar,komorkiNaPlanszy[i].ID,random(16)+1);
                  al_rest(100);
                  while (al_key[al_KEY_SPACE] = 0) do //dopóki nie wcisnieto spacji to komórka jest przypięta do myszki
                        begin
                        al_clear_bitmap(buffer);
                        for j := 1 to ilosc + 6 do
                            begin drawCell(j,zlicz); end;
                        komorkiNaPlanszy[ilosc+6].posX := al_mouse_x;
                        komorkiNaPlanszy[ilosc+6].posY := al_mouse_y;
                        zlicz := (zlicz + 1) mod 10000;
                        al_show_mouse(buffer);
                        al_blit(buffer,al_screen,0,0,0,0,al_SCREEN_W,al_SCREEN_H);
                        al_rest(1);
                        end;
                  end;
               end;
        zlicz := (zlicz + 1) mod 10000;
        al_show_mouse(buffer);
        al_blit(buffer,al_screen,0,0,0,0,al_SCREEN_W,al_SCREEN_H);
        al_rest(1);
        end;
  for i:= 7 to ilosc+6 do
      begin
      write(level,komorkiNaPlanszy[i].posX,' ',komorkiNaPlanszy[i].posY,' ',komorkiNaPlanszy[i].punkty,' ',komorkiNaPlanszy[i].rozmiar,' ',komorkiNaPlanszy[i].ID);
      if i <> ilosc+6 then writeln(level);
      end;
  close(level);
  al_rest(100);
end;


function doSpacji(var tekst:string):string; //funkcja pomocnicza sprawdzająca gdzie jest spacja. I zwracająca caly tekst do spacji
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

procedure loadLevel(levelFile:string); //procedura wczytująca poziom z pliku
var level     : text;
    tmpString : string;
    i         : integer;
    X,Y,P,S,ID: integer;
begin
     i := 1;
     if pos('.lvl',levelFile) = 0 then levelFile := levelFile + '.' + 'lvl';
     tmpString := 'lvl/'+levelFile;
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


function playLevel(): integer;                 //glowna pętla gry tak naprawdę, zbyt zawile by tlumaczyć
var i,j   : integer;
    klik  : integer;
    czyKon: integer;
begin
  klik := 0;
  czyKon := 0;
  AIinit(); //inicjalizacja AI
  while (al_key[AL_KEY_ESC] = 0) and (czyKon = 0) and (al_key[al_KEY_q] = 0) and (al_key[al_KEY_Q] = 0) do
        begin
        al_clear_bitmap(buffer);
        for i:=1 to ilosc do drawCell(i,zlicz); //tu trzeba potem poprawic
        al_draw_sprite(buffer,cursor,al_mouse_x,al_mouse_y); //nad tym trzeba pomysleć
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

        /////////////////////////////////////
        //                                 //
        //     TU JEST MIEJSCE DLA AI      //
        //                                 //
        /////////////////////////////////////
        if (AIexpandeRandomALL(zlicz) = 0) or (random(1000) < 100) then
           if random(2000) = 339 then begin for i:=1 to 15 do AImassiveMssacre() end
           else AIsendRandomALL(zlicz);
        AIwatchDog(zlicz);

        /////////////////////////////////////
        //                                 //
        //     TU JUŻ NIE                  //
        //                                 //
        /////////////////////////////////////

        if (bubbleList <> nil) then drawBubble(bubbleList);
        checkBubble(bubbleList);
        if (bubbleList <> nil) and ((zlicz mod configTAB[4]) = 0) then  //wrazliwe na predkosc lecenia babelkow
        begin
             updateBubble(bubbleList,zlicz);
        end;
        updateCells(zlicz);
        al_textout_ex(buffer, al_font,'wcisnij Q aby uciekac!',10,10, al_makecol (255, 255, 255), -1);
        al_blit(buffer,al_screen,0,0,0,0,al_SCREEN_W,al_SCREEN_H);
        zlicz := (zlicz+1) mod 100000;
        al_rest(1);
        czyKon := ifEnd();
        if (al_key[al_KEY_q] <> 0) or (al_key[al_KEY_Q] <> 0) then playLevel := 0;
        end;
  bubbleList := nil;       //będzie leak pamieci, no trudno..
  playLevel := czyKon;
end;


procedure wczytajLvlZklawiatury(); //procedura pozwalająca graczowi wczytanie lvlu o dowolnej nazwie
var bufforek : al_BITMAPptr;
    levelName: string[30];
    drugiStr : string[30];
    znak : integer;
begin
   bufforek := al_create_bitmap(al_SCREEN_W,al_SCREEN_H);
   levelName := '';
   while al_key[al_KEY_ENTER] = 0 do
        begin
        al_clear_bitmap(bufforek);
        al_textout_centre_ex (bufforek, al_font,'wpisz nazwe swojego lvlu', al_SCREEN_W DIV 2, (al_SCREEN_H DIV 2), al_makecol (255, 255, 255), -1);
        al_textout_centre_ex (bufforek, al_font,'zatwierdz klawiszem ENTER', al_SCREEN_W DIV 2, (al_SCREEN_H DIV 2)+20, al_makecol (255, 255, 255), -1);
        al_textout_centre_ex (bufforek, al_font,levelName, al_SCREEN_W DIV 2, (al_SCREEN_H DIV 2)+40, al_makecol (255, 255, 255), -1);
        al_blit(bufforek,al_screen,0,0,0,0,al_SCREEN_W,al_SCREEN_H);
        znak := al_readkey();
        if znak = 16136 then levelName := copy(levelName,0,length(levelName)-1)
                        else levelName := levelName + char(znak);
        end;
   levelName := copy(levelName,1,length(levelName)-1);
   loadLevel(levelName);
   playLevel();
end;

