declare
  ano number;
  mes number;
  dia number;
  nome_mes varchar2(50);
  semana_mes number;
  primeiro_dia date;
  primeiro_domingo date;
  ultimo_dia date;
  ultimo_domingo date;
  data_dia date;
  colunas number;
  largura number;
  e_feriado number;

  function espacado(texto varchar2) return varchar2
  is
    resultado varchar2(3000);
  begin
    resultado := substr(texto, 1, 1);
    for i in 2..length(texto) loop
      resultado := resultado || ' ' || substr(texto, i, 1);
    end loop;
    return resultado;
  end;

  function centralizado(texto varchar2, tamanho number) return varchar2
  is
  begin
    return rpad(lpad(texto, length(texto) + ceil((tamanho - length(texto)) / 2), ' '), tamanho, ' ');
  end;

begin

  colunas := 3; -- Quantos meses por linha
  largura := 32 * colunas + 1;
  ano := to_char(sysdate, 'yyyy');

  -- Titulo
  dbms_output.put_line('|' || lpad('=', largura, '=') || '|');
  dbms_output.put_line('|[4m' || centralizado(espacado('CALENDARIO ' || ano), largura) || '[24m|');
  dbms_output.put_line('|' || lpad(' ', largura, ' ') || '|');

  for linha_mes in 1..ceil(12/colunas) loop

    dbms_output.put_line('|' || lpad(' ', 32 * colunas + 1, ' ') || '|');

    -- Linha superior
    dbms_output.put('|');
    for coluna_mes in 1..colunas loop
      mes := (linha_mes-1) * colunas + coluna_mes;
      if mes <= 12 then
        dbms_output.put(' +-----------------------------+');
      else
        dbms_output.put('                                ');
      end if;
    end loop;
    dbms_output.put_line(' |');

    -- Desenha as linhas do quadro contendo os dias do m�s
    for linha_quadro in 1..8 loop

      dbms_output.put('|');

      for coluna_mes in 1..colunas loop
        mes := (linha_mes-1) * colunas + coluna_mes;
        if mes between 1 and 12 then
          primeiro_dia := to_date('1/' || mes || '/' || ano, 'dd/mm/yyyy');
          primeiro_domingo := trunc(primeiro_dia + 6, 'd');
          ultimo_dia := last_day(primeiro_dia);
          ultimo_domingo := trunc(ultimo_dia, 'd');

          if linha_quadro = 1 then
            nome_mes := to_char(to_date('1/' || mes || '/' || ano, 'dd/mm/yyyy'), 'fmMonth');
            dbms_output.put(' |[4m' || centralizado(nome_mes, 29) || '[24m|');
          elsif linha_quadro = 2 then
            dbms_output.put(' | [96mDom[39m Seg Ter Qua Qui Sex [92mSab[39m |');
          else
            semana_mes := linha_quadro - 2;
            dbms_output.put(' | ');
            for ndia in 1..7 loop

              if primeiro_dia = primeiro_domingo then
                dia := to_char(primeiro_domingo, 'dd') + ndia - 1 + 7 * (semana_mes - 1);
              else
                dia := to_char(primeiro_domingo, 'dd') + ndia - 1 + 7 * (semana_mes - 2);
              end if;

              if dia between 1 and to_char(ultimo_dia, 'dd') then

                data_dia := to_date(dia || '/' || mes || '/' || ano, 'dd/mm/yyyy');

                if to_char(data_dia, 'd') = 1 then
                  dbms_output.put('[96m');
                elsif to_char(data_dia, 'd') = 7 then
                  dbms_output.put('[92m');
                end if;


                if data_dia = trunc(sysdate) then
                  dbms_output.put('[107;34m<' || lpad(dia, 2, ' ') || '>[0m');
                else
                  dbms_output.put(lpad(dia, 3, ' ') || ' ');
                end if;


                if to_char(data_dia, 'd') in (1, 7) then
                  dbms_output.put('[39m');
                end if;

              else
                dbms_output.put('    ');
              end if;

            end loop;
            dbms_output.put('|');
          end if;

        else
          dbms_output.put('                                ');
        end if;

      end loop;

      dbms_output.put_line(' |');

    end loop;

    -- Linha inferior
    dbms_output.put('|');
    for coluna_mes in 1..colunas loop
      mes := (linha_mes-1) * colunas + coluna_mes;
      if mes <= 12 then
        dbms_output.put(' +-----------------------------+');
      else
        dbms_output.put('                                ');
      end if;
    end loop;
    dbms_output.put_line(' |');

  end loop;

  dbms_output.put_line('|' || lpad(' ', 32 * colunas + 1, ' ') || '|');
  dbms_output.put_line('|' || lpad('=', 32 * colunas + 1, '=') || '|');

end;
/
