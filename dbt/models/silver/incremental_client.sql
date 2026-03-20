{{ 
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key=['client_id']
    ) 
}}

select
    client_id,
    safe.parse_date('%y%m%d', cast(birth_number as string)) as birth_date,
    district_id,
    current_timestamp as ingested_at
from {{ ref('client') }}