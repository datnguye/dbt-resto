begin;
    
        
        
    

    

    merge into vietlot_power655.mart.dim_date as DBT_INTERNAL_DEST
        using vietlot_power655.mart.dim_date__dbt_tmp as DBT_INTERNAL_SOURCE
        on 
            DBT_INTERNAL_SOURCE.box_date = DBT_INTERNAL_DEST.box_date
        

    
    when matched then update set
        "DATE_KEY" = DBT_INTERNAL_SOURCE."DATE_KEY","BOX_DATE" = DBT_INTERNAL_SOURCE."BOX_DATE","BOX_DAY" = DBT_INTERNAL_SOURCE."BOX_DAY","BOX_WEEK" = DBT_INTERNAL_SOURCE."BOX_WEEK","BOX_MONTH" = DBT_INTERNAL_SOURCE."BOX_MONTH","BOX_MONTH_NAME" = DBT_INTERNAL_SOURCE."BOX_MONTH_NAME","BOX_YEAR" = DBT_INTERNAL_SOURCE."BOX_YEAR"
    

    when not matched then insert
        ("DATE_KEY", "BOX_DATE", "BOX_DAY", "BOX_WEEK", "BOX_MONTH", "BOX_MONTH_NAME", "BOX_YEAR")
    values
        ("DATE_KEY", "BOX_DATE", "BOX_DAY", "BOX_WEEK", "BOX_MONTH", "BOX_MONTH_NAME", "BOX_YEAR")

;
    commit;