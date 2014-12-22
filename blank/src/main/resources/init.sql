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


