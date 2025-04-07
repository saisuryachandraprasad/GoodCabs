-- City-Level fare and Trip summary report

select
	c.city_name,
    count(t.trip_id) as total_trips,
    round((sum(t.fare_amount)/sum(t.distance_travelled_km)),2) as avg_fare_per_km,
    round((sum(t.fare_amount)/count(t.trip_id)),2) as avg_fare_per_trip,
    round(count(t.trip_id)*100.0/(select count(*) from fact_trips),2) as total_trips_contribution_pct    
from fact_trips t
join dim_city c
on t.city_id = c.city_id
group by c.city_name