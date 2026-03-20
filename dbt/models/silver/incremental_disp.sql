{{ 
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key=['disp_id']
    ) 
}}

select
    disp_id,
    client_id,
    account_id,
    type,
    current_timestamp as ingested_at
from {{ ref('disposition') }}

