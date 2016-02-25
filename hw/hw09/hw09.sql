create table parents as
  select "abraham" as parent, "barack" as child union
  select "abraham"          , "clinton"         union
  select "delano"           , "herbert"         union
  select "fillmore"         , "abraham"         union
  select "fillmore"         , "delano"          union
  select "fillmore"         , "grover"          union
  select "eisenhower"       , "fillmore";

create table dogs as
  select "abraham" as name, "long" as fur, 26 as height union
  select "barack"         , "short"      , 52           union
  select "clinton"        , "long"       , 47           union
  select "delano"         , "long"       , 46           union
  select "eisenhower"     , "short"      , 35           union
  select "fillmore"       , "curly"      , 32           union
  select "grover"         , "short"      , 28           union
  select "herbert"        , "curly"      , 31;

create table sizes as
  select "toy" as size, 24 as min, 28 as max union
  select "mini",        28,        35        union
  select "medium",      35,        45        union
  select "standard",    45,        60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
create table size_of_dogs as
select name, size from dogs, sizes where height > min and height <= max;


-- All dogs with parents ordered by decreasing height of their parent
create table by_height as
select child from parents, dogs where parent = name order by -height;


-- Sentences about siblings that are the same size
create table sentences as
with siblings(sib1, sib2) as (
	select a.child, b.child from parents as a, parents as b where a.parent = b.parent and a.child < b.child
  )
select sib1 || " and " || sib2 || " are " || s1.size || " siblings" from siblings, size_of_dogs as s1, size_of_dogs as s2 where sib1 = s1.name and sib2 = s2.name and s1.size = s2.size;

-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
create table stacks as
with dog_filter(name, height) as (
	select name, height from dogs
),
dog_stack(dog_name, num, last_dogs_height, total_height) as (
	select name, 1, height, height from dog_filter union
	select dog_name || ", " || name, num+1, height, total_height + height from dog_stack, dog_filter where num < 4 and last_dogs_height < height
)
select dog_name, total_height from dog_stack where num = 4 and total_height > 170 order by total_height;


create table tallest as
with tall(name, height, tens) as (
	select name, height, height / 10 from dogs
)
select max(height), name from tall group by tens having count(*) > 1;


-- All non-parent relations ordered by height difference
create table non_parents as
select "REPLACE THIS LINE WITH YOUR SOLUTION";


