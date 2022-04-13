-- seno e cosseno
select substr(listagg(case when lin = round(sin(col/100*2*3.14159265258979)*24) then '*' when lin = round(cos(col/100*2*3.14159265258979)*24) then '.' else ' ' end)
       within group (order by col), 1, 100) as canvas
from
  (select level-1 col from dual connect by level <= 100) cols,
  (select level-25 lin from dual connect by level <= 50) lins
group by lin;

$pause
-- circulo
select substr(listagg( case when round(sqrt(col*col/3+lin*lin)) = 24 then ':' else ' ' end )
       within group (order by col), 1, 100) as canvas
from
  (select level-50 col from dual connect by level <= 100) cols,
  (select level-25 lin from dual connect by level <= 50) lins
group by lin;

$pause
-- bola
select substr(listagg( case when round(sqrt(col*col/3+lin*lin)) < 24 then ':' else ' ' end )
       within group (order by col), 1, 100) as canvas
from
  (select level-50 col from dual connect by level <= 100) cols,
  (select level-25 lin from dual connect by level <= 50) lins
group by lin;

$pause
-- angulos
select substr(listagg( case when round(sqrt(col*col/3+lin*lin)) between 1 and 24 then substr('.!@', mod(360 + atan2(lin/25, col/50) / 2 / 3.14159265258979 * 36, 3)+1, 1) else ' ' end )
       within group (order by col), 1, 100) as canvas
from
  (select level-50 col from dual connect by level <= 100) cols,
  (select level-25 lin from dual connect by level <= 50) lins
group by lin;

$pause
-- donut
select substr(listagg( case when round(sqrt(col*col/3+lin*lin)) between 15 and 24 then ':' else ' ' end )
       within group (order by col), 1, 100) as canvas
from
  (select level-50 col from dual connect by level <= 100) cols,
  (select level-25 lin from dual connect by level <= 50) lins
group by lin;

$pause
-- cruzamentos
select substr(listagg( case when col = 0 and lin = 0 then '+'
                            when col = 0 then '|'
                            when lin = 0 then '-'
                            when abs(col) = abs(lin) and sign(col) = sign(lin) then '\'
                            when abs(col) = abs(lin) and sign(col) <> sign(lin) then '/'
                            else ' ' end )
       within group (order by col), 1, 100) as canvas
from
  (select level-50 col from dual connect by level <= 100) cols,
  (select level-25 lin from dual connect by level <= 50) lins
group by lin;

$pause
-- hexagonal
select substr(listagg( case when mod(col, 6) = 1 and mod(lin, 2) = 1 then '\'
                            when mod(col, 6) = 4 and mod(lin, 2) = 0 then '\'
                            when mod(col, 6) = 4 and mod(lin, 2) = 1 then '/'
                            when mod(col, 6) = 1 and mod(lin, 2) = 0 then '/'
                            when mod(col, 6) in (2, 3) and mod(lin, 2) = 1 then '_'
                            when mod(col, 6) in (5, 0) and mod(lin, 2) = 0 then '_'
                            else ' ' end )
       within group (order by col), 1, 100) as canvas
from
  (select level col from dual connect by level <= 100) cols,
  (select level lin from dual connect by level <= 50) lins
group by lin;
