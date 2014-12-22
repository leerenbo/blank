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
				url = ez.contextPath + '/sysDict!update.action';
			} else {
				url = ez.contextPath + '/sysDict!save.action';
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

			${symbol_dollar}.post(ez.contextPath + '/sysDict!getById.action', {
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
		<fieldset>
			<legend>数据字典信息</legend>
			<table class="table" style="width: 100%;">
			
				<tr>
				<input name="data.id" type="hidden" value="<%=id%>" />
				<th>字典组</th>
				<td>
					<input name="data.location" class="easyui-textbox" data-options=""/>
				</td>
				<th>字典键</th>
				<td>
					<input name="data.value" class="easyui-textbox" data-options=""/>
				</td>
				</tr>
				<tr>
				<th>字典值</th>
				<td>
					<input name="data.text" class="easyui-textbox" data-options=""/>
				</td>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>