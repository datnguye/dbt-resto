begin;
    
        
        
    

    

    merge into vietlot_power655.mart.fact_result as DBT_INTERNAL_DEST
        using vietlot_power655.mart.fact_result__dbt_tmp as DBT_INTERNAL_SOURCE
        on 
            DBT_INTERNAL_SOURCE.fact_result_key = DBT_INTERNAL_DEST.fact_result_key
        

    
    when matched then update set
        "FACT_RESULT_KEY" = DBT_INTERNAL_SOURCE."FACT_RESULT_KEY","BOX_KEY" = DBT_INTERNAL_SOURCE."BOX_KEY","PRIZE_KEY" = DBT_INTERNAL_SOURCE."PRIZE_KEY","DATE_KEY" = DBT_INTERNAL_SOURCE."DATE_KEY","NO_OF_WON" = DBT_INTERNAL_SOURCE."NO_OF_WON","PRIZE_VALUE" = DBT_INTERNAL_SOURCE."PRIZE_VALUE","PRIZE_PAID" = DBT_INTERNAL_SOURCE."PRIZE_PAID","IS_PRIZE_TAKEN" = DBT_INTERNAL_SOURCE."IS_PRIZE_TAKEN"
    

    when not matched then insert
        ("FACT_RESULT_KEY", "BOX_KEY", "PRIZE_KEY", "DATE_KEY", "NO_OF_WON", "PRIZE_VALUE", "PRIZE_PAID", "IS_PRIZE_TAKEN")
    values
        ("FACT_RESULT_KEY", "BOX_KEY", "PRIZE_KEY", "DATE_KEY", "NO_OF_WON", "PRIZE_VALUE", "PRIZE_PAID", "IS_PRIZE_TAKEN")

;
    commit;