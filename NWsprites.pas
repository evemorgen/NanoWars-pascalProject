procedure loadSprites;
var tmpString : string;
begin
     for i:=1 to 16 do
           begin
           tmpString := 'bc/cellB' + intToStr(i) + '.pcx';
           spriteBLUE[i] := al_load_bitmap(tmpString,NIL);
           tmpString := 'bc/cellR' + intToStr(i) + '.pcx';
           spriteRED[i] := al_load_bitmap(tmpString,NIL);
           end;
end;

procedure destroySprites;
begin
     for i:=1 to 16 do
           begin
           al_destroy_bitmap(spriteBLUE[i]);
           al_destroy_bitmap(spriteRED[i]);
           end;
end;