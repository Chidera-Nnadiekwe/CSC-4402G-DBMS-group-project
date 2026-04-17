const express = require('express');
const router  = express.Router();
const db      = require('../db/connection');

// GET all countries with region name
router.get('/', async (req, res) => {
    try {
        const [rows] = await db.query(`
            SELECT c.country_id, c.country_name, c.iso_alpha2, c.iso_alpha3,
                   c.gdp_usd, c.population, c.wto_member, c.joined_wto,
                   r.region_name
            FROM countries c
            JOIN regions r ON r.region_id = c.region_id
            ORDER BY c.country_name
        `);
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// GET trade relations for a specific country
router.get('/:iso3/trade', async (req, res) => {
    const { iso3 } = req.params;
    try {
        const [rows] = await db.query(`
            SELECT
                e.country_name  AS exporter,
                e.iso_alpha3    AS exporter_iso3,
                i.country_name  AS importer,
                i.iso_alpha3    AS importer_iso3,
                p.product_name,
                p.hs_code,
                tf.year,
                ROUND(tf.trade_value_usd / 1e9, 2) AS trade_value_bn_usd
            FROM trade_flows tf
            JOIN countries e ON e.country_id = tf.exporter_id
            JOIN countries i ON i.country_id = tf.importer_id
            JOIN products  p ON p.product_id = tf.product_id
            WHERE e.iso_alpha3 = ? OR i.iso_alpha3 = ?
            ORDER BY tf.trade_value_usd DESC
        `, [iso3, iso3]);
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// GET trade balance for a specific country
router.get('/:iso3/balance', async (req, res) => {
    const { iso3 } = req.params;
    try {
        const [rows] = await db.query(`
            SELECT tb.*
            FROM vw_trade_balance tb
            JOIN countries c ON c.country_name = tb.country_name
            WHERE c.iso_alpha3 = ?
            ORDER BY tb.year DESC
        `, [iso3]);
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// GET sanctions involving a specific country
router.get('/:iso3/sanctions', async (req, res) => {
    const { iso3 } = req.params;
    try {
        const [rows] = await db.query(`
            SELECT
                imp.country_name AS imposing_country,
                tgt.country_name AS target_country,
                p.product_name,
                s.start_date, s.end_date,
                s.sanction_type, s.legal_basis
            FROM sanctions s
            JOIN countries imp ON imp.country_id = s.imposing_country
            JOIN countries tgt ON tgt.country_id = s.target_country
            LEFT JOIN products p ON p.product_id = s.product_id
            WHERE imp.iso_alpha3 = ? OR tgt.iso_alpha3 = ?
            ORDER BY s.start_date DESC
        `, [iso3, iso3]);
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;
