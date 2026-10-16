SELECT DISTINCT missionID as theMissionID, rocketType as theRocketType
FROM Mission, Contract
WHERE Mission.missionID = Contract.missionID AND paymentMethod = 'GovernmentGrant' AND price < 50000
