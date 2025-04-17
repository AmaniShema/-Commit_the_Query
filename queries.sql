SELECT
    SaleId,
    Region,
    Product,
    SaleDate,
    Amount,
    LAG(Amount, 1, NULL) OVER (ORDER BY SaleDate) AS PreviousAmount,
    LEAD(Amount, 1, NULL) OVER (ORDER BY SaleDate) AS NextAmount,
    CASE
        WHEN Amount > LAG(Amount, 1, NULL) OVER (ORDER BY SaleDate) THEN 'HIGHER'
        WHEN Amount < LAG(Amount, 1, NULL) OVER (ORDER BY SaleDate) THEN 'LOWER'
        WHEN Amount = LAG(Amount, 1, NULL) OVER (ORDER BY SaleDate) THEN 'EQUAL'
        ELSE 'FIRST' -- For the very first record as there's no previous
    END AS ComparedToPrevious,
    CASE
        WHEN Amount > LEAD(Amount, 1, NULL) OVER (ORDER BY SaleDate) THEN 'HIGHER'
        WHEN Amount < LEAD(Amount, 1, NULL) OVER (ORDER BY SaleDate) THEN 'LOWER'
        WHEN Amount = LEAD(Amount, 1, NULL) OVER (ORDER BY SaleDate) THEN 'EQUAL'
        ELSE 'LAST' -- For the very last record as there's no next
    END AS ComparedToNext
FROM
    SalesTable;

SELECT
    SaleId,
    Region,
    Product,
    SaleDate,
    Amount,
    RANK() OVER (PARTITION BY Region ORDER BY Amount DESC) AS AmountRankWithinRegion,
    DENSE_RANK() OVER (PARTITION BY Region ORDER BY Amount DESC) AS AmountDenseRankWithinRegion
FROM
    SalesTable;

WITH RankedSales AS (
    SELECT
        SaleId,
        Region,
        Product,
        SaleDate,
        Amount,
        RANK() OVER (PARTITION BY Region ORDER BY Amount DESC) AS AmountRankWithinRegion
    FROM
        SalesTable
)
SELECT
    SaleId,
    Region,
    Product,
    SaleDate,
    Amount
FROM
    RankedSales
WHERE
    AmountRankWithinRegion <= 2;
    
WITH RankedSalesByDate AS (
    SELECT
        SaleId,
        Region,
        Product,
        SaleDate,
        Amount,
        RANK() OVER (PARTITION BY Region ORDER BY SaleDate ASC) AS SaleDateRankWithinRegion
    FROM
        SalesTable
)
SELECT
    SaleId,
    Region,
    Product,
    SaleDate,
    Amount
FROM
    RankedSalesByDate
WHERE
    SaleDateRankWithinRegion <= 1;

SELECT
    SaleId,
    Region,
    Product,
    SaleDate,
    Amount,
    MAX(Amount) OVER (PARTITION BY Region) AS MaxAmountInRegion,
    MAX(Amount) OVER () AS OverallMaxAmount
FROM
    SalesTable;
