# StreamHub Database Architecture

## Overview

StreamHub is a relational database built for a fictional online streaming platform. I created this project to put database management concepts into practice, specifically focusing on ER modeling, data normalization, and writing SQL queries that handle information efficiently.

## Core Architecture

The database is structured to support the backend operations of a video streaming service:

* **Content Management:** Tracks movies, TV shows, seasons, and individual episodes.
* **User Accounts:** Manages multi-profile accounts and different subscription tiers (Basic, Standard, Premium, etc.).
* **User Engagement:** Stores viewing history, custom watchlists, and user ratings/reviews.
* **Metadata:** Uses many-to-many relationships to link content with actors, directors, genres, studios, and providers.

## Database Normalization (BCNF)

The entire schema is normalized to Boyce-Codd Normal Form (BCNF) to prevent data anomalies.

* **Functional Dependencies:** Every determinant across the database's 20+ tables is a candidate key or superkey.
* **Example:** In the `Episode` table, the composite primary key (`content_id`, `season_no`, `episode_number`) strictly determines all other column values, eliminating partial or transitive dependencies.

## SQL Implementation

The repository contains 20+ SQL scripts written to handle common platform operations and analytics:

* **Data Aggregation:** Queries to calculate trending content based on the last 30 days of user viewing history.
* **Recommendation Logic:** Finding "Recommended Content" by comparing a user's most-watched genres against titles they haven't seen yet.
* **Financial Metrics:** Calculating total monthly revenue grouped by active subscription plans.

## Structure

The project files are organized logically to separate documentation, visual models, and (PostgreSQL) code:

* **`docs/`**
Contains the comprehensive design documents (`ERD_SCHEMA_PROOF.pdf`), which detail the database specifications, relationships, and BCNF normalization proofs.
* **`images/`**
Holds the visual reference diagrams for the database, including the Entity-Relationship Diagram (`erd.png`) and the relational schema (`schema.png`).
* **`sql/`**
* `01_schema_DDL.sql`: The core Data Definition Language script responsible for creating all tables, primary/foreign keys, and database constraints.
* `02_seed_data.sql`: A robust set of mock `INSERT` statements used to populate the tables with realistic dummy data for testing purposes.
* `03_queries.sql`: The collection of 21 optimized SQL queries demonstrating data retrieval, complex joins, and business logic analytics.
