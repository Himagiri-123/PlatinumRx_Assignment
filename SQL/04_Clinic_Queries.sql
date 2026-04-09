-- Q1: Find the revenue we got from each sales channel in a given year (e.g., 2021)
SELECT sales_channel, SUM(amount) as total_revenue
FROM clinic_sales
WHERE strftime('%Y', datetime) = '2021'
GROUP BY sales_channel;


-- Q2: Find top 10 most valuable customers for a given year (e.g., 2021)
SELECT c.uid, c.name, SUM(cs.amount) as total_spent
FROM clinic_sales cs
JOIN customer c ON cs.uid = c.uid
WHERE strftime('%Y', cs.datetime) = '2021'
GROUP BY c.uid, c.name
ORDER BY total_spent DESC
LIMIT 10;


-- Q3: Find month wise revenue, expense, profit, status for a given year (e.g., 2021)
WITH MonthlyRev AS (
    SELECT strftime('%m', datetime) as month, SUM(amount) as revenue
    FROM clinic_sales
    WHERE strftime('%Y', datetime) = '2021'
    GROUP BY strftime('%m', datetime)
),
MonthlyExp AS (
    SELECT strftime('%m', datetime) as month, SUM(amount) as expense
    FROM expenses
    WHERE strftime('%Y', datetime) = '2021'
    GROUP BY strftime('%m', datetime)
)
SELECT 
    r.month,
    r.revenue as total_revenue,
    COALESCE(e.expense, 0) as total_expense,
    (r.revenue - COALESCE(e.expense, 0)) as profit,
    CASE 
        WHEN (r.revenue - COALESCE(e.expense, 0)) > 0 THEN 'profitable'
        ELSE 'not-profitable'
    END as status
FROM MonthlyRev r
LEFT JOIN MonthlyExp e ON r.month = e.month;


-- Q4: For each city find the most profitable clinic for a given month (e.g., Sep 2021)
WITH Rev AS (
    SELECT cid, SUM(amount) as revenue 
    FROM clinic_sales 
    WHERE strftime('%Y-%m', datetime) = '2021-09' GROUP BY cid
),
Exp AS (
    SELECT cid, SUM(amount) as expense 
    FROM expenses 
    WHERE strftime('%Y-%m', datetime) = '2021-09' GROUP BY cid
),
Profitability AS (
    SELECT c.city, c.clinic_name, 
           (COALESCE(r.revenue, 0) - COALESCE(e.expense, 0)) as profit
    FROM clinics c
    LEFT JOIN Rev r ON c.cid = r.cid
    LEFT JOIN Exp e ON c.cid = e.cid
),
RankedClinics AS (
    SELECT city, clinic_name, profit, 
           RANK() OVER(PARTITION BY city ORDER BY profit DESC) as rnk
    FROM Profitability
)
SELECT city, clinic_name, profit 
FROM RankedClinics 
WHERE rnk = 1;


-- Q5: For each state find the second least profitable clinic for a given month (e.g., Sep 2021)
WITH Rev AS (
    SELECT cid, SUM(amount) as revenue 
    FROM clinic_sales 
    WHERE strftime('%Y-%m', datetime) = '2021-09' GROUP BY cid
),
Exp AS (
    SELECT cid, SUM(amount) as expense 
    FROM expenses 
    WHERE strftime('%Y-%m', datetime) = '2021-09' GROUP BY cid
),
Profitability AS (
    SELECT c.state, c.clinic_name, 
           (COALESCE(r.revenue, 0) - COALESCE(e.expense, 0)) as profit
    FROM clinics c
    LEFT JOIN Rev r ON c.cid = r.cid
    LEFT JOIN Exp e ON c.cid = e.cid
),
RankedClinics AS (
    SELECT state, clinic_name, profit, 
           DENSE_RANK() OVER(PARTITION BY state ORDER BY profit ASC) as rnk
    FROM Profitability
)
SELECT state, clinic_name, profit 
FROM RankedClinics 
WHERE rnk = 2;
