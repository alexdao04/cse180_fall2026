DROP SCHEMA Lab2 CASCADE;
CREATE SCHEMA Lab2;

CREATE TABLE Payload(
	payloadID INTEGER PRIMARY KEY, 
	payloadName VARCHAR(40) NOT NULL, 
	owner VARCHAR(40), 
	massKg INTEGER, 
	payloadType CHAR(1),
	CONSTRAINT unique_payloadName_owner UNIQUE(payloadName, owner)
);

CREATE TABLE LaunchSite(
	siteCode VARCHAR(40) PRIMARY KEY, 
	siteName VARCHAR(40) NOT NULL, 
	country VARCHAR(40), 
	numLaunchPads INTEGER, 
	altitudeMeters INTEGER,
	CONSTRAINT unique_siteName_country UNIQUE(siteName, country)
);

CREATE TABLE Mission(
	missionID INTEGER PRIMARY KEY, 
	launchSiteCode VARCHAR(40), 
	scheduledLaunch TIMESTAMP NOT NULL, 
	actualLaunch TIMESTAMP NOT NULL, 
	rocketType VARCHAR(40),
	durationHours INTEGER, 
	outcome CHAR(1)
);

CREATE TABLE Astronaut(
	astronautID INTEGER PRIMARY KEY, 
	astronautName VARCHAR(40), 
	agency VARCHAR(40), 
	dateOfBirth DATE, 
	yearsExperience INTEGER,
	CONSTRAINT astronaut_name UNIQUE(astronautName)
);

CREATE TABLE Contract(
	contractID INTEGER PRIMARY KEY, 
	missionID INTEGER REFERENCES Mission(missionID), 
	signedDate DATE, 
	priority CHAR(1), 
	price NUMERIC(9,2), 
	paymentMethod VARCHAR(40),
	CONSTRAINT unique_signedDate_paymentMethod_missionID UNIQUE(signedDate, paymentMethod, missionID)
);

CREATE TABLE PayloadIntegration(
	contractID INTEGER REFERENCES Contract(contractID), 
	payloadID INTEGER REFERENCES Payload(payloadID), 
	integrationTime TIMESTAMP, 
	numTechnicians INTEGER, 
	baySlot VARCHAR(40), 
	PRIMARY KEY(contractID, payloadID)
);

CREATE TABLE MissionCrew(
	missionID INTEGER REFERENCES Mission(missionID), 
	astronautID INTEGER REFERENCES Astronaut(astronautID), 
	role VARCHAR(40), 
	compensation NUMERIC(9,2), 
	PRIMARY KEY(missionID, astronautID)
);

