# AtliQ-Hardware-Sales-Analysis

## Problem Statement :

In this project, we performed sales insights for the India-based AtliQ Hardware company - a Data Analysis project.

AtliQ Hardware is a company that supplies computer hardware and peripherals to many clients, such as Surge Stores, Nomad Stores, etc., across India. AtliQ Hardware's head office is situated in Delhi, India, and they have many regional offices throughout the country.

The Sales Director of the company is facing several challenges as the market is growing dynamically. He is struggling to track sales in this rapidly changing market and facing issues with the growth of the business, as overall sales have been declining. He has regional managers for North, South, and Central India. Whenever he wants insights into these regions, he calls the regional managers, and they provide some verbal insights over the phone, such as sales from the last quarter and projected growth for the next quarter.

The problem is that all these interactions are verbal, with no factual proof of how the business is being affected, which frustrates him. He can see that overall sales are declining, but when he asks the regional managers, he doesn't get a complete picture of the business, especially considering AtliQ Hardware is a large company. He needs to see insights clearly and be able to make data-driven decisions to increase the sales of his company. What he wants is a simple data visualization tool that he can access daily. By using such tools and technologies, one can make data-driven decisions that help increase the company's sales.

In this project, we will help the company create its own sales-related dashboard using Power BI.

## Data Analysis using MySQL :
SQL database dump is in db_dump_version_2.sql file above. Download db_dump_version_2.sql file to your local computer

- Importing Data to MySQL workbench

The import of data is done from an already existing MySQL file. This file has to be loaded into MySQL workbench for further data analysis. 

- Analysis of data by looking into different tables and reflecting garbage values

   We can see that garbage value that the table market cantains certain values which are incorrect.

'SELECT * FROM sales.market;'

 And then we can check that transacation table we can see that certain transactions are in USD. Hence, filtration of that is also needed by converting into INR.
     
`select * from transactions where currency = 'usd';`

also finding sales amount which are less than or equal to 0.

`select * from transactions where sales_amount <=0;`

### KPIS :
1) Total Revenue :
`select sum(sales_amount) as Revenue from transactions;`

2) Total Quantity :
`select sum(sales_qty) from transactions;`

3) Total Profit Margin :
`select cast(sum(profit_margin) as decimal(10,2)) as Profit_Margin from transactions;`

### Key Insights :

4) Revenue by Market :
`select m.markets_name,sum(t.sales_amount) 
from markets as m
inner join 
transactions as t
on m.markets_code = t.market_code
group by 1
order by 2 desc;`

5) Quantity by Market :
`select m.markets_name,sum(t.sales_qty) 
from markets as m
inner join 
transactions as t
on m.markets_code = t.market_code
group by 1
order by 2 desc;`

6) Reveneue Trend Yearly:
`select year(order_date) as Year, sum(sales_amount) as Revenue from transactions group by 1;`

7) Reveneue Trend Monthly:
`select month(order_date) as Month, sum(sales_amount) as Revenue from transactions group by 1 order by 1;`

8) Top 5 Customers :
`select c.custmer_name,sum(t.sales_amount) as Revenue
from customers as c 
join transactions as t
on c.customer_code = t.customer_code
group by 1
order by 2 desc limit 5;`

9) Top 5 Products :
`select p.product_code,sum(t.sales_amount) as Revenue
from products as p 
join transactions as t
on p.product_code = t.product_code
group by 1
order by 2 desc limit 5;`

10) Profit % by market :
`select m.markets_name, round(sum(profit_margin)/sum(Sales_amount)*100,2) as Profit_Percentage
from transactions as t
join markets as m
on m.markets_code = t.market_code
group by 1
order by 2 desc;`

11) Profit % by zone :
`select m.zone, round(sum(profit_margin)/sum(Sales_amount)*100,2) as Profit_Percentage
from transactions as t
join markets as m
on m.markets_code = t.market_code
group by 1
order by 2 desc;`

## Data Cleaning and ETL (Extract, Transform, Load):
In this process, we are work on data cleaning and ETL.

 Step 1: Connect the MySQL database with the PowerBI desktop.
 
 Step 2: Loading data into the Power BI deskstop.
 This step load all the tables and created in the data base. This load option will connect with the SQL and pull all the records into power BI environment.
         
 In that model view looking up for model which form the star schema.
 
 ![Star Schema](https://github.com/user-attachments/assets/49da6eba-dfe3-43df-bb7a-53057c03e682)

Setp 3: Transform data with the help of Power Query
 
 Perform filtration in market’s table: In the tables, when we click on the "Transform Data" option, we are directed to the Power Query Editor. The Power Query Editor is where we perform our ETL (Extract, Transform, Load) processes. Here, we can perform data transformation, such as data cleaning. We need to filter the rows where the values are null by filtering the data and deselecting the "Blank" option.

 To convert USD into INR in the transaction table: AtliQ Hardware operates only in India, so having values in USD is not valid. We need to convert those USD values into INR using appropriate formulas. To do this, we will add a new column – a Conditional Column – named "Normal_sales_currency" where the sales amount will be displayed in INR.

In power query editore finding the total values having USD as currency.

`= Table.AddColumn(sales_transactions, "Normal_sales_currency", each if [currency] = "USD"  then [sales_amount]* 65 else [sales_amount])`

 using this correct formula of the conversion,and converted the USD currency into INR.

## Data Modeling:

And then dataset was cleaned and transformed, it was ready to the data modeled.

The sales insights data tables as show below:

![clean data schemas](https://github.com/user-attachments/assets/9c9bbccc-3c0d-4125-8369-804e2c9520b6)

## Data Analysis  (DAX):

Measures used in all visualization are:

Base Measures:
    
  - Profit % = `DIVIDE([Total Profit Margin],[Revenue])`
  - Profit Contribution % = `DIVIDE([Total Profit Margin],CALCULATE([Total Profit Margin],ALL('sales products'),ALL('sales customers'),ALL('sales markets')))`
  - Revenue = `SUM('sales transactions'[Normal_sales_currency])`
  - Revenue Contribution % = `DIVIDE([Revenue],CALCULATE([Revenue],ALL('sales products'),ALL('sales customers'),ALL('sales markets')))`
  - Revenue LY = `CALCULATE([Revenue],SAMEPERIODLASTYEAR('sales date'[date]))`
  - Sales quntity = `SUM('sales transactions'[sales_qty])`
  - Total Profit Margin = `SUM('sales transactions'[profit_margin])`

Profit Target:
  
  - Profit Target1 = `GENERATESERIES(-0.05, 0.15, 0.01)`
  - Profit Target Value = `SELECTEDVALUE('Profit Target 1'[Profit Target])`
  - Target Diff = [Profit %] - 'Profit Target 1'[Profit Target Value]`

## Build Dashboard Or a Report:

Data visualization for the data analysis (DAX) was done in Microsoft Power BI Desktop:

Shows visualizations from Sales insights :

| Key Insights |
| ----------- |
|![Key Insights](https://github.com/user-attachments/assets/77acb858-cf7e-474b-afb2-48638d8b7f51)|

| Profit Analysis |
| ----------- |
|![Profit Analysis](https://github.com/user-attachments/assets/a8667d44-3670-4fc8-9d5a-0ecbc353b0b3)|


| Performace Insights |
| ----------- |
|![Performance Insights](https://github.com/user-attachments/assets/df303de4-3f93-4c8d-9a6e-ec06358f8b03)|

## Tools, Software and Libraries :

1.MySQL

2.Microsoft Power BI

3.Power Query Editor

3.DAX Language 

## Contribution :
Feel free to contribute by enhancing the data analysis techniques, adding more complex visualizations, or suggesting improvements to the overall analysis.
