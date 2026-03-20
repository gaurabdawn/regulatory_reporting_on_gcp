{{
    config (
        materialized = 'view',
        meta = {
            "on_view_exists" : "drop"
            }
    )
}}

select
    client_id,
    birth_date,
    district_id
from {{ source('gold', 'client_snapshot') }}
where dbt_valid_to is null