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
-- After running the code locally, the third-best state was "OH", Ohio, with a total revenue of 37577.0.

-- QUESTION 3. Write a query that shows total cost, impressions, clicks, and revenue of each campaign.
-- Make sure to include the campaign name in the output.
SELECT
  ci.name AS camapign_name,
  SUM(mp.cost) AS total_cost,
  SUM(mp.impressions) AS total_impressions,
  SUM(mp.clicks) AS total_clicks,
  SUM(wr.revenue) AS total_revenue
FROM marketing_performance mp
JOIN campaign_info ci ON mp.campaign_id = ci.id
JOIN
  website_revenue wr ON mp.campaign_id = wr.campaign_id AND
  mp.date = wr.date
GROUP BY ci.name;

-- QUESTION 4. Write a query to get the number of conversions of Campaign5 by state.
-- Which state generated the most conversions for this campaign?
SELECT
  mp.geo AS state,
  SUM(mp.conversions) AS total_conversions
FROM marketing_performance mp
JOIN campaign_info ci ON mp.campaign_id = ci.id
WHERE ci.name = 'Campaign5'
GROUP BY mp.geo
ORDER BY total_conversions DESC;



