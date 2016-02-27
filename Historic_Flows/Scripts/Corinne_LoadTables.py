import pymysql
import csv

# a database in MySQL named 'Corinne' must be created before using this script
# db has 3 columns: ResultID (int), LocalDateTime (datetime), Discharge (double)

# Create the connection to the database - only need to do this once
cnxn = pymysql.connect(host='127.0.0.1', port=3306, user='root', passwd='b', db='Corinne')
# Get a cursor - only need to do this once
crsr = cnxn.cursor()

# ------ Do this for each table: Load Units Table-----------------------------------
# Open the CSV file and loop through every row - need to do this for each file loaded
with open('/Users/bryce/Desktop/NWIS_Corinne_formated.csv','rU') as csvfile:
    # Get the content of the file
    fileContent = csv.reader(csvfile)
    # Loop through the rows in the file content
    for row in fileContent:
        # Check to make sure the current row isn't the header row
        if row[0].isdigit():
            # Construct a generic SQL INSERT query that I can inject the current row's values into
            queryString = 'INSERT INTO results (ResultID, LocalDateTime, Discharge) ' \
                          'VALUES (%s, %s, %s);'
            # Execute the INSERT query using the current row's values
            crsr.execute(queryString, row)

# Make sure to commit the transactions to the database - need to do this for each file loaded
cnxn.commit()
# -------- End of loading the Units table -------------------------------------------


