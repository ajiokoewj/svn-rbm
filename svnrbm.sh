#!/usr/bin/env bash
# Description :- SVN Remote Backup Manager (SVN RBM) script
# Author : Amit Kumar Mishra
# Requirement : Subversion 1.7 or later

## SVN Backup Directory
export SVN_DUMP_DIR=/svn
## Path of SVN Backup script & property files
export SVN_PROP=$HOME/.backup

day="$(date +'%A')"

if [ $day = "Sunday" ]; then
        sh -x $SVN_PROP/fullsvnbackup.sh
else
        sh -x $SVN_PROP/incrementalsvnbackup.sh
fi

. $SVN_PROP/notifyme.sh
## Scrip End ##