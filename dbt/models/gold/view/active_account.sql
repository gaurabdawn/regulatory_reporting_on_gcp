{{
    config (
        materialized = 'view',
        meta = {
            "on_view_exists" : "drop"
            }
    )
}}

select
    account_id,
    district_id,
    frequency,
    date
from {{ source('gold', 'account_snapshot') }}
where dbt_valid_to is null