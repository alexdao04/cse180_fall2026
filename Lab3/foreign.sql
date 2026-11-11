ALTER TABLE Contract
ADD CONSTRAINT contractMissionForeignKey
FOREIGN KEY (missionID)
REFERENCES Mission (missionID)
ON DELETE SET NULL
/* for tuples in mission table that are deleted
missionID in all affected tuples will be set to NULL */
ON UPDATE CASCADE;

ALTER TABLE PayloadIntegration
ADD CONSTRAINT PayloadIntPayloadForeignKey
FOREIGN KEY (payloadID)
REFERENCES Payload (payloadID)
ON UPDATE CASCADE;

ALTER TABLE PayloadIntegration
ADD CONSTRAINT PayloadIntContractFK
FOREIGN KEY (contractID)
REFERENCES Contract (contractID)
ON DELETE CASCADE
ON UPDATE CASCADE;

