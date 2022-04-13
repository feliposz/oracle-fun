SELECT lbl
     , val
     , chr(27) || '[' || decode(mod(rownum, 15)+1, 1, 41, 2, 42, 3, 43, 4, 44, 5, 45, 6, 46, 7, 47, 8, 100, 9, 101, 10, 102, 11, 103, 12, 104, 13, 105, 14, 106, 15, 107)  ||'m'
       || substr(lpad(' ', ceil(val / max(val) over () * 100), ' '), 1, 100)
       || chr(27) || '[m'  as chart
  FROM (
        &1
       );
