SELECT m.missionID, m.rocketType, COUNT(c.contractID) AS numPremium, AVG(c.price) AS avgPremiumPrice
FROM Mission m, Contract c
WHERE m.missionID = c.missionID
    AND c.price >= 90000
    AND c.priority = 'H'
GROUP BY m.missionID, m.rocketType
ORDER BY m.missionID;

/*
 missionid | rockettype | numpremium |  avgpremiumprice   
-----------+------------+------------+--------------------
       101 | Falcon 9   |         32 | 94942.187500000000
       102 | Falcon 9   |         31 | 95182.258064516129
       103 | Ariane 6   |         31 | 94846.774193548387
       104 | Starship   |         31 | 94953.225806451613
       105 | Soyuz 2    |         30 | 94775.000000000000
       106 | H3         |         31 | 95016.129032258065
       107 | PSLV       |         30 | 94935.000000000000
       108 | New Glenn  |         33 | 95045.454545454545
       109 | Starship   |         29 | 94958.620689655172
       110 | Falcon 9   |         32 | 94900.000000000000
       111 | Falcon 9   |         28 | 95016.071428571429
       112 | Ariane 6   |         32 | 94907.812500000000
       113 | Falcon 9   |         30 | 95200.000000000000
(13 rows)
*/

EXPLAIN ANALYZE
SELECT m.missionID, m.rocketType, COUNT(c.contractID) AS numPremium, AVG(c.price) AS avgPremiumPrice
FROM Mission m, Contract c
WHERE m.missionID = c.missionID
    AND c.price >= 90000
    AND c.priority = 'H'
GROUP BY m.missionID, m.rocketType
ORDER BY m.missionID;

/* HOW CONTRACT WAS SCANNED:
Parallel Seq Scan on Contract c
Execution Time 10.424ms
*/

CREATE INDEX ContractIndex
ON Contract(priority, price);

/*
 missionid | rockettype | numpremium |  avgpremiumprice
-----------+------------+------------+--------------------
       101 | Falcon 9   |         32 | 94942.187500000000
       102 | Falcon 9   |         31 | 95182.258064516129
       103 | Ariane 6   |         31 | 94846.774193548387
       104 | Starship   |         31 | 94953.225806451613
       105 | Soyuz 2    |         30 | 94775.000000000000
       106 | H3         |         31 | 95016.129032258065
       107 | PSLV       |         30 | 94935.000000000000
       108 | New Glenn  |         33 | 95045.454545454545
       109 | Starship   |         29 | 94958.620689655172
       110 | Falcon 9   |         32 | 94900.000000000000
       111 | Falcon 9   |         28 | 95016.071428571429
       112 | Ariane 6   |         32 | 94907.812500000000
       113 | Falcon 9   |         30 | 95200.000000000000
(13 rows)
*/

EXPLAIN ANALYZE
SELECT m.missionID, m.rocketType, COUNT(c.contractID) AS numPremium, AVG(c.price) AS avgPremiumPrice
FROM Mission m, Contract c
WHERE m.missionID = c.missionID
    AND c.price >= 90000
    AND c.priority = 'H'
GROUP BY m.missionID, m.rocketType
ORDER BY m.missionID;

/* SECOND PASS ON CONTRACT
Bitmap Heap Scan on Contract c
Execution Time 0.703ms
*/

/* REFLECTION
The result of the query did not change after the index was created. 
Our query execution time improved by nearly 15x compared to previously.
This is probably because the previous method relied entirely on linear scanning across all tables.
That doesn't exactly scale well when you have a database with 200k+ rows.
An index speeds things up because you don't waste time on unnecessary lookups.
*/