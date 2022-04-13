declare

  c_altura   constant pls_integer  := 25;
  c_aspecto  constant number       := 0.5; --1/sqrt(3);
  c_largura  constant pls_integer  := c_altura / c_aspecto;
  c_pi       constant number       := acos(-1);
  --c_car_ang  constant varchar2(36) := 'x!+\@"/#:*|$(%-&)*=';
  c_car_ang  constant varchar2(36) := '                   ';
  --c_car_ang  constant varchar2(72) := '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%"&*()abcdefghijklmnopqrstuvwxyz';
  v_delta_x  number;
  v_delta_y  number;
  v_angulo   number;
  v_pos      number;
  v_x1       number;
  v_x2       number;
  v_legenda_plotada   boolean;
  v_qtde     number;
  v_total    number;

  type r_legenda is record ( x number, y number, texto varchar2(50) );
  type t_legenda is table of r_legenda index by pls_integer;
  v_legenda t_legenda;

  type r_dados is record ( lbl varchar2(50), val number, angulo_min number, angulo_max number );
  type t_dados is table of r_dados index by pls_integer;
  v_dados t_dados;

  type t_cor is table of varchar2(20) index by pls_integer;
  v_cor t_cor;

  cur_dados sys_refcursor;

  function fi_distancia(p_x number, p_y number) return number
  is
  begin
    return sqrt(p_x*p_x + p_y*p_y);
  end;

  function fi_angulo(p_delta_x number, p_delta_y number) return number
  is
  begin
    return mod(360 + atan2(p_delta_y, p_delta_x) * 180 / c_pi, 360);
  end;

begin

  v_total := 0;
  v_qtde := 0;

  v_cor(01) := chr(27) || '[40;97m';
  v_cor(02) := chr(27) || '[41;97m';
  v_cor(03) := chr(27) || '[42;97m';
  v_cor(04) := chr(27) || '[43;97m';
  v_cor(05) := chr(27) || '[44;97m';
  v_cor(06) := chr(27) || '[45;97m';
  v_cor(07) := chr(27) || '[46;97m';
  v_cor(08) := chr(27) || '[47;30m';
  v_cor(09) := chr(27) || '[100;97m';
  v_cor(10) := chr(27) || '[101;97m';
  v_cor(11) := chr(27) || '[102;97m';
  v_cor(12) := chr(27) || '[103;97m';
  v_cor(13) := chr(27) || '[104;97m';
  v_cor(14) := chr(27) || '[105;97m';
  v_cor(15) := chr(27) || '[106;97m';
  v_cor(16) := chr(27) || '[107;30m';

  -- Obtem dados a partir de uma query qualquer (primeira coluna = lbl, segunda = val)
  open cur_dados for '&1';

  loop
    v_qtde := v_qtde + 1;
    fetch cur_dados into v_dados(v_qtde).lbl, v_dados(v_qtde).val;
    if cur_dados%notfound then
      v_qtde := v_qtde - 1;
      exit;
    end if;
    v_total := v_total + v_dados(v_qtde).val;
  end loop;

  -- Calcula angulos
  v_angulo := 0;
  for i in 1..v_qtde loop
    v_dados(i).angulo_min := v_angulo;
    v_angulo := v_angulo + (v_dados(i).val / v_total * 360);
    v_dados(i).angulo_max := v_angulo;
  end loop;

  -- Calcula posicao das legendas
  for i in v_dados.first..v_dados.last loop
    v_angulo := (v_dados(i).angulo_max + v_dados(i).angulo_min) / 2;
    --v_legenda(i).x := trunc(c_largura * 0.575 * cos(v_angulo / 360 * 2 * c_pi));
    --v_legenda(i).y := trunc(c_altura * 0.575 * sin(v_angulo / 360 * 2 * c_pi));
    v_legenda(i).x := trunc(c_largura * 0.8 * cos(v_angulo / 360 * 2 * c_pi));
    v_legenda(i).y := trunc(c_altura * 0.8 * sin(v_angulo / 360 * 2 * c_pi));
    v_legenda(i).texto := '[ ' || v_dados(i).lbl || ' = ' || round(v_dados(i).val, 2) || ' ]';
    --v_legenda(i).texto := '[ ' || v_dados(i).val || ' ]';
  end loop;
  -- TODO: Tratar legendas que se sobrepoem!!!

  -- Plota o grafico caracter por caracter
  for y in (-c_altura)..c_altura loop
    for x in (-c_largura)..c_largura loop
      v_legenda_plotada := false;

      -- Determina se a a posicao de uma legenda
      for i in v_legenda.first..v_legenda.last loop
        -- Centraliza a legenda
        v_x1 := v_legenda(i).x - trunc(length(v_legenda(i).texto) / 2);
        v_x2 := v_x1 + length(v_legenda(i).texto) - 1;
        if y = v_legenda(i).y and x between v_x1 and v_x2 then
          v_legenda_plotada := true;
          dbms_output.put(chr(27) || '[m' || substr(v_legenda(i).texto, x - v_x1 + 1, 1));
          exit;
        end if;
      end loop;

      if not v_legenda_plotada then
        if fi_distancia(x * c_aspecto, y) between c_altura*0.2 and c_altura*0.95 then
          v_angulo := fi_angulo(x / c_largura, y / c_altura);
          for i in v_dados.first..v_dados.last loop
            if v_angulo >= v_dados(i).angulo_min and v_angulo < v_dados(i).angulo_max then
              v_pos := i;
              exit;
            end if;
          end loop;
          if v_pos > length(c_car_ang) then
            v_pos := mod(v_pos, length(c_car_ang));
          end if;
          --v_pos := trunc(v_angulo / 360 * length(c_car_ang)) + 1;
          dbms_output.put(v_cor(MOD(v_pos, v_cor.COUNT) + 1));
          dbms_output.put(substr(c_car_ang, v_pos, 1));
        else
          dbms_output.put(chr(27) || '[m ');
        end if;
      end if;

    end loop;
    dbms_output.put_line(chr(27) || '[m');
  end loop;

end;
/
