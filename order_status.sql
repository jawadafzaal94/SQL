-- order_status fp_t1

CREATE TABLE order_status (
Order_ID int,
order_status_id int,
Timestamp DATETIME
)
INSERT INTO Order_Status (Order_ID, order_status_id, Timestamp)
VALUES (1, 2, '2019-12-24 00:00:00'),
(1, 3, '2019-12-24 00:10:00'),
(1, 4, '2019-12-24 00:30:00'),
(1, 5, '2019-12-24 01:00:00'),
(2, 2, '2019-12-24 15:00:00'),
(2, 3, '2019-12-24 15:07:00'),
(2, 9, '2019-12-24 15:10:00'),
(2, 8, '2019-12-24 15:33:00'),
(2, 10, '2019-12-24 16:00:00'),
(4, 4, '2019-12-24 19:00:00'),
(4, 2, '2019-12-24 19:30:00'),
(4, 3, '2019-12-24 19:32:00'),
(4, 4, '2019-12-24 19:40:00'),
(4, 5, '2019-12-24 19:45:00'),
(5, 2, '2019-01-28 19:30:00'),
(5, 6, '2019-01-28 19:48:00');
