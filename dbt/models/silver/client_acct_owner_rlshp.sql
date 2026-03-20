{{
    config (
        materialized = 'table',
        meta = {
            "on_table_exists" : "drop"
            }
    )
}}

select
    client_id,
    account_id
from {{ ref('disposition') }}
where upper(type) = 'OWNER'