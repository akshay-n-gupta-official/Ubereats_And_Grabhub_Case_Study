
WITH t AS (
  SELECT 
    gh.slug AS `Grubhub_slug`,
    FORMAT('%s - %s', gh.start_time, gh.end_time) AS `Virtual_Restaurant_Business_Hours`,
    ub.slug AS `Uber_Eats_slug`,
    FORMAT('%s - %s', ub.start_time, ub.end_time) AS `Uber_Eats_Business_Hours`,
    CASE 
      WHEN gh.start_time = ub.start_time AND gh.end_time = ub.end_time THEN "In Range"
      WHEN (ABS(TIMESTAMP_DIFF(
                TIMESTAMP(DATETIME(gh.date, PARSE_TIME('%H:%M', gh.start_time))), 
                TIMESTAMP(DATETIME(ub.date, PARSE_TIME('%H:%M', ub.start_time))), MINUTE)) +
            ABS(TIMESTAMP_DIFF(
                TIMESTAMP(DATETIME(gh.date, PARSE_TIME('%H:%M', gh.end_time))), 
                TIMESTAMP(DATETIME(ub.date, PARSE_TIME('%H:%M', ub.end_time))), MINUTE))) <= 5
        THEN "Out of Range with 5 mins difference"
      ELSE "Out of Range"
    END AS is_out_range,

    gh.timestamp AS gh_timestamp,
    ub.timestamp AS ub_timestamp,

    Dense_Rank() OVER (
      PARTITION BY gh.b_name, gh.vb_name
      ORDER BY ub.date DESC
    ) AS rank_num

  FROM `uplifted-light-447306-d9.Loop_AI.final_grubhub_dataset` gh
  JOIN `uplifted-light-447306-d9.Loop_AI.final_ubereats_dataset` ub 
    ON gh.b_name = ub.b_name 
    AND gh.vb_name = ub.vb_name 
    AND gh.date = ub.date
)

SELECT t.Grubhub_slug,t.Virtual_Restaurant_Business_Hours,t.Uber_Eats_slug,t.Uber_Eats_Business_Hours,t.is_out_range
FROM t
WHERE rank_num = 1
;
