<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.datalook.model.sys.web.SessionInfo"%>
<%
	String contextPath = request.getContextPath();
	SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
%>
<%String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<title>SSHE</title>
<jsp:include page="../inc.jsp"></jsp:include>
<script type="text/javascript">
	var mainMenu;
	var mainTabs;

	$(function() {


		mainTabs = $('#mainTabs').tabs({
			fit : true,
			border : false,
			tools : [ {
				iconCls : 'ext-icon-arrow_up',
				handler : function() {
					mainTabs.tabs({
						tabPosition : 'top'
					});
				}
			}, {
				iconCls : 'ext-icon-arrow_left',
				handler : function() {
					mainTabs.tabs({
						tabPosition : 'left'
					});
				}
			}, {
				iconCls : 'ext-icon-arrow_down',
				handler : function() {
					mainTabs.tabs({
						tabPosition : 'bottom'
					});
				}
			}, {
				iconCls : 'ext-icon-arrow_right',
				handler : function() {
					mainTabs.tabs({
						tabPosition : 'right'
					});
				}
			}, {
				text : '刷新',
				iconCls : 'ext-icon-arrow_refresh',
				handler : function() {
					var panel = mainTabs.tabs('getSelected').panel('panel');
					var frame = panel.find('iframe');
					try {
						if (frame.length > 0) {
							for (var i = 0; i < frame.length; i++) {
								frame[i].contentWindow.document.write('');
								frame[i].contentWindow.close();
								frame[i].src = frame[i].src;
							}
							if (navigator.userAgent.indexOf("MSIE") > 0) {// IE特有回收内存方法
								try {
									CollectGarbage();
								} catch (e) {
								}
							}
						}
					} catch (e) {
					}
				}
			}, {
				text : '关闭',
				iconCls : 'ext-icon-cross',
				handler : function() {
					var index = mainTabs.tabs('getTabIndex', mainTabs.tabs('getSelected'));
					var tab = mainTabs.tabs('getTab', index);
					if (tab.panel('options').closable) {
						mainTabs.tabs('close', index);
					} else {
						$.messager.alert('提示', '[' + tab.panel('options').title + ']不可以被关闭！', 'error');
					}
				}
			} ]
		});

	});
</script>
</head>
<body id="mainLayout" class="easyui-layout">
	<div data-options="region:'north',href:'<%=contextPath%>/pages/north.jsp'" style="height: 70px; overflow: hidden;" class="logo"></div>
	<div data-options="region:'west',href:'<%=contextPath%>/sysFunction!noSy_makeMenu.action',split:true" title="导航" style="width:200px"></div>
	<div data-options="region:'center'" style="overflow: hidden;">
		<div id="mainTabs">
			<div title="欢迎页面" data-options="">
				<iframe src="<%=contextPath%>/welcome.jsp" allowTransparency="true" style="border: 0; width: 100%; height: 99%;" frameBorder="0"></iframe>
			</div>
		</div>
	</div>
	<div data-options="region:'south',href:'<%=contextPath%>/pages/south.jsp',border:false" style="height: 30px; overflow: hidden;"></div>
<div id="loginDialog" title="解锁登录" style="display: none;">
	<form method="post" class="form" onsubmit="return false;">
		<table class="table">
			<tr>
				<th width="50">账号</th>
				<td><%=sessionInfo.getSysUser().getUsername()%><input name="data.username" readonly="readonly" type="hidden" value="<%=sessionInfo.getSysUser().getUsername()%>" /></td>
			</tr>
			<tr>
				<th>密码</th>
				<td><input name="data.password" type="password" class="easyui-validatebox" data-options="required:true" /></td>
			</tr>
		</table>
	</form>
</div>

<div id="passwordDialog" title="修改密码" style="display: none;">
	<form method="post" class="form" onsubmit="return false;">
		<table class="table">
			<tr>
				<th>当前密码</th>
				<td><input id="nowpassword" name="nowpassword" type="password" class="easyui-validatebox" data-options="required:true,validType:{remote:['<%=basePath%>/sysUser!noSy_checkCurrentUserPassword.action','data.password']},invalidMessage:'密码错误'" /></td>
			</tr>
		
			<tr>
				<th>新密码</th>
				<td><input id="password" name="data.password" type="password" class="easyui-validatebox" data-options="required:true" /></td>
			</tr>
			<tr>
				<th>重复密码</th>
				<td><input type="password" class="easyui-validatebox" data-options="required:true,validType:'eqPwd[\'#password\']'" /></td>
			</tr>
		</table>
	</form>
</div>

</body>
</html>