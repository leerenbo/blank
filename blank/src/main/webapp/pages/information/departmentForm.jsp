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
	var submitForm = function($dialog, $grid, $pjq, $mainMenu) {
		if ($('form').form('validate')) {
			var url;
			if ($(':input[name="data.id"]').val().length > 0) {
				url = datalook.contextPath + '/department!update.action';
			} else {
				url = datalook.contextPath + '/department!save.action';
			}
			$.post(url, sy.serializeObject($('form')), function(result) {
				if (result.success) {
					$grid.treegrid('reload');
					$dialog.dialog('destroy');
					$mainMenu.tree('reload');
				} else {
					$pjq.messager.alert('提示', result.msg, 'error');
				}
			}, 'json');
		}
	};
	var showIcons = function() {
		var dialog = parent.sy.modalDialog({
			title : '浏览小图标',
			url : datalook.contextPath + '/style/icons.jsp',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.selectIcon(dialog, $('#iconCls'));
				}
			} ]
		});
	};
	$(function() {
		if ($(':input[name="data.id"]').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(datalook.contextPath + '/department!getById.action', {
				id : $(':input[name="data.id"]').val(),
			}, function(result) {
				if (result.id != undefined) {
					var locationId = "";
					if (result.location != undefined) {
						locationId = result.location.id;
					}
					$('form').form('load', {
						'data.id' : result.id,
						'data.departmentname' : result.departmentname,
						'data.location.id':	locationId,
						'data.pid': result.pid,
						'data.seq': result.seq
					});
					$('#iconCls').attr('class', result.iconCls);//设置背景图标
				}
				parent.$.messager.progress('close');
			}, 'json');
		}
	});
</script>
</head>
<body>
	<form method="post" class="form">
	<input type="hidden" name='data.status' value='1'>
		<fieldset>
			<legend>添加部门信息</legend>
			<table class="table" style="width: 100%;">
				<tr>
					<th>编号</th>
					<td><input name="data.id" class="easyui-textboxs" data-options="iconCls:'icon-search'" value="<%=id%>" readonly="readonly"/></td>
					<th>部门名称</th>
					<td><input name="data.departmentname" class="easyui-validatebox" data-options="required:true,validType:'length[1,16]',invalidMessage:'长度不能超过16个字符'" /></td>
				</tr>
				<tr>
					<th>办公地点</th>
					<td>
						<select id="departmentForm_id" name="data.location.id" class="easyui-combobox" data-options="required:true,editable:false,valueField:'id',textField:'locationname',url:'<%=contextPath%>/location!noSy_getLocation.action?hqland_status_dengyu_String=1'" style="width: 155px;" ></select>
						<img class="iconImg ext-icon-cross" onclick="$('#departmentForm_id').combotree('clear');" title="清空" />
					</td>
					<th>上级资源</th>
					<td>
						<select id="departmentForm_pid" name="data.pid" class="easyui-combotree" data-options="required:true,value:'100000',editable:false,idField:'id',textField:'departmentname',parentField:'pid',url :'<%=contextPath%>/department!treeGrid.action?hqland_status_dengyu_String=1'" style="width: 155px;"></select>
						<img class="iconImg ext-icon-cross" onclick="$('#departmentForm_pid').combotree('clear');" title="清空" />
					</td>
				</tr>
				<tr>
					<th>顺序</th>
					<td><input name="data.seq" class="easyui-numberspinner" data-options="required:true,min:-32767,max:32767,editable:true" style="width: 155px;" value="0" /></td>
					<th></th>
					<td></td>
				</tr>
				
			</table>
		</fieldset>
	</form>
</body>
</html>