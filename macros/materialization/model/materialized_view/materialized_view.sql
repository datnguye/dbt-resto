{% materialization materialized_view, default -%}

  {#-- 1. Prepare the database for the new model #}
  {%- set identifier = model['alias'] -%}
  {%- set old_relation = adapter.get_relation(database=database, schema=schema, identifier=identifier) -%}
  {%- set target_relation = this -%}

  {#-- 2. Run pre-hooks #}
  {{ run_hooks(pre_hooks, inside_transaction=False) }}

  {#-- 3. Execute any sql required to implement the desired materialization #}
  {%- if old_relation -%}
    {% do adapter.drop_relation(old_relation) %}
  {%- endif -%}

  -- BEGIN transaction
  {{ run_hooks(pre_hooks, inside_transaction=True) }}

  {% call statement('main') -%}
    {{ dbt_resto.create_materialized_view_as(target_relation, sql) }}
  {%- endcall %}

  {% do persist_docs(target_relation, model) %}

  {{ adapter.commit() }}
  -- COMMIT transaction

  {#-- 4. Run post-model hooks #}
  {{ run_hooks(post_hooks, inside_transaction=False) }}

  {#-- 5. Clean up the database as required #}
  -- Nothing to clean up

  {#-- 6. Update the Relation cache #}
  {{ return({'relations': [target_relation]}) }}

{%- endmaterialization %}