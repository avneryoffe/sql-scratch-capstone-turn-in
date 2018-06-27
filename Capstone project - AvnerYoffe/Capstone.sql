question 1:
SELECT * FROM survey

Question 2:
SELECT question,  COUNT(*) FROM survey
GROUP BY question;


Question 4:
select * from quiz limit 5;
select * from home_try_on limit 5;
select * from purchase limit 5;


Question 5:
select distinct quiz.user_id,
CASE
WHEN home_try_on.user_id IS NOT NULL 
THEN 'True'
ELSE 'False'
END AS 'is_home_try_on',
CASE
WHEN home_try_on.number_of_pairs = '3 pairs'
THEN 3
WHEN home_try_on.number_of_pairs = '5 pairs'
THEN 5
ELSE NULL
END AS number_of_pairs,
CASE
WHEN purchase.user_id IS NOT NULL 
THEN 'True'
ELSE 'False'
END AS 'is_purchase'
from quiz
LEFT join home_try_on
on quiz.user_id = home_try_on.user_id
LEFT join purchase
on home_try_on.user_id = purchase.user_id;


Question 6:

with conclusions AS (
select distinct quiz.user_id,
home_try_on.user_id IS NOT NULL AS 'is_home_try_on',
CASE
WHEN home_try_on.number_of_pairs = '3 pairs'
THEN 3
WHEN home_try_on.number_of_pairs = '5 pairs'
THEN 5
ELSE NULL
END AS number_of_pairs,
purchase.user_id IS NOT NULL AS 'is_purchase'
from quiz
LEFT join home_try_on
on quiz.user_id = home_try_on.user_id
LEFT join purchase
on home_try_on.user_id = purchase.user_id)
select
1.0 * sum(is_home_try_on) / count(*) as '%_home_from_quiz',
1.0 * sum(is_purchase) / count(*) as '%_Purchase_from_quiz',
1.0 * SUM(CASE WHEN number_of_pairs = 3 THEN 1 END) / COUNT(*) AS '3_pairs_grp_purchase%',
1.0 * SUM(CASE WHEN number_of_pairs = 5 THEN 1 END) / COUNT(*) AS '5_pairs_grp_purchase%',
1.0 * SUM(is_purchase) / sum(is_home_try_on) AS '%_purchase_from_home_try'
from conclusions;