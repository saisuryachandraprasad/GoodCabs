select
	c.city_name,
    date_format(fps.month, "%M") as month,
    fps.total_passengers,
    fps.repeat_passengers,
    round((fps.repeat_passengers * 100) / fps.total_passengers,2) as monthly_repeat_passenger_pct,
    round(sum(fps.repeat_passengers) over(partition by c.city_name) * 100 / 
					sum(fps.total_passengers) over(partition by c.city_name) , 2) as city_repeat_passenger_pct
from fact_passenger_summary fps
inner join dim_city c
on fps.city_id = c.city_id
order by c.city_name,monthly_repeat_passenger_pct desc