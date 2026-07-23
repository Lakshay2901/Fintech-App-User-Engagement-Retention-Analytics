# Fintech User Engagement & Retention Analytics (MySQL)

This project analyzes user login, transaction, and offer-redemption behavior on a
digital payments platform using **realistic synthetic data**. Written and
tested in MySQL. Uses SQL to uncover churn, retention,
activation, and cashback-offer effectiveness patterns.

## Overview

- **Timeframe**: Jan 2024 – Dec 2024 (12 months)
- **Tools Used**: MySQL 8+ (window functions require this minimum version)
- **Skills Applied**:
  - Window Functions 
  - CTEs & Subqueries
  - Gaps-and-Islands pattern (consecutive failed-payment streak detection)
  - Cohort Retention Analysis
  - Churn & Reactivation Metrics

## Dataset

**Synthetic dataset generated for learning and portfolio purposes.**
250 users, ~6,300 logins, ~6,400 transactions, and 146 offers, spread across 12 months.

### Tables

| Table | Description |
|---|---|
| `users` | user_id, signup_date, city, age_group, kyc_status, acquisition_channel |
| `logins` | login_id, user_id, login_date, device_type, login_channel, login_status |
| `transactions` | transaction_id, user_id, txn_date, amount, txn_type, status |
| `offers` | offer_id, user_id, offer_type, offer_date, discount_value, redeemed |

Dataset Links:

- [logins.csv](Database_CSV/logins.csv)
- [offers.csv](Database_CSV/offers.csv)
- [transactions.csv](Database_CSV/transactions.csv)
- [users.csv](Database_CSV/users.csv)



## Key SQL Queries

| # | Use Case | Queries |
|---|---|---|
| 1 | Daily Active Users (DAU) | [Query](Queries/Query1_DAU.sql) |
| 2 | Monthly Active Users (MAU) | [Query](Queries/Query2_MAU.sql) |
| 3 | Weekly Engaged Users (3+ active days/week) | [Query](Queries/Query3_Weekly_Engaged_Users.sql) |
| 4 | Detect Inactive / Churned Users | [Query](Queries/Query4_Inactive_Users.sql)  |
| 5 | Avg Transaction Value by City | [Query](Queries/Query5_Avg_Txn_By_City.sql) |
| 6 | Avg Transaction Value by Age Group | [Query](Queries/Query6_Avg_Txn_By_Age.sql) |
| 7 | Signup → First Transaction (activation lag) | [Query](Queries/Query7_Signup_To_First_Txn) |
| 8 | First Transaction Drop-off | [Query](Queries/Query8_First_Txn_Dropoff.sql) |
| 9 | Login Device vs Retention | [Query](Queries/Query9_Channel_Vs_Retention.sql) |
| 10 | **Failed Payment Streaks** | [Query](Queries/Query10_Failed_Payment_Streaks.sql) |
| 11 | Signup Cohort Retention (month-over-month) | [Query](Queries/Query11_Signup_Cohort_Retention.sql) |
| 12 | Churn Rate by City | [Query](Queries/Query12_Churn_By_City.sql) |
| 13 | Offer/Cashback Impact vs Organic Users | [Query](Queries/Query13_Offer_Impact.sql) |
| 14 | Reactivated Users (return after 45+ day gap) | [Query](Queries/Query14_Reactivated_Users.sql) |

Explore all queries [here](https://github.com/Lakshay2901/Fintech-App-User-Engagement-Retention-Analytics/tree/main/Queries)
