{{ 
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key=['loan_id']
    ) 
}}

select
    loan_id,
    account_id,
    amount,
    payments,
    status
from {{ ref('loan') }}