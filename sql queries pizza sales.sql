select * from [dbo].[pizza_sales]


--- KPI's
-- Total revenue of pizza
select sum(total_price) as Total_Revenue from pizza_sales

--Average order value 
select sum(total_price)/ count(distinct(order_id)) as Average_order_value  from pizza_sales

-- Total pizza sold

select sum(quantity) as total_pizza_sold from pizza_sales

--total orders

select count(distinct order_id) as total_orders from pizza_sales

-- Average pizza per order

select cast(cast(sum(quantity)as decimal(10,2))/cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2))as [Average pizza per order] from pizza_sales

--CHARTS REQUIREMENTS----

-- Daily Trend for total orders

select Datename(DW,order_date) as order_day ,count(distinct order_id) as Total_Orders 
from pizza_sales
group by  Datename(DW,order_date)


-- Monthly trend for total orders

select Datename(month,order_date) as month_name ,count(distinct order_id) as Total_Orders 
from pizza_sales
group by  Datename(month,order_date)
order by Total_Orders desc

--percentage of sales by pizza category


select * from [dbo].[pizza_sales]

select pizza_category,sum(total_price) as total_sales, cast(sum(total_price)*100/(select sum(total_price) from pizza_sales where month(order_date)=1) as decimal(10,2)) as[percentage of sales by pizza category] 
from pizza_sales
where month(order_date)=1
group by pizza_category

--percentage of sales by pizza size

select pizza_size,cast(sum(total_price) as decimal(10,2)) as total_price, cast(sum(total_price)*100/(select sum(total_price) from pizza_sales where datepart(quarter,order_date)=1) as decimal(10,2)) as [percentage of sales by pizza size]  from pizza_sales
where datepart(quarter,order_date)=1
group by pizza_size
order by [percentage of sales by pizza size] desc

-- total pizzas sold by pizza category

select pizza_category,sum(quantity) as [no of pizzas] from pizza_sales 
group by pizza_category
order by [no of pizzas] desc

-- Top 5 best sellers by revenue,total quantity and total orders


select top 5 pizza_name ,sum(total_price) as [total revenue] from pizza_sales 
group by pizza_name
order by [total revenue] desc

select top 5 pizza_name ,sum(quantity) as [total quantity]  from pizza_sales 
group by pizza_name
order by [total quantity] desc

select top 5 pizza_name ,count(distinct order_id) as [total orders]  from pizza_sales 
group by pizza_name
order by [total orders] desc


-- bottom 5  sellers by revenue,total quantity and total orders

select top 5 pizza_name ,sum(total_price) as [total revenue] from pizza_sales 
group by pizza_name
order by [total revenue] asc

select top 5 pizza_name ,sum(quantity) as [total quantity]  from pizza_sales 
group by pizza_name
order by [total quantity] asc

select top 5 pizza_name ,count(distinct order_id) as [total orders]  from pizza_sales 
group by pizza_name
order by [total orders] asc