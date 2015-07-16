
**`##############################################################`** 
#### ***`###`	SVN Remote Backup Manager (SVN RBM)	`###`*** 
**`##############################################################`** 

**Name    :-** ``SVN Remote Backup Manager``
**Version :-** 1.0.0
**Author  :-** Amit Kumar Mishra

 **`System requirements :-`** 
1. OS :- Ubuntu 14.04
2. Application :- Subversion 1.7 or later
3. Tools :- Bash shell, Sed, Awk, cut


**`Install, uninstall, configuration, and operating instructions :-`** 
	1. Create folder called '.backup' in your home folder directory.
	2. Copy all files which is in following files list into create directory '.backup'
	3. 

**`Files list :-`**
1. svnrbm.sh :- Main script which controls all scrips.
2. fullsvnbackup.sh :- Full backup script.
3. incrementalsvnbackup.sh :- Daily incremental script
4. svn_initial_rev.properties :- Property file which contains and updates by script initial or current revision number of repositories.
5. svn_repo.properties :- Property file which contains list of svn repo name
