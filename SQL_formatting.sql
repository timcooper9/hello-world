-- Table for reconciliation data to be added to 

CREATE TABLE reconciliation(transaction_id TEXT, settlement_date DATETIME, merchant_name TEXT, merchant_account TEXT, mid TEXT, transaction_currency TEXT, transaction_amount REAL, fee_amount REAL, interchange_amount REAL, card_brand TEXT, order_id TEXT, interchange_description TEXT, card_type TEXT, region_relation TEXT, processing_date DATETIME);

-- Table for transaction data to be added to 

CREATE TABLE transactions(transaction_id TEXT, transaction_type TEXT, transaction_status TEXT, created_datetime DATETIME, created_timezone TEXT, settlement_date DATETIME, disbursement_date DATETIME, merchant_account TEXT, currency_iso TEXT, amount_authorised REAL, amount_submitted_for_settlement REAL, order_id TEXT, descriptor_name TEXT, card_brand TEXT, cardholder name TEXT, first_six TEXT, last_four TEXT, expiration_date DATETIME, customer_id TEXT, payment_method_token TEXT, cvv_response TEXT, settlement_amount TEXT, settlement_currency TEXT, settlement_batch_id TEXT, country_of_issuance TEXT, issuing_bank TEXT, commercial TEXT, prepaid TEXT, debit TEXT, product_id TEXT, three_ds_status TEXT, three_ds_eci TEXT, three_ds_version TEXT, three_ds_challenge_requested TEXT, three_ds_exemption_requested TEXT);

-- Query to show breakdown of TPV and cost by card country of issuance 

sqlite> with total as (select sum(fee_amount) as total from reconciliation), total_TPV as (select sum(transaction_amount) as total from reconciliation) select country_of_issuance, sum(transaction_amount) as TPV, sum(transaction_amount)/total_TPV.total*100 as TPV_as_pct_of_total, sum(fee_amount)/sum(transaction_amount)*-100 as fee_pct, sum(fee_amount)/total.total*100 as fee_pct_of_total from total, total_TPV, transactions inner join reconciliation where transactions.transa
ction_id = reconciliation.transaction_id group by 1 order by 2 desc;
