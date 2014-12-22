/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     2014/9/22 10:57:27                           */
/*==============================================================*/

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SYS_FUNCTION') and o.name = 'FK_SYS_FUNC_REFERENCE_SYS_FUNC')
alter table SYS_FUNCTION
   drop constraint FK_SYS_FUNC_REFERENCE_SYS_FUNC
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SYS_OPERATION_LOG') and o.name = 'FK_SYS_OPER_REFERENCE_SYS_FUNC')
alter table SYS_OPERATION_LOG
   drop constraint FK_SYS_OPER_REFERENCE_SYS_FUNC
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SYS_OPERATION_LOG') and o.name = 'FK_SYS_OPER_REFERENCE_SYS_USER')
alter table SYS_OPERATION_LOG
   drop constraint FK_SYS_OPER_REFERENCE_SYS_USER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SYS_ROLE_FUNCTION_RELATION') and o.name = 'FK_SYS_ROLE_REFERENCE_SYS_ROLE')
alter table SYS_ROLE_FUNCTION_RELATION
   drop constraint FK_SYS_ROLE_REFERENCE_SYS_ROLE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SYS_ROLE_FUNCTION_RELATION') and o.name = 'FK_SYS_ROLE_REFERENCE_SYS_FUNC')
alter table SYS_ROLE_FUNCTION_RELATION
   drop constraint FK_SYS_ROLE_REFERENCE_SYS_FUNC
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SYS_USER_DEPARTMENT_MANAGE') and o.name = 'FK_SYS_USER_REFERENCE_SYS_USER')
alter table SYS_USER_DEPARTMENT_MANAGE
   drop constraint FK_SYS_USER_REFERENCE_SYS_USER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SYS_USER_DEPARTMENT_MANAGE') and o.name = 'FK_SYS_USER_REFERENCE_DEPARTME')
alter table SYS_USER_DEPARTMENT_MANAGE
   drop constraint FK_SYS_USER_REFERENCE_DEPARTME
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SYS_USER_ROLE_RELATION') and o.name = 'FK_SYS_USER_REFERENCE_SYS_USER2')
alter table SYS_USER_ROLE_RELATION
   drop constraint FK_SYS_USER_REFERENCE_SYS_USER2
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SYS_USER_ROLE_RELATION') and o.name = 'FK_SYS_USER_REFERENCE_SYS_ROLE')
alter table SYS_USER_ROLE_RELATION
   drop constraint FK_SYS_USER_REFERENCE_SYS_ROLE
go


if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_FUNCTION')
            and   type = 'U')
   drop table SYS_FUNCTION
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_OPERATION_LOG')
            and   type = 'U')
   drop table SYS_OPERATION_LOG
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_PARAM_DEF')
            and   type = 'U')
   drop table SYS_PARAM_DEF
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_ROLE')
            and   type = 'U')
   drop table SYS_ROLE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_ROLE_FUNCTION_RELATION')
            and   type = 'U')
   drop table SYS_ROLE_FUNCTION_RELATION
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_USER')
            and   type = 'U')
   drop table SYS_USER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_USER_DEPARTMENT_MANAGE')
            and   type = 'U')
   drop table SYS_USER_DEPARTMENT_MANAGE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_USER_ROLE_RELATION')
            and   type = 'U')
   drop table SYS_USER_ROLE_RELATION
go

/*==============================================================*/
/* Table: SYS_FUNCTION                                          */
/*==============================================================*/
create table SYS_FUNCTION (
   ID                   int                  not null,
   FUNCTIONNAME         varchar(50)          null,
   SEQ                  smallint             null,
   PID                  int                  null,
   FUNCTIONTYPE         varchar(2)           null,
   URL                  varchar(100)         null,
   ICONCLS              varchar(50)          null,
   IMG                  varchar(50)          null,
   constraint PK_SYS_FUNCTION primary key nonclustered (ID)
)
go

if exists (select 1 
from sys.extended_properties 
where major_id = object_id('SYS_FUNCTION') 
and minor_id = 0 and name = 'MS_Description') 
begin 
declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_FUNCTION' 
 
end 

select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description', 
'SYS_FUNCTION', 
'user', @CurrentUser, 'table', 'SYS_FUNCTION'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_FUNCTION')
and B.Name = 'ID' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_FUNCTION', 'column', 'ID'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'主键',
'user', @CurrentUser, 'table', 'SYS_FUNCTION', 'column', 'ID'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_FUNCTION')
and B.Name = 'FUNCTIONNAME' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_FUNCTION', 'column', 'FUNCTIONNAME'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'功能名称',
'user', @CurrentUser, 'table', 'SYS_FUNCTION', 'column', 'FUNCTIONNAME'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_FUNCTION')
and B.Name = 'SEQ' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_FUNCTION', 'column', 'SEQ'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'同级功能顺序',
'user', @CurrentUser, 'table', 'SYS_FUNCTION', 'column', 'SEQ'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_FUNCTION')
and B.Name = 'PID' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_FUNCTION', 'column', 'PID'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'父功能id',
'user', @CurrentUser, 'table', 'SYS_FUNCTION', 'column', 'PID'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_FUNCTION')
and B.Name = 'FUNCTIONTYPE' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_FUNCTION', 'column', 'FUNCTIONTYPE'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'类型，0功能，1滑动级菜单，2树展开级菜单，3页面添加级菜单',
'user', @CurrentUser, 'table', 'SYS_FUNCTION', 'column', 'FUNCTIONTYPE'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_FUNCTION')
and B.Name = 'URL' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_FUNCTION', 'column', 'URL'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'页面或action地址',
'user', @CurrentUser, 'table', 'SYS_FUNCTION', 'column', 'URL'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_FUNCTION')
and B.Name = 'ICONCLS' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_FUNCTION', 'column', 'ICONCLS'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'功能小图标类名',
'user', @CurrentUser, 'table', 'SYS_FUNCTION', 'column', 'ICONCLS'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_FUNCTION')
and B.Name = 'IMG' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_FUNCTION', 'column', 'IMG'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'功能大图标路径',
'user', @CurrentUser, 'table', 'SYS_FUNCTION', 'column', 'IMG'
go

/*==============================================================*/
/* Table: SYS_OPERATION_LOG                                     */
/*==============================================================*/
create table SYS_OPERATION_LOG (
   ID                   int                  identity,
   USERID               int                  null,
   SYSFUNCTIONID        int                  null,
   OPERATEDETAIL        varchar(50)          null,
   OPERATETIME          datetime             null,
   constraint PK_SYS_OPERATION_LOG primary key nonclustered (ID)
)
go

if exists (select 1 
from sys.extended_properties 
where major_id = object_id('SYS_OPERATION_LOG') 
and minor_id = 0 and name = 'MS_Description') 
begin 
declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_OPERATION_LOG' 
 
end 

select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description', 
'SYS_OPERATION_LOG', 
'user', @CurrentUser, 'table', 'SYS_OPERATION_LOG'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_OPERATION_LOG')
and B.Name = 'ID' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_OPERATION_LOG', 'column', 'ID'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'自增主键',
'user', @CurrentUser, 'table', 'SYS_OPERATION_LOG', 'column', 'ID'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_OPERATION_LOG')
and B.Name = 'USERID' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_OPERATION_LOG', 'column', 'USERID'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'操作员id',
'user', @CurrentUser, 'table', 'SYS_OPERATION_LOG', 'column', 'USERID'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_OPERATION_LOG')
and B.Name = 'SYSFUNCTIONID' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_OPERATION_LOG', 'column', 'SYSFUNCTIONID'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'功能id',
'user', @CurrentUser, 'table', 'SYS_OPERATION_LOG', 'column', 'SYSFUNCTIONID'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_OPERATION_LOG')
and B.Name = 'OPERATEDETAIL' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_OPERATION_LOG', 'column', 'OPERATEDETAIL'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'操作的内容',
'user', @CurrentUser, 'table', 'SYS_OPERATION_LOG', 'column', 'OPERATEDETAIL'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_OPERATION_LOG')
and B.Name = 'OPERATETIME' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_OPERATION_LOG', 'column', 'OPERATETIME'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'操作时间',
'user', @CurrentUser, 'table', 'SYS_OPERATION_LOG', 'column', 'OPERATETIME'
go

/*==============================================================*/
/* Table: SYS_ROLE                                              */
/*==============================================================*/
create table SYS_ROLE (
   ID                   int                  identity,
   ROLENAME             varchar(32)          null,
   SEQ                  smallint             null,
   STATUS               varchar(2)           null,
   constraint PK_SYS_ROLE primary key nonclustered (ID)
)
go

if exists (select 1 
from sys.extended_properties 
where major_id = object_id('SYS_ROLE') 
and minor_id = 0 and name = 'MS_Description') 
begin 
declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_ROLE' 
 
end 

select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description', 
'ROLE', 
'user', @CurrentUser, 'table', 'SYS_ROLE'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_ROLE')
and B.Name = 'ID' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_ROLE', 'column', 'ID'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'自增主键',
'user', @CurrentUser, 'table', 'SYS_ROLE', 'column', 'ID'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_ROLE')
and B.Name = 'ROLENAME' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_ROLE', 'column', 'ROLENAME'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'角色名称',
'user', @CurrentUser, 'table', 'SYS_ROLE', 'column', 'ROLENAME'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_ROLE')
and B.Name = 'SEQ' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_ROLE', 'column', 'SEQ'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'角色顺序',
'user', @CurrentUser, 'table', 'SYS_ROLE', 'column', 'SEQ'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_ROLE')
and B.Name = 'STATUS' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_ROLE', 'column', 'STATUS'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'角色状态，0删除，1正常',
'user', @CurrentUser, 'table', 'SYS_ROLE', 'column', 'STATUS'
go

/*==============================================================*/
/* Table: SYS_ROLE_FUNCTION_RELATION                            */
/*==============================================================*/
create table SYS_ROLE_FUNCTION_RELATION (
   ROLEID               int                  null,
   SYSFUNCTIONID        int                  null
)
go

if exists (select 1 
from sys.extended_properties 
where major_id = object_id('SYS_ROLE_FUNCTION_RELATION') 
and minor_id = 0 and name = 'MS_Description') 
begin 
declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_ROLE_FUNCTION_RELATION' 
 
end 

select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description', 
'ROLE_FUCTION_RELATION', 
'user', @CurrentUser, 'table', 'SYS_ROLE_FUNCTION_RELATION'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_ROLE_FUNCTION_RELATION')
and B.Name = 'ROLEID' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_ROLE_FUNCTION_RELATION', 'column', 'ROLEID'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'角色id',
'user', @CurrentUser, 'table', 'SYS_ROLE_FUNCTION_RELATION', 'column', 'ROLEID'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_ROLE_FUNCTION_RELATION')
and B.Name = 'SYSFUNCTIONID' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_ROLE_FUNCTION_RELATION', 'column', 'SYSFUNCTIONID'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'功能id',
'user', @CurrentUser, 'table', 'SYS_ROLE_FUNCTION_RELATION', 'column', 'SYSFUNCTIONID'
go

/*==============================================================*/
/* Table: SYS_USER                                              */
/*==============================================================*/
create table SYS_USER (
   ID                   int                  identity,
   REALNAME             varchar(32)          null,
   USERNAME             varchar(32)          null,
   PASSWORD             varchar(32)          null,
   STATUS               varchar(2)           null,
   constraint PK_SYS_USER primary key nonclustered (ID)
)
go

if exists (select 1 
from sys.extended_properties 
where major_id = object_id('SYS_USER') 
and minor_id = 0 and name = 'MS_Description') 
begin 
declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_USER' 
 
end 

select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description', 
'USER', 
'user', @CurrentUser, 'table', 'SYS_USER'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_USER')
and B.Name = 'ID' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'ID'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'自增主键',
'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'ID'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_USER')
and B.Name = 'REALNAME' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'REALNAME'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'用户姓名',
'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'REALNAME'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_USER')
and B.Name = 'USERNAME' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'USERNAME'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'账号',
'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'USERNAME'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_USER')
and B.Name = 'PASSWORD' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'PASSWORD'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'密码',
'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'PASSWORD'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_USER')
and B.Name = 'STATUS' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'STATUS'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'状态，0删除，1正常',
'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'STATUS'
go


/*==============================================================*/
/* Table: SYS_USER_ROLE_RELATION                                */
/*==============================================================*/
create table SYS_USER_ROLE_RELATION (
   USERID               int                  null,
   ROLEID               int                  null
)
go

create table SYS_DICT (
location varchar(50) not null,
code varchar(10) not null,
text text, 
value varchar(255), 
primary key (location, code)
)
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_USER_ROLE_RELATION')
and B.Name = 'USERID' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_USER_ROLE_RELATION', 'column', 'USERID'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'用户id',
'user', @CurrentUser, 'table', 'SYS_USER_ROLE_RELATION', 'column', 'USERID'
go

if exists (select 1
FROM sysobjects As A INNER JOIN syscolumns As B ON A.id = B.id
INNER JOIN sys.extended_properties As C ON C.major_id = A.id 
AND ( minor_id = B.colid)
where A.id = object_id('SYS_USER_ROLE_RELATION')
and B.Name = 'ROLEID' AND C.name='MS_Description')
begin
declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
'user', @CurrentUser, 'table', 'SYS_USER_ROLE_RELATION', 'column', 'ROLEID'


end

select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
'角色id',
'user', @CurrentUser, 'table', 'SYS_USER_ROLE_RELATION', 'column', 'ROLEID'
go

alter table SYS_FUNCTION
   add constraint FK_SYS_FUNC_REFERENCE_SYS_FUNC foreign key (PID)
      references SYS_FUNCTION (ID)
go

alter table SYS_OPERATION_LOG
   add constraint FK_SYS_OPER_REFERENCE_SYS_FUNC foreign key (SYSFUNCTIONID)
      references SYS_FUNCTION (ID)
go

alter table SYS_OPERATION_LOG
   add constraint FK_SYS_OPER_REFERENCE_SYS_USER foreign key (USERID)
      references SYS_USER (ID)
go

alter table SYS_ROLE_FUNCTION_RELATION
   add constraint FK_SYS_ROLE_REFERENCE_SYS_ROLE foreign key (ROLEID)
      references SYS_ROLE (ID)
go

alter table SYS_ROLE_FUNCTION_RELATION
   add constraint FK_SYS_ROLE_REFERENCE_SYS_FUNC foreign key (SYSFUNCTIONID)
      references SYS_FUNCTION (ID)
go

alter table SYS_USER_ROLE_RELATION
   add constraint FK_SYS_USER_REFERENCE_SYS_USER2 foreign key (USERID)
      references SYS_USER (ID)
go

alter table SYS_USER_ROLE_RELATION
   add constraint FK_SYS_USER_REFERENCE_SYS_ROLE foreign key (ROLEID)
      references SYS_ROLE (ID)
go

