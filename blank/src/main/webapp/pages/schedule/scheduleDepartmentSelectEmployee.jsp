<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
<%
	String id = request.getParameter("id");
	String scheduledate=request.getParameter("scheduledate");
	if (id == null) {
		id = "";
	}
%>
<!DOCTYPE html>
<html>
<jsp:include page="../../inc.jsp"></jsp:include>
<script type="text/javascript">
	var submitForm = function($dialog, $grid, $pjq) {
		var nodes = $('#tree').tree('getChecked', [ 'checked', 'indeterminate' ]);
		var ids = [];
		for (var i = 0; i < nodes.length; i++) {
			ids.push(nodes[i].id);
		}
		$.post(datalook.contextPath + '/scheduleDepartment!useToEmployeeSchedule.action', {
			'data.scheduledate':$('#scheduledate').val(),
			ids : ids.join(',')
		}, function(result) {
			if (result.success) {
				$dialog.dialog('destroy');
			} else {
				$pjq.messager.show('提示', result.msg);
			}
			$pjq.messager.alert('提示', '排班成功！', 'info');
		}, 'json');
	};
	$(function() {
		parent.$.messager.progress({
			text : '数据加载中....'
		});
		$('#tree').tree({
			url : datalook.contextPath + '/department!noSnSy_findEmployeeByDepartment.action?data.id='+$('#departmentid').val()+'&data.status=1',
			checkbox : true,
			formatter : function(node) {
				return node.employeename+'('+node.employeenumber+')';
			},
			onLoadSuccess : function(node, data) {
				parent.$.messager.progress('close');
			}
		});
	});
</script>
	<fieldset>
	
		<input id="departmentid" name="data.id" value="<%=id%>" readonly="readonly" type="hidden" />
		<input id="scheduledate" value="<%=scheduledate%>" readonly="readonly" type="hidden" />
		<legend>员工</legend>
		<ul id="tree"></ul>
	</fieldset>
</html>