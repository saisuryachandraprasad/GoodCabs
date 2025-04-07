with base as (
select
	c.city_name as city_name,
    rtd.trip_count as trip_count,
    rtd.repeat_passenger_count  as repeat_passenger_count 
from dim_repeat_trip_distribution rtd
inner join dim_city c
on rtd.city_id = c.city_id
),
aggregated as (
select
	city_name,
    sum(repeat_passenger_count) as total_passenger,
    sum(case when trip_count = "2-Trips" then repeat_passenger_count end ) as trips_2,
    sum(case when trip_count = "3-Trips" then repeat_passenger_count end ) as trips_3,
    sum(case when trip_count = "4-Trips" then repeat_passenger_count end ) as trips_4,
    sum(case when trip_count = "5-Trips" then repeat_passenger_count end ) as trips_5,
    sum(case when trip_count = "6-Trips" then repeat_passenger_count end ) as trips_6,
    sum(case when trip_count = "7-Trips" then repeat_passenger_count end ) as trips_7,
    sum(case when trip_count = "8-Trips" then repeat_passenger_count end ) as trips_8,
    sum(case when trip_count = "9-Trips" then repeat_passenger_count end ) as trips_9,
    sum(case when trip_count = "10-Trips" then repeat_passenger_count end ) as trips_10
from base
group by city_name
)
select
	city_name,
    round((trips_2 * 100) / total_passenger,2) as "2-Trips",
    round((trips_3 * 100) / total_passenger,2) as "3-Trips",
    round((trips_4 * 100) / total_passenger,2) as "4-Trips",
    round((trips_5 * 100) / total_passenger,2) as "5-Trips",
    round((trips_6 * 100) / total_passenger,2) as "6-Trips",
    round((trips_7 * 100) / total_passenger,2) as "7-Trips",
    round((trips_8 * 100) / total_passenger,2) as "8-Trips",
    round((trips_9 * 100) / total_passenger,2) as "9-Trips",
    round((trips_10 * 100) / total_passenger,2) as "10-Trips"
from aggregated
    