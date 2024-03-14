--SERIE DE TIEMPO PARA TICKETS RAW
CREATE OR REPLACE TABLE MaggiesDatasetsPoC.transformed_tickets_raw AS
SELECT 
  Violation_Charged_Code,Violation_Description,
  COUNT(*) AS count,
  CONCAT(CAST(Violation_Year AS STRING), '-', LPAD(CAST(Violation_Month AS STRING), 2, '0'), '-01') AS Violation_Date
FROM MaggiesDatasetsPoC.tickets_raw
GROUP BY 
  Violation_Date, Violation_Charged_Code,
  Violation_Description
ORDER BY Violation_Date;
