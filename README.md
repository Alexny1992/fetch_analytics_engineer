
# Fetch Rewards Coding Exercise - Analytics Engineer


## **Project Objective**
Goals: 
1. Reason about unstructured data and design structured, relational data models.
2. Write SQL queries to answer specific business questions.
3. Assess data quality and identify potential issues.
4. Communicate insights and technical challenges effectively to non-technical stakeholders.
---

### **1. Data Modeling**
**Objective**: Transform unstructured JSON data into a structured, relational schema for a data warehouse.  
**Steps**:
1. Review the provided JSON files:
   - `receipts.json.gz`
   - `users.json.gz`
   - `brands.json.gz`
2. Develop a structured relational model diagram showing:
   - Tables
   - Fields
   - Joinable keys

![Data Schema](https://github.com/Alexny1992/fetch_analytics_engineer/blob/main/01_Data_modeling/Data_Schema_ERD.jpg)

**A scenario walkthrough**: Someone registers an account through Fetch app, creating usersID and createdate, and all the necessary information (columns). He or she scans a receipt through the app and records receipt descriptions to the receipt table - a user can have multiple receipts (1 to many relationship) However, a receipt can contain multiple items and multiple receipts can also come from the same item therefore this is a many-to-many relationship.  Within the receipt item table, Barcode column connects to Brands table. Multiple items can be under one brand (Many to one relationship) Finally, a brand can only be under one category so this will be a one-to-one relationship 

Supplement: I have also worked on a bottom-up approach through normal form, images are included in the 01_ folder 

**Tools**: Lucidchart, Excel sheet

---

### **1.1 Data injection** 
Here I chose ETL (Extract, Transform, Load) as the RewardReceiptItemList from the receipt table can potentially be hard to parse through after normalizing

**Steps**:
1. Install Terraform and initialize 
2. Configure AWS S3 credential
3. Create an IAM User role 
4. Create a policy for S3 bucket permission under the IAM User role
5. Attach the policy to the IAM User Role
6. Upload files locally to S3 bucket
7. Configure Snowflake credentials
8. Create a connection between S3 and Snowflake
9. Create a S3 stage in snowflake
10. Create a S3 integration to warehouse resource

**Tools**: Terraform, VScode, AWS S3, AWS Iam, Snowflake
Link to the folder

Note: I initially started with Pandas route storing all the data locally into DBeaver through psycopg2. I scratched the route and decided to go with a tech stack that better aligns with Fetch. 

Note: The json files in the Terraform code are different from the files I used for analysis. Terraform code works fine, however, for the time being, I chose to clean the data through Pandas and directly upload them to Snowflake for the project. Here's a snapshot of my snowflake database:

![Snowflake Database](https://github.com/Alexny1992/fetch_analytics_engineer/blob/main/02_Data_Injection/Snowflake_Database_Snapshot.jpg)

---

### **2. SQL Queries**
**Objective**: Write SQL queries to address business questions using the new data model.  

#### **Business Questions**:
Select at least two:
- Top 5 brands by receipts scanned for the most recent month.
- Compare top 5 brands by receipts scanned for the current vs. previous month.
- Average spend comparison for receipts with `Accepted` vs. `Rejected` `rewardsReceiptStatus`.
- Total items purchased comparison for receipts with `Accepted` vs. `Rejected` `rewardsReceiptStatus`.
- Brand with the most spend among users created within the past 6 months.
- Brand with the most transactions among users created within the past 6 months.

**Tools**: Snowflake, Terraform, Amazon S3, Pandas, Google Collab

---

### **3. Data Quality Evaluation**
**Objective**: Identify and address potential data quality issues.  

**Steps**:
1. Explore JSON data programmatically using Python and Pandas
2. Identify potential issues (e.g., missing values, inconsistent formats, duplicates).

  - Identified issues 
  - Methods of discovery (EDA)
  - Recommendations for resolution

---

### **4. Stakeholder Communication**
**Objective**: Compose a concise and clear message for non-technical stakeholders summarizing findings and insights.  

- Address:
  - Key insights from your analysis.
  - Data quality concerns and their implications.
  - Questions and next steps for resolution.

[Email to Stakeholder](https://seed-wound-036.notion.site/Fetch-Stakeholders-Email-15172f53381d80e2a336f1c655f5f052)


