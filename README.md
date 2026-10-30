# Customer Churn Analysis

## Project Overview

This project investigates customer churn for a subscription-based business using a synthetic customer dataset. The objective is to measure the overall churn rate, identify customer segments with higher churn, and highlight areas where retention strategies may need further investigation.

The analysis uses SQL for data analysis and Power BI for interactive dashboards.

> **Disclaimer:** This project uses synthetic data for portfolio and learning purposes. The findings do not represent the performance of a real company.

## Business Problem

A subscription-based business wants to understand why customers are leaving its service. The objective is to measure customer churn, compare churn across different customer segments, and identify behavioural and service-related patterns associated with customer churn.

## Tools Used

* **SQL (SQLite):** Aggregation, filtering, segmentation, and churn analysis.
* **Power BI:** KPI cards, churn comparisons, customer segmentation, and interactive filters.
* **Excel:** Data inspection and validation.

## Key Findings

Analysis of the customer dataset revealed the following patterns:

* Overall customer churn rate was approximately **16.91%**.
* Customers on the Basic subscription plan had the highest churn rate at approximately **22.8%**.
* Premium plan customers had the lowest churn rate at approximately **8.8%**.
* Customers with 0–4 monthly logins had a churn rate of approximately **31.1%**.
* Customers with 20 or more monthly logins had a churn rate of approximately **9.2%**.
* Newer customers showed higher churn compared with customers who had longer tenure.
* Churn patterns also varied across satisfaction scores, support ticket volumes, and late payment behaviour.

These findings highlight customer segments associated with higher churn. They do not establish the underlying causes of customer departures.

## Analysis Approach

1. Inspected the customer dataset and reviewed its columns and structure.
2. Used SQL to calculate total customers, churned customers, active customers, and overall churn rate.
3. Compared churn rates across subscription plans and acquisition channels.
4. Examined churn patterns based on customer tenure and monthly login frequency.
5. Investigated relationships between churn, satisfaction scores, support tickets, and late payments.
6. Built interactive Power BI dashboards to present the overall churn situation and explore potential churn drivers.
7. Validated key metrics and findings against the dashboard.

## Dashboard

### Executive Overview

This dashboard presents the main customer KPIs, including total customers, churned customers, active customers, and overall churn rate.

It also compares churn rates across subscription plans and acquisition channels, with interactive filters for customer segmentation.

### Churn Driver Analysis

This dashboard investigates customer churn across different behavioural and service-related dimensions, including:

* Customer tenure
* Monthly login frequency
* Satisfaction scores
* Support ticket volume
* Late payment behaviour

The objective is to identify customer segments with higher churn rates and highlight opportunities for further investigation.

## Recommendations for Further Investigation

1. Investigate the high churn rate among Basic plan customers by examining pricing, subscription benefits, and plan-related customer feedback.
2. Examine engagement patterns among customers with low monthly login frequency and investigate opportunities to improve product engagement.
3. Review the onboarding experience for newer customers to identify potential early-stage retention issues.
4. Investigate whether frequent support tickets are associated with unresolved customer problems or service dissatisfaction.
5. Examine late payment patterns and evaluate whether payment difficulties contribute to customer departures.
6. Review customer satisfaction feedback to identify recurring issues among customers with lower satisfaction scores.

These are proposed investigation steps, not confirmed causes.

## Limitations

* The dataset is synthetic and may not reflect real-world customer behaviour.
* Most signup date values are missing, limiting reliable time-based signup and churn trend analysis.
* Churn comparisons identify associations between customer characteristics and churn but cannot establish causation.
* Customer behaviour and subscription patterns may differ in real business environments.
* The analysis is limited to the variables available in the supplied dataset.

## Project Structure

```text
customer-churn-analysis/
├── data/
│   └── customers_raw.csv
├── sql/
│   └── customer_churn_analysis.sql
├── docs/
│   └── dashboard-screenshots/
├── powerbi/
│   └── customer_churn_analysis.pbix
└── README.md
```

## Skills Demonstrated

SQL analysis, customer churn analysis, KPI development, customer segmentation, behavioural analysis, retention analysis, data validation, Power BI dashboard development, and evidence-based business recommendations.
