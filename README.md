# E-Commerce Sales Drop Analysis

> **Portfolio case study | Synthetic data | SQL + Power BI + business analysis**

## 1. Business problem

A hypothetical e-commerce business has reported that revenue has fallen in recent months. The objective is to validate the decline, identify where it is concentrated, investigate possible drivers, and recommend evidence-based next steps.

**Important:** The dataset is synthetic and does not represent a real company. Results should be described as findings from a portfolio case study, not as real business performance.

## 2. Questions this project investigates

1. Is the recent revenue decline visible in the available data?
2. Is revenue changing because of order volume, average order value (AOV), or both?
3. Which sales channels, product categories, regions, and customer segments show the largest changes?
4. Are discounts, product mix, or estimated profit changing alongside revenue?
5. How much missing or invalid data could affect the conclusions?

## 3. Dataset

| Table | Purpose | Key columns |
|---|---|---|
| `orders` | Order-level performance | `order_id`, `order_date`, `customer_id`, `product_id`, `quantity`, `unit_price`, `revenue`, `sales_channel`, `month`, `profit_estimate` |
| `customers` | Customer attributes | `customer_id`, `city`, `region`, `customer_segment`, `acquisition_channel` |
| `products` | Product attributes and costs | `product_id`, `product_name`, `category`, `list_price`, `unit_cost` |

The `data/raw/` folder contains the supplied messy source CSVs. The `data/processed/` folder contains prepared CSVs used for analysis. Cleaning notes and the data dictionary are in `docs/`.

## 4. Key data-quality caveat

The supplied processed orders file contains **32,000 rows**, including **800 rows with missing order dates**. Those 800 rows cannot be assigned to a month reliably. Their revenue should be reported separately and excluded from monthly trend comparisons until the dates are resolved. Do not silently delete these rows or guess their dates.

The current dataset contains completed orders only, so it cannot be used to compare completed versus cancelled orders.

## 5. Initial measured trend

For rows with valid dates, the supplied analysis log reports:

| Metric | July 2026 | September 2026 | Change, July → September |
|---|---:|---:|---:|
| Revenue | 9,587,109 | 6,169,742 | -35.6% |
| Orders | 2,600 | 1,768 | -32.0% |
| Quantity | 3,395 | 2,180 | -35.8% |
| Estimated profit | 2,686,645 | 1,721,840 | -35.9% |

These are descriptive comparisons, not proof of a cause. The next step is to investigate channel, category, region, segment and product-level changes using the SQL queries and a Power BI dashboard.

## 6. Repository structure

```text
ecommerce-sales-drop-analysis/
├── README.md
├── .gitignore
├── data/
│   ├── raw/                 # Supplied messy synthetic CSVs
│   └── processed/           # Supplied cleaned/analysis-ready CSVs
├── sql/
│   └── analysis_queries.sql # Validation and business analysis queries
└── docs/
    ├── A-Z_Project_Execution_Log.pdf
    ├── 03_Data_Cleaning_Guide.pdf
    ├── 04_Project_Workflow.pdf
    └── 05_Data_Dictionary.pdf
```

Add dashboard screenshots and a `.pbix` file after you build and validate the Power BI dashboard.

## 7. How to reproduce the analysis

1. Download or clone this repository.
2. Open `data/processed/` and import the three CSVs into SQLite, using table names `orders`, `customers`, and `products`.
3. Open `sql/analysis_queries.sql` in your SQLite client and run each section.
4. Check the data-quality queries before interpreting trends.
5. Build a Power BI dashboard using the same metric definitions and date filters.
6. Save dashboard screenshots in `docs/dashboard-screenshots/` and add a concise findings section here only after validating the results.
7. Explain the sequence in interviews: business question → metric validation → data-quality assessment → trend confirmation → driver analysis → recommendations → limitations.

### Suggested tools

- SQL: SQLite with DB Browser for SQLite, or another SQLite client.
- Dashboard: Power BI Desktop.
- Documentation/version control: GitHub.

## 8. Metric definitions

- **Revenue:** sum of `revenue` for the selected population. For monthly trends, include only rows with a valid `order_date`.
- **Orders:** distinct count of `order_id`.
- **Average order value (AOV):** revenue divided by distinct orders for the same population.
- **Estimated profit:** sum of `profit_estimate`. This is an estimate based on the supplied cost fields, not audited accounting profit.
- **Revenue change (%):** `(current period revenue - comparison period revenue) / comparison period revenue × 100`.

Keep the population and date window consistent when comparing metrics.

## 9. Recommendations and next steps

Do not claim a root cause from the overall trend alone. Use the SQL analysis to determine which dimensions account for the largest absolute and percentage changes. Then propose a targeted investigation or experiment and define a success metric (for example, revenue, orders, conversion, AOV or estimated profit).

## 10. Limitations

- Synthetic data; no real company or customer conclusions.
- 800 order rows have missing dates.
- Only completed orders are present.
- Estimated profit depends on supplied cost assumptions.
- A July-to-September comparison describes the observed period but does not establish seasonality or causality.

## 11. Interview-ready project summary

“I investigated a reported e-commerce revenue decline using order, customer and product tables. I first validated the data and metric definitions, then compared monthly revenue, order volume, quantity and estimated profit. I found a material decline between July and September 2026 in the valid-date subset, while identifying 800 orders with missing dates as a limitation. I then used channel, product, region and segment analysis to investigate where the decline was concentrated, and used the results to frame actionable recommendations. The data is synthetic, so I present this as a reproducible portfolio case study.”

**Before using this summary in an interview:** run the SQL, build the dashboard, and fill in the driver findings and recommendations with your own validated results. Do not say you discovered a specific cause until your analysis supports it.
