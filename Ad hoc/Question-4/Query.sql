with top_bottom as (
select
	c.city_name as city_name,
    sum(fps.new_passengers) as new_passengers,
    dense_rank() over(order by sum(fps.new_passengers) desc) as Top_3,
    dense_rank() over(order by sum(fps.new_passengers) asc) as Bottom_3
from fact_passenger_summary fps
inner join dim_city c
on fps.city_id = c.city_id
group by city_name
)

select
	city_name,
    new_passengers,
    (case 
		when Top_3 <= 5 then "Top_5" 
        when Bottom_3 <= 5 then "Bottom_5"
	end ) as category
from top_bottom
order by new_passengers desc