create database project;
use project ;

# Total Revenue
select sum(revenue_realized) as "Total Revenue" from fact_bookings;

#Occupancy
Select Concat(round((sum(successful_bookings)/sum(capacity))*100,2),'%') from fact_aggregated_bookings;

#Cancellation rate
Select Concat(round(sum(booking_status='Cancelled')*100/Count(*),2),'%') as Cancellation_percent from fact_bookings;

#Total Bookings
Select sum(successful_bookings) from fact_aggregated_bookings;

#Utilized Capacity
Select (Select sum(booking_status='checked out') from fact_bookings)*100.0/(select sum(capacity) from fact_aggregated_bookings) as Utilize_Capacity; 

#Reveue by state and hotel
select dh.Property_name, dh.city,sum(fb.revenue_realized) as Total_revenue from fact_bookings as fb join dim_hotels as dh 
on fb.property_id=dh.property_id group by dh.property_name,dh.city;

#Booking Status
Select booking_status,count(*) as Count from fact_bookings group by booking_status;

#weekend and weekday revenue
select case when dayofweek(booking_date) in (1,7) then 'Weekend'else 'Weekday'end as day_type,sum(revenue_realized) as Total_Revenue,
count(*) as Total_Bookings from fact_bookings group by Day_Type;

#Class Wise Revenue
Select dr.room_class,sum(fb.revenue_realized) as revenue from fact_bookings fb join dim_rooms dr on fb.room_category=dr.room_id group by dr.room_class;



