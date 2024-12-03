--Creating Brands Table
CREATE TABLE "FETCH_S3_DATABASE"."PUBLIC"."Brands" ( _id VARCHAR , barcode VARCHAR , brandCode VARCHAR , cpg VARCHAR , name VARCHAR , topBrand BOOLEAN ); 

CREATE TEMP FILE FORMAT "FETCH_S3_DATABASE"."PUBLIC"
	TYPE=JSON
    STRIP_OUTER_ARRAY=TRUE
    REPLACE_INVALID_CHARACTERS=TRUE
    DATE_FORMAT=AUTO
    TIME_FORMAT=AUTO
    TIMESTAMP_FORMAT=AUTO; 

COPY INTO "FETCH_S3_DATABASE"."PUBLIC"."Brands" 
FROM (SELECT $1:_id::VARCHAR, $1:barcode::VARCHAR, $1:brandCode::VARCHAR, $1:cpg::VARCHAR, $1:name::VARCHAR, $1:topBrand::BOOLEAN
	FROM '@"FETCH_S3_DATABASE"."PUBLIC"."S3_TO_SNOWFLAKE"') 
FILES = ('Brands.json') 
FILE_FORMAT = '"FETCH_S3_DATABASE"."PUBLIC"' 
ON_ERROR=ABORT_STATEMENT 


--Creating Categories Table
CREATE TABLE "FETCH_S3_DATABASE"."PUBLIC"."Categories" ( category VARCHAR , categoryCode VARCHAR, categoryId VARCHAR ); 

CREATE TEMP FILE FORMAT "FETCH_S3_DATABASE"."PUBLIC"
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
FILE_FORMAT = '"FETCH_S3_DATABASE"."PUBLIC"' 
ON_ERROR=ABORT_STATEMENT 


-- Creating User Table 
CREATE TABLE "FETCH_S3_DATABASE"."PUBLIC"."users" ( _id VARCHAR , active BOOLEAN , createdDate VARCHAR , lastLogin VARCHAR , role VARCHAR , signUpSource VARCHAR , state VARCHAR ); 

CREATE TEMP FILE FORMAT "FETCH_S3_DATABASE"."PUBLIC"
	TYPE=JSON
    STRIP_OUTER_ARRAY=TRUE
    REPLACE_INVALID_CHARACTERS=TRUE
    DATE_FORMAT=AUTO
    TIME_FORMAT=AUTO
    TIMESTAMP_FORMAT=AUTO; 

COPY INTO "FETCH_S3_DATABASE"."PUBLIC"."users" 
FROM (SELECT $1:_id::VARCHAR, $1:active::BOOLEAN, $1:createdDate::VARCHAR, $1:lastLogin::VARCHAR, $1:role::VARCHAR, $1:signUpSource::VARCHAR, $1:state::VARCHAR
	FROM '@"FETCH_S3_DATABASE"."PUBLIC"."S3_TO_SNOWFLAK"') 
FILES = ('users.json') 
FILE_FORMAT = '"FETCH_S3_DATABASE"."PUBLIC"' 
ON_ERROR=ABORT_STATEMENT 


-- Creating Receipt Table
CREATE TABLE "FETCH_S3_DATABASE"."PUBLIC"."Receipt" ( _id VARCHAR , bonusPointsEarned NUMBER(38, 0) , bonusPointsEarnedReason VARCHAR , createDate VARCHAR , dateScanned VARCHAR , finishedDate VARCHAR , modifyDate VARCHAR , pointsAwardedDate VARCHAR , pointsEarned VARCHAR , purchaseDate VARCHAR , purchasedItemCount NUMBER(38, 0) , rewardsReceiptStatus VARCHAR , totalSpent VARCHAR , userId VARCHAR ); 

CREATE TEMP FILE FORMAT "FETCH_S3_DATABASE"."PUBLIC"
	TYPE=JSON
    STRIP_OUTER_ARRAY=TRUE
    REPLACE_INVALID_CHARACTERS=TRUE
    DATE_FORMAT=AUTO
    TIME_FORMAT=AUTO
    TIMESTAMP_FORMAT=AUTO; 

COPY INTO "FETCH_S3_DATABASE"."PUBLIC"."Receipt" 
FROM (SELECT $1:_id::VARCHAR, $1:bonusPointsEarned::NUMBER(3, 0), $1:bonusPointsEarnedReason::VARCHAR, $1:createDate::VARCHAR, $1:dateScanned::VARCHAR, $1:finishedDate::VARCHAR, $1:modifyDate::VARCHAR, $1:pointsAwardedDate::VARCHAR, $1:pointsEarned::VARCHAR, $1:purchaseDate::VARCHAR, $1:purchasedItemCount::NUMBER(3, 0), $1:rewardsReceiptStatus::VARCHAR, $1:totalSpent::VARCHAR, $1:userId::VARCHAR
	FROM '@"FETCH_S3_DATABASE"."PUBLIC"."S3_TO_SNOWFLAK"') 
FILES = ('Receipts.json') 
FILE_FORMAT = '"FETCH_S3_DATABASE"."PUBLIC"' 
ON_ERROR=ABORT_STATEMENT 


-- Creating BonuePoint table
CREATE TABLE "FETCH_S3_DATABASE"."PUBLIC"."Ef" ( _id VARCHAR , bonusPointsEarned NUMBER(38, 0) , bonusPointsEarnedReason VARCHAR ); 

CREATE TEMP FILE FORMAT "FETCH_S3_DATABASE"."PUBLIC"
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
FILE_FORMAT = '"FETCH_S3_DATABASE"."PUBLIC"' 
ON_ERROR=ABORT_STATEMENT 

-- Creating RewardReceivedItems
CREATE TABLE "FETCH_S3_DATABASE"."PUBLIC"."RewardReceiptItem" ( barcode VARCHAR , brandCode VARCHAR , competitiveProduct BOOLEAN , competitorRewardsGroup VARCHAR , deleted BOOLEAN , description VARCHAR , discountedItemPrice VARCHAR , finalPrice VARCHAR , itemNumber VARCHAR , itemPrice VARCHAR , metabriteCampaignId VARCHAR , needsFetchReview BOOLEAN , needsFetchReviewReason VARCHAR , originalFinalPrice VARCHAR , originalMetaBriteBarcode VARCHAR , originalMetaBriteDescription VARCHAR , originalMetaBriteItemPrice VARCHAR , originalMetaBriteQuantityPurchased NUMBER(38, 1) , originalReceiptItemText VARCHAR , partnerItemId VARCHAR , pointsEarned VARCHAR , pointsNotAwardedReason VARCHAR , pointsPayerId VARCHAR , preventTargetGapPoints BOOLEAN , priceAfterCoupon VARCHAR , quantityPurchased NUMBER(38, 1) , rewardsGroup VARCHAR , rewardsProductPartnerId VARCHAR , targetPrice VARCHAR , userFlaggedBarcode VARCHAR , userFlaggedDescription VARCHAR , userFlaggedNewItem BOOLEAN , userFlaggedPrice VARCHAR , userFlaggedQuantity NUMBER(38, 1) ); 

CREATE TEMP FILE FORMAT "FETCH_S3_DATABASE"."PUBLIC"
	TYPE=JSON
    STRIP_OUTER_ARRAY=TRUE
    REPLACE_INVALID_CHARACTERS=TRUE
    DATE_FORMAT=AUTO
    TIME_FORMAT=AUTO
    TIMESTAMP_FORMAT=AUTO; 

COPY INTO "FETCH_S3_DATABASE"."PUBLIC"."RewardReceiptItem" 
FROM (SELECT $1:barcode::VARCHAR, $1:brandCode::VARCHAR, $1:competitiveProduct::BOOLEAN, $1:competitorRewardsGroup::VARCHAR, $1:deleted::BOOLEAN, $1:description::VARCHAR, $1:discountedItemPrice::VARCHAR, $1:finalPrice::VARCHAR, $1:itemNumber::VARCHAR, $1:itemPrice::VARCHAR, $1:metabriteCampaignId::VARCHAR, $1:needsFetchReview::BOOLEAN, $1:needsFetchReviewReason::VARCHAR, $1:originalFinalPrice::VARCHAR, $1:originalMetaBriteBarcode::VARCHAR, $1:originalMetaBriteDescription::VARCHAR, $1:originalMetaBriteItemPrice::VARCHAR, $1:originalMetaBriteQuantityPurchased::NUMBER(2, 1), $1:originalReceiptItemText::VARCHAR, $1:partnerItemId::VARCHAR, $1:pointsEarned::VARCHAR, $1:pointsNotAwardedReason::VARCHAR, $1:pointsPayerId::VARCHAR, $1:preventTargetGapPoints::BOOLEAN, $1:priceAfterCoupon::VARCHAR, $1:quantityPurchased::NUMBER(3, 1), $1:rewardsGroup::VARCHAR, $1:rewardsProductPartnerId::VARCHAR, $1:targetPrice::VARCHAR, $1:userFlaggedBarcode::VARCHAR, $1:userFlaggedDescription::VARCHAR, $1:userFlaggedNewItem::BOOLEAN, $1:userFlaggedPrice::VARCHAR, $1:userFlaggedQuantity::NUMBER(2, 1)
	FROM '@"FETCH_S3_DATABASE"."PUBLIC"."S3_TO_SNOWFLAKE"') 
FILES = ('Reward_Receipt_Item.json') 
FILE_FORMAT = '"FETCH_S3_DATABASE"."PUBLIC"' 
ON_ERROR=ABORT_STATEMENT 


