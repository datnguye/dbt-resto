# dbt-resto
This is dbt package for everyone
- Default warehouse: Snowflake
- Supported warehouses:
    - Snowflake
    - SQL Server

## Developer's Guide
See [integration_tests](./integration_tests/README.md)

## Macros:
### get_table_alias ([source](/macros/config/get_table_alias.sql))
  Suffix the table name with your configured variable `table_suffix`.

  Usage:
  ```
  {{ config(alias=dbt_resto.get_table_alias(this)) }}
  ```

### money_to_words ([source](/macros/num2words/money_to_words.sql))
  Convert a number (money) to words e.g. 2000 = two thousand

  Usage:
  ```
  select {{ dbt_resto.money_to_words('my_column_name', 'en') }} as my_column_name_in_words
  ```

### generate_schema_name ([source](/macros/override_default/generate_schema_name.sql))
  Override the schema strategy. MAKE-A-COPY to your local project under `your-project/macros/` directory.

  If the model has no config `schema` then it will use target.schema to be its schema name, else will use the exact schema name configured.

### get_base_times ([source](/macros/sql/get_base_times.sql))
  Prepare the select statement of the datetime values in each level = hour, minute.

  Usage:
  ```
  with base_times as (
    {{ dbt_resto.get_base_times('hour') }}
  )
  select * from base_times;

  with base_times as (
    {{ dbt_resto.get_base_times('minute') }}
  )
  select * from base_times;
  ```

### get_time_dimension ([source](/macros/sql/get_time_dimension.sql))
  Prepare the select statement of all columns required in a time dimension table.

  Usage:
  ```
  # models/my_model.yml
  {{ get_time_dimension() }}
  ```

### str_to_date ([source](/macros/sql/str_to_date.sql))
  Convert a string formatted in a specific pattern to the date value.

  Usage:
  ```
  select   {{ str_to_date(column) }} as date_column
  from     table
  ```


## Generic Tests:
### test_column_values_to_match_regex ([source](/macros/generic_test/test_column_values_to_match_regex.sql))
  Generic test function to check if a column value is matched to a regular experssion.

  Currently support Snowflake only.

  Usage:
  ```
  models:
    - name: table_name
      columns:
        - name: column_name
          tests:
            - dbt_resto.test_column_values_to_match_regex:
                regex_expr: '[a-zA-Z]' # matching text only
  ```