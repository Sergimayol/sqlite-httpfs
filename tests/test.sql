.bail on

.header on
.mode box

SELECT load_extension('./target/release/libsqlite_httpfs', 'sqlite3_httpfs_init');

CREATE VIRTUAL TABLE IF NOT EXISTS demo USING HTTPFS('https://raw.githubusercontent.com/plotly/datasets/refs/heads/master/2014_us_cities.csv', 'csv');

.timer on
SELECT * FROM demo LIMIT 1;

SELECT * FROM demo WHERE name = 'Chicago';
SELECT * FROM demo WHERE pop > 1000000 LIMIT 5;
SELECT * FROM demo WHERE lat >= 33.0 AND name != 'Logan' LIMIT 5;
SELECT * FROM demo WHERE name != 'Logan' LIMIT 5;
SELECT name FROM demo WHERE name != 'Logan' LIMIT 5;
SELECT COUNT(*) as total_cities FROM demo WHERE pop > 1000000;

.timer off
CREATE VIRTUAL TABLE IF NOT EXISTS demo2 USING HTTPFS(url='https://raw.githubusercontent.com/plotly/datasets/refs/heads/master/2014_us_cities.csv', format='csv');
.timer on
SELECT AVG(pop) as avg_pop FROM demo2;