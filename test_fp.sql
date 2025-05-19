-- test fp Junior BI Analyst

WITH LatestStatus AS (
  SELECT
    OS.order_id,
    OS.order_status_id,
    OS.timestamp,
    C.Contact_time,
    MS.status_description,
    ROW_NUMBER() OVER (PARTITION BY OS.order_id ORDER BY OS.timestamp DESC) AS RN
FROM order_status OS 
JOIN contact C
  ON OS.order_id = C.order_id
 AND OS.timestamp < C.contact_time
LEFT JOIN meta_status MS
       ON OS.order_status_id = MS.order_status_id
)
SELECT
  LS.order_id,
  LS.order_status_id,
  LS.status_description AS last_order_status_before_contact

FROM LatestStatus LS
WHERE LS.RN = 1;
