use LogiReport_System
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

create table dbo.GLOBAL_NLS_FONT_2
(
    LOC         varchar(48) not null,
    ORG_FACE    varchar(20) not null,
    ORG_SIZE    int         not null,
    TAR_FACE    varchar(20) not null,
    TAR_SIZE    int         not null,
    IS_RELATIVE bit         not null,
    primary key (LOC, ORG_FACE, ORG_SIZE)
)
go

create table dbo.GLOBAL_NLS_FORMAT_2
(
    LOC          varchar(48)  not null,
    KEY_FORMAT   varchar(255) not null,
    VALUE_FORMAT varchar(512) not null,
    primary key (LOC, KEY_FORMAT)
)
go

create table dbo.GLOBAL_NLS_TEXT_2
(
    LOC        varchar(48)  not null,
    NLS_TYPE   int          not null,
    KEY_TEXT   varchar(255) not null,
    VALUE_TEXT varchar(512) not null,
    primary key (LOC, NLS_TYPE, KEY_TEXT)
)
go

create table dbo.MEMBERS
(
    MEMBER_ID int         not null
        primary key,
    RMI_HOST  varchar(32) not null,
    RMI_PORT  int         not null
)
go

create table dbo.RESOURCE_LOCK
(
    LOCK_NAME varchar(512) not null
        primary key
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

create table dbo.UPDATEDETAILS_1
(
    UPDATE_ITEM  varchar(32) not null
        primary key,
    UPDATE_STATE bit         not null
)
go

