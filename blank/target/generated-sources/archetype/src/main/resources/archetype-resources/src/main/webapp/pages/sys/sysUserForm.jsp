#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	if (id == null) {
		id = "";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<jsp:include page="../../inc.jsp"></jsp:include>
<script type="text/javascript">
	var submitForm = function(${symbol_dollar}dialog, ${symbol_dollar}grid, ${symbol_dollar}pjq) {
		if (${symbol_dollar}('form').form('validate')) {
			var url;
			if (${symbol_dollar}(':input[name="data.id"]').val().length > 0) {
				url = ez.contextPath + '/sysUser!update.action';
			} else {
				url = ez.contextPath + '/sysUser!save.action';
			}
			${symbol_dollar}('${symbol_pound}ezAddAndUpdataform').form('submit', {
				url : url,
				onSubmit : function() {
					// do some check
					// return false to prevent submit;
					return true;
				},
				success : function(result) {
					result = ${symbol_dollar}.parseJSON(result);
					${symbol_dollar}pjq.messager.alert('提示', result.msg, 'info');
					${symbol_dollar}grid.datagrid('load');
					${symbol_dollar}dialog.dialog('destroy');
				}
			});
		}
	};
	${symbol_dollar}(function() {
		if (${symbol_dollar}(':input[name="data.id"]').val().length > 0) {
			parent.${symbol_dollar}.messager.progress({
				text : '数据加载中....'
			});

			${symbol_dollar}.post(ez.contextPath + '/sysUser!getById.action', {
				'data.id' : ${symbol_dollar}(':input[name="data.id"]').val()
			}, function(result) {
				if (result.id != undefined) {
					var data = ez.formLoadConvert(result);
					if (result.id != undefined) {
						${symbol_dollar}('${symbol_pound}ezAddAndUpdataform').form('load', data);
					}
				}
				parent.${symbol_dollar}.messager.progress('close');
			}, 'json');
		}
	});
</script>
</head>
<body>
	<form id="ezAddAndUpdataform" method="post" enctype="multipart/form-data" class="form">
		<input type="hidden" name="data.status" value="1"></input>
		<input type="hidden" name="data.password" value=""></input>
		<input type="hidden" name="data.id" value="<%=id%>" readonly="readonly" />
		<fieldset>
			<legend>用户基本信息</legend>
			<table class="table" style="width: 100%;">
				<tr>
					<th>姓名</th>
					<td><input name="data.realname" class="easyui-textbox" data-options="required:true,validType:'length[1,16]',invalidMessage:'长度不能超过16个字符'" /></td>
					<th>登陆帐号</th>
					<td><input name="data.username" class="easyui-textbox" data-options="required:true,validType:'length[1,16]',invalidMessage:'长度不能超过16个字符'" /></td>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>