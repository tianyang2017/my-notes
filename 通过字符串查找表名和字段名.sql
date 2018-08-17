declare
  v_Sql   varchar2(2000);
  v_count number;
begin
  for xx in (select t.OWNER, t.TABLE_NAME, t.COLUMN_NAME
               from dba_tab_columns t
              where t.OWNER = 'HIST') loop
    --用户名
    begin
      v_Sql := 'select count(1) from ' || xx.owner || '.' || xx.table_name ||
               ' where ' || xx.column_name ||
               ' = ''0001MG1000000005X21Y'' '; --输入的参数
      execute immediate v_Sql
        into v_count;
      if (v_count >= 1) then
        dbms_output.put_line('update ' || xx.table_name ||
                             ' set ts=''2016-07-26 22:22:22'',' ||
                             xx.column_name ||
                             ' = ''0001MG1000000005X21V'' where ' ||
                             xx.column_name ||
                             '=''0001MG1000000005X21Y'';');
      end if;
    exception
      when others then
        null;
    end;
  end loop;
end;
