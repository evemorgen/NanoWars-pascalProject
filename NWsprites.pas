//Funkcja wczytująca sprite'y dla klatek komórek
procedure loadSprites;
var tmpString : string;
begin
     for i:=1 to 16 do
           begin
           tmpString := 'bc/cellb' + intToStr(i) + '.pcx';
           spriteBLUE[i] := al_load_bitmap(tmpString,NIL);
           tmpString := 'bc/cellr' + intToStr(i) + '.pcx';
           spriteRED[i] := al_load_bitmap(tmpString,NIL);
           tmpString := 'bc/cellw' + intToStr(i) + '.pcx';
           spriteWHITE[i] := al_load_bitmap(tmpString,NIL);
           end;
end;

//Funkcja zwalniająca ram na koniec programu
procedure destroySprites;
begin
     for i:=1 to 16 do
           begin
           al_destroy_bitmap(spriteBLUE[i]);
           al_destroy_bitmap(spriteRED[i]);
           al_destroy_bitmap(spriteWHITE[i]);
           end;
end;
