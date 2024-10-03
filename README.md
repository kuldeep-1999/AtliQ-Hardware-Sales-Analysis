# AtliQ-Hardware-Sales-Analysis

## Problem Statement :

In this project performed India based AtliQ hardware company sales insights - A Data Analysis project. 

AtliQ Hardware is a company which supplies computer hardware and peripherals to many of clients such as surge stores, Nomad stores etc. across India. AtliQ Hardware head office is situated in Delhi, India and they have many regional office through out the India.

Sales director for this company is facing a lot of challenges is this the market is growing dynamically and sales director is facing issue in terms of tracking the sales in this dynamical growth market and he is having issues with growth of this bussiness, as overall sales was declining. He has regional manager for North India, South and Central India. Whenever he wants to get insights of thses region he would call these people and on the phone regional manager give some insights to him that this was the sales last quarter and we are going to grow by this much in the next quarter.

The problem was that all thses thing happening is verbal and these was mo proof with facts that how his business is affected and which made him frustraed as he can see that overall sales is declining but when he can ask regional manager, he is not getting complete picture of this bussiness and when he and this AtliQ hardware is big business. so to see insights clearly. and he will get proper insights anbd can take data driven decision to increase sales of hos company.
All he wants is a simple data visualization tool which he can access on daily basis. By using such tools and technology one can make data driven decisiions which helps to increase the sales of the company. So, In this projects we will help a company make its own sales related dashboard using Power BI.

## Data Analysis using MySQL :
SQL database dump is in db_dump_version_2.sql file above. Download db_dump_version_2.sql file to your local computer

- Importing Data to MySQL workbench
- 
The import of data is done from an already existing MySQL file. This file has to be loaded into MySQL workbench for further data analysis. 

- Analysis of data by looking into different tables and reflecting garbage values

   We can see that garbage value that the table market cantains certain values which are incorrect.

'SELECT * FROM sales.market;'

 And then we can check that transacation table we can see that certain transactions are in USD. Hence, filtration of that is also needed by converting into INR.
     
select * from transactions where currency = 'usd';

also finding sales amount which are less than or equal to 0.

select * from transactions where sales_amount <=0;

# KPIS :
-- 1) Total Revenue :
select sum(sales_amount) as Revenue from transactions;

-- 2) Total Quantity :
select sum(sales_qty) from transactions;

-- 3) Total Profit Margin :
select cast(sum(profit_margin) as decimal(10,2)) as Profit_Margin from transactions;

# Key Insights :

-- 4) Revenue by Market :
select m.markets_name,sum(t.sales_amount) 
from markets as m
inner join 
transactions as t
on m.markets_code = t.market_code
group by 1
order by 2 desc;

-- 5) Quantity by Market :
select m.markets_name,sum(t.sales_qty) 
from markets as m
inner join 
transactions as t
on m.markets_code = t.market_code
group by 1
order by 2 desc;

-- 6) Reveneue Trend Yearly:
select year(order_date) as Year, sum(sales_amount) as Revenue from transactions group by 1;

-- 7) Reveneue Trend Monthly:
select month(order_date) as Month, sum(sales_amount) as Revenue from transactions group by 1 order by 1;

-- 8) Top 5 Customers :
select c.custmer_name,sum(t.sales_amount) as Revenue
from customers as c 
join transactions as t
on c.customer_code = t.customer_code
group by 1
order by 2 desc limit 5;

-- 8) Top 5 Products :
select p.product_code,sum(t.sales_amount) as Revenue
from products as p 
join transactions as t
on p.product_code = t.product_code
group by 1
order by 2 desc limit 5;

-- 9) Profit % by market :
select m.markets_name, round(sum(profit_margin)/sum(Sales_amount)*100,2) as Profit_Percentage
from transactions as t
join markets as m
on m.markets_code = t.market_code
group by 1
order by 2 desc;

-- 10) Profit % by zone :
select m.zone, round(sum(profit_margin)/sum(Sales_amount)*100,2) as Profit_Percentage
from transactions as t
join markets as m
on m.markets_code = t.market_code
group by 1
order by 2 desc;

## Data Cleaning and ETL (Extract, Transform, Load):
In this process, we are work on data cleaning and ETL.

 Step 1: Connect the MySQL database with the PowerBI desktop.
 
 Step 2: Loading data into the Power BI deskstop.
 This step load all the tables and created in the data base. This load option will connect with the SQL and pull all the records into power BI environment.
         
 In that model view looking up for model which form the star schema.
 
 ![Star Schema](https://github.com/user-attachments/assets/49da6eba-dfe3-43df-bb7a-53057c03e682)

Setp 3: Transform data with the help of Power Query
 
 Perform filtration in market’s table: In the tables perform when we click on the transform data option, we are directed to Power query editor. Power query editor is where we perform out ETL.and then we can perform data transformation i.e. Data Cleaning. we need to filter the rows where the values are null and filtering the data and deselecting the blank option. 

 Perform filtration in Transaction’s table: In the table perform when we check the query in the MySQL to filter some ne,we have deselecting the values, don’t want in the table. The result after filtration. the zero values represent some garbage values which is not possible so we need to clean that data.

Convert USD into INR in the transaction’s table: the AtliQ Hardware only works in India so the USD values are not possible. we need to convert those USD values into INR by using some formulas. Add new column - Conditional column - normalized currency where sales amount will be in INR

In power query editore finding the total values having USD as currency.
