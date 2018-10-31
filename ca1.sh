#!/bin/bash

# Author: Noel Bell X00158551

# CA1 script to check for the following conditions;
# 	Is user mysql in the password file?
# 	Is the number of CPUs on this VM greater than or equal to 2
# 	Does /usr/bin/uptime have execute permission set for the owner

# First, look for username from the system password file
ISUSERPRESENT=`grep ~mysql /etc/passwd | wc -l`

# Now count CPU
NUMCPU=`cat /proc/cpuinfo | grep processor | wc -l`

# now check /usr/bin/uptime (assume checking owners execute permission, ie: 4th character in string)
ISEXESET=`ls -tal /usr/bin/uptime | cut -c4`

# Get date and time - the %p format will return locale's equivalent of either AM or PM but will return blank if not known
TODAY=`date +%Y-%m-%d`
NOWTIME=`date +%r" "%p`

# Now output the results
echo "======================================================================="
echo "COMPLIANCE REPORT"
echo ""
echo "DATE: " $TODAY
echo "TIME: " $NOWTIME
echo ""
# test value of $ISUSERPRESENT - > 0 means a result was returned from grep and word count command earlier
if [ $ISUSERPRESENT -gt 0 ]
then
	echo "The user account mysql is present in this VM"
else
	echo "ERROR: The user account mysql is not present on this VM"
fi
# test value of $NUMCPU - this is a literal value returned from the word count earlier
if [ $NUMCPU -ge 2 ]
then
	echo "OK: The number of CPUs on this VM is greater than or equal to 2"
else
	echo "ERROR: THe number of CPUs on this VM is less than 2"
fi
# test value of $ISEXESET - this should be either x or -
if [ $ISEXESET = "x" ]
then
	echo "OK: /usr/bin/uptime does have execute permission turned on"
else
	echo "ERROR: /usr/bin/uptime does not have execute permission turned on"
fi
echo "======================================================================="
