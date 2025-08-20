* https://techtfq.com/blog/solving-3-tricky-sql-interview-queries


/* 1 ) Write an SQL query to display the correct message (meaningful message) from the input
comments_and_translation table. */

drop table comments_and_translations;
create table comments_and_translations
(
	id				int,
	comment			varchar(100),
	translation		varchar(100)
);

insert into comments_and_translations values
(1, 'very good', null),
(2, 'good', null),
(3, 'bad', null),
(4, 'ordinary', null),
(5, 'cdcdcdcd', 'very bad'),
(6, 'excellent', null),
(7, 'ababab', 'not satisfied'),
(8, 'satisfied', null),
(9, 'aabbaabb', 'extraordinary'),
(10, 'ccddccbb', 'medium');
commit;


select 	CASE WHEN translation is null then comment else translation end as meaniful_comment from comments_and_translations ;

or

select COALESCE(translation,comment) as meaniful_comment from comments_and_translations ;


/* 2) Using the Source and Target table, write a query to arrive at the Output table as shown in below image. */
SELECT 
    source.id AS id,
    CASE 
        WHEN source.id NOT IN (SELECT id FROM target) 
            THEN 'NEW IN SOURCE'
    END AS comment
FROM source
WHERE source.id NOT IN (SELECT id FROM target)

UNION

SELECT 
    target.id AS id,
    CASE 
        WHEN target.id NOT IN (SELECT id FROM source) 
            THEN 'NEW IN TARGET'
    END AS comment
FROM target
WHERE target.id NOT IN (SELECT id FROM source)

UNION

SELECT 
    s.id,
    'MISMATCHED' AS comment
FROM source s
JOIN target t 
    ON s.id = t.id
WHERE s.name != t.name;


SELECT s.id, 'Mismatch' AS Comment

FROM source s

JOIN target t ON s.id = t.id AND s.name <> t.name

	UNION

SELECT s.id, 'New in source' AS Comment

FROM source s

LEFT JOIN target t ON s.id = t.id

WHERE t.id IS NULL

	UNION

SELECT t.id, 'New in target' AS Comment

FROM source s

RIGHT JOIN target t ON s.id = t.id

WHERE s.id IS NULL;



select 

case when t.id is null then s.id

	 when s.id is null then t.id

	 when (s.id=t.id and s.name <> t.name) then s.id

end as id

,case when t.id is null then 'New in source'

	 when s.id is null then 'New in target'

	 when (s.id=t.id and s.name <> t.name) then 'Mismatch'

 end as id

from source s

full join target t on t.id=s.id

where t.id is null

or s.id is null

or (s.id=t.id and s.name <> t.name)


/* 3) /* There are 10 IPL team. write an sql query such that each team play with every other team just once.

Also write another query such that each team plays with every other team twice.
*/
There are 10 IPL team. write an sql query such that each team play with every other team just once. */

drop table teams;
create table teams
    (
        team_code       varchar(10),
        team_name       varchar(40)
    );

insert into teams values ('RCB', 'Royal Challengers Bangalore');
insert into teams values ('MI', 'Mumbai Indians');
insert into teams values ('CSK', 'Chennai Super Kings');
insert into teams values ('DC', 'Delhi Capitals');
insert into teams values ('RR', 'Rajasthan Royals');
insert into teams values ('SRH', 'Sunrisers Hyderbad');
insert into teams values ('PBKS', 'Punjab Kings');
insert into teams values ('KKR', 'Kolkata Knight Riders');
insert into teams values ('GT', 'Gujarat Titans');
insert into teams values ('LSG', 'Lucknow Super Giants');
commit;


-- Each team plays with every other team JUST ONCE.

WITH matches AS

	(SELECT row_number() over(order by team_name) AS id, t.*

	 FROM teams t)

SELECT team.team_name AS team, opponent.team_name AS opponent

FROM matches team

JOIN matches opponent ON team.id < opponent.id

ORDER BY team;

-- Each team plays with every other team TWICE.

WITH matches AS

	(SELECT row_number() over(order by team_name) AS id, t.*

	 FROM teams t)

SELECT team.team_name AS team, opponent.team_name AS opponent

FROM matches team

JOIN matches opponent ON team.id <> opponent.id

ORDER BY team;