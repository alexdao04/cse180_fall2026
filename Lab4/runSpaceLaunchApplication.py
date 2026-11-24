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
    # You need to implement this function
    cur = myConn.cursor()

    """The launch company needs to know how many different astronauts have launched from a given launch site.
    
    The MissionCrew table tells us which astronauts (astronautID) were crew on which missions
    (missionID), while the Mission table tells us the launch site (launchSiteCode) that each mission
    launches from. A mission has launched only if its actualLaunch is not NULL.
    
    Besides the database connection, countAstronautsLaunchedFromSite has one parameter,
    theSiteCode, which is a string. countAstronautsLaunchedFromSite should count the number of
    different astronauts who were crew on a mission that launched from the launch site whose
    siteCode is theSiteCode. The function should return that count.

    If there is no launch site whose siteCode equals theSiteCode, countAstronautsLaunchedFromSite should return -1. 

    If the launch site exists but no astronauts have launched from it, countAstronautsLaunchedFromSite should return 0.

    Note that Python functions can have more than one SQL statement in them.

    You will probably have more than one SQL statement in your code for countAstronautsLaunchedFromSite.
    """

    return 0
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
    """
    ● A launch is “scrubbed” when it is called off on the day it was scheduled (for example, because of
    weather). After a launch range outage, the launch company has decided to refund every
    contract for a mission that was scheduled to launch on a particular day, even if that mission
    still launched later that day or on another day.

    ● In the Contract table, the value of paymentMethod is the method that was used to pay for the
    contract. In the Lab4 load data, these values are 'WireTransfer', 'GovernmentGrant',
    'CreditLine' and NULL.

    ● Besides the database connection, refundScrubbedContracts has the parameter scrubDate,
    which is a string formatted as YEAR-MONTH-DAY (ex. '2026-03-01'). The function
    refundScrubbedContracts should do the following:
        ○ If the year in scrubDate is not 2026, then no changes should be made to any
        paymentMethod values, and refundScrubbedContracts should return -1.
        ○ Otherwise, for every mission whose scheduledLaunch is on the date scrubDate, the
        paymentMethod of each Contract for that mission should have ' REFUNDED <scrubDate>'
        appended at the end. For example, if scrubDate is '2026-05-08', then a Contract for that
        mission whose paymentMethod is 'WireTransfer' should be changed to 'WireTransfer
        REFUNDED 2026-05-08'.
        ○ If the paymentMethod of that Contract is NULL, it should be changed to 'REFUNDED 2026-
        05-08' (without a blank at the beginning). Remember that in SQL, NULL || 'abc' is NULL.
        ○ Contracts that have already been refunded (their paymentMethod has 'REFUNDED' in it)
        should not be changed again. A Contract whose paymentMethod is NULL has not been
        refunded.
        ○ refundScrubbedContracts should return the number of Contracts whose paymentMethod
        was updated.

    ● To concatenate two strings in SQL, use the || operator (the vertical bar written twice). For
    example: 
    'Dr. ' || astronautName
    puts 'Dr. ' in front of an astronautName.

    ● Notes:
        ○ To get a SQL DATE datatype from a TIMESTAMP you can use the DATE(timestamp)
        function, ex. DATE(m.scheduledLaunch).
        ○ To get a SQL DATE datatype from a string you can use the TO_DATE(string,
        string_date_format) function, ex. TO_DATE(date_as_string, 'YYYY-MM-DD').
        ○ After you execute an UPDATE, myCursor.rowcount is the number of rows that were
        updated.
        ○ If you use LIKE in a SQL string that also has %s parameters, write each % in the pattern as
        %%."""
    return 0

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

    # Perform tests of refundScrubbedContracts, as described in Section 7 of Lab4.
    # Print their outputs (including error outputs) here, not in refundScrubbedContracts.
    # You may use a Python method to help you do the printing.

    # Perform tests of rewardCrew, as described in Section 7 of Lab4,
    # Print their outputs (including error outputs) here, not in rewardCrew.
    # You may use a Python method to help you do the printing.

    myConn.close()
    sys.exit(0)
#end

#------------------------------------------------------------------------------
if __name__=='__main__':

    main()

# end
