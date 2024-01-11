use LogiReport_Realm
go

create table dbo.ACLENTRIES_3
(
    ENTRY_ID       int          not null
        primary key,
    ACL_ID         int          not null,
    PRINCIPAL_TYPE tinyint      not null,
    PRINCIPAL_NAME varchar(256) not null,
    IS_POSITIVE    bit          not null,
    PERMISSIONS    int          not null
)
go

create table dbo.ACLS_2
(
    ID          int         not null
        primary key,
    NAME        varchar(64) not null,
    CREATE_NAME varchar(32) not null,
    CREATE_TIME bigint
)
go

create table dbo.ACLS_WITH_RESOURCE_1
(
    ID             int          not null
        primary key,
    RESOURCE_PATH  varchar(256) not null,
    VERSION_NUMBER int          not null,
    ACL_NAME       varchar(512) not null,
    CREATE_NAME    varchar(32)  not null,
    CREATE_TIME    bigint
)
go

create table dbo.ALIASES_2
(
    ID             int          not null
        unique,
    PRINCIPAL_NAME varchar(256) not null,
    PRINCIPAL_TYPE tinyint      not null,
    ALIAS_NAME     varchar(256) not null,
    PARENT_NAME    varchar(256),
    MAP_RESOURCE   varchar(256) not null,
    HIDDEN         bit          not null
)
go

create table dbo.ALIAS_MAPPING
(
    KEY_ID           int          not null,
    FIELD_TYPE       int          not null,
    FIELD_SIGNATURE  varchar(32)  not null,
    FIELD_CATLOG     varchar(256) not null,
    FIELD_DATASOURCE varchar(256) not null,
    FIELD_QUERY      varchar(256) not null,
    FIELD_DETAILS    image        not null,
    primary key (KEY_ID, FIELD_TYPE, FIELD_SIGNATURE)
)
go

create table dbo.ALIAS_MAPPING_KEY
(
    ID          int          not null
        primary key,
    MAPPING_KEY varchar(256) not null
        unique
)
go

create table dbo.CATALOGVERSION_4
(
    VERSIONNUMBER int          not null,
    VERSIONNAME   varchar(128),
    RESOURCEID    int          not null,
    CREATOR       varchar(128),
    CREATEDTIME   bigint       not null,
    MODIFIER      varchar(128),
    MODIFIEDTIME  bigint       not null,
    CATALOGFILE   varchar(512) not null,
    ID            bigint       not null
        unique,
    DISKSIZE      bigint
)
go

create table dbo.CCD_INFO_1
(
    ID                  int not null
        unique,
    SVERSION            int,
    CATALOGID           int,
    CATALOGPATH         varchar(255),
    DATASOURCE          varchar(255),
    CONNNAME            varchar(255),
    LASTMODIFIED        bigint,
    PARAMFILE           varchar(255),
    RESULTVERSION       int,
    CATALOGVERSION      int,
    CATALOGLASTMODIFIED bigint,
    TASKID              varchar(255),
    CONFIGFILE          varchar(255),
    LOGINUSER           varchar(255),
    STATUS              tinyint,
    CREATETIME          bigint,
    FLAGS               int
)
go

create table dbo.CCDRUNDETAIL_1
(
    ID        int
        references dbo.CCD_INFO_1 (ID),
    ACTIVITY  tinyint,
    STARTTIME bigint,
    ENDTIME   bigint,
    SUCC      bit
)
go

create table dbo.CFG_PROPS_2
(
    PROP_NAME  varchar(128) not null,
    PROP_KEY   varchar(512) not null,
    PROP_VALUE varchar(512),
    IS_LOB     bit          not null,
    LOB_VAL    image,
    primary key (PROP_NAME, PROP_KEY)
)
go

create table dbo.COMPLETEDPUBLISHTABLE_2
(
    ID          int          not null,
    RECORDID    varchar(40)  not null,
    SHEETNAME   varchar(256) not null,
    DISPLAYNAME varchar(256),
    PUB_TYPE    varchar(64)  not null
)
go

create table dbo.COMPLETEDRESULTTABLE_3
(
    PUBLISHID int          not null,
    RECORDID  varchar(40)  not null,
    PUB_TYPE  varchar(128) not null,
    STATUS    int          not null,
    DETAIL    varchar(256) not null
)
go

create table dbo.COMPLETEDTABLE_4
(
    ID               int          not null,
    RECORDID         varchar(128),
    TASKID           varchar(128) not null,
    TASKCLASS        varchar(256) not null,
    CATFILE          varchar(256),
    RPTFILE          varchar(256),
    PARAMFILE        varchar(256),
    RESULTFILE       varchar(1024),
    ERROR            varchar(256),
    ENGMSG           varchar(512),
    SUBMITTER        varchar(128),
    COMPLETEDTIME    bigint,
    FORMATEXISTS     int,
    FORMATSUCCESSFUL int,
    VERSIONID        int,
    LAUNCHTYPE       int,
    ISSUCCESSFUL     bit          not null,
    TASKNAME         varchar(128),
    ISMISSED         bit          not null,
    SCHEDULETRIGGER  varchar(80),
    CONDITIONSLOGIC  varchar(16),
    REPORTNAMES      varchar(512)
)
go

create table dbo.COMPLETED_CCD_INFO_1
(
    ID                  int not null
        unique,
    SVERSION            int,
    CATALOGID           int,
    CATALOGPATH         varchar(255),
    DATASOURCE          varchar(255),
    CONNNAME            varchar(255),
    LOGINUSER           varchar(255),
    LASTMODIFIED        bigint,
    PARAMFILE           varchar(255),
    CATALOGVERSION      int,
    CATALOGLASTMODIFIED bigint,
    STARTTIME           bigint,
    COMPLETEDTIME       bigint,
    SUCC                int,
    ACTIVITYTYPE        tinyint,
    MESSAGE             varchar(512)
)
go

create table dbo.COMPLETED_CRD_INFO_3
(
    ID                  int not null
        unique,
    SVERSION            int,
    CATALOGID           int,
    CATALOGPATH         varchar(255),
    DATASOURCE          varchar(255),
    QUERYTYPE           int,
    QUERYNAME           varchar(255),
    LASTMODIFIED        bigint,
    USERNAME            varchar(255),
    PWD                 varchar(255),
    PARAMFILE           varchar(255),
    LAZY                int,
    CATALOGVERSION      int,
    CATALOGLASTMODIFIED bigint,
    STARTTIME           bigint,
    COMPLETEDTIME       bigint,
    SUCC                int,
    BVNAME              varchar(255),
    ACTIVITYTYPE        tinyint,
    MESSAGE             varchar(512)
)
go

create table dbo.COMP_CRD_CONN_INFO_1
(
    ID       int
        references dbo.COMPLETED_CRD_INFO_3 (ID),
    CONNNAME varchar(256),
    USERNAME varchar(256),
    PWD      varchar(256)
)
go

create table dbo.CRD_INFO_5
(
    ID                  int not null
        unique,
    SVERSION            int,
    CATALOGID           int,
    CATALOGPATH         varchar(255),
    DATASOURCE          varchar(255),
    QUERYTYPE           int,
    QUERYNAME           varchar(255),
    LASTMODIFIED        bigint,
    USERNAME            varchar(255),
    PWD                 varchar(255),
    PARAMFILE           varchar(255),
    LAZY                int,
    RESULTVERSION       int,
    CATALOGVERSION      int,
    CATALOGLASTMODIFIED bigint,
    TASKID              varchar(255),
    CONFIGFILE          varchar(255),
    LOGINUSER           varchar(255),
    CACHETYPE           int,
    BVNAME              varchar(255),
    STATUS              tinyint,
    CREATETIME          bigint,
    MAXMEMORY           real,
    FLAGS               int,
    LOCATION            tinyint
)
go

create table dbo.CRDRUNDETAIL_1
(
    ID        int
        references dbo.CRD_INFO_5 (ID),
    ACTIVITY  tinyint,
    STARTTIME bigint,
    ENDTIME   bigint,
    SUCC      bit
)
go

create table dbo.CRD_CONN_INFO_1
(
    ID       int
        references dbo.CRD_INFO_5 (ID),
    CONNNAME varchar(256),
    USERNAME varchar(256),
    PWD      varchar(256)
)
go

create table dbo.CUSTOM_FIELD_1
(
    ID          int          not null,
    SVERSION    int,
    ENABLED     int,
    NAME        varchar(255) not null,
    DESCRIPTION varchar(256),
    unique (ID, NAME)
)
go

create table dbo.CUSTOM_FIELD_VALUE_1
(
    ID           int not null
        unique,
    SVERSION     int,
    NODEID       int,
    NODEREALPATH varchar(256),
    FIELDID      int,
    STRINGVALUE  varchar(256)
)
go

create table dbo.DASHBOARDLISTENER_1
(
    CLASSNAME   varchar(512) not null
        primary key,
    DESCRIPTION varchar(255),
    ENABLED     bit          not null,
    CREATETIME  bigint
)
go

create table dbo.DASHBOARDLISTENERTARGET_1
(
    CLASSNAME varchar(512)
        references dbo.DASHBOARDLISTENER_1,
    TARGET    varchar(512),
    APPLYTIME bigint
)
go

create table dbo.DRESULT_3
(
    REPORTSET         varchar(256),
    VERSIONNUMBER     bigint       not null,
    REPORT            varchar(256) not null,
    REPORTDISPLAYNAME varchar(256),
    RESULT            varchar(256) not null,
    VIEWEDFORMATS     bigint,
    PLSRESULTFMTS     bigint,
    SECCONSTRAINTFMTS bigint
)
go

create table dbo.DYNAMICNODE_5
(
    NAME                varchar(256) not null,
    ROOT                varchar(256) not null,
    REALPATH            varchar(256) not null,
    NODETYPE            tinyint      not null,
    ENABLEARCHIVEPOLICY bit          not null,
    DELETED             bit          not null,
    ACLID               int,
    DESCRIPTION         varchar(256),
    MAXVERSIONAMOUNT    int,
    ENABLELINKEDCAT     bit          not null,
    LINKEDCAT           varchar(256),
    USEINHERITED        bit          not null,
    ENABLENLS           bit          not null,
    STATUS              tinyint,
    LINKEDCATID         int
)
go

create table dbo.DYNAMICRESULT_2
(
    ID               int          not null,
    REPORTNAME       varchar(256) not null,
    VERSIONNUMBER    int          not null,
    CREATOR          varchar(256) not null,
    CREATEDTIME      bigint       not null,
    CATALOGVERNUM    int          not null,
    CATALOGRESNUM    int          not null,
    REPORTVERNUM     int          not null,
    REPORTRESNUM     int          not null,
    PARAMFILE        varchar(256),
    RESULTFILE       varchar(256) not null,
    RESULTFMTS       bigint       not null,
    LAUNCHTYPE       int          not null,
    TASKID           varchar(128),
    EXPIRATIONTIME   bigint       not null,
    EXPIRE           bit          not null,
    EXPIRATIONMETHOD int,
    REPORTAMOUNT     int
)
go

create table dbo.DYNAMIC_CONNECTIONS_3
(
    CONN_ID           int          not null
        primary key,
    ORG_NAME          varchar(256),
    CATALOG           varchar(512) not null,
    DATASOURCRE       varchar(256) not null,
    CONNECTION_NAME   varchar(256),
    CONN_PROPERTIES   image,
    DB_AND_COLLECTION image
)
go

create table dbo.DYNAMIC_CONNECTIONS_MAPPING_3
(
    CONN_ID        int          not null
        references dbo.DYNAMIC_CONNECTIONS_3,
    PRINCIPAL      varchar(512) not null,
    PRINCIPAL_TYPE varchar(64)  not null,
    DB_USER        varchar(256),
    DB_PASSWORD    varchar(256),
    primary key (CONN_ID, PRINCIPAL, PRINCIPAL_TYPE)
)
go

create table dbo.DYN_BVELE_NAME_1
(
    ID             int          not null
        primary key,
    ORG_NAME       varchar(256),
    CATALOG        varchar(512) not null,
    PRINCIPAL_NAME varchar(512),
    PRINCIPAL_TYPE varchar(64)  not null
)
go

create table dbo.DYN_BVELE_NAME_MAPPING_1
(
    ID             int          not null
        references dbo.DYN_BVELE_NAME_1,
    QUALIFIED_NAME varchar(512) not null,
    DISPLAY_NAME   varchar(128) not null
)
go

create table dbo.DYN_SECURITY_1
(
    ID                 int not null
        unique,
    SVERSION           int,
    CATALOG_PATH       varchar(255),
    SECURITY_FILE_NAME varchar(255),
    SECURITY_FILE_PATH varchar(255),
    TYPE               int
)
go

create table dbo.EXTENDACLENTRIES_3
(
    PRINCIPAL_NAME varchar(255) not null,
    PRINCIPAL_TYPE tinyint      not null,
    PERMISSIONS    int          not null,
    unique (PRINCIPAL_NAME, PRINCIPAL_TYPE)
)
go

create table dbo.FOLDERS_4
(
    ID                    int not null,
    REALPATH              varchar(256),
    OWNERNAME             varchar(256),
    MAXVERSIONAMOUNT      int not null,
    ARCHIVENEWVERSION     bit not null,
    ENABLEARCHIVEPOLICY   bit not null,
    IS_SHARED             bit not null,
    ENABLEDYNAMICRESOURCE bit not null
)
go

create table dbo.GROUPPROFILES_3
(
    GROUP_NAME     varchar(256),
    SUB_GROUP_NAME varchar(256)
)
go

create table dbo.GROUPS_4
(
    NAME        varchar(255) not null
        primary key,
    BUILDIN     bit          not null,
    DESCRIPTION varchar(256),
    GROUP_TYPE  int          not null
)
go

create table dbo.GUPROFILES_4
(
    GROUP_NAME varchar(256),
    USER_NAME  varchar(256)
)
go

create table dbo.HISTORY_PARAMLIST_TABLE_1
(
    ID     int          not null
        unique,
    REALM  varchar(256) not null,
    USER11 varchar(256) not null,
    FILE1  image        not null
)
go

create table dbo.JR_QRTZ_2_CALENDARS
(
    SCHED_NAME    varchar(120) not null,
    CALENDAR_NAME varchar(200) not null,
    CALENDAR      image        not null,
    primary key (SCHED_NAME, CALENDAR_NAME)
)
go

create table dbo.JR_QRTZ_2_FIRED_TRIGGERS
(
    SCHED_NAME        varchar(120) not null,
    ENTRY_ID          varchar(95)  not null,
    TRIGGER_NAME      varchar(200) not null,
    TRIGGER_GROUP     varchar(200) not null,
    INSTANCE_NAME     varchar(200) not null,
    FIRED_TIME        bigint       not null,
    PRIORITY          int          not null,
    STATE             varchar(16)  not null,
    JOB_NAME          varchar(200),
    JOB_GROUP         varchar(200),
    IS_NONCONCURRENT  bit,
    REQUESTS_RECOVERY bit,
    SCHED_TIME        bigint       not null,
    primary key (SCHED_NAME, ENTRY_ID)
)
go

create table dbo.JR_QRTZ_2_JOB_DETAILS
(
    SCHED_NAME        varchar(120) not null,
    JOB_NAME          varchar(200) not null,
    JOB_GROUP         varchar(200) not null,
    DESCRIPTION       varchar(250),
    JOB_CLASS_NAME    varchar(250) not null,
    IS_DURABLE        bit          not null,
    IS_NONCONCURRENT  bit          not null,
    IS_UPDATE_DATA    bit          not null,
    REQUESTS_RECOVERY bit          not null,
    JOB_DATA          image,
    primary key (SCHED_NAME, JOB_NAME, JOB_GROUP)
)
go

create table dbo.JR_QRTZ_2_LOCKS
(
    SCHED_NAME varchar(120) not null,
    LOCK_NAME  varchar(200) not null,
    primary key (SCHED_NAME, LOCK_NAME)
)
go

create table dbo.JR_QRTZ_2_PAUSED_TRIGGER_GRPS
(
    SCHED_NAME    varchar(120) not null,
    TRIGGER_GROUP varchar(200) not null,
    primary key (SCHED_NAME, TRIGGER_GROUP)
)
go

create table dbo.JR_QRTZ_2_SCHEDULER_STATE
(
    SCHED_NAME        varchar(120) not null,
    INSTANCE_NAME     varchar(200) not null,
    LAST_CHECKIN_TIME bigint       not null,
    CHECKIN_INTERVAL  bigint       not null,
    primary key (SCHED_NAME, INSTANCE_NAME)
)
go

create table dbo.JR_QRTZ_2_TRIGGERS
(
    SCHED_NAME     varchar(120) not null,
    TRIGGER_NAME   varchar(200) not null,
    TRIGGER_GROUP  varchar(200) not null,
    JOB_NAME       varchar(200) not null,
    JOB_GROUP      varchar(200) not null,
    DESCRIPTION    varchar(250),
    NEXT_FIRE_TIME bigint       not null,
    PREV_FIRE_TIME bigint       not null,
    PRIORITY       int          not null,
    TRIGGER_STATE  varchar(16)  not null,
    TRIGGER_TYPE   varchar(8)   not null,
    START_TIME     bigint       not null,
    END_TIME       bigint,
    CALENDAR_NAME  varchar(200),
    MISFIRE_INSTR  smallint,
    JOB_DATA       image,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    foreign key (SCHED_NAME, JOB_NAME, JOB_GROUP) references dbo.JR_QRTZ_2_JOB_DETAILS
)
go

create table dbo.JR_QRTZ_2_BLOB_TRIGGERS
(
    SCHED_NAME    varchar(120) not null,
    TRIGGER_NAME  varchar(200) not null,
    TRIGGER_GROUP varchar(200) not null,
    BLOB_DATA     image,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references dbo.JR_QRTZ_2_TRIGGERS
)
go

create table dbo.JR_QRTZ_2_CRON_TRIGGERS
(
    SCHED_NAME      varchar(120) not null,
    TRIGGER_NAME    varchar(200) not null,
    TRIGGER_GROUP   varchar(200) not null,
    CRON_EXPRESSION varchar(120) not null,
    TIME_ZONE_ID    varchar(80),
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references dbo.JR_QRTZ_2_TRIGGERS
)
go

create table dbo.JR_QRTZ_2_SIMPLE_TRIGGERS
(
    SCHED_NAME      varchar(120) not null,
    TRIGGER_NAME    varchar(200) not null,
    TRIGGER_GROUP   varchar(200) not null,
    REPEAT_COUNT    bigint       not null,
    REPEAT_INTERVAL bigint       not null,
    TIMES_TRIGGERED bigint       not null,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references dbo.JR_QRTZ_2_TRIGGERS
)
go

create table dbo.JR_QRTZ_2_SIMPROP_TRIGGERS
(
    SCHED_NAME    varchar(120) not null,
    TRIGGER_NAME  varchar(200) not null,
    TRIGGER_GROUP varchar(200) not null,
    STR_PROP_1    varchar(512),
    STR_PROP_2    varchar(512),
    STR_PROP_3    varchar(512),
    INT_PROP_1    int,
    INT_PROP_2    int,
    LONG_PROP_1   bigint,
    LONG_PROP_2   bigint,
    DEC_PROP_1    numeric,
    DEC_PROP_2    numeric,
    BOOL_PROP_1   bit,
    BOOL_PROP_2   bit,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references dbo.JR_QRTZ_2_TRIGGERS
)
go

create table dbo.LCVERSION_2
(
    VERSIONNUMBER int          not null,
    VERSIONNAME   varchar(128),
    RESOURCEID    int          not null,
    CREATOR       varchar(128),
    CREATEDTIME   bigint       not null,
    MODIFIER      varchar(128),
    MODIFIEDTIME  bigint       not null,
    LCFILE        varchar(512) not null,
    ID            bigint       not null
        unique,
    DISKSIZE      bigint
)
go

create table dbo.NODES_7
(
    ID              int          not null,
    NAME            varchar(256) not null,
    CREATORNAME     varchar(256) not null,
    CREATETIME      bigint       not null,
    PARENTID        int          not null,
    NODETYPE        tinyint      not null,
    ACLID           int,
    DESCRIPTION     varchar(256),
    ENABLELINKEDCAT bit,
    LINKEDCAT       varchar(256),
    USEINHERITED    bit,
    LINKEDCATID     int,
    ORGANIZATION    varchar(256)
)
go

create table dbo.ORGANIZATIONS_2
(
    NAME        varchar(255) not null
        primary key,
    DESCRIPTION varchar(256),
    USERAMOUNT  int
)
go

create table dbo.REPORTVERSION_4
(
    VERSIONNUMBER int          not null,
    VERSIONNAME   varchar(256),
    RESOURCEID    int          not null,
    CREATOR       varchar(256),
    CREATETIME    bigint       not null,
    MODIFIER      varchar(256),
    MODIFIEDTIME  bigint       not null,
    REPORTFILE    varchar(512) not null,
    ID            bigint       not null,
    DISKSIZE      bigint,
    unique (RESOURCEID, ID)
)
go

create table dbo.RESOURCEMAP_2
(
    RESOURCEID   int          not null,
    RESOURCENAME varchar(512) not null,
    RESOURCETYPE tinyint      not null
)
go

create table dbo.RESOURCENLS_2
(
    LOC          varchar(48)  not null,
    FOLDER_ID    int          not null,
    KEY_TEXT     varchar(256) not null,
    VALUE_TEXT   varchar(512) not null,
    ORGANIZATION varchar(32),
    primary key (LOC, FOLDER_ID, KEY_TEXT)
)
go

create table dbo.RESOURCENODES_5
(
    ID                  int     not null,
    RESOURCETYPE        tinyint not null,
    REALPATH            varchar(256),
    MAXVERSIONAMOUNT    int     not null,
    ARCHIVENEWVERSION   bit     not null,
    ENABLEARCHIVEPOLICY bit     not null,
    PROFILENAME         varchar(256),
    ENABLENLS           bit     not null,
    STATUS              tinyint,
    RESOURCESUBTYPE     tinyint
)
go

create table dbo.RESOURCE_LOCK
(
    LOCK_NAME varchar(512) not null
        primary key
)
go

create table dbo.RESOURCE_PROPS_1
(
    PROP_NAME   varchar(128) not null,
    RESOURCE_ID int          not null,
    CUS_KEY     varchar(255) not null,
    LOB_VAL     image,
    primary key (PROP_NAME, RESOURCE_ID, CUS_KEY)
)
go

create table dbo.RESULTVERSION_3
(
    ID                bigint       not null,
    VERSIONNUMBER     int          not null,
    VERSIONNAME       varchar(128) not null,
    RESOURCEID        int          not null,
    CREATOR           varchar(128),
    CREATEDTIME       bigint       not null,
    MODIFIER          varchar(128),
    MODIFIEDTIME      bigint       not null,
    CATALOGVERNUM     int          not null,
    CATALOGRESNUM     int          not null,
    REPORTVERNUM      int          not null,
    REPORTRESNUM      int          not null,
    PARAMFILE         varchar(128),
    RESULTFILE        varchar(128) not null,
    RESULTFMTS        bigint       not null,
    LAUNCHTYPE        int          not null,
    TASKID            varchar(128),
    EXPIRATIONTIME    bigint       not null,
    EXPIRE            bit          not null,
    EXPIREATIONMETHOD int,
    SPECIFIEDFOLDER   varchar(128),
    REPORTAMOUNT      int,
    DISKSIZE          bigint,
    unique (ID, RESOURCEID)
)
go

create table dbo.RESULT_3
(
    RESOURCEID        bigint       not null,
    VERSIONNUMBER     bigint       not null,
    REPORT            varchar(256) not null,
    REPORTDISPLAYNAME varchar(256),
    RESULT            varchar(256) not null,
    VIEWEDFORMATS     bigint,
    PLSRESULTFMTS     bigint,
    SECCONSTRAINTFMTS bigint
)
go

create table dbo.RGPROFILES_3
(
    ROLE_NAME  varchar(256),
    GROUP_NAME varchar(256)
)
go

create table dbo.ROLEPROFILES_4
(
    ROLE_NAME     varchar(256),
    SUB_ROLE_NAME varchar(256)
)
go

create table dbo.ROLES_5
(
    NAME        varchar(255) not null
        primary key,
    BUILDIN     bit          not null,
    DESCRIPTION varchar(256),
    ROLE_TYPE   int          not null
)
go

create table dbo.SCHDLASTEXETIME_1
(
    TASKID      varchar(40) not null,
    LASTEXETIME bigint      not null
)
go

create table dbo.SHORTCUTS_1
(
    ID        int not null,
    LINKTOID  int not null,
    ALLOWEDIT bit not null
)
go

create table dbo.STORAGE_MEMBER_1
(
    FILEID    int    not null,
    UNITINDEX int    not null,
    BITS      bigint not null,
    unique (FILEID, UNITINDEX)
)
go

create table dbo.STORAGE_RESOURCE_1
(
    ID            int          not null
        primary key,
    PATH          varchar(255) not null
        unique,
    ISDIRECTORY   bit          not null,
    LAST_MODIFIED bigint
)
go

create table dbo.TBL_DUAL_JINFONET
(
    DUAL_COL bit not null
)
go

create table dbo.TBL_IDGENRATOR_JINFONET
(
    TF_NAME varchar(64) not null
        primary key,
    NEXT_ID int         not null
)
go

create table dbo.TBL_LOCK_JINFONET
(
    LOCK_NAME varchar(255) not null
        primary key
)
go

create table dbo.TRIGGERS_1
(
    TRIGGER_NAME   varchar(80) not null
        primary key,
    DESCRIPTION    varchar(255),
    TRIGGER_TYPE   tinyint     not null,
    TRIGGER_STATE  bit         not null,
    PREV_FIRE_TIME bigint,
    NEXT_FIRE_TIME bigint
)
go

create table dbo.UPDATEDETAILS_1
(
    UPDATE_ITEM  varchar(32) not null
        primary key,
    UPDATE_STATE bit         not null
)
go

create table dbo.USERPROFILES_5
(
    USER_NAME varchar(256),
    ROLE_NAME varchar(256)
)
go

create table dbo.USERS_5
(
    NAME                  varchar(255) not null
        primary key,
    FULL_NAME             varchar(256),
    DESCRIPTION           varchar(256),
    EMAIL                 varchar(256),
    CREATE_TIME           bigint       not null,
    USER_PSWD             varchar(512),
    BUILDIN               bit          not null,
    ENABLE                bit          not null,
    MIN_PS_LENGTH         int,
    LAST_MODIFY_TIME      bigint,
    NEVER_EXPIRE          bit          not null,
    EXPIRE_TIME           int,
    ACCOUNT_DISABLE       bit          not null,
    ACCESS_EVENT_SUC      bit          not null,
    ACCESS_EVENT_FAIL     bit          not null,
    MANAGEMENT_EVENT_SUC  bit          not null,
    MANAGEMENT_EVENT_FAIL bit          not null,
    NO_AUDIT              bit          not null,
    AUTH_TYPE             int          not null,
    LDAP_TYPE             int,
    EXPIRED_ASK_CHANGE    bit          not null,
    RESET_ASK_CHANGE      bit          not null,
    HAS_RESET             bit          not null
)
go

create table dbo.USER_PROPS_1
(
    PROP_NAME    varchar(128) not null,
    CUS_NAME     varchar(512) not null,
    ORGANIZATION varchar(32)  not null,
    USERNAME     varchar(255) not null,
    PROP_VALUE   varchar(512),
    IS_LOB       bit          not null,
    LOB_VAL      image,
    primary key (PROP_NAME, CUS_NAME, ORGANIZATION, USERNAME)
)
go

create table dbo.VERSIONNODES_4
(
    ID             int    not null,
    RESOURCEID     int    not null,
    VERSIONNUMBER  int    not null,
    EXPIRATIONTIME bigint not null,
    AUTHOR         varchar(256),
    AUTHOREMAIL    varchar(256),
    BUILDINDESC    varchar(256),
    STATUS         tinyint
)
go

create table dbo.VISIBLEPRINCIPALS_1
(
    NAME             varchar(255) not null,
    TYPE             int          not null,
    VISIBLEPRINCIPAL varchar(256) not null,
    PRINCIPALTYPE    int          not null
)
go

