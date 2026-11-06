CREATE VIEW RideshareMissionView AS
SELECT m.missionID, m.rocketType, COUNT(c.contractID) AS totalContracts, SUM(c.price) AS totalRevenue
FROM Mission m, Contract c
WHERE m.missionID = c.missionID
GROUP BY m.missionID, m.rocketType
HAVING COUNT(c.contractID) >= 2;
