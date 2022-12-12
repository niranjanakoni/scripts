--> Both configuration file and script file should be located in same place

--> Run the script using following command:
    # backup.sh <configuration_file>

--> To automate the backup process we can use Crontab,
    steps:
      # crontab -e
	* * * * * /usr/bin/sh /path/to/backup.sh /path/to/<configuration_file> --> to run script 'At every minute' (You can change timing format as per your requirement)
