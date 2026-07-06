-- ============================================================
--  INVENTORY SYSTEM — Realistic Seed Data
--  Database : inventory_system
--  Run this after the schema/tables are created.
-- ============================================================

USE inventory_system;

-- ------------------------------------------------------------
-- 0. CLEAR EXISTING DATA (safe order: child → parent)
-- ------------------------------------------------------------
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE stock_history;
TRUNCATE TABLE products;
TRUNCATE TABLE categories;
TRUNCATE TABLE admins;
SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- 1. ADMINS
-- ============================================================
INSERT INTO admins (username, email, password) VALUES
('admin',       'admin@inventoryco.com',   'admin123'),
('john.ops',    'john@inventoryco.com',    'john@2024'),
('sara.mgr',    'sara@inventoryco.com',    'sara@2024');

-- ============================================================
-- 2. CATEGORIES  (8 realistic product families)
-- ============================================================
INSERT INTO categories (category_name, description) VALUES
('Electronics',        'Laptops, smartphones, tablets, and accessories'),
('Office Supplies',    'Stationery, paper, pens, and desk accessories'),
('Furniture',          'Office chairs, desks, shelves, and cabinets'),
('Networking',         'Routers, switches, cables, and access points'),
('Software Licenses',  'Operating systems, productivity suites, antivirus'),
('Peripherals',        'Keyboards, mice, monitors, and webcams'),
('Consumables',        'Printer ink, toner cartridges, and paper rolls'),
('Safety Equipment',   'Fire extinguishers, first-aid kits, safety signs');

-- ============================================================
-- 3. PRODUCTS  (32 products spread across 8 categories)
--    Columns: product_name, category_id, price, quantity, min_stock, description, created_at
-- ============================================================
INSERT INTO products (product_name, category_id, price, quantity, min_stock, description, created_at) VALUES

-- Electronics (cat 1)
('Dell Latitude 5540 Laptop',      1, 85999.00, 42,  10, '15.6" FHD, i5-1335U, 16GB RAM, 512GB SSD',            '2024-08-01 09:00:00'),
('Apple MacBook Air M2',           1, 114999.00, 18,  5, '13.6" Liquid Retina, 8GB, 256GB SSD, Midnight',       '2024-08-05 10:30:00'),
('Samsung Galaxy Tab S9',          1,  62999.00, 27,  8, '11" AMOLED, Snapdragon 8 Gen 2, 256GB',               '2024-08-10 11:00:00'),
('Sony WH-1000XM5 Headphones',     1,  29999.00, 55, 15, 'Wireless noise-cancelling, 30hr battery',             '2024-09-01 08:00:00'),
('Logitech MX Keys S Keyboard',    6,  11999.00, 38, 10, 'Wireless, backlit, multi-device, USB-C charge',       '2024-09-03 09:00:00'),

-- Office Supplies (cat 2)
('A4 Paper Ream 500 Sheets',       2,    450.00, 320, 80, 'ITC Classique 75 GSM, white',                        '2024-07-15 08:00:00'),
('Ballpoint Pen Box (12 pcs)',      2,    120.00, 540, 100,'Reynolds 045 blue, fine tip',                        '2024-07-15 08:30:00'),
('Sticky Notes 3x3 (12 pads)',     2,    360.00, 210, 60, 'Post-it canary yellow, 100 sheets each',             '2024-07-20 09:00:00'),
('Stapler Heavy Duty',             2,    875.00,  95, 20, 'Max HD-11UFL, 50-sheet capacity',                    '2024-08-01 10:00:00'),
('Whiteboard Marker Set (8 col)',  2,    290.00, 185, 40, 'Camlin dry-erase, assorted colors',                  '2024-08-01 10:30:00'),

-- Furniture (cat 3)
('Ergonomic Office Chair',         3,  18500.00,  22,  5, 'Mesh back, adjustable lumbar, armrests',             '2024-06-01 09:00:00'),
('Standing Desk 160x80 cm',        3,  24999.00,  10,  3, 'Electric height-adjustable, oak finish',             '2024-06-10 09:00:00'),
('3-Shelf Bookcase',               3,   6800.00,  35,  8, 'Steel frame, 900x400x1800mm, dark grey',             '2024-06-15 10:00:00'),
('4-Drawer Filing Cabinet',        3,   9400.00,  14,  4, 'Metal, foolscap, lockable, charcoal',                '2024-07-01 09:00:00'),

-- Networking (cat 4)
('TP-Link Archer AX73 Router',     4,  12500.00,  30,  8, 'Wi-Fi 6, AX5400, dual-band, 6 antennas',            '2024-08-20 09:00:00'),
('Cisco SG350-28 Switch',          4,  38000.00,   9,  3, '28-port Gigabit Managed Switch, Layer 3',            '2024-08-22 10:00:00'),
('Cat6 Patch Cable 1m (10-pack)',  4,    850.00, 120, 30, 'Snagless, UTP, LSZH, grey',                         '2024-08-25 08:00:00'),
('Ubiquiti UniFi AP AC Pro',       4,  16500.00,  17,  5, 'Dual-band 802.11ac, 1300Mbps, PoE',                 '2024-09-01 11:00:00'),

-- Software Licenses (cat 5)
('Microsoft 365 Business (annual)',5,   8499.00,  50, 10, 'Word, Excel, PowerPoint, Teams — 1 user',            '2024-07-01 09:00:00'),
('Windows 11 Pro License',         5,  14999.00,  35,  8, 'OEM key, lifetime, genuine',                        '2024-07-05 09:30:00'),
('Adobe Acrobat Pro (annual)',     5,  16500.00,  20,  5, 'PDF creation, editing, e-sign — 1 user',             '2024-07-10 10:00:00'),
('Kaspersky Endpoint Security',    5,   5200.00,  45, 10, '1 year, 5 devices, cloud-managed',                   '2024-07-15 10:00:00'),

-- Peripherals (cat 6)
('Dell P2422H Monitor 24"',        6,  22500.00,  28,  6, 'FHD IPS, 60Hz, HDMI+DP, height-adjust',             '2024-08-01 09:00:00'),
('Logitech M720 Triathlon Mouse',  6,   6500.00,  60, 15, 'Wireless, 7 buttons, multi-device, darkfield',      '2024-08-03 09:00:00'),
('Logitech C920 Webcam',           6,   8999.00,  33, 10, '1080p 30fps, built-in stereo mic, USB',             '2024-08-05 10:00:00'),
('Anker 10-Port USB Hub',          6,   3200.00,  72, 20, 'USB 3.0 x7 + USB-C x3, 60W power delivery',        '2024-08-10 09:00:00'),

-- Consumables (cat 7)
('HP 678 Tri-color Ink Cartridge', 7,    890.00, 145, 40, 'Compatible with HP DeskJet series',                  '2024-07-01 08:00:00'),
('Canon PG-745 Black Ink',         7,    760.00, 180, 50, 'Compatible with Canon PIXMA iP2870',                 '2024-07-01 08:30:00'),
('Brother TN-2380 Toner',          7,   2800.00,  62, 20, 'High yield 2600 pages, HL-L2321D',                  '2024-07-05 09:00:00'),
('Thermal Paper Rolls 80x80 (50)',  7,   1100.00, 230, 60, 'BPA-free, 80mm width, POS compatible',              '2024-07-10 09:00:00'),

-- Safety Equipment (cat 8)
('ABC Fire Extinguisher 4kg',      8,   3500.00,  18,  6, 'ISI marked, 4kg dry powder, wall bracket included', '2024-06-01 09:00:00'),
('First Aid Kit (50-person)',       8,   2200.00,  11,  4, 'OSHA compliant, 200+ items, hard case',              '2024-06-05 10:00:00'),
('Safety Helmet (Pack of 5)',      8,   1750.00,  24,  6, 'HDPE, adjustable ratchet, EN 397 certified',         '2024-06-10 11:00:00');

-- ============================================================
-- 4. STOCK HISTORY  (90+ transactions over ~8 months)
--    changeType: 'IN' = stock received, 'OUT' = stock issued
-- ============================================================

-- === August 2024 — Initial stock loading ===
INSERT INTO stock_history (product_id, change_type, quantity_changed, updated_at) VALUES
(1,  'IN',  50, '2024-08-01 09:15:00'),
(2,  'IN',  20, '2024-08-05 10:35:00'),
(3,  'IN',  30, '2024-08-10 11:10:00'),
(4,  'IN',  60, '2024-09-01 08:05:00'),
(5,  'IN',  45, '2024-09-03 09:10:00'),
(6,  'IN', 400, '2024-07-15 08:05:00'),
(7,  'IN', 600, '2024-07-15 08:35:00'),
(8,  'IN', 240, '2024-07-20 09:05:00'),
(11, 'IN',  25, '2024-06-01 09:10:00'),
(12, 'IN',  12, '2024-06-10 09:15:00'),
(13, 'IN',  40, '2024-06-15 10:05:00'),
(15, 'IN',  35, '2024-08-20 09:05:00'),
(16, 'IN',  10, '2024-08-22 10:05:00'),
(17, 'IN', 150, '2024-08-25 08:10:00'),
(19, 'IN',  55, '2024-07-01 09:10:00'),
(20, 'IN',  40, '2024-07-05 09:35:00'),
(23, 'IN',  30, '2024-08-01 09:10:00'),
(24, 'IN',  70, '2024-08-03 09:10:00'),
(27, 'IN', 180, '2024-07-01 08:05:00'),
(28, 'IN', 200, '2024-07-01 08:35:00'),
(31, 'IN',  20, '2024-06-01 09:15:00'),
(32, 'IN',  14, '2024-06-05 10:10:00');

-- === September 2024 — Departmental issues ===
INSERT INTO stock_history (product_id, change_type, quantity_changed, updated_at) VALUES
(1,  'OUT',  5, '2024-09-04 10:00:00'),
(2,  'OUT',  2, '2024-09-05 11:00:00'),
(6,  'OUT', 40, '2024-09-06 09:00:00'),
(7,  'OUT', 50, '2024-09-06 09:30:00'),
(11, 'OUT',  2, '2024-09-10 10:00:00'),
(19, 'OUT',  5, '2024-09-12 09:00:00'),
(20, 'OUT',  4, '2024-09-12 09:30:00'),
(23, 'OUT',  3, '2024-09-15 10:00:00'),
(27, 'OUT', 20, '2024-09-16 08:30:00'),
(28, 'OUT', 18, '2024-09-16 09:00:00'),
(4,  'OUT',  5, '2024-09-18 11:00:00'),
(5,  'OUT',  7, '2024-09-20 09:30:00'),
(15, 'OUT',  4, '2024-09-22 10:00:00'),
(17, 'OUT', 20, '2024-09-25 08:00:00'),
(31, 'OUT',  2, '2024-09-28 09:00:00');

-- === October 2024 — Re-stock + heavy usage ===
INSERT INTO stock_history (product_id, change_type, quantity_changed, updated_at) VALUES
(6,  'IN',  200, '2024-10-02 08:00:00'),
(7,  'IN',  300, '2024-10-02 08:30:00'),
(8,  'OUT',  30, '2024-10-03 09:00:00'),
(27, 'IN',   80, '2024-10-04 08:00:00'),
(28, 'IN',  100, '2024-10-04 08:30:00'),
(1,  'OUT',   6, '2024-10-05 10:00:00'),
(3,  'OUT',   3, '2024-10-08 11:00:00'),
(19, 'OUT',   6, '2024-10-10 09:00:00'),
(24, 'OUT',  10, '2024-10-12 09:30:00'),
(13, 'OUT',   5, '2024-10-15 10:00:00'),
(29, 'IN',   80, '2024-10-16 08:00:00'),
(30, 'IN',  120, '2024-10-16 08:30:00'),
(5,  'OUT',   5, '2024-10-18 09:30:00'),
(16, 'OUT',   1, '2024-10-20 10:00:00'),
(23, 'OUT',   2, '2024-10-22 10:00:00'),
(20, 'OUT',   3, '2024-10-25 09:30:00');

-- === November 2024 — Quarter-end peak usage ===
INSERT INTO stock_history (product_id, change_type, quantity_changed, updated_at) VALUES
(6,  'OUT',  60, '2024-11-01 08:00:00'),
(7,  'OUT',  80, '2024-11-01 08:30:00'),
(1,  'OUT',   7, '2024-11-03 10:00:00'),
(2,  'OUT',   3, '2024-11-05 11:00:00'),
(4,  'OUT',  10, '2024-11-06 10:00:00'),
(19, 'OUT',   8, '2024-11-08 09:00:00'),
(20, 'OUT',   5, '2024-11-10 09:30:00'),
(21, 'IN',   25, '2024-11-12 09:00:00'),
(22, 'IN',   50, '2024-11-12 09:30:00'),
(27, 'OUT',  30, '2024-11-15 08:00:00'),
(28, 'OUT',  25, '2024-11-15 08:30:00'),
(29, 'OUT',  18, '2024-11-18 08:00:00'),
(12, 'OUT',   2, '2024-11-20 10:00:00'),
(15, 'OUT',   5, '2024-11-22 10:00:00'),
(31, 'OUT',   3, '2024-11-25 09:00:00'),
(5,  'IN',   20, '2024-11-27 09:30:00');

-- === December 2024 — Year-end stock-take & top-up ===
INSERT INTO stock_history (product_id, change_type, quantity_changed, updated_at) VALUES
(1,  'IN',  15, '2024-12-02 09:00:00'),
(2,  'IN',   5, '2024-12-02 09:30:00'),
(3,  'IN',  10, '2024-12-03 10:00:00'),
(6,  'IN', 150, '2024-12-04 08:00:00'),
(7,  'IN', 200, '2024-12-04 08:30:00'),
(11, 'IN',   8, '2024-12-05 09:00:00'),
(13, 'IN',  15, '2024-12-05 09:30:00'),
(23, 'IN',  10, '2024-12-06 09:00:00'),
(24, 'IN',  25, '2024-12-06 09:30:00'),
(6,  'OUT', 35, '2024-12-10 08:00:00'),
(7,  'OUT', 55, '2024-12-10 08:30:00'),
(27, 'OUT', 22, '2024-12-12 08:00:00'),
(28, 'OUT', 20, '2024-12-12 08:30:00'),
(19, 'OUT',  4, '2024-12-15 09:00:00'),
(20, 'OUT',  3, '2024-12-16 09:30:00'),
(4,  'OUT',  5, '2024-12-20 11:00:00'),
(29, 'IN',  50, '2024-12-22 08:00:00'),
(30, 'IN',  80, '2024-12-22 08:30:00');

-- === January 2025 — New year restocking ===
INSERT INTO stock_history (product_id, change_type, quantity_changed, updated_at) VALUES
(1,  'IN',  10, '2025-01-03 09:00:00'),
(15, 'IN',  15, '2025-01-05 09:00:00'),
(16, 'IN',   5, '2025-01-05 09:30:00'),
(17, 'IN',  80, '2025-01-06 08:00:00'),
(18, 'IN',  20, '2025-01-06 08:30:00'),
(6,  'OUT', 50, '2025-01-08 08:00:00'),
(7,  'OUT', 60, '2025-01-08 08:30:00'),
(22, 'OUT',  6, '2025-01-10 09:30:00'),
(25, 'IN',  15, '2025-01-12 10:00:00'),
(26, 'IN',  30, '2025-01-12 10:30:00'),
(27, 'OUT', 25, '2025-01-15 08:00:00'),
(28, 'OUT', 22, '2025-01-15 08:30:00'),
(1,  'OUT',  4, '2025-01-18 10:00:00'),
(3,  'OUT',  5, '2025-01-20 11:00:00'),
(19, 'OUT',  5, '2025-01-22 09:00:00'),
(20, 'OUT',  4, '2025-01-25 09:30:00');

-- === February 2025 — Routine operations ===
INSERT INTO stock_history (product_id, change_type, quantity_changed, updated_at) VALUES
(6,  'IN', 100, '2025-02-01 08:00:00'),
(7,  'IN', 120, '2025-02-01 08:30:00'),
(8,  'OUT',  25, '2025-02-03 09:00:00'),
(9,  'OUT',  10, '2025-02-03 09:30:00'),
(29, 'OUT',  20, '2025-02-05 08:00:00'),
(30, 'OUT',  28, '2025-02-05 08:30:00'),
(1,  'OUT',   3, '2025-02-08 10:00:00'),
(5,  'OUT',   6, '2025-02-10 09:30:00'),
(23, 'OUT',   3, '2025-02-12 10:00:00'),
(24, 'OUT',   8, '2025-02-14 09:30:00'),
(21, 'OUT',   5, '2025-02-15 09:00:00'),
(22, 'OUT',   8, '2025-02-18 09:30:00'),
(15, 'OUT',   3, '2025-02-20 10:00:00'),
(31, 'OUT',   2, '2025-02-22 09:00:00'),
(17, 'OUT',  18, '2025-02-25 08:00:00');

-- === March 2025 — Latest transactions ===
INSERT INTO stock_history (product_id, change_type, quantity_changed, updated_at) VALUES
(1,  'IN',  12, '2025-03-01 09:00:00'),
(2,  'IN',   8, '2025-03-01 09:30:00'),
(4,  'IN',  20, '2025-03-02 08:00:00'),
(6,  'OUT', 45, '2025-03-03 08:00:00'),
(7,  'OUT', 60, '2025-03-03 08:30:00'),
(11, 'OUT',  3, '2025-03-05 10:00:00'),
(13, 'OUT',  4, '2025-03-07 10:00:00'),
(19, 'OUT',  4, '2025-03-10 09:00:00'),
(20, 'OUT',  4, '2025-03-10 09:30:00'),
(27, 'IN',  60, '2025-03-12 08:00:00'),
(28, 'IN',  80, '2025-03-12 08:30:00'),
(27, 'OUT', 18, '2025-03-15 08:00:00'),
(28, 'OUT', 15, '2025-03-15 08:30:00'),
(24, 'OUT',  5, '2025-03-18 09:30:00'),
(5,  'OUT',  4, '2025-03-20 09:30:00'),
(29, 'OUT', 15, '2025-03-22 08:00:00'),
(30, 'OUT', 20, '2025-03-22 08:30:00'),
(3,  'OUT',  3, '2025-03-25 11:00:00'),
(16, 'OUT',  1, '2025-03-28 10:00:00'),
(31, 'IN',   8, '2025-03-30 09:00:00');

-- ============================================================
-- 5. LOW STOCK — Force 7 products below min_stock threshold
--    (query: WHERE quantity <= min_stock)
--    These products will appear on the Low Stock Alerts page
--    and increment the lowStockCount on the Dashboard/AI page.
-- ============================================================

-- product_id 2  : MacBook Air  — quantity 3  / min_stock 5   ← CRITICAL
-- product_id 12 : Standing Desk — quantity 2 / min_stock 3   ← CRITICAL
-- product_id 16 : Cisco Switch  — quantity 3 / min_stock 3   ← AT LIMIT
-- product_id 18 : Ubiquiti AP   — quantity 4 / min_stock 5   ← LOW
-- product_id 21 : Adobe Acrobat — quantity 4 / min_stock 5   ← LOW
-- product_id 25 : Logitech C920 — quantity 9 / min_stock 10  ← LOW
-- product_id 32 : First Aid Kit  — quantity 3 / min_stock 4  ← LOW

UPDATE products SET quantity = 3  WHERE product_id = 2;   -- MacBook Air M2
UPDATE products SET quantity = 2  WHERE product_id = 12;  -- Standing Desk
UPDATE products SET quantity = 3  WHERE product_id = 16;  -- Cisco Switch
UPDATE products SET quantity = 4  WHERE product_id = 18;  -- Ubiquiti AP
UPDATE products SET quantity = 4  WHERE product_id = 21;  -- Adobe Acrobat
UPDATE products SET quantity = 9  WHERE product_id = 25;  -- Logitech Webcam
UPDATE products SET quantity = 3  WHERE product_id = 32;  -- First Aid Kit

-- ============================================================
-- 6. APRIL–MAY 2025 — Dense recent history for AI Insights
--    • More transactions on high-value products so the
--      "Most Active Product" metric is meaningful
--    • Varied IN/OUT ratios across categories so the
--      pie chart and activity charts look full
-- ============================================================

-- === April 2025 ===
INSERT INTO stock_history (product_id, change_type, quantity_changed, updated_at) VALUES
-- Consumables heavy usage (office print season)
(27, 'OUT', 22, '2025-04-01 08:00:00'),
(28, 'OUT', 28, '2025-04-01 08:30:00'),
(29, 'OUT', 14, '2025-04-01 09:00:00'),
(30, 'OUT', 18, '2025-04-01 09:30:00'),
(27, 'IN',  80, '2025-04-03 08:00:00'),
(28, 'IN', 100, '2025-04-03 08:30:00'),
-- Office Supplies
(6,  'OUT', 55, '2025-04-04 08:00:00'),
(7,  'OUT', 70, '2025-04-04 08:30:00'),
(8,  'OUT', 20, '2025-04-05 09:00:00'),
(10, 'OUT', 25, '2025-04-05 09:30:00'),
(6,  'IN', 150, '2025-04-07 08:00:00'),
(7,  'IN', 180, '2025-04-07 08:30:00'),
-- Electronics issued to new hires
(1,  'OUT',  5, '2025-04-08 10:00:00'),
(2,  'OUT',  1, '2025-04-08 10:30:00'),  -- brings MacBook very low
(3,  'OUT',  4, '2025-04-09 11:00:00'),
(4,  'OUT',  8, '2025-04-10 10:00:00'),
-- Networking top-up
(15, 'IN',  12, '2025-04-10 09:00:00'),
(17, 'IN',  60, '2025-04-10 09:30:00'),
(18, 'OUT',  3, '2025-04-11 10:00:00'),  -- Ubiquiti AP goes low
-- Software new licenses
(19, 'OUT',  6, '2025-04-12 09:00:00'),
(20, 'OUT',  5, '2025-04-12 09:30:00'),
(21, 'OUT',  4, '2025-04-14 09:00:00'),  -- Adobe goes low
(22, 'OUT',  7, '2025-04-14 09:30:00'),
-- Peripherals
(23, 'OUT',  4, '2025-04-15 10:00:00'),
(24, 'OUT',  9, '2025-04-15 10:30:00'),
(25, 'OUT',  5, '2025-04-16 10:00:00'),  -- Webcam goes low
(26, 'OUT', 12, '2025-04-16 10:30:00'),
-- Safety check issue
(31, 'OUT',  4, '2025-04-18 09:00:00'),
(32, 'OUT',  2, '2025-04-18 09:30:00'),  -- First Aid Kit goes low
(33, 'OUT',  5, '2025-04-18 10:00:00'),
-- Consumable restock
(29, 'IN',  60, '2025-04-20 08:00:00'),
(30, 'IN',  80, '2025-04-20 08:30:00'),
-- Furniture issued
(11, 'OUT',  3, '2025-04-22 10:00:00'),
(13, 'OUT',  6, '2025-04-22 10:30:00'),
(14, 'OUT',  2, '2025-04-23 10:00:00'),
-- More electronics out
(1,  'OUT',  3, '2025-04-25 10:00:00'),
(5,  'OUT',  5, '2025-04-25 10:30:00'),
-- Office supplies continued
(6,  'OUT', 40, '2025-04-26 08:00:00'),
(7,  'OUT', 50, '2025-04-26 08:30:00'),
(9,  'OUT', 15, '2025-04-28 09:00:00'),
-- Networking adjustment
(16, 'OUT',  1, '2025-04-29 10:00:00'),  -- Cisco Switch hits limit
(17, 'OUT', 20, '2025-04-30 08:00:00');

-- === May 2025 (current month) ===
INSERT INTO stock_history (product_id, change_type, quantity_changed, updated_at) VALUES
-- Restock cycle
(1,  'IN',  20, '2025-05-02 09:00:00'),
(3,  'IN',  15, '2025-05-02 09:30:00'),
(4,  'IN',  25, '2025-05-02 10:00:00'),
(6,  'IN', 120, '2025-05-03 08:00:00'),
(7,  'IN', 150, '2025-05-03 08:30:00'),
(23, 'IN',  12, '2025-05-04 09:00:00'),
(24, 'IN',  30, '2025-05-04 09:30:00'),
-- Daily issues
(6,  'OUT', 30, '2025-05-05 08:00:00'),
(7,  'OUT', 40, '2025-05-05 08:30:00'),
(19, 'OUT',  3, '2025-05-06 09:00:00'),
(22, 'OUT',  4, '2025-05-06 09:30:00'),
(27, 'OUT', 16, '2025-05-07 08:00:00'),
(28, 'OUT', 20, '2025-05-07 08:30:00'),
(1,  'OUT',  4, '2025-05-07 10:00:00'),
(5,  'OUT',  3, '2025-05-07 10:30:00'),
(29, 'OUT', 14, '2025-05-08 08:00:00'),
(30, 'OUT', 18, '2025-05-08 08:30:00');

-- ============================================================
-- END OF SEED DATA
-- ============================================================
