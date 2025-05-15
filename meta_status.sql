-- meta_status

CREATE TABLE meta_status (
Order_status_ID int,
status_description varchar(255)
)
INSERT INTO meta_status (order_status_id, status_description)
VALUES (1, 'desc1'),
(2, 'desc2'),
(3, 'desc3'),
(4, 'desc4'),
(5, 'desc5');
