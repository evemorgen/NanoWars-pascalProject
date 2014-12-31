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
     if (zlicz mod 30) = 0 then komorkiNaPlanszy[ktoraKomorka].spriteNr := ((komorkiNaPlanszy[ktoraKomorka].spriteNr + 1) mod 16) + 1;
     al_textout_centre_ex (buffer, al_font, intToStr(komorkiNaPlanszy[ktoraKomorka].punkty),komorkiNaPlanszy[ktoraKomorka].posX + 30,komorkiNaPlanszy[ktoraKomorka].posY + 30, al_makecol (255, 255, 255), -1);
end;

procedure updateCells(dt : integer);
var i : integer;
begin
     if (dt mod 500) = 0 then
        begin
        for i:= 1 to ilosc do
            begin
            komorkiNaPlanszy[i].punkty := komorkiNaPlanszy[i].punkty + komorkiNaPlanszy[i].rozmiar;
            end;
        end
end;
