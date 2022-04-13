declare
  ano number;
  dia_semana number;
  ultimo_dia number;
begin

  ano := to_char(sysdate, 'yyyy');

  dbms_output.put_line('Calendario ' || ano);

  for mes in 1..12 loop

    dbms_output.put_line(' ');
    dbms_output.put_line(to_char(to_date('1/' || mes || '/' || ano, 'dd/mm/yyyy'), 'Month'));
    dbms_output.put_line(' ');
    dbms_output.put_line('Dom Seg Ter Qua Qui Sex Sab');

    ultimo_dia := to_char(last_day(to_date('1/' || mes || '/' || ano, 'dd/mm/yyyy')), 'dd');

    for dia in 1..ultimo_dia loop

      dia_semana := to_char(to_date(dia || '/' || mes || '/' || ano, 'dd/mm/yyyy'), 'd');

      if dia = 1 then
        dbms_output.put(lpad(' ', 4 * (dia_semana-1), ' '));
      end if;

      dbms_output.put(lpad(dia, 3, ' '));

      if dia_semana = 7 or dia = ultimo_dia then
        dbms_output.put_line(' ');
      else
        dbms_output.put(' ');
      end if;

    end loop;

  end loop;

end;
/
