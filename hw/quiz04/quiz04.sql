create table pizzas as
  select "Pizzahhh" as name, 12 as open, 15 as close union
  select "La Val's"        , 11        , 22          union
  select "Sliver"          , 11        , 20          union
  select "Cheeseboard"     , 16        , 23          union
  select "Emilia's"        , 13        , 18;

create table meals as
  select "breakfast" as meal, 11 as time union
  select "lunch"            , 13         union
  select "dinner"           , 19         union
  select "snack"            , 22;

-- Two meals at the same place
create table double as
with double_meal(early, later, early_time, later_time) as (
	select a.meal, b.meal, a.time, b.time from meals as a, meals as b where a.time < b.time and b.time - a.time > 6
)
select early, later, name from double_meal, pizzas where early_time >= open and later_time <= close;


-- Pizza options for every meal
create table options as
with opts(m, t, last_add, num, str) as (
	select meal, time, name, 1, name from meals, pizzas where time >= open and time <= close union
	select m, t, name, num + 1, str || ", " || name from opts, pizzas where name > last_add and t >= open and t <= close
)
select m as meal, max(num), str from opts group by m order by t;


