-- =====================================================
-- BASIC EDA
-- =====================================================
-- create database
create database finance
-- database select 
use finance

-- Q1. Find the total number of customers.

SELECT COUNT(*) AS total_customers
FROM customers;

------------------------------------------------------------

-- Q2. Find the total number of transactions.

SELECT COUNT(*) AS total_transactions
FROM transactions;

------------------------------------------------------------
-- Q3. Find the total transaction amount.

SELECT SUM(amount) as total_transaction_amount
FROM transactions;
-----------------------------------------------------------
-- Q4. Find the average transaction amount.

select avg(amount) as average_transactions_amount
 from transactions 

------------------------------------------------------------
-- Q5. Find the maximum transaction amount.

select max(amount) as maximum_transaction_amount 
from transactions 

------------------------------------------------------------

-- Q6. Find the minimum transaction amount.

SELECT MIN(amount) AS minimum_transaction
FROM transactions;

-----------------------------------------------------------

-- Q7. Find the total fee collected.

SELECT SUM(fee_amount) AS fee_collection
FROM transactions;

-----------------------------------------------------------

-- Q8. Find the total tax collected.

SELECT SUM(tax_amount) AS tax_collections
FROM transactions;

-----------------------------------------------------------

-- Q9. Find the total number of successful transactions.

SELECT COUNT(transaction_status) AS successful_transactions
FROM transactions
WHERE transaction_status = 'success';

-----------------------------------------------------------

-- Q10. Find the total number of failed transactions.

SELECT COUNT(transaction_status) AS failed_transactions
FROM transactions
WHERE transaction_status = 'failed';

-----------------------------------------------------------

-- Q11. Find the total number of pending transactions.

SELECT COUNT(transaction_status) AS pending_transactions
FROM transactions
WHERE transaction_status = 'pending';

-----------------------------------------------------------

-- Q12. Find the total number of transactions by status.

SELECT
    transaction_status,
    COUNT(*) AS total_transactions
FROM transactions
GROUP BY transaction_status
ORDER BY total_transactions DESC;

-----------------------------------------------------------

-- Q13. Find the number of unique accounts.

SELECT COUNT(DISTINCT account_id) AS unique_accounts
FROM transactions;

-----------------------------------------------------------

-- Q14. Find the number of unique merchant categories.

SELECT COUNT(DISTINCT merchant_category) AS merchant_categories
FROM transactions;

-----------------------------------------------------------

-- Q15. Find the number of unique transaction channels.

SELECT COUNT(DISTINCT channel) AS transaction_channels
FROM transactions;

-----------------------------------------------------------
-- =====================================================
-- BUSINESS ANALYSIS
-- =====================================================

-- Q16. Find total transaction amount by customer segment.

SELECT C.customer_segment, SUM(amount) AS total_transaction_amount
FROM customers C
INNER JOIN transactions T
ON C.customer_id = T.customer_id
GROUP BY C.customer_segment;

-----------------------------------------------------------

-- Q17. Find total transaction amount by gender.

SELECT C.gender, SUM(amount) AS total_amount
FROM customers C
INNER JOIN transactions T
ON C.customer_id = T.customer_id
GROUP BY C.gender;

-----------------------------------------------------------

-- Q18. Find total transaction amount by state.

SELECT C.state, SUM(amount) AS total_amount
FROM customers C
INNER JOIN transactions T
ON C.customer_id = T.customer_id
GROUP BY C.state;

-----------------------------------------------------------

-- Q19. Find total transaction amount by occupation.

SELECT C.occupation, SUM(amount) AS total_amount
FROM customers C
INNER JOIN transactions T
ON C.customer_id = T.customer_id
GROUP BY C.occupation;

-----------------------------------------------------------

-- Q20. Find total transaction amount by transaction type.

SELECT transaction_type, SUM(amount) AS total_transaction_amount
FROM transactions
GROUP BY transaction_type;

-----------------------------------------------------------

-- Q21. Find total transaction amount by merchant category.

SELECT merchant_category, SUM(amount) AS total_transaction_amount
FROM transactions
GROUP BY merchant_category;

-----------------------------------------------------------

-- Q22. Find total transaction amount by channel.

SELECT channel, SUM(amount) AS total_transactions
FROM transactions
GROUP BY channel;

-----------------------------------------------------------

-- Q23. Find total fee collected by channel.

SELECT channel, SUM(fee_amount) AS total_fee_collected
FROM transactions
GROUP BY channel;

-----------------------------------------------------------

-- Q24. Find total tax collected by channel.

SELECT channel, SUM(tax_amount) AS total_tax_amount
FROM transactions
GROUP BY channel;

-----------------------------------------------------------

-- Q25. Find the average transaction amount by customer segment.

SELECT c.customer_segment, AVG(t.amount) AS total_transaction
FROM customers c
INNER JOIN transactions t
ON c.customer_id = t.customer_id
GROUP BY c.customer_segment;

-----------------------------------------------------------

-- Q26. Find the average transaction amount by merchant category.

SELECT merchant_category, AVG(amount) AS avg_amount
FROM transactions
GROUP BY merchant_category;

-----------------------------------------------------------

-- Q27. Find the average transaction amount by channel.

SELECT channel,
       AVG(amount) AS average_transaction_amount
FROM transactions
GROUP BY channel;

-----------------------------------------------------------

-- Q28. Find the total number of transactions by state.

SELECT c.state,
       COUNT(t.transaction_id) AS total_transactions
FROM customers c
INNER JOIN transactions t
ON c.customer_id = t.customer_id
GROUP BY c.state;

-----------------------------------------------------------

-- Q29. Find the total number of customers in each segment.

SELECT customer_segment,
       COUNT(customer_id) AS total_customers
FROM customers
GROUP BY customer_segment;

-----------------------------------------------------------

-- Q30. Find the total number of customers in each state.

SELECT state,
       COUNT(customer_id) AS total_customers
FROM customers
GROUP BY state;

-----------------------------------------------------------

-- Q31. Find the top 10 customers by transaction amount.

SELECT c.customer_id,
       CONCAT(c.first_name,' ',c.last_name) AS full_Name,
       SUM(t.amount) AS total_amount
FROM customers c
INNER JOIN transactions t
ON c.customer_id = t.customer_id
GROUP BY c.customer_id, full_Name
ORDER BY SUM(t.amount) DESC
LIMIT 10;

-----------------------------------------------------------

-- Q32. Find the top 10 states by transaction amount.

SELECT c.state,
       SUM(t.amount) AS total_amount
FROM customers c
INNER JOIN transactions t
ON c.customer_id = t.customer_id
GROUP BY state
ORDER BY SUM(t.amount) DESC
LIMIT 10;

-----------------------------------------------------------

-- Q33. Find the top merchant categories by transaction amount.

SELECT merchant_category,
       SUM(amount) AS transaction_amount
FROM transactions
GROUP BY merchant_category
ORDER BY SUM(amount) DESC
LIMIT 3;

-----------------------------------------------------------

-- Q34. Find the channel with the highest transaction amount.

SELECT channel,
       SUM(amount) AS total_transaction_amount
FROM transactions
GROUP BY channel
ORDER BY total_transaction_amount DESC
LIMIT 1;

-----------------------------------------------------------

-- Q35. Find the merchant category with the highest transaction amount.

SELECT merchant_category,
       SUM(amount) AS total_transaction_amount
FROM transactions
GROUP BY merchant_category
ORDER BY total_transaction_amount DESC
LIMIT 1;

-----------------------------------------------------------

-- Q36. Find the customer segment with the highest transaction amount.

SELECT c.customer_segment,
       SUM(t.amount) AS total_transaction_amount
FROM customers c
INNER JOIN transactions t
ON c.customer_id = t.customer_id
GROUP BY c.customer_segment
ORDER BY total_transaction_amount DESC
LIMIT 1;

-----------------------------------------------------------

-- Q37. Find the occupation with the highest transaction amount.

SELECT c.occupation,
       SUM(t.amount) AS total_transaction_amount
FROM customers c
INNER JOIN transactions t
ON c.customer_id = t.customer_id
GROUP BY c.occupation
ORDER BY total_transaction_amount DESC
LIMIT 1;

-----------------------------------------------------------

===========================
ADVANCED SQL 
===========================
-- Q41. Rank customers based on total transaction amount.

SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    SUM(t.amount) AS total_transaction_amount,
    DENSE_RANK() OVER (ORDER BY SUM(t.amount) DESC) AS customer_rank
FROM customers c
INNER JOIN transactions t
ON c.customer_id = t.customer_id
GROUP BY c.customer_id, full_name;

-----------------------------------------------------------

-- Q42. Find the top 5 customers using DENSE_RANK().

SELECT *
FROM
(
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS full_name,
        SUM(t.amount) AS total_transaction_amount,
        DENSE_RANK() OVER (ORDER BY SUM(t.amount) DESC) AS customer_rank
    FROM customers c
    INNER JOIN transactions t
    ON c.customer_id = t.customer_id
    GROUP BY c.customer_id, full_name
) AS ranked_customers
WHERE customer_rank <= 5;

-----------------------------------------------------------

-- Q43. Find the running total of transaction amount.
SELECT *,
       SUM(amount) OVER (ORDER BY transaction_date) AS running_sales
FROM transactions;


-----------------------------------------------------------

-- Q44. Find the moving average of transaction amount.

SELECT *,
       AVG(amount) OVER (ORDER BY transaction_date) AS moving_average
FROM transactions;

-----------------------------------------------------------

-- Q45. Find the previous transaction amount using LAG().

SELECT *,
       LAG(amount) OVER (ORDER BY transaction_date) AS previous_transaction_amount
FROM transactions;

-----------------------------------------------------------

-- Q46. Find the next transaction amount using LEAD().

SELECT *,
       LEAD(amount) OVER (ORDER BY transaction_date) AS next_transaction_amount
FROM transactions;

-----------------------------------------------------------

-- Q47. Find the highest transaction in each customer segment.

SELECT c.customer_segment, MAX(t.amount) AS highest_amount
FROM customers c
INNER JOIN transactions t
ON c.customer_id = t.customer_id
GROUP BY c.customer_segment
ORDER BY SUM(t.amount) DESC;

-----------------------------------------------------------

-- Q48. Find the second highest transaction amount.

SELECT MAX(amount) AS second_amount
FROM transactions
WHERE amount < (SELECT MAX(amount) FROM transactions);

-----------------------------------------------------------

-- Q49. Find customers whose transaction amount is above the overall average.

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    t.amount
FROM customers c
INNER JOIN transactions t
ON c.customer_id = t.customer_id
WHERE t.amount >
(
    SELECT AVG(amount)
    FROM transactions
);

-----------------------------------------------------------

-- Q50. Find customers whose total transaction amount is above the average customer spending.

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    SUM(t.amount) AS total_transaction_amount
FROM customers c
INNER JOIN transactions t
ON c.customer_id = t.customer_id
GROUP BY c.customer_id, full_name
HAVING SUM(t.amount) >
(
    SELECT AVG(total_spending)
    FROM
    (
        SELECT SUM(amount) AS total_spending
        FROM transactions
        GROUP BY customer_id
    ) AS avg_spending
);

-----------------------------------------------------------

-- Q51. Classify transactions into Low, Medium, and High using CASE WHEN.

SELECT
    transaction_id,
    amount,
    CASE
        WHEN amount < 1000 THEN 'Low'
        WHEN amount BETWEEN 1000 AND 5000 THEN 'Medium'
        ELSE 'High'
    END AS transaction_category
FROM transactions;

-----------------------------------------------------------

-- Q52. Find monthly transaction amount.

SELECT
    MONTH(transaction_date) AS month,
    SUM(amount) AS total_transaction_amount
FROM transactions
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date);

-----------------------------------------------------------

-- Q53. Find yearly transaction amount.

SELECT
    YEAR(transaction_date) AS month,
    SUM(amount) AS total_transaction_amount
FROM transactions
GROUP BY YEAR(transaction_date)
ORDER BY YEAR(transaction_date);

-----------------------------------------------------------