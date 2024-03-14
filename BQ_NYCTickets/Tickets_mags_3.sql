CREATE OR REPLACE MODEL `poc-test-omsg.MaggiesDatasetsPoC.tickets_model`
OPTIONS
  (model_type = 'ARIMA_PLUS',
   time_series_timestamp_col = 'parsed_date',
   time_series_data_col = 'count',
   time_series_id_col = 'Violation_Description',
   auto_arima_max_order = 5
  ) AS
SELECT
   Violation_Description,count,
   PARSE_DATE('%Y-%m-%d', Violation_Date) AS parsed_date
FROM
  `poc-test-omsg.MaggiesDatasetsPoC.transformed_tickets_raw`;

SELECT
 *
FROM
 ML.ARIMA_EVALUATE(MODEL `poc-test-omsg.MaggiesDatasetsPoC.tickets_model`);

SELECT
 *
FROM
 ML.ARIMA_COEFFICIENTS(MODEL `poc-test-omsg.MaggiesDatasetsPoC.tickets_model`);

#Use your model to forecast multiple time series simultaneously
SELECT
 *
FROM
 ML.FORECAST(MODEL `poc-test-omsg.MaggiesDatasetsPoC.tickets_model`,
                     STRUCT(3 AS horizon, 0.9 AS confidence_level));


