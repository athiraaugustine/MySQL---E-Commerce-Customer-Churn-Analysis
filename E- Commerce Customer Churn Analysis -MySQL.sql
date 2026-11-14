USE ecomm;
SELECT * FROM customer_churn;
UPDATE customer_churn SET WarehouseToHome = (SELECT ROUND(AVG(WarehouseToHome)) FROM (SELECT WarehouseToHome FROM customer_churn) AS temp)
WHERE WarehouseToHome IS NULL;
SET SQL_SAFE_UPDATES = 0;
UPDATE customer_churn SET HourSpendOnApp = (SELECT ROUND(AVG(HourSpendOnApp)) 
FROM (SELECT HourSpendOnApp FROM customer_churn) AS temp)
WHERE HourSpendOnApp IS NULL;
UPDATE customer_churn SET OrderAmountHikeFromlastYear = (SELECT ROUND(AVG(OrderAmountHikeFromlastYear))
 FROM (SELECT OrderAmountHikeFromlastYear FROM customer_churn) AS temp)
WHERE OrderAmountHikeFromlastYear IS NULL;
UPDATE customer_churn SET OrderAmountHikeFromlastYear = (SELECT ROUND(AVG(OrderAmountHikeFromlastYear))
 FROM (SELECT OrderAmountHikeFromlastYear FROM customer_churn) AS temp)
WHERE OrderAmountHikeFromlastYear IS NULL;
UPDATE customer_churn SET DaySinceLastOrder = (SELECT ROUND(AVG(DaySinceLastOrder)) 
FROM (SELECT DaySinceLastOrder FROM customer_churn) AS temp)
WHERE DaySinceLastOrder IS NULL;
SET SQL_SAFE_UPDATES = 1;
UPDATE customer_churn SET Tenure = (SELECT Tenure AS mode_value FROM Customer_churn
 WHERE Tenure IS NOT NULL GROUP BY Tenure ORDER BY COUNT(*) DESC LIMIT 1 )
WHERE Tenure IS NULL;
UPDATE customer_churn SET
Tenure = (SELECT mode_value FROM (SELECT Tenure AS mode_value FROM customer_churn WHERE Tenure IS NOT NULL GROUP BY Tenure ORDER BY COUNT(*) DESC, Tenure ASC LIMIT 1) AS subquery_tenure)
WHERE
    Tenure IS NULL;
UPDATE customer_churn SET
CouponUsed = (SELECT mode_value FROM (SELECT CouponUsed AS mode_value FROM customer_churn WHERE CouponUsed IS NOT NULL GROUP BY CouponUsed ORDER BY COUNT(*) DESC,
 CouponUsed ASC LIMIT 1) AS subquery_couponused)
WHERE CouponUsed IS NULL;
UPDATE customer_churn SET
OrderCount = (SELECT mode_value FROM (SELECT OrderCount AS mode_value FROM customer_churn WHERE OrderCount IS NOT NULL GROUP BY OrderCount ORDER BY COUNT(*) DESC, 
OrderCount ASC LIMIT 1) AS subquery_ordercount)
WHERE OrderCount IS NULL;
DELETE FROM customer_churn
WHERE WarehouseToHome > 100;
UPDATE Customer_churn SET PreferredLoginDevice = 'Mobile Phone' 
WHERE PreferredLoginDevice = 'Phone';
UPDATE Customer_churn SET PreferedOrderCat = 'Mobile Phone' 
WHERE PreferedOrderCat = 'Mobile';
UPDATE Customer_churn SET PreferredPaymentMode = 'Cash On Delivery' 
WHERE PreferredPaymentMode = 'COD';
UPDATE Customer_churn SET PreferredPaymentMode = 'Credit Card' 
WHERE PreferredPaymentMode = 'CC';
ALTER TABLE Customer_churn
RENAME COLUMN PreferedOrderCat TO PreferredOrderCat;
ALTER TABLE Customer_churn
RENAME COLUMN HourSpendOnApp TO HoursSpentOnApp;
SELECT * FROM Customer_churn;
ALTER TABLE Customer_churn
ADD COLUMN ComplaintReceived VARCHAR(5);
UPDATE Customer_churn SET ComplaintReceived = CASE WHEN Complain = 1
THEN 'Yes'
ELSE 'No'
END;

ALTER TABLE Customer_churn
ADD COLUMN ChurnStatus VARCHAR(10);
UPDATE Customer_churn SET ChurnStatus = CASE WHEN Churn = 1
THEN 'Churned'
ELSE 'Active'
END;
ALTER TABLE Customer_Churn
DROP Churn,
DROP Complain;
SELECT ChurnStatus, Count(*) AS Customer_StatusCount FROM Customer_churn
GROUP BY ChurnStatus;
SELECT AVG(Tenure) AS Average_Tenure,
SUM(CashbackAmount) AS Total_Cashback
FROM Customer_Churn WHERE ChurnStatus = 'Churned';
SELECT COUNT(CASE WHEN ComplaintReceived = 'Yes' THEN 1 END)* 100 / COUNT(*) AS Complaint_Percentage
FROM Customer_churn WHERE ChurnStatus = 'Churned';

SELECT CityTier, COUNT(*) AS Customer_count FROM Customer_churn
WHERE ChurnStatus = 'Churned'
AND PreferredOrderCat = 'Laptop & Accessory'
GROUP BY CityTier
ORDER BY Customer_count DESC LIMIT 1;

SELECT PreferredPaymentMode, COUNT(*) AS Customer_count FROM Customer_churn
WHERE ChurnStatus = 'Active'
GROUP BY PreferredPaymentMode
ORDER BY Customer_count DESC LIMIT 1;

SELECT SUM(OrderAmountHikeFromlastYear) AS Total_OrderAmountHikeFromLastYear
FROM customer_churn
WHERE MaritalStatus = 'Single' AND PreferredLoginDevice = 'Mobile Phone';

SELECT AVG(NumberOfDeviceRegistered) AS Average_Number_Of_Device FROM Customer_churn
WHERE PreferredPaymentMode = 'UPI';

SELECT CityTier, COUNT(*) AS Customer_count FROM customer_churn
GROUP BY CityTier
ORDER BY Customer_count DESC LIMIT 1;

SELECT Gender, SUM(CouponUsed) AS Total_Coupon FROM customer_churn
GROUP BY Gender
ORDER BY Total_Coupon DESC LIMIT 1;

SELECT PreferredOrderCat, COUNT(*) AS Customer_count, MAX(HoursSpentOnApp) AS Maxium_hours_spent
FROM Customer_churn
GROUP BY PreferredOrderCat;

SELECT SUM(OrderCount) AS TotalOrderCount FROM Customer_churn
WHERE PreferredPaymentMode = 'Credit Card'
 AND SatisfactionScore = (SELECT MAX(SatisfactionScore) FROM Customer_churn);
 
 SELECT AVG(SatisfactionScore) AS Average_SatisfactionScore FROM Customer_churn
 WHERE ComplaintReceived = 'Yes';

SELECT PreferredOrderCat FROM customer_churn
WHERE CouponUsed > 5;

SELECT PreferredOrderCat, AVG(CashbackAmount) AS Average_cashback FROM customer_churn
GROUP BY PreferredOrderCat
ORDER BY Average_cashback DESC LIMIT 3;

SELECT PreferredPaymentMode, AVG(Tenure) AS Avg_Tenure FROM customer_churn
WHERE OrderCount > 500
GROUP BY PreferredPaymentMode HAVING AVG(Tenure) = 10;

SELECT CASE
WHEN WarehouseToHome <=5 THEN 'Very Close Distance'
WHEN WarehouseToHome <=10 THEN 'Close Distance'
WHEN WarehouseToHome <=15 THEN 'Moderate Distance'
ELSE 'Far Distance' END AS Distance_Category, ChurnStatus,
COUNT(CustomerID) AS NumberOfCustomers FROM customer_churn
GROUP BY Distance_Category, ChurnStatus
ORDER BY Distance_Category, ChurnStatus;

SELECT * FROM customer_churn WHERE MaritalStatus = 'Married'
AND CityTier = 1 AND OrderCount >(SELECT AVG(OrderCount) FROM customer_churn);

CREATE TABLE customer_returns(
    ReturnID           INT PRIMARY KEY,
    CustomerID         INT,
    ReturnDate         DATE,
    RefundAmount       INT
    );
    
INSERT INTO customer_returns(ReturnID,CustomerID,ReturnDate,RefundAmount) VALUES
(1001,50022,'2023-01-01',2130),
(1002,50316,'2023-01-23',2000),
(1003,51099,'2023-02-14',2290),
(1004,52321,'2023-03-08',2510),
(1005,52928,'2023-03-20',3000),
(1006,53749,'2023-04-17',1740),
(1007,54206,'2023-04-21',3250),
(1008,54838,'2023-04-30',1990);

SELECT * FROM customer_returns;
SELECT * FROM customer_returns AS r
INNER JOIN customer_churn AS c ON r.CustomerID = c.CustomerID
WHERE c.ChurnStatus = 'Churned' AND c.ComplaintReceived = 'Yes';

 
