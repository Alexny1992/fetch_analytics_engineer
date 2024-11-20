SQL

COPY INTO "FETCH_S3_DATABASE"."PUBLIC"."Brands" 
FROM (SELECT $1:_id::VARCHAR, $1:barcode::VARCHAR, $1:brandCode::VARCHAR, $1:name::VARCHAR, $1:topBrand::BOOLEAN, UUID_STRING() AS cgqID, UUID_STRING() AS categoryId
	FROM '@"FETCH_S3_DATABASE"."PUBLIC"."S3_TO_SNOWFLAK"') 
FILES = ('Brands.json') 
FILE_FORMAT = '"FETCH_S3_DATABASE"."PUBLIC"."temp_file_format_infer_2024-11-19T16:41:05.997Z"' 
ON_ERROR=ABORT_STATEMENT 
-- For more details, see: https://docs.snowflake.com/en/sql-reference/sql/copy-into-table



CREATE TABLE "FETCH_S3_DATABASE"."PUBLIC"."Categories" ( category VARCHAR , categoryCode VARCHAR, categoryId VARCHAR ); 

CREATE TEMP FILE FORMAT "FETCH_S3_DATABASE"."PUBLIC"."temp_file_format_infer_2024-11-19T17:27:21.440Z"
	TYPE=JSON
    STRIP_OUTER_ARRAY=TRUE
    REPLACE_INVALID_CHARACTERS=TRUE
    DATE_FORMAT=AUTO
    TIME_FORMAT=AUTO
    TIMESTAMP_FORMAT=AUTO; 

COPY INTO "FETCH_S3_DATABASE"."PUBLIC"."Categories" 
FROM (SELECT $1:category::VARCHAR, $1:categoryCode::VARCHAR, UUID_STRING() AS categoryId
	FROM '@"FETCH_S3_DATABASE"."PUBLIC"."S3_TO_SNOWFLAK"') 
FILES = ('Brands.json') 
FILE_FORMAT = '"FETCH_S3_DATABASE"."PUBLIC"."temp_file_format_infer_2024-11-19T17:27:21.440Z"' 
ON_ERROR=ABORT_STATEMENT 
-- For more details, see: https://docs.snowflake.com/en/sql-reference/sql/copy-into-table

-- Creating User Table 
CREATE TABLE "FETCH_S3_DATABASE"."PUBLIC"."ius" ( _id VARCHAR , active BOOLEAN , createdDate VARCHAR , lastLogin VARCHAR , role VARCHAR , signUpSource VARCHAR , state VARCHAR ); 

CREATE TEMP FILE FORMAT "FETCH_S3_DATABASE"."PUBLIC"."temp_file_format_infer_2024-11-20T05:35:19.755Z"
	TYPE=JSON
    STRIP_OUTER_ARRAY=TRUE
    REPLACE_INVALID_CHARACTERS=TRUE
    DATE_FORMAT=AUTO
    TIME_FORMAT=AUTO
    TIMESTAMP_FORMAT=AUTO; 

COPY INTO "FETCH_S3_DATABASE"."PUBLIC"."ius" 
FROM (SELECT $1:_id::VARCHAR, $1:active::BOOLEAN, $1:createdDate::VARCHAR, $1:lastLogin::VARCHAR, $1:role::VARCHAR, $1:signUpSource::VARCHAR, $1:state::VARCHAR
	FROM '@"FETCH_S3_DATABASE"."PUBLIC"."S3_TO_SNOWFLAK"') 
FILES = ('users.json') 
FILE_FORMAT = '"FETCH_S3_DATABASE"."PUBLIC"."temp_file_format_infer_2024-11-20T05:35:19.755Z"' 
ON_ERROR=ABORT_STATEMENT 


-- Creating Receipt Table
CREATE TABLE "FETCH_S3_DATABASE"."PUBLIC"."asd" ( _id VARCHAR , bonusPointsEarned NUMBER(38, 0) , bonusPointsEarnedReason VARCHAR , createDate VARCHAR , dateScanned VARCHAR , finishedDate VARCHAR , modifyDate VARCHAR , pointsAwardedDate VARCHAR , pointsEarned VARCHAR , purchaseDate VARCHAR , purchasedItemCount NUMBER(38, 0) , rewardsReceiptStatus VARCHAR , totalSpent VARCHAR , userId VARCHAR ); 

CREATE TEMP FILE FORMAT "FETCH_S3_DATABASE"."PUBLIC"."temp_file_format_infer_2024-11-20T05:39:08.485Z"
	TYPE=JSON
    STRIP_OUTER_ARRAY=TRUE
    REPLACE_INVALID_CHARACTERS=TRUE
    DATE_FORMAT=AUTO
    TIME_FORMAT=AUTO
    TIMESTAMP_FORMAT=AUTO; 

COPY INTO "FETCH_S3_DATABASE"."PUBLIC"."asd" 
FROM (SELECT $1:_id::VARCHAR, $1:bonusPointsEarned::NUMBER(3, 0), $1:bonusPointsEarnedReason::VARCHAR, $1:createDate::VARCHAR, $1:dateScanned::VARCHAR, $1:finishedDate::VARCHAR, $1:modifyDate::VARCHAR, $1:pointsAwardedDate::VARCHAR, $1:pointsEarned::VARCHAR, $1:purchaseDate::VARCHAR, $1:purchasedItemCount::NUMBER(3, 0), $1:rewardsReceiptStatus::VARCHAR, $1:totalSpent::VARCHAR, $1:userId::VARCHAR
	FROM '@"FETCH_S3_DATABASE"."PUBLIC"."S3_TO_SNOWFLAK"') 
FILES = ('Receipts.json') 
FILE_FORMAT = '"FETCH_S3_DATABASE"."PUBLIC"."temp_file_format_infer_2024-11-20T05:39:08.485Z"' 
ON_ERROR=ABORT_STATEMENT 


-- Creating BonuePoint table
CREATE TABLE "FETCH_S3_DATABASE"."PUBLIC"."Ef" ( _id VARCHAR , bonusPointsEarned NUMBER(38, 0) , bonusPointsEarnedReason VARCHAR ); 

CREATE TEMP FILE FORMAT "FETCH_S3_DATABASE"."PUBLIC"."temp_file_format_infer_2024-11-20T17:53:27.084Z"
	TYPE=JSON
    STRIP_OUTER_ARRAY=TRUE
    REPLACE_INVALID_CHARACTERS=TRUE
    DATE_FORMAT=AUTO
    TIME_FORMAT=AUTO
    TIMESTAMP_FORMAT=AUTO; 

COPY INTO "FETCH_S3_DATABASE"."PUBLIC"."Ef" 
FROM (SELECT $1:_id::VARCHAR, $1:bonusPointsEarned::NUMBER(3, 0), $1:bonusPointsEarnedReason::VARCHAR
	FROM '@"FETCH_S3_DATABASE"."PUBLIC"."S3_TO_SNOWFLAK"') 
FILES = ('Receipts.json') 
FILE_FORMAT = '"FETCH_S3_DATABASE"."PUBLIC"."temp_file_format_infer_2024-11-20T17:53:27.084Z"' 
ON_ERROR=ABORT_STATEMENT 

-- Creating RewardReceivedItems
CREATE TABLE "FETCH_S3_DATABASE"."PUBLIC"."RewardReceivedItems" ( rewardsReceiptItemList VARCHAR ); 

CREATE TEMP FILE FORMAT "FETCH_S3_DATABASE"."PUBLIC"."temp_file_format_infer_2024-11-20T18:07:53.169Z"
	TYPE=JSON
    STRIP_OUTER_ARRAY=TRUE
    REPLACE_INVALID_CHARACTERS=TRUE
    DATE_FORMAT=AUTO
    TIME_FORMAT=AUTO
    TIMESTAMP_FORMAT=AUTO; 

COPY INTO "FETCH_S3_DATABASE"."PUBLIC"."RewardReceivedItems" 
FROM (SELECT $1:rewardsReceiptItemList::VARCHAR
	FROM '@"FETCH_S3_DATABASE"."PUBLIC"."S3_TO_SNOWFLAK"') 
FILES = ('Receipts.json') 
FILE_FORMAT = '"FETCH_S3_DATABASE"."PUBLIC"."temp_file_format_infer_2024-11-20T18:07:53.169Z"' 
ON_ERROR=ABORT_STATEMENT 