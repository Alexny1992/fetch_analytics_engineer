
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

[Data Schema](https://github.com/Alexny1992/fetch_analytics_engineer/blob/main/data_schema.jpg)
**Tools**: Lucidchart, Excel sheet

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
3. Document findings and recommendations in a markdown file (`data_quality.md`).

**Deliverables**:
- Code used for evaluation (e.g., `data_quality_check.py`).
- A report (`data_quality.md`) summarizing:
  - Identified issues
  - Methods of discovery
  - Recommendations for resolution

---

### **4. Stakeholder Communication**
**Objective**: Compose a concise and clear message for non-technical stakeholders summarizing findings and insights.  

- Address:
  - Key insights from your analysis.
  - Data quality concerns and their implications.
  - Questions and next steps for resolution.

[Email to Stakeholder](https://seed-wound-036.notion.site/Fetch-Stakeholders-Email-15172f53381d80e2a336f1c655f5f052)
---

## **Evaluation Criteria**
- **Data Modeling**: Schema design clarity and alignment with business needs.
- **SQL Queries**: Accuracy, performance, and ability to answer business questions.
- **Data Quality Evaluation**: Depth of insights and recommendations.
- **Communication**: Clarity and professionalism in stakeholder messaging.
- **Code and Documentation**: Organization, readability, and reproducibility.

---

## **Example Repository Structure**
