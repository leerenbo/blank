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
			if ($(':input[name="olddata.code"]').val().length > 0) {
				url = datalook.contextPath + '/kqPos!update.action';
			} else {
				url = datalook.contextPath + '/kqPos!save.action';
			}
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
		if ($(':input[name="olddata.code"]').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(datalook.contextPath + '/kqPos!getByCode.action', {
				'data.code' : $(':input[name="olddata.code"]').val()
			}, function(result) {
				if (result.code != undefined) {
					$('form').form('load', {
						'data.code' : result.code,
						'data.posname' : result.posname,
						'data.location.id' : result.location.id,
						'data.postype' : result.postype,
						'data.serialport' : result.serialport,
						'data.timelapse' : result.timelapse,
						'data.computerport' : result.computerport,
						'data.posport' : result.posport,
						'data.posip' : result.posip,
						'data.status' : result.status,
						'data.version' : result.version
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
	<input type="hidden" name="olddata.code" value="<%=id%>" />
		<fieldset>
			<legend>添加考勤信息</legend>
			<table class="table" style="width: 100%;">
				<tr>
					<th>编号</th>
					<td><input name="data.code" class="easyui-validatebox" data-options="required:true,validType:'length[1,4]',invalidMessage:'长度不能超过4个字符'" /></td>
					<th>考勤机名称</th>
					<td><input name="data.posname" class="easyui-validatebox" data-options="required:true,validType:'length[1,16]',invalidMessage:'长度不能超过16个字符'" /></td>
				</tr>
				<tr>
					<th>放置地点</th>
					<td>
						<select id="kqPosForm_location_id" name="data.location.id" class="easyui-combobox" data-options="required:true,editable:false,valueField:'id',textField:'locationname',url:'<%=contextPath%>/location!noSy_getLocation.action?hqland_status_dengyu_String=1'" style="width: 155px;" ></select>
						<img class="iconImg ext-icon-cross" onclick="$('#kqPosForm_location_id').combobox('clear');" title="清空" />
					</td>
					<th>设备版本号</th>
					<td><input name="data.version" class="easyui-numberbox" data-options="required:true,min:0,max:99999999,editable:true" /></td>
				</tr>
				<tr>
					<th>设备类型号</th>
					<td><input name="data.postype" class="easyui-numberbox" data-options="required:true,min:0,max:99999999,editable:true" /></td>
					<th>串行端口号</th>
					<td><input name="data.serialport" class="easyui-numberbox" data-options="required:true,min:0,max:99999999,editable:true" /></td>
				</tr>
				<tr>
					<th>延时</th>
					<td><input name="data.timelapse" class="easyui-validatebox" data-options="required:true,validType:'length[1,5]',invalidMessage:'长度不能超过5个字符'" /></td>
					<th>计算机端口</th>
					<td><input name="data.computerport" class="easyui-validatebox" data-options="required:true,validType:'length[1,10]',invalidMessage:'长度不能超过10个字符'" /></td>
				</tr>
				<tr>
					<th>考勤机端口</th>
					<td><input name="data.posport" class="easyui-validatebox" data-options="required:true,validType:'length[1,10]',invalidMessage:'长度不能超过10个字符'" /></td>
					<th>考勤机ip</th>
					<td><input name="data.posip" class="easyui-validatebox" data-options="required:true,validType:'length[1,32]',invalidMessage:'长度不能超过32个字符'" /></td>
				</tr>
				<tr>
					<th>考勤机状态</th>
					<td>
						<select name="data.status" class="easyui-combobox" data-options="required:true,editable:false,valueField:'id',textField:'name',panelHeight:'auto'" style="width: 155px;">
	    					<option value=1>正常</option>
	    					<option value=2>停用</option>
	    					<option value=3>错误</option>
						</select>
					</td>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>