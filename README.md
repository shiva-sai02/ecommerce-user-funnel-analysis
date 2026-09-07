# E-commerce User Funnel & Conversion Analysis

## Project Overview

This project analyzes e-commerce user behavior from initial visits through completed purchases. The analysis focuses on understanding the customer funnel, identifying major drop-off points, and evaluating performance across traffic sources, devices, locations, and time.

The goal is to identify where users are most likely to drop off and provide actionable insights to improve conversion performance.

## Business Problem

An e-commerce business receives users from multiple traffic sources and devices, but not all users progress through the purchasing journey.

This analysis answers:

- Where do users drop off in the funnel?
- Which traffic sources generate the strongest conversion performance?
- How do different devices perform?
- Which locations contribute the most users?
- How does user activity and conversion vary over time?

## Dataset

- **Records:** 12,000 user sessions
- **Period:** January 1 – March 31, 2026
- **Key fields:** Session Date, Traffic Source, Device, Location, Visited, Signed Up, Product Viewed, Added to Cart, Started Checkout, Purchased, Order Value, Session Duration

## Tools Used

- **MySQL** — Data analysis and SQL queries
- **Power BI** — Interactive dashboard and visualization
- **Excel/CSV** — Dataset preparation

## Dashboard

### Executive Overview

Provides a high-level view of the e-commerce funnel, overall conversion performance, traffic sources, devices, locations, and daily activity.

### Customer Segment Analysis

Analyzes user and purchase performance across traffic sources, devices, and geographic locations.

### Drop-off Analysis

Focuses on funnel-stage conversion and identifies the stages where the largest proportion of users leave the purchasing journey.

## Key Findings

- The largest funnel drop-off occurs between **Product Views and Add to Cart**, with approximately **59.0%** of users dropping off at this stage.
- Overall conversion from **12,000 visitors to 779 purchases** is approximately **6.5%**.
- **Organic Search** generates the highest visitor volume and the highest total order value.
- **Social Media** has the highest purchase conversion rate at approximately **7.43%**.
- **Mobile** has the highest total order value, making mobile users commercially important despite lower conversion than desktop.
- **Hyderabad** has the highest visitor volume among the analyzed locations.
- Daily visitor activity remains relatively consistent without a sustained upward or downward trend.

## Business Recommendations

1. Improve the **Product View → Add to Cart** stage by optimizing product pages, pricing visibility, product information, and calls-to-action.
2. Continue investing in **Organic Search**, which contributes strong traffic volume and total order value.
3. Study successful **Social Media** campaigns and identify opportunities to scale their conversion performance.
4. Prioritize **mobile user experience** because mobile contributes the largest total order value.
5. Investigate user behavior in **Hyderabad** to understand the reasons behind its high traffic volume.
6. Continue monitoring daily traffic and conversion trends to identify meaningful changes in performance.

## Repository Structure

```text
data/
└── user_funnel_raw_data.csv

sql/
└── Project_1_User_Funnel_Analysis.sql

powerbi/
└── Ecommerce_User_Funnel_Analysis.pbix

screenshot/
├── Executive overview.png
├── Segment-analysis.png
└── Dropoff-analysis.png

README.md

