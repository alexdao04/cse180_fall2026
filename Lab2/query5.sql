SELECT DISTINCT MissionCrew.missionID as theMissionID, missionCrew.astronautID as theAstronautID
FROM Mission, Astronaut, Contract, PayloadIntegration, MissionCrew
WHERE Mission.missionID = MissionCrew.missionID
AND Astronaut.astronautID = MissionCrew.astronautID
AND Mission.missionID = Contract.missionID
AND Contract.contractID = PayloadIntegration.contractID
AND numTechnicians >= 1
/* this is a subquery to get earliest launch date among crewed missions */
AND DATE(actualLaunch) = (
	SELECT MIN(DATE(actualLaunch)) 
	FROM Mission, MissionCrew
	WHERE Mission.missionID = MissionCrew.missionID
);
