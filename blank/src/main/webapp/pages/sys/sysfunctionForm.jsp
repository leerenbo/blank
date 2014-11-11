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
				url = datalook.contextPath + '/sysFunction!update.action';
			} else {
				url = datalook.contextPath + '/sysFunction!save.action';
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
			$.post(datalook.contextPath + '/sysFunction!getById.action', {
				id : $(':input[name="data.id"]').val(),
			}, function(result) {
				if (result.id != undefined) {
					$('form').form('load', {
						'data.id' : result.id,
						'data.functionname' : result.functionname,
						'data.url' : result.url,
						'data.functiontype' : result.functiontype,
						'data.pid' : result.pid ? result.pid : '',
						'data.iconCls' : result.iconCls,
						'data.seq' : result.seq,
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
		<fieldset>
			<legend>功能基本信息</legend>
			<table class="table" style="width: 100%;">
				<tr>
					<th>编号</th>
					<td><input name="data.id" class="easyui-textboxs" data-options="iconCls:'icon-search'" value="<%=id%>" readonly="readonly"/></td>
					<th>资源名称</th>
					<td><input name="data.functionname" class="easyui-validatebox" data-options="required:true,validType:'length[1,16]',invalidMessage:'长度不能超过16个字符'" /></td>
				</tr>
				<tr>
					<th>资源路径</th>
					<td><input name="data.url" class="easyui-validatebox" data-options="validType:'length[0,100]',invalidMessage:'长度不能超过100个字符'" /></td>
					<th>资源类型</th>
					<td>
						<select name="data.functiontype" class="easyui-combobox" data-options="required:true,editable:false,panelHeight:'auto'" style="width: 155px;">
							<option value=0>操作</option>
	    					<!-- <option value=1>板块</option> -->
	    					<option value=2>滑动模块</option>
	    					<option value=3>功能页面</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>上级资源</th>
					<td>
						<select id="sysfunctionForm_id" name="data.pid" class="easyui-combotree" data-options="editable:false,idField:'id',textField:'functionname',parentField:'pid',url:'<%=contextPath%>/sysFunction!noSy_getAllMenuWithRoot.action',value:0" style="width: 155px;"></select>
						<img class="iconImg ext-icon-cross" onclick="$('#sysfunctionForm_id').combotree('clear');" title="清空" />
					</td>
					<th>资源图标</th>
					<td>
						<input id="iconCls" name="data.iconCls" readonly="readonly" style="padding-left: 18px; width: 134px;" />
						<img class="iconImg ext-icon-zoom" onclick="showIcons();" title="浏览图标" />&nbsp;
						<img class="iconImg ext-icon-cross" onclick="$('#iconCls').val('');$('#iconCls').attr('class','');" title="清空" />
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