SELECT
  ml_generate_text_result['candidates'][0]['content']['parts'][0]['text'],
  ml_generate_text_result, prompt
FROM
  ML.GENERATE_TEXT(
    MODEL `playground_us.martina_llm_model_g`,
    (
  SELECT
        CONCAT('Can you read the  the following commit message and subject and determine for each record whether the intent of the commit   was to  fix the code ,  revert it to previous version or neither of something else. Reply with categories: revert, fix, neither ?',' ', subject,' ' ,message)
        AS prompt
        from `bigquery-public-data.github_repos.commits` where repo_name[0] like 'kiwicom%'
    ),
    STRUCT(
      0.9 AS temperature,
      150 AS max_output_tokens));