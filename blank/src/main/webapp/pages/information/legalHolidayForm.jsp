<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
<%
	String date = request.getParameter("date");
	if (date == null) {
		date = "";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<jsp:include page="../../inc.jsp"></jsp:include>
<script type="text/javascript">
	var submitForm = function($dialog, $grid, $pjq) {
		if ($('form').form('validate')) {
			var url;
			<% if(date.equals("")){%>
				url = datalook.contextPath + '/legalHoliday!save.action';
			<% }else{ %>
				url = datalook.contextPath + '/legalHoliday!update.action';
			<% } %>
				$.post(url, sy.serializeObject($('form')), function(result) {
				if (result.success) {
					$grid.datagrid('load');
					$dialog.dialog('destroy');
				} else {
					$pjq.messager.alert('提示', result.msg, 'error');
				}
			}, 'json');
		}
	};
	
	$(function() {
		if ($(':input[name="startDate"]').val().length > 0) {
 			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(datalook.contextPath + '/legalHoliday!getByDate.action', {
				date : $(':input[name="startDate"]').val()
			}, function(result) {
				if (result.date != undefined) {
					$('form').form('load', {
						'data.name' : result.name
					});
				}
				parent.$.messager.progress('close');
			}, 'json');
 			$('#legalHolidayForm_startDate').datebox('readonly',true);
 			$('#legalHolidayForm_need_change').html('修改的日期');

 		}
	});
	
	
</script>
</head>
<body>
	<form method="post" class="form">
		<fieldset>
			<legend>添加每周休息日</legend>
			<table class="table" style="width: 100%;">
				<tr>
				
				
					<th id="legalHolidayForm_need_change">假期起始日期</th>
					<td><input id="legalHolidayForm_startDate" name="startDate" value="<%=date%>" class="easyui-datebox" data-options="required:true,editable:false"/></td>
			<% if(date.equals("")){%>
					<th >假期结束日期</th>
					<td><input name="endDate" class="easyui-datebox" data-options="required:true,editable:false"/></td>
			<% }else{ %>
			<% } %>
					
				</tr>
				<tr>
					<th>节日名称</th>
					<td><input name="data.name" class="easyui-validatebox" data-options="required:true,validType:'length[1,16]',invalidMessage:'长度不能超过16个字符'" /></td>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>