  --(select ' .:-=+*#%@' gradiente from dual) gradiente
  --(select ' ·~»c¢XM¶MX¢c»~· ' gradiente from dual) gradiente
  --(select ' .:;+=xX$&' gradiente from dual) gradiente

-- Radial
select substr(listagg(substr(gradiente, mod(trunc(sqrt(col*col/3+lin*lin)), length(gradiente)),1))
       within group (order by col), 1, 100) as canvas
from
  (select level-50 col from dual connect by level <= 100) cols,
  (select level-25 lin from dual connect by level <= 50) lins,
  (select '@0GO©o®º"°''.·×xøØ' gradiente from dual) gradiente
group by lin;

$pause
-- Radial, dois centros
select substr(listagg(substr(gradiente, mod(trunc(0.67*sqrt(col*col/3+lin*lin) + 0.33*sqrt((col+50)*(col+50)/3+(lin-25)*(lin-25))), length(gradiente)),1))
       within group (order by col), 1, 100) as canvas
from
  (select level-50 col from dual connect by level <= 100) cols,
  (select level-25 lin from dual connect by level <= 50) lins,
  (select '@0GO©o®º"°''.·×xøØ' gradiente from dual) gradiente
group by lin;

$pause
-- Radial angular
select substr(listagg( case when col = 0 and lin = 0 then ' ' else substr(gradiente, mod(360 + atan2(col/50, lin/25) / 2 / 3.14159265258979 * 360, length(gradiente)), 1) end )
       within group (order by col), 1, 100) as canvas
from
  (select level-50 col from dual connect by level <= 100) cols,
  (select level-25 lin from dual connect by level <= 50) lins,
  (select '@0GO©o®º"°''.·×xøØ' gradiente from dual) gradiente
  --(select '0122456789ABCDEFGHIJKLMNOPQRSTUVWXYZ' gradiente from dual) gradiente
group by lin;

$pause
-- Interferência 1
select substr(listagg(substr(gradiente, mod((col*col)/20+(lin*lin)/10, length(gradiente)),1))
       within group (order by col), 1, 100) as canvas
from
  (select level col from dual connect by level <= 100) cols,
  (select level lin from dual connect by level <= 50) lins,
  (select '@0GO©o®º"°''.·×xøØ' gradiente from dual) gradiente
group by lin;

$pause
-- Interferência 2
select substr(listagg(substr(gradiente, mod(trunc((col*col/10+lin*lin/4)), length(gradiente)),1))
       within group (order by col), 1, 100) as canvas
from
  (select level-50 col from dual connect by level <= 100) cols,
  (select level-25 lin from dual connect by level <= 50) lins,
  (select '@0GO©o®º"°''.·×xøØ' gradiente from dual) gradiente
group by lin;

$pause
-- Interferência 3
select substr(listagg(substr(gradiente, mod(trunc(col*sqrt(abs(lin*col))), length(gradiente)),1))
       within group (order by col), 1, 100) as canvas
from
  (select level-50 col from dual connect by level <= 100) cols,
  (select level-25 lin from dual connect by level <= 50) lins,
  (select '@0GO©o®º"°''.·×xøØ' gradiente from dual) gradiente
group by lin;

$pause
-- Interferência 4
select substr(listagg(substr(gradiente, mod(cos(col/50*2*3.1416) * 15 + sin(lin/25*2*3.1416) * 10 + lin, length(gradiente)),1))
       within group (order by col), 1, 100) as canvas
from
  (select level-50 col from dual connect by level <= 100) cols,
  (select level-25 lin from dual connect by level <= 50) lins,
  (select '@0GO©o®º"°''.·×xøØ' gradiente from dual) gradiente
group by lin;

$pause
-- Interferência 5
select substr(listagg(substr(gradiente, mod(cos(col/50*2*3.1416) * 15 + sin(lin/25*2*3.1416) * 10 + lin / 2 + col, length(gradiente)),1))
       within group (order by col), 1, 100) as canvas
from
  (select level-50 col from dual connect by level <= 100) cols,
  (select level-25 lin from dual connect by level <= 50) lins,
  (select '@0GO©o®º"°''.·×xøØ' gradiente from dual) gradiente
group by lin;


