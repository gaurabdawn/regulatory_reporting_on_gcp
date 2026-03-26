{{
    config (
        materialized = 'table',
        meta = {
            "on_table_exists" : "drop"
            }
    )
}}

with active_acct as (
    select
        ca.client_id,
        ca.account_id
    from {{ ref('client_acct_owner_rlshp') }} ca 
    inner join {{ source('gold', 'account_snapshot') }} acct
        on ca.account_id = acct.account_id
    where acct.dbt_valid_to is null
)

select
    active_acct.client_id,
    active_acct.account_id,
    loan.amount as loan_amount,
    loan.payments as amount_paid,
    loan.amount - loan.payments as amount_to_be_paid
from active_acct
left join {{ ref('incremental_loan') }} loan
    on active_acct.account_id = loan.account_id
where loan.amount is not null
