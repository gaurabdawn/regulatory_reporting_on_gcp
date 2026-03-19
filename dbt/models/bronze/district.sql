{{
    config (
        materialized = 'table',
        meta = {
            "on_table_exists" : "drop"
            }
    )
}}

select * from {{ source('raw','district_ext') }}