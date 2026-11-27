CREATE OR REPLACE FUNCTION rewardCrewFunction(
	minSuccessfulMissions INTEGER,
	maxRewarded INTEGER
) RETURNS INTEGER AS $$
DECLARE
	rec RECORD;
	rewardedCount INTEGER := 0;
BEGIN
	IF minSuccessfulMissions <= 0 OR maxRewarded <= 0 THEN
    		RETURN -1;
	END IF;
	FOR REC IN
		SELECT a.astronautID
		FROM Astronaut a
		JOIN MissionCrew mc ON a.astronautID = mc.astronautID
		JOIN Mission m on mc.missionID = m.missionID
		WHERE m.outcome = 'S'
		GROUP BY a.astronautID, a.yearsExperience
		HAVING COUNT(*) >= minSuccessfulMissions
			AND NOT EXISTS(
				SELECT 1
				FROM MissionCrew mc2
				WHERE mc2.astronautID = a.astronautID
					AND mc2.compensation >= 120000.00
					)
				ORDER BY a.yearsExperience DESC, a.astronautID ASC
				LIMIT MaxRewarded
			LOOP
				UPDATE MissionCrew
			SET compensation = compensation * 1.1
			WHERE astronautID = rec.astronautID;
		rewardedCount := rewardedCount + 1;
   	END LOOP;
   	RETURN rewardedCount;
END;
$$ LANGUAGE plpgsql;
