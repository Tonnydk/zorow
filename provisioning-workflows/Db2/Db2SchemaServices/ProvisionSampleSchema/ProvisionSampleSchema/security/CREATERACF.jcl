//RACFAU   EXEC PGM=IKJEFT01,DYNAMNBR=20,COND=(EVEN)
//SYSTSPRT DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//SYSTSIN  DD *
  ADDGROUP ${instance-RACFGROUP} OWNER(${instance-RACFOWNER}) -
      SUPGROUP(${instance-RACFSUPERGRP})

  SETROPTS CLASSACT(DSNADM) GENERIC(DSNADM)
  RDEFINE DSNADM ${instance-MVSSNAME}. -
          ${instance-DBASEA}*.DBADM -
          UACC(NONE) OWNER(${instance-RACFOWNER})
  RDEFINE DSNADM ${instance-MVSSNAME}. -
          ${instance-DBASEP}*.DBADM -
          UACC(NONE) OWNER(${instance-RACFOWNER})
  RDEFINE DSNADM ${instance-MVSSNAME}. -
          ${instance-DBASEX}*.DBADM -
          UACC(NONE) OWNER(${instance-RACFOWNER})
  PERMIT ${instance-MVSSNAME}. -
         ${instance-DBASEA}*.DBADM -
         ID(${instance-RACFGROUP}) -
         ACCESS(READ) CLASS(DSNADM)
  PERMIT ${instance-MVSSNAME}. -
         ${instance-DBASEP}*.DBADM -
         ID(${instance-RACFGROUP}) -
         ACCESS(READ) CLASS(DSNADM)
  PERMIT ${instance-MVSSNAME}. -
         ${instance-DBASEX}*.DBADM -
         ID(${instance-RACFGROUP}) -
         ACCESS(READ) CLASS(DSNADM)

  ADDUSER ${instance-RACFUSER} -
        OWNER(${instance-RACFOWNER}) -
        DFLTGRP(${instance-RACFSUPERGRP}) -
        AUTHORITY(USE)

  CONNECT (${instance-RACFUSER}) AUTHORITY(USE) -
          GROUP(${instance-RACFGROUP})
  PERMIT ${instance-MVSSNAME}.BATCH CLASS(DSNR) -
         ID(${instance-RACFUSER}) ACCESS(READ)

  SETR RACLIST(DSNADM) REFRESH
  SETR GENERIC(DSNADM) REFRESH
  SETROPTS GRPLIST
