//procedura w której znajdują się wszystkie rzeczy do inicjalizacji
procedure initAll;
begin
     al_init();
     al_install_keyboard();
     al_install_mouse();
     al_set_color_depth(32);
     randomize;
end;


//aby za każdym uruchomieniem gry nie wybierać rozdzielczosci, delay'u między
//klatkami itd. stworzylem plik tzw. config.
//procedura wczytuje config o ile istnieje
procedure loadCFG;
var tmpString    : string;
var cfg          : text;
var tmpInt       : integer;
var i            : integer;
begin
     assign(cfg,'config.cfg');
     reset(cfg);
     SetLength(configTAB,4); //ilosc linijek w cfg
     i := 1;
     while eof(cfg) = false do
           begin
           readln(cfg,tmpString);
           configTab[i] := strToInt(tmpString);
           i := i+1;
           end;
     close(cfg);
end;

//funkcja która pozwala użytkownikowi dobrać prędkosć animacji
//powinno to być zrobione na timer'ach ale czasu braklo.
function pickDelay1():integer;
var del      : integer;
    zlicz    : integer;
    bufforek : al_BITMAPptr;
begin
     loadSprites;
     del := 30;
     zlicz := 0;
     bufforek := al_create_bitmap(al_SCREEN_W,al_SCREEN_H);
     initCell(1,al_SCREEN_W div 2-30 ,al_SCREEN_H div 2 + 120,random(20)+10,1,random(2),random(16)+1);
     while al_key[AL_KEY_ENTER] = 0 do
        begin
        al_clear_bitmap(bufforek);
        al_textout_centre_ex (bufforek, al_font,'Dostosuj predkosc animacji. #1', al_SCREEN_W DIV 2, (al_SCREEN_H DIV 2), al_makecol (255, 255, 255), -1);
        al_textout_centre_ex (bufforek, al_font,'<- LEFT ARROW - zmniejsza predkosc animacji', al_SCREEN_W DIV 2, (al_SCREEN_H DIV 2) + 20, al_makecol (255, 255, 255), -1);
        al_textout_centre_ex (bufforek, al_font,'-> RIGHT ARROW - zwieksza predkosc animacji', al_SCREEN_W DIV 2, (al_SCREEN_H DIV 2) + 40, al_makecol (255, 255, 255), -1);
        al_textout_centre_ex (bufforek, al_font,'Wcisnij Enter aby kontynuowac', al_SCREEN_W DIV 2, (al_SCREEN_H DIV 2) + 60, al_makecol (255, 255, 255), -1);

        al_draw_sprite(bufforek,spriteRED[komorkiNaPlanszy[1].spriteNr],komorkiNaPlanszy[1].posX,komorkiNaPlanszy[1].posY);
        if (zlicz mod del) = 0 then komorkiNaPlanszy[1].spriteNr := ((komorkiNaPlanszy[1].spriteNr + 1) mod 16) +1; //wrazliwe animacje komorek
        al_textout_centre_ex (bufforek, al_font, intToStr(komorkiNaPlanszy[1].punkty),komorkiNaPlanszy[1].posX + 30,komorkiNaPlanszy[1].posY + 30, al_makecol (255, 255, 255), -1);

        al_blit(bufforek,al_screen,0,0,0,0,al_SCREEN_W,al_SCREEN_H);
        if al_key[AL_KEY_LEFT] <> 0 then del := del + 1;
        if al_key[AL_KEY_RIGHT] <> 0 then del := del - 1;
        if del <= 0 then del := 1;
        zlicz := (zlicz + 1) mod 10000;
        al_rest(1);
        end;
     pickDelay1 := del;
end;

//analogicznie j.w.
//w pewnym momencie przestalo dzialać, kochany pascal
function pickDelay2():integer;
var del        : integer;
    zlicz      : integer;
    bufforek   : al_BITMAPptr;
    pomoc      : pOnBubble;
begin
    al_rest(100);
    del := 2;
    zlicz := 0;
    bufforek := al_create_bitmap(al_SCREEN_W,al_SCREEN_H);
    initCell(1,50 ,al_SCREEN_H div 2 + 120,random(20)+10,1,random(2),random(16)+1);
    initCell(2,200,al_SCREEN_H div 2 + 120,random(20)+10,1,random(2),random(16)+1);
    loadSprites;
    while al_KEY[al_KEY_ENTER] = 0 do
       begin
       al_clear_bitmap(bufforek);
       al_textout_centre_ex (bufforek, al_font,'Dostosuj predkosc animacji. #2', al_SCREEN_W DIV 2, (al_SCREEN_H DIV 2), al_makecol (255, 255, 255), -1);
       al_textout_centre_ex (bufforek, al_font,'<- LEFT ARROW - zmniejsza predkosc animacji', al_SCREEN_W DIV 2, (al_SCREEN_H DIV 2) + 20, al_makecol (255, 255, 255), -1);
       al_textout_centre_ex (bufforek, al_font,'-> RIGHT ARROW - zwieksza predkosc animacji', al_SCREEN_W DIV 2, (al_SCREEN_H DIV 2) + 40, al_makecol (255, 255, 255), -1);
       al_textout_centre_ex (bufforek, al_font,'Wcisnij Enter aby kontynuowac', al_SCREEN_W DIV 2, (al_SCREEN_H DIV 2) + 60, al_makecol (255, 255, 255), -1);
       al_textout_centre_ex (bufforek, al_font,intToStr(del),al_SCREEN_W DIV 2, (al_SCREEN_H DIV 2) + 80, al_makecol(255,255,255),-1);
       if (zlicz mod 300) = 0 then pushFRONTbubble(bubbleList,1,2);
       if (bubbleList <> nil) then
          begin
          pomoc := bubbleList;
          while pomoc <> nil do
                begin
                al_circlefill(bufforek,pomoc^.posX,pomoc^.posY,10,al_makecol(166,5,5));
                al_textout_centre_ex (bufforek, al_font,intToStr(pomoc^.punkty), pomoc^.posX+1,pomoc^.posY-2, al_makecol (255, 255, 255), -1);
                al_circle(bufforek,pomoc^.posX,pomoc^.posY,11,al_makecol(255,255,255));
                al_circle(bufforek,pomoc^.posX,pomoc^.posY,12,al_makecol(255,255,255));
                pomoc := pomoc^.nastepny;
                end;
          end;
       checkBubble(bubbleList);
       if (bubbleList <> nil) and ((zlicz mod del) = 0) then  //wrazliwe na predkosc lecenia babelkow
       begin
            updateBubble(bubbleList,zlicz);
       end;

        al_blit(bufforek,al_screen,0,0,0,0,al_SCREEN_W,al_SCREEN_H);
        if al_key[AL_KEY_LEFT] <> 0 then begin del := del + 1; al_rest(50); end;
        if al_key[AL_KEY_RIGHT] <> 0 then begin del := del - 1; al_rest(50); end;
        if del <= 0 then del := 1;
        zlicz := (zlicz + 1) mod 10000;
        al_rest(1);
       end;
       bubbleList := nil;
    pickDelay2 := del;
end;


//procedura realizuje możliwosć wyboru odpowiedniej rozdzielczosci, jednoczesnie zapisuje ją
//do config'u jeżeli istnieje, jeżeli nie to go tworzy.
procedure pickRes;
var i,circlePoz :integer;
var napis  : string;
    height : array[1..7] of integer = (480,600, 768, 720, 768, 900,1080);
    width  : array[1..7] of integer = (640,800,1024,1280,1366,1600,1920);
    buffor : al_BITMAPptr;
    cfg    : text;
    cfgW   : integer;
    cfgH   : integer;
begin
     if (fsearch('config.cfg','')='') then
        begin
        al_set_gfx_mode (AL_GFX_AUTODETECT, 640, 480, 0, 0);
        buffor := al_create_bitmap(al_SCREEN_W,al_SCREEN_H);
        circlePoz := 20;
        while al_key[AL_KEY_ENTER] = 0 do
        begin
             al_clear_bitmap(buffor);
             napis := '';

             al_textout_centre_ex (buffor, al_font, 'Wybierz rozdzielczosc', al_SCREEN_W DIV 2, al_SCREEN_H DIV 2 - 30, al_makecol (255, 255, 255), -1);
             for i:=1 to 7 do
                 begin
                 napis := intToStr(width[i]) + 'x' + intToStr(height[i]);
                 al_textout_centre_ex (buffor, al_font,napis, al_SCREEN_W DIV 2, (al_SCREEN_H DIV 2) + i*20, al_makecol (255, 255, 255), -1);
                 end;
                 al_circlefill(buffor,al_SCREEN_W DIV 2 - 80, (al_SCREEN_H DIV 2) + circlePoz + 1,5,al_makecol(255,255,255));
                 al_blit(buffor,al_screen,0,0,0,0,al_SCREEN_W,al_SCREEN_H);
                 if (al_key[AL_KEY_UP] <> 0) or (al_key[AL_KEY_W] <> 0) then begin circlePoz := circlePoz - 20; al_rest(200); end;
                 if (al_key[AL_KEY_DOWN] <> 0) or (al_key[AL_KEY_S] <> 0) then begin circlePoz := circlePoz + 20; al_rest(200); end;
                 if circlePoz < 20 then circlePoz := 140;
                 if circlePoz > 140 then circlePoz := 20;
                 al_rest(30);
        end;
        circlePoz := circlePoz div 20;
        if al_set_gfx_mode (AL_GFX_AUTODETECT, width[circlePoz], height[circlePoz], 0, 0) = FALSE then
           begin
           al_message('something went wrong, please pick another resolution!');
           al_exit;
           end;

        al_destroy_bitmap(buffor);
        assign(cfg,'config.cfg');
        rewrite(cfg);
        writeln(cfg,intToStr(width[circlePoz]));
        writeln(cfg,intToStr(height[circlePoz]));
        writeln(cfg,intToStr(pickDelay1()));
        writeln(cfg,intToStr(2));
        //writeln(cfg,intToStr(pickDelay2()));
        close(cfg);
        if width[circlePoz] > 1024 then wspolczynnikRozdzielczosci := 0
        else                            wspolczynnikRozdzielczosci := 1;
        loadCFG();
        end
     else
        begin
        loadCFG();
        if configTab[1] > 1024 then wspolczynnikRozdzielczosci := 0
        else                        wspolczynnikRozdzielczosci := 1;
        al_set_gfx_mode (AL_GFX_AUTODETECT, configTab[1], configTab[2], 0, 0);
        end;
end;
