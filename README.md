# dbt-resto
This is dbt package for FUN!

[![integration_tests](https://github.com/datnguye/dbt-resto/actions/workflows/main.yml/badge.svg)](https://github.com/datnguye/dbt-resto/actions/workflows/main.yml)

- Default warehouse: Snowflake
- Supported warehouses:
    - Snowflake
    - SQL Server
    - Postgres

## Developer's Guide
See [integration_tests](./integration_tests/README.md)

## Environment Variables
- DBT_ENV_RUN_DATE:
  - Applicable to models.vietlot.*.mart
  - Pin the date you would like to run the forecast. By default the value is `current_timestamp`
  - Set value:
  ```
  # windows
  set DBT_ENV_RUN_DATE='2022-09-24'
  # linux
  export DBT_ENV_RUN_DATE='2022-09-24'
  ```

## Macros:
### get_table_alias ([source](/macros/config/get_table_alias.sql))
  Suffix the table name with your configured variable `table_suffix`.

  Usage:
  ```sql
  {{ config(alias=dbt_resto.get_table_alias(this)) }}
  ```

### money_to_words ([source](/macros/num2words/money_to_words.sql))
  Convert a number (money) to words e.g. 2000 = two thousand

  Usage:
  ```sql
  select {{ dbt_resto.money_to_words('column', 'en') }} as my_column_name_in_words
  ```

### generate_schema_name ([source](/macros/override_default/generate_schema_name.sql))
  Override the schema strategy. MAKE-A-COPY to your local project under `your-project/macros/` directory.

  If the model has no config `schema` then it will use target.schema to be its schema name, else will use the exact schema name configured.

### dateadd ([source](/macros/sql/datetime/dateadd.sql))
  Add value to date

  Usage:
  ```sql
  select {{ dbt_resto.dateadd('day', 1, 'column') }}
  ```

### datepart ([source](/macros/sql/datetime/datepart.sql))
  Get date part

  Usage:
  ```sql
  select {{ dbt_resto.datepart('column', 'second') }}
  ```

### get_base_times ([source](/macros/sql/datetime/get_base_times.sql))
  Prepare the select statement of the datetime values in each level = hour, minute.

  NOTE: It can genrate per second level but NOT recommend to do so.

  Usage:
  ```sql
  with base_times as (
    {{ dbt_resto.get_base_times('hour') }}
  )
  select * from base_times;

  with base_times as (
    {{ dbt_resto.get_base_times('minute') }}
  )
  select * from base_times;
  ```

### get_time_dimension ([source](/macros/sql/datetime/get_time_dimension.sql))
  Prepare the select statement of all columns required in a time dimension table.

  NOTE: It can genrate per second level but NOT recommend to do so.

  Usage:
  ```sql
  # models/my_model.yml
  {{ dbt_resto.get_time_dimension() }}
  ```

### get_time_key ([source](/macros/sql/datetime/get_time_key.sql))
  Convert the time part to the string of {HOUR}{MINUTE}{SECOND} e.g. 092733

  Usage:
  ```sql
  select {{ dbt_resto.get_time_key('column', parts=['hour','minute','second'], h24=True) }}
  ```

### str_to_date ([source](/macros/sql/datetime/str_to_date.sql))
  Convert a string formatted in a specific pattern to the date value.

  Usage:
  ```sql
  select   {{ dbt_resto.str_to_date('column') }} as date_column
  from     table
  ```

### len ([source](/macros/sql/len.sql))
  Get length of column value

  Usage:
  ```sql
  select   {{ dbt_resto.len('column') }} as column_len
  from     table
  ```


## Generic Tests:
### if_column_value_to_match_regex ([source](/macros/generic_test/if_column_value_to_match_regex.sql))
  Generic test function to check if a column value is matched to a regular experssion.

  Currently support Snowflake only.

  Usage:
  ```sql
  models:
    - name: table_name
      columns:
        - name: column_name
          tests:
            - dbt_resto.if_column_value_to_match_regex:
                regex_expr: '[a-zA-Z]' # matching text only
  ```


## Materialization:
### materialized_view ([source](/macros/materialization/model/materialized_view/materialized_view.sql))
  Model materialization for Materialized View (it's called Indexed View in SQL Server)

  - NOTE - Supported editions:
    - Snowflake Enterprise and above
    - SQL Server all editions

  - NOTE: Use this with knowledge of the Limitations

  Usage:
  - Snowflake

    ```sql
    {{
      config(
        materialized = 'materialized_view'
      )
    }}

    select  *
    from    {{ ref('your_model') }}
    ```
  - SQL Server:

    ```sql
    {{
      config(
        materialized = 'materialized_view',
        unique_key = 'your_model_key',
      )
    }}

    select  *
    from    {{ ref('your_model').include(database=False) }}
    ```
    - The `ref` relation must go with `include(database=False)`
    - The config must have `unique_key`

## Repo Beats
![Alt](https://repobeats.axiom.co/api/embed/d40c2fc125162c2a0d9ccf229fcecda3cd84fc2c.svg "Repobeats analytics image")
