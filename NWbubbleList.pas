
type pOnBubble = ^bubble;
bubble = record
posX     : integer;
posY     : integer;
destX    : integer;
destY    : integer;
punkty   : integer;
incDecX  : integer;
toNr     : integer;
fromNr   : integer;
interval : integer;
distance : integer;
nastepny : pOnBubble;
end;

var bubbleList : pOnBubble;
var bubbleCount : integer;

procedure printBubble(lista:pOnBubble);
var kopia : pOnBubble;
begin
     kopia := lista;
     writeln('|PosX|PosY|toNr|fromNr|');
     while kopia <> nil do
           begin
           writeln('|',kopia^.posX,'|',kopia^.posY,'|',kopia^.toNr ,'|',kopia^.fromNr,'|');
           kopia := kopia^.nastepny;
           end;
end;

procedure pushFRONTbubble(var poprzedni:pOnBubble;odd,doo:integer);
var dodawany : pOnBubble;
begin
     New(dodawany);
     bubbleCount := bubbleCount+1;

     dodawany^.fromNr := odd;
     dodawany^.toNr   := doo;
     dodawany^.punkty := komorkiNaPlanszy[odd].punkty div 2;
     if komorkiNaPlanszy[odd].punkty mod 2 <> 0 then komorkiNaPlanszy[odd].punkty := (komorkiNaPlanszy[odd].punkty div 2)+1
                                                else komorkiNaPlanszy[odd].punkty := (komorkiNaPlanszy[odd].punkty div 2);
     dodawany^.posX   := komorkiNaPlanszy[odd].posX+30;
     dodawany^.posY   := komorkiNaPlanszy[odd].posY+30;
     dodawany^.destX  := komorkiNaPlanszy[doo].posX+30;
     dodawany^.destY  := komorkiNaPlanszy[doo].posY+30;
     dodawany^.distance := round(sqrt(sqr(dodawany^.posX - dodawany^.destX) + sqr(dodawany^.posY - dodawany^.destY)));
     dodawany^.interval := dodawany^.distance div (abs(dodawany^.posX - dodawany^.destX));
     writeln('distance: ',dodawany^.distance,' | interval:',dodawany^.interval);
     if dodawany^.destX > dodawany^.posX then dodawany^.incDecX := 1
                                         else dodawany^.incDecX := -1;
     dodawany^.nastepny := poprzedni;
     poprzedni := dodawany;
end;

procedure pushBACKbubble(var listeczka:pOnBubble;odd,doo:integer);
var dodawany,biegaj: pOnBubble;
begin
     New(dodawany);
     bubbleCount := bubbleCount+1;

     dodawany^.fromNr := odd;
     dodawany^.toNr   := doo;
     dodawany^.punkty := komorkiNaPlanszy[odd].punkty div 2;
     if komorkiNaPlanszy[odd].punkty mod 2 <> 0 then komorkiNaPlanszy[odd].punkty := (komorkiNaPlanszy[odd].punkty div 2)+1
                                                else komorkiNaPlanszy[odd].punkty := (komorkiNaPlanszy[odd].punkty div 2);
     dodawany^.posX   := komorkiNaPlanszy[odd].posX+30;
     dodawany^.posY   := komorkiNaPlanszy[odd].posY+30;
     dodawany^.destX  := komorkiNaPlanszy[doo].posX+30;
     dodawany^.destY  := komorkiNaPlanszy[doo].posY+30;
     if dodawany^.destX > dodawany^.posX then dodawany^.incDecX := 1
                                         else dodawany^.incDecX := -1;

     biegaj := listeczka;
     while biegaj^.nastepny <> nil do
           biegaj := biegaj^.nastepny;
     dodawany^.nastepny := nil;
     biegaj^.nastepny := dodawany;
end;

procedure popFRONTbubble(var listeczka:pOnBubble);
begin
     bubbleCount := bubbleCount-1;
     if listeczka <> nil then
     begin
     //tutaj zrob cos z danymi jesli sa jeszcze potrzebne;
     listeczka := listeczka^.nastepny;
     end;
end;

procedure popBACKbubble(var listeczka:pOnBubble);
var pomoc:pOnBubble;
begin
     bubbleCount := bubbleCount-1;
     pomoc := listeczka;
     while pomoc^.nastepny^.nastepny <> nil do
           pomoc := pomoc^.nastepny;
     //tutaj zrob cos z danymi jesli sa jeszcze potrzebne;
     pomoc^.nastepny := nil;
end;

procedure popMIDDLEbubble(var listeczka:pOnBubble;ktory : integer);
var i:integer;
    pomoc : pOnBubble;
begin
     bubbleCount := bubbleCount-1;
     i:=1;
     pomoc := listeczka;
     while i <> ktory-1 do
           begin
           pomoc := pomoc^.nastepny;
           i := i+1;
           end;
     //tutaj zrob cos z danymi jesli sa jeszcze potrzebne;
     pomoc^.nastepny := pomoc^.nastepny^.nastepny;
end;

procedure popBubble(var listeczka:pOnBubble;ktory:integer);
begin
     if ktory = 1                               then begin popFRONTbubble(listeczka); exit; end;
     if ktory = bubbleCount                     then begin popBACKbubble(listeczka); exit; end;
     if (ktory <> 1) and (ktory <> bubbleCount) then popMIDDLEbubble(listeczka,ktory);
end;


procedure checkBubble(var listeczka:pOnBubble);
var pomoc : pOnBubble;
    i     : integer;
    z     : integer;
begin
     repeat
     z := 0;
     i := 1;
     pomoc := listeczka;
     while pomoc <> nil do
           begin
           if (pomoc^.posX = pomoc^.destX) and (pomoc^.posY = pomoc^.destY) then
              begin
              z := i;
              break;
              end;
           pomoc := pomoc^.nastepny;
           i := i+1;
           end;
     if z <> 0 then
        begin
        if komorkiNaPlanszy[pomoc^.fromNr].ID <> komorkiNaPlanszy[pomoc^.toNr].ID then komorkiNaPlanszy[pomoc^.toNr].punkty := komorkiNaPlanszy[pomoc^.toNr].punkty - pomoc^.punkty
                                                                                  else komorkiNaPlanszy[pomoc^.toNr].punkty := komorkiNaPlanszy[pomoc^.toNr].punkty + pomoc^.punkty;
        if komorkiNaPlanszy[pomoc^.toNr].punkty < 0 then begin komorkiNaPlanszy[pomoc^.toNr].ID := 1-komorkiNaPlanszy[pomoc^.toNr].ID; komorkiNaPlanszy[pomoc^.toNr].punkty := (-1)*(komorkiNaPlanszy[pomoc^.toNr].punkty); end;
        popBubble(listeczka,z);
        end;
     until z=0;
end;

procedure drawBubble(var listeczka:pOnBubble);
var pomoc : pOnBubble;
begin
     pomoc := listeczka;
     while pomoc <> nil do
           begin
           if komorkiNaPlanszy[pomoc^.fromNr].ID <> 1 then
              begin
              al_circlefill(buffer,pomoc^.posX,pomoc^.posY,10,al_makecol(166,5,5));
              al_textout_centre_ex (buffer, al_font,intToStr(pomoc^.punkty), pomoc^.posX+1,pomoc^.posY-2, al_makecol (255, 255, 255), -1);
              end
           else
              begin
              al_circlefill(buffer,pomoc^.posX,pomoc^.posY,10,al_makecol(66,185,253));
              al_textout_centre_ex (buffer, al_font,intToStr(pomoc^.punkty), pomoc^.posX+1,pomoc^.posY-2, al_makecol (0, 0, 0), -1);
              end;
           al_circle(buffer,pomoc^.posX,pomoc^.posY,11,al_makecol(255,255,255));
           al_circle(buffer,pomoc^.posX,pomoc^.posY,12,al_makecol(255,255,255));
           pomoc := pomoc^.nastepny;
           end;
end;

procedure updateBubble(var listeczka: pOnBubble;dt:integer);
var pomoc : pOnBubble;
begin
     pomoc := listeczka;
     while pomoc <> nil do
           begin
           if (komorkiNaPlanszy[pomoc^.toNr].posX+30) - (komorkiNaPlanszy[pomoc^.fromNr].posX+30) <> 0 then
              begin
              if (dt mod pomoc^.interval = 0) then
                 begin
                 pomoc^.posX := pomoc^.posX + pomoc^.incDecX;
                 pomoc^.posY := (komorkiNaPlanszy[pomoc^.toNr].posY+30) - (komorkiNaPlanszy[pomoc^.fromNr].posY+30);
                 pomoc^.posY := pomoc^.posY * (pomoc^.posX - (komorkiNaPlanszy[pomoc^.fromNr].posX+30));
                 pomoc^.posY := pomoc^.posY div ((komorkiNaPlanszy[pomoc^.toNr].posX+30) - (komorkiNaPlanszy[pomoc^.fromNr].posX+30));
                 pomoc^.posY := pomoc^.posY + komorkiNaPlanszy[pomoc^.fromNr].posY + 30;
                 end
              else
                 begin
                 if pomoc^.posY < pomoc^.destY then pomoc^.posY := pomoc^.posY + 1
                                               else pomoc^.posY := pomoc^.posY - 1;
                 end;
              end;
           pomoc := pomoc^.nastepny;
           end;

end;


