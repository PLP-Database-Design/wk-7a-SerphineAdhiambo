-- SQL query to transform the ProductDetail table into 1NF by removing multiple values in the 'Products' column.
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
SELECT OrderID, CustomerName, TRIM(product) 
FROM (
    SELECT OrderID, CustomerName, SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n), ',', -1) AS product
    FROM ProductDetail
    CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4) num
    WHERE CHAR_LENGTH(Products) - CHAR_LENGTH(REPLACE(Products, ',', '')) >= n - 1
) AS temp;

