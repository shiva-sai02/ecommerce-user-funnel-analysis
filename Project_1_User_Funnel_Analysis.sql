-- Project 1: E-commerce User Funnel & Conversion Analysis
-- SQL Analysis & Query File
-- Source dataset: 12,000 user-level records
-- The dataset is maintained separately in the data/ folder.
-- This file intentionally contains NO INSERT statements.

CREATE DATABASE IF NOT EXISTS user_funnel_analysis;
USE user_funnel_analysis;

-- =========================================================
-- TABLE STRUCTURE
-- =========================================================

CREATE TABLE IF NOT EXISTS funnel_data (
    user_id VARCHAR(20),
    session_date DATE,
    device VARCHAR(20),
    traffic_source VARCHAR(50),
    location VARCHAR(50),
    visited TINYINT,
    signed_up TINYINT,
    viewed_product TINYINT,
    added_to_cart TINYINT,
    started_checkout TINYINT,
    purchased TINYINT,
    order_value DECIMAL(10,2),
    session_duration_min DECIMAL(6,2)
);

-- =========================================================
-- 1. DATA VALIDATION
-- =========================================================

SELECT COUNT(*) AS total_users
FROM funnel_data;

SELECT COUNT(DISTINCT user_id) AS unique_users
FROM funnel_data;

SELECT
    MIN(session_date) AS start_date,
    MAX(session_date) AS end_date
FROM funnel_data;

-- =========================================================
-- 2. OVERALL FUNNEL
-- =========================================================

SELECT
    SUM(visited) AS visitors,
    SUM(signed_up) AS signups,
    SUM(viewed_product) AS product_views,
    SUM(added_to_cart) AS add_to_cart,
    SUM(started_checkout) AS checkouts,
    SUM(purchased) AS purchases
FROM funnel_data;

-- =========================================================
-- 3. FUNNEL CONVERSION RATES
-- =========================================================

SELECT
    ROUND(SUM(signed_up) / NULLIF(SUM(visited), 0) * 100, 2) AS visit_to_signup_pct,
    ROUND(SUM(viewed_product) / NULLIF(SUM(signed_up), 0) * 100, 2) AS signup_to_product_pct,
    ROUND(SUM(added_to_cart) / NULLIF(SUM(viewed_product), 0) * 100, 2) AS product_to_cart_pct,
    ROUND(SUM(started_checkout) / NULLIF(SUM(added_to_cart), 0) * 100, 2) AS cart_to_checkout_pct,
    ROUND(SUM(purchased) / NULLIF(SUM(started_checkout), 0) * 100, 2) AS checkout_to_purchase_pct,
    ROUND(SUM(purchased) / NULLIF(SUM(visited), 0) * 100, 2) AS overall_conversion_pct
FROM funnel_data;

-- =========================================================
-- 4. FUNNEL DROP-OFF
-- =========================================================

SELECT
    SUM(visited) - SUM(signed_up) AS visitor_to_signup_dropoff,
    SUM(signed_up) - SUM(viewed_product) AS signup_to_product_dropoff,
    SUM(viewed_product) - SUM(added_to_cart) AS product_to_cart_dropoff,
    SUM(added_to_cart) - SUM(started_checkout) AS cart_to_checkout_dropoff,
    SUM(started_checkout) - SUM(purchased) AS checkout_to_purchase_dropoff
FROM funnel_data;

SELECT
    ROUND(
        (SUM(viewed_product) - SUM(added_to_cart))
        / NULLIF(SUM(viewed_product), 0) * 100, 2
    ) AS product_to_cart_dropoff_pct
FROM funnel_data;

-- =========================================================
-- 5. DEVICE PERFORMANCE
-- =========================================================

SELECT
    device,
    COUNT(*) AS visitors,
    SUM(purchased) AS purchases,
    ROUND(SUM(purchased) / COUNT(*) * 100, 2) AS purchase_conversion_pct,
    ROUND(SUM(order_value), 2) AS total_order_value,
    ROUND(AVG(session_duration_min), 2) AS avg_session_duration_min
FROM funnel_data
GROUP BY device
ORDER BY total_order_value DESC;

-- =========================================================
-- 6. TRAFFIC SOURCE PERFORMANCE
-- =========================================================

SELECT
    traffic_source,
    COUNT(*) AS visitors,
    SUM(purchased) AS purchases,
    ROUND(SUM(purchased) / COUNT(*) * 100, 2) AS purchase_conversion_pct,
    ROUND(SUM(order_value), 2) AS total_order_value,
    ROUND(AVG(session_duration_min), 2) AS avg_session_duration_min
FROM funnel_data
GROUP BY traffic_source
ORDER BY total_order_value DESC;

-- =========================================================
-- 7. LOCATION PERFORMANCE
-- =========================================================

SELECT
    location,
    COUNT(*) AS visitors,
    SUM(purchased) AS purchases,
    ROUND(SUM(purchased) / COUNT(*) * 100, 2) AS purchase_conversion_pct,
    ROUND(SUM(order_value), 2) AS total_order_value
FROM funnel_data
GROUP BY location
ORDER BY visitors DESC;

-- =========================================================
-- 8. DAILY TRAFFIC & CONVERSION TREND
-- =========================================================

SELECT
    session_date,
    COUNT(*) AS visitors,
    SUM(purchased) AS purchases,
    ROUND(SUM(purchased) / COUNT(*) * 100, 2) AS daily_conversion_pct
FROM funnel_data
GROUP BY session_date
ORDER BY session_date;

-- =========================================================
-- 9. REVENUE OVERVIEW
-- =========================================================

SELECT
    COUNT(*) AS total_visitors,
    SUM(purchased) AS total_purchases,
    ROUND(SUM(order_value), 2) AS total_order_value,
    ROUND(AVG(CASE WHEN purchased = 1 THEN order_value END), 2) AS average_order_value
FROM funnel_data;

-- =========================================================
-- 10. REVENUE BY DEVICE
-- =========================================================

SELECT
    device,
    SUM(purchased) AS purchases,
    ROUND(SUM(order_value), 2) AS total_order_value,
    ROUND(AVG(CASE WHEN purchased = 1 THEN order_value END), 2) AS average_order_value
FROM funnel_data
GROUP BY device
ORDER BY total_order_value DESC;

-- =========================================================
-- 11. REVENUE BY TRAFFIC SOURCE
-- =========================================================

SELECT
    traffic_source,
    SUM(purchased) AS purchases,
    ROUND(SUM(order_value), 2) AS total_order_value,
    ROUND(AVG(CASE WHEN purchased = 1 THEN order_value END), 2) AS average_order_value
FROM funnel_data
GROUP BY traffic_source
ORDER BY total_order_value DESC;

-- =========================================================
-- 12. DEVICE × TRAFFIC SOURCE
-- =========================================================

SELECT
    device,
    traffic_source,
    COUNT(*) AS visitors,
    SUM(purchased) AS purchases,
    ROUND(SUM(purchased) / COUNT(*) * 100, 2) AS purchase_conversion_pct,
    ROUND(SUM(order_value), 2) AS total_order_value
FROM funnel_data
GROUP BY device, traffic_source
ORDER BY purchase_conversion_pct DESC;

-- =========================================================
-- 13. FUNNEL PERFORMANCE BY TRAFFIC SOURCE
-- =========================================================

SELECT
    traffic_source,
    SUM(visited) AS visitors,
    SUM(signed_up) AS signups,
    SUM(viewed_product) AS product_views,
    SUM(added_to_cart) AS add_to_cart,
    SUM(started_checkout) AS checkouts,
    SUM(purchased) AS purchases
FROM funnel_data
GROUP BY traffic_source
ORDER BY visitors DESC;

-- =========================================================
-- 14. FUNNEL PERFORMANCE BY DEVICE
-- =========================================================

SELECT
    device,
    SUM(visited) AS visitors,
    SUM(signed_up) AS signups,
    SUM(viewed_product) AS product_views,
    SUM(added_to_cart) AS add_to_cart,
    SUM(started_checkout) AS checkouts,
    SUM(purchased) AS purchases
FROM funnel_data
GROUP BY device
ORDER BY visitors DESC;

-- =========================================================
-- 15. DATA QUALITY CHECK
-- =========================================================

SELECT
    SUM(CASE WHEN user_id IS NULL OR user_id = '' THEN 1 ELSE 0 END) AS missing_user_id,
    SUM(CASE WHEN session_date IS NULL THEN 1 ELSE 0 END) AS missing_session_date,
    SUM(CASE WHEN device IS NULL OR device = '' THEN 1 ELSE 0 END) AS missing_device,
    SUM(CASE WHEN traffic_source IS NULL OR traffic_source = '' THEN 1 ELSE 0 END) AS missing_traffic_source,
    SUM(CASE WHEN location IS NULL OR location = '' THEN 1 ELSE 0 END) AS missing_location,
    SUM(CASE WHEN purchased = 1 AND order_value <= 0 THEN 1 ELSE 0 END) AS purchased_without_order_value
FROM funnel_data;
