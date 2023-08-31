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
-- After running the query locally, the third-best state was "OH", Ohio, with a total revenue of 37577.0.


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
JOIN website_revenue wr ON
  mp.campaign_id = wr.campaign_id AND
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
-- After running the query locally, I found that "United States-GA", or Georgia, had the most conversions for this campaign at 672 conversions.


-- QUESTION 5. In your opinion, which campaign was the most efficient, and why? 
-- When I ran the following query:
SELECT
  ci.name AS campaign_name,
  ci.status AS campaign_status,
  SUM(mp.cost) AS total_cost,
  SUM(mp.conversions) AS total_conversions,
  SUM(mp.clicks) AS total_clicks,
  SUM(wr.revenue) AS total_revenue,
  SUM(mp.cost) / SUM(mp.conversions) AS cost_per_conversion,
  SUM(mp.cost) / SUM(mp.clicks) AS cost_per_click
FROM marketing_performance mp
JOIN campaign_info ci ON mp.campaign_id = ci.id
JOIN website_revenue wr ON
  mp.campaign_id = wr.campaign_id AND
  mp.date = wr.date
GROUP BY
  ci.name,
  ci.status
ORDER BY
  cost_per_conversion,
  cost_per_click;

-- I got the following information:
-- |campaign_name|campaign_status|total_cost|total_conversions|total_clicks|total_revenue|cost_per_conversion|  cost_per_click  |
-- |  Campaign2  |    enabled    |  141.84  |        456      |    1030    |     6964    | 0.311052631578947 |0.137708737864078 |
-- |  Campaign5  |    enabled    |  162.58  |        346      |    1724    |     7147    | 0.469884393063584 |0.0943039443155453|
-- |  Campaign3  |    enabled    |  588.13  |       1228      |    4335    |    19265    | 0.4789332247557   |0.135670126874279 |
-- |  Campaign1  |    paused     |  384.4   |        737      |    3285    |    13403    | 0.52157394843962  |0.117016742770167 |

-- There are various determinations of efficiency we can employ:
-- * We could articulate Campaign3 is most efficient by its revenue generation – while it's the most expensive, it has produced
--   significantly more conversions and money than the rest of the campaigns.
-- * We could articulate Campaign5 is most efficient by its ability to gather clicks – its cost per click is far lower than
--   every other campaign's, meaning the ad campaign may be better at garnering interest in the content of the ad and increasing
--   consumer response.
-- * We could articulate Campaign2 is most efficient by its ability to convert at a comparatively low cost – its cost per conversion
--   is far lower than every other campaign's, almost 2/3 of any other campaign. It also appears to convert roughly half of all
--   those who click the ad.

-- Of these, in *my* opinion, I believe Campaign2 was the most efficient. Efficiency and effectiveness aren't quite the same thing
-- and Campaign2 was able to convert consumers at a relatively efficient cost per conversion and at a comparable cost per click to
-- the other campaigns. On top of this, nearly half the total clicks in Campaign2 yielded conversions, whereas this ratio was
-- roughly 1:4 to 1:5 in the other campaigns. These facts lead me to believe Campaign2 was the most efficient campaign.


-- BONUS QUESTION 6. Write a query that showcases the best day of the week (e.g., Sunday, Monday, Tuesday, etc.) to run ads.
SELECT
  DAYNAME(date) AS day_of_week,
  SUM(impressions) AS total_impressions,
  SUM(cost) AS total_cost,
  SUM(clicks) AS total_clicks,
  SUM(conversions) AS total_conversions
FROM marketing_performance
GROUP BY DAYNAME(date)
ORDER BY total_conversions DESC;
