-- Table for reconciliation data to be added to 

CREATE TABLE reconciliation (
  transaction_id TEXT, 
  settlement_date DATETIME, 
  merchant_name TEXT, 
  merchant_account TEXT, 
  mid TEXT, 
  transaction_currency TEXT, 
  transaction_amount REAL, 
  fee_amount REAL, 
  interchange_amount REAL, 
  card_brand TEXT, 
  order_id TEXT, 
  interchange_description TEXT, 
  card_type TEXT, 
  region_relation TEXT, 
  processing_date DATETIME
);

-- Table for transaction data to be added to 

CREATE TABLE transactions (
  transaction_id TEXT, 
  transaction_type TEXT, 
  transaction_status TEXT, 
  created_datetime DATETIME, 
  created_timezone TEXT, 
  settlement_date DATETIME, 
  disbursement_date DATETIME, 
  merchant_account TEXT, 
  currency_iso TEXT, 
  amount_authorised REAL, 
  amount_submitted_for_settlement REAL, 
  order_id TEXT, 
  descriptor_name TEXT, 
  card_brand TEXT, 
  cardholder name TEXT, 
  first_six TEXT, 
  last_four TEXT, 
  expiration_date DATETIME, 
  customer_id TEXT, 
  payment_method_token TEXT, 
  cvv_response TEXT, 
  settlement_amount TEXT, 
  settlement_currency TEXT, 
  settlement_batch_id TEXT, 
  country_of_issuance TEXT, 
  issuing_bank TEXT, 
  commercial TEXT, 
  prepaid TEXT, 
  debit TEXT, 
  product_id TEXT, 
  three_ds_status TEXT, 
  three_ds_eci TEXT, 
  three_ds_version TEXT, 
  three_ds_challenge_requested TEXT, 
  three_ds_exemption_requested TEXT
);

-- Query to show breakdown of TPV and cost by card country of issuance 

WITH total AS (SELECT sum(fee_amount) AS total FROM reconciliation), 
total_TPV AS (SELECT sum(transaction_amount) AS total FROM reconciliation) 
SELECT t.country_of_issuance, 
sum(r.transaction_amount) AS TPV, 
sum(r.transaction_amount)/total_TPV.total*100 AS TPV_as_pct_of_total, 
sum(r.fee_amount)/sum(r.transaction_amount)*-100 AS fee_pct, 
sum(r.fee_amount)/total.total*100 AS fee_pct_of_total 
FROM total, 
total_TPV, 
transactions AS t
INNER JOIN reconciliation AS r
ON t.transaction_id = r.transaction_id 
GROUP BY 1 
ORDER BY 2 desc
;
