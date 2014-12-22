#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>系统登录</title>
<jsp:include page="inc.jsp"></jsp:include>
<script type="text/javascript">
	${symbol_dollar}(function() {

		var loginFun = function() {
			var loginTabs = ${symbol_dollar}('${symbol_pound}loginTabs').tabs('getSelected');//当前选中的tab
			var ${symbol_dollar}form = loginTabs.find('form');//选中的tab里面的form
			if (${symbol_dollar}form.length == 1 && ${symbol_dollar}form.form('validate')) {
				${symbol_dollar}('${symbol_pound}loginBtn').linkbutton('disable');
				${symbol_dollar}.post(ez.contextPath + '/sysUser!noSnSy_login.action', ${symbol_dollar}form.serialize(), function(result) {
					if (result.success) {
						location.replace(ez.contextPath + '/index.jsp');
					} else {
						${symbol_dollar}.messager.alert('提示', result.msg, 'error', function() {
							${symbol_dollar}('${symbol_pound}loginBtn').linkbutton('enable');
						});
					}
				}, 'json');
			}
		};

		${symbol_dollar}('${symbol_pound}loginDialog').show().dialog({
			modal : false,
			closable : false,
			iconCls : 'ext-icon-lock_open',
			buttons : [ {
				id : 'loginBtn',
				text : '登录',
				width : '100px',
				handler : function() {
					loginFun();
				}
			} ],
			onOpen : function() {
				${symbol_dollar}('form :input:first').focus();
				${symbol_dollar}('form :input').keyup(function(event) {
					if (event.keyCode == 13) {
						loginFun();
					}
				});
			}
		});

	});
</script>
</head>
<body>
	<div id="loginDialog" title="系统登录" style="display: none; width: 320px; height: 180px; overflow: hidden;">
		<div id="loginTabs" class="easyui-tabs" data-options="fit:true,border:false">
			<div title="管理员登录" style="overflow: hidden; padding: 10px;">
				<form method="post" class="form">
				<input type="hidden" name="status" value="1"/>
					<table class="table" style="width: 100%; height: 100%;">
						<tr>
							<th width="50">账号</th>
							<td><input name="data.username" class="easyui-textbox" data-options="required:true,iconCls:'icon-man',missingMessage:'该输入项为必输项'" value="admin" style="width: 210px;" /></td>
						</tr>
						<tr>
							<th>密码</th>
							<td><input name="data.password" type="password" class="easyui-textbox" data-options="required:true,iconCls:'icon-lock',missingMessage:'该输入项为必输项'" value="admin" style="width: 210px;" /></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</body>
</html>