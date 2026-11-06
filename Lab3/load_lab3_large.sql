-- CSE 180 Fall 2026 Lab3 large load file (Section 3.3: Create and Use an Index)
-- Run this script AFTER running create_lab3.sql and load_lab3.sql.

-- Adds 200,000 generated contracts (contractID 100001 to 300000) to Contract,
-- so that Contract is large enough for an index to make a difference.
-- The values are computed from i (no random numbers), so everyone gets
-- exactly the same data.  Only about 2% of the new contracts have priority 'H'.
INSERT INTO Contract (contractID, missionID, signedDate, priority, price, paymentMethod)
SELECT 100000 + i,
       101 + i % 13,
       DATE '2025-01-01' + i % 600,
       CASE WHEN i % 50 = 0 THEN 'H'
            WHEN i % 2 = 0 THEN 'M'
            ELSE 'L' END,
       1000 + (i * 37) % 99000,
       CASE i % 3 WHEN 0 THEN 'WireTransfer'
                  WHEN 1 THEN 'CreditLine'
                  ELSE 'GovernmentGrant' END
FROM generate_series(1, 200000) AS i;

-- Update the statistics that PostgreSQL uses to choose a query plan.
ANALYZE Contract;
