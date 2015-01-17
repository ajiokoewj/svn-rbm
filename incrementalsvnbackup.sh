#!/usr/bin/env bash
# Description :- SVN Remote incremental Backup script
# Author : Amit Kumar Mishra
# Requirement : Subversion 1.7 or later
# Tool :- sed, awk, cut, grep, expr, cat, tr

## SVN Backup Directory
export SVN_DUMP_DIR=/svn
## SVN Backup script & property file path
export SVN_PROP=$HOME/.backup
## URL of Repository
rep_home="https://svn.example.com/svn"
## Time stamp in format YYYY-MM-DD_HHMMSS
timestamp=`date +'%Y-%m-%d_%H%M%S'`
BK_DIR=`date +'%Y-%m-%d'`-"Incremental"

cd $SVN_PROP
. ./svn_repo.properties
. ./svn_initial_rev.properties
## For loop 
for rep in $(echo $svn_repo | tr "," " ");
do
        ## Current revision number of repository
        CURR_REV=`svn info "$rep_home"/"$rep" | grep "Revision:" | awk '{print $2}'`
        ## Last or initial revision no of repository
        INITIAL_REV=`cat svn_initial_rev.properties | grep -w $rep | cut -d '=' -f 2`
        BK_REV_FROM=`expr "$INITIAL_REV" + "1"`
        #echo This is current revision number $CURR_REV and last revision number $INITIAL_REV for $rep
  if [ ${CURR_REV} -gt ${INITIAL_REV} ] ; then
        ## Backup file name
        DUMPFILE="$rep"-Incremental-"$timestamp"-Rev-"$BK_REV_FROM"-to-"$CURR_REV"
        echo Backup started for Repository "$rep" .............
        mkdir -p "$SVN_DUMP_DIR"/"$BK_DIR"
        ## SVN Remote Dump
        svnrdump dump --quiet "$rep_home"/"$rep" --incremental -r${BK_REV_FROM}:${CURR_REV} | gzip -9 > $SVN_DUMP_DIR/$BK_DIR/${DUMPFILE}.dump.gz
        ## Cutting row number for repository
        rno=`grep -n . svn_initial_rev.properties | grep -w $rep | cut -d ":" -f 1`
        ## Updating current revision number to initial revision number in property file "svn_initial_rev.properties"
        sed -i "${rno}s/${INITIAL_REV}/${CURR_REV}/" svn_initial_rev.properties
        #echo `cat svn_initial_rev.properties | grep -w $rep`
        echo backup completed at $timestamp for Repositoy $rep >> $SVN_PROP/dailybackup.log
        #echo ====================
  else
        echo There is no update for Repository $rep >> $SVN_PROP/dailybackup.log
  fi            

done