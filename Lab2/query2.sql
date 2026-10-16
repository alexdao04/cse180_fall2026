SELECT DISTINCT Mission.missionID as theMissionID, rocketType as theRocketType
FROM Mission, Contract
WHERE Mission.missionID = Contract.missionID 
AND paymentMethod = 'GovernmentGrant'
AND NOT EXISTS (
	SELECT * 
	FROM Contract AS c2 /* c2 alias */
	WHERE c2.missionID = Mission.missionID and c2.price > 50000
)
ORDER BY theRocketType DESC, theMissionID ASC;
