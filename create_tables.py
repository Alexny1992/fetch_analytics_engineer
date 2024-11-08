import psycopg2
from connect_to_database import connect_to_db


conn = connect_to_db()

drop_receipts_table = """DROP TABLE Receipts"""

# Define table creation scripts
users_table = """
CREATE TABLE IF NOT EXISTS Users (
    _id UUID PRIMARY KEY,
    state TEXT,
    createdDate TIMESTAMP,
    lastLogin TIMESTAMP,
    role TEXT,
    active BOOLEAN
);
"""

bonusPoints_table = """
CREATE TABLE IF NOT EXISTS BonusPoints (
    _id UUID PRIMARY KEY,
    receiptId UUID,
    bonusPointsEarned INTEGER,
    bonusPointsEarnedReason TEXT,
    price FLOAT4
);
"""

receipts_table = """
CREATE TABLE IF NOT EXISTS Receipts (
    _id UUID PRIMARY KEY,
    createDate TIMESTAMP,
    dateScanned TIMESTAMP,
    finishedDate TIMESTAMP,
    modifyDate TIMESTAMP,
    pointsAwardedDate TIMESTAMP,
    pointsEarned INTEGER,
    purchaseDate DATE,
    purchasedItemCount INTEGER,
    rewardsReceiptStatusId TEXT,
    totalSpent FLOAT4,
    userId UUID
);
"""

receiptItems_table = """
CREATE TABLE IF NOT EXISTS ReceiptItems (
    _id UUID PRIMARY KEY,
    receiptId UUID,
    brandsID UUID,
    barcode TEXT,
    description TEXT,
    finalPrice FLOAT4,
    itemPrice FLOAT4,
    needFetchReview BOOLEAN,
    partnerItemId INTEGER,
    preventTargetGapPoints BOOLEAN,
    quantityPurchased INTEGER,
    userFlaggedBarcode INTEGER,
    userFlaggedNewItem BOOLEAN,
    userFlaggedPrice INTEGER,
    userFlaggedQuantity INTEGER
);
"""

brands_table = """
CREATE TABLE IF NOT EXISTS Brands (
    _id UUID PRIMARY KEY,
    barcode INTEGER,
    categoryId UUID,
    cpgId UUID,
    topBrand TEXT,
    brandCode TEXT,
    name TEXT
);
"""

cpg_table = """
CREATE TABLE IF NOT EXISTS CPG (
    _id UUID PRIMARY KEY,
    cpg TEXT
);
"""

category_table = """
CREATE TABLE IF NOT EXISTS Categories (
    _id UUID PRIMARY KEY,
    category TEXT,
    categorycode TEXT
);
"""

# Execute table creation
tables = [users_table, bonusPoints_table, receipts_table, receiptItems_table, brands_table, cpg_table]

# for table in tables:
#     cur.execute(table)
#     conn.commit()

add_foreign_key_receipts = """
ALTER TABLE Receipts
ADD CONSTRAINT userid
FOREIGN KEY (userid)
REFERENCES Users(_id)
ON DELETE CASCADE;
"""

drop_foreign_key = """
ALTER TABLE Receipts
DROP CONSTRAINT userid;
"""

add_foreign_key_receipts = """
ALTER TABLE Receipts
ADD CONSTRAINT fk_userid
FOREIGN KEY (userid)
REFERENCES Users(_id)
ON DELETE CASCADE;
"""

add_foreign_key_receiptsItems = """
ALTER TABLE receiptitems
ADD CONSTRAINT fk_receiptId
FOREIGN KEY (receiptId)
REFERENCES Receipts (_id)
ON DELETE CASCADE;
"""

add_foreign_key_bonuspoints = """
ALTER TABLE bonuspoints
ADD CONSTRAINT fk_receiptid
FOREIGN KEY (receiptId)
REFERENCES Receipts (_id)
ON DELETE CASCADE;
"""

add_foreign_key_brands = """
ALTER TABLE receiptitems
ADD CONSTRAINT fk_brandsID
FOREIGN KEY (brandsID)
REFERENCES Brands (_id)
ON DELETE CASCADE;
"""


add_foreign_key_cpg = """
ALTER TABLE brands
ADD CONSTRAINT fk_cpg
FOREIGN KEY (cpgid)
REFERENCES cpg (_id)
ON DELETE CASCADE;
"""

add_foreign_key_category = """
ALTER TABLE brands
ADD CONSTRAINT fk_category
FOREIGN KEY (categoryid)
REFERENCES categories (_id)
ON DELETE CASCADE;
"""


cur = conn.cursor()
cur.execute()
conn.commit()


cur.close()
conn.close()