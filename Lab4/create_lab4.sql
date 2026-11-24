-- CSE 180 Fall 2026 Lab4 creation file
-- Run this script BEFORE running load_lab4.sql.

-- Drop and recreate the Lab4 schema, then set it as the current search_path.
-- These commands make the script idempotent (safe to re-run).
DROP SCHEMA IF EXISTS Lab4 CASCADE;
CREATE SCHEMA Lab4;
SET search_path TO Lab4;

-- These are the same 7 tables as in create_lab3.sql, except that the
-- Foreign Keys on Contract and PayloadIntegration from our Lab1 solution are
-- back (in their original form), and the UpdateContract table is gone.
-- The Foreign Keys and general (CHECK) constraints that you added in Lab3
-- are NOT in this schema.

CREATE TABLE Payload(
  payloadID INTEGER PRIMARY KEY,
  payloadName VARCHAR(40),
  owner VARCHAR(40),
  massKg INTEGER,
  payloadType CHAR(1)
);

CREATE TABLE LaunchSite(
  siteCode VARCHAR(40) PRIMARY KEY,
  siteName VARCHAR(40),
  country VARCHAR(40),
  numLaunchPads INTEGER,
  altitudeMeters INTEGER
);

CREATE TABLE Mission(
  missionID INTEGER PRIMARY KEY,
  launchSiteCode VARCHAR(40) REFERENCES LaunchSite(siteCode),
  scheduledLaunch TIMESTAMP,
  actualLaunch TIMESTAMP,
  rocketType VARCHAR(40),
  durationHours INTEGER,
  outcome CHAR(1)
);

CREATE TABLE Astronaut(
  astronautID INTEGER PRIMARY KEY,
  astronautName VARCHAR(40),
  agency VARCHAR(40),
  dateOfBirth DATE,
  yearsExperience INTEGER
);

CREATE TABLE Contract(
  contractID INTEGER PRIMARY KEY,
  missionID INTEGER REFERENCES Mission(missionID),
  signedDate DATE,
  priority CHAR(1),
  price NUMERIC(9, 2),
  paymentMethod VARCHAR(40)
);

CREATE TABLE PayloadIntegration(
  contractID INTEGER REFERENCES Contract(contractID),
  payloadID INTEGER REFERENCES Payload(payloadID),
  integrationTime TIMESTAMP,
  numTechnicians INTEGER,
  baySlot VARCHAR(40),
  PRIMARY KEY (contractID, payloadID)
);

CREATE TABLE MissionCrew(
  missionID INTEGER REFERENCES Mission(missionID),
  astronautID INTEGER REFERENCES Astronaut(astronautID),
  role VARCHAR(40),
  compensation NUMERIC(9, 2),
  PRIMARY KEY (missionID, astronautID)
);
