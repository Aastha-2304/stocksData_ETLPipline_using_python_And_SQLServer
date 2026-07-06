USE stockDB;
GO

-- Total rows
SELECT COUNT(*) AS total_rows
FROM dbo.stock_data_2024;
GO

-- First 10 rows
SELECT TOP (10) *
FROM dbo.stock_data_2024;
GO

-- AVERAGE CLOSING PRICE PER STOCK
SELECT
    Stock,
    ROUND(AVG([Close]), 2) AS avg_close,
    ROUND(MIN([Close]), 2) AS min_close,
    ROUND(MAX([Close]), 2) AS max_close,
    ROUND(MAX([Close]) - MIN([Close]), 2) AS price_range
FROM dbo.stock_data_2024
GROUP BY Stock
ORDER BY avg_close DESC;
GO

-- BEST AND WORST DAY PER STOCK
SELECT
    Stock,
    ROUND(MAX(High), 2) AS best_day_price,
    ROUND(MIN(Low), 2) AS worst_day_price,
    ROUND(MAX(High) - MIN(Low), 2) AS total_range
FROM dbo.stock_data_2024
GROUP BY Stock
ORDER BY total_range DESC;
GO

-- MONTHLY AVERAGE CLOSING PRICE
SELECT
    Stock,
    MONTH([Date]) AS [Month],
    ROUND(AVG([Close]), 2) AS avg_monthly_close
FROM dbo.stock_data_2024
GROUP BY
    Stock,
    MONTH([Date])
ORDER BY
    Stock,
    [Month];
GO

-- TOP 10 HIGHEST VOLUME DAYS
SELECT TOP (10)
    Stock,
    [Date],
    ROUND([Close], 2) AS close_price,
    Volume
FROM dbo.stock_data_2024
ORDER BY Volume DESC;
GO

-- COMPLETE STOCK SUMMARY
SELECT
    Stock,
    ROUND(AVG(CAST([Close] AS FLOAT)), 2) AS avg_price,
    ROUND(MIN(CAST([Close] AS FLOAT)), 2) AS min_price,
    ROUND(MAX(CAST([Close] AS FLOAT)), 2) AS max_price,
    ROUND(AVG(CAST(Volume AS BIGINT)), 0) AS avg_daily_volume,
    ROUND(
        (
            (MAX(CAST([Close] AS FLOAT)) - MIN(CAST([Close] AS FLOAT)))
            / NULLIF(MIN(CAST([Close] AS FLOAT)), 0)
        ) * 100,
        2
    ) AS price_growth_pct
FROM dbo.stock_data_2024
GROUP BY Stock
ORDER BY price_growth_pct DESC;