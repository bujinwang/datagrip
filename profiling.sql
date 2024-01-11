use LogiReport_Profiling
go

create table dbo.RESOURCE_LOCK
(
    LOCK_NAME varchar(512) not null
        primary key
)
go

create table dbo.TASKAUDIT
(
    ID            int not null
        primary key,
    TASK_ID       varchar(128),
    REPORT_NAME   varchar(256),
    CATALOG_NAME  varchar(256),
    CATALOG_NAMES image,
    USER_NAME     varchar(128),
    TASK_TYPE     int,
    TASK_STATUS   int,
    PAGE_NUMBER   int,
    RUN_TIMES     int,
    SUBMIT_TIME   bigint,
    START_TIME    bigint,
    COMPLETE_TIME bigint,
    FAIL_REASON   varchar(256),
    PARAMETERS    image
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

