{% snapshot account_snapshot %}

{{
    config(
        target_schema='regreport_gold',
        unique_key='account_id',
        strategy='check',
        check_cols=['date', 'frequency'],
        invalidate_hard_deletes=True
    )
}}

select
    account_id,
    district_id,
    frequency,
    date
from {{ source('silver', 'incremental_account') }}

{% endsnapshot %}