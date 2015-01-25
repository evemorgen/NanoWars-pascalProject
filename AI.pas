procedure AIinit();     //inicjalizacja AI
var i : integer;
    interval : integer;
begin
     //////////////////
     interval := 2000;
     //////////////////
     for i:=1 to ilosc do
         begin
            if komorkiNaPlanszy[i].rozmiar = 3 then komorkiNaPlanszy[i].ios := 2*interval + random(500)
                                               else komorkiNaPlanszy[i].ios := interval + random(500);
         end;
end;

procedure AIsendRandomALL(zlicz : integer); //AI wysyla calkiem losowo ze wszystkich pociski w inna komorke.
var i : integer;
    los: integer;
begin
     for i:=1 to ilosc do
         begin
         if (komorkiNaPlanszy[i].ID = 1) and (zlicz mod komorkiNaPlanszy[i].ios = 0) then
            begin
            los := i;
            while los = i do
                  los := random(ilosc)+1;
            pushFRONTBubble(bubbleList,i,los);
            end;
         end;
end;

procedure AIsendRandomONE(zlicz : integer); //AI wysyla losowa z jednej w inna komorke
var losowaZ : integer;
    losowaDo: integer;
begin
     losowaZ := 0;
     losowaDo:= 0;
     while (losowaZ = 0) or (losowaZ = ilosc+1) or (komorkiNaPlanszy[losowaZ].ID <> 1) do
           begin
           losowaZ := random(ilosc) + 1;
           end;

     while (losowaDo= 0) or (losowaDo = ilosc+1) or (komorkiNaPlanszy[losowaDo].ID = 1) do
           losowaDo := random(ilosc) + 1;
     if zlicz mod komorkiNaPlanszy[losowaZ].ios = 0 then pushFRONTBubble(bubbleList,losowaZ,losowaDo);
end;

procedure AImassiveMssacre(); //Wysylanie duzej ilosci pociskow w malym okresie
begin
     AIsendRandomONE(0);
end;

procedure AIwatchDog(zlicz : integer); //mechanizm dostosowania częstotliwosci wysylania pocisków przez AI
var i : integer;
    good : integer;
    baad : integer;
    coIle: integer;
begin
     coIle := 5000;
     if zlicz mod coIle <> 0 then exit;
     good := 0;
     baad := 0;
     for i:=1 to ilosc do
         begin
         if komorkiNaPlanszy[i].ID = 0 then good := good + 1;
         if komorkiNaPlanszy[i].ID = 1 then baad := baad + 1;
         end;
     if good > 2*baad then
        begin
        for i:=1 to ilosc do
            komorkiNaPlanszy[i].ios := komorkiNaPlanszy[i].ios div 2;
            if komorkiNaPlanszy[i].ios = 0 then komorkiNaPlanszy[i].ios := 10;
        end
     else
       if baad > 2*good then
          begin
          for i:=1 to ilosc do
              begin
              komorkiNaPlanszy[i].ios := komorkiNaPlanszy[i].ios * 2;
              end;
          end;
end;

function AIexpandeRandomONE(zlicz : integer):integer;            //AI nie ataktuje przeciwnika, zajmuje wolne, nieutralne komorki
var losowaZ : integer;
    losowaDo: integer;
    neutral : integer;
    i       : integer;
begin
     neutral := 0;
     for i:=1 to ilosc do
        if komorkiNaPlanszy[i].ID = 2 then neutral:= neutral + 1;
     if neutral = 0 then begin AIexpandeRandomONE := -1; exit; end;
     losowaZ := 0;
     losowaDo:= 0;
     while (losowaZ = 0) or (losowaZ = ilosc+1) or (komorkiNaPlanszy[losowaZ].ID <> 1) do
          losowaZ := random(ilosc) + 1;

     while (losowaDo= 0) or (losowaDo = ilosc+1) or (komorkiNaPlanszy[losowaDo].ID <> 2) do
          losowaDo := random(ilosc) + 1;
     if zlicz mod komorkiNaPlanszy[losowaZ].ios = 0 then pushFRONTBubble(bubbleList,losowaZ,losowaDo);
     AIexpandeRandomONE := neutral;
end;

function AIexpandeRandomALL(zlicz : integer):integer;            //to samo co wyżej tylko dla wszystkich
var los     : integer;
    neutral : integer;
    i       : integer;
begin
     neutral := 0;
     for i:=1 to ilosc do
        if komorkiNaPlanszy[i].ID = 2 then neutral:= neutral + 1;
     if neutral = 0 then begin AIexpandeRandomALL := 0; exit; end;
     for i:=1 to ilosc do
        begin
        if (komorkiNaPlanszy[i].ID = 1) and (zlicz mod komorkiNaPlanszy[i].ios = 0) then
           begin
           los := i;
           while (los = i) or (komorkiNaPlanszy[los].ID <> 2) do
                 los := random(ilosc)+1;
           pushFRONTbubble(bubbleList,i,los);
           end;
        end;
     AIexpandeRandomALL := neutral;
end;

