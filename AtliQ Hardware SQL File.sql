use sales;
Select * from transactions;

select * from transactions where sales_amount <=0;

select * from transactions where currency = 'usd';

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
select product_code,sum(sales_amount) as Revenue 
from transactions 
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