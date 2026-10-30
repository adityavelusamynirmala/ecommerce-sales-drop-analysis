# Ecommerce Sales Drop Analysis

## Project Overview

This project investigates a decline in e-commerce revenue using a synthetic dataset. The objective is to quantify the decline, examine changes in order volume, and identify the sales channels and product categories that warrant further investigation.

The analysis uses SQL for data analysis and Power BI for interactive dashboards.

> **Disclaimer:** This project uses synthetic data for portfolio and learning purposes. The findings do not represent the performance of a real company.

## Business Problem

Revenue declined in the most recent month of the dataset. The objective is to understand the scale of the decline and investigate which sales channels and product categories experienced the largest changes.

## Tools Used

* **SQL (SQLite):** Aggregation, filtering, joins, and period-over-period comparisons.
* **Power BI:** KPI cards, monthly trend analysis, category comparisons, channel comparisons, and interactive filters.
* **Excel:** Data inspection and validation.

## Key Findings

Comparing August 2026 with September 2026:

* Total revenue decreased from ₹70,46,322.60 to ₹61,69,741.85, a decline of approximately **12.44%**.
* Distinct order count decreased from 2,069 to 1,768, a decline of approximately **14.55%**.
* Mobile App revenue declined by approximately **18.89%**, the largest percentage decline among the three sales channels.
* Fashion revenue declined by approximately **18.34%**, the largest percentage decline among the four product categories.

These findings identify areas for further investigation; they do not establish the underlying causes of the decline.

## Analysis Approach

1. Inspected the dataset and reviewed its tables and columns.
2. Used SQL to calculate monthly revenue and distinct order counts.
3. Compared August and September 2026 performance.
4. Compared revenue by sales channel.
5. Compared revenue by product category.
6. Built interactive Power BI dashboards to explore revenue trends and potential drivers.
7. Cross-checked monthly and segment-level results between SQL and Power BI.

## Dashboard

### Executive Overview

This dashboard presents the main business KPIs and monthly revenue and order trends.

### Revenue Driver Analysis

This dashboard compares monthly revenue across sales channels, product categories, and customer regions.

## Recommendations for Further Investigation

1. Investigate the decline in Mobile App revenue by examining app conversion, checkout completion, and order volume.
2. Investigate Fashion performance through product-level sales, pricing, discounts, and availability.
3. Examine changes in average order value to understand whether customer spending per order changed.
4. Compare customer acquisition and repeat-purchase behaviour across channels.
5. Investigate missing or unmatched customer-region information before using regional comparisons for business decisions.

These are proposed investigation steps, not confirmed causes.

## Limitations

* The dataset is synthetic and may not reflect real-world business conditions.
* The comparison focuses on August and September 2026; additional historical context is needed to assess seasonality and longer-term trends.
* Revenue trends alone cannot establish causation.
* Records with missing order dates require separate treatment in time-based analysis.
* The blank regional category was excluded from the regional visual; the underlying data-quality issue requires further investigation.

## Project Structure

```text
ecommerce-sales-drop-analysis/
├── data/
│   ├── raw/
│   └── processed/
├── sql/
├── docs/
│   └── dashboard-screenshots/
├── powerbi/
│   └── ecommerce_sales_drop_analysis.pbix
└── README.md
```

## Skills Demonstrated

SQL analysis, business problem framing, KPI analysis, revenue trend analysis, segment comparisons, data validation, Power BI dashboard development, and evidence-based recommendations.
