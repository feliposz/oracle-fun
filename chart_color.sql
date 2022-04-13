with dados as
(
  select rank() over (order by lbl) as pos
       , decode(mod(rank() over (order by lbl), 15)+1, 1, 31, 2, 32, 3, 33, 4, 34, 5, 35, 6, 36, 7, 37, 8, 90, 9, 91, 10, 92, 11, 93, 12, 94, 13, 95, 14, 96, 15, 97) as cor
       , lbl
       , val
       , max(val) over () as val_max
    from (
           &1
         )
),
linhas as
(
  select level as linha from dual connect by level <= 45
)
select listagg(case
                when l.linha = 44                                         then chr(27)||'[40;' || d.cor || 'm |______|/' || chr(27)||'[m'
                when l.linha = 45                                         then chr(27)||'[40;' || d.cor || 'm ' || rpad(d.lbl, 8, ' ') || ' ' || chr(27)||'[m'
                when round(43 - (d.val/d.val_max * 40)) = l.linha + 1 then chr(27)||'[40;' || d.cor || 'm  ' || lpad(d.val, 7, '_') || ' ' || chr(27)||'[m'
                when round(43 - (d.val/d.val_max * 40)) = l.linha     then chr(27)||'[40;' || d.cor || 'm /______/|' || chr(27)||'[m'
                when round(43 - (d.val/d.val_max * 40)) < l.linha     then chr(27)||'[40;' || d.cor || 'm |......||' || chr(27)||'[m'
                else                                                           chr(27)||'[40;' || d.cor || 'm          ' || chr(27)||'[m'
               end)
       within group (order by d.pos) as g
  from dados d, linhas l
 group by l.linha;
