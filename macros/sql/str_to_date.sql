{#/*
	Convert str to date by given the date format
	Usage:
		select 	{{ str_to_date(column) }} as date_column
		from 		table
*/#}

{% macro str_to_date(column_name, pattern='yyyymmdd') %}
	{{ return(adapter.dispatch('str_to_date', 'dbt_resto')(column_name, pattern)) }}
{% endmacro %}

{% macro default__str_to_date(column_name, pattern) -%}
  
	try_to_date({{column_name}}::varchar, '{{pattern|upper}}')

{%- endmacro %}

{% macro sqlserver__str_to_date(column_name, pattern) -%}

	try_convert(date, convert(varchar, {{column_name}}), {{ sqlserver__get_format_number(pattern) }})

{%- endmacro %}


{% macro sqlserver__get_format_number(pattern) %}

  {#--https://www.mssqltips.com/sqlservertip/1145/date-and-time-conversions-using-sql-server/#}
	{% if pattern == 'mm/dd/yy' %} 			{{ return(1) }} 	{% endif %}
	{% if pattern == 'yy.mm.dd' %} 			{{ return(2) }} 	{% endif %}
	{% if pattern == 'dd/mm/yy' %} 			{{ return(3) }} 	{% endif %}
	{% if pattern == 'dd.mm.yy' %} 			{{ return(4) }} 	{% endif %}
	{% if pattern == 'dd-mm-yy' %} 			{{ return(5) }} 	{% endif %}
	{% if pattern == 'dd-Mon-yy' %} 		{{ return(6) }} 	{% endif %}
	{% if pattern == 'Mon dd, yy' %} 		{{ return(7) }} 	{% endif %}
	{% if pattern == 'mm-dd-yy' %} 			{{ return(10) }}	{% endif %}
	{% if pattern == 'yy/mm/dd' %} 			{{ return(11) }}	{% endif %}
	{% if pattern == 'yymmdd' %} 				{{ return(12) }}	{% endif %}
	{% if pattern == 'yyyy-mm-dd' %} 		{{ return(23) }}	{% endif %}
	{% if pattern == 'mm/dd/yyyy' %} 		{{ return(101) }} {% endif %}
	{% if pattern == 'yyyy.mm.dd' %} 		{{ return(102) }} {% endif %}
	{% if pattern == 'dd/mm/yyyy' %} 		{{ return(103) }} {% endif %}
	{% if pattern == 'dd.mm.yyyy' %} 		{{ return(104) }} {% endif %}
	{% if pattern == 'dd-mm-yyyy' %} 		{{ return(105) }} {% endif %}
	{% if pattern == 'dd Mon yyyy' %} 	{{ return(106) }} {% endif %}
	{% if pattern == 'Mon dd, yyyy' %} 	{{ return(107) }} {% endif %}
	{% if pattern == 'mm-dd-yyyy' %} 		{{ return(110) }} {% endif %}
	{% if pattern == 'yyyy/mm/dd' %} 		{{ return(111) }} {% endif %}
										{#--'yyyymmdd'#} 	{{ return(112) }} 

{% endmacro %}