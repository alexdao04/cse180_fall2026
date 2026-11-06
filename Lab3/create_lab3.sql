-- CSE 180 Fall 2026 Lab3 creation file
-- Run this script BEFORE running load_lab3.sql.

-- Drop and recreate the Lab3 schema, then set it as the current search_path.
-- These commands make the script idempotent (safe to re-run).
DROP SCHEMA IF EXISTS Lab3 CASCADE;
CREATE SCHEMA Lab3;
SET search_path TO Lab3;

-- The first 7 tables are similar to the tables in our Lab1 create_lab1.sql
-- solution.  The NULL and UNIQUE constraints from Lab2 are NOT included.
-- Three Foreign Key constraints (on Contract and PayloadIntegration) are
-- intentionally omitted; you will add them in foreign.sql (Section 3.5).

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

-- Note: The Foreign Key on (missionID -> Mission) is intentionally omitted.
-- Students will add it in Section 3.5 (foreign.sql).
CREATE TABLE Contract(
  contractID INTEGER PRIMARY KEY,
  missionID INTEGER,
  signedDate DATE,
  priority CHAR(1),
  price NUMERIC(9, 2),
  paymentMethod VARCHAR(40)
);

-- Note: Both Foreign Keys on PayloadIntegration (contractID -> Contract and
-- payloadID -> Payload) are intentionally omitted.
-- Students will add them in Section 3.5 (foreign.sql).
CREATE TABLE PayloadIntegration(
  contractID INTEGER,
  payloadID INTEGER,
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

-- New table for Lab3: UpdateContract
-- This table contains updates to be merged into the Contract table
-- by your combine.sql (Section 3.4).
CREATE TABLE UpdateContract(
  contractID INTEGER PRIMARY KEY,
  priority CHAR(1),
  price NUMERIC(9, 2)
);
