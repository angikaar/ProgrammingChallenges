-- QUESTION 1. Write a query to get the sum of impressions by day.
SELECT
  date,
  SUM(impressions) AS total_impressions
FROM marketing_performance
GROUP BY date;

-- QUESTION 2. Write a query to get the top three revenue-generating states in order of best to worst.
-- How much revenue did the third best state generate?
SELECT
  state,
  SUM(revenue) AS total_revenue
FROM website_revenue
GROUP BY state
ORDER BY total_revenue DESC
LIMIT 3;
