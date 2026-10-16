-- Sample script file to populate the Space Launch Schema (Lab2)
-- Run this AFTER your create_lab2.sql.

-- Payload(payloadID, payloadName, owner, massKg, payloadType)
-- payloadType: S = satellite, C = cargo, P = probe
COPY Payload FROM stdin USING DELIMITERS '|';
1|Starlink Batch 12|SpaceX|15600|S
2|ISS Resupply CRS-31|NASA|3300|C
3|Europa Scout|ESA|2400|P
4|WeatherSat 7|NOAA|1850|S
5|Lunar Cargo Module|JAXA|4200|C
6|Orbital Lab Kit|Blue Origin|900|C
7|Mars Relay Probe|ISRO|1200|P
8|EarthObserver 3|Planet Labs|650|S
9|Sentinel 6C|ESA|1200|S
10|Starlink Batch 13|SpaceX|15800|S
11|SkyComm Relay|Viasat|3100|S
12|Ice Mapper|NOAA|800|S
13|Comet Sampler|JAXA|1500|P
14|smallSat Swarm|Rocket Lab|300|S
15|Space Debris Tracker|LeoLabs|450|S
16|CubeSat Pack A|UCSC|40|S
17|CubeSat Pack B|UCSC|35|S
18|ArcticSat 1|NOAA|1300|S
19|Tether Experiment|JAXA|300|C
20|Galileo FOC 13|ESA|715|S
\.

-- LaunchSite(siteCode, siteName, country, numLaunchPads, altitudeMeters)
COPY LaunchSite FROM stdin USING DELIMITERS '|';
KSC|Kennedy Space Center|USA|3|3
VSFB|Vandenberg Space Force Base|USA|4|112
CCSFS|Cape Canaveral Space Force Station|USA|5|4
BOCA|Starbase Boca Chica|USA|2|2
CSG|Guiana Space Centre|France|3|15
BAIK|Baikonur Cosmodrome|Kazakhstan|4|90
TNSC|Tanegashima Space Center|Japan|2|30
SDSC|Satish Dhawan Space Centre|India|2|10
\.

-- Mission(missionID, launchSiteCode, scheduledLaunch, actualLaunch, rocketType, durationHours, outcome)
-- outcome: S = success, F = failure, P = partial success
COPY Mission FROM stdin USING DELIMITERS '|';
101|KSC|2026-03-01 14:00:00|2026-03-01 14:05:00|Falcon 9|72|S
102|VSFB|2026-03-12 09:00:00|2026-03-12 09:40:00|Falcon 9|48|S
103|CSG|2026-04-03 21:30:00|2026-04-03 21:30:00|Ariane 6|6|S
104|BOCA|2026-04-20 12:00:00|2026-04-20 12:10:00|Starship|2|F
105|BAIK|2026-05-08 06:00:00|2026-05-08 06:05:00|Soyuz 2|168|S
106|TNSC|2026-05-30 16:00:00|2026-05-30 16:20:00|H3|24|P
107|SDSC|2026-06-15 10:00:00|2026-06-15 10:05:00|PSLV|4|S
108|KSC|2026-07-02 08:00:00|2026-07-02 08:15:00|New Glenn|96|S
109|BOCA|2026-06-25 13:00:00|2026-06-25 13:30:00|Starship|3|S
110|CCSFS|2026-07-20 11:00:00|2026-07-20 11:45:00|Falcon 9|12|S
111|VSFB|2026-03-01 18:00:00|2026-03-01 22:10:00|Falcon 9|8|S
112|CSG|2026-02-10 10:00:00|2026-02-14 10:20:00|Ariane 6|5|S
\.

-- Astronaut(astronautID, astronautName, agency, dateOfBirth, yearsExperience)
COPY Astronaut FROM stdin USING DELIMITERS '|';
1|Alice Green|NASA|1978-05-14|15
2|Brian Lee|NASA|1985-11-02|10
3|Carla Gomez|ESA|1990-01-27|7
4|David White|NASA|1972-08-19|20
5|Sophia Kim|JAXA|1992-03-30|5
6|James Patel|ISRO|1983-07-07|12
7|Laura Chen|ESA|1988-12-12|8
8|Tom Harris|Roscosmos|1975-04-25|18
9|Maya Singh|ISRO|1991-09-09|6
10|Ethan Brooks|NASA|1987-02-18|9
\.

-- Contract(contractID, missionID, signedDate, priority, price, paymentMethod)
-- priority: H = high, M = medium, L = low
-- price is in thousands of dollars. One contract may cover several payloads.
-- \N is used by PostgreSQL to denote a NULL value during COPY
COPY Contract FROM stdin USING DELIMITERS '|';
201|101|2025-09-15|H|62000.00|WireTransfer
202|102|2025-09-18|H|48500.00|GovernmentGrant
203|103|2025-09-20|M|91000.00|WireTransfer
204|104|2025-09-22|L|12000.00|CreditLine
205|105|2025-09-25|M|35000.00|WireTransfer
206|107|2025-09-28|H|27000.00|GovernmentGrant
207|109|2026-04-28|H|38000.00|WireTransfer
208|104|2025-10-06|M|38000.00|CreditLine
209|101|2025-10-10|M|20000.00|GovernmentGrant
210|110|2025-12-01|L|15000.00|GovernmentGrant
211|108|2025-12-05|M|50000.00|GovernmentGrant
212|109|2026-01-12|H|30000.00|\N
213|106|2026-01-20|H|22000.00|\N
214|110|2026-02-02|H|18000.00|\N
215|110|2026-01-05|M|9000.00|\N
216|111|2026-01-08|H|14000.00|\N
217|112|2025-11-20|M|41000.00|WireTransfer
\.

-- PayloadIntegration(contractID, payloadID, integrationTime, numTechnicians, baySlot)
COPY PayloadIntegration FROM stdin USING DELIMITERS '|';
201|1|2026-02-26 06:30:00|12|A1
201|8|2026-02-26 09:10:00|5|A2
202|2|2026-03-09 07:45:00|9|B2
203|3|2026-03-30 05:50:00|14|A3
204|4|2026-04-17 12:30:00|6|C1
204|6|2026-04-17 15:00:00|4|C2
204|15|2026-04-17 16:30:00|3|C3
205|5|2026-05-05 10:20:00|10|B1
206|7|2026-06-12 08:15:00|8|A2
206|11|2026-06-12 09:40:00|6|A3
207|9|2026-06-22 07:00:00|7|B1
207|10|2026-06-22 09:15:00|11|B2
207|14|2026-06-22 11:00:00|3|B3
208|10|2026-04-16 08:00:00|11|C4
212|12|2026-06-21 14:00:00|6|A1
213|13|2026-05-27 08:00:00|7|A1
213|19|2026-05-27 13:00:00|4|A2
214|16|2026-07-17 09:30:00|6|D1
214|17|2026-07-17 09:30:00|5|D2
215|18|2026-07-16 10:00:00|8|D3
216|18|2026-02-25 10:00:00|9|A1
217|20|2026-02-09 06:00:00|10|A1
\.

-- MissionCrew(missionID, astronautID, role, compensation)
COPY MissionCrew FROM stdin USING DELIMITERS '|';
101|1|Commander|150000.00
101|2|Pilot|100000.00
101|3|Specialist|50000.00
102|4|Commander|160000.00
102|6|Pilot|110000.00
102|5|Specialist|55000.00
103|1|Commander|150000.00
103|7|Specialist|60000.00
104|8|Commander|155000.00
104|2|Pilot|100000.00
105|4|Commander|160000.00
105|5|Specialist|55000.00
106|1|Commander|150000.00
106|6|Pilot|110000.00
107|8|Commander|155000.00
107|3|Specialist|50000.00
108|2|Pilot|100000.00
108|7|Specialist|60000.00
109|8|Commander|165000.00
109|2|Pilot|105000.00
110|1|Commander|150000.00
110|2|Pilot|100000.00
110|5|Specialist|55000.00
111|4|Commander|160000.00
111|9|Pilot|90000.00
111|10|Specialist|70000.00
\.
