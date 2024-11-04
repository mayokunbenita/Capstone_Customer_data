select * from [dbo].[CUSTOMERDATA]

DELETE FROM [dbo].[CUSTOMERDATA] WHERE CustomerID IS NULL AND REGION IS NULL AND SubscriptionType IS NULL;

1---------TOTAL NUMBER OF CUSTOMER FOR EACH REGION---------

SELECT REGION, COUNT(DISTINCT CUSTOMERID) AS CustomersPerRegion 
FROM [dbo].[CUSTOMERDATA] GROUP BY REGION 

2-------MOST POPULAR SUBSCRIPTION TYPE BY THE NUMBER OF CUSTOMERS-----

SELECT TOP (1) SubscriptionType, COUNT(CustomerID) AS CustomerSubscriptionType
FROM[dbo].[CUSTOMERDATA] GROUP BY SUBSCRIPTIONTYPE
ORDER BY CustomerSubscriptionType DESC

3-------CUSTOMERS WHO CANCELED THEIR SUBSCRIPTION WITHIN 6 MONTHS----XXXX

SELECT CustomerName, SUBSCRIPTIONSTART,SUBSCRIPTIONEND 
FROM [dbo].[CUSTOMERDATA] 
WHERE Canceled = 'TRUE'

4------- CALCULATE THE AVERAGE SUBSCRIPTION DURATUION FOR ALL CUSTOMERS ----- 

SELECT AVG(DATEDIFF(MONTH,SUBSCRIPTIONSTART,COALESCE(SUBSCRIPTIONEND,SUBSCRIPTIONSTART)))
AS AverageSubscriptionDuration
FROM [dbo].[CUSTOMERDATA]

5-------CUSTOMERS WITH SUBSCRIPTION LONGER THAN 12 MONTHS-----

SELECT DISTINCT CUSTOMERID, CUSTOMERNAME FROM [dbo].[CUSTOMERDATA]
WHERE COALESCE (SUBSCRIPTIONEND,GETDATE()) > DATEADD(MONTH,12,SUBSCRIPTIONSTART);

6---------TOTAL REVENUE BY SUBSCRIPTION TYPE----------------

SELECT SubscriptionType, SUM(REVENUE) AS TotalRevenueBySubscription FROM [dbo].[CUSTOMERDATA]
GROUP BY SubscriptionType ORDER BY TotalRevenueBySubscription DESC;

7--------TOP 3 REGIONS BY SUBSCRIPTION CANCELATION------

SELECT TOP (3) REGION, COUNT(CUSTOMERID) AS RegionalSubscriptionCanceled
FROM [dbo].[CUSTOMERDATA] WHERE CANCELED = 'TRUE' 
GROUP BY REGION ORDER BY RegionalSubscriptionCanceled DESC

8--------TOTAL NUMBER OF ACTIVE AND CANCELED SUBSCRIPTION-------

SELECT SUM(CASE WHEN CANCELED = 'FALSE' THEN 1 ELSE 0 END) AS ActiveSubscription,
       SUM(CASE WHEN CANCELED = 'TRUE' THEN 1 ELSE 0 END) AS Subscriptioncanceled
       FROM [dbo].[CUSTOMERDATA]

