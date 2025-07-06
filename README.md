
# 📊 Ubereats_And_Grabhub_Case_Study

This project is a SQL-based data analysis case study focused on identifying **Business Hour Mismatches** between restaurants listed on **UberEats** and **Grubhub**. [More Details](https://loopxyz.notion.site/Analyzing-the-Impact-of-Business-Hour-Mismatch-on-Order-Volume-in-the-Food-Delivery-Industry-A-Case-789fa5edadc84032a6f53b1e23790451)

---

## 🔍 Objective

To analyze and quantify inconsistencies in store business hours across two major food delivery platforms—UberEats and Grubhub. We treat **UberEats as the ground truth** and check if Grubhub's hours deviate from that standard.


---

## 🛠️ Data Sources

Sample datasets available on Google BigQuery:

| Platform | Table |
|----------|-------|
| UberEats | `arboreal-vision-339901.take_home_v2.virtual_kitchen_ubereats_hours` |
| Grubhub  | `arboreal-vision-339901.take_home_v2.virtual_kitchen_grubhub_hours`  |

To preview the data, run:
```sql
SELECT * FROM `arboreal-vision-339901.take_home_v2.virtual_kitchen_ubereats_hours` LIMIT 1000;
SELECT * FROM `arboreal-vision-339901.take_home_v2.virtual_kitchen_grubhub_hours` LIMIT 1000;
````

---

## 🧾 Files

| File Name                            | Description                                                              |
| ------------------------------------ | ------------------------------------------------------------------------ |
| `Final_join_query.sql`               | Final SQL query to compute mismatches between UberEats and Grubhub hours |
| `Grabhub_table_query.sql`            | Extract and transform Grubhub store hours from JSON                      |
| `Ubereats_table_query.sql`           | Extract and transform UberEats store hours from JSON                     |
| `Result_Of_Final_Join_Query.csv`     | Output result of the final query with mismatch classification            |
| `Result_Of_Grabhub_Table_Query.csv`  | Flattened and parsed Grubhub store hours                                 |
| `Result_Of_Ubereats_Table_Query.csv` | Flattened and parsed UberEats store hours                                |
| `README.md`                          | Project documentation and objective                                      |

---

## 🧮 Metric Computed

**Business Hour Mismatch Status** between Grubhub and UberEats for each restaurant:

| Status                                | Meaning                                 |
| ------------------------------------- | --------------------------------------- |
| `In Range`                            | Grubhub hours are within UberEats hours |
| `Out of Range with 5 mins difference` | Slight mismatch (\~5 min buffer)        |
| `Out of Range`                        | Significant mismatch                    |

---

## 🧰 Technologies Used

* Google BigQuery
* Standard SQL
* JSON Parsing using BigQuery JSON functions
* CSV output for results

---

## 📈 Sample Output Schema

| Grubhub Slug              | Grubhub Hours     | UberEats Slug             | UberEats Hours     | is\_out\_range |
| ------------------------- | ----------------- | ------------------------- | ------------------ | -------------- |
| johnspizz\_sicilianpi\_gh | 9:00 AM - 9:00 PM | johnspizz\_sicilianpi\_ue | 9:00 AM - 10:00 PM | In Range       |

---

## 🧪 How to Run

1. Use BigQuery sandbox (no credit card needed):
   [BigQuery Sandbox](https://cloud.google.com/bigquery/docs/sandbox)

2. Open each SQL file and execute in BigQuery to transform and join the datasets.

3. Review the final output and CSV files for mismatch analysis.

---
