SELECT
  TO_JSON(ml_generate_text_result) AS complete_result,
  prompt
FROM
  ML.GENERATE_TEXT(
    MODEL `poc-test-omsg.genai_bq_poc.genai_bq_poc`,
    (
  SELECT
        CONCAT('Can you read the following complaint message and company public response and reply with a new apology from the company?', '', consumer_complaint_narrative, '', company_public_response)
        AS prompt
        from `bigquery-public-data.cfpb_complaints.complaint_database` 
    ),
    STRUCT(
      0.9 AS temperature,
      150 AS max_output_tokens))
LIMIT 20;