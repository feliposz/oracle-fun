begin
  -- Reset colors
  dbms_output.put_line(chr(27) || '[m');

  -- Clear screen
  --dbms_output.put_line(chr(27) || '[2J');

  -- Reset cursor
  --dbms_output.put_line(chr(27) || '[0;0H');

  dbms_output.put('         ');
  for fg in 30..37 loop
    dbms_output.put('FG ' || RPAD(fg, 6, ' '));
  end loop;

  for fg in 90..97 loop
    dbms_output.put('FG ' || RPAD(fg, 6, ' '));
  end loop;

  dbms_output.put_line(' ');

  for bg in 40..47 loop
    dbms_output.put(chr(27) || '[mBG  ' || bg || ' - ' || chr(27) || '[' || bg || 'm');
    for fg in 30..37 loop
      dbms_output.put(chr(27) || '[' || fg || ';' || bg || 'm[' || bg || ';' || fg || 'm ' || chr(27) || '[m ');
    end loop;

    for fg in 90..97 loop
      dbms_output.put(chr(27) || '[' || fg || ';' || bg || 'm[' || bg || ';' || fg || 'm ' || chr(27) || '[m ');
    end loop;

    dbms_output.put_line(' ');
  end loop;

  for bg in 100..107 loop
    dbms_output.put(chr(27) || '[mBG ' || bg || ' - ' || chr(27) || '[' || bg || 'm');
    for fg in 30..37 loop
      dbms_output.put(chr(27) || '[' || fg || ';' || bg || 'm[' || bg || ';' || fg || 'm' || chr(27) || '[m ');
    end loop;

    for fg in 90..97 loop
      dbms_output.put(chr(27) || '[' || fg || ';' || bg || 'm[' || bg || ';' || fg || 'm' || chr(27) || '[m ');
    end loop;

    dbms_output.put_line(' ');
  end loop;

  -- Reset colors
  dbms_output.put_line(chr(27) || '[m');

  dbms_output.put_line('Sample PL/SQL:');
  dbms_output.put_line('  exec dbms_output.put_line(chr(27) || ''[45;93m'' || ''Color example'' || chr(27) || ''[m'');');
  dbms_output.put_line(' ');
  dbms_output.put_line('Sample script (Prompt):');
  dbms_output.put_line('  prompt [107;94mCtrl+[[m[45;93mColor example[107;94mCtrl+[[m[m');
  dbms_output.put_line(' ');
end;
/

--@ansi_reset_color
