WITH diff_hours
  AS (SELECT ivr_id
           , start_date
           , LAG(start_date) OVER(PARTITION BY phone_number ORDER BY start_date, ivr_id) AS previous_call_date
           , LEAD(start_date) OVER(PARTITION BY phone_number ORDER BY start_date, ivr_id) AS next_call_date
           , DATETIME_DIFF(LAG(start_date) OVER(PARTITION BY phone_number ORDER BY start_date, ivr_id), start_date, HOUR) AS previous_hour_diff
           , DATETIME_DIFF(LEAD(start_date) OVER(PARTITION BY phone_number ORDER BY start_date, ivr_id), start_date, HOUR) AS next_hour_diff
           , IF(DATETIME_DIFF(LAG(start_date) OVER(PARTITION BY phone_number ORDER BY start_date, ivr_id), start_date, HOUR) > -24, 1, 0) AS repeated_phone_24h
           , IF(DATETIME_DIFF(LEAD(start_date) OVER(PARTITION BY phone_number ORDER BY start_date, ivr_id), start_date, HOUR) < 24, 1, 0) AS cause_recall_phone_24h
        FROM `keepcoding.ivr_calls`)
    , vdn_agg
    AS (SELECT ivr_id
     , vdn_label
           , CASE WHEN STARTS_WITH(vdn_label,'ATC') THEN 'FRONT'
                  WHEN STARTS_WITH(vdn_label,'TECH') THEN 'TECH'
                  WHEN STARTS_WITH(vdn_label,'ABSORPTION') THEN 'ABSORPTION'
                  ELSE 'RESTO'
                  END AS vdn_aggregation
        FROM `keepcoding.ivr_calls`) 
    , dni_cleaning
  AS (SELECT ivr_id
           , document_type
           , document_identification
        FROM `keepcoding.ivr_detail`
       WHERE document_identification <> 'UNKNOWN'
     QUALIFY ROW_NUMBER() OVER (PARTITION BY SAFE_CAST(ivr_id AS STRING) ORDER BY document_identification) = 1)
    , phone_cleaning
  AS (SELECT ivr_id
           , customer_phone
        FROM `keepcoding.ivr_detail`
       WHERE customer_phone <> 'UNKNOWN'
      QUALIFY ROW_NUMBER() OVER(PARTITION BY SAFE_CAST(ivr_id AS STRING) ORDER BY customer_phone) = 1)
    , billing_cleaning
  AS (SELECT ivr_id
           , billing_account_id
        FROM `keepcoding.ivr_detail`
       WHERE billing_account_id <> 'UNKNOWN' AND billing_account_id IS NOT NULL
      QUALIFY ROW_NUMBER() OVER(PARTITION BY SAFE_CAST(ivr_id AS STRING) ORDER BY billing_account_id) = 1)

SELECT detail.ivr_id
     , detail.phone_number
     , detail.ivr_result
     , vdn_agg.vdn_aggregation
     , detail.start_date
     , detail.end_date
     , detail.total_duration
     , detail.customer_segment
     , detail.ivr_language
     , detail.steps_module
     , detail.module_aggregation
     , COALESCE(dni_cleaning.document_type, 'UNKNOWN') AS document_type
     , COALESCE(dni_cleaning.document_identification, 'UNKNOWN') AS document_identification
     , COALESCE(phone_cleaning.customer_phone, 'UNKNOWN') AS customer_phone
     , COALESCE(billing_cleaning.billing_account_id, 'UNKNOWN') AS billing_account_id
     , MAX(IF(detail.module_name = 'AVERIA_MASIVA', 1, 0)) AS masiva_lg 
     , MAX(IF(detail.step_name = 'CUSTOMERINFOBYPHONE.TX' AND detail.step_description_error = 'UNKNOWN',1,0)) AS info_by_phone_lg
     , MAX(IF(detail.step_name = 'CUSTOMERINFOBYDNI.TX' AND detail.step_description_error = 'UNKNOWN',1,0)) AS info_by_dni_lg
     , diff_hours.repeated_phone_24h
     , diff_hours.cause_recall_phone_24h
 FROM `keepcoding.ivr_detail` detail
 LEFT
 JOIN diff_hours
   ON detail.ivr_id = diff_hours.ivr_id
 LEFT
 JOIN vdn_agg
   ON detail.ivr_id = vdn_agg.ivr_id
 LEFT
 JOIN dni_cleaning
   ON detail.ivr_id = dni_cleaning.ivr_id
 LEFT
 JOIN phone_cleaning
   ON detail.ivr_id = phone_cleaning.ivr_id
 LEFT
 JOIN billing_cleaning
   ON detail.ivr_id = billing_cleaning.ivr_id  
GROUP BY detail.ivr_id
    , detail.phone_number
    , detail.ivr_result
    , vdn_agg.vdn_aggregation
    , detail.start_date
    , detail.end_date
    , detail.total_duration
    , detail.customer_segment
    , detail.ivr_language
    , detail.steps_module
    , detail.module_aggregation
    , document_type
    , document_identification
    , customer_phone
    , billing_account_id
    , diff_hours.repeated_phone_24h
    , diff_hours.cause_recall_phone_24h