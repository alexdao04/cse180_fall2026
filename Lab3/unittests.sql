/* insert test 1 */
INSERT INTO Contract (contractID, missionID)
VALUES (9999, 9999);

/* insert test 2 */
INSERT INTO PayloadIntegration (payloadID, contractID)
VALUES (9999, 201);

/* insert test 3 */
INSERT INTO PayloadIntegration (payloadID, contractID)
VALUES (1, 9999);

/* general test 1 */
UPDATE LaunchSite 
SET numLaunchPads = 1
WHERE siteCode = (SELECT siteCode FROM LaunchSite LIMIT 1); 

UPDATE LaunchSite
SET numLaunchPads = -1
WHERE siteCode = (SELECT siteCode FROM LaunchSite LIMIT 1);

/* general test 2 */
UPDATE Mission
SET outcome = 'S'
WHERE missionID = (SELECT missionID FROM Mission LIMIT 1);

UPDATE Mission
SET outcome = 'D' 
WHERE missionID = (SELECT missionID FROM Mission LIMIT 1);

/* general test 3 */
UPDATE Contract
SET price = 100.00, paymentMethod = 'WireTransfer'
WHERE contractID = (SELECT contractID FROM Contract LIMIT 1);

UPDATE Contract
SET price = NULL, paymentMethod = 'WireTransfer'
WHERE contractID = (SELECT contractID FROM Contract LIMIT 1);
