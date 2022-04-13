declare

  c_altura   constant pls_integer  := 35;
  c_aspecto  constant number       := 1/sqrt(3);
  c_largura  constant pls_integer  := c_altura / c_aspecto;
  c_pi       constant number       := acos(-1);
  v_distancia number;
  v_padroes   varchar2(30) := '@0GO©o®º"°''.·×xøØ';

  function fi_distancia(p_x number, p_y number) return number
  is
  begin
    return sqrt(p_x*p_x + p_y*p_y);
  end;

begin

  -- Plota o grafico
  for y in (-c_altura)..c_altura loop
    for x in (-c_largura)..c_largura loop
      v_distancia := trunc(fi_distancia(x * c_aspecto, y));
      dbms_output.put(substr(v_padroes, mod(v_distancia, length(v_padroes)) + 1, 1));
    end loop;
    dbms_output.put_line(' ');
  end loop;

end;
/
