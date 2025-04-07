-- Monthly City-Level Trips Target Performance Report

with base as (
select
	t.city_id ,
	c.city_name,
    d.month_name,
    d.start_of_month as month,
    count(t.trip_id) as actual_trips,
    mt.total_target_trips as target_trips
from fact_trips t
left join dim_city c
on t.city_id = c.city_id
left join dim_date d
on t.date = d.date
join targets_db.monthly_target_trips mt
on t.city_id = mt.city_id 
and d.start_of_month = mt.month
group by t.city_id,city_name,d.month_name,d.start_of_month
)
select
	city_name,
    month_name,
    actual_trips,
    target_trips,
    (case
		when actual_trips > target_trips then "Above Target" else "Below Target" 
	end ) as performance_status,
    round(((actual_trips - target_trips)*100/target_trips),2) as difference_pct
from base
	
