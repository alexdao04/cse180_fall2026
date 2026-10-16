SELECT DISTINCT payloadName AS thePayloadName, siteCode as theLaunchSiteCode, price AS thePrice
FROM Payload, LaunchSite, Mission, Contract, PayloadIntegration
WHERE Payload.payloadID = PayloadIntegration.payloadID AND PayloadIntegration.contractID = Contract.contractID AND Contract.missionID = Mission.missionID AND Mission.launchSiteCode = LaunchSite.siteCode AND payloadName ~ '^S' AND price > 20000 AND numLaunchPads = 2 
