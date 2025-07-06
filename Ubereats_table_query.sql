WITH parsed_data AS (
  SELECT
    JSON_KEYS(response.data.menus)[OFFSET(0)] AS menu_id,
    response,
    slug,
    b_name,
    vb_name,
    timestamp,
    DATE(timestamp) AS date,
    MOD(EXTRACT(DAYOFWEEK FROM DATE(timestamp)) + 5, 7) AS days_index 
  FROM `arboreal-vision-339901.take_home_v2.virtual_kitchen_ubereats_hours`
  WHERE ARRAY_LENGTH(JSON_KEYS(response.data.menus)) > 0

),

hours_data AS (
  SELECT
    response,
    slug,
    b_name,
    vb_name,
    timestamp,
    date,
    FORMAT_DATE('%A', date) AS day_name, 
    menu_id,
    JSON_EXTRACT_SCALAR(response.data.menus[menu_id].sections[0].regularHours[0].startTime,'$') AS start_time,
    JSON_EXTRACT_SCALAR(response.data.menus[menu_id].sections[0].regularHours[0].endTime,'$') AS end_time,
    response.data.menus[menu_id].sections[0].regularHours[0].daysBitArray AS days_bit_array,
    days_index
  FROM parsed_data
)

-- Final select
SELECT
  slug,
  b_name,
  vb_name,
  timestamp,
  date,  
  FORMAT_TIME('%H:%M', TIME(PARSE_DATETIME('%H:%M', start_time))) as start_time,
  FORMAT_TIME('%H:%M', TIME(PARSE_DATETIME('%H:%M', end_time))) as end_time,
  day_name,
  days_index
FROM hours_data
;
