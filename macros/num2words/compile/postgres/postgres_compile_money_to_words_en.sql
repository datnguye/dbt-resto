{% macro postgres__compile_money_to_words_en() -%}

create or replace function {{var('num2words_schema', 'dbtresto')}}.MoneyToWords_EN ()
returns varchar
as
$$
declare
 result varchar = null;
begin
	{# if func = '+' then
		result =  x + y;
	elsif  func = '-' then
		result = x - y;
	elsif  func = '*' then
	result = x * y;
	elsif  func = '/' then
	result = x / y;
	else
		raise exception 'Invalid function provided';
	end if; #}



	return result;
end
$$
language plpgsql;

{%- endmacro %}