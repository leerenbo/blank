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
				url = ez.contextPath + '/sysRole!update.action';
			} else {
				url = ez.contextPath + '/sysRole!save.action';
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
			${symbol_dollar}.post(ez.contextPath + '/sysRole!getById.action', {
				'data.id' : ${symbol_dollar}(':input[name="data.id"]').val()
			}, function(result) {
				var data = ez.formLoadConvert(result);
				if (result.id != undefined) {
					${symbol_dollar}('${symbol_pound}ezAddAndUpdataform').form('load', data);
				}
				parent.${symbol_dollar}.messager.progress('close');
			}, 'json');
		}
	});
</script>
</head>
<body>
	<form id="ezAddAndUpdataform" method="post" class="form">
		<input name="data.status" type="hidden" value="1" />
		<input name="data.id" type="hidden" value="<%=id%>" readonly="readonly" />
		<fieldset>
			<legend>角色基本信息</legend>
			<table class="table" style="width: 100%;">
				<tr>
					<th>角色名称</th>
					<td><input name="data.rolename" class="easyui-textbox" data-options="required:true,validType:'length[1,16]',invalidMessage:'长度不能超过16个字符'" /></td>
					<th>顺序</th>
					<td><input name="data.seq" class="easyui-numberspinner" data-options="required:true,min:-32767,max:32767,editable:true,missingMessage:'该输入项为必输项'" style="width: 155px;" value="0" /></td>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>