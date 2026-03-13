-- ─────────────────────────────────────────────
-- USEFUL VIEWS
-- ─────────────────────────────────────────────
-- Top bilateral trade relationships (total two-way flow)
CREATE OR REPLACE VIEW vw_bilateral_trade AS
SELECT LEAST(e.country_name, i.country_name) AS country_a,
    GREATEST(e.country_name, i.country_name) AS country_b,
    tf.year,
    SUM(tf.trade_value_usd) AS total_two_way_usd
FROM trade_flows tf
    JOIN countries e ON e.country_id = tf.exporter_id
    JOIN countries i ON i.country_id = tf.importer_id
GROUP BY 1,
    2,
    3;
-- Trade balance per country per year
CREATE OR REPLACE VIEW vw_trade_balance AS
SELECT c.country_name,
    tf.year,
    SUM(
        CASE
            WHEN tf.exporter_id = c.country_id THEN tf.trade_value_usd
            ELSE 0
        END
    ) AS exports_usd,
    SUM(
        CASE
            WHEN tf.importer_id = c.country_id THEN - tf.trade_value_usd
            ELSE 0
        END
    ) AS imports_neg_usd,
    SUM(
        CASE
            WHEN tf.exporter_id = c.country_id THEN tf.trade_value_usd
            WHEN tf.importer_id = c.country_id THEN - tf.trade_value_usd
            ELSE 0
        END
    ) AS trade_balance_usd
FROM countries c
    JOIN trade_flows tf ON tf.exporter_id = c.country_id
    OR tf.importer_id = c.country_id
GROUP BY 1,
    2;
-- Tariff impact: compare MFN vs applied rate
CREATE OR REPLACE VIEW vw_tariff_preference AS
SELECT i.country_name AS importer,
    e.country_name AS exporter,
    p.product_name,
    p.hs_code,
    t.year,
    t.mfn_rate,
    t.applied_rate,
    (t.mfn_rate - t.applied_rate) AS preference_margin,
    ta.agreement_name
FROM tariffs t
    JOIN countries i ON i.country_id = t.importing_country
    JOIN countries e ON e.country_id = t.exporting_country
    JOIN products p ON p.product_id = t.product_id
    LEFT JOIN trade_agreements ta ON ta.agreement_id = t.agreement_id;