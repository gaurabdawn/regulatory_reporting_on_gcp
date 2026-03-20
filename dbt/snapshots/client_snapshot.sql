{% snapshot client_snapshot %}

{{
    config(
        target_schema='regreport_gold',
        unique_key='client_id',
        strategy='check',
        check_cols=['district_id'],
        invalidate_hard_deletes=True
    )
}}

select
    client_id,
    birth_date,
    district_id
from {{ source('silver', 'incremental_client') }}

{% endsnapshot %}