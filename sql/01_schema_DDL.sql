CREATE SCHEMA streamhub;
set search_path to streamhub;

-- CONTENT
CREATE TABLE Content (
    content_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_date DATE,
    language VARCHAR(50),
    content_type VARCHAR(20)
);

CREATE TABLE Movie (
    content_id INT PRIMARY KEY,
    duration INT,
    FOREIGN KEY (content_id) REFERENCES Content(content_id) ON DELETE CASCADE
);

CREATE TABLE TV_Show (
    content_id INT PRIMARY KEY,
    FOREIGN KEY (content_id) REFERENCES Content(content_id) ON DELETE CASCADE
);

-- SEASON & EPISODE
CREATE TABLE Season (
    content_id INT,
    season_no INT,
    PRIMARY KEY (content_id, season_no),
    FOREIGN KEY (content_id) REFERENCES TV_Show(content_id) ON DELETE CASCADE
);

CREATE TABLE Episode (
    content_id INT,
    season_no INT,
    episode_number INT,
    title VARCHAR(255),
    duration INT,
    release_date DATE,
    PRIMARY KEY (content_id, season_no, episode_number),
    FOREIGN KEY (content_id, season_no) REFERENCES Season(content_id, season_no) ON DELETE CASCADE
);

-- USER AND PROFILE
CREATE TABLE AppUser (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone_no VARCHAR(20),
    country VARCHAR(50),
    reg_date DATE
);

CREATE TABLE Profile (
    profile_id INT PRIMARY KEY,
    user_id INT,
    profile_name VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES AppUser(user_id) ON DELETE CASCADE
);

-- SUBSCRIPTION
CREATE TABLE SubscriptionPlan (
    plan_id INT PRIMARY KEY,
    plan_name VARCHAR(50),
    monthly_price DECIMAL(10,2),
    max_screens INT,
    video_quality VARCHAR(20)
);

CREATE TABLE UserSubscription (
    subscription_id INT PRIMARY KEY,
    user_id INT,
    plan_id INT,
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES AppUser(user_id) ON DELETE CASCADE,
    FOREIGN KEY (plan_id) REFERENCES SubscriptionPlan(plan_id)
);

-- RATING & VIEWING
CREATE TABLE RatingReview (
    rating_id INT PRIMARY KEY,
    profile_id INT,
    content_id INT,
    rating INT,
    review_comment TEXT,
    review_date DATE,
    FOREIGN KEY (profile_id) REFERENCES Profile(profile_id) ON DELETE CASCADE,
    FOREIGN KEY (content_id) REFERENCES Content(content_id) ON DELETE CASCADE
);

CREATE TABLE ViewingHistory (
    history_id INT PRIMARY KEY,
    profile_id INT,
    content_id INT,
    watch_timestamp TIMESTAMP,
    device_used VARCHAR(50),
    FOREIGN KEY (profile_id) REFERENCES Profile(profile_id) ON DELETE CASCADE,
    FOREIGN KEY (content_id) REFERENCES Content(content_id) ON DELETE CASCADE
);

-- WATCHLIST
CREATE TABLE Watchlist (
    watchlist_id INT PRIMARY KEY,
    profile_id INT,
    watchlist_name VARCHAR(100),
    FOREIGN KEY (profile_id) REFERENCES Profile(profile_id) ON DELETE CASCADE
);

CREATE TABLE WatchlistContent (
    watchlist_id INT,
    content_id INT,
    PRIMARY KEY (watchlist_id, content_id),
    FOREIGN KEY (watchlist_id) REFERENCES Watchlist(watchlist_id) ON DELETE CASCADE,
    FOREIGN KEY (content_id) REFERENCES Content(content_id) ON DELETE CASCADE
);

-- ACTOR / DIRECTOR / GENRE
CREATE TABLE Actor (
    actor_id INT PRIMARY KEY,
    actor_name VARCHAR(100),
    dob DATE,
    country VARCHAR(50)
);

CREATE TABLE Director (
    director_id INT PRIMARY KEY,
    director_name VARCHAR(100),
    country VARCHAR(50)
);

CREATE TABLE Genre (
    genre_id INT PRIMARY KEY,
    genre_name VARCHAR(100),
    parent_genre INT,
    FOREIGN KEY (parent_genre) REFERENCES Genre(genre_id)
);

-- M:N RELATIONSHIPS
CREATE TABLE ContentActor (
    content_id INT,
    actor_id INT,
    character_name VARCHAR(100),
    PRIMARY KEY (content_id, actor_id),
    FOREIGN KEY (content_id) REFERENCES Content(content_id) ON DELETE CASCADE,
    FOREIGN KEY (actor_id) REFERENCES Actor(actor_id) ON DELETE CASCADE
);

CREATE TABLE ContentDirector (
    content_id INT,
    director_id INT,
    PRIMARY KEY (content_id, director_id),
    FOREIGN KEY (content_id) REFERENCES Content(content_id) ON DELETE CASCADE,
    FOREIGN KEY (director_id) REFERENCES Director(director_id) ON DELETE CASCADE
);

CREATE TABLE ContentGenre (
    content_id INT,
    genre_id INT,
    PRIMARY KEY (content_id, genre_id),
    FOREIGN KEY (content_id) REFERENCES Content(content_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES Genre(genre_id) ON DELETE CASCADE
);

-- PRODUCTION
CREATE TABLE Studio (
    studio_id INT PRIMARY KEY,
    studio_name VARCHAR(100),
    country VARCHAR(50),
    address TEXT
);

CREATE TABLE ContentProvider (
    provider_id INT PRIMARY KEY,
    company_name VARCHAR(100),
    country VARCHAR(50),
    website VARCHAR(100)
);

CREATE TABLE Produces (
    studio_id INT,
    content_id INT,
    PRIMARY KEY (studio_id, content_id),
    FOREIGN KEY (studio_id) REFERENCES Studio(studio_id) ON DELETE CASCADE,
    FOREIGN KEY (content_id) REFERENCES Content(content_id) ON DELETE CASCADE
);

CREATE TABLE Uploads (
    provider_id INT,
    content_id INT,
    PRIMARY KEY (provider_id, content_id),
    FOREIGN KEY (provider_id) REFERENCES ContentProvider(provider_id) ON DELETE CASCADE,
    FOREIGN KEY (content_id) REFERENCES Content(content_id) ON DELETE CASCADE
);
