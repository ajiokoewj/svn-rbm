#!/usr/bin/env bash
# Description :- Move your Backups to S3 Bucket (mv2s3)
# Author : Amit Kumar Mishra
# Requirement : AWS CLI with Access credentials for S3 Bucket
# 

# VARIABLES
#export SVN_DUMP_DIR=/svn
#export SVN_PROP=$HOME/.backup
. ./svnbk.cfg
DAYS="30"
FILE=$SVN_PROP/bkdirlst
# List only name of file & directory. "Cut" used to cut characters from 1 to 10
ls -1 $SVN_DUMP_DIR | cut -c 1-10 > bkdirlst

# While loop to Reading file line by line
while read bkdate; do
echo Backupdate is $bkdate

#d1=`date --date "$bkdate" +%s`
#echo date1 is $d1
#d2=`date +%Y-%m-%d`
#d2=`date --date "$d2" +%s`
#echo date2 is $d2
#diff=$((d2-d1))
#echo difference is $diff
BKDATE=`date --date "$bkdate" +%s`
echo Backup date $BKDATE
CURRENTDATE="$(date +%Y-%m-%d)"
CURRENTDATE=`date --date "$CURRENTDATE" +%s`
echo Current Date $CURRENTDATE

diff=$((CURRENTDATE-BKDATE))
echo difference is $DIFF

diffdays=`echo $((diff/86400))`
echo days is $days

echo backup directory name is $bkdate

if [ $diffdays -gt $DAYS ] ; then
		echo BACKUP OLDER THAN $DAYS DAYS
		echo =========================
        echo backup directory name is $bkdate
        echo Moving backup Dt. $bkdate to S3 Bucket ............
        mv $SVN_DUMP_DIR/$bkdate* $S3
        echo Backup Dt. $bkdate moved inside S3 bucket >> $SVN_PROP/dailybackup.log
        echo =========================
else
        echo No old backup remains to move backup.
fi

done < $FILE

### SCRIPTS DONE ###