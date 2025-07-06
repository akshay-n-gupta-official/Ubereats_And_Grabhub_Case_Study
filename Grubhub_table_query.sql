WITH t AS (
  SELECT 
    slug,
    b_name,
    vb_name,
    timestamp,
    DATE(timestamp) AS date,
    JSON_EXTRACT_SCALAR(response.today_availability_by_catalog.STANDARD_DELIVERY[0].from, '$') AS start_time_raw,
    JSON_EXTRACT_SCALAR(response.today_availability_by_catalog.STANDARD_DELIVERY[0].to, '$') AS end_time_raw
  FROM 
    `arboreal-vision-339901.take_home_v2.virtual_kitchen_grubhub_hours`
  ORDER BY slug, date DESC 
  
)

SELECT
  slug, 
  b_name,
  vb_name,
  timestamp,
  date,
  FORMAT_DATE('%A', date) AS day_name,
  FORMAT_TIME('%H:%M', TIME(PARSE_DATETIME('%H:%M:%E*S', start_time_raw))) AS start_time,
  FORMAT_TIME('%H:%M', TIME(PARSE_DATETIME('%H:%M:%E*S', end_time_raw))) AS end_time
FROM t
where t.start_time_raw is not null;