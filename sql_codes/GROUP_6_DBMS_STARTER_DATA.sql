-- ============================================================
--  INTERNATIONAL TRADE DATABASE — Seed Data
--  Based on real-world figures (UN Comtrade, WTO, World Bank)
-- ============================================================
-- ─────────────────────────────────────────────
-- REGIONS
-- ─────────────────────────────────────────────
INSERT INTO regions (region_name, region_code)
VALUES ('North America', 'NAAM'),
    ('European Union', 'EUUN'),
    ('East Asia & Pacific', 'EAPC'),
    ('South & Central Asia', 'SCAS'),
    ('Middle East & N Africa', 'MENA'),
    ('Sub-Saharan Africa', 'SSAF'),
    ('Latin America', 'LATM'),
    ('Eastern Europe & CIS', 'ECIS');
-- ─────────────────────────────────────────────
-- COUNTRIES
-- ─────────────────────────────────────────────
INSERT INTO countries (
        iso_alpha2,
        iso_alpha3,
        country_name,
        region_id,
        gdp_usd,
        population,
        wto_member,
        joined_wto
    )
VALUES (
        'US',
        'USA',
        'United States',
        1,
        27360000000000,
        335000000,
        TRUE,
        '1995-01-01'
    ),
    (
        'CA',
        'CAN',
        'Canada',
        1,
        2140000000000,
        38000000,
        TRUE,
        '1995-01-01'
    ),
    (
        'MX',
        'MEX',
        'Mexico',
        1,
        1320000000000,
        130000000,
        TRUE,
        '1995-01-01'
    ),
    (
        'DE',
        'DEU',
        'Germany',
        2,
        4460000000000,
        84000000,
        TRUE,
        '1995-01-01'
    ),
    (
        'FR',
        'FRA',
        'France',
        2,
        3030000000000,
        68000000,
        TRUE,
        '1995-01-01'
    ),
    (
        'NL',
        'NLD',
        'Netherlands',
        2,
        1050000000000,
        17800000,
        TRUE,
        '1995-01-01'
    ),
    (
        'CN',
        'CHN',
        'China',
        3,
        17700000000000,
        1412000000,
        TRUE,
        '2001-12-11'
    ),
    (
        'JP',
        'JPN',
        'Japan',
        3,
        4230000000000,
        125000000,
        TRUE,
        '1995-01-01'
    ),
    (
        'KR',
        'KOR',
        'South Korea',
        3,
        1710000000000,
        51700000,
        TRUE,
        '1995-01-01'
    ),
    (
        'IN',
        'IND',
        'India',
        4,
        3570000000000,
        1430000000,
        TRUE,
        '1995-01-01'
    ),
    (
        'SA',
        'SAU',
        'Saudi Arabia',
        5,
        1060000000000,
        36000000,
        TRUE,
        '2005-12-11'
    ),
    (
        'AE',
        'ARE',
        'United Arab Emirates',
        5,
        509000000000,
        9900000,
        TRUE,
        '1996-04-10'
    ),
    (
        'BR',
        'BRA',
        'Brazil',
        7,
        2080000000000,
        215000000,
        TRUE,
        '1995-01-01'
    ),
    (
        'ZA',
        'ZAF',
        'South Africa',
        6,
        405000000000,
        60000000,
        TRUE,
        '1995-01-01'
    ),
    (
        'NG',
        'NGA',
        'Nigeria',
        6,
        477000000000,
        218000000,
        TRUE,
        '1995-01-01'
    ),
    (
        'RU',
        'RUS',
        'Russia',
        8,
        1860000000000,
        143000000,
        TRUE,
        '2012-08-22'
    ),
    (
        'AU',
        'AUS',
        'Australia',
        3,
        1690000000000,
        26000000,
        TRUE,
        '1995-01-01'
    ),
    (
        'GB',
        'GBR',
        'United Kingdom',
        2,
        3080000000000,
        67000000,
        TRUE,
        '1995-01-01'
    );
-- ─────────────────────────────────────────────
-- PRODUCT CATEGORIES  (HS Sections)
-- ─────────────────────────────────────────────
INSERT INTO product_categories (category_name, hs_section)
VALUES ('Live Animals & Animal Products', 1),
    ('Vegetable Products', 2),
    ('Fats, Oils & Waxes', 3),
    ('Foodstuffs, Beverages & Tobacco', 4),
    ('Mineral Products', 5),
    ('Chemical & Allied Products', 6),
    ('Plastics & Rubber', 7),
    ('Raw Hides, Skins & Leather', 8),
    ('Wood & Wood Products', 9),
    ('Pulp, Paper & Paperboard', 10),
    ('Textiles & Apparel', 11),
    ('Footwear & Headgear', 12),
    ('Stone, Ceramic & Glass', 13),
    ('Precious Metals & Gems', 14),
    ('Base Metals', 15),
    ('Machinery & Electronics', 16),
    ('Vehicles & Transport Equipment', 17),
    ('Optical & Medical Instruments', 18),
    ('Arms & Ammunition', 19),
    ('Miscellaneous Manufactured Articles', 20),
    ('Works of Art & Antiques', 21);
-- ─────────────────────────────────────────────
-- PRODUCTS  (representative sample, real HS codes)
-- ─────────────────────────────────────────────
INSERT INTO products (
        hs_code,
        product_name,
        category_id,
        unit_of_measure
    )
VALUES -- Mineral / Energy
    (
        '270900',
        'Crude petroleum oils',
        5,
        'barrels'
    ),
    (
        '271019',
        'Light petroleum distillates (gasoline/diesel)',
        5,
        'kg'
    ),
    (
        '271111',
        'Liquefied natural gas (LNG)',
        5,
        'kg'
    ),
    (
        '260111',
        'Iron ore, not agglomerated',
        15,
        'kg'
    ),
    (
        '260300',
        'Copper ores and concentrates',
        15,
        'kg'
    ),
    -- Machinery & Electronics
    (
        '847130',
        'Laptops & portable computers',
        16,
        'units'
    ),
    (
        '851762',
        'Smartphones & base stations',
        16,
        'units'
    ),
    (
        '854231',
        'Electronic integrated circuits (semiconductors)',
        16,
        'units'
    ),
    (
        '850440',
        'Static converters (power supplies)',
        16,
        'units'
    ),
    (
        '841182',
        'Gas turbines (aircraft engines)',
        16,
        'units'
    ),
    -- Vehicles
    (
        '870332',
        'Passenger cars, 1500–3000 cc',
        17,
        'units'
    ),
    (
        '870120',
        'Road tractors for semi-trailers',
        17,
        'units'
    ),
    (
        '880240',
        'Aeroplanes > 15 000 kg',
        17,
        'units'
    ),
    -- Chemicals & Pharma
    (
        '300490',
        'Medicaments, mixed/prepared (retail)',
        6,
        'kg'
    ),
    (
        '310210',
        'Urea fertilizers',
        6,
        'kg'
    ),
    -- Agricultural
    (
        '100199',
        'Common wheat & meslin',
        2,
        'kg'
    ),
    (
        '020130',
        'Bovine meat, boneless fresh/chilled',
        1,
        'kg'
    ),
    (
        '090111',
        'Coffee, not roasted or decaffeinated',
        4,
        'kg'
    ),
    (
        '260112',
        'Iron ore, agglomerated (pellets)',
        15,
        'kg'
    ),
    -- Textiles
    (
        '610910',
        'T-shirts, cotton, knitted',
        11,
        'units'
    );
-- ─────────────────────────────────────────────
-- TRADE AGREEMENTS
-- ─────────────────────────────────────────────
INSERT INTO trade_agreements (
        agreement_name,
        agreement_type,
        signed_date,
        effective_date,
        description
    )
VALUES (
        'WTO Multilateral Framework',
        'WTO',
        '1994-04-15',
        '1995-01-01',
        'World Trade Organization base rules for all members'
    ),
    (
        'USMCA',
        'FTA',
        '2018-11-30',
        '2020-07-01',
        'US-Mexico-Canada Agreement, successor to NAFTA'
    ),
    (
        'EU Single Market',
        'CU',
        '1992-02-07',
        '1993-01-01',
        'European Union customs union and single market'
    ),
    (
        'RCEP',
        'FTA',
        '2020-11-15',
        '2022-01-01',
        'Regional Comprehensive Economic Partnership — 15 Asia-Pacific nations'
    ),
    (
        'CPTPP',
        'FTA',
        '2018-03-08',
        '2018-12-30',
        'Comprehensive and Progressive Agreement for Trans-Pacific Partnership'
    ),
    (
        'EU-South Korea FTA',
        'FTA',
        '2010-10-06',
        '2011-07-01',
        'Bilateral FTA between EU and South Korea'
    ),
    (
        'India-UAE CEPA',
        'FTA',
        '2022-02-18',
        '2022-05-01',
        'India–UAE Comprehensive Economic Partnership Agreement'
    ),
    (
        'African Continental Free Trade Area',
        'FTA',
        '2018-03-21',
        '2021-01-01',
        'AfCFTA — largest FTA by member countries'
    );
-- ─────────────────────────────────────────────
-- AGREEMENT MEMBERS
-- ─────────────────────────────────────────────
-- WTO (agreement_id=1) — select members
INSERT INTO agreement_members (agreement_id, country_id, joined_date, status)
SELECT 1,
    country_id,
    joined_wto,
    'active'
FROM countries
WHERE wto_member = TRUE;
-- USMCA (agreement_id=2)
INSERT INTO agreement_members (agreement_id, country_id, joined_date, status)
VALUES (
        2,
        (
            SELECT country_id
            FROM countries
            WHERE iso_alpha3 = 'USA'
        ),
        '2020-07-01',
        'active'
    ),
    (
        2,
        (
            SELECT country_id
            FROM countries
            WHERE iso_alpha3 = 'CAN'
        ),
        '2020-07-01',
        'active'
    ),
    (
        2,
        (
            SELECT country_id
            FROM countries
            WHERE iso_alpha3 = 'MEX'
        ),
        '2020-07-01',
        'active'
    );
-- EU Single Market (agreement_id=3)
INSERT INTO agreement_members (agreement_id, country_id, joined_date, status)
VALUES (
        3,
        (
            SELECT country_id
            FROM countries
            WHERE iso_alpha3 = 'DEU'
        ),
        '1993-01-01',
        'active'
    ),
    (
        3,
        (
            SELECT country_id
            FROM countries
            WHERE iso_alpha3 = 'FRA'
        ),
        '1993-01-01',
        'active'
    ),
    (
        3,
        (
            SELECT country_id
            FROM countries
            WHERE iso_alpha3 = 'NLD'
        ),
        '1993-01-01',
        'active'
    );
-- RCEP (agreement_id=4)
INSERT INTO agreement_members (agreement_id, country_id, joined_date, status)
VALUES (
        4,
        (
            SELECT country_id
            FROM countries
            WHERE iso_alpha3 = 'CHN'
        ),
        '2022-01-01',
        'active'
    ),
    (
        4,
        (
            SELECT country_id
            FROM countries
            WHERE iso_alpha3 = 'JPN'
        ),
        '2022-01-01',
        'active'
    ),
    (
        4,
        (
            SELECT country_id
            FROM countries
            WHERE iso_alpha3 = 'KOR'
        ),
        '2022-01-01',
        'active'
    ),
    (
        4,
        (
            SELECT country_id
            FROM countries
            WHERE iso_alpha3 = 'AUS'
        ),
        '2022-01-01',
        'active'
    );
-- India-UAE CEPA (agreement_id=7)
INSERT INTO agreement_members (agreement_id, country_id, joined_date, status)
VALUES (
        7,
        (
            SELECT country_id
            FROM countries
            WHERE iso_alpha3 = 'IND'
        ),
        '2022-05-01',
        'active'
    ),
    (
        7,
        (
            SELECT country_id
            FROM countries
            WHERE iso_alpha3 = 'ARE'
        ),
        '2022-05-01',
        'active'
    );
-- AfCFTA (agreement_id=8)
INSERT INTO agreement_members (agreement_id, country_id, joined_date, status)
VALUES (
        8,
        (
            SELECT country_id
            FROM countries
            WHERE iso_alpha3 = 'ZAF'
        ),
        '2021-01-01',
        'active'
    ),
    (
        8,
        (
            SELECT country_id
            FROM countries
            WHERE iso_alpha3 = 'NGA'
        ),
        '2021-01-01',
        'active'
    );
-- ─────────────────────────────────────────────
-- TRADE FLOWS  (2023 estimates, USD, real-world magnitudes)
-- Sources: UN Comtrade, WTO Statistics Portal
-- ─────────────────────────────────────────────
INSERT INTO trade_flows (
        exporter_id,
        importer_id,
        product_id,
        year,
        trade_value_usd,
        quantity,
        data_source
    )
SELECT e.country_id,
    i.country_id,
    p.product_id,
    yr,
    val,
    qty,
    'UN Comtrade 2023'
FROM (
        VALUES -- (exporter_iso3, importer_iso3, hs_code, year, value_usd, qty)
            -- China → US: electronics
            (
                'CHN',
                'USA',
                '854231',
                2023,
                87000000000,
                15000000000
            ),
            (
                'CHN',
                'USA',
                '847130',
                2023,
                42000000000,
                4200000000
            ),
            (
                'CHN',
                'USA',
                '851762',
                2023,
                35000000000,
                800000000
            ),
            (
                'CHN',
                'USA',
                '610910',
                2023,
                5800000000,
                700000000
            ),
            -- US → China
            (
                'USA',
                'CHN',
                '880240',
                2023,
                18000000000,
                12000
            ),
            (
                'USA',
                'CHN',
                '100199',
                2023,
                3200000000,
                12000000000
            ),
            (
                'USA',
                'CHN',
                '270900',
                2023,
                7500000000,
                450000000
            ),
            -- Germany → US
            (
                'DEU',
                'USA',
                '870332',
                2023,
                32000000000,
                1200000
            ),
            (
                'DEU',
                'USA',
                '300490',
                2023,
                9400000000,
                180000
            ),
            -- Saudi Arabia → China
            (
                'SAU',
                'CHN',
                '270900',
                2023,
                46000000000,
                980000000
            ),
            -- Russia → China (post-2022 ramp-up)
            (
                'RUS',
                'CHN',
                '270900',
                2023,
                63000000000,
                1400000000
            ),
            (
                'RUS',
                'CHN',
                '271111',
                2023,
                11000000000,
                220000000
            ),
            -- Australia → China
            (
                'AUS',
                'CHN',
                '260111',
                2023,
                59000000000,
                78000000000
            ),
            -- Brazil → China
            (
                'BRA',
                'CHN',
                '260111',
                2023,
                22000000000,
                28000000000
            ),
            (
                'BRA',
                'CHN',
                '020130',
                2023,
                8300000000,
                2100000000
            ),
            -- Japan → US
            (
                'JPN',
                'USA',
                '870332',
                2023,
                17000000000,
                640000
            ),
            (
                'JPN',
                'USA',
                '847130',
                2023,
                4200000000,
                510000
            ),
            -- India → US
            (
                'IND',
                'USA',
                '300490',
                2023,
                8100000000,
                950000
            ),
            (
                'IND',
                'USA',
                '610910',
                2023,
                4300000000,
                620000000
            ),
            -- US → Canada
            (
                'USA',
                'CAN',
                '870332',
                2023,
                24000000000,
                790000
            ),
            (
                'USA',
                'CAN',
                '271019',
                2023,
                18000000000,
                34000000000
            ),
            -- Canada → US
            (
                'CAN',
                'USA',
                '270900',
                2023,
                71000000000,
                1900000000
            ),
            (
                'CAN',
                'USA',
                '271019',
                2023,
                22000000000,
                41000000000
            ),
            -- Mexico → US
            (
                'MEX',
                'USA',
                '870332',
                2023,
                43000000000,
                1700000000
            ),
            (
                'MEX',
                'USA',
                '851762',
                2023,
                16000000000,
                390000000
            ),
            -- Netherlands → Germany (EU internal)
            (
                'NLD',
                'DEU',
                '300490',
                2023,
                11000000000,
                230000
            ),
            (
                'NLD',
                'DEU',
                '854231',
                2023,
                7800000000,
                2400000000
            ),
            -- South Korea → US
            (
                'KOR',
                'USA',
                '870332',
                2023,
                14000000000,
                610000
            ),
            (
                'KOR',
                'USA',
                '854231',
                2023,
                21000000000,
                5200000000
            ),
            -- UAE → India
            (
                'ARE',
                'IND',
                '271019',
                2023,
                9200000000,
                18000000000
            ),
            -- Nigeria → EU
            (
                'NGA',
                'NLD',
                '270900',
                2023,
                12000000000,
                320000000
            ),
            -- South Africa → China
            (
                'ZAF',
                'CHN',
                '260300',
                2023,
                3100000000,
                4200000000
            )
    ) AS v(exp_iso3, imp_iso3, hs, yr, val, qty)
    JOIN countries e ON e.iso_alpha3 = exp_iso3
    JOIN countries i ON i.iso_alpha3 = imp_iso3
    JOIN products p ON p.hs_code = hs;
-- ─────────────────────────────────────────────
-- TARIFFS  (applied rates 2023, selected pairs)
-- Sources: WTO Tariff Profiles, WITS database
-- ─────────────────────────────────────────────
INSERT INTO tariffs (
        importing_country,
        exporting_country,
        product_id,
        year,
        mfn_rate,
        applied_rate,
        agreement_id,
        notes
    )
SELECT i.country_id,
    e.country_id,
    p.product_id,
    yr,
    mfn,
    applied,
    ag_id,
    note
FROM (
        VALUES -- US tariffs
            (
                'USA',
                'CHN',
                '854231',
                2023,
                25.0,
                25.0,
                NULL,
                'Section 301 tariffs maintained'
            ),
            (
                'USA',
                'CHN',
                '847130',
                2023,
                25.0,
                25.0,
                NULL,
                'Section 301 tariffs maintained'
            ),
            (
                'USA',
                'CHN',
                '870332',
                2023,
                27.5,
                27.5,
                NULL,
                'Section 301 + auto tariff'
            ),
            (
                'USA',
                'CAN',
                '870332',
                2023,
                2.5,
                0.0,
                2,
                'USMCA preferential rate'
            ),
            (
                'USA',
                'MEX',
                '610910',
                2023,
                12.0,
                0.0,
                2,
                'USMCA preferential rate'
            ),
            (
                'USA',
                'DEU',
                '870332',
                2023,
                2.5,
                2.5,
                NULL,
                'MFN rate, no bilateral FTA'
            ),
            -- EU tariffs
            (
                'DEU',
                'CHN',
                '847130',
                2023,
                0.0,
                0.0,
                NULL,
                'Zero MFN for laptops (ITA)'
            ),
            (
                'DEU',
                'CHN',
                '870332',
                2023,
                10.0,
                10.0,
                NULL,
                'Standard EU auto tariff'
            ),
            (
                'DEU',
                'KOR',
                '870332',
                2023,
                10.0,
                0.0,
                6,
                'EU-Korea FTA eliminates duty'
            ),
            (
                'FRA',
                'USA',
                '870332',
                2023,
                10.0,
                10.0,
                NULL,
                'No EU-US FTA'
            ),
            -- China tariffs
            (
                'CHN',
                'USA',
                '100199',
                2023,
                65.0,
                65.0,
                NULL,
                'Retaliatory agri tariff since 2018'
            ),
            (
                'CHN',
                'AUS',
                '260111',
                2023,
                3.0,
                0.0,
                4,
                'RCEP preferential rate'
            ),
            (
                'CHN',
                'JPN',
                '847130',
                2023,
                0.0,
                0.0,
                4,
                'RCEP zero tariff'
            ),
            -- India tariffs
            (
                'IND',
                'ARE',
                '271019',
                2023,
                5.0,
                1.0,
                7,
                'India-UAE CEPA reduced rate'
            ),
            (
                'IND',
                'CHN',
                '854231',
                2023,
                20.0,
                20.0,
                NULL,
                'Elevated rate post-border tensions'
            ),
            -- Intra-EU (zero)
            (
                'NLD',
                'DEU',
                '300490',
                2023,
                0.0,
                0.0,
                3,
                'EU single market — no duty'
            ),
            (
                'NLD',
                'DEU',
                '854231',
                2023,
                0.0,
                0.0,
                3,
                'EU single market — no duty'
            )
    ) AS v(
        imp_iso3,
        exp_iso3,
        hs,
        yr,
        mfn,
        applied,
        ag_id,
        note
    )
    JOIN countries i ON i.iso_alpha3 = imp_iso3
    JOIN countries e ON e.iso_alpha3 = exp_iso3
    JOIN products p ON p.hs_code = hs;
-- ─────────────────────────────────────────────
-- EXCHANGE RATES  (annual average 2023, vs USD)
-- ─────────────────────────────────────────────
INSERT INTO exchange_rates (country_id, year, currency_code, usd_rate)
SELECT c.country_id,
    2023,
    cc,
    rate
FROM (
        VALUES ('USA', 'USD', 1.000000),
            ('CAN', 'CAD', 1.349000),
            ('MEX', 'MXN', 17.17000),
            ('DEU', 'EUR', 0.920000),
            ('FRA', 'EUR', 0.920000),
            ('NLD', 'EUR', 0.920000),
            ('CHN', 'CNY', 7.075000),
            ('JPN', 'JPY', 140.5100),
            ('KOR', 'KRW', 1305.410),
            ('IND', 'INR', 82.72000),
            ('SAU', 'SAR', 3.750000),
            ('AE', 'AED', 3.672500),
            ('BRA', 'BRL', 4.992000),
            ('ZAF', 'ZAR', 18.45000),
            ('NGA', 'NGN', 460.7000),
            ('RUS', 'RUB', 85.15000),
            ('AU', 'AUD', 1.501000),
            ('GB', 'GBP', 0.801000)
    ) AS v(iso2, cc, rate)
    JOIN countries c ON c.iso_alpha2 = iso2;
-- ─────────────────────────────────────────────
-- SANCTIONS  (current/recent, public record)
-- ─────────────────────────────────────────────
INSERT INTO sanctions (
        imposing_country,
        target_country,
        product_id,
        start_date,
        end_date,
        sanction_type,
        legal_basis
    )
SELECT imp.country_id,
    tgt.country_id,
    pr.product_id,
    sd,
    ed,
    stype,
    basis
FROM (
        VALUES -- US sanctions on Russia (crude oil)
            (
                'USA',
                'RUS',
                '270900',
                '2022-03-08',
                NULL,
                'import ban',
                'Executive Order 14066'
            ),
            -- EU sanctions on Russia (crude oil, effective Dec 2022)
            (
                'DEU',
                'RUS',
                '270900',
                '2022-12-05',
                NULL,
                'import ban',
                'EU Council Regulation 2022/1904'
            ),
            -- US section 301 tariffs on China semiconductors (modelled as sanction-style restriction)
            (
                'USA',
                'CHN',
                '854231',
                '2018-07-06',
                NULL,
                'elevated tariff',
                'USTR Section 301 Investigation'
            ),
            -- China ban on Australian barley (lifted 2023)
            (
                'CHN',
                'AUS',
                '100199',
                '2020-05-12',
                '2023-05-22',
                'import ban',
                'MOFCOM Anti-dumping Order 2020/4'
            )
    ) AS v(imp_iso3, tgt_iso3, hs, sd, ed, stype, basis)
    JOIN countries imp ON imp.iso_alpha3 = imp_iso3
    JOIN countries tgt ON tgt.iso_alpha3 = tgt_iso3
    LEFT JOIN products pr ON pr.hs_code = hs;