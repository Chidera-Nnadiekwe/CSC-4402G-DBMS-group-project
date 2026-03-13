-- ============================================================
--  INTERNATIONAL TRADE RELATIONS DATABASE (ITRD) — SCHEMA DEFINITION
-- ============================================================
-- ─────────────────────────────────────────────
-- 1. REGIONS  (continent / trading bloc grouping)
-- ─────────────────────────────────────────────
CREATE TABLE regions (
    region_id SERIAL PRIMARY KEY,
    region_name VARCHAR(100) NOT NULL UNIQUE, -- e.g. 'East Asia', 'Sub-Saharan Africa'
    region_code CHAR(4) NOT NULL UNIQUE -- e.g. 'EAAS', 'SSAF'
);

-- ─────────────────────────────────────────────
-- 2. COUNTRIES
-- ─────────────────────────────────────────────
CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    iso_alpha2 CHAR(2) NOT NULL UNIQUE, -- ISO 3166-1 alpha-2  e.g. 'US'
    iso_alpha3 CHAR(3) NOT NULL UNIQUE, -- ISO 3166-1 alpha-3  e.g. 'USA'
    country_name VARCHAR(100) NOT NULL UNIQUE,
    region_id INT REFERENCES regions(region_id),
    gdp_usd NUMERIC(20, 2), -- latest annual GDP in USD
    population BIGINT,
    wto_member BOOLEAN DEFAULT TRUE,
    joined_wto DATE
);
-- Comment: iso_alpha2 = 2-letter country code (e.g., 'US', 'CA', 'MX'), iso_alpha3 = 3-letter country code (e.g., 'USA', 'CAN', 'MEX').

-- ─────────────────────────────────────────────
-- 3. PRODUCT CATEGORIES  (HS Section level)
-- ─────────────────────────────────────────────
CREATE TABLE product_categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(150) NOT NULL UNIQUE,    -- e.g. 'Machinery & Electronics'
    hs_section SMALLINT NOT NULL UNIQUE -- HS Section number 1-21
);
-- Comment: The Harmonized System (HS) is an internationally standardized system of names and numbers for classifying traded products. It is organized into 21 sections, which are further divided into 99 chapters (2-digit), headings (4-digit), and subheadings (6-digit). The 'hs_section' field in the 'product_categories' table corresponds to the top-level section of the HS classification, allowing us to group products into broad categories based on their HS section. For example, Section 1 includes 'Live animals; animal products', while Section 16 includes 'Machinery and mechanical appliances; electrical equipment'. 

-- ─────────────────────────────────────────────
-- 4. PRODUCTS  (HS 6-digit heading)
-- ───────────────────────────────────────────── 
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    hs_code CHAR(6) NOT NULL UNIQUE, -- Harmonized System 6-digit code
    product_name VARCHAR(200) NOT NULL,
    category_id INT NOT NULL REFERENCES product_categories(category_id),
    unit_of_measure VARCHAR(30) DEFAULT 'kg' -- kg, units, barrels, etc.
);
-- Comment: The 'hs_code' field in the 'products' table corresponds to the 6-digit code from the Harmonized System (HS) classification. This code provides a detailed classification of traded products, allowing for precise identification and analysis of trade flows. For example, the HS code '010121' corresponds to 'Live horses, purebred breeding animals', while '847130' corresponds to 'Portable automatic data processing machines, weighing not more than 10 kg, consisting of at least a central processing unit and an input and output unit, whether or not containing in the same housing one or two of the following: storage units, recording or reproducing units, keyboards, or monitors'.

-- ─────────────────────────────────────────────
-- 5. TRADE AGREEMENTS
-- ─────────────────────────────────────────────
CREATE TABLE trade_agreements (
    agreement_id SERIAL PRIMARY KEY,
    agreement_name VARCHAR(200) NOT NULL UNIQUE, -- e.g. 'USMCA', 'EU Single Market'
    agreement_type VARCHAR(50) NOT NULL -- 'FTA','CU','EIA','PTA','WTO'
    CHECK (
        agreement_type IN ('FTA', 'CU', 'EIA', 'PTA', 'WTO', 'OTHER')
    ),
    signed_date DATE,
    effective_date DATE,
    expiry_date DATE,
    description TEXT
);
-- Comment: 'FTA' = Free Trade Agreement, 'CU' = Customs Union, 'EIA' = Economic Integration Agreement, 'PTA' = Preferential Trade Agreement, 'WTO' = World Trade Organization membership, 'OTHER' = any other type of trade agreement not covered by the previous categories.

-- ─────────────────────────────────────────────
-- 6. AGREEMENT MEMBERSHIP
-- ─────────────────────────────────────────────
CREATE TABLE agreement_members (
    agreement_id INT NOT NULL REFERENCES trade_agreements(agreement_id),
    country_id INT NOT NULL REFERENCES countries(country_id),
    joined_date DATE,
    status VARCHAR(20) DEFAULT 'active' -- active, suspended, withdrawn
    CHECK (
        status IN ('active', 'suspended', 'withdrawn', 'observer')
    ),
    PRIMARY KEY (agreement_id, country_id)
);

-- ─────────────────────────────────────────────
-- 7. TARIFFS
-- ─────────────────────────────────────────────
CREATE TABLE tariffs (
    tariff_id SERIAL PRIMARY KEY,
    importing_country INT NOT NULL REFERENCES countries(country_id),
    exporting_country INT NOT NULL REFERENCES countries(country_id),
    product_id INT NOT NULL REFERENCES products(product_id),
    year SMALLINT NOT NULL,
    mfn_rate NUMERIC(7, 4), -- Most-Favoured-Nation ad valorem rate (%)
    applied_rate NUMERIC(7, 4), -- Actual applied rate after agreements  (%)
    specific_duty NUMERIC(12, 4), -- Fixed duty per unit (USD)
    agreement_id INT REFERENCES trade_agreements(agreement_id), -- if preferential
    notes TEXT,
    UNIQUE (
        importing_country,
        exporting_country,
        product_id,
        year
    )
);

-- ─────────────────────────────────────────────
-- 8. TRADE FLOWS  (bilateral annual flows)
-- ─────────────────────────────────────────────
CREATE TABLE trade_flows (
    flow_id SERIAL PRIMARY KEY,
    exporter_id INT NOT NULL REFERENCES countries(country_id),
    importer_id INT NOT NULL REFERENCES countries(country_id),
    product_id INT NOT NULL REFERENCES products(product_id),
    year SMALLINT NOT NULL,
    trade_value_usd NUMERIC(20, 2) NOT NULL, -- FOB value in USD
    quantity NUMERIC(20, 4), -- in product's unit_of_measure
    data_source VARCHAR(100) DEFAULT 'UN Comtrade',
    CONSTRAINT no_self_trade CHECK (exporter_id <> importer_id),
    UNIQUE (exporter_id, importer_id, product_id, year)
);
-- Comment: FOB (Free On Board) value represents the value of goods at the point of export, excluding transportation and insurance costs. The 'quantity' field allows us to analyze trade volumes in addition to trade values, providing insights into the physical flow of goods between countries./

-- ─────────────────────────────────────────────
-- 9. EXCHANGE RATES  (optional relation)
-- ─────────────────────────────────────────────
CREATE TABLE exchange_rates (
    rate_id SERIAL PRIMARY KEY,
    country_id INT NOT NULL REFERENCES countries(country_id),
    year SMALLINT NOT NULL,
    currency_code CHAR(3) NOT NULL, -- ISO 4217
    usd_rate NUMERIC(18, 6) NOT NULL, -- units of local currency per 1 USD
    UNIQUE (country_id, year)
);
-- Comment: ISO 4217 is the international standard for currency codes, where each currency is represented by a three-letter code (e.g., 'USD' for US Dollar, 'EUR' for Euro, 'JPY' for Japanese Yen). The 'usd_rate' field indicates how many units of the local currency are equivalent to one US Dollar, allowing for currency conversion and analysis of trade values in a common currency.

-- ─────────────────────────────────────────────
-- 10. SANCTIONS  (optional relation)
-- ─────────────────────────────────────────────
CREATE TABLE sanctions (
    sanction_id SERIAL PRIMARY KEY,
    imposing_country INT NOT NULL REFERENCES countries(country_id),
    target_country INT NOT NULL REFERENCES countries(country_id),
    product_id INT REFERENCES products(product_id), -- NULL = all goods
    start_date DATE NOT NULL,
    end_date DATE,
    sanction_type VARCHAR(80), -- 'export ban','import ban','asset freeze', etc.
    legal_basis TEXT,
    CONSTRAINT no_self_sanction CHECK (imposing_country <> target_country)
);

-- ─────────────────────────────────────────────
-- INDEXES for common query patterns
-- ─────────────────────────────────────────────
CREATE INDEX idx_trade_flows_exporter ON trade_flows(exporter_id, year);
CREATE INDEX idx_trade_flows_importer ON trade_flows(importer_id, year);
CREATE INDEX idx_trade_flows_product ON trade_flows(product_id, year);
CREATE INDEX idx_tariffs_pair_product ON tariffs(importing_country, exporting_country, product_id);
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_countries_region ON countries(region_id);
