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
<jsp:include page="sysUserForm.jsp"/>
<!DOCTYPE html>
<html>
<head>
<title></title>
<script type="text/javascript">
	var submitForm = function(${symbol_dollar}dialog, ${symbol_dollar}grid, ${symbol_dollar}pjq) {
		var nodes = ${symbol_dollar}('${symbol_pound}tree').tree('getChecked', [ 'checked', 'indeterminate' ]);
		var ids = [];
		for (var i = 0; i < nodes.length; i++) {
			ids.push(nodes[i].id);
		}
		${symbol_dollar}.post(ez.contextPath + '/sysUser!grantSysRole.action', {
			'data.id' : ${symbol_dollar}(':input[name="data.id"]').val(),
			ids : ids.join(',')
		}, function(result) {
			if (result.success) {
				${symbol_dollar}dialog.dialog('destroy');
			} else {
				${symbol_dollar}pjq.messager.alert('提示', result.msg, 'error');
			}
			${symbol_dollar}pjq.messager.alert('提示', result.msg, 'info');
		}, 'json');
	};
	${symbol_dollar}(function() {
		parent.${symbol_dollar}.messager.progress({
			text : '数据加载中....'
		});
		${symbol_dollar}('${symbol_pound}tree').tree({
			url : ez.contextPath + '/sysRole!noSy_find.action?hqland_status_dengyu_String=1',
			parentField : 'pid',
			checkbox : true,
			formatter : function(node) {
				return node.rolename;
			},
			onLoadSuccess : function(node, data) {
				${symbol_dollar}.post(ez.contextPath + '/sysUser!noSy_getRolesByUserId.action', {
					'data.id' : ${symbol_dollar}(':input[name="data.id"]').val()
				}, function(result) {
					if (result) {
						for (var i = 0; i < result.length; i++) {
							var node = ${symbol_dollar}('${symbol_pound}tree').tree('find', result[i].id);
							if (node) {
								var isLeaf = ${symbol_dollar}('${symbol_pound}tree').tree('isLeaf', node.target);
								if (isLeaf) {
									${symbol_dollar}('${symbol_pound}tree').tree('check', node.target);
								}
							}
						}
					}
					parent.${symbol_dollar}.messager.progress('close');
				}, 'json');
			}
		});
	});
</script>
</head>
<body>
	<input name="data.id" value="<%=id%>" readonly="readonly" type="hidden" />
	<fieldset>
		<legend>所属角色</legend>
		<ul id="tree"></ul>
	</fieldset>
</body>
</html>