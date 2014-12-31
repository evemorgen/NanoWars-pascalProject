
type pOnBubble = ^bubble;
bubble = record
posX     : integer;
posY     : integer;
destX    : integer;
destY    : integer;
punkty   : integer;
incDecX  : integer;
incDecY  : integer;
toNr     : integer;
fromNr   : integer;
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
     if dodawany^.destX > dodawany^.posX then dodawany^.incDecX := 1
                                         else dodawany^.incDecX := -1;
     if dodawany^.destY > dodawany^.posY then dodawany^.incDecY := 1
                                         else dodawany^.incDecY := -1;

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
     if dodawany^.destY > dodawany^.posY then dodawany^.incDecY := 1
                                         else dodawany^.incDecY := -1;

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





