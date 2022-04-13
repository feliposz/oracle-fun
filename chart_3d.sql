with chart_data as
(
  select rank() over (order by lbl) as pos
       , lbl
       , val
       , max(val) over () as val_max
    from (
           &1
         )
),
chart_rows as
(
  select level as chart_row from dual connect by level <= 45
)
select listagg(case
                when l.chart_row = 44                                     then ' |____|/'
                when l.chart_row = 45                                     then ' ' || rpad(d.lbl, 6, ' ') || ' '
                when round(43 - (d.val/d.val_max * 40)) = l.chart_row + 1 then '  '|| lpad(d.val, 5, '_') || ' '
                when round(43 - (d.val/d.val_max * 40)) = l.chart_row     then ' /____/|'
                when round(43 - (d.val/d.val_max * 40)) < l.chart_row     then ' |....||'
                else                                                           '        '
               end)
       within group (order by d.pos) as g
  from chart_data d, chart_rows l
 group by l.chart_row;
