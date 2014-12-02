<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.datalook.model.sys.web.SessionInfo"%>
<%
	String contextPath = request.getContextPath();
	SessionInfo sessionInfo = (SessionInfo) session.getAttribute(com.datalook.util.base.ConfigUtil.getSessionName());
%>
<%-- 引入easyui扩展 --%>
<script src="<%=contextPath%>/js/EzuiEasyUI.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" charset="utf-8">
	var lockWindowFun = function() {
		$.post(ez.contextPath + '/sysUser!noSnSy_logout.action', function(result) {
			$('#loginDialog').dialog('open');
		}, 'json');
	};
	var logoutFun = function() {
		$.post(ez.contextPath + '/sysUser!noSnSy_logout.action', function(result) {
			location.replace(ez.contextPath + '/index.jsp');
		}, 'json');
	};
	var showMyInfoFun = function() {
		var dialog = parent.ez.modalDialog({
			title : '我的信息',
			url : ez.contextPath + '/pages/userInfo.jsp'
		});
	};
	
	var loginFun = function() {
		if ($('#loginDialog form').form('validate')) {
			$('#loginBtn').linkbutton('disable');
			$.post(ez.contextPath + '/sysUser!noSnSy_login.action', $('#loginDialog form').serialize(), function(result) {
				if (result.success) {
					$('#loginDialog').dialog('close');
				} else {
					$.messager.alert('提示', result.msg, 'error', function() {
						$('#loginDialog form :input:eq(1)').focus();
					});
				}
				$('#loginBtn').linkbutton('enable');
			}, 'json');
		}
	};
	$('#loginDialog').show().dialog({
		modal : true,
		closable : false,
		iconCls : 'ext-icon-lock_open',
		buttons : [ {
			id : 'loginBtn',
			text : '登录',
			handler : function() {
				loginFun();
			}
		} ],
		onOpen : function() {
			$('#loginDialog form :input[name="data.pwd"]').val('');
			$('form :input').keyup(function(event) {
				if (event.keyCode == 13) {
					loginFun();
				}
			});
		}
	}).dialog('close');
	
	$.extend($.fn.validatebox.defaults.rules, {
		eqPwd : {/* 验证两次密码是否一致功能 */
			validator : function(value, param) {
				return value == $(param[0]).val();
			},
			message : '密码不一致！'
		}
	});

	$('#passwordDialog').show().dialog({
		modal : true,
		closable : true,
		iconCls : 'ext-icon-lock_edit',
		buttons : [ {
			text : '修改',
			handler : function() {
				if ($('#passwordDialog form').form('validate')) {
					$.post(ez.contextPath + '/sysUser!noSy_updateCurrentUserPassword.action', {
						'data.password' : $('#password').val()
					}, function(result) {
						if (result.success) {
							$.messager.alert('提示', '密码修改成功！', 'info');
							$('#passwordDialog').dialog('close');
						}
					}, 'json');
				}
			}
		} ],
		onOpen : function() {
			$('#passwordDialog form :input').val('');
		}
	}).dialog('close');
	
	/* ----------插件安装---------- */
	$("#layout_north_cjazMenu").click(function(){
		var dialog = parent.ez.modalDialog({
			width : 450,
    		height : 200,
			title : '插件安装',
			url : ez.contextPath + '/opercard/installocx/installGrant.jsp'
		});
	});
	/* ----------插件安装---------- */
	/* ----------串口设置---------- */
	$("#layout_north_ckszMenu").click(function(){
		var dialog = parent.ez.modalDialog({
			width : 500,
    		height : 310,
			title : '串口设置',
			url : ez.contextPath + '/opercard/setComValue.jsp'
		});
	});
	/* ----------串口设置---------- */
</script>
<div id="sessionInfoDiv" style="position: absolute; right: 10px; top: 5px;">
	<%
		if (sessionInfo != null) {
			out.print(com.datalook.util.base.StringUtil.formateString("欢迎您，{0}", sessionInfo.getSysUser().getRealname()));
		}
	%>
</div>
<div style="position: absolute; right: 0px; bottom: 0px;">
	<!-- ***************************安装插件*************************** -->
		<a class="easyui-linkbutton" id="layout_north_cjazMenu" data-options="iconCls:'ext-icon-monitor_add',plain:true">插件安装</a>
	<!-- ***************************安装插件*************************** -->
	<!-- ***************************串口设置*************************** -->
		<a class="easyui-linkbutton" id="layout_north_ckszMenu" data-options="iconCls:'ext-icon-information',plain:true">串口设置</a>
	<!-- ***************************串口设置*************************** -->
	<a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_pfMenu',iconCls:'ext-icon-rainbow'">更换皮肤</a> 
	<a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_kzmbMenu',iconCls:'ext-icon-cog'">控制面板</a> 
	<a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_zxMenu',iconCls:'ext-icon-disconnect'">注销</a>
</div>
<div id="layout_north_pfMenu" style="width: 120px; display: none;">

	<div onclick="changeStyle('check');" title="选项框风格">选项框风格</div>
	<div onclick="changeStyle('icon');" title="图标风格">图标风格</div>

	<div class="menu-sep"></div>

	<div onclick="ez.changeTheme('default');" title="default">default</div>
	<div onclick="ez.changeTheme('gray');" title="gray">gray</div>
	<div onclick="ez.changeTheme('bootstrap');" title="bootstrap">bootstrap</div>
	<div onclick="ez.changeTheme('black');" title="black">black</div>
	<div onclick="ez.changeTheme('ui-cupertino');" title="ui-cupertino">ui-cupertino</div>
	<div onclick="ez.changeTheme('ui-dark-hive');" title="ui-dark-hive">ui-dark-hive</div>
	<div onclick="ez.changeTheme('ui-pepper-grinder');" title="ui-pepper-grinder">ui-pepper-grinder</div>
	<div onclick="ez.changeTheme('ui-sunny');" title="ui-sunny">ui-sunny</div>
	<div onclick="ez.changeTheme('metro');" title="metro">metro</div>
	<div onclick="ez.changeTheme('metro-blue');" title="metro-blue">metro-blue</div>
	<div onclick="ez.changeTheme('metro-gray');" title="metro-gray">metro-gray</div>
	<div onclick="ez.changeTheme('metro-green');" title="metro-green">metro-green</div>
	<div onclick="ez.changeTheme('metro-orange');" title="metro-orange">metro-orange</div>
	<div onclick="ez.changeTheme('metro-red');" title="metro-red">metro-red</div>
</div>
<div id="layout_north_kzmbMenu" style="width: 100px; display: none;">
	<div data-options="iconCls:'ext-icon-user_edit'" onclick="$('#passwordDialog').dialog('open');">修改密码</div>
<!-- 	<div class="menu-sep"></div>
	<div data-options="iconCls:'ext-icon-user'" onclick="showMyInfoFun();">我的信息</div>
 --></div>
<div id="layout_north_zxMenu" style="width: 100px; display: none;">
	<div data-options="iconCls:'ext-icon-lock'" onclick="lockWindowFun();">锁定窗口</div>
	<div class="menu-sep"></div>
	<div data-options="iconCls:'ext-icon-door_out'" onclick="logoutFun();">退出系统</div>
</div>
