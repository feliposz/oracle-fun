declare
  type t_notas is table of varchar2(2) index by pls_integer;
  v_largura number;
  v_notas   t_notas;
  v_nota    pls_integer;

  function fi_centraliza(p_texto varchar2, p_tamanho number, p_caracter varchar2 default ' ') return varchar2
  is
  begin
    return lpad(rpad(p_texto, trunc(p_tamanho/2)+1, p_caracter), trunc(p_tamanho), p_caracter);
  end;

begin

  v_notas(01) := 'C';
  v_notas(02) := 'C#';
  v_notas(03) := 'D';
  v_notas(04) := 'D#';
  v_notas(05) := 'E';
  v_notas(06) := 'F';
  v_notas(07) := 'F#';
  v_notas(08) := 'G';
  v_notas(09) := 'G#';
  v_notas(10) := 'A';
  v_notas(11) := 'A#';
  v_notas(12) := 'B';

  -- v_notas(02) := 'Db';
  -- v_notas(04) := 'Eb';
  -- v_notas(07) := 'Gb';
  -- v_notas(09) := 'Ab';
  -- v_notas(11) := 'Bb';

  v_largura := 10;
  dbms_output.put('  ');
  for l_casa in 1..20 loop
    dbms_output.put(fi_centraliza(l_casa, trunc(v_largura)));
    v_largura := v_largura / power(2, 1/12);
  end loop;
  dbms_output.put_line(' ');

  for l_corda in 1..6 loop
    v_largura := 10;
    select decode(l_corda, 0, -1, 1, 5, 2, 12, 3, 8, 4, 3, 5, 10, 6, 5) into v_nota from dual;
    dbms_output.put(lpad(v_notas(v_nota), 2, ' '));
    for l_casa in 1..20 loop
      v_nota := v_nota + 1;
      if v_nota = 13 then
        v_nota := 1;
      end if;
      if instr(upper('&1' || ' '), v_notas(v_nota) || ' ') > 0 then
        dbms_output.put('|' || fi_centraliza(v_notas(v_nota), trunc(v_largura-1), '-'));
      else
        dbms_output.put(rpad('|', trunc(v_largura), '-'));
      end if;
      v_largura := v_largura / power(2, 1/12);
    end loop;
    dbms_output.put_line(' ');
  end loop;

end;
/
