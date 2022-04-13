declare
  type t_notas is table of varchar2(100) index by pls_integer;
  v_largura number;
  v_notas   t_notas;
  v_cores   t_notas;
  v_nota    pls_integer;

  function fi_centraliza(p_texto varchar2, p_tamanho number, p_caracter varchar2 default ' ') return varchar2
  is
  begin
    return lpad(rpad(p_texto, trunc(p_tamanho/2)+1, p_caracter), trunc(p_tamanho), p_caracter);
  end;

begin

  v_notas(01) := case when instr('&&1', 'B#') = 0 then 'C'  else 'B#' end;
  v_notas(02) := case when instr('&&1', 'Db') = 0 then 'C#' else 'Db' end;
  v_notas(03) := 'D';
  v_notas(04) := case when instr('&&1', 'Eb') = 0 then 'D#' else 'Eb' end;
  v_notas(05) := case when instr('&&1', 'Fb') = 0 then 'E'  else 'Fb' end;
  v_notas(06) := case when instr('&&1', 'E#') = 0 then 'F'  else 'E#' end;
  v_notas(07) := case when instr('&&1', 'Gb') = 0 then 'F#' else 'Gb' end;
  v_notas(08) := 'G';
  v_notas(09) := case when instr('&&1', 'Ab') = 0 then 'G#' else 'Ab' end;
  v_notas(10) := 'A';
  v_notas(11) := case when instr('&&1', 'Bb') = 0 then 'A#' else 'Bb' end;
  v_notas(12) := case when instr('&&1', 'Cb') = 0 then 'B'  else 'Cb' end;

  v_cores(01) := chr(27)||'[40;91m';
  v_cores(02) := chr(27)||'[40;31m';
  v_cores(03) := chr(27)||'[40;93m';
  v_cores(04) := chr(27)||'[40;33m';
  v_cores(05) := chr(27)||'[40;35m';
  v_cores(06) := chr(27)||'[40;92m';
  v_cores(07) := chr(27)||'[40;32m';
  v_cores(08) := chr(27)||'[40;96m';
  v_cores(09) := chr(27)||'[40;36m';
  v_cores(10) := chr(27)||'[40;94m';
  v_cores(11) := chr(27)||'[40;34m';
  v_cores(12) := chr(27)||'[40;95m';

  v_largura := 10;
  dbms_output.put('  ');
  for l_casa in 1..20 loop
    dbms_output.put(fi_centraliza(l_casa, trunc(v_largura)));
    v_largura := v_largura / power(2, 1/12);
  end loop;
  dbms_output.put_line(' ');

  for l_corda in 1..6 loop
    v_largura := 10;

    v_nota := case l_corda
                when 1 then 5  -- e
                when 2 then 12 -- B
                when 3 then 8  -- G
                when 4 then 3  -- D
                when 5 then 10 -- A
                when 6 then 5  -- E
              end;

    -- Casa "0"
    if instr('&&1' || ',', v_notas(v_nota) || ',') > 0 then
      dbms_output.put(v_cores(v_nota) || lpad(v_notas(v_nota), 2, ' ') || chr(27)||'[m');
    else
      dbms_output.put(lpad(v_notas(v_nota), 2, ' '));
    end if;

    for l_casa in 1..20 loop
      v_nota := v_nota + 1;
      if v_nota = 13 then
        v_nota := 1;
      end if;
      -- Destacar notas
      if instr('&&1' || ',', v_notas(v_nota) || ',') > 0 then
        dbms_output.put('|' || v_cores(v_nota) || fi_centraliza(v_notas(v_nota), trunc(v_largura-1), '-') || chr(27)||'[m' );
      else
        dbms_output.put(rpad('|', trunc(v_largura), '-'));
      end if;
      v_largura := v_largura / power(2, 1/12);
    end loop;
    dbms_output.put_line(' ');
  end loop;

end;
/
undef 1
