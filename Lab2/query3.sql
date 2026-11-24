SELECT astronautID as theAstronautID
FROM Astronaut
WHERE astronautName != 'Sophia Kim'
AND EXISTS ( /* subquery time, check for rocket type */
	SELECT * /* select all */
	FROM Mission m1, Mission m2, MissionCrew mc1, MissionCrew mc2 /* make two copies. equality check for our conditions*/
	WHERE mc1.astronautID = Astronaut.astronautID
	AND mc2.astronautID = Astronaut.astronautID /* we wanted at least two different missions */
	AND mc1.missionID = m1.missionID
	AND mc2.missionID = m2.missionID /* foreign key */
	AND m1.rocketType = m2.rocketType /* so we can check rocket type */
	AND mc1.missionID < mc2.missionID /* and because we did a self comparison/self-join */
	/* comparing the IDs ensures theyre never comparing against themselves */
);
