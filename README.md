# -Commit_the_Query
# SQL Window Functions Project

## 👥 Team Project
This repository contains our work on SQL Window Functions, built using a regular sales dataset.

## 📘 Objectives
- Practice SQL Window Functions: `LAG()`, `LEAD()`, `RANK()`, `DENSE_RANK()`, `ROW_NUMBER()`, and aggregate `SUM() OVER`.
- Explain real-life applications of each.
- Collaborate as a team and track individual contributions.

## 🗃️ Dataset
A fictional `sales` table with `customer_id`, `sale_date`, and `sale_amount`.

## 📂 Structure
- `dataset/`: Sample dataset in SQL format.
- `queries/`: Window function SQL queries.
- `explanations/`: Explanations of queries and their real-world use cases.
- `screenshots/`: Output screenshots (if any).

## 🧑‍💻 Collaborators
- Student A (GitHub: @Alec-manzi02)
- Student B (GitHub: @AmaniShema)

## ✅ Instructor Access
Collaborator: @ericmaniraguha

##  THE QUERIES AND THE EXPLANATION
### Note that we didn't use Oracle database because it was not working properly, but instead we used an online tool called OneCompiler
### You can visit it here 👉 https://onecompiler.com/oracle

-   This is the table we used
-![query](https://github.com/user-attachments/assets/34f54bd7-c41e-49ca-b96e-5a71960cc558)
-![Capture](https://github.com/user-attachments/assets/58c43d35-6328-4cda-9306-3b35832fc359)
-![2](https://github.com/user-attachments/assets/492601d1-8fdc-46c1-a485-d629c1e90de6)
- 1. Compare Values with Previous or Next Records
     ![1](https://github.com/user-attachments/assets/65f846f1-8ae0-4ca1-9513-c400cada5c35)
     ![2](https://github.com/user-attachments/assets/c959af74-486c-462d-90ce-7e5acd3b2b44)
     ![3](https://github.com/user-attachments/assets/7f0c9651-6bcd-474c-a967-5bc1efd18495)
     ![4](https://github.com/user-attachments/assets/a26a5939-e13a-4a16-89be-7346b0795b2f)

- Explanation:
- LAG (Amount, 1, NULL) OVER (ORDER BY SaleDate): This function retrieves the value of the 'Amount' column from the previous row within the entire dataset, ordered by 'SaleDate'.
The '1' specifies that we want to look one row back.
'NULL' is the default value if there is no previous row (for the first record).
LEAD(Amount, 1, NULL) OVER (ORDER BY SaleDate): This function retrieves the value of the 'Amount' column from the next row within the entire dataset, ordered by 'SaleDate'.
The '1' specifies that we want to look one row forward.
'NULL' is the default value if there is no next row (for the last record).
The CASE statements then compare the current 'Amount' with the 'PreviousAmount' and 'NextAmount' to determine if it's HIGHER, LOWER, or EQUAL.

- 2. Ranking Data within a Category (Ranking by Amount within each Region)
     ![1](https://github.com/user-attachments/assets/fc268ece-8846-4cca-9b77-69cf273747d1)
     ![2](https://github.com/user-attachments/assets/52b28d4b-6dcb-4136-ad27-0a159359b1a8)
     ![3](https://github.com/user-attachments/assets/5d7f12eb-a6ca-43b1-b966-1a1005ea2345)
    ![4](https://github.com/user-attachments/assets/b307fe29-d86c-4372-abfe-4a2778838ab6)
Explanation:
RANK() OVER (PARTITION BY Region ORDER BY Amount DESC): This function assigns a rank to each row within each 'Region' based on the 'Amount' in descending order (highest amount gets rank 1).
PARTITION BY Region: This divides the data into partitions based on the unique values in the 'Region' column. The ranking is performed independently within each region.
ORDER BY Amount DESC: This specifies the order for ranking within each partition. 'DESC' means ranking from highest to lowest amount.
DENSE_RANK() OVER (PARTITION BY Region ORDER BY Amount DESC): This function also assigns a rank within each 'Region' based on 'Amount', but it does not skip ranks when there are ties.
Difference between RANK() and DENSE_RANK():
RANK(): If there are ties, RANK() assigns the same rank to all tied rows and then skips the subsequent ranks. For example, if two records have the same highest amount and get rank 1, the next rank will be 3.
DENSE_RANK(): If there are ties, DENSE_RANK() assigns the same rank to all tied rows, but the subsequent rank is the next consecutive integer. In the same example, if two records have the same highest amount and get rank 1, the next rank will be 2.

- 3. Identifying Top Records (Top 2 highest sales per Region
![1](https://github.com/user-attachments/assets/06ecc96f-1f8d-45a9-80c0-460021fbc7ed)
![2](https://github.com/user-attachments/assets/76ddc736-d874-46fd-8c08-02885e99ef2d)

-Explanation:
We use a Common Table Expression (CTE) called 'RankedSales' to first rank the sales within each region based on the 'Amount' in descending order.
The outer SELECT statement then retrieves the records from the 'RankedSales' CTE where the 'AmountRankWithinRegion' is less than or equal to 2, effectively giving us the top 2 highest sales in each region.
Using RANK() handles duplicate values appropriately because if multiple sales have the same (high) amount, they will all receive the same rank and will be included in the top 2 if their rank meets the condition.
- 4. Finding the Earliest Records (First sale transaction per Region)
  ![1](https://github.com/user-attachments/assets/7d2487d5-c969-40af-ae06-8e5824191ba1)

- Explanation:
Similar to the previous query, we use a CTE called 'RankedSalesByDate'.
Inside the CTE, we rank the sales transactions within each 'Region' based on the 'SaleDate' in ascending order (earliest date gets rank 1).
The outer SELECT statement then filters the results to include only the records where 'SaleDateRankWithinRegion' is less than or equal to 1, thus retrieving the first sale transaction for each region.
If multiple sales occurred on the exact same earliest date within a region, they will all receive a rank of 1 and will be included in the result.

- 5. Aggregation with Window Functions
    ![1](https://github.com/user-attachments/assets/eb2c8b13-04dd-49a2-a2f6-e81ec51567c0)
    ![2](https://github.com/user-attachments/assets/585b5727-cc64-4c42-afcb-9c84d83f7e08)
    ![3](https://github.com/user-attachments/assets/1c40db28-dac3-4b96-8277-5b34005e054f)
    ![4](https://github.com/user-attachments/assets/168ff692-5863-4d5c-adfe-e7ef843b404c)

- Explanation:
MAX(Amount) OVER (PARTITION BY Region): This window function calculates the maximum 'Amount' within each 'Region'.
PARTITION BY Region: This ensures that the maximum is calculated separately for each unique 'Region'.
MAX(Amount) OVER (): This window function calculates the maximum 'Amount' across the entire 'SalesTable' dataset, without any partitioning. This gives us the overall maximum sales amount.
By including these window functions in the SELECT statement along with all the original columns, we can see each individual sales record along with the maximum sale amount in its region and the overall maximum sale amount.
