type latajacyKrwinek = record
posX                 : integer;
posY                 : integer;
dodaj1               : integer;
dodaj2               : integer;
sprite               : al_BITMAPptr;
spriteNr             : integer;
interval             : integer;
end;

procedure menu;
var buffor     : al_BITMAPptr;
    ileKrwinek : integer;
    x          : integer;
    y          : integer;
    cos1       : integer;
    cos2       : integer;
    zlicz      : integer;
    czekaj     : integer;
    tmpString  : string;
    redCells   : array of latajacyKrwinek;
    cellAnim   : array[1..16] of al_BITMAPptr;
begin
  ileKrwinek := 70;
  setlength(redCells,ileKrwinek+1);
  for i:=1 to ileKrwinek do
      begin
      redCells[i].posX := random(al_SCREEN_W-55);
      redCells[i].posY := random(al_SCREEN_H);
      redCells[i].dodaj1 := random(3)+1;
      redCells[i].dodaj2 := random(3)+1;
      redCells[i].spriteNr := random(15)+1;
      redCells[i].interval := 30;
      end;

  for i:=1 to 16 do
      begin
      tmpString := 'bc/cellR' + intToStr(i) + '.pcx';
      cellAnim[i] := al_load_bitmap(tmpString,NIL);
      end;
  buffor := al_create_bitmap(al_SCREEN_W,al_SCREEN_H);
  czekaj := 1;
  zlicz := 0;
  while al_key[AL_KEY_SPACE] = 0 do
  begin
           al_clear_bitmap(buffer);
           for i:=1 to ileKrwinek do al_draw_sprite(buffer,cellAnim[redCells[i].spriteNr],redCells[i].posx,redCells[i].posY);
           for i:=1 to ileKrwinek do begin if zlicz mod redCells[i].interval = 0 then inc(redCells[i].spriteNr); if redCells[i].spriteNr = 16 then redCells[i].spriteNr := 1; end;
           for i:=1 to ileKrwinek do begin redCells[i].posX := redCells[i].posX + redCells[i].dodaj1; redCells[i].posY := redCells[i].posY + redCells[i].dodaj2; end;
           for i:=1 to ileKrwinek do
               begin
                    if redCells[i].posX+55 > AL_SCREEN_W then redcells[i].dodaj1 := (-1)*random(3);
                    if redCells[i].posX < 0 then redcells[i].dodaj1 := random(3);
                    if redCells[i].posY+55 > AL_SCREEN_H then redcells[i].dodaj2 := (-1)*random(3);
                    if redCells[i].posY < 0 then redcells[i].dodaj2 := random(3);
               end;
           al_rest(czekaj);
           al_blit(buffer,al_screen,0,0,0,0,al_SCREEN_W,al_SCREEN_H);
           zlicz := zlicz+1 mod 60;
           if zlicz = 0 then czekaj := random(3);
  end;
end;