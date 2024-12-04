-- Q1 What are the top 5 brands by receipts scanned for most recent month?
-- In other words, we want to know which 5 brands had the highest number of receipts scanned last month.
-- 1. Showing Brands and its corresponding counts by receipt 
-- Issue 1: Realizing date format is UNIX timestamp in milliseconds 
-- Do we need to include other columns? Not really since we are only interested in finding out brands by receipts scanned

-- This shows that the latest month is March of 2021, so the most recent month will be Febuary of 2021
SELECT TO_CHAR(DATE_TRUNC('MONTH', TO_TIMESTAMP(TO_NUMBER(PARSE_JSON(DATESCANNED):"$date") / 1000)), 'YYYY-MM') AS latest_month
FROM "RECEIPTS"
ORDER BY latest_month DESC

-- After cleaning the data we no longer parse date column
SELECT MIN(DATESCANNED), MAX(DATESCANNED)
FROM RECEIPTS_CLEAN
LIMIT 5 
-- We need to find information on the entire 2021/02 data

/*
Thought process: Use the middle table of three (Receipt_items),
Join with the Receipts_Clean table for Datescanned information
Join with the Brands_Clean table for Brands name information
Filter (Where) 2021 Feb (Most recent month)
Group by the brand name 
AND Order by count of datescanned (receipts) in DESC order
Finally limit 5 to show the top 5 brands
*/

--Solution 1--
SELECT BRANDS_CLEAN.NAME
FROM RECEIPT_ITEMS
JOIN brands_clean ON receipt_items.brandcode = brands_clean.brandcode JOIN RECEIPTS_CLEAN ON RECEIPT_ITEMS._id = RECEIPTS_CLEAN._id
WHERE  DATESCANNED BETWEEN '2021-02-01' AND '2021-02-28'
GROUP BY BRANDS_CLEAN.NAME
ORDER BY COUNT(RECEIPTS_CLEAN.DATESCANNED) DESC
LIMIT 5 


--Solution 2--
WITH RecentReceipts AS (
  SELECT
    _id
  FROM
    receipts_clean
  WHERE
    datescanned >= DATEADD (
      MONTH,
      -1,
      (
        SELECT
          MAX(datescanned)
        FROM
          receipts_clean
      )
    )
    AND datescanned <= (
      SELECT
        MAX(datescanned)
      FROM
        receipts_clean
    )
),
ReceiptItems AS (
  SELECT
    ri._id AS receipt_id,
    ri.brandcode
  FROM
    receipt_items AS ri
    INNER JOIN RecentReceipts AS r ON ri._id = r._id
),
BrandReceipts AS (
  SELECT
    b.name AS brand_name,
    COUNT(DISTINCT ri.receipt_id) AS total_receipts
  FROM
    ReceiptItems AS ri
    INNER JOIN brands_clean AS b ON ri.brandcode = b.brandcode
  GROUP BY
    b.name
)
SELECT
  brand_name,
  total_receipts
FROM
  BrandReceipts
ORDER BY
  total_receipts DESC
LIMIT
  5;

"""
output: (I suspect the reason why I onnly able to get one row is due to joining by barcode and filter by the date, this further reduces down the available data)
BRAND_NAME	TOTAL_RECEIPTS
Viva	      1
"""

/* 
Q2: How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?
Thought process: 
1. filter the past 2 months (previous month) data of receipts, which should be 2021 Jan data 
2. combine receipt table with receipt item table with id
3. combine receipt item table with brand table with barcode 
4. use rank() in window function to partition by month 
*/


WITH RecentReceipts AS (
  SELECT
    _id,
    DATE_PART (MONTH, purchasedate) AS month
  FROM
    receipts_clean
  WHERE
    purchasedate >= DATEADD (
      MONTH,
      -2,
      (
        SELECT
          MAX(purchasedate)
        FROM
          receipts_clean
      )
    )AND purchasedate <= (
      SELECT
        MAX(purchasedate)
      FROM
        receipts_clean
    )
),
ReceiptItems AS (
  SELECT
    ri._id AS receipt_id,
    ri.brandcode,
    r.month
  FROM
    receipt_items AS ri
    INNER JOIN RecentReceipts AS r ON ri._id = r._id
),BrandReceipts AS (
  SELECT
    b.name AS brand_name,
    ri.month,
    COUNT(DISTINCT ri.receipt_id) AS total_receipts
  FROM
    ReceiptItems AS ri
    INNER JOIN brands_clean AS b ON ri.brandcode = b.brandcode
  GROUP BY
    b.name,
    ri.month
),
RankedBrands AS (
  SELECT
    brand_name,
    month,
    total_receipts,
    RANK() OVER (
      PARTITION BY month
      ORDER BY
        total_receipts DESC
    ) AS rank
  FROM
    BrandReceipts
)
SELECT
  brand_name,
  month,
  total_receipts,
  rank
FROM
  RankedBrands
WHERE
  rank <= 5
ORDER BY
  month,
  rank;

"""
Output: 
BRAND_NAME	MONTH	TOTAL_RECEIPTS	RANK
Pepsi	      1	    22	            1
Kraft	      1	    20	            2
Kleenex	    1 	  19	            3
KNORR	      1	    18	            4
Doritos	    1	    17	            5 
Viva	      2	    1	              1 
"""


/*
*****
Q3: When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
Ans: rewardsReceiptStatus of Accepted is greater for average spend
*/
WITH accepted_receipts AS (
  SELECT TOTALSPENT
  FROM RECEIPTS_CLEAN
  WHERE REWARDSRECEIPTSTATUS = 'FINISHED'
), rejected_receipts AS (
  SELECT TOTALSPENT
  FROM RECEIPTS_CLEAN
  WHERE REWARDSRECEIPTSTATUS = 'REJECTED'
)
SELECT
  AVG(accepted_receipts.TOTALSPENT) AS Avg_accepted_spend,
  AVG(rejected_receipts.TOTALSPENT) AS Avg_rejected_spend
FROM
  accepted_receipts,
  rejected_receipts;


"""
Output:
AVG_ACCEPTED_SPEND	AVG_REJECTED_SPEND
80.85430502	        23.32605634
"""
  
/*
Q4: When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
Ans: The total number of items purchased from receipts with rewardsReceiptStatus of Accepted is greater 
*/

WITH accepted_receipts AS (
  SELECT purchasedItemCount
  FROM RECEIPTS_CLEAN
  WHERE REWARDSRECEIPTSTATUS = 'FINISHED'
), rejected_receipts AS (
  SELECT purchasedItemCount
  FROM RECEIPTS_CLEAN
  WHERE REWARDSRECEIPTSTATUS = 'REJECTED'
)
SELECT 
    SUM(accepted_receipts.purchasedItemCount) AS Sum_accepted_purchasedItemCount,
    SUM(rejected_receipts.purchasedItemCount) AS Sum_rejected_purchasedItemCount
FROM
    accepted_receipts,
    rejected_receipts;

"""
Output:
SUM_ACCEPTED_PURCHASEDITEMCOUNT	SUM_REJECTED_PURCHASEDITEMCOUNT
581064.0	                      89614.0
"""

/*
Q5: Which brand has the most spend among users who were created within the past 6 months?
Table needed to answer this question: Brands, Receipts for spend, users
Thought process: 
1, filter users created from the past 6 months 
2. join the users to receipt table 
3. join again to receipt item table 
4. join again to brand table for brand name
5. selected the chain CTE and display brand name 
*/


WITH RecentUsers AS (
  SELECT _id
  FROM users_clean
  WHERE
    createddate >= DATEADD (MONTH, -6,
      (SELECT
          MAX(createddate)
        FROM
          users_clean
      )
    )AND createddate <= (
      SELECT MAX(createddate)
      FROM users_clean
    )
),UserReceipts AS (
  SELECT
    r._id AS receipt_id,
    r.userid
  FROM
    receipts_clean AS r
    INNER JOIN RecentUsers AS u ON r.userid = u._id
), 
ReceiptItems AS (
  SELECT
    ri._id AS receipt_id,
    ri.barcode,
    ri.finalprice AS spend,
    ri.brandcode
  FROM
    receipt_items AS ri
    INNER JOIN UserReceipts AS ur ON ri._id = ur.receipt_id
),
BrandSpend AS (
  SELECT
    b.name AS brand_name,
    SUM(ri.spend) AS total_spend
  FROM
    ReceiptItems AS ri
    INNER JOIN brands_clean AS b ON ri.brandcode = b.brandcode
  GROUP BY
    b.name
)
SELECT
  brand_name,
  total_spend
FROM
  BrandSpend
ORDER BY
  total_spend DESC
LIMIT 1;

"""
Output:
BRAND_NAME	            TOTAL_SPEND
Cracker Barrel Cheese	  1097.46
"""

/*
Q6: Which brand has the most transactions among users who were created within the past 6 months?
Ans: Pepsi
Thought process: 
1. Filter users data from the past 6 months
2. join with receipt and leave only id and userid 
3. join with receipt item table and display only id and barcode 
4. join with brand table and group by brand
5. show brand name and count of transactions 
6. order descendingly by the count of transactions
7. since we are only interested by the "most" limit 1
*/

WITH RecentUsers AS (
  SELECT _id
  FROM users_clean
  WHERE
    createddate >= DATEADD (MONTH, -6,
      (
        SELECT MAX(createddate)
        FROM users_clean
      )
    )
    AND createddate <= (
      SELECT MAX(createddate)
      FROM users_clean
    )
),
UserReceipts AS (
  SELECT
    r._id AS receipt_id,
    r.userid
  FROM
    receipts_clean AS r
    INNER JOIN RecentUsers AS u ON r.userid = u._id
),
ReceiptItems AS (
  SELECT
    ri._id AS receipt_id,
    ri.brandcode
  FROM
    receipt_items AS ri
    INNER JOIN UserReceipts AS ur ON ri._id = ur.receipt_id
),
BrandTransactions AS (
  SELECT
    b.name AS brand_name,
    COUNT(ri.receipt_id) AS total_transactions
  FROM
    ReceiptItems AS ri
    INNER JOIN brands_clean AS b ON ri.brandcode = b.brandcode
  GROUP BY
    b.name
)
SELECT
  brand_name,
  total_transactions
FROM
  BrandTransactions
ORDER BY
  total_transactions DESC
LIMIT 1
  
"""
Output:
BRAND_NAME	TOTAL_TRANSACTIONS
Pepsi	      118
"""