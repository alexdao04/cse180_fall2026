SELECT DISTINCT Mission.missionID as theMissionID, integrationTime as theIntegrationTime
FROM LaunchSite, Mission, Contract, PayloadIntegration
WHERE Mission.missionID = Contract.missionID 
AND Mission.launchSiteCode = LaunchSite.siteCode
AND Contract.contractID = PayloadIntegration.contractID
AND priority = 'H' 
AND DATE(integrationTime) >= '2026-05-01' 
AND siteName ~ 'an'
AND numTechnicians >= 5
AND paymentMethod IS NULL
