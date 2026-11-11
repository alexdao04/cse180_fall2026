SELECT missionID, rocketType, totalContracts, totalRevenue / totalContracts AS avgRevenuePerContract
FROM RideshareMissionView;

/* RESULTS OF QUERY 1:
 missionid | rockettype | totalcontracts | avgrevenuepercontract 
-----------+------------+----------------+-----------------------
       104 | Starship   |              2 |    25000.000000000000
       109 | Starship   |              2 |    34000.000000000000
       110 | Falcon 9   |              3 |    14000.000000000000
       101 | Falcon 9   |              2 |    41000.000000000000
(4 rows)
 */

DELETE FROM Contract WHERE contractID = 209;

SELECT missionID, rocketType, totalContracts, totalRevenue / totalContracts AS avgRevenuePerContract
FROM RideshareMissionView;

/* RESULTS OF QUERY 2:
 missionid | rockettype | totalcontracts | avgrevenuepercontract 
-----------+------------+----------------+-----------------------
       104 | Starship   |              2 |    25000.000000000000
       109 | Starship   |              2 |    34000.000000000000
       110 | Falcon 9   |              3 |    14000.000000000000
(3 rows)
*/
