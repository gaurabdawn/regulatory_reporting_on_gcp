{{
    config (
        materialized = 'table',
        meta = {
            "on_table_exists" : "drop"
            }
    )
}}

select
    order_id,
    account_id,
    bank_to,
    account_to,
    amount
from {{ ref('order') }}
where k_symbol is not null