
CREATE OR REPLACE EXTERNAL TABLE `regreport_raw.transactions_ext`
OPTIONS (
  format = 'CSV',
  uris = ['gs://reg-reporting-490417-dev-raw/source_layer/trans.csv'],
  skip_leading_rows = 1
);

CREATE OR REPLACE EXTERNAL TABLE `regreport_raw.account_ext`
OPTIONS (
  format = 'CSV',
  uris = ['gs://reg-reporting-490417-dev-raw/source_layer/account.csv'],
  skip_leading_rows = 1
);

CREATE OR REPLACE EXTERNAL TABLE `regreport_raw.card_ext`
OPTIONS (
  format = 'CSV',
  uris = ['gs://reg-reporting-490417-dev-raw/source_layer/card.csv'],
  skip_leading_rows = 1
);

CREATE OR REPLACE EXTERNAL TABLE `regreport_raw.client_ext`
OPTIONS (
  format = 'CSV',
  uris = ['gs://reg-reporting-490417-dev-raw/source_layer/client.csv'],
  skip_leading_rows = 1
);

CREATE OR REPLACE EXTERNAL TABLE `regreport_raw.disp_ext`
OPTIONS (
  format = 'CSV',
  uris = ['gs://reg-reporting-490417-dev-raw/source_layer/disp.csv'],
  skip_leading_rows = 1
);

CREATE OR REPLACE EXTERNAL TABLE `regreport_raw.district_ext`
OPTIONS (
  format = 'CSV',
  uris = ['gs://reg-reporting-490417-dev-raw/source_layer/district.csv'],
  skip_leading_rows = 1
);

CREATE OR REPLACE EXTERNAL TABLE `regreport_raw.loan_ext`
OPTIONS (
  format = 'CSV',
  uris = ['gs://reg-reporting-490417-dev-raw/source_layer/loan.csv'],
  skip_leading_rows = 1
);

CREATE OR REPLACE EXTERNAL TABLE `regreport_raw.order_ext`
OPTIONS (
  format = 'CSV',
  uris = ['gs://reg-reporting-490417-dev-raw/source_layer/order.csv'],
  skip_leading_rows = 1
);
