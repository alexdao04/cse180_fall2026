SELECT m.missionID, m.rocketType, COUNT(c.contractID) AS totalContracts, totalRevenue
FROM Mission m, Contract c
WHERE 
