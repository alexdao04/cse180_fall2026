#! /usr/bin/env python

#  runSpaceLaunchApplication Solution
from datetime import datetime
import psycopg2, sys

# The three Python functions for Lab4 should appear below.
# Write those functions, as described in Lab4 Section 4 (and Section 5,
# which describes the Stored Function used by the third Python function).
#
# Write the tests of those function in main, as described in Section 7
# of Lab4.


# countAstronautsLaunchedFromSite (myConn, theSiteCode):
# The launch company wants to know how many different astronauts have actually
# launched from a given launch site.
# The MissionCrew table tells us which astronauts (astronautID) were crew on which
# missions (missionID), while the Mission table tells us which launch site
# (launchSiteCode) each mission launches from, and whether it has launched yet
# (actualLaunch).
#
# Besides the database connection, countAstronautsLaunchedFromSite has one
# parameter, a string, theSiteCode.
#
# countAstronautsLaunchedFromSite should return the number of different astronauts
# who were crew on a mission that launched from that site.  It returns -1 if
# there is no launch site whose siteCode is theSiteCode.
#
# For more details, including error handling and return codes, see the Lab4 pdf.

def countAstronautsLaunchedFromSite (myConn, theSiteCode):
    cur = myConn.cursor()

    sql = """
    SELECT COUNT(DISTINCT mc.astronautID)
    FROM Mission m
    JOIN MissionCrew mc ON m.missionID = mc.missionID
    WHERE m.launchSiteCode = %s
        AND m.actualLaunch IS NOT NULL
    """

    cur.execute(sql, (theSiteCode,))
    row = cur.fetchone()
        
    if row is None or row[0] == 0: 
        # null check (if no launch site whose siteCode = theSiteCode)
        cur.execute("SELECT 1 FROM LaunchSite WHERE siteCode = %s", (theSiteCode,))
        if cur.fetchone() is None:
            cur.close()
            return -1

        cur.close()
        return 0
    cur.close()
    return row[0]
    # end countAstronautsLaunchedFromSite


# refundScrubbedContracts (myConn, scrubDate):
# In the Contract table, paymentMethod is the method that the customer used to pay
# for the contract (e.g., 'WireTransfer', 'GovernmentGrant', 'CreditLine'), and it
# may also be NULL.
# Besides the database connection, refundScrubbedContracts has another parameter,
# scrubDate, which is a string formatted as YEAR-MONTH-DAY or YYYY-MM-DD.
# Every contract whose mission had its scheduledLaunch on scrubDate must be marked
# as refunded, by appending ' REFUNDED <scrubDate>' to its paymentMethod.
# If the year in scrubDate is not 2026, then no changes should be made, and
# refundScrubbedContracts should return -1.
#
# refundScrubbedContracts should return the number of contracts whose paymentMethod
# was updated.
#
# For more details, including NULL handling and error handling, see the Lab4 pdf.

def refundScrubbedContracts (myConn, scrubDate):
    # You need to implement this function
    
    if scrubDate is None or not scrubDate.startswith("2026-"): # simple 2026 check
        return -1
    

    cur = myConn.cursor()
    
    sql = """
    UPDATE Contract c 
    SET paymentMethod = CASE
        WHEN c.paymentMethod IS NULL THEN 'REFUNDED ' || %s
        ELSE c.paymentMethod || ' REFUNDED ' || %s
    END
    FROM Mission m
    WHERE DATE(m.scheduledLaunch) = TO_DATE(%s, 'YYYY-MM-DD')
        AND c.missionID = m.missionID
        AND (c.paymentMethod IS NULL OR c.paymentMethod NOT LIKE '%%REFUNDED%%')
    """

    cur.execute(sql, (scrubDate, scrubDate, scrubDate))
    # for security reasons (pass separate so a bad actor cant modify the og query)
    updated_rows = cur.rowcount
    cur.close()
    return updated_rows
# end refundScrubbedContracts


# rewardCrew (myConn, minSuccessfulMissions, maxRewarded)
#
# The launch company wants to give a raise to some experienced astronauts who
# have flown successful missions.
#
# Besides the database connection, this Python function has two other parameters,
# minSuccessfulMissions and maxRewarded, which are both integers.
#
# rewardCrew invokes a Stored Function, rewardCrewFunction, that you will need to
# implement and store in the database according to the description in Section 5.
# The stored function rewardCrewFunction has the same parameters
# minSuccessfulMissions and maxRewarded as rewardCrew (but the database connection
# is not a parameter for the stored function), and rewardCrewFunction returns an
# integer.
#
# Section 5 tells you which astronauts get rewarded and how, and explains the
# integer value that rewardCrewFunction returns.  The rewardCrew Python function
# returns the same integer value that the rewardCrewFunction stored function returns.
#
# rewardCrewFunction doesn't print anything.  The rewardCrew function must only
# invoke the stored function rewardCrewFunction, which does all of the work for
# this part of the assignment; rewardCrew should not do any of the work itself.
#
# For more details, see the Lab4 pdf.

def rewardCrew (myConn, minSuccessfulMissions, maxRewarded):

    try:
        myCursor = myConn.cursor()
        sql = "SELECT rewardCrewFunction(%s, %s)"
        myCursor.execute(sql, (minSuccessfulMissions, maxRewarded))
    except:
        print("Call of rewardCrewFunction with arguments", minSuccessfulMissions, maxRewarded, "had error", file=sys.stderr)
        myCursor.close()
        myConn.close()
        sys.exit(-1)

    row = myCursor.fetchone()
    myCursor.close()
    return(row[0])

#end rewardCrew


def main():
    port = "5432"
    userID = "cse180"
    pwd = "database4me"

    # Optional command line arguments: <userid> <password>
    if len(sys.argv) == 3:
        userID = sys.argv[1]
        pwd = sys.argv[2]

    # Try to make a connection to the database
    try:
        myConn = psycopg2.connect(port=port, user=userID, password=pwd)
    except:
        print("Connection to database failed", file=sys.stderr)
        sys.exit(-1)

    # We're making every SQL statement a transaction that commits.
    # Don't need to explicitly begin a transaction.
    # Could have multiple statement in a transaction, using myConn.commit when we want to commit.

    myConn.autocommit = True

    # There are other correct ways of writing all of these calls correctly in Python.

    # Perform tests of countAstronautsLaunchedFromSite, as described in Section 7 of Lab4.
    # Print their outputs (including error outputs) here, not in countAstronautsLaunchedFromSite.
    # You may use a Python method to help you do the printing.
    for site in ["KSC", "BOCA", "WSLS", "LAX", "VSFB"]:
        output = countAstronautsLaunchedFromSite(myConn, site)
        if output >= 0:
            print(f'Number of astronauts launched from site {site} is {output}')
        else:
            print(f'Error: invalid launch site {site}')
        print()

    # Perform tests of refundScrubbedContracts, as described in Section 7 of Lab4.
    # Print their outputs (including error outputs) here, not in refundScrubbedContracts.
    # You may use a Python method to help you do the printing.
    restricted = ["2026-03-01", "2025-09-15", "2026-02-14", "2026-03-01", "2026-06-25"]
    for dates in restricted:
        output = refundScrubbedContracts(myConn, scrubDate)
        if output >= 0:
            print(f"Number of contracts refunded by refundScrubbedContracts for {scrub_date} is {output}")
        else:
            print(f"Error: invalid scrubDate {scrubDate}")
        print()

    # Perform tests of rewardCrew, as described in Section 7 of Lab4,
    # Print their outputs (including error outputs) here, not in rewardCrew.
    # You may use a Python method to help you do the printing.
    for min_missions, max_reward in [(0,3), (3,1), (2,2), (3,5), (1,10)]:
        output = rewardCrew(myConn, minSuccessfulMissions, maxReward)
        if result >= 0:
            print(f"Number of astronauts rewarded for minSuccessfulMissions {minSuccessfulMissions} and maxRewarded {maxRewarded} is {count}")  
        else:
            print(f"Error: invalid {minSuccessfulMissions}, {maxRewarded}")
        print()
    myConn.close()
    sys.exit(0)
#end

#------------------------------------------------------------------------------
if __name__=='__main__':

    main()

# end
