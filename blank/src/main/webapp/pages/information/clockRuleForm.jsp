<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
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
	var submitForm = function($dialog, $grid, $pjq) {
		if ($('form').form('validate')) {
			var url;
			<% if(id.equals("")){%>
				url = datalook.contextPath + '/clockRule!save.action';
			<% }else{ %>
				url = datalook.contextPath + '/clockRule!update.action';
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
		if ($(':input[name="data.id"]').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(datalook.contextPath + '/clockRule!getById.action', {
				id : $(':input[name="data.id"]').val()
			}, function(result) {
				if (result.id != undefined) {
					$('form').form('load', {
						'data.id' : result.id,
						'data.clockname' : result.clockname,
						'data.receivetime' : result.receivetime,
						'data.clocktype' : result.clocktype,
						'data.righttime' : result.righttime,
						'data.endtime' : result.endtime
					});
				}
				parent.$.messager.progress('close');
			}, 'json');
		}
	});
</script>
</head>
<body>
	<form method="post" class="form">
	<input name="data.status" type="hidden" value="1" />
		<fieldset>
			<legend>添加打卡信息</legend>
			<table class="table" style="width: 100%;">
				<tr>
					<th>编号</th>
					<td><input name="data.id" value="<%=id%>" readonly="readonly" /></td>
					<th>打卡名称</th>
					<td><input name="data.clockname" class="easyui-validatebox" data-options="required:true,validType:'length[1,16]',invalidMessage:'长度不能超过16个字符'" /></td>
				</tr>
				<tr>
					<th>打卡类型</th>
					<td>
						<select name="data.clocktype" class="easyui-combobox" data-options="required:true,editable:false,panelHeight:'auto'" style="width: 155px;">
							<option value=0>上班打卡</option>
	    					<option value=1>下班打卡</option>
							<option value=2>加班上班打卡</option>
	    					<option value=3>加班下班打卡</option>
						</select>
					</td>
					
					<th>接受打卡时间</th>
					<td><input name="data.receivetime" class="easyui-timespinner" data-options="required:true,missingMessage:'该输入项为必填项'"/></td>
				</tr>
				
				<tr>
					<th>正点打卡时间</th>
					<td><input name="data.righttime" class="easyui-timespinner" data-options="required:true,missingMessage:'该输入项为必填项'"/></td>
					
					<th>结束打卡时间</th>
					<td><input name="data.endtime" class="easyui-timespinner" data-options="required:true,missingMessage:'该输入项为必填项'"/></td>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>