SET IDENTITY_INSERT [SYS_USER] ON
INSERT [SYS_USER] ([ID], [PASSWORD], [REALNAME], [STATUS], [USERNAME]) VALUES (1, N'21232f297a57a5a743894a0e4a801fc3', N'人力主管', N'1', N'admin')
SET IDENTITY_INSERT [SYS_USER] OFF
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (0, N'根', N'-1', NULL, NULL, NULL, 1, NULL)
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (1, N'系统设置', N'2', NULL, NULL, 0, 2, NULL)
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (2, N'功能管理', N'3', N'ext-icon-script_key', NULL, 1, 3, N'/pages/sys/sysFunction.jsp')
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (3, N'功能增加', N'0', N'ext-icon-bullet_wrench', NULL, 2, 4, N'/sysFunction!save')
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (4, N'功能删除', N'0', N'ext-icon-bullet_wrench', NULL, 2, 5, N'/sysFunction!deletePhysical')
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (5, N'功能编辑', N'0', N'ext-icon-bullet_wrench', NULL, 2, 6, N'/sysFunction!update')
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (6, N'功能列表查看', N'0', N'ext-icon-bullet_wrench', NULL, 2, 7, N'/sysFunction!treegridNoPage')
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (7, N'角色管理', N'3', N'ext-icon-vcard', NULL, 1, 8, N'/pages/sys/sysRole.jsp')
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (8, N'角色列表查看', N'0', N'ext-icon-bullet_wrench', NULL, 7, 9, N'/sysRole!datagridByPage')
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (9, N'角色添加', N'0', N'ext-icon-bullet_wrench', NULL, 7, 10, N'/sysRole!save')
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (10, N'角色删除', N'0', N'ext-icon-bullet_wrench', NULL, 7, 11, N'/sysRole!deleteByStatus')
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (11, N'角色编辑', N'0', N'ext-icon-bullet_wrench', NULL, 7, 12, N'/sysRole!update')
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (12, N'功能查询', N'0', N'ext-icon-bullet_wrench', NULL, 2, 13, N'/sysFunction!getById')
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (13, N'角色查看', N'0', N'ext-icon-bullet_wrench', NULL, 7, 14, N'/sysRole!getById')
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (21, N'角色功能授权', N'0', N'ext-icon-bullet_wrench', NULL, 7, 11, N'/sysRole!grantSysFunction')
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (14, N'用户管理', N'3', N'ext-icon-user_gray', NULL, 1, 15, N'/pages/sys/sysUser.jsp')
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (15, N'用户增加', N'0', N'ext-icon-bullet_wrench', NULL, 14, 16, N'/sysUser!save')
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (16, N'用户删除', N'0', N'ext-icon-bullet_wrench', NULL, 14, 17, N'/sysUser!deleteByStatus')
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (17, N'用户编辑', N'0', N'ext-icon-bullet_wrench', NULL, 14, 18, N'/sysUser!update')
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (18, N'用户查看', N'0', N'ext-icon-bullet_wrench', NULL, 14, 19, N'/sysUser!getById')
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (19, N'用户列表查看', N'0', N'ext-icon-bullet_wrench', NULL, 14, 20, N'/sysUser!datagridByPage')
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (20, N'用户角色编辑', N'0', N'ext-icon-bullet_wrench', NULL, 14, 21, N'/sysUser!grantSysRole')
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (100, N'系统监控', N'2', NULL, NULL, 0, 100, NULL)
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (101, N'项目监控', N'3', N'ext-icon-monitor', NULL, 100, 101, N'/monitoring')
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (102, N'数据源监控', N'3', N'ext-icon-database', NULL, 100, 102, N'/druid')
INSERT [SYS_FUNCTION] ([ID], [FUNCTIONNAME], [FUNCTIONTYPE], [ICONCLS], [IMG], [PID], [SEQ], [URL]) VALUES (103, N'Action映射监控', N'3', N'ext-icon-application_cascade', NULL, 100, 103, N'/config-browser/showConstants.action')
SET IDENTITY_INSERT [SYS_ROLE] ON
INSERT [SYS_ROLE] ([ID], [ROLENAME], [SEQ], [STATUS]) VALUES (1, N'超级管理员', 1, N'1')
SET IDENTITY_INSERT [SYS_ROLE] OFF
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 0)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 1)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 2)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 3)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 4)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 5)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 6)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 7)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 8)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 9)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 10)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 11)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 12)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 13)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 14)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 15)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 16)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 17)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 18)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 19)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 20)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 21)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 100)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 101)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 102)
INSERT [SYS_ROLE_FUNCTION_RELATION] ([ROLEID], [SYSFUNCTIONID]) VALUES (1, 103)
INSERT [SYS_USER_ROLE_RELATION] ([USERID], [ROLEID]) VALUES (1, 1)
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url,iconcls) values(30,'数据字典','3',1,30,'/pages/sys/sysDictDatagrid.jsp','ext-icon-book');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,30);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url,iconcls) values(31,'数据字典添加','0',30,31,'/sysDict!save','ext-icon-bullet_wrench');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,31);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url,iconcls) values(32,'数据字典编辑','0',30,32,'/sysDict!update','ext-icon-bullet_wrench');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,32);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url,iconcls) values(33,'数据字典详情','0',30,33,'/sysDict!getById','ext-icon-bullet_wrench');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,33);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url,iconcls) values(34,'数据字典列表','0',30,34,'/sysDict!datagridByPage','ext-icon-bullet_wrench');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,34);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url,iconcls) values(35,'数据字典删除','0',30,35,'/sysDict!deletePhysical','ext-icon-bullet_wrench');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,35);
INSERT [SYS_DICT]([LOCATION],[VALUE],[TEXT]) VALUES('com.datalook.model.sys.SysFunction.functiontype','0','操作')
INSERT [SYS_DICT]([LOCATION],[VALUE],[TEXT]) VALUES('com.datalook.model.sys.SysFunction.functiontype','2','滑动模块')
INSERT [SYS_DICT]([LOCATION],[VALUE],[TEXT]) VALUES('com.datalook.model.sys.SysFunction.functiontype','3','功能页面')


insert into SYS_DICT(location,value,text) values('com.datalook.model.test.Seat.tableNum','3','桌3');
insert into SYS_DICT(location,value,text) values('com.datalook.model.test.Seat.tableNum','2','桌2');
insert into SYS_DICT(location,value,text) values('com.datalook.model.test.Seat.tableNum','1','桌1');
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1000,'页面自动生成','2',0,1000,'');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1000);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1001,'晚会管理','3',1000,1001,'/pages/test/partyDatagrid.jsp');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1001);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1002,'晚会管理添加','0',1001,1002,'/party!save');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1002);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1003,'晚会管理编辑','0',1001,1003,'/party!update');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1003);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1004,'晚会管理详情','0',1001,1004,'/party!getById');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1004);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1005,'晚会管理列表','0',1001,1005,'/party!datagridByPage');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1005);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1006,'晚会管理删除','0',1001,1006,'/party!deletePhysical');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1006);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1007,'安排节目','0',1001,1007,'/party!relatePartyProgram');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1007);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1008,'人员管理','3',1000,1008,'/pages/test/personDatagrid.jsp');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1008);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1009,'人员管理添加','0',1008,1009,'/person!save');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1009);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1010,'人员管理编辑','0',1008,1010,'/person!update');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1010);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1011,'人员管理详情','0',1008,1011,'/person!getById');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1011);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1012,'人员管理列表','0',1008,1012,'/person!datagridByPage');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1012);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1013,'人员管理删除','0',1008,1013,'/person!deletePhysical');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1013);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1014,'安排节目','0',1008,1014,'/person!relatePersonProgram');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1014);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1015,'节目管理','3',1000,1015,'/pages/test/programDatagrid.jsp');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1015);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1016,'节目管理添加','0',1015,1016,'/program!save');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1016);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1017,'节目管理编辑','0',1015,1017,'/program!update');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1017);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1018,'节目管理详情','0',1015,1018,'/program!getById');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1018);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1019,'节目管理列表','0',1015,1019,'/program!datagridByPage');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1019);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1020,'节目管理删除','0',1015,1020,'/program!deletePhysical');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1020);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1021,'安排演员','0',1015,1021,'/program!relateProgramPerson');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1021);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1022,'座位管理','3',1000,1022,'/pages/test/seatDatagrid.jsp');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1022);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1023,'座位管理添加','0',1022,1023,'/seat!save');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1023);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1024,'座位管理编辑','0',1022,1024,'/seat!update');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1024);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1025,'座位管理详情','0',1022,1025,'/seat!getById');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1025);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1026,'座位管理列表','0',1022,1026,'/seat!datagridByPage');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1026);
insert into SYS_FUNCTION(id,functionname,functiontype,pid,seq,url) values(1027,'座位管理删除','0',1022,1027,'/seat!deleteByStatus');
insert into SYS_ROLE_FUNCTION_RELATION(roleid,sysfunctionid) values(1,1027);
