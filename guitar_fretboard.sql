declare
  v_largura number;

  function fi_centraliza(p_texto varchar2, p_tamanho number) return varchar2
  is
  begin
    return lpad(rpad(p_texto, trunc(p_tamanho/2)+1, ' '), trunc(p_tamanho), ' ');
  end;

begin

  for l_corda in 0..6 loop
    v_largura := 10;
    if l_corda = 0 then
      dbms_output.put(' ');
    else
      dbms_output.put(l_corda);
    end if;
    for l_casa in 1..20 loop
      if l_corda = 0 then
        dbms_output.put(fi_centraliza(l_casa, trunc(v_largura)));
      else
        dbms_output.put(rpad('|', trunc(v_largura), '-'));
      end if;
      v_largura := v_largura / power(2, 1/12);
    end loop;
    dbms_output.put_line(' ');
  end loop;

end;
/
