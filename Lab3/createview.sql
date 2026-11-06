CREATE VIEW RideshareMissionView AS
SELECT m.missionID, m.rocketType, COUNT(DISTINCT c.contractID), SUM(c.price)
FROM Mission m, Contract c
WHERE COUNT(contractID) >= 2
GROUP BY missionID, rocketType

