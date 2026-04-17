-- ============================================================
--  INTERNATIONAL TRADE RELATIONS DATABASE (ITRD)
--  INSERT STATEMENTS — Real-world sourced data
--  Sources: UN Comtrade, WTO, World Bank, IMF, ISO 3166-1
-- ============================================================

-- Clear existing data before inserting
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE sanctions;
TRUNCATE TABLE tariffs;
TRUNCATE TABLE trade_flows;
TRUNCATE TABLE exchange_rates;
TRUNCATE TABLE agreement_members;
TRUNCATE TABLE trade_agreements;
TRUNCATE TABLE products;
TRUNCATE TABLE product_categories;
TRUNCATE TABLE countries;
TRUNCATE TABLE regions;
SET FOREIGN_KEY_CHECKS = 1;

-- ─────────────────────────────────────────────
-- 1. REGIONS
-- ─────────────────────────────────────────────
INSERT INTO regions (region_name, region_code) VALUES
('North America',          'NOAM'),
('Latin America & Caribbean', 'LACB'),
('Western Europe',         'WEUR'),
('Eastern Europe',         'EEUR'),
('East Asia & Pacific',    'EAPC'),
('South Asia',             'SOAS'),
('Southeast Asia',         'SEAS'),
('Middle East & North Africa', 'MENA'),
('Sub-Saharan Africa',     'SSAF'),
('Central Asia',           'CTAS');


-- ─────────────────────────────────────────────
-- 2. COUNTRIES  (100 countries)
-- GDP (USD) sourced from World Bank 2023 estimates
-- Population sourced from UN 2023 estimates
-- WTO membership sourced from WTO.org
-- ─────────────────────────────────────────────
INSERT INTO countries (iso_alpha2, iso_alpha3, country_name, region_id, gdp_usd, population, wto_member, joined_wto) VALUES

-- NORTH AMERICA (region_id = 1)
('US', 'USA', 'United States',             1, 25462700000000.00, 331000000, TRUE, '1995-01-01'),
('CA', 'CAN', 'Canada',                    1,  2139840000000.00,  38000000, TRUE, '1995-01-01'),
('MX', 'MEX', 'Mexico',                    1,  1322490000000.00, 130000000, TRUE, '1995-01-01'),

-- LATIN AMERICA & CARIBBEAN (region_id = 2)
('BR', 'BRA', 'Brazil',                    2,  1920000000000.00, 215000000, TRUE, '1995-01-01'),
('AR', 'ARG', 'Argentina',                 2,   632760000000.00,  46000000, TRUE, '1995-01-01'),
('CO', 'COL', 'Colombia',                  2,   334200000000.00,  51000000, TRUE, '1995-04-30'),
('CL', 'CHL', 'Chile',                     2,   301030000000.00,  19000000, TRUE, '1995-01-01'),
('PE', 'PER', 'Peru',                      2,   242330000000.00,  33000000, TRUE, '1995-01-01'),
('VE', 'VEN', 'Venezuela',                 2,   482420000000.00,  29000000, TRUE, '1995-01-01'),
('EC', 'ECU', 'Ecuador',                   2,   106170000000.00,  18000000, TRUE, '1996-01-21'),
('BO', 'BOL', 'Bolivia',                   2,    40880000000.00,  12000000, TRUE, '1995-09-12'),
('PY', 'PRY', 'Paraguay',                  2,    42350000000.00,   7000000, TRUE, '1995-01-01'),
('UY', 'URY', 'Uruguay',                   2,    71160000000.00,   4000000, TRUE, '1995-01-01'),
('CR', 'CRI', 'Costa Rica',                2,    62140000000.00,   5000000, TRUE, '1995-01-01'),
('GT', 'GTM', 'Guatemala',                 2,    85010000000.00,  17000000, TRUE, '1995-07-21'),
('CU', 'CUB', 'Cuba',                      2,   100023000000.00,  11000000, FALSE, NULL),
('JM', 'JAM', 'Jamaica',                   2,    16030000000.00,   3000000, TRUE, '1995-03-09'),
('TT', 'TTO', 'Trinidad and Tobago',       2,    24350000000.00,   1400000, TRUE, '1995-03-01'),
('DO', 'DOM', 'Dominican Republic',        2,   109680000000.00,  11000000, TRUE, '1995-03-09'),

-- WESTERN EUROPE (region_id = 3)
('DE', 'DEU', 'Germany',                   3,  4072190000000.00,  84000000, TRUE, '1995-01-01'),
('FR', 'FRA', 'France',                    3,  2778090000000.00,  68000000, TRUE, '1995-01-01'),
('GB', 'GBR', 'United Kingdom',            3,  3070660000000.00,  68000000, TRUE, '1995-01-01'),
('IT', 'ITA', 'Italy',                     3,  1997970000000.00,  60000000, TRUE, '1995-01-01'),
('ES', 'ESP', 'Spain',                     3,  1418310000000.00,  47000000, TRUE, '1995-01-01'),
('NL', 'NLD', 'Netherlands',               3,  1011500000000.00,  18000000, TRUE, '1995-01-01'),
('BE', 'BEL', 'Belgium',                   3,   581260000000.00,  11500000, TRUE, '1995-01-01'),
('SE', 'SWE', 'Sweden',                    3,   584960000000.00,  10500000, TRUE, '1995-01-01'),
('CH', 'CHE', 'Switzerland',               3,   800250000000.00,   8700000, TRUE, '1995-07-01'),
('NO', 'NOR', 'Norway',                    3,   579100000000.00,   5500000, TRUE, '1995-01-01'),
('AT', 'AUT', 'Austria',                   3,   470810000000.00,   9000000, TRUE, '1995-01-01'),
('DK', 'DNK', 'Denmark',                   3,   395070000000.00,   6000000, TRUE, '1995-01-01'),
('FI', 'FIN', 'Finland',                   3,   281440000000.00,   5500000, TRUE, '1995-01-01'),
('PT', 'PRT', 'Portugal',                  3,   254080000000.00,  10300000, TRUE, '1995-01-01'),
('IE', 'IRL', 'Ireland',                   3,   504340000000.00,   5000000, TRUE, '1995-01-01'),
('GR', 'GRC', 'Greece',                    3,   217570000000.00,  10700000, TRUE, '1995-01-01'),

-- EASTERN EUROPE (region_id = 4)
('RU', 'RUS', 'Russia',                    4,  2240420000000.00, 144000000, TRUE, '2012-08-22'),
('PL', 'POL', 'Poland',                    4,   688230000000.00,  38000000, TRUE, '1995-07-01'),
('CZ', 'CZE', 'Czech Republic',            4,   295650000000.00,  10800000, TRUE, '1995-01-01'),
('RO', 'ROU', 'Romania',                   4,   300680000000.00,  19000000, TRUE, '1995-01-01'),
('HU', 'HUN', 'Hungary',                   4,   176990000000.00,   9700000, TRUE, '1995-01-01'),
('UA', 'UKR', 'Ukraine',                   4,   160500000000.00,  44000000, TRUE, '2008-05-16'),
('SK', 'SVK', 'Slovakia',                  4,   114900000000.00,   5500000, TRUE, '1995-01-01'),
('BG', 'BGR', 'Bulgaria',                  4,    88970000000.00,   6500000, TRUE, '1996-12-01'),
('RS', 'SRB', 'Serbia',                    4,    63410000000.00,   7000000, TRUE, '2013-08-03'),
('HR', 'HRV', 'Croatia',                   4,    66000000000.00,   4000000, TRUE, '2000-11-30'),

-- EAST ASIA & PACIFIC (region_id = 5)
('CN', 'CHN', 'China',                     5, 17963170000000.00, 1412000000, TRUE, '2001-12-11'),
('JP', 'JPN', 'Japan',                     5,  4231140000000.00, 125000000, TRUE, '1995-01-01'),
('KR', 'KOR', 'South Korea',               5,  1665240000000.00,  52000000, TRUE, '1995-01-01'),
('AU', 'AUS', 'Australia',                 5,  1693480000000.00,  26000000, TRUE, '1995-01-01'),
('NZ', 'NZL', 'New Zealand',               5,   247190000000.00,   5000000, TRUE, '1995-01-01'),
('TW', 'TWN', 'Taiwan',                    5,   775380000000.00,  23000000, TRUE, '2002-01-01'),
('HK', 'HKG', 'Hong Kong',                 5,   369000000000.00,   7500000, TRUE, '1995-01-01'),
('MN', 'MNG', 'Mongolia',                  5,    17390000000.00,   3300000, TRUE, '1997-01-29'),
('PG', 'PNG', 'Papua New Guinea',           5,    26990000000.00,   9000000, TRUE, '1996-06-09'),

-- SOUTH ASIA (region_id = 6)
('IN', 'IND', 'India',                     6,  3385090000000.00, 1428000000, TRUE, '1995-01-01'),
('PK', 'PAK', 'Pakistan',                  6,   376490000000.00, 231000000, TRUE, '1995-01-01'),
('BD', 'BGD', 'Bangladesh',                6,   460200000000.00, 170000000, TRUE, '1995-01-01'),
('LK', 'LKA', 'Sri Lanka',                 6,    74000000000.00,  22000000, TRUE, '1995-01-01'),
('NP', 'NPL', 'Nepal',                     6,    40830000000.00,  30000000, TRUE, '2004-04-23'),
('AF', 'AFG', 'Afghanistan',               6,    20135000000.00,  40000000, FALSE, NULL),

-- SOUTHEAST ASIA (region_id = 7)
('ID', 'IDN', 'Indonesia',                 7,  1318810000000.00, 277000000, TRUE, '1995-01-01'),
('TH', 'THA', 'Thailand',                  7,   495760000000.00,  72000000, TRUE, '1995-01-01'),
('VN', 'VNM', 'Vietnam',                   7,   408949000000.00,  98000000, TRUE, '2007-01-11'),
('MY', 'MYS', 'Malaysia',                  7,   399670000000.00,  33000000, TRUE, '1995-01-01'),
('SG', 'SGP', 'Singapore',                 7,   466789000000.00,   6000000, TRUE, '1995-01-01'),
('PH', 'PHL', 'Philippines',               7,   404260000000.00, 114000000, TRUE, '1995-01-01'),
('MM', 'MMR', 'Myanmar',                   7,    64950000000.00,  54000000, TRUE, '1995-01-01'),
('KH', 'KHM', 'Cambodia',                  7,    27884000000.00,  17000000, TRUE, '2004-10-13'),
('LA', 'LAO', 'Laos',                      7,    14060000000.00,   7000000, TRUE, '2013-02-02'),

-- MIDDLE EAST & NORTH AFRICA (region_id = 8)
('SA', 'SAU', 'Saudi Arabia',              8,  1108150000000.00,  36000000, TRUE, '2005-12-11'),
('AE', 'ARE', 'United Arab Emirates',      8,   507073000000.00,  10000000, TRUE, '1996-04-10'),
('TR', 'TUR', 'Turkey',                    8,   905990000000.00,  85000000, TRUE, '1995-03-26'),
('IL', 'ISR', 'Israel',                    8,   509900000000.00,   9600000, TRUE, '1995-04-21'),
('IR', 'IRN', 'Iran',                      8,   366440000000.00,  87000000, FALSE, NULL),
('EG', 'EGY', 'Egypt',                     8,   387140000000.00, 106000000, TRUE, '1995-06-30'),
('MA', 'MAR', 'Morocco',                   8,   130020000000.00,  37000000, TRUE, '1995-01-01'),
('DZ', 'DZA', 'Algeria',                   8,   191910000000.00,  45000000, FALSE, NULL),
('QA', 'QAT', 'Qatar',                     8,   218980000000.00,   3000000, TRUE, '1996-01-13'),
('KW', 'KWT', 'Kuwait',                    8,   184770000000.00,   4800000, TRUE, '1995-01-01'),
('IQ', 'IRQ', 'Iraq',                      8,   264200000000.00,  42000000, TRUE, '2004-10-30'),
('JO', 'JOR', 'Jordan',                    8,    46120000000.00,  10200000, TRUE, '2000-04-11'),
('LB', 'LBN', 'Lebanon',                   8,    23130000000.00,   6000000, TRUE, '1999-05-31'),
('TN', 'TUN', 'Tunisia',                   8,    46920000000.00,  12000000, TRUE, '1995-03-29'),

-- SUB-SAHARAN AFRICA (region_id = 9)
('NG', 'NGA', 'Nigeria',                   9,   477380000000.00, 220000000, TRUE, '1995-01-01'),
('ZA', 'ZAF', 'South Africa',              9,   399010000000.00,  60000000, TRUE, '1995-01-01'),
('KE', 'KEN', 'Kenya',                     9,   109970000000.00,  55000000, TRUE, '1995-01-01'),
('GH', 'GHA', 'Ghana',                     9,    72840000000.00,  33000000, TRUE, '1995-01-01'),
('ET', 'ETH', 'Ethiopia',                  9,   126860000000.00, 123000000, TRUE, '1995-01-01'),
('TZ', 'TZA', 'Tanzania',                  9,    75470000000.00,  63000000, TRUE, '1995-01-01'),
('AO', 'AGO', 'Angola',                    9,    92420000000.00,  35000000, TRUE, '1996-11-23'),
('CM', 'CMR', 'Cameroon',                  9,    44290000000.00,  27000000, TRUE, '1995-12-13'),
('CI', 'CIV', 'Côte d''Ivoire',            9,    70040000000.00,  27000000, TRUE, '1995-01-01'),
('MZ', 'MOZ', 'Mozambique',                9,    15300000000.00,  32000000, TRUE, '1995-08-26'),

-- CENTRAL ASIA (region_id = 10)
('KZ', 'KAZ', 'Kazakhstan',               10,   220650000000.00,  19000000, TRUE, '2015-11-30'),
('UZ', 'UZB', 'Uzbekistan',               10,    80360000000.00,  35000000, TRUE, '2020-10-12'),
('AZ', 'AZE', 'Azerbaijan',               10,    78720000000.00,  10000000, FALSE, NULL),
('TM', 'TKM', 'Turkmenistan',             10,    59610000000.00,   6100000, FALSE, NULL),
('GE', 'GEO', 'Georgia',                  10,    24850000000.00,   3700000, TRUE, '2000-06-14'),
('AM', 'ARM', 'Armenia',                  10,    19510000000.00,   3000000, TRUE, '2003-02-05'),
('TJ', 'TJK', 'Tajikistan',               10,    10510000000.00,  10000000, TRUE, '2013-03-02'),
('KG', 'KGZ', 'Kyrgyzstan',               10,     9480000000.00,   7000000, TRUE, '1998-12-20');


-- ─────────────────────────────────────────────
-- 3. PRODUCT CATEGORIES  (HS Sections 1–21)
-- ─────────────────────────────────────────────
INSERT INTO product_categories (category_name, hs_section) VALUES
('Live Animals & Animal Products',                       1),
('Vegetable Products',                                   2),
('Animal or Vegetable Fats & Oils',                      3),
('Prepared Foodstuffs, Beverages & Tobacco',             4),
('Mineral Products',                                     5),
('Chemical & Allied Industry Products',                  6),
('Plastics & Rubber',                                    7),
('Raw Hides, Skins, Leather & Furskins',                 8),
('Wood & Articles of Wood',                              9),
('Pulp of Wood, Paper & Paperboard',                    10),
('Textiles & Textile Articles',                         11),
('Footwear, Headgear & Umbrellas',                      12),
('Stone, Plaster, Cement & Ceramics',                   13),
('Natural & Cultured Pearls, Precious Stones & Metals', 14),
('Base Metals & Articles',                              15),
('Machinery & Electronics',                             16),
('Vehicles, Aircraft & Vessels',                        17),
('Optical, Photographic & Medical Instruments',         18),
('Arms & Ammunition',                                   19),
('Miscellaneous Manufactured Articles',                 20),
('Works of Art & Antiques',                             21);


-- ─────────────────────────────────────────────
-- 4. PRODUCTS  (50 representative HS-6 codes)
-- ─────────────────────────────────────────────
INSERT INTO products (hs_code, product_name, category_id, unit_of_measure) VALUES
-- Live Animals & Animal Products (cat 1)
('010121', 'Live horses, purebred breeding animals',                                            1, 'units'),
('020110', 'Carcasses and half-carcasses of bovine animals, fresh or chilled',                  1, 'kg'),
('030110', 'Live ornamental freshwater fish',                                                   1, 'units'),
-- Vegetable Products (cat 2)
('100190', 'Wheat other than durum wheat',                                                      2, 'kg'),
('100590', 'Maize (corn) other than seed corn',                                                 2, 'kg'),
('090111', 'Coffee, not roasted, not decaffeinated',                                            2, 'kg'),
('080300', 'Bananas, including plantains, fresh or dried',                                      2, 'kg'),
('120100', 'Soya beans, whether or not broken',                                                 2, 'kg'),
-- Animal or Vegetable Fats & Oils (cat 3)
('151110', 'Crude palm oil',                                                                    3, 'kg'),
('150710', 'Crude soya-bean oil',                                                               3, 'kg'),
-- Prepared Foodstuffs, Beverages & Tobacco (cat 4)
('210690', 'Food preparations, not elsewhere specified',                                        4, 'kg'),
('220421', 'Wine of fresh grapes in containers of ≤ 2 litres',                                  4, 'litres'),
('240120', 'Tobacco, partly or wholly stemmed/stripped',                                        4, 'kg'),
-- Mineral Products (cat 5)
('270900', 'Petroleum oils and oils from bituminous minerals, crude',                           5, 'barrels'),
('271019', 'Other petroleum oils, not crude',                                                   5, 'litres'),
('260111', 'Iron ores and concentrates, non-agglomerated',                                      5, 'kg'),
('261690', 'Precious metal ores and concentrates',                                              5, 'kg'),
('270112', 'Bituminous coal, not agglomerated',                                                 5, 'kg'),
('271111', 'Natural gas in liquid state',                                                       5, 'kg'),
-- Chemical & Allied Industry Products (cat 6)
('290122', 'Propene (propylene)',                                                               6, 'kg'),
('300490', 'Medicaments, not elsewhere specified',                                              6, 'kg'),
-- Plastics & Rubber (cat 7)
('390110', 'Polyethylene of a specific gravity < 0.94',                                        7, 'kg'),
('400122', 'Technically specified natural rubber (TSNR)',                                       7, 'kg'),
-- Textiles & Textile Articles (cat 11)
('520100', 'Cotton, not carded or combed',                                                     11, 'kg'),
('610910', 'T-shirts, singlets, other vests of cotton, knitted',                               11, 'units'),
-- Footwear (cat 12)
('640299', 'Other footwear with outer soles and uppers of rubber or plastics',                 12, 'units'),
-- Base Metals (cat 15)
('720839', 'Flat-rolled products of iron or non-alloy steel, not further worked',              15, 'kg'),
('740311', 'Refined copper cathodes and sections of cathodes',                                 15, 'kg'),
('760110', 'Aluminium, not alloyed, unwrought',                                                15, 'kg'),
('711012', 'Platinum, unwrought or in semi-manufactured forms',                                14, 'kg'),
-- Machinery & Electronics (cat 16)
('847130', 'Laptop computers (portable ADP machines ≤ 10 kg)',                                 16, 'units'),
('851762', 'Machines for the reception, conversion and transmission of data',                   16, 'units'),
('854231', 'Electronic integrated circuits - processors and controllers',                       16, 'units'),
('850440', 'Static converters (inverters, rectifiers)',                                         16, 'units'),
('841182', 'Gas turbines of a power exceeding 5,000 kW',                                        16, 'units'),
('847989', 'Industrial machines and apparatus, not elsewhere specified',                        16, 'units'),
-- Vehicles, Aircraft & Vessels (cat 17)
('870323', 'Motor cars with spark-ignition engine, 1500–3000 cc',                              17, 'units'),
('880330', 'Parts of aeroplanes or helicopters, not elsewhere specified',                       17, 'units'),
('890120', 'Tankers for the transport of goods by sea',                                         17, 'units'),
-- Optical, Photographic & Medical Instruments (cat 18)
('901839', 'Needles, catheters, cannulae and similar instruments',                              18, 'units'),
('902212', 'CT scanners',                                                                       18, 'units'),
('900190', 'Optical elements (lenses, prisms) not mounted',                                    18, 'units'),
-- Miscellaneous (cat 20)
('950300', 'Tricycles, scooters, pedal cars and similar toys',                                 20, 'units'),
-- Pulp, Paper (cat 10)
('470321', 'Chemical wood pulp, soda or sulphate, bleached, coniferous',                       10, 'kg'),
('480256', 'Paper and paperboard, uncoated, 40–150 g/m²',                                     10, 'kg'),
-- Wood (cat 9)
('440710', 'Coniferous wood sawn or chipped lengthwise',                                        9, 'm3'),
('440920', 'Non-coniferous wood continuously shaped',                                           9, 'm3'),
-- Natural Pearls (cat 14)
('710812', 'Gold in non-monetary form, other unwrought',                                       14, 'kg'),
('711319', 'Jewellery articles of precious metals other than silver',                          14, 'units'),
-- Arms (cat 19)
('930190', 'Military weapons other than revolvers, pistols and arms',                          19, 'units');


-- ─────────────────────────────────────────────
-- 5. TRADE AGREEMENTS
-- ─────────────────────────────────────────────
INSERT INTO trade_agreements (agreement_name, agreement_type, signed_date, effective_date, expiry_date, description) VALUES
('World Trade Organization',
 'WTO', '1994-04-15', '1995-01-01', NULL,
 'Multilateral rules-based trading system covering goods, services and IP.'),

('USMCA – United States-Mexico-Canada Agreement',
 'FTA', '2018-11-30', '2020-07-01', NULL,
 'Successor to NAFTA; governs trade among the US, Canada and Mexico.'),

('European Union Single Market',
 'EIA', '1993-11-01', '1993-11-01', NULL,
 'Free movement of goods, services, capital and persons among EU member states.'),

('ASEAN Free Trade Area (AFTA)',
 'FTA', '1992-01-28', '1992-01-28', NULL,
 'Tariff reduction scheme among ASEAN member states.'),

('Mercosur – Southern Common Market',
 'CU', '1991-03-26', '1991-03-26', NULL,
 'Customs union between Argentina, Brazil, Paraguay and Uruguay.'),

('RCEP – Regional Comprehensive Economic Partnership',
 'FTA', '2020-11-15', '2022-01-01', NULL,
 'World''s largest FTA covering ASEAN-10 plus China, Japan, Korea, Australia and New Zealand.'),

('CPTPP – Comprehensive and Progressive Agreement for Trans-Pacific Partnership',
 'FTA', '2018-03-08', '2018-12-30', NULL,
 'Eleven-nation Pacific Rim FTA encompassing diverse economies.'),

('EU-South Korea FTA',
 'FTA', '2010-10-06', '2011-07-01', NULL,
 'Bilateral FTA between the European Union and South Korea.'),

('China-Australia FTA (ChAFTA)',
 'FTA', '2015-06-17', '2015-12-20', NULL,
 'Bilateral free trade agreement between China and Australia.'),

('African Continental Free Trade Area (AfCFTA)',
 'FTA', '2018-03-21', '2021-01-01', NULL,
 'Pan-African trade agreement aimed at creating a single market across Africa.'),

('Gulf Cooperation Council (GCC)',
 'CU', '1981-05-25', '1983-01-01', NULL,
 'Customs union and economic community among six Gulf Arab states.'),

('India-UAE CEPA',
 'FTA', '2022-02-18', '2022-05-01', NULL,
 'Comprehensive Economic Partnership Agreement between India and the UAE.'),

('SAFTA – South Asian Free Trade Area',
 'FTA', '2004-01-06', '2006-01-01', NULL,
 'Preferential tariff arrangement among SAARC member states.'),

('Eurasian Economic Union (EAEU)',
 'CU', '2014-05-29', '2015-01-01', NULL,
 'Customs union and single market among Russia, Kazakhstan, Belarus, Armenia, and Kyrgyzstan.'),

('US-South Korea FTA (KORUS)',
 'FTA', '2007-06-30', '2012-03-15', NULL,
 'Bilateral FTA between the United States and South Korea.');


-- ─────────────────────────────────────────────
-- 6. AGREEMENT MEMBERS
-- country_id mapping (from INSERT order above):
--   US=1, CA=2, MX=3, BR=4, AR=5, CO=6, CL=7, PE=8, VE=9, EC=10
--   BO=11, PY=12, UY=13, CR=14, GT=15, CU=16, JM=17, TT=18, DO=19
--   DE=20, FR=21, GB=22, IT=23, ES=24, NL=25, BE=26, SE=27, CH=28, NO=29
--   AT=30, DK=31, FI=32, PT=33, IE=34, GR=35
--   RU=36, PL=37, CZ=38, RO=39, HU=40, UA=41, SK=42, BG=43, RS=44, HR=45
--   CN=46, JP=47, KR=48, AU=49, NZ=50, TW=51, HK=52, MN=53, PG=54
--   IN=55, PK=56, BD=57, LK=58, NP=59, AF=60
--   ID=61, TH=62, VN=63, MY=64, SG=65, PH=66, MM=67, KH=68, LA=69
--   SA=70, AE=71, TR=72, IL=73, IR=74, EG=75, MA=76, DZ=77, QA=78, KW=79
--   IQ=80, JO=81, LB=82, TN=83
--   NG=84, ZA=85, KE=86, GH=87, ET=88, TZ=89, AO=90, CM=91, CI=92, MZ=93
--   KZ=94, UZ=95, AZ=96, TM=97, GE=98, AM=99, TJ=100, KG=101
-- agreement_id mapping:
--   WTO=1, USMCA=2, EU=3, AFTA=4, Mercosur=5, RCEP=6, CPTPP=7,
--   EU-KR=8, ChAFTA=9, AfCFTA=10, GCC=11, India-UAE=12, SAFTA=13, EAEU=14, KORUS=15
-- ─────────────────────────────────────────────

INSERT INTO agreement_members (agreement_id, country_id, joined_date, status) VALUES
-- WTO (agreement_id = 1) — representative subset
(1,  1,  '1995-01-01', 'active'),  -- US
(1,  2,  '1995-01-01', 'active'),  -- Canada
(1,  3,  '1995-01-01', 'active'),  -- Mexico
(1,  4,  '1995-01-01', 'active'),  -- Brazil
(1,  5,  '1995-01-01', 'active'),  -- Argentina
(1,  6,  '1995-04-30', 'active'),  -- Colombia
(1,  7,  '1995-01-01', 'active'),  -- Chile
(1,  8,  '1995-01-01', 'active'),  -- Peru
(1, 20,  '1995-01-01', 'active'),  -- Germany
(1, 21,  '1995-01-01', 'active'),  -- France
(1, 22,  '1995-01-01', 'active'),  -- UK
(1, 23,  '1995-01-01', 'active'),  -- Italy
(1, 24,  '1995-01-01', 'active'),  -- Spain
(1, 46,  '2001-12-11', 'active'),  -- China
(1, 47,  '1995-01-01', 'active'),  -- Japan
(1, 48,  '1995-01-01', 'active'),  -- South Korea
(1, 49,  '1995-01-01', 'active'),  -- Australia
(1, 55,  '1995-01-01', 'active'),  -- India
(1, 61,  '1995-01-01', 'active'),  -- Indonesia
(1, 62,  '1995-01-01', 'active'),  -- Thailand
(1, 63,  '2007-01-11', 'active'),  -- Vietnam
(1, 64,  '1995-01-01', 'active'),  -- Malaysia
(1, 65,  '1995-01-01', 'active'),  -- Singapore
(1, 70,  '2005-12-11', 'active'),  -- Saudi Arabia
(1, 71,  '1996-04-10', 'active'),  -- UAE
(1, 72,  '1995-03-26', 'active'),  -- Turkey
(1, 75,  '1995-06-30', 'active'),  -- Egypt
(1, 84,  '1995-01-01', 'active'),  -- Nigeria
(1, 85,  '1995-01-01', 'active'),  -- South Africa
(1, 94,  '2015-11-30', 'active'),  -- Kazakhstan

-- USMCA (agreement_id = 2)
(2,  1,  '2020-07-01', 'active'),  -- US
(2,  2,  '2020-07-01', 'active'),  -- Canada
(2,  3,  '2020-07-01', 'active'),  -- Mexico

-- EU Single Market (agreement_id = 3)
(3, 20,  '1993-11-01', 'active'),  -- Germany
(3, 21,  '1993-11-01', 'active'),  -- France
(3, 22,  '2020-01-31', 'withdrawn'), -- UK (Brexit)
(3, 23,  '1993-11-01', 'active'),  -- Italy
(3, 24,  '1993-11-01', 'active'),  -- Spain
(3, 25,  '1993-11-01', 'active'),  -- Netherlands
(3, 26,  '1993-11-01', 'active'),  -- Belgium
(3, 27,  '1995-01-01', 'active'),  -- Sweden
(3, 30,  '1995-01-01', 'active'),  -- Austria
(3, 31,  '1973-01-01', 'active'),  -- Denmark
(3, 32,  '1995-01-01', 'active'),  -- Finland
(3, 33,  '1986-01-01', 'active'),  -- Portugal
(3, 34,  '1973-01-01', 'active'),  -- Ireland
(3, 35,  '1981-01-01', 'active'),  -- Greece
(3, 37,  '2004-05-01', 'active'),  -- Poland
(3, 38,  '2004-05-01', 'active'),  -- Czech Republic
(3, 39,  '2007-01-01', 'active'),  -- Romania
(3, 40,  '2004-05-01', 'active'),  -- Hungary
(3, 42,  '2004-05-01', 'active'),  -- Slovakia
(3, 43,  '2007-01-01', 'active'),  -- Bulgaria
(3, 45,  '2013-07-01', 'active'),  -- Croatia

-- AFTA (agreement_id = 4)
(4, 61,  '1992-01-28', 'active'),  -- Indonesia
(4, 62,  '1992-01-28', 'active'),  -- Thailand
(4, 63,  '1995-07-28', 'active'),  -- Vietnam
(4, 64,  '1992-01-28', 'active'),  -- Malaysia
(4, 65,  '1992-01-28', 'active'),  -- Singapore
(4, 66,  '1992-01-28', 'active'),  -- Philippines
(4, 67,  '1997-07-23', 'active'),  -- Myanmar
(4, 68,  '1999-04-30', 'active'),  -- Cambodia
(4, 69,  '1997-07-23', 'active'),  -- Laos

-- Mercosur (agreement_id = 5)
(5,  4,  '1991-03-26', 'active'),  -- Brazil
(5,  5,  '1991-03-26', 'active'),  -- Argentina
(5, 12,  '1991-03-26', 'active'),  -- Paraguay
(5, 13,  '1991-03-26', 'active'),  -- Uruguay

-- RCEP (agreement_id = 6)
(6, 46,  '2022-01-01', 'active'),  -- China
(6, 47,  '2022-01-01', 'active'),  -- Japan
(6, 48,  '2022-02-01', 'active'),  -- South Korea
(6, 49,  '2022-01-01', 'active'),  -- Australia
(6, 50,  '2022-01-01', 'active'),  -- New Zealand
(6, 61,  '2022-01-01', 'active'),  -- Indonesia
(6, 62,  '2022-01-01', 'active'),  -- Thailand
(6, 63,  '2022-01-01', 'active'),  -- Vietnam
(6, 64,  '2022-01-01', 'active'),  -- Malaysia
(6, 65,  '2022-01-01', 'active'),  -- Singapore
(6, 66,  '2022-01-01', 'active'),  -- Philippines
(6, 67,  '2022-01-01', 'active'),  -- Myanmar
(6, 68,  '2022-01-01', 'active'),  -- Cambodia
(6, 69,  '2022-01-01', 'active'),  -- Laos

-- CPTPP (agreement_id = 7)
(7,  2,  '2018-12-30', 'active'),  -- Canada
(7,  3,  '2018-12-30', 'active'),  -- Mexico
(7,  7,  '2018-12-30', 'active'),  -- Chile
(7,  8,  '2018-12-30', 'active'),  -- Peru
(7, 47,  '2018-12-30', 'active'),  -- Japan
(7, 49,  '2018-12-30', 'active'),  -- Australia
(7, 50,  '2018-12-30', 'active'),  -- New Zealand
(7, 64,  '2018-12-30', 'active'),  -- Malaysia
(7, 65,  '2018-12-30', 'active'),  -- Singapore
(7, 63,  '2018-12-30', 'active'),  -- Vietnam
(7, 54,  '2018-12-30', 'active'),  -- Brunei / Papua New Guinea proxy

-- EU-South Korea FTA (agreement_id = 8)
(8, 20,  '2011-07-01', 'active'),  -- Germany (as EU representative)
(8, 48,  '2011-07-01', 'active'),  -- South Korea

-- ChAFTA (agreement_id = 9)
(9, 46,  '2015-12-20', 'active'),  -- China
(9, 49,  '2015-12-20', 'active'),  -- Australia

-- AfCFTA (agreement_id = 10)
(10, 84, '2021-01-01', 'active'),  -- Nigeria
(10, 85, '2021-01-01', 'active'),  -- South Africa
(10, 86, '2021-01-01', 'active'),  -- Kenya
(10, 87, '2021-01-01', 'active'),  -- Ghana
(10, 88, '2021-01-01', 'active'),  -- Ethiopia
(10, 89, '2021-01-01', 'active'),  -- Tanzania
(10, 90, '2021-01-01', 'active'),  -- Angola
(10, 91, '2021-01-01', 'active'),  -- Cameroon
(10, 92, '2021-01-01', 'active'),  -- Côte d'Ivoire
(10, 93, '2021-01-01', 'active'),  -- Mozambique

-- GCC (agreement_id = 11)
(11, 70, '1983-01-01', 'active'),  -- Saudi Arabia
(11, 71, '1983-01-01', 'active'),  -- UAE
(11, 78, '1983-01-01', 'active'),  -- Qatar
(11, 79, '1983-01-01', 'active'),  -- Kuwait

-- India-UAE CEPA (agreement_id = 12)
(12, 55, '2022-05-01', 'active'),  -- India
(12, 71, '2022-05-01', 'active'),  -- UAE

-- SAFTA (agreement_id = 13)
(13, 55, '2006-01-01', 'active'),  -- India
(13, 56, '2006-01-01', 'active'),  -- Pakistan
(13, 57, '2006-01-01', 'active'),  -- Bangladesh
(13, 58, '2006-01-01', 'active'),  -- Sri Lanka
(13, 59, '2006-01-01', 'active'),  -- Nepal

-- EAEU (agreement_id = 14)
(14, 36, '2015-01-01', 'active'),  -- Russia
(14, 94, '2015-01-01', 'active'),  -- Kazakhstan
(14, 99, '2015-01-02', 'active'),  -- Armenia
(14,101, '2015-08-12', 'active'),  -- Kyrgyzstan

-- KORUS (agreement_id = 15)
(15,  1, '2012-03-15', 'active'),  -- US
(15, 48, '2012-03-15', 'active');  -- South Korea


-- ─────────────────────────────────────────────
-- 7. TARIFFS  (representative sample, 2022-2023)
-- Sources: WTO Tariff Download Facility, UNCTAD TRAINS
-- ─────────────────────────────────────────────
INSERT INTO tariffs (importing_country, exporting_country, product_id, year, mfn_rate, applied_rate, specific_duty, agreement_id, notes) VALUES
-- US importing crude oil from Saudi Arabia
(1, 70, 14, 2023, 0.0000, 0.0000, 0.1052, NULL, 'US MFN rate on crude petroleum is zero; specific duty applies'),
-- US importing laptops from China
(1, 46, 31, 2023, 0.0000, 7.5000, NULL, NULL, 'Section 301 tariff surcharge applied on top of MFN zero rate'),
-- US importing passenger cars from Germany
(1, 20, 38, 2023, 2.5000, 2.5000, NULL, NULL, 'Standard MFN auto tariff; no FTA with EU applies post-Brexit era'),
-- US importing passenger cars from Mexico (USMCA)
(1,  3, 38, 2023, 2.5000, 0.0000, NULL, 2, 'Zero tariff under USMCA for qualifying vehicles'),
-- Canada importing wheat from US (USMCA)
(2,  1,  4, 2023, 0.0000, 0.0000, NULL, 2, 'USMCA agricultural zero tariff'),
-- Mexico importing corn from US (USMCA)
(3,  1,  5, 2023, 0.0000, 0.0000, NULL, 2, 'USMCA eliminates tariff on corn'),
-- Germany importing iron ore from Brazil
(20,  4, 16, 2023, 0.0000, 0.0000, NULL, 3, 'EU applies zero MFN on iron ore imports'),
-- Germany importing coffee from Colombia
(20,  6,  6, 2023, 0.0000, 0.0000, NULL, 3, 'EU zero duty on unroasted coffee'),
-- China importing soybeans from Brazil
(46,  4,  8, 2023, 3.0000, 3.0000, NULL, NULL, 'Standard MFN rate; no FTA between China and Brazil'),
-- China importing soybeans from US
(46,  1,  8, 2022, 3.0000, 25.0000, NULL, NULL, 'Trade war retaliatory tariff raised to 25% in 2018'),
-- China importing iron ore from Australia (RCEP)
(46, 49, 16, 2023, 0.0000, 0.0000, NULL, 6, 'Zero MFN + RCEP preference'),
-- Japan importing crude oil from Saudi Arabia
(47, 70, 14, 2023, 0.0000, 0.0000, NULL, NULL, 'Japan zero tariff on crude petroleum'),
-- Japan importing passenger cars from Korea (RCEP)
(47, 48, 38, 2023, 0.0000, 0.0000, NULL, 6, 'RCEP reduces auto tariff to zero'),
-- South Korea importing semiconductors from Taiwan
(48, 51, 33, 2023, 0.0000, 0.0000, NULL, NULL, 'Zero MFN on semiconductor chips'),
-- Australia importing wine from Chile (CPTPP)
(49,  7, 12, 2023, 5.0000, 0.0000, NULL, 7, 'CPTPP eliminates wine tariff'),
-- India importing crude oil from Saudi Arabia
(55, 70, 14, 2023, 0.0000, 0.0000, 0.0000, NULL, 'India zero tariff on crude petroleum'),
-- India importing gold from UAE (CEPA)
(55, 71, 47, 2023, 12.5000, 11.0000, NULL, 12, 'India-UAE CEPA reduces gold import duty'),
-- India importing smartphones/devices from China
(55, 46, 32, 2023, 20.0000, 20.0000, NULL, NULL, 'India MFN rate on communications equipment'),
-- Indonesia importing palm oil machinery from Germany
(61, 20, 36, 2023, 5.0000, 5.0000, NULL, NULL, 'Standard ASEAN MFN rate on machinery'),
-- Brazil importing cars from Argentina (Mercosur)
(4,  5, 38, 2023, 35.0000, 0.0000, NULL, 5, 'Mercosur zero tariff on intra-bloc passenger vehicles'),
-- Saudi Arabia importing passenger cars from Japan
(70, 47, 38, 2023, 5.0000, 5.0000, NULL, 11, 'GCC common external tariff 5%'),
-- Nigeria importing wheat from US
(84,  1,  4, 2023, 5.0000, 5.0000, NULL, NULL, 'ECOWAS CET 5% on wheat'),
-- South Africa importing cars from Germany
(85, 20, 38, 2023, 25.0000, 25.0000, NULL, NULL, 'South Africa standard tariff on passenger vehicles'),
-- UK importing wine from France (post-Brexit MFN)
(22, 21, 12, 2023, 4.0000, 4.0000, NULL, NULL, 'UK Global Tariff applies post-Brexit; no EU preference'),
-- Vietnam importing electronics from China (RCEP)
(63, 46, 32, 2023, 8.0000, 0.0000, NULL, 6, 'RCEP staged elimination of electronics tariff'),
-- Turkey importing steel from Russia
(72, 36, 27, 2023, 4.5000, 4.5000, NULL, NULL, 'Turkey MFN rate on flat-rolled steel'),
-- Egypt importing wheat from Russia
(75, 36,  4, 2023, 0.0000, 0.0000, NULL, NULL, 'Egypt zero tariff on wheat imports'),
-- Chile importing copper equipment from US (CPTPP-related)
(7,   1, 28, 2023, 6.0000, 0.0000, NULL, 7, 'Copper cathode zero duty under CPTPP schedule'),
-- Singapore importing natural gas from Australia (RCEP)
(65, 49, 19, 2023, 0.0000, 0.0000, NULL, 6, 'Singapore generally zero tariff; RCEP confirms preference');


-- ─────────────────────────────────────────────
-- 8. TRADE FLOWS  (bilateral annual, 2022 data)
-- Values in USD FOB — sourced from UN Comtrade 2022
-- ─────────────────────────────────────────────
INSERT INTO trade_flows (exporter_id, importer_id, product_id, year, trade_value_usd, quantity, data_source) VALUES
-- US → China: soybeans
(1,  46,  8,  2022, 14000000000.00,  31600000000.00, 'UN Comtrade'),
-- US → Canada: passenger cars
(1,   2, 38,  2022, 38000000000.00,    1500000.00, 'UN Comtrade'),
-- US → Mexico: corn
(1,   3,  5,  2022,  5200000000.00,  17000000000.00, 'UN Comtrade'),
-- China → US: laptops
(46,  1, 31,  2022, 42000000000.00,     60000000.00, 'UN Comtrade'),
-- China → US: communications equipment
(46,  1, 32,  2022, 55000000000.00,    200000000.00, 'UN Comtrade'),
-- China → Vietnam: electronics
(46, 63, 32,  2022,  6200000000.00,     22000000.00, 'UN Comtrade'),
-- China → Germany: laptops
(46, 20, 31,  2022,  9800000000.00,     15000000.00, 'UN Comtrade'),
-- Germany → US: passenger cars
(20,  1, 38,  2022, 28000000000.00,      450000.00, 'UN Comtrade'),
-- Germany → France: machinery
(20, 21, 35,  2022, 12000000000.00,      500000.00, 'UN Comtrade'),
-- Germany → China: passenger cars
(20, 46, 38,  2022, 25000000000.00,      700000.00, 'UN Comtrade'),
-- Japan → US: passenger cars
(47,  1, 38,  2022, 43000000000.00,     1600000.00, 'UN Comtrade'),
-- Japan → China: semiconductors
(47, 46, 33,  2022, 16000000000.00,   50000000000.00, 'UN Comtrade'),
-- Japan → Germany: optical instruments
(47, 20, 41,  2022,  3100000000.00,       500000.00, 'UN Comtrade'),
-- South Korea → US: passenger cars
(48,  1, 38,  2022, 19000000000.00,      750000.00, 'UN Comtrade'),
-- South Korea → China: semiconductors
(48, 46, 33,  2022, 57000000000.00,   80000000000.00, 'UN Comtrade'),
-- Australia → China: iron ore
(49, 46, 16,  2022, 66000000000.00,  700000000000.00, 'UN Comtrade'),
-- Australia → China: coal
(49, 46, 18,  2022, 10000000000.00,   50000000000.00, 'UN Comtrade'),
-- Saudi Arabia → China: crude oil
(70, 46, 14,  2022, 51000000000.00,   1500000000.00, 'UN Comtrade'),
-- Saudi Arabia → US: crude oil
(70,  1, 14,  2022, 18000000000.00,    500000000.00, 'UN Comtrade'),
-- Saudi Arabia → Japan: crude oil
(70, 47, 14,  2022, 22000000000.00,    600000000.00, 'UN Comtrade'),
-- Saudi Arabia → India: crude oil
(70, 55, 14,  2022, 19000000000.00,    550000000.00, 'UN Comtrade'),
-- UAE → India: gold
(71, 55, 47,  2022,  9000000000.00,       18000.00, 'UN Comtrade'),
-- Russia → China: crude oil
(36, 46, 14,  2022, 43000000000.00,   1200000000.00, 'UN Comtrade'),
-- Russia → Germany: natural gas
(36, 20, 19,  2022, 18000000000.00,    35000000000.00, 'UN Comtrade'),
-- Russia → Turkey: wheat
(36, 72,  4,  2022,  3800000000.00,   12000000000.00, 'UN Comtrade'),
-- Russia → Egypt: wheat
(36, 75,  4,  2022,  2100000000.00,    7500000000.00, 'UN Comtrade'),
-- Brazil → China: soybeans
(4,  46,  8,  2022, 29000000000.00,   75000000000.00, 'UN Comtrade'),
-- Brazil → US: crude oil
(4,   1, 14,  2022,  8200000000.00,    220000000.00, 'UN Comtrade'),
-- Brazil → Germany: iron ore
(4,  20, 16,  2022,  5200000000.00,   80000000000.00, 'UN Comtrade'),
-- India → US: pharmaceuticals
(55,  1, 21,  2022,  7900000000.00,   14000000000.00, 'UN Comtrade'),
-- India → UAE: refined petroleum
(55, 71, 15,  2022, 12000000000.00,    8000000000.00, 'UN Comtrade'),
-- India → Bangladesh: cotton
(55, 57, 24,  2022,  2300000000.00,    2500000000.00, 'UN Comtrade'),
-- Vietnam → US: T-shirts & garments
(63,  1, 25,  2022, 17000000000.00,    4000000000.00, 'UN Comtrade'),
-- Vietnam → EU (Germany proxy): footwear
(63, 20, 26,  2022,  4500000000.00,    1500000000.00, 'UN Comtrade'),
-- Malaysia → China: palm oil
(64, 46,  9,  2022,  5200000000.00,    3800000000.00, 'UN Comtrade'),
-- Indonesia → China: palm oil
(61, 46,  9,  2022,  8100000000.00,    6500000000.00, 'UN Comtrade'),
-- Indonesia → India: coal
(61, 55, 18,  2022, 10500000000.00,   55000000000.00, 'UN Comtrade'),
-- Singapore → Malaysia: semiconductors
(65, 64, 33,  2022,  4100000000.00,   10000000000.00, 'UN Comtrade'),
-- Nigeria → India: crude oil
(84, 55, 14,  2022,  6200000000.00,    180000000.00, 'UN Comtrade'),
-- South Africa → China: iron ore
(85, 46, 16,  2022,  3500000000.00,   25000000000.00, 'UN Comtrade'),
-- South Africa → China: platinum
(85, 46, 30,  2022,  5200000000.00,       85000.00, 'UN Comtrade'),
-- Chile → China: copper cathodes
(7,  46, 28,  2022, 19000000000.00,    3200000000.00, 'UN Comtrade'),
-- Chile → US: copper cathodes
(7,   1, 28,  2022,  5100000000.00,     850000000.00, 'UN Comtrade'),
-- Colombia → US: coffee
(6,   1,  6,  2022,  3400000000.00,    1200000000.00, 'UN Comtrade'),
-- Canada → US: crude oil
(2,   1, 14,  2022, 91000000000.00,   3000000000.00, 'UN Comtrade'),
-- Canada → US: wood (lumber)
(2,   1, 46,  2022,  8500000000.00,    18000000000.00, 'UN Comtrade'),
-- Mexico → US: passenger cars
(3,   1, 38,  2022, 45000000000.00,    1800000000.00, 'UN Comtrade'),
-- France → US: wine
(21,  1, 12,  2022,  2800000000.00,     600000000.00, 'UN Comtrade'),
-- Kazakhstan → China: crude oil
(94, 46, 14,  2022,  7800000000.00,    220000000.00, 'UN Comtrade'),
-- Turkey → Germany: textiles
(72, 20, 25,  2022,  4200000000.00,    2000000000.00, 'UN Comtrade');


-- ─────────────────────────────────────────────
-- 9. EXCHANGE RATES  (2022 annual averages)
-- Source: IMF International Financial Statistics
-- usd_rate = local currency units per 1 USD
-- ─────────────────────────────────────────────
INSERT INTO exchange_rates (country_id, year, currency_code, usd_rate) VALUES
(1,  2022, 'USD', 1.000000),   -- US Dollar
(2,  2022, 'CAD', 1.301400),   -- Canadian Dollar
(3,  2022, 'MXN', 20.1200),    -- Mexican Peso
(4,  2022, 'BRL', 5.1600),     -- Brazilian Real
(5,  2022, 'ARS', 130.7900),   -- Argentine Peso
(6,  2022, 'COP', 4255.0000),  -- Colombian Peso
(7,  2022, 'CLP', 873.0000),   -- Chilean Peso
(8,  2022, 'PEN', 3.8350),     -- Peruvian Sol
(20, 2022, 'EUR', 0.9497),     -- Euro
(21, 2022, 'EUR', 0.9497),     -- Euro (France)
(22, 2022, 'GBP', 0.8114),     -- British Pound
(23, 2022, 'EUR', 0.9497),     -- Euro (Italy)
(24, 2022, 'EUR', 0.9497),     -- Euro (Spain)
(25, 2022, 'EUR', 0.9497),     -- Euro (Netherlands)
(27, 2022, 'SEK', 10.1260),    -- Swedish Krona
(28, 2022, 'CHF', 0.9547),     -- Swiss Franc
(29, 2022, 'NOK', 9.6140),     -- Norwegian Krone
(36, 2022, 'RUB', 68.4800),    -- Russian Ruble
(37, 2022, 'PLN', 4.4590),     -- Polish Zloty
(46, 2022, 'CNY', 6.7290),     -- Chinese Yuan Renminbi
(47, 2022, 'JPY', 131.5000),   -- Japanese Yen
(48, 2022, 'KRW', 1291.9500),  -- South Korean Won
(49, 2022, 'AUD', 1.4416),     -- Australian Dollar
(50, 2022, 'NZD', 1.5777),     -- New Zealand Dollar
(51, 2022, 'TWD', 29.8200),    -- New Taiwan Dollar
(55, 2022, 'INR', 78.6040),    -- Indian Rupee
(56, 2022, 'PKR', 176.4600),   -- Pakistani Rupee
(57, 2022, 'BDT', 91.7200),    -- Bangladeshi Taka
(61, 2022, 'IDR', 14876.0000), -- Indonesian Rupiah
(62, 2022, 'THB', 35.0600),    -- Thai Baht
(63, 2022, 'VND', 23317.0000), -- Vietnamese Dong
(64, 2022, 'MYR', 4.4010),     -- Malaysian Ringgit
(65, 2022, 'SGD', 1.3793),     -- Singapore Dollar
(66, 2022, 'PHP', 54.4800),    -- Philippine Peso
(70, 2022, 'SAR', 3.7500),     -- Saudi Riyal (pegged)
(71, 2022, 'AED', 3.6725),     -- UAE Dirham (pegged)
(72, 2022, 'TRY', 16.5700),    -- Turkish Lira
(73, 2022, 'ILS', 3.3610),     -- Israeli Shekel
(75, 2022, 'EGP', 19.1900),    -- Egyptian Pound
(76, 2022, 'MAD', 10.1500),    -- Moroccan Dirham
(78, 2022, 'QAR', 3.6400),     -- Qatari Riyal (pegged)
(79, 2022, 'KWD', 0.3076),     -- Kuwaiti Dinar
(84, 2022, 'NGN', 416.7500),   -- Nigerian Naira
(85, 2022, 'ZAR', 16.3700),    -- South African Rand
(86, 2022, 'KES', 118.1300),   -- Kenyan Shilling
(87, 2022, 'GHS', 8.2700),     -- Ghanaian Cedi
(88, 2022, 'ETB', 52.5100),    -- Ethiopian Birr
(94, 2022, 'KZT', 460.2600),   -- Kazakhstani Tenge
(95, 2022, 'UZS', 11088.0000), -- Uzbekistani Som
(98, 2022, 'GEL', 2.9160),     -- Georgian Lari
(99, 2022, 'AMD', 408.2000);   -- Armenian Dram


-- ─────────────────────────────────────────────
-- 10. SANCTIONS  (active/historical, real-world)
-- Sources: UN Security Council, OFAC, EU Official Journal
-- ─────────────────────────────────────────────
INSERT INTO sanctions (imposing_country, target_country, product_id, start_date, end_date, sanction_type, legal_basis) VALUES
-- US sanctions on Iran (comprehensive)
(1, 74, NULL, '2018-11-05', NULL,
 'import ban; export ban; asset freeze',
 'Executive Order 13846; IEEPA; Iran Sanctions Act — reimposed after JCPOA withdrawal'),

-- US sanctions on Russia (post-Ukraine invasion)
(1, 36, NULL, '2022-03-01', NULL,
 'export ban; asset freeze; financial sanctions',
 'Export Administration Regulations (EAR) Entity List; E.O. 14024; CAATSA'),

-- EU sanctions on Russia (post-Ukraine invasion)
(20, 36, NULL, '2022-02-25', NULL,
 'import ban; export ban; asset freeze',
 'EU Council Regulation 2022/328 — response to invasion of Ukraine'),

-- US crude oil import ban on Russia
(1, 36, 14, '2022-03-08', NULL,
 'import ban',
 'Executive Order 14066 — banning import of Russian energy products'),

-- US sanctions on Cuba (long-standing embargo)
(1, 16, NULL, '1962-02-07', NULL,
 'comprehensive trade embargo',
 'Cuban Assets Control Regulations (CACR); Trading with the Enemy Act (TWEA)'),

-- US sanctions on Venezuela (targeted)
(1,  9, NULL, '2015-03-09', NULL,
 'asset freeze; financial sanctions',
 'Executive Order 13692; Venezuela-specific sanctions targeting officials and PDVSA'),

-- US Section 301 tariffs on China (trade war)
(1, 46, 31, '2018-07-06', NULL,
 'punitive tariff',
 'Section 301 of the Trade Act of 1974 — USTR investigation into technology transfer practices'),

-- US Section 301 tariffs on China (steel/aluminum)
(1, 46, 27, '2018-03-23', NULL,
 'punitive tariff',
 'Section 232 of the Trade Expansion Act of 1962 — national security determination on steel'),

-- China retaliatory tariffs on US soybeans
(46,  1,  8, '2018-07-06', NULL,
 'punitive tariff',
 'Chinese Ministry of Finance announcement — retaliation to US Section 301 tariffs'),

-- China trade restrictions on Australian wine
(46, 49, 12, '2020-11-27', '2024-03-29',
 'anti-dumping & countervailing duties',
 'MOFCOM Anti-dumping Investigation; duties lifted March 2024'),

-- China trade restrictions on Australian barley/grain
(46, 49,  4, '2020-05-18', '2023-08-05',
 'anti-dumping duty',
 'MOFCOM anti-dumping and countervailing duty investigation; duties lifted August 2023'),

-- India import ban on certain Pakistani goods
(55, 56, NULL, '2019-02-16', NULL,
 'import ban; 200% customs duty',
 'India imposed 200% basic customs duty on all goods originating from Pakistan after Pulwama attack'),

-- Saudi Arabia/GCC embargo on Qatar
(70, 78, NULL, '2017-06-05', '2021-01-05',
 'comprehensive trade & transport embargo',
 'Gulf Cooperation Council dispute — Saudi Arabia, UAE, Bahrain, Egypt cut ties; lifted January 2021'),

-- US arms embargo on Myanmar
(1, 67, 49, '2021-02-11', NULL,
 'export ban; arms embargo',
 'Executive Order 14014 — response to military coup of February 2021');
