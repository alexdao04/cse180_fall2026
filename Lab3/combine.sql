INSERT INTO Contract(
	contractID, priority, price, missionID, signedDate, paymentMethod
)
SELECT uc.contractID, uc.priority, uc.price, NULL, CURRENT_DATE, 'WireTransfer'
FROM UpdateContract as uc
/* when you attempt to insert values, if contractID exists we run DO UPDATE to update the existing values
 else insert the row as selected above */
ON CONFLICT (contractID) DO UPDATE
SET priority = EXCLUDED.priority, price = EXCLUDED.price, paymentMethod = 'WireTransfer';

