# CSC 4402G Database Systems Project Report

## Cover Page

**Project Title:** International Trade Relations Database (ITRD)  
**Course:** CSC 4402G - Database Management Systems  
**Group Number:** Group 6  
**Repository:** [CSC-4402G-DBMS-group-project](https://github.com/Chidera-Nnadiekwe/CSC-4402G-DBMS-group-project)  
**Group Members:**  
- Bryce Shifflett
- Chidera C. Nnadiekwe
- Jacob Pham
- Iago T. Nonaka
- Carlos Rodriguez Coronel
- Michael Brennan
- Jonathan Hebert
- Abdul Mutaal
- Isaac Humphries
- Jacob Atkinson
- Parker Ryan

**Instructor:** Dr. Jianhua Chen  
**Date:** April 29, 2026  


## Abstract

International trade among nations is an important indicator of the global economy. It boosts economic growth, reduces poverty, fosters efficiency, lowers costs of production through economies of sales, and facilitates access to goods and services. Ultimately, international trade aims to improve standards of living. The vast information regarding international trades is scattered over many materials and online resources and requires time and effort to synthesize collectively. Hence, designing and creating a relational database will make it easy, efficient, and convenient to access this information. In designing the International Trade Relations Database (ITRD), we considered the following relations for the logical schema, Regions (continent/trading bloc grouping), Countries, Product Categories, Products, Trade Agreements, Agreement Members, Tariffs, Trade Flows, Exchange Rates, and Sanctions. We have also included an E-R diagram for effective visualization of table relationships and created Views for top bilateral trade relationships, trade balance per country per year, as well as tariff impact. Some analytical queries we have included are (1) Which country trades the most, (2) Trade balance for every country in a particular year, and (3) Product most impacted by tariffs greater than 10%, amongst others. To implement this database, we used VS Code as code editor, Mermaid Live Editor for our E-R diagram, GitHub for project planification and implementation, and Warp or VS Code Terminal as command interface.

---

## Table of Contents

[TOC]

---

## 1. Introduction

The database we created shows a comprehensive representation of international trade between various countries and regions. The database tracks products and product categories, trade agreements, members of those trade agreements, tariffs, trade flow, exchange rates, and sanctions, tracking the data between countries and regions. All of this information is then organized appropriately to be easily readable and allow easy analysis of the information. Collecting and tracking all this information on international trade, especially for over 100 countries, is an incredibly daunting and time-consuming task for anyone that wants to. It would require gathering this information across numerous sources, verifying the information yourself to make sure the information is reliable, and then piecing it all together to make the final collection of data more comprehensive and understandable. However, by instead hosting all of this information in a single, easily accessible database, one that can be updated instantaneously as new information comes out, it makes this task incredibly easier and means that all of this is easily accessible by any individual, so they don’t have to do this task themselves. The primary users of this database would be economists and trade experts who can use this database to help track the complex global trade. It will also allow those with stocks or seeking to invest in a company to better understand what markets/products are hot or cold, allowing them to make more informed decisions regarding the buying or selling of stocks or investment.

---

## 2. Database Design

Our database design follows the main requirements of modeling global trade data in a way that is consistent, reliable, and easy to query. We designed the schema around core trade entities and connected them with foreign key relationships so that each record can be traced back to valid country, product, and agreement information.

The main requirements we considered were storing country information, product information, annual bilateral trade flows, tariff rates, agreement memberships, sanctions, and exchange rates. To support analysis, we also needed the data to work well with joins, groupings, and aggregate queries.

Some business rules were applied in the schema. Each country belongs to one region. Each product belongs to one product category. Trade flow records do not allow a country to trade with itself in the same record. Tariff lines and trade flow lines are unique for each country-pair, product, and year combination. Agreement membership is many-to-many, so we use a bridge table (`agreement_members`) between agreements and countries. Exchange rates are unique per country and year. Sanctions also prevent self-targeting by the same country.

We used assumptions suitable for the scope of this course project. Data is modeled yearly rather than monthly. Trade values are represented in USD to make cross-country comparisons easier. The dataset is representative and not a complete world dataset, but it includes realistic magnitudes and policy structures.

The E-R design includes ten entities: regions, countries, product categories, products, trade agreements, agreement members, tariffs, trade flows, exchange rates, and sanctions. The relationships include one-to-many links (such as regions to countries and products to trade flows) and many-to-many links (trade agreements to countries through agreement members). The E-R diagram is available in `GROUP_6_DBMS_E-R_SCHEMA.mermaid`.

From a normalization perspective, the tables are generally in 3NF or BCNF. We separated entities to avoid redundancy and update anomalies. For example, product category data is separate from products, and agreement membership is separated from the agreement master table. Functional dependencies are mainly based on primary keys and unique natural keys such as country ISO codes and HS product codes.

A short schema summary is shown below:

- `regions(region_id PK, region_name, region_code)` - BCNF  
- `countries(country_id PK, iso_alpha2, iso_alpha3, country_name, region_id FK, gdp_usd, population, wto_member, joined_wto)` - BCNF  
- `product_categories(category_id PK, category_name, hs_section)` - BCNF  
- `products(product_id PK, hs_code, product_name, category_id FK, unit_of_measure)` - BCNF  
- `trade_agreements(agreement_id PK, agreement_name, agreement_type, signed_date, effective_date, expiry_date, description)` - BCNF  
- `agreement_members(agreement_id PK/FK, country_id PK/FK, joined_date, status)` - BCNF  
- `tariffs(tariff_id PK, importing_country FK, exporting_country FK, product_id FK, year, mfn_rate, applied_rate, specific_duty, agreement_id FK, notes)` - 3NF/BCNF  
- `trade_flows(flow_id PK, exporter_id FK, importer_id FK, product_id FK, year, trade_value_usd, quantity, data_source)` - 3NF/BCNF  
- `exchange_rates(rate_id PK, country_id FK, year, currency_code, usd_rate)` - BCNF  
- `sanctions(sanction_id PK, imposing_country FK, target_country FK, product_id FK, start_date, end_date, sanction_type, legal_basis)` - BCNF

---

## 3. Database Implementation

We implemented the database using MySQL-compatible SQL scripts. The coding work was done in VS Code, and version control/project coordination was done through GitHub. The E-R model was prepared using Mermaid syntax. SQL files include the schema definition, insert scripts, starter data, views, and analytical query examples.

In the implementation process, we first created all tables and constraints from `GROUP_6_DBMS_SCHEMA.sql`. Then we inserted representative data using the insert and starter scripts. After data insertion, we created reusable views for bilateral trade, trade balance, and tariff preference analysis.

The implementation includes the following:
- 10 base tables
- primary keys and foreign keys
- unique constraints on important business keys
- check constraints for key logical rules
- indexes for common analytical query patterns

### 3.1 Data Definition

Data definition in this project includes all `CREATE TABLE`, `CREATE INDEX`, and `CREATE VIEW` statements. These statements are provided in:
- `sql_codes/GROUP_6_DBMS_SCHEMA.sql`
- `sql_codes/GROUP_6_DBMS_USEFUL_VIEWS.sql`

The final report PDF should include table definitions and sample outputs of `SELECT *` from each table (first 10 rows is acceptable for large tables).

### 3.2 Data Manipulation

### 3.3.1 Sample Insert Statements (2 per table)

Below are representative inserts (full scripts are in appendices):

```sql
-- REGIONS
INSERT INTO regions (region_name, region_code) VALUES ('North America', 'NAAM');
INSERT INTO regions (region_name, region_code) VALUES ('European Union', 'EUUN');

-- COUNTRIES
INSERT INTO countries (iso_alpha2, iso_alpha3, country_name, region_id, gdp_usd, population, wto_member, joined_wto)
VALUES ('US','USA','United States',1,27360000000000,335000000,TRUE,'1995-01-01');
INSERT INTO countries (iso_alpha2, iso_alpha3, country_name, region_id, gdp_usd, population, wto_member, joined_wto)
VALUES ('CN','CHN','China',3,17700000000000,1412000000,TRUE,'2001-12-11');

-- PRODUCT_CATEGORIES
INSERT INTO product_categories (category_name, hs_section) VALUES ('Mineral Products', 5);
INSERT INTO product_categories (category_name, hs_section) VALUES ('Machinery & Electronics', 16);

-- PRODUCTS
INSERT INTO products (hs_code, product_name, category_id, unit_of_measure) VALUES ('270900','Crude petroleum oils',5,'barrels');
INSERT INTO products (hs_code, product_name, category_id, unit_of_measure) VALUES ('854231','Electronic integrated circuits (semiconductors)',16,'units');

-- TRADE_AGREEMENTS
INSERT INTO trade_agreements (agreement_name, agreement_type, signed_date, effective_date, description)
VALUES ('USMCA','FTA','2018-11-30','2020-07-01','US-Mexico-Canada Agreement');
INSERT INTO trade_agreements (agreement_name, agreement_type, signed_date, effective_date, description)
VALUES ('RCEP','FTA','2020-11-15','2022-01-01','Regional Comprehensive Economic Partnership');

-- AGREEMENT_MEMBERS
INSERT INTO agreement_members (agreement_id, country_id, joined_date, status) VALUES (2, 1, '2020-07-01', 'active');
INSERT INTO agreement_members (agreement_id, country_id, joined_date, status) VALUES (2, 2, '2020-07-01', 'active');

-- TRADE_FLOWS
INSERT INTO trade_flows (exporter_id, importer_id, product_id, year, trade_value_usd, quantity, data_source)
VALUES (46, 1, 33, 2023, 87000000000, 15000000000, 'UN Comtrade 2023');
INSERT INTO trade_flows (exporter_id, importer_id, product_id, year, trade_value_usd, quantity, data_source)
VALUES (70, 46, 14, 2023, 46000000000, 980000000, 'UN Comtrade 2023');

-- TARIFFS
INSERT INTO tariffs (importing_country, exporting_country, product_id, year, mfn_rate, applied_rate, agreement_id, notes)
VALUES (1,46,33,2023,25.0,25.0,NULL,'Section 301 tariffs maintained');
INSERT INTO tariffs (importing_country, exporting_country, product_id, year, mfn_rate, applied_rate, agreement_id, notes)
VALUES (1,2,38,2023,2.5,0.0,2,'USMCA preferential rate');

-- EXCHANGE_RATES
INSERT INTO exchange_rates (country_id, year, currency_code, usd_rate) VALUES (1, 2023, 'USD', 1.000000);
INSERT INTO exchange_rates (country_id, year, currency_code, usd_rate) VALUES (46, 2023, 'CNY', 7.075000);

-- SANCTIONS
INSERT INTO sanctions (imposing_country, target_country, product_id, start_date, end_date, sanction_type, legal_basis)
VALUES (1,36,14,'2022-03-08',NULL,'import ban','Executive Order 14066');
INSERT INTO sanctions (imposing_country, target_country, product_id, start_date, end_date, sanction_type, legal_basis)
VALUES (1,46,33,'2018-07-06',NULL,'elevated tariff','USTR Section 301 Investigation');
```

### 3.2.1 Table Contents (`SELECT *`) for Report Screenshots

For the final PDF submission, run and capture output for:

```sql
SELECT * FROM regions LIMIT 10;
SELECT * FROM countries LIMIT 10;
SELECT * FROM product_categories LIMIT 10;
SELECT * FROM products LIMIT 10;
SELECT * FROM trade_agreements LIMIT 10;
SELECT * FROM agreement_members LIMIT 10;
SELECT * FROM trade_flows LIMIT 10;
SELECT * FROM tariffs LIMIT 10;
SELECT * FROM exchange_rates LIMIT 10;
SELECT * FROM sanctions LIMIT 10;
```

## 3.3 Analytical SQL Queries (10-15)

To satisfy the course requirement, we included 12 analytical queries covering joins, subqueries, common table expressions, aggregation, and window-style analysis. For each query in the final PDF, show:
1. the English statement,
2. the SQL code,
3. a screenshot of the result.

### Query 1: Top bilateral trade pairs

English statement: Find the top country pairs by two-way trade value in a selected year.
```sql
SELECT country_a, country_b, year, ROUND(total_two_way_usd / 1e9, 1) AS total_billion_usd
FROM vw_bilateral_trade
WHERE year = 2022
ORDER BY total_two_way_usd DESC
LIMIT 10;
```

### Query 2: Country trade balances

English statement: Compute exports, imports, and trade balance by country for 2022.
```sql
SELECT country_name,
       ROUND(exports_usd / 1e9, 1) AS exports_bn,
       ROUND(ABS(imports_neg_usd) / 1e9, 1) AS imports_bn,
       ROUND(trade_balance_usd / 1e9, 1) AS balance_bn
FROM vw_trade_balance
WHERE year = 2022
ORDER BY trade_balance_usd DESC;
```

### Query 3: High-tariff affected products

English statement: List product flows where applied tariff exceeds 10%.
```sql
SELECT p.hs_code, p.product_name, i.country_name AS importer, e.country_name AS exporter,
       t.applied_rate AS tariff_pct, ROUND(tf.trade_value_usd/1e9,2) AS flow_bn_usd
FROM tariffs t
JOIN products p ON p.product_id = t.product_id
JOIN countries i ON i.country_id = t.importing_country
JOIN countries e ON e.country_id = t.exporting_country
LEFT JOIN trade_flows tf ON tf.exporter_id = t.exporting_country
                        AND tf.importer_id = t.importing_country
                        AND tf.product_id = t.product_id
                        AND tf.year = t.year
WHERE t.applied_rate > 10
ORDER BY t.applied_rate DESC, tf.trade_value_usd DESC;
```

### Query 4: Tariff preference by trade agreement

English statement: Measure average tariff reduction margins attributable to agreements.
```sql
SELECT agreement_name,
       COUNT(*) AS tariff_lines,
       ROUND(AVG(preference_margin), 2) AS avg_margin_pct
FROM vw_tariff_preference
WHERE agreement_name IS NOT NULL
GROUP BY agreement_name
ORDER BY avg_margin_pct DESC;
```

### Query 5: Top globally traded products

English statement: Find top products by aggregate trade value in 2022.
```sql
SELECT p.hs_code, p.product_name,
       ROUND(SUM(tf.trade_value_usd)/1e9,1) AS global_flow_bn_usd
FROM trade_flows tf
JOIN products p ON p.product_id = tf.product_id
WHERE tf.year = 2022
GROUP BY p.hs_code, p.product_name
ORDER BY global_flow_bn_usd DESC
LIMIT 10;
```

### Query 6: Sanctioned trade flows at sanction start year

English statement: Estimate the bilateral trade value when a sanction started.
```sql
SELECT imp.country_name AS imposing, tgt.country_name AS target, p.product_name,
       s.start_date, ROUND(SUM(tf.trade_value_usd)/1e9, 2) AS remaining_flow_bn_usd
FROM sanctions s
JOIN countries imp ON imp.country_id = s.imposing_country
JOIN countries tgt ON tgt.country_id = s.target_country
LEFT JOIN products p ON p.product_id = s.product_id
LEFT JOIN trade_flows tf
  ON ((tf.exporter_id = s.target_country AND tf.importer_id = s.imposing_country)
   OR (tf.exporter_id = s.imposing_country AND tf.importer_id = s.target_country))
 AND (s.product_id IS NULL OR tf.product_id = s.product_id)
 AND tf.year = EXTRACT(YEAR FROM s.start_date)
GROUP BY imp.country_name, tgt.country_name, p.product_name, s.start_date
ORDER BY s.start_date;
```

### Query 7: Regional trade intensity

English statement: Compare intra-region and inter-region trade shares.
```sql
SELECT er.region_name AS exporter_region, ir.region_name AS importer_region,
       ROUND(SUM(tf.trade_value_usd)/1e9, 1) AS flow_bn_usd,
       ROUND(100.0 * SUM(tf.trade_value_usd) / SUM(SUM(tf.trade_value_usd)) OVER (), 1) AS pct_of_total
FROM trade_flows tf
JOIN countries e ON e.country_id = tf.exporter_id
JOIN countries i ON i.country_id = tf.importer_id
JOIN regions er ON er.region_id = e.region_id
JOIN regions ir ON ir.region_id = i.region_id
WHERE tf.year = 2022
GROUP BY er.region_name, ir.region_name
ORDER BY flow_bn_usd DESC;
```

### Query 8: Export concentration risk

English statement: Identify countries where one product exceeds 30% of export value.
```sql
WITH country_totals AS (
  SELECT exporter_id, year, SUM(trade_value_usd) AS total_exports
  FROM trade_flows
  GROUP BY exporter_id, year
),
country_product AS (
  SELECT exporter_id, product_id, year, SUM(trade_value_usd) AS product_exports
  FROM trade_flows
  GROUP BY exporter_id, product_id, year
)
SELECT c.country_name, p.product_name, cp.year,
       ROUND(cp.product_exports / ct.total_exports * 100, 1) AS export_concentration_pct
FROM country_product cp
JOIN country_totals ct ON ct.exporter_id = cp.exporter_id AND ct.year = cp.year
JOIN countries c ON c.country_id = cp.exporter_id
JOIN products p ON p.product_id = cp.product_id
WHERE cp.year = 2022
  AND cp.product_exports / ct.total_exports > 0.30
ORDER BY export_concentration_pct DESC
LIMIT 10;
```

### Query 9: Exchange-rate adjusted values

English statement: Convert USD trade values into exporter and importer local currencies.
```sql
SELECT e.country_name AS exporter, i.country_name AS importer, p.product_name,
       tf.trade_value_usd,
       xr_e.currency_code AS exporter_currency,
       ROUND(tf.trade_value_usd * xr_e.usd_rate, 0) AS value_in_exporter_currency,
       xr_i.currency_code AS importer_currency,
       ROUND(tf.trade_value_usd * xr_i.usd_rate, 0) AS value_in_importer_currency
FROM trade_flows tf
JOIN countries e ON e.country_id = tf.exporter_id
JOIN countries i ON i.country_id = tf.importer_id
JOIN products p ON p.product_id = tf.product_id
LEFT JOIN exchange_rates xr_e ON xr_e.country_id = tf.exporter_id AND xr_e.year = tf.year
LEFT JOIN exchange_rates xr_i ON xr_i.country_id = tf.importer_id AND xr_i.year = tf.year
WHERE tf.year = 2022
ORDER BY tf.trade_value_usd DESC
LIMIT 10;
```

### Query 10: Top importers of semiconductors

English statement: Find leading import destinations for HS code 854231 in 2022/2023.
```sql
SELECT i.country_name AS importer, tf.year, ROUND(SUM(tf.trade_value_usd)/1e9,2) AS import_bn_usd
FROM trade_flows tf
JOIN countries i ON i.country_id = tf.importer_id
JOIN products p ON p.product_id = tf.product_id
WHERE p.hs_code = '854231'
GROUP BY i.country_name, tf.year
ORDER BY import_bn_usd DESC;
```

### Query 11: Agreement membership size

English statement: Count active members by agreement.
```sql
SELECT ta.agreement_name, COUNT(*) AS active_members
FROM agreement_members am
JOIN trade_agreements ta ON ta.agreement_id = am.agreement_id
WHERE am.status = 'active'
GROUP BY ta.agreement_name
ORDER BY active_members DESC;
```

### Query 12: Average tariff by importer

English statement: Compute mean applied tariff each country imposes in 2023.
```sql
SELECT c.country_name AS importer,
       ROUND(AVG(t.applied_rate),2) AS avg_applied_tariff_pct,
       COUNT(*) AS tariff_lines
FROM tariffs t
JOIN countries c ON c.country_id = t.importing_country
WHERE t.year = 2023
GROUP BY c.country_name
ORDER BY avg_applied_tariff_pct DESC;
```

### 3.4 Update Statements (4-5 required)

```sql
-- U1: update a tariff after policy change
UPDATE tariffs
SET applied_rate = 20.0, notes = 'Policy revision: reduced from 25% to 20%'
WHERE importing_country = (SELECT country_id FROM countries WHERE iso_alpha3 = 'USA')
  AND exporting_country = (SELECT country_id FROM countries WHERE iso_alpha3 = 'CHN')
  AND product_id = (SELECT product_id FROM products WHERE hs_code = '854231')
  AND year = 2023;

-- U2: update sanctions end date after removal
UPDATE sanctions
SET end_date = '2024-12-31', legal_basis = CONCAT(legal_basis, '; amended by new decree')
WHERE imposing_country = (SELECT country_id FROM countries WHERE iso_alpha3 = 'USA')
  AND target_country = (SELECT country_id FROM countries WHERE iso_alpha3 = 'CHN')
  AND sanction_type = 'elevated tariff';

-- U3: update GDP estimate
UPDATE countries
SET gdp_usd = gdp_usd * 1.015
WHERE iso_alpha3 = 'IND';

-- U4: update exchange rate for revised annual average
UPDATE exchange_rates
SET usd_rate = 82.950000
WHERE country_id = (SELECT country_id FROM countries WHERE iso_alpha3 = 'IND')
  AND year = 2023;

-- U5: mark agreement membership withdrawn
UPDATE agreement_members
SET status = 'withdrawn'
WHERE agreement_id = (SELECT agreement_id FROM trade_agreements WHERE agreement_name = 'EU Single Market')
  AND country_id = (SELECT country_id FROM countries WHERE iso_alpha3 = 'GBR');
```

---

## 4. Conclusion and Future Directions

This project provides a complete relational database for analyzing international trade relations in a structured and practical way. By combining trade flows, tariffs, agreements, sanctions, and exchange rates in one schema, the database supports useful policy and market analysis while remaining readable and easy to extend.

The implementation also demonstrates core concepts from CSC 4402, including normalization, key constraints, foreign key integrity, views, and advanced SQL query writing. Overall, the project meets the goals of both technical database design and real-world analytical usefulness.

In future work, this database can be expanded with more countries, finer time granularity, automated data loading pipelines, and a simple web interface for non-technical users.

---

## 5. References

1. Project repository: [Chidera-Nnadiekwe/CSC-4402G-DBMS-group-project](https://github.com/Chidera-Nnadiekwe/CSC-4402G-DBMS-group-project)  
2. UN Comtrade Database (data source referenced in SQL comments).  
3. WTO Statistics and Tariff Profiles (data source referenced in SQL comments).  
4. World Bank Open Data (GDP and population context referenced in SQL comments).  
5. IMF exchange-rate datasets (referenced in SQL comments).  

---

## 6. Appendices

### Appendix A: Repository Files Used

- `README.md`  
- `GROUP_6_DBMS_E-R_SCHEMA.mermaid`  
- `sql_codes/GROUP_6_DBMS_SCHEMA.sql`  
- `sql_codes/GROUP_6_DBMS_STARTER_DATA.sql`  
- `sql_codes/GROUP_6_DBMS_INSERT_STATEMENTS.sql`  
- `sql_codes/GROUP_6_DBMS_USEFUL_VIEWS.sql`  
- `sql_codes/GROUP_6_DBMS_TRADE_QUERIES.sql`  

### Appendix B: Suggested Final Submission Checklist

- Replace placeholder member names on cover page.
- Add page numbers in the final edited document.
- Include screenshot of the E-R diagram.
- Include `SELECT *` screenshots for each table (first 10 rows for large tables).
- Include screenshots for query results (Queries 1 to 12).
- Include update statement result screenshots where appropriate.
- Export final report to PDF before submission.

