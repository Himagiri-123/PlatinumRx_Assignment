-- Q1: For every user in the system, get the user_id and last booked room_no
SELECT user_id, room_no
FROM (
    SELECT user_id, room_no,
    ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY booking_date DESC) as rn
    FROM bookings
) tmp
WHERE rn = 1;


-- Q2: Get booking_id and total billing amount of every booking created in November, 2021
SELECT b.booking_id, SUM(bc.item_quantity * i.item_rate) as total_billing_amount
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE strftime('%Y-%m', b.booking_date) = '2021-11'
GROUP BY b.booking_id;


-- Q3: Get bill_id and bill amount of all the bills raised in October, 2021 having bill amount > 1000
SELECT bc.bill_id, SUM(bc.item_quantity * i.item_rate) as bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE strftime('%Y-%m', bc.bill_date) = '2021-10'
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000;


-- Q4: Determine the most ordered and least ordered item of each month of year 2021
WITH MonthlyCounts AS (
    SELECT 
        strftime('%m', bc.bill_date) as month,
        bc.item_id,
        SUM(bc.item_quantity) as total_qty
    FROM booking_commercials bc
    WHERE strftime('%Y', bc.bill_date) = '2021'
    GROUP BY strftime('%m', bc.bill_date), bc.item_id
),
RankedItems AS (
    SELECT 
        month, 
        item_id, 
        total_qty,
        RANK() OVER(PARTITION BY month ORDER BY total_qty DESC) as rank_most,
        RANK() OVER(PARTITION BY month ORDER BY total_qty ASC) as rank_least
    FROM MonthlyCounts
)
SELECT month, item_id, 
       CASE 
           WHEN rank_most = 1 THEN 'Most Ordered'
           WHEN rank_least = 1 THEN 'Least Ordered'
       END as order_status
FROM RankedItems
WHERE rank_most = 1 OR rank_least = 1;


-- Q5: Find the customers with the second highest bill value of each month of year 2021
WITH MonthlyBills AS (
    SELECT 
        strftime('%m', bc.bill_date) as month,
        b.user_id,
        SUM(bc.item_quantity * i.item_rate) as total_bill
    FROM booking_commercials bc
    JOIN bookings b ON bc.booking_id = b.booking_id
    JOIN items i ON bc.item_id = i.item_id
    WHERE strftime('%Y', bc.bill_date) = '2021'
    GROUP BY strftime('%m', bc.bill_date), b.user_id, bc.bill_id
),
RankedBills AS (
    SELECT 
        month, 
        user_id, 
        total_bill,
        DENSE_RANK() OVER(PARTITION BY month ORDER BY total_bill DESC) as rank
    FROM MonthlyBills
)
SELECT month, user_id, total_bill
FROM RankedBills
WHERE rank = 2;