{% macro compile__try_cast() -%}

  create or replace function {{ generate_schema_name(target.schema) }}.try_to_date(_in text, _inpat text, inout _out anyelement)
  language plpgsql as
  $func$
  begin
    execute format('SELECT to_date(%L, %L)', $1, $2)
    into  _out;
  exception when others then
    -- do nothing: _out already carries default
  end
  $func$;

{%- endmacro %}