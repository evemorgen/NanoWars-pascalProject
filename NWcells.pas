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

procedure drawCell(ktoraKomorka,dt: integer);
begin
     if komorkiNaPlanszy[ktoraKomorka].ID = 1 then
        begin
        al_draw_sprite(buffer,spriteBLUE[komorkiNaPlanszy[ktoraKomorka].spriteNr],komorkiNaPlanszy[ktoraKomorka].posX,komorkiNaPlanszy[ktoraKomorka].posY);
        end
     else
        begin
        al_draw_sprite(buffer,spriteRED[komorkiNaPlanszy[ktoraKomorka].spriteNr],komorkiNaPlanszy[ktoraKomorka].posX,komorkiNaPlanszy[ktoraKomorka].posY);
       end;
     if (dt mod configTAB[3]) = 0 then komorkiNaPlanszy[ktoraKomorka].spriteNr := ((komorkiNaPlanszy[ktoraKomorka].spriteNr + 1) mod 16) +1; //wrazliwe animacje komorek
     al_textout_centre_ex (buffer, al_font, intToStr(komorkiNaPlanszy[ktoraKomorka].punkty),komorkiNaPlanszy[ktoraKomorka].posX + 30,komorkiNaPlanszy[ktoraKomorka].posY + 30, al_makecol (255, 255, 255), -1);
end;

procedure updateCells(dt : integer);
var i : integer;
begin
     if (dt mod 300) = 0 then //wrazliwe zwiekszanie szybkosci rosniecia babelkow
        begin
        for i:= 1 to ilosc do
            begin
            komorkiNaPlanszy[i].punkty := komorkiNaPlanszy[i].punkty + komorkiNaPlanszy[i].rozmiar;
            end;
        end
end;


function ifEnd():integer;
var good  : integer;
    badd  : integer;
    i     : integer;
begin
     good := 0;
     badd := 0;
     for i:=1 to ilosc  do
           begin
           if komorkiNaPlanszy[i].ID = 1 then good := good + 1;
           if komorkiNaPlanszy[i].ID = 0 then badd := badd + 1;
           end;
     if (good =  0) and (badd <> 0) then ifEnd := (-1)*badd;
     if (good <> 0) and (badd =  0) then ifEnd := good;
     if (good <> 0) and (badd <> 0) then ifEnd := 0;
end;
