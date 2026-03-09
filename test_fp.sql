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


-------------- CHECK BELOW ------------

WITH latest_status AS (

      SELECT 
          Order_Status.Order_ID AS order_id,
          Order_Status.order_status_id AS order_status_id,
          Order_Status.Timestamp AS timestamp,
          Contact.Contact_time AS contact_time,
          meta_status.status_description AS status_description,
          ROW_NUMBER() OVER (PARTITION BY Order_Status.Order_ID, Contact.Contact_time
                                 ORDER BY Order_Status.Timestamp DESC) AS rnk
       FROM Order_Status
       JOIN Contact
         ON Order_Status.Order_ID = Contact.Order_id
        AND Order_Status.Timestamp < Contact.Contact_time
  LEFT JOIN meta_status
         ON Order_Status.order_status_id = meta_status.order_status_id
  
)

      SELECT 
          order_id,
          order_status_id,
          timestamp,
          contact_time,
          status_description
      FROM latest_status
      WHERE rnk = 1
