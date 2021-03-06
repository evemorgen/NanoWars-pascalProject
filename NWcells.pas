type
komorka = record
posX      : integer;  //pozycja w x
posY      : integer;  //pozycja w y
punkty    : integer;  //ilosc punktow ktorymi komorka moze strzelac
rozmiar   : integer;  //wielkosć komórki, rozróżniamy 3 wielkosci, im większa komorka tym szybciej produkuje points'y
promien   : integer;  //do kasacji
ID        : integer;  //numerek okreslajacy do kogo nalezy komorka - 0 gracz,1 AI, 2 neutralna;
spriteNr  : integer;  //numer obrazka do wyswietlenia
rmbc      : integer;  //flaga okreslajaca czy prawy przycisk myszy byl klikniety na komorce
ios       : integer;  //interval of shooting - zmienna okreslajaca co ile dana komorka AI moze strzelac
end;

var komorkiNaPlanszy : array of komorka; //tablica dynamiczna o zmiennej dlugosci trzymająca wszystkie komórki występujące na planszy


//funkcja inicjalizująca jedną komórkę.
procedure initCell(ktoraKomorka, X,Y,points,size,id,spriteNr : integer);
var i:integer;
begin
     komorkiNaPlanszy[ktoraKomorka].spriteNr := spriteNr;
     komorkiNaPlanszy[ktoraKomorka].posX := X;
     komorkiNaPlanszy[ktoraKomorka].posY := Y;
     komorkiNaPlanszy[ktoraKomorka].punkty := points;
     komorkiNaPlanszy[ktoraKomorka].rozmiar := size;
     komorkiNaPlanszy[ktoraKomorka].ID := id;
     komorkiNaPlanszy[ktoraKomorka].rmbc := 0;
end;


//po prostu rysowanie komórek.
procedure drawCell(ktoraKomorka,dt: integer);
begin
     if komorkiNaPlanszy[ktoraKomorka].ID = 1 then
        if komorkiNaPlanszy[ktoraKomorka].Rozmiar = 1 then al_draw_sprite(buffer,spriteBLUE[komorkiNaPlanszy[ktoraKomorka].spriteNr],komorkiNaPlanszy[ktoraKomorka].posX,komorkiNaPlanszy[ktoraKomorka].posY)
                                                      else al_masked_stretch_blit(spriteBLUE[komorkiNaPlanszy[ktoraKomorka].spriteNr],buffer,0,0,60,60,komorkiNaPlanszy[ktoraKomorka].posX,komorkiNaPlanszy[ktoraKomorka].posY,90,90);
     if komorkiNaPlanszy[ktoraKomorka].ID = 0 then
        if komorkiNaPlanszy[ktoraKomorka].Rozmiar = 1 then al_draw_sprite(buffer,spriteRED[komorkiNaPlanszy[ktoraKomorka].spriteNr],komorkiNaPlanszy[ktoraKomorka].posX,komorkiNaPlanszy[ktoraKomorka].posY)
                                                      else al_masked_stretch_blit(spriteRED[komorkiNaPlanszy[ktoraKomorka].spriteNr],buffer,0,0,60,60,komorkiNaPlanszy[ktoraKomorka].posX,komorkiNaPlanszy[ktoraKomorka].posY,90,90);
    if komorkiNaPlanszy[ktoraKomorka].ID = 2 then
        if komorkiNaPlanszy[ktoraKomorka].Rozmiar = 1 then al_draw_sprite(buffer,spriteWHITE[komorkiNaPlanszy[ktoraKomorka].spriteNr],komorkiNaPlanszy[ktoraKomorka].posX,komorkiNaPlanszy[ktoraKomorka].posY)
                                                      else al_masked_stretch_blit(spriteWHITE[komorkiNaPlanszy[ktoraKomorka].spriteNr],buffer,0,0,60,60,komorkiNaPlanszy[ktoraKomorka].posX,komorkiNaPlanszy[ktoraKomorka].posY,90,90);

     if (dt mod configTAB[3]) = 0 then komorkiNaPlanszy[ktoraKomorka].spriteNr := ((komorkiNaPlanszy[ktoraKomorka].spriteNr + 1) mod 16) +1; //wrazliwe animacje komorek
     if komorkiNaPlanszy[ktoraKomorka].ID <> 2 then
        if komorkiNaPlanszy[ktoraKomorka].rozmiar < 3 then al_textout_centre_ex (buffer, al_font, intToStr(komorkiNaPlanszy[ktoraKomorka].punkty),komorkiNaPlanszy[ktoraKomorka].posX + 30,komorkiNaPlanszy[ktoraKomorka].posY + 30, al_makecol (255, 255, 255), -1)
                                                      else al_textout_centre_ex (buffer, al_font, intToStr(komorkiNaPlanszy[ktoraKomorka].punkty),komorkiNaPlanszy[ktoraKomorka].posX + 45,komorkiNaPlanszy[ktoraKomorka].posY + 45, al_makecol (255, 255, 255), -1)
     else
        if komorkiNaPlanszy[ktoraKomorka].rozmiar < 3 then al_textout_centre_ex (buffer, al_font, intToStr(komorkiNaPlanszy[ktoraKomorka].punkty),komorkiNaPlanszy[ktoraKomorka].posX + 30,komorkiNaPlanszy[ktoraKomorka].posY + 30, al_makecol (0, 0, 0), -1)
                                                      else al_textout_centre_ex (buffer, al_font, intToStr(komorkiNaPlanszy[ktoraKomorka].punkty),komorkiNaPlanszy[ktoraKomorka].posX + 45,komorkiNaPlanszy[ktoraKomorka].posY + 45, al_makecol (0, 0, 0), -1);
     al_textout_centre_ex (buffer, al_font, intToStr(ktoraKomorka),komorkiNaPlanszy[ktoraKomorka].posX,komorkiNaPlanszy[ktoraKomorka].posY, al_makecol (255, 255, 255), -1);

end;

//procedura robiąca update statusu komórek.
//komórki zwiększają swoją ilosć punktów w zależnosci od rozmiaru. Większe komórki rosną szybciej.
procedure updateCells(dt : integer);
var i : integer;
begin
     if (dt mod (configTAB[4]*100)) = 0 then //wrazliwe zwiekszanie szybkosci rosniecia komórek
        begin
        for i:= 1 to ilosc do
            begin //neutralne komorki nie rosna.
            if komorkiNaPlanszy[i].ID <> 2 then komorkiNaPlanszy[i].punkty := komorkiNaPlanszy[i].punkty + komorkiNaPlanszy[i].rozmiar;
            end;
        end
end;

//funkcja sprawdzająca czy wszystkie komórki na planszy należą do jednego gracza lub są neutralne
//zwraca 0 jesli gra ma dalej trwać.
function ifEnd():integer;
var good  : integer;
    badd  : integer;
    i     : integer;
begin
     good := 0;
     badd := 0;
     for i:=1 to ilosc  do
           begin
           if komorkiNaPlanszy[i].ID = 0 then good := good + 1;
           if komorkiNaPlanszy[i].ID = 1 then badd := badd + 1;
           end;
     if (good =  0) and (badd <> 0) then ifEnd := (-1)*badd;
     if (good <> 0) and (badd =  0) then ifEnd := good;
     if (good <> 0) and (badd <> 0) then ifEnd := 0;
end;
