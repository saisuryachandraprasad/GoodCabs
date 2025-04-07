with monthly_aggregation  as (
select
	c.city_name,
    date_format(date,"%M") month,
    sum(fare_amount) as revenue,
    sum(sum(fare_amount)) over(partition by city_name) as total_revenue
from fact_trips ft
inner join dim_city c
on ft.city_id = c.city_id
group by c.city_name, date_format(date,"%M")
),
monthly_revenue_rank as (
select
	city_name,
    month,
    revenue,
    total_revenue,
    rank() over(partition by city_name order by revenue desc) as salary_rank
from monthly_aggregation
)
select
	city_name,
    month,
    revenue,
    total_revenue,
    round((revenue * 100) / total_revenue,2) as pct_contribution
from monthly_revenue_rank
where salary_rank = 1
order by revenue desc, pct_contribution desc