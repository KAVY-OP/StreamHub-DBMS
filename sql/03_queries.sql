-- 1: Search by Title / Genre / Actor / Director / Language
SELECT c.content_id, c.title, c.language
FROM Content c
WHERE c.title ILIKE '%Avenger%' 
   OR c.language = 'English'
   OR EXISTS (SELECT 1 FROM ContentGenre cg JOIN Genre g ON cg.genre_id = g.genre_id WHERE cg.content_id = c.content_id AND g.genre_name = 'Action')
   OR EXISTS (SELECT 1 FROM ContentActor ca JOIN Actor a ON ca.actor_id = a.actor_id WHERE ca.content_id = c.content_id AND a.actor_name = 'Robert Downey Jr')
   OR EXISTS (SELECT 1 FROM ContentDirector cd JOIN Director d ON cd.director_id = d.director_id WHERE cd.content_id = c.content_id AND d.director_name = 'Christopher Nolan');

-- 2: Trending / Most Watched Content
SELECT c.title, COUNT(v.history_id) AS views
FROM ViewingHistory v
JOIN Content c ON v.content_id = c.content_id
WHERE v.watch_timestamp >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY c.content_id, c.title
ORDER BY views DESC
LIMIT 10;

-- 3: My Watch History
SELECT c.title, v.watch_timestamp, v.device_used
FROM ViewingHistory v
JOIN Content c ON v.content_id = c.content_id
WHERE v.profile_id = 1
ORDER BY v.watch_timestamp DESC;

-- 4: My Watchlists
SELECT w.watchlist_name, c.title
FROM Watchlist w
JOIN WatchlistContent wc ON w.watchlist_id = wc.watchlist_id
JOIN Content c ON wc.content_id = c.content_id
WHERE w.profile_id = 1;

-- 5: My Ratings and Reviews
SELECT c.title, r.rating, r.review_comment, r.review_date
FROM RatingReview r
JOIN Content c ON r.content_id = c.content_id
WHERE r.profile_id = 1
ORDER BY r.review_date DESC;

-- 6: Recently Watched (Last 7 Days)
SELECT c.title, v.watch_timestamp
FROM ViewingHistory v
JOIN Content c ON v.content_id = c.content_id
WHERE v.profile_id = 1
  AND v.watch_timestamp >= CURRENT_DATE - INTERVAL '7 days'
ORDER BY v.watch_timestamp DESC;

-- 7: Recommended Content
WITH UserFavoriteGenres AS (
    SELECT DISTINCT cg.genre_id
    FROM ViewingHistory v
    JOIN ContentGenre cg ON v.content_id = cg.content_id
    WHERE v.profile_id = 1
)
SELECT DISTINCT c.title
FROM Content c
JOIN ContentGenre cg ON c.content_id = cg.content_id
JOIN UserFavoriteGenres ufg ON cg.genre_id = ufg.genre_id
WHERE NOT EXISTS (
    SELECT 1 
    FROM ViewingHistory vh 
    WHERE vh.profile_id = 1 AND vh.content_id = c.content_id
);

-- 8: Content Statistics (Views + Ratings)
WITH ViewStats AS (
    SELECT content_id, COUNT(history_id) AS total_views
    FROM ViewingHistory
    GROUP BY content_id
),
RatingStats AS (
    SELECT content_id, ROUND(AVG(rating), 2) AS avg_rating
    FROM RatingReview
    GROUP BY content_id
)
SELECT c.title,
       COALESCE(vs.total_views, 0) AS total_views,
       COALESCE(rs.avg_rating, 0) AS avg_rating
FROM Uploads u
JOIN Content c ON u.content_id = c.content_id
LEFT JOIN ViewStats vs ON c.content_id = vs.content_id
LEFT JOIN RatingStats rs ON c.content_id = rs.content_id
WHERE u.provider_id = 1;

-- 9: Number of Views per Title
SELECT c.title, COUNT(v.history_id) AS views
FROM Content c
JOIN ViewingHistory v ON c.content_id = v.content_id
GROUP BY c.content_id, c.title
ORDER BY views DESC;

-- 10: Viewer Distribution by Country
SELECT u.country, COUNT(v.history_id) AS total_views
FROM ViewingHistory v
JOIN Profile p ON v.profile_id = p.profile_id
JOIN AppUser u ON p.user_id = u.user_id
GROUP BY u.country
ORDER BY total_views DESC;

-- 11: Average Rating of Provider Content
SELECT c.title, ROUND(AVG(r.rating), 2) AS avg_rating
FROM Uploads u
JOIN Content c ON u.content_id = c.content_id
JOIN RatingReview r ON c.content_id = r.content_id
WHERE u.provider_id = 1
GROUP BY c.content_id, c.title;

-- 12: Monthly Viewing Statistics
SELECT DATE_TRUNC('month', v.watch_timestamp) AS month,
       COUNT(v.history_id) AS total_views
FROM ViewingHistory v
GROUP BY DATE_TRUNC('month', v.watch_timestamp)
ORDER BY month DESC;

-- 13: Most Popular Titles Uploaded by Provider
SELECT c.title, COUNT(v.history_id) AS views
FROM Uploads u
JOIN ViewingHistory v ON u.content_id = v.content_id
JOIN Content c ON c.content_id = v.content_id
WHERE u.provider_id = 1
GROUP BY c.content_id, c.title
ORDER BY views DESC
LIMIT 5;

-- 14: Reviews & Feedback for Provider Content
SELECT c.title, r.rating, r.review_comment
FROM Uploads u
JOIN Content c ON u.content_id = c.content_id
JOIN RatingReview r ON c.content_id = r.content_id
WHERE u.provider_id = 1 
  AND r.review_comment IS NOT NULL
ORDER BY r.review_date DESC;

-- 15: Overall Viewing Statistics (Daily)
SELECT DATE_TRUNC('day', watch_timestamp) AS day,
       COUNT(history_id) AS total_views
FROM ViewingHistory
GROUP BY DATE_TRUNC('day', watch_timestamp)
ORDER BY day DESC;

-- 16: Most Popular Movies / Shows
SELECT c.title, COUNT(v.history_id) AS views
FROM Content c
JOIN ViewingHistory v ON c.content_id = v.content_id
GROUP BY c.content_id, c.title
ORDER BY views DESC
LIMIT 10;

-- 17: Most Popular Actors
SELECT a.actor_name,
       COUNT(v.history_id) AS popularity
FROM Actor a
JOIN ContentActor ca ON a.actor_id = ca.actor_id
JOIN ViewingHistory v ON ca.content_id = v.content_id
GROUP BY a.actor_id, a.actor_name
ORDER BY popularity DESC
LIMIT 10;

-- 18: Subscription Statistics by Region
SELECT u.country,
       COUNT(us.subscription_id) AS total_subscriptions
FROM AppUser u
JOIN UserSubscription us ON u.user_id = us.user_id
GROUP BY u.country
ORDER BY total_subscriptions DESC;

-- 19: Revenue from Subscription Plans
SELECT sp.plan_name, SUM(sp.monthly_price) AS total_revenue
FROM UserSubscription us
JOIN SubscriptionPlan sp ON us.plan_id = sp.plan_id
WHERE us.status = 'Active'
GROUP BY sp.plan_name;

-- 20: Top Rated Content
SELECT c.title,
       ROUND(AVG(r.rating), 2) AS avg_rating
FROM Content c
JOIN RatingReview r ON c.content_id = r.content_id
GROUP BY c.content_id, c.title
HAVING COUNT(r.rating_id) > 10
ORDER BY avg_rating DESC
LIMIT 10;

-- 21: Most Frequently Added to Watchlists
SELECT c.title,
       COUNT(wc.watchlist_id) AS times_added
FROM WatchlistContent wc
JOIN Content c ON wc.content_id = c.content_id
GROUP BY c.content_id, c.title
ORDER BY times_added DESC
LIMIT 10;
