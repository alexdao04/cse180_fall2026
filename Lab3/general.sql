ALTER TABLE LaunchSite
ADD CONSTRAINT siteLaunchPadsPositive
CHECK (numLaunchPads > 0);

ALTER TABLE Mission
ADD CONSTRAINT validMissionOutcome
CHECK (outcome = 'S' OR outcome = 'F' OR outcome = 'P' OR outcome IS NULL);

ALTER TABLE Contract
ADD CONSTRAINT ifNullPriceThenNullMethod
CHECK (price IS NOT NULL OR paymentMethod IS NULL);
/* if the price is null, paymentMethod is expected to be null.
if we didn't fulfill that initial condition 
then we check if paymentMethod itself is null or if a value exists there. */
