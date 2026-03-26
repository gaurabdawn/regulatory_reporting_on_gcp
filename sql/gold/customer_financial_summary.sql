CREATE OR REPLACE VIEW regreport_gold.customer_financial_summary AS
SELECT
    c.client_id,
    a.account_id,
    a.district_id,
    a.frequency,
    a.date,
    c.birth_date,
    l.loan_amount,
    l.amount_paid,
    -- Derived fields
    (l.loan_amount - l.amount_paid) AS outstanding_amount,
    SAFE_DIVIDE(l.amount_paid, l.loan_amount) AS repayment_ratio

FROM regreport_gold.user_lending_fum l
LEFT JOIN regreport_gold.active_account a
    ON l.account_id = a.account_id
LEFT JOIN regreport_gold.active_client c
    ON l.client_id = c.client_id;