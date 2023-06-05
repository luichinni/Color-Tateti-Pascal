program tateti;
Uses Crt,sysutils;
const
    hoverColor = 3; // cian
    hoverColorWrong = 5; // magenta
    colorMarca = 10; // verde claro
    xColor = 4; // rojo
    oColor = 1; // azul
    colorReset = 0; // negro
    colorLetras = 15; // blanco
    colorTabla = 7; //gris oscuro
type
fila = array [1..3] of integer;
tablero = array [1..3] of fila;
{tablero[x][y] #
  x →
y □ □ □
↓ □ □ □
  □ □ □
}
procedure lineaHorizontal(x,y,tam,color:integer);
begin
    gotoxy(x,y);
    TextBackground(color);
    TextColor(color);
    for x:=x to x+tam-1 do
        write(' ');

    TextColor(colorLetras);
    TextBackground(colorReset);
end;

procedure lineaVertical(x,y,tam,color:integer);
begin
    gotoxy(x,y);
    TextBackground(color);
    TextColor(color);    
    for y:=y to y+tam do begin
        write(' ');
        gotoxy(x,y);
    end;
    TextColor(colorLetras);
    TextBackground(colorReset);
end;

procedure lineaDiagonal(x,y,tam,color:integer;dir:boolean);
var i:integer;
begin 
    i:=0;
    TextBackground(color);
    TextColor(color);   
    if(dir)then begin // de 1,1 a 3,3
        for x:=x to x+tam do begin
            gotoxy(x,y+i);
            write(' ');
            i:=i+1;
        end
    end else begin // de 1,3 a 3,1
        for x:=x to x+tam do begin
            gotoxy(x,y-i);
            write(' ');
            i:=i+1;
        end;
    end;
    TextColor(colorLetras);
    TextBackground(colorReset);
end;

//dibuja las 4 lineas del tablero (anashe)
procedure dibujarTabla();
begin
    lineaVertical(6,1,17,colorTabla);
    lineaVertical(12,1,17,colorTabla);
    lineaHorizontal(1,6,17,colorTabla);
    lineaHorizontal(1,12,17,colorTabla);
end;

//dibuja una X
procedure dibujarX(x,y:integer);
begin
    TextBackground(xColor);
    TextColor(xColor);
    gotoxy(x,y); write(' ');
    gotoxy(x,y+2); write(' ');
    gotoxy(x+2,y); write(' ');
    gotoxy(x+2,y+2); write(' ');
    gotoxy(x+1,y+1); write(' ');
    TextColor(colorLetras);
    TextBackground(colorReset);
end;

//dibuja una O
procedure dibujarO(x,y:integer);
begin
    TextBackground(oColor);
    TextColor(oColor);
    gotoxy(x,y); write('   ');
    gotoxy(x,y+2); write('   ');
    gotoxy(x,y+1); write(' ');
    gotoxy(x+2,y+1); write(' ');
    TextColor(colorLetras);
    TextBackground(colorReset);
end;

//pinta un area
procedure pintarArea(x,y,tamX,tamY,color:integer);
var i:integer;
begin
    for i:=y to y+tamY-1 do
        lineaHorizontal(x,i,tamX,color);
end;

procedure inicializarTablero(var t:tablero);
var x,y:integer;
begin // inicializa todo el tablero con ceros
    for x:=1 to 3 do
        for y:=1 to 3 do
            t[x][y]:=0;
    dibujarTabla();
end;

//pasa la pos de la matriz y la extrapola al gráfico y lo dibuja a la x o la O
procedure pintarCasilla(j,x,y:integer);
var posX,posY:integer;
begin
    case x of
        1: posX:=2;
        2: posX:=8;
        3: posX:=14;
    end;
    case y of
        1: posY:=2;
        2: posY:=8;
        3: posY:=14;
    end;
    if(j=1)then
        dibujarX(posX,posY)
    else if(j=2) then
        dibujarO(posX,posY)
end;

procedure pintarCasilla2(x,y,color:integer);
var posX,posY:integer;
begin
    case x of
        1: posX:=1;
        2: posX:=7;
        3: posX:=13;
    end;
    case y of
        1: posY:=1;
        2: posY:=7;
        3: posY:=13;
    end;
    pintarArea(posX,posY,5,5,color);
end;




Procedure quienVaAhora(turno: boolean);
var 
    posX,posY: integer;

begin

    //desde aqui puedo variar la posicionS
    posX := 25;
    posY := 3;

    gotoxy(posx,posy);

    write('ahora le toca a: ');

    if(turno) then begin
        pintarArea(posx+5,posy+2,3,3,colorReset);
        dibujarX(posx+5,posy+2);
    end
    else begin
        pintarArea(posx+5,posy+2,3,3,colorReset);
        dibujarO(posx+5,posy+2);        
    end;
    
    
end;


Procedure seleccionarCasilla(Var t:tablero; Var x,y:integer; turno:boolean);

Var valido: boolean;
  c: char;
  xAnt,yAnt:integer;
Begin
  // en x,y viene posicionado el puntero y retorna ahi mismo la casilla elegida
  gotoxy(1,20);
  write('Presionar "y" para seleccionar la casilla');

    //codigo que dice quien va ahora:
    quienVaAhora(turno);

  If (t[x][y]<>0)Then
      Begin
        // si no es una casilla disponible valido queda en false
        valido := false;
        pintarCasilla2(x,y,hoverColorWrong);
        pintarCasilla(t[x][y],x,y);
        // poner casilla roja al rededor de lo ocupado y limpiar anterior
      End
    Else
      Begin
        valido := true;
        pintarCasilla2(x,y,hoverColor);
        // poner casilla de color normal indicador y limpiar anterior
      End;
  Repeat
    xAnt:=x;
    yAnt:=y;
    c := readkey();
    // leemos para saber si hay que mover el puntero
    Case (c) Of 
      // se mueve segun lo elegido
      'w': If (y<=1)Then y := 3
           Else y := y-1;
      'a': If (x<=1)Then x := 3
           Else x := x-1;
      's': If (y>=3)Then y := 1
           Else y := y+1;
      'd': If (x>=3)Then x := 1
           Else x := x+1;
    End;
    {gotoxy(1,16);
    write('x='+IntToStr(x)+' y='+IntToStr(y));}
    If (t[x][y]<>0)Then
      Begin
        // si no es una casilla disponible valido queda en false
        valido := false;
        pintarCasilla2(x,y,hoverColorWrong);
        pintarCasilla(t[x][y],x,y);
        // poner casilla roja al rededor de lo ocupado y limpiar anterior
      End
    Else
      Begin
        valido := true;
        pintarCasilla2(x,y,hoverColor);
        // poner casilla de color normal indicador y limpiar anterior
      End;
    if not((x=xAnt) and (y=yAnt))then begin
        pintarCasilla2(xAnt,yAnt,colorReset);
        pintarCasilla(t[xAnt][yAnt],xAnt,yAnt);
    end;
  Until ((c='y') And valido);
  // enter para elegir
  If (turno)Then
    Begin
      // jugador 1
      t[x][y] := 1;
      pintarCasilla(1,x,y);
      //readkey;//borro este?
    End
  Else
    Begin
        // jugador 2
        t[x][y] := 2;
        pintarCasilla(2,x,y);
    End;
End;


Function comprobarC(t:tablero;var x1,y1,x2,y2: integer): integer;
Var 
  i, j, p1, p2, tot: integer;
Begin
    p1 := 0;
    p2 := 0;
    tot := 0;
    For i:= 1 To 3 Do // por cada x
        Begin
        For j:= 1 To 3 Do // por cada y
            Begin
            If (t[i][j] = 1) Then // si hay 1 sumo uno al jugador 1
                p1 := p1 + 1
            Else if (t[i][j]=2) then // si hay 2 sumo uno al jugador 2
                p2 := p2 + 1;
            End;
        If (p1 = 3) Then begin// si alguno de los dos tiene de suma 3 entonces gano con columna
            tot := 1;
            x1:=i; x2:=i;
            y1:=1; y2:=3
        end else If (p2 = 3) Then begin
            tot := 2;
            x1:=i; x2:=i;
            y1:=1; y2:=3;
        end;
        p1 := 0;
        p2 := 0;
        End;
    {writeln('comprobarC: ',tot);}
    comprobarC:=tot;
End;

Function comprobarF(t:tablero; var x1,y1,x2,y2: integer): integer;
Var 
  i, j, p1, p2, tot: integer;
Begin
    p1 := 0;
    p2 := 0;
    tot := 0;
    For i:= 1 To 3 Do // por cada y
        Begin
        For j:= 1 To 3 Do // por cada x
            Begin
            If (t[j][i] = 1) Then // si hay un 1 suma 1
                p1 := p1 + 1
            Else If (t[j][i] = 2) Then // si hay un 2 suma 1
                    p2 := p2 + 1;
            End;
        If (p1 = 3) Then begin// si alguno de los dos suma 3 entonces gana
            tot := 1;
            x1:=1; x2:=3;
            y1:=i; y2:=i
        end else If (p2 = 3) Then begin
            tot := 2;
            x1:=1; x2:=3;
            y1:=i; y2:=i;
        end;
        p1 := 0;
        p2 := 0;
        End;
    {writeln('comprobarF: ',tot);}
    comprobarF:=tot;
End;

Function comprobarD(t:tablero;var x1,y1,x2,y2:integer): integer;//READY
Var 
  i, j, p1, p2, tot: integer;
Begin
    p1 := 0;
    p2 := 0;
    tot := 0;
    For i:=1 To 3 Do // diagonal desde 1,1 hasta 3,3 
        Begin
        If (t[i][i] = 1) Then // si hay 1 se suma 1
            p1 := p1 + 1
        Else If (t[i][i] = 2) Then // si hay 2 se suma 1
            p2 := p2 + 1;
        End;
    If (p1 = 3) Then begin // si alguno tiene 3 puntos es el ganador en ese diagonal
        tot := 1;
        x1:=1; x2:=3;
        y1:=1; y2:=3
    end else If (p2 = 3) Then begin
        tot := 2;
        x1:=1; x2:=3;
        y1:=1; y2:=3;
    end;

    if(tot=0)then begin
        p1 := 0;
        p2 := 0;
        i:=1; j:=3;
        while(i<4)do begin
            if(t[i][j]=1)then
                p1:=p1+1
            else if(t[i][j]=2)then
                p2:=p2+1;
            i:=i+1;
            j:=j-1;
        end;
        If (p1 = 3) Then begin
            tot:= 1;
            x1:=1; x2:=3;
            y1:=3; y2:=1
        end else if (p2 = 3) Then begin
            tot := 2;
            x1:=1; x2:=3;
            y1:=3; y2:=1;
        end;
    end;
    {writeln('CompD: ',tot);}
    comprobarD:=tot;
End;

function comprobarTablero(var x1,y1,x2,y2: integer;t:tablero):integer;
Var 
    rta,i,j: integer;
Begin
    rta := comprobarC(t,x1,y1,x2,y2);
    If rta=0 Then begin
        rta := comprobarD(t,x1,y1,x2,y2);
        If rta=0 Then
            rta := comprobarF(t,x1,y1,x2,y2);
    end;

    if rta=0 then begin
        rta:=-1;
        for i:=1 to 3 do
            for j:=1 to 3 do
                if(t[i][j]=0)then
                    rta:=0;
    end;
    comprobarTablero:=rta;
end;

procedure dibujarGanador(x1,y1,x2,y2:integer);
var posX,posY,posX2,posY2:integer;
begin
    case x1 of
        1: posX:=3;
        2: posX:=9;
        3: posX:=15;
    end;
    case x2 of
        1: posX2:=3;
        2: posX2:=9;
        3: posX2:=15;
    end;
    case y1 of
        1: posY:=3;
        2: posY:=9;
        3: posY:=15;
    end;
    case y2 of
        1: posY2:=3;
        2: posY2:=9;
        3: posY2:=15;
    end;
    if(x1=x2)then
        lineaVertical(posX,posY,posY2-posY,colorMarca)
    else if (y1=y2)then
        lineaHorizontal(posX,posY,posX2-posX,colorMarca)
    else if (y1<y2)then
        lineaDiagonal(posX,posY,posX2-posX,colorMarca,true)
    else if (y1>y2)then
        lineaDiagonal(posX,posY,posX2-posX,colorMarca,false);
end;


procedure jugadorQueGano(jugador: integer);
Begin
  gotoxy(WhereX+1,WhereY-1);
  Case jugador Of 
    1:Begin dibujarX(WhereX,WhereY);TextColor(xColor);End;
    2:Begin dibujarO(WhereX,WhereY);TextColor(oColor);End;
  End;
End;


var
    t:tablero; fin,turno:boolean; x,y,x1,x2,y1,y2,ganador:integer; c:char;
begin
    cursoroff;
    repeat
        ClrScr;
        inicializarTablero(t);
        x:=1; y:=1;
        fin:=false;
        turno:=true;
        while not fin do begin
            seleccionarCasilla(t,x,y,turno);
            turno:=not turno;
            // x1,y1 donde arranca, x2,y2 donde termina
            ganador:=comprobarTablero(x1,y1,x2,y2,t);
            if(ganador<>0)then begin
                fin:=true;
                if(ganador<>-1)then
                    dibujarGanador(x1,y1,x2,y2);
            end;
        end;
        delay(1000);
        ClrScr;
        gotoxy(2,2);
        If (ganador=1) Or (ganador=2)Then begin
            case ganador of 
                1: TextColor(xColor);
                2: TextColor(oColor);
            end;
            write('Gano el jugador: ');
            jugadorQueGano(ganador)
        end Else
            write('No hay ganadores :P');
        gotoxy(2,5);
        write('presione cualquier tecla para volver a jugar');
        gotoxy(4,6);
        write('(o presione "q" para cerrar)');
        while(KeyPressed)do
            readkey;
        c:=readkey();
    until(c='q');
end.
