set feedback off
set timing off
set linesize 1500
clear screen
select listagg(
        case
          when sqrt(power(x, 2)/60*0.5 + power(y, 2)/20) < 2 and y = 0 and x between -16 and 16 then chr(27)||'[107;32m' || substr(' O R D E M  e  P R O G R E S S O ', x + 16, 1)
          when y = -2 and x = 10 then chr(27)||'[104;97m*'
          when sqrt(power(x, 2)/60*0.5 + power(y, 2)/20) < 2 and y between -1 and 1 then chr(27)||'[107;94m '
          when sqrt(power(x, 2)/60*0.5 + power(y, 2)/20) < 2 then chr(27)||'[104;97m' || decode(sign(y), 1, decode(sign(dbms_random.value(-10, 1)), 1, '*', ' '), ' ')
          when abs(x)/60 + abs(y)/20 < 0.9 then chr(27)||'[103;31m '
          else chr(27)||'[42;92m '
        end
       ) within group (order by x) || chr(27)||'[0m' as bandeira
from ( select level-70 as x from dual connect by level < 140 ) xs
   , ( select level-25 as y from dual connect by level < 50 ) ys
group by ys.y;
