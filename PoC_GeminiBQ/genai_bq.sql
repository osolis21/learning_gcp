CREATE OR REPLACE MODEL
`poc-test-omsg.genai_bq_poc.genai_bq_poc`
REMOTE WITH CONNECTION `projects/poc-test-omsg/locations/us/connections/Gemini-Connection`
OPTIONS (ENDPOINT = 'gemini-pro');# El modelo que se desee usar de Vertex Model Garden

#Crear tabla de prompts
CREATE OR REPLACE TABLE poc-test-omsg.genai_bq_poc.genai_demo_prompts
(
PROMPT STRING,
DATE STRING
);

#Agregar un prompt a la tabla
INSERT INTO  poc-test-omsg.genai_bq_poc.genai_demo_prompts VALUES ('WHEN IS HURRICANE SEASON IN THE CARIBBEAN?','2024-03-21');

#Seleccionar los resultados
SELECT ml_generate_text_llm_result,PROMPT,DATE
FROM
  ML.GENERATE_TEXT(
    MODEL `poc-test-omsg.genai_bq_poc.genai_bq_poc`,
    TABLE `poc-test-omsg.genai_bq_poc.genai_demo_prompts`,
    STRUCT(
      0.4 AS temperature, 100 AS max_output_tokens, 0.5 AS top_p, 40 AS top_k, TRUE AS flatten_json_output));