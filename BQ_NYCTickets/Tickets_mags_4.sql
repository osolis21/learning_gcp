-- Crear una tabla nueva sin la columna Violation_Charged_Code
CREATE OR REPLACE TABLE `poc-test-omsg.MaggiesDatasetsPoC.transformed_tickets_no_code` AS
SELECT
  Violation_Description,
  PARSE_TIMESTAMP('%Y-%m-%d', Violation_Date) AS Violation_Date,
  count
FROM
  `poc-test-omsg.MaggiesDatasetsPoC.transformed_tickets_raw`;

-- Insertar los resultados del segundo query en la tabla nueva
INSERT INTO `poc-test-omsg.MaggiesDatasetsPoC.transformed_tickets_no_code`
SELECT
  Violation_Description,
  forecast_timestamp AS Violation_Date,
  CAST(ROUND(forecast_value) AS INT64) AS count
FROM
  ML.FORECAST(MODEL `poc-test-omsg.MaggiesDatasetsPoC.tickets_model`,
              STRUCT(3 AS horizon, 0.9 AS confidence_level));
