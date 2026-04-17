-- ============================================================
--  INTERNATIONAL TRADE DATABASE — Analytical Query Examples
-- ============================================================

-- ─────────────────────────────────────────────
-- Q1. Which country pairs trade the most? (Top 10 bilateral)
-- ─────────────────────────────────────────────
SELECT
    country_a,
    country_b,
    year,
    ROUND(total_two_way_usd / 1e9, 1) AS total_billion_usd
FROM vw_bilateral_trade
WHERE year = 2022
ORDER BY total_two_way_usd DESC
LIMIT 10;

-- ─────────────────────────────────────────────
-- Q2. Trade balance for every country (2023)
-- ─────────────────────────────────────────────
SELECT
    country_name,
    ROUND(exports_usd / 1e9, 1) AS exports_bn,
    ROUND(ABS(imports_neg_usd) / 1e9, 1) AS imports_bn,
    ROUND(trade_balance_usd / 1e9, 1) AS balance_bn,
    CASE WHEN trade_balance_usd > 0 THEN '▲ Surplus' ELSE '▼ Deficit' END AS status
FROM vw_trade_balance
WHERE year = 2022
ORDER BY trade_balance_usd DESC;

-- ─────────────────────────────────────────────
-- Q3. Products most affected by tariffs > 10%
-- ─────────────────────────────────────────────
SELECT
    p.hs_code,
    p.product_name,
    pc.category_name,
    i.country_name  AS importer,
    e.country_name  AS exporter,
    t.applied_rate  AS tariff_pct,
    ROUND(tf.trade_value_usd / 1e9, 2) AS flow_bn_usd
FROM tariffs t
JOIN products          p  ON p.product_id   = t.product_id
JOIN product_categories pc ON pc.category_id = p.category_id
JOIN countries         i  ON i.country_id   = t.importing_country
JOIN countries         e  ON e.country_id   = t.exporting_country
LEFT JOIN trade_flows  tf ON tf.exporter_id = t.exporting_country
                          AND tf.importer_id = t.importing_country
                          AND tf.product_id  = t.product_id
                          AND tf.year        = t.year
WHERE t.applied_rate > 10
ORDER BY t.applied_rate DESC, tf.trade_value_usd DESC;

-- ─────────────────────────────────────────────
-- Q4. Effect of trade agreements: preference margin by agreement
-- ─────────────────────────────────────────────
SELECT
    agreement_name,
    COUNT(*)                          AS tariff_lines,
    ROUND(AVG(preference_margin), 2)  AS avg_margin_pct,
    ROUND(MAX(preference_margin), 2)  AS max_margin_pct,
    GROUP_CONCAT(DISTINCT importer ORDER BY importer SEPARATOR ', ' ) AS importers
FROM vw_tariff_preference
WHERE agreement_name IS NOT NULL
GROUP BY agreement_name
ORDER BY avg_margin_pct DESC;

-- ─────────────────────────────────────────────
-- Q5. Top exported products globally (by value)
-- ─────────────────────────────────────────────
SELECT
    p.hs_code,
    p.product_name,
    pc.category_name,
    COUNT(DISTINCT tf.exporter_id)       AS exporting_nations,
    COUNT(DISTINCT tf.importer_id)       AS importing_nations,
    ROUND(SUM(tf.trade_value_usd)/1e9,1) AS global_flow_bn_usd
FROM trade_flows tf
JOIN products          p  ON p.product_id  = tf.product_id
JOIN product_categories pc ON pc.category_id = p.category_id
WHERE tf.year = 2022
GROUP BY p.hs_code, p.product_name, pc.category_name
ORDER BY global_flow_bn_usd DESC
LIMIT 10;

-- ─────────────────────────────────────────────
-- Q6. Impact of sanctions — compare trade before/after
--     (hypothetical: compare sanctioned vs non-sanctioned flows for same product)
-- ─────────────────────────────────────────────
SELECT
    imp.country_name  AS imposing,
    tgt.country_name  AS target,
    p.product_name,
    s.start_date,
    s.sanction_type,
    -- Flows in the year of sanction
    ROUND(SUM(tf.trade_value_usd)/1e9, 2) AS remaining_flow_bn_usd
FROM sanctions s
JOIN countries imp ON imp.country_id = s.imposing_country
JOIN countries tgt ON tgt.country_id = s.target_country
LEFT JOIN products p ON p.product_id = s.product_id
LEFT JOIN trade_flows tf
    ON  (tf.exporter_id = s.target_country AND tf.importer_id = s.imposing_country
      OR tf.exporter_id = s.imposing_country AND tf.importer_id = s.target_country)
    AND (s.product_id IS NULL OR tf.product_id = s.product_id)
    AND tf.year = EXTRACT(YEAR FROM s.start_date) -- returns int by default
GROUP BY imp.country_name, tgt.country_name, p.product_name, s.start_date, s.sanction_type
ORDER BY s.start_date;

-- ─────────────────────────────────────────────
-- Q7. Regional trade intensity (intra-region vs cross-region)
-- ─────────────────────────────────────────────
SELECT
    er.region_name   AS exporter_region,
    ir.region_name   AS importer_region,
    ROUND(SUM(tf.trade_value_usd)/1e9, 1) AS flow_bn_usd,
    ROUND(100.0 * SUM(tf.trade_value_usd) /
        SUM(SUM(tf.trade_value_usd)) OVER (), 1)    AS pct_of_total
FROM trade_flows tf
JOIN countries e  ON e.country_id = tf.exporter_id
JOIN countries i  ON i.country_id = tf.importer_id
JOIN regions   er ON er.region_id = e.region_id
JOIN regions   ir ON ir.region_id = i.region_id
WHERE tf.year = 2022
GROUP BY er.region_name, ir.region_name
ORDER BY flow_bn_usd DESC;

-- ─────────────────────────────────────────────
-- Q8. Countries most dependent on a single export product
-- ─────────────────────────────────────────────
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
SELECT
    c.country_name,
    p.product_name,
    cp.year,
    ROUND(cp.product_exports / ct.total_exports * 100, 1) AS export_concentration_pct
FROM country_product cp
JOIN country_totals ct ON ct.exporter_id = cp.exporter_id AND ct.year = cp.year
JOIN countries c ON c.country_id = cp.exporter_id
JOIN products  p ON p.product_id = cp.product_id
WHERE cp.year = 2022
  AND cp.product_exports / ct.total_exports > 0.30   -- >30% of exports = 1 product
ORDER BY export_concentration_pct DESC
LIMIT 10;

-- ─────────────────────────────────────────────
-- Q9. Exchange-rate adjusted trade value (local currency)
-- ─────────────────────────────────────────────
SELECT
    e.country_name                             AS exporter,
    i.country_name                             AS importer,
    p.product_name,
    tf.trade_value_usd,
    xr_e.currency_code                         AS exporter_currency,
    ROUND(tf.trade_value_usd * xr_e.usd_rate, 0) AS value_in_exporter_currency,
    xr_i.currency_code                         AS importer_currency,
    ROUND(tf.trade_value_usd * xr_i.usd_rate, 0) AS value_in_importer_currency
FROM trade_flows tf
JOIN countries e      ON e.country_id  = tf.exporter_id
JOIN countries i      ON i.country_id  = tf.importer_id
JOIN products  p      ON p.product_id  = tf.product_id
LEFT JOIN exchange_rates xr_e ON xr_e.country_id = tf.exporter_id AND xr_e.year = tf.year
LEFT JOIN exchange_rates xr_i ON xr_i.country_id = tf.importer_id AND xr_i.year = tf.year
WHERE tf.year = 2022
ORDER BY tf.trade_value_usd DESC
LIMIT 10;

-- ─────────────────────────────────────────────
-- Q10. Countries with the most trade agreements
-- ─────────────────────────────────────────────
SELECT
    c.country_name,
    r.region_name,
    COUNT(am.agreement_id)          AS total_agreements,
    GROUP_CONCAT(ta.agreement_name ORDER BY ta.agreement_name SEPARATOR ', ') AS agreements
FROM agreement_members am
JOIN countries        c  ON c.country_id   = am.country_id
JOIN regions          r  ON r.region_id    = c.region_id
JOIN trade_agreements ta ON ta.agreement_id = am.agreement_id
WHERE am.status = 'active'
GROUP BY c.country_name, r.region_name
ORDER BY total_agreements DESC
LIMIT 10;

-- ─────────────────────────────────────────────
-- Q11. Top 10 importers of crude oil (HS 270900)
-- ─────────────────────────────────────────────
SELECT
    i.country_name                          AS importer,
    r.region_name,
    ROUND(SUM(tf.trade_value_usd) / 1e9, 2) AS total_import_bn_usd,
    SUM(tf.quantity)                         AS total_barrels
FROM trade_flows tf
JOIN countries i ON i.country_id = tf.importer_id
JOIN regions   r ON r.region_id  = i.region_id
JOIN products  p ON p.product_id = tf.product_id
WHERE p.hs_code = '270900'
  AND tf.year = 2022
GROUP BY i.country_name, r.region_name
ORDER BY total_import_bn_usd DESC
LIMIT 10;

-- ─────────────────────────────────────────────
-- Q12. Average applied tariff rate by product category
-- ─────────────────────────────────────────────
SELECT
    pc.category_name,
    COUNT(t.tariff_id)              AS tariff_lines,
    ROUND(AVG(t.mfn_rate), 2)       AS avg_mfn_rate_pct,
    ROUND(AVG(t.applied_rate), 2)   AS avg_applied_rate_pct,
    ROUND(AVG(t.mfn_rate - t.applied_rate), 2) AS avg_preference_margin_pct
FROM tariffs t
JOIN products         p  ON p.product_id  = t.product_id
JOIN product_categories pc ON pc.category_id = p.category_id
GROUP BY pc.category_name
ORDER BY avg_applied_rate_pct DESC;

-- ─────────────────────────────────────────────
-- Q13. Countries currently under active sanctions
--      and their total trade volume
-- ─────────────────────────────────────────────
SELECT
    tgt.country_name                         AS sanctioned_country,
    COUNT(DISTINCT s.imposing_country)       AS sanctioned_by_n_countries,
    GROUP_CONCAT(DISTINCT imp.country_name ORDER BY imp.country_name SEPARATOR ', ') AS sanctioned_by,
    ROUND(SUM(tf.trade_value_usd) / 1e9, 2) AS total_trade_bn_usd
FROM sanctions s
JOIN countries tgt ON tgt.country_id = s.target_country
JOIN countries imp ON imp.country_id = s.imposing_country
LEFT JOIN trade_flows tf
    ON (tf.exporter_id = s.target_country OR tf.importer_id = s.target_country)
    AND tf.year = 2022
WHERE s.end_date IS NULL
GROUP BY tgt.country_name
ORDER BY sanctioned_by_n_countries DESC;

-- ─────────────────────────────────────────────
-- Q14. WTO members vs non-WTO members:
--      average GDP and trade volume comparison
-- ─────────────────────────────────────────────
SELECT
    CASE WHEN c.wto_member = 1 THEN 'WTO Member' ELSE 'Non-WTO Member' END AS membership_status,
    COUNT(DISTINCT c.country_id)             AS country_count,
    ROUND(AVG(c.gdp_usd) / 1e9, 1)          AS avg_gdp_bn_usd,
    ROUND(SUM(tf.trade_value_usd) / 1e9, 1) AS total_trade_bn_usd
FROM countries c
LEFT JOIN trade_flows tf
    ON (tf.exporter_id = c.country_id OR tf.importer_id = c.country_id)
    AND tf.year = 2022
GROUP BY c.wto_member
ORDER BY total_trade_bn_usd DESC;

-- ─────────────────────────────────────────────
-- Q15. Countries that have a trade surplus AND
--      are imposing active sanctions (sub-query)
-- ─────────────────────────────────────────────
SELECT
    c.country_name,
    ROUND(tb.trade_balance_usd / 1e9, 2) AS trade_surplus_bn_usd,
    COUNT(DISTINCT s.target_country)     AS countries_sanctioned
FROM countries c
JOIN vw_trade_balance tb ON tb.country_name = c.country_name AND tb.year = 2022
JOIN sanctions s ON s.imposing_country = c.country_id AND s.end_date IS NULL
WHERE tb.trade_balance_usd > 0
  AND c.country_id IN (
      SELECT DISTINCT imposing_country
      FROM sanctions
      WHERE end_date IS NULL
  )
GROUP BY c.country_name, tb.trade_balance_usd
ORDER BY trade_surplus_bn_usd DESC;

-- ============================================================
--  UPDATE STATEMENTS
-- ============================================================

-- ─────────────────────────────────────────────
-- U1. Update GDP for the United States (2023 revised estimate)
-- ─────────────────────────────────────────────
UPDATE countries
SET gdp_usd = 27360000000000.00
WHERE iso_alpha3 = 'USA';

-- ─────────────────────────────────────────────
-- U2. Reduce the applied tariff rate for US importing
--     laptops from China after a hypothetical trade deal
-- ─────────────────────────────────────────────
UPDATE tariffs
SET applied_rate = 5.0,
    notes = 'Reduced from 7.5% under Phase 2 trade deal'
WHERE importing_country = (SELECT country_id FROM countries WHERE iso_alpha3 = 'USA')
  AND exporting_country = (SELECT country_id FROM countries WHERE iso_alpha3 = 'CHN')
  AND product_id        = (SELECT product_id FROM products WHERE hs_code = '847130')
  AND year = 2023;

-- ─────────────────────────────────────────────
-- U3. Mark the China-Australia barley sanction as lifted
-- ─────────────────────────────────────────────
UPDATE sanctions
SET end_date = '2023-08-05'
WHERE imposing_country = (SELECT country_id FROM countries WHERE iso_alpha3 = 'CHN')
  AND target_country   = (SELECT country_id FROM countries WHERE iso_alpha3 = 'AUS')
  AND product_id       = (SELECT product_id FROM products WHERE hs_code = '100190');

-- ─────────────────────────────────────────────
-- U4. Update Russia's population estimate
-- ─────────────────────────────────────────────
UPDATE countries
SET population = 144000000
WHERE iso_alpha3 = 'RUS';

-- ─────────────────────────────────────────────
-- U5. Update exchange rate for Turkish Lira (2022 revised)
-- ─────────────────────────────────────────────
UPDATE exchange_rates
SET usd_rate = 16.9700
WHERE country_id = (SELECT country_id FROM countries WHERE iso_alpha3 = 'TUR')
  AND year = 2022;
