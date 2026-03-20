{{ 
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key=['account_id']
    ) 
}}

select
    account_id,
    district_id,
    frequency,
    date,
    current_timestamp as ingested_at
from {{ ref('account') }}