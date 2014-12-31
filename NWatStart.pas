procedure initAll;
begin
     al_init();
     al_install_keyboard();
     al_install_mouse();
     al_set_color_depth(16);
     randomize;
end;


procedure loadCFG;
var tmpString    : string;
var cfg          : text;
var i            : integer;
var tmpInt       : integer;
begin
     assign(cfg,'config.cfg');
     reset(cfg);
     i := 1;
     SetLength(configTAB,2);
     while eof(cfg) = false do
           begin
           readln(cfg,tmpString);
           configTab[i] := strToInt(tmpString);
           i := i+1;
           SetLength(configTab,i+1);
           end;
     close(cfg);
end;

procedure makeCFG; //rozdzielczosc wybrana przez gracza, audio, zmiana klawiszy (?)
var cfg    : text;
begin
     assign(cfg,'config.cfg');
     append(cfg);

     close(cfg);
end;

procedure pickRes;
var i,circlePoz :integer;
var napis  : string;
var height : array[1..7] of integer = (480,600, 768, 720, 768, 900,1080);
var width  : array[1..7] of integer = (640,800,1024,1280,1366,1600,1920);
var buffor : al_BITMAPptr;
var cfg    : text;
var cfgW   : integer;
var cfgH   : integer;
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

             al_textout_centre_ex (buffor, al_font, 'Wybierz rozdzielczoœæ', al_SCREEN_W DIV 2, al_SCREEN_H DIV 2 - 30, al_makecol (255, 255, 255), -1);
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
        close(cfg);
        makeCFG;
        if width[circlePoz] > 1024 then wspolczynnikRozdzielczosci := 0
        else                            wspolczynnikRozdzielczosci := 1;
        end
     else
        begin
        loadCFG();
        if configTab[1] > 1024 then wspolczynnikRozdzielczosci := 0
        else                        wspolczynnikRozdzielczosci := 1;
        al_set_gfx_mode (AL_GFX_AUTODETECT, configTab[1], configTab[2], 0, 0);
        end;
     buffer := al_create_bitmap(al_SCREEN_W,al_SCREEN_H);
     al_clear_bitmap(buffer);


end;
