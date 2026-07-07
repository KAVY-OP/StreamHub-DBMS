-- 1. SUBSCRIPTION PLANS
INSERT INTO SubscriptionPlan (plan_id, plan_name, monthly_price, max_screens, video_quality) VALUES
(1, 'Basic', 8.99, 1, '720p'),
(2, 'Standard', 13.99, 2, '1080p'),
(3, 'Premium', 19.99, 4, '4K HDR'),
(4, 'Mobile Only', 4.99, 1, '480p'),
(5, 'Student', 5.99, 1, '1080p'),
(6, 'Family', 24.99, 6, '4K HDR');

-- 2. USERS (APPUSER)
INSERT INTO AppUser (user_id, name, email, phone_no, country, reg_date) VALUES
(1, 'John Doe', 'john@example.com', '+1234567890', 'USA', '2022-01-15'),
(2, 'Priya Sharma', 'priya@example.com', '+91987654321', 'India', '2023-05-20'),
(3, 'Liam Smith', 'liam@example.com', '+44791112345', 'UK', '2021-11-10'),
(4, 'Elena Rodriguez', 'elena@example.com', '+34600123456', 'Spain', '2024-02-05'),
(5, 'Kenji Sato', 'kenji@example.com', '+81090123456', 'Japan', '2023-08-30'),
(6, 'Maria Garcia', 'maria@example.com', '+55119999999', 'Brazil', '2022-12-01'),
(7, 'David Chen', 'david@example.com', '+14165550198', 'Canada', '2023-03-15'),
(8, 'Sophie Martin', 'sophie@example.com', '+33123456789', 'France', '2024-01-10'),
(9, 'Lukas Weber', 'lukas@example.com', '+49151234567', 'Germany', '2021-07-22'),
(10, 'Chloe Taylor', 'chloe@example.com', '+61491570156', 'Australia', '2023-11-05');

-- 3. USER SUBSCRIPTIONS
INSERT INTO UserSubscription (subscription_id, user_id, plan_id, start_date, end_date, status) VALUES
(1, 1, 3, '2023-01-15', CURRENT_DATE + INTERVAL '1 month', 'Active'),
(2, 2, 2, '2023-05-20', CURRENT_DATE + INTERVAL '5 days', 'Active'),
(3, 3, 1, '2021-11-10', '2022-11-10', 'Expired'),
(4, 4, 3, '2024-02-05', CURRENT_DATE + INTERVAL '1 year', 'Active'),
(5, 5, 4, '2023-08-30', '2023-09-30', 'Expired'),
(6, 6, 6, '2022-12-01', CURRENT_DATE + INTERVAL '2 months', 'Active'),
(7, 7, 2, '2023-03-15', CURRENT_DATE + INTERVAL '15 days', 'Active'),
(8, 8, 5, '2024-01-10', CURRENT_DATE + INTERVAL '6 months', 'Active'),
(9, 9, 3, '2021-07-22', '2024-01-22', 'Cancelled'),
(10, 10, 1, '2023-11-05', CURRENT_DATE + INTERVAL '1 month', 'Active');

-- 4. PROFILES
INSERT INTO Profile (profile_id, user_id, profile_name) VALUES
(1, 1, 'John Main'),
(2, 1, 'Kids'),
(3, 2, 'Priya'),
(4, 2, 'Parents'),
(5, 3, 'Liam'),
(6, 4, 'Elena'),
(7, 4, 'Carlos (Guest)'),
(8, 5, 'Kenji Anime'),
(9, 6, 'Maria'),
(10, 6, 'Joao'),
(11, 7, 'David'),
(12, 8, 'Sophie'),
(13, 9, 'Lukas'),
(14, 10, 'Chloe'),
(15, 10, 'Roommate');

-- 5. GENRES
INSERT INTO Genre (genre_id, genre_name, parent_genre) VALUES
(1, 'Action', NULL),
(2, 'Sci-Fi', NULL),
(3, 'Drama', NULL),
(4, 'Comedy', NULL),
(5, 'Horror', NULL),
(6, 'Superhero', 1),
(7, 'Cyberpunk', 2),
(8, 'Thriller', 3),
(9, 'Romantic Comedy', 4),
(10, 'Anime', NULL),
(11, 'Documentary', NULL);

-- 6. CONTENT DIRECTORY
INSERT INTO Content (content_id, title, release_date, language, content_type) VALUES
(1, 'The Avengers', '2012-05-04', 'English', 'Movie'),
(2, 'Inception', '2010-07-16', 'English', 'Movie'),
(3, 'The Dark Knight', '2008-07-18', 'English', 'Movie'),
(4, 'Parasite', '2019-05-30', 'Korean', 'Movie'),
(5, 'Breaking Bad', '2008-01-20', 'English', 'TV_Show'),
(6, 'Stranger Things', '2016-07-15', 'English', 'TV_Show'),
(7, 'Money Heist', '2017-05-02', 'Spanish', 'TV_Show'),
(8, 'Interstellar', '2014-11-07', 'English', 'Movie'),
(9, 'Dune', '2021-10-22', 'English', 'Movie'),
(10, 'The Matrix', '1999-03-31', 'English', 'Movie'),
(11, 'Spirited Away', '2001-07-20', 'Japanese', 'Movie'),
(12, 'The Office', '2005-03-24', 'English', 'TV_Show'),
(13, 'Planet Earth', '2006-03-05', 'English', 'TV_Show'),
(14, 'Avengers: Endgame', '2019-04-26', 'English', 'Movie'),
(15, 'Dark', '2017-12-01', 'German', 'TV_Show');

-- 7. SUBTYPES: MOVIES & TV SHOWS
INSERT INTO Movie (content_id, duration) VALUES 
(1, 143), (2, 148), (3, 152), (4, 132), (8, 169), (9, 155), (10, 136), (11, 125), (14, 181);

INSERT INTO TV_Show (content_id) VALUES 
(5), (6), (7), (12), (13), (15);

-- 8. SEASONS & EPISODES
INSERT INTO Season (content_id, season_no) VALUES
(5, 1), (5, 2), (6, 1), (7, 1), (12, 1), (13, 1), (15, 1);

INSERT INTO Episode (content_id, season_no, episode_number, title, duration, release_date) VALUES
(5, 1, 1, 'Pilot', 58, '2008-01-20'),
(5, 1, 2, 'Cat''s in the Bag...', 48, '2008-01-27'),
(6, 1, 1, 'Chapter One: The Vanishing of Will Byers', 47, '2016-07-15'),
(7, 1, 1, 'Efectuar lo acordado', 47, '2017-05-02'),
(12, 1, 1, 'Pilot', 22, '2005-03-24'),
(12, 1, 2, 'Diversity Day', 22, '2005-03-29'),
(13, 1, 1, 'From Pole to Pole', 50, '2006-03-05'),
(15, 1, 1, 'Secrets', 51, '2017-12-01');

-- 9. ACTORS & DIRECTORS
INSERT INTO Actor (actor_id, actor_name, dob, country) VALUES
(1, 'Robert Downey Jr', '1965-04-04', 'USA'),
(2, 'Chris Evans', '1981-06-13', 'USA'),
(3, 'Leonardo DiCaprio', '1974-11-11', 'USA'),
(4, 'Bryan Cranston', '1956-03-07', 'USA'),
(5, 'Song Kang-ho', '1967-01-17', 'South Korea'),
(6, 'Keanu Reeves', '1964-09-02', 'Canada'),
(7, 'Steve Carell', '1962-08-16', 'USA'),
(8, 'Christian Bale', '1974-01-30', 'UK');

INSERT INTO Director (director_id, director_name, country) VALUES
(1, 'Christopher Nolan', 'UK'),
(2, 'Joss Whedon', 'USA'),
(3, 'Bong Joon-ho', 'South Korea'),
(4, 'Vince Gilligan', 'USA'),
(5, 'Lana Wachowski', 'USA'),
(6, 'Hayao Miyazaki', 'Japan'),
(7, 'Anthony Russo', 'USA');

-- 10. M:N RELATIONSHIPS
INSERT INTO ContentActor (content_id, actor_id, character_name) VALUES
(1, 1, 'Tony Stark / Iron Man'),
(1, 2, 'Steve Rogers / Captain America'),
(14, 1, 'Tony Stark / Iron Man'),
(2, 3, 'Cobb'),
(5, 4, 'Walter White'),
(4, 5, 'Kim Ki-taek'),
(10, 6, 'Neo'),
(12, 7, 'Michael Scott'),
(3, 8, 'Bruce Wayne / Batman');

INSERT INTO ContentDirector (content_id, director_id) VALUES
(1, 2), (2, 1), (3, 1), (8, 1), (4, 3), (5, 4), (10, 5), (11, 6), (14, 7);

INSERT INTO ContentGenre (content_id, genre_id) VALUES
(1, 1), (1, 6),     
(2, 2), (2, 8),     
(3, 1), (3, 8),     
(4, 3),             
(5, 3), (5, 8),     
(6, 2), (6, 5),     
(7, 1), (7, 8),
(8, 2), (8, 3),
(9, 2), (9, 1),
(10, 1), (10, 7),
(11, 10), (11, 3),
(12, 4),
(13, 11),
(14, 1), (14, 6),
(15, 2), (15, 8);

-- 11. STUDIOS & CONTENT PROVIDERS
INSERT INTO Studio (studio_id, studio_name, country, address) VALUES
(1, 'Marvel Studios', 'USA', 'Burbank, CA'),
(2, 'Warner Bros', 'USA', 'Burbank, CA'),
(3, 'CJ Entertainment', 'South Korea', 'Seoul'),
(4, 'Studio Ghibli', 'Japan', 'Tokyo');

INSERT INTO ContentProvider (provider_id, company_name, country, website) VALUES
(1, 'StreamHub Originals', 'USA', 'www.streamhub.com'),
(2, 'HBO Max Lib', 'USA', 'www.hbomax.com'),
(3, 'AnimeCentral', 'Japan', 'www.animecentral.jp');

INSERT INTO Produces (studio_id, content_id) VALUES
(1, 1), (2, 2), (2, 3), (3, 4), (2, 8), (1, 14), (4, 11);

INSERT INTO Uploads (provider_id, content_id) VALUES
(1, 1), (1, 4), (1, 5), (1, 6), (1, 12), (1, 14), (1, 15),
(2, 2), (2, 3), (2, 7), (2, 8), (2, 9), (2, 10), (2, 13),
(3, 11);

-- 12. VIEWING HISTORY (Spread across last 60 days to test trending & recent logic)
INSERT INTO ViewingHistory (history_id, profile_id, content_id, watch_timestamp, device_used) VALUES
(1, 1, 1, CURRENT_TIMESTAMP - INTERVAL '2 days', 'Smart TV'),
(2, 1, 2, CURRENT_TIMESTAMP - INTERVAL '5 days', 'Laptop'),
(3, 1, 5, CURRENT_TIMESTAMP - INTERVAL '40 days', 'Smartphone'),
(4, 2, 1, CURRENT_TIMESTAMP - INTERVAL '1 day', 'Tablet'),
(5, 3, 4, CURRENT_TIMESTAMP - INTERVAL '15 days', 'Smart TV'),
(6, 3, 7, CURRENT_TIMESTAMP - INTERVAL '20 days', 'Laptop'),
(7, 4, 3, CURRENT_TIMESTAMP - INTERVAL '3 days', 'Smart TV'),
(8, 4, 8, CURRENT_TIMESTAMP - INTERVAL '10 days', 'Smart TV'),
(9, 5, 1, CURRENT_TIMESTAMP - INTERVAL '25 days', 'Smartphone'),
(10, 5, 6, CURRENT_TIMESTAMP - INTERVAL '2 days', 'Smartphone'),
(11, 1, 1, CURRENT_TIMESTAMP - INTERVAL '1 hour', 'Smart TV'),
(12, 6, 14, CURRENT_TIMESTAMP - INTERVAL '4 days', 'Smart TV'),
(13, 7, 10, CURRENT_TIMESTAMP - INTERVAL '12 days', 'Laptop'),
(14, 8, 11, CURRENT_TIMESTAMP - INTERVAL '1 day', 'Tablet'),
(15, 9, 7, CURRENT_TIMESTAMP - INTERVAL '8 days', 'Smartphone'),
(16, 10, 4, CURRENT_TIMESTAMP - INTERVAL '35 days', 'Smart TV'),
(17, 11, 8, CURRENT_TIMESTAMP - INTERVAL '6 days', 'Laptop'),
(18, 12, 12, CURRENT_TIMESTAMP - INTERVAL '2 days', 'Tablet'),
(19, 13, 15, CURRENT_TIMESTAMP - INTERVAL '5 days', 'Smart TV'),
(20, 14, 2, CURRENT_TIMESTAMP - INTERVAL '18 days', 'Smartphone'),
(21, 15, 5, CURRENT_TIMESTAMP - INTERVAL '22 days', 'Smart TV'),
(22, 1, 14, CURRENT_TIMESTAMP - INTERVAL '6 days', 'Smart TV'),
(23, 2, 6, CURRENT_TIMESTAMP - INTERVAL '3 days', 'Tablet'),
(24, 3, 1, CURRENT_TIMESTAMP - INTERVAL '45 days', 'Laptop'),
(25, 4, 10, CURRENT_TIMESTAMP - INTERVAL '14 days', 'Smart TV'),
(26, 5, 13, CURRENT_TIMESTAMP - INTERVAL '9 days', 'Smartphone'),
(27, 8, 1, CURRENT_TIMESTAMP - INTERVAL '2 days', 'Tablet'),
(28, 11, 1, CURRENT_TIMESTAMP - INTERVAL '10 days', 'Smart TV'),
(29, 14, 1, CURRENT_TIMESTAMP - INTERVAL '5 days', 'Laptop'),
(30, 9, 1, CURRENT_TIMESTAMP - INTERVAL '1 day', 'Smart TV');

-- 13. WATCHLISTS
INSERT INTO Watchlist (watchlist_id, profile_id, watchlist_name) VALUES
(1, 1, 'Weekend Binge'),
(2, 1, 'Sci-Fi Favorites'),
(3, 3, 'Must Watch Later'),
(4, 8, 'Anime List'),
(5, 12, 'Comedies to watch');

INSERT INTO WatchlistContent (watchlist_id, content_id) VALUES
(1, 3), (1, 8), (1, 9), (1, 14),
(2, 2), (2, 8), (2, 6), (2, 10),
(3, 1), (3, 4), (3, 7),
(4, 11),
(5, 12);

-- 14. RATING & REVIEWS
INSERT INTO RatingReview (rating_id, profile_id, content_id, rating, review_comment, review_date) VALUES
(1, 1, 2, 4, 'Very confusing but great visuals.', CURRENT_DATE - INTERVAL '2 days'),
(2, 3, 4, 5, 'Mindblowing social commentary.', CURRENT_DATE - INTERVAL '15 days'),
(3, 4, 3, 5, 'Best Batman movie ever.', CURRENT_DATE - INTERVAL '20 days'),
(4, 5, 6, 4, 'Love the 80s nostalgia.', CURRENT_DATE - INTERVAL '5 days'),
(5, 8, 11, 5, 'Absolute masterpiece of animation.', CURRENT_DATE - INTERVAL '1 day'),
(6, 12, 12, 5, 'Hilarious!', CURRENT_DATE - INTERVAL '3 days'),
(7, 13, 15, 5, 'Best time travel show.', CURRENT_DATE - INTERVAL '6 days'),
(8, 7, 10, 4, NULL, CURRENT_DATE - INTERVAL '11 days');

-- Flooding Content 1 (The Avengers) with 12 reviews to trigger Query 20's "HAVING COUNT > 10"
INSERT INTO RatingReview (rating_id, profile_id, content_id, rating, review_comment, review_date) VALUES
(101, 1, 1, 5, 'Absolute masterpiece of superhero cinema.', CURRENT_DATE - INTERVAL '10 days'),
(102, 2, 1, 5, 'Loved it!', CURRENT_DATE),
(103, 3, 1, 4, 'Great action', CURRENT_DATE),
(104, 4, 1, 5, 'Awesome', CURRENT_DATE),
(105, 5, 1, 4, 'Good CGI', CURRENT_DATE),
(106, 6, 1, 5, 'Incredible', CURRENT_DATE),
(107, 7, 1, 5, 'Wow', CURRENT_DATE),
(108, 9, 1, 5, NULL, CURRENT_DATE),
(109, 10, 1, 4, NULL, CURRENT_DATE),
(110, 11, 1, 3, 'A bit long', CURRENT_DATE),
(111, 14, 1, 5, 'RDJ is the best', CURRENT_DATE),
(112, 15, 1, 4, 'Classic', CURRENT_DATE);

-- Extra reviews for StreamHub provider (Provider 1)
INSERT INTO RatingReview (rating_id, profile_id, content_id, rating, review_comment, review_date) VALUES
(113, 1, 5, 5, 'Best TV show ever made.', CURRENT_DATE - INTERVAL '30 days'),
(114, 2, 5, 5, 'Incredible character arc.', CURRENT_DATE - INTERVAL '25 days'),
(115, 6, 14, 5, 'Perfect ending to the saga.', CURRENT_DATE - INTERVAL '2 days'),
(116, 8, 14, 4, NULL, CURRENT_DATE - INTERVAL '1 day');
