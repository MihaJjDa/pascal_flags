program flags(input, output);

uses crt;

var
  mem : byte;
  inf, sup: longint;

type
  cell = array [1..16] of byte;

procedure outnum(a: longint);
  var
    b: longint;
    i: byte;
  begin
    write(a);
    if a < 0 then          {Выясняю длину числа, чтобы вывод был красивее}
      i := 2
    else
      i := 1;
    a := abs(a);
    while a > 9 do
      begin
        a := a div 10;
        i := i + 1;
      end;
    if a < 0 then
      i := i + 1;
    for i := i to 6 do
      write(' ');
  end;

procedure outbnum(a: longint; var ab: cell);
  var
    b: longint;
    i: byte;
  begin
    b := a;
    if b < 0 then
      b := b + sup + 1;
    for i := mem downto 2 do
      begin
        ab[i] := b mod 2;
        b := b div 2;
      end;
    if a < 0 then
      ab[1] := 1
    else
      ab[1] := b mod 2;
    for i := 1 to mem do
      write(ab[i]);
    for i := mem to 16 do
      write(' ');
  end;

procedure outwos(var ab: cell);
  var
    i: byte;
    a: longint;
  begin
    a := 0;
    for i := 1 to mem do
      a := a * 2 + ab[i];
    outnum(a);
  end;

procedure outws(var ab: cell);
  var
    i: byte;
    a: longint;
  begin
    a := 0;
    for i := 1 to mem do
      a := a * 2 + ab[i];
    if ab[1] = 1 then
      a := a - sup - 1;
    outnum(a);
  end;

procedure num(a: longint; var ab: cell);
  begin
    outnum(a);
    outbnum(a, ab);
    outwos(ab);
    outws(ab);
    writeln;
  end;

procedure add(var a, b: cell);
  var
    i, d: byte;
    cf, ovf, sf, zf: byte;
    s: cell;
  begin
    cf := 0;
    zf := 1;
    for i := mem downto 1 do
      begin
        d := a[i] + b[i] + cf;
        s[i] := d mod 2;
        cf := d div 2;
        if s[i] = 1 then
        zf := 0;
      end;
    sf := s[1];
    if (a[1] = b[1]) and (s[1] <> a[1]) then
      ovf := 1
    else
      ovf := 0;
    for i := 1 to mem do
      write(s[i]);
    for i := mem to 16 do
      write(' ');
    outwos(s);
    outws(s);
    write('wos', (cf + 1) mod 2, 'ws', (ovf + 1) mod 2, ' ');
    write(sf, '  ', ovf, '  ', cf, '  ', zf);
    writeln;
  end;

procedure sub(var a, b: cell);
  var
    i, d: byte;
    cf, ovf, sf, zf: byte;
    s: cell;
  begin
    cf := 0;
    zf := 1;
    for i := mem downto 1 do
      begin
        d := 2 + a[i] - b[i] - cf;
        s[i] := d mod 2;
        cf := 1 - (d div 2);
        if s[i] = 1 then
          zf := 0;
      end;
    sf := s[1];
    if (a[1] <> b[1]) and (s[1] = b[1]) then
      ovf := 1
    else
      ovf := 0;
    for i := 1 to mem do
      write(s[i]);
    for i := mem to 16 do
      write(' ');
    outwos(s);
    outws(s);
    write('wos', (cf + 1) mod 2, 'ws', (ovf + 1) mod 2, ' ');
    write(sf, '  ', ovf, '  ', cf, '  ', zf);
    writeln;
  end;


var
  a, b: longint;
  ab, bb: cell;
  c: char;
begin
  clrscr;
  writeln('________________________________');
  writeln('Puchkin Daniel, group 112, Flags');
  writeln('________________________________');
  writeln('Press ENTER to continue');
  readln;
  repeat
    clrscr;
    writeln('Enter an integer from 2 to 16 (number of bits for computer''s memory)');
    read(mem);
    while not (mem in [2..16]) do
      begin
        clrscr;
        writeln('Error! Enter an integer from 2 to 16');
        read(mem);
      end;
    clrscr;
    inf := -trunc(exp((mem - 1) * ln(2)));
    sup := trunc(exp(mem * ln(2))) - 1;
    writeln('Enter 2 integers in the interval [', inf, ', ', sup, ']');
    read(a, b);
    while (a < inf) or (a > sup) or (b < inf) or (b > sup) do
      begin
        clrscr;
        writeln('Error! Enter an integer in the interval [', inf, ', ', sup, ']');
        read(a, b);
      end;
    clrscr;
    writeln('                Number Binary SC        10scWO 10scWS Correct SF OF CF ZF');
    write('The 1st number: ');
    num(a, ab);
    write('The 2nd number: ');
    num(b, bb);
    write('Sum:            ');
    outnum(a + b);
    add(ab, bb);
    write('Sub:            ');
    outnum(a - b);
    sub(ab, bb);
    writeln('wos - without sign');
    writeln('ws - with sign');
    writeln('1 - correct result');
    writeln('0 - incorrect result');
    writeln('Press ENTER to continue');
    readln;
    readln;
    clrscr;
    writeln('Enter ''N'' to exit or press ENTER to continue perfoming');
    read(c);
    if (c = 'n') or (c = 'N') then
      exit;
    until false;
    readln;
end.