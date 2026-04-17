const express = require('express');
const router  = express.Router();
const db      = require('../db/connection');

// GET top bilateral trade flows
router.get('/bilateral', async (req, res) => {
    const year = req.query.year || 2022;
    try {
        const [rows] = await db.query(`
            SELECT country_a, country_b, year,
                   ROUND(total_two_way_usd / 1e9, 1) AS total_bn_usd
            FROM vw_bilateral_trade
            WHERE year = ?
            ORDER BY total_two_way_usd DESC
            LIMIT 20
        `, [year]);
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// GET global trade flows (for map visualization)
router.get('/flows', async (req, res) => {
    const year = req.query.year || 2022;
    try {
        const [rows] = await db.query(`
            SELECT
                e.country_name AS exporter, e.iso_alpha3 AS exporter_iso3,
                i.country_name AS importer, i.iso_alpha3 AS importer_iso3,
                p.product_name, p.hs_code,
                ROUND(tf.trade_value_usd / 1e9, 2) AS trade_value_bn_usd
            FROM trade_flows tf
            JOIN countries e ON e.country_id = tf.exporter_id
            JOIN countries i ON i.country_id = tf.importer_id
            JOIN products  p ON p.product_id = tf.product_id
            WHERE tf.year = ?
            ORDER BY tf.trade_value_usd DESC
        `, [year]);
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// GET regional trade intensity
router.get('/regions', async (req, res) => {
    const year = req.query.year || 2022;
    try {
        const [rows] = await db.query(`
            SELECT
                er.region_name AS exporter_region,
                ir.region_name AS importer_region,
                ROUND(SUM(tf.trade_value_usd) / 1e9, 1) AS flow_bn_usd
            FROM trade_flows tf
            JOIN countries e  ON e.country_id = tf.exporter_id
            JOIN countries i  ON i.country_id = tf.importer_id
            JOIN regions   er ON er.region_id = e.region_id
            JOIN regions   ir ON ir.region_id = i.region_id
            WHERE tf.year = ?
            GROUP BY er.region_name, ir.region_name
            ORDER BY flow_bn_usd DESC
        `, [year]);
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;
