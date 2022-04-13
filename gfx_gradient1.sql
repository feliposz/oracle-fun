declare

  c_altura   constant pls_integer  := 35;
  c_aspecto  constant number       := 1/sqrt(3);
  c_largura  constant pls_integer  := c_altura / c_aspecto;
  c_pi       constant number       := acos(-1);
  v_distancia number;

  function fi_distancia(p_x number, p_y number) return number
  is
  begin
    return sqrt(p_x*p_x + p_y*p_y);
  end;

begin

  -- Plota o grafico
  for y in (-c_altura)..c_altura loop
    for x in (-c_largura)..c_largura loop

      v_distancia := fi_distancia(x * c_aspecto, y);

      -- @0GO©o®º"°''.·×xøØ
      case
        when v_distancia <  5 then dbms_output.put('@');
        when v_distancia < 10 then dbms_output.put('G');
        when v_distancia < 15 then dbms_output.put('O');
        when v_distancia < 20 then dbms_output.put('o');
        when v_distancia < 25 then dbms_output.put('®');
        when v_distancia < 30 then dbms_output.put('°');
        when v_distancia < 35 then dbms_output.put('.');
        else dbms_output.put(' ');
      end case;

    end loop;
    dbms_output.put_line(' ');
  end loop;

end;
/
