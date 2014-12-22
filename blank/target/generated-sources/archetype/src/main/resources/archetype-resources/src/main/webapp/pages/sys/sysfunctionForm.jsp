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
<%@ include file="../../inc.jsp"%>
<script type="text/javascript">
	var submitForm = function(${symbol_dollar}dialog, ${symbol_dollar}grid, ${symbol_dollar}pjq, ${symbol_dollar}mainMenu) {
		if (${symbol_dollar}('form').form('validate')) {
			var url;
			if (${symbol_dollar}(':input[name="data.id"]').val().length > 0) {
				url = ez.contextPath + '/sysFunction!update.action';
			} else {
				url = ez.contextPath + '/sysFunction!save.action';
			}
			${symbol_dollar}.post(url, ez.serializeObject(${symbol_dollar}('form')), function(result) {
				if (result.success) {
					${symbol_dollar}grid.treegrid('reload');
					${symbol_dollar}dialog.dialog('destroy');
					${symbol_dollar}mainMenu.tree('reload');
				} else {
					${symbol_dollar}pjq.messager.alert('提示', result.msg, 'error');
				}
			}, 'json');
		}
	};
	var showIcons = function() {
		var dialog = parent.ez.modalDialog({
			title : '浏览小图标',
			url : ez.contextPath + '/style/icons.jsp',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.selectIcon(dialog, ${symbol_dollar}('${symbol_pound}iconCls'));
				}
			} ]
		});
	};
	${symbol_dollar}(function() {
		if (${symbol_dollar}(':input[name="data.id"]').val().length > 0) {
			parent.${symbol_dollar}.messager.progress({
				text : '数据加载中....'
			});
			${symbol_dollar}.post(ez.contextPath + '/sysFunction!getById.action', {
				'data.id' : ${symbol_dollar}(':input[name="data.id"]').val(),
			}, function(result) {
				if (result.id != undefined) {
					var data = ez.formLoadConvert(result);
					if (result.id != undefined) {
						${symbol_dollar}('${symbol_pound}ezAddAndUpdataform').form('load', data);
					}
					${symbol_dollar}('${symbol_pound}iconCls').attr('class', result.iconCls);//设置背景图标
				}
				parent.${symbol_dollar}.messager.progress('close');
			}, 'json');
		}
	});
</script>
</head>
<body>
	<form id="ezAddAndUpdataform" method="post" class="form">
		<input name="data.id" class="easyui-textboxs" type="hidden" value="<%=id%>" readonly="readonly" />
		<fieldset>
			<legend>功能基本信息</legend>
			<table class="table" style="width: 100%;">
				<tr>
					<th>资源名称</th>
					<td><input name="data.functionname" class="easyui-textboxs" data-options="required:true,validType:'length[1,16]',invalidMessage:'长度不能超过16个字符'" /></td>
					<th>资源路径</th>
					<td><input name="data.url" class="easyui-textboxs" data-options="validType:'length[0,100]',invalidMessage:'长度不能超过100个字符'" /></td>
				</tr>
				<tr>
					<th>上级资源</th>
					<td><select id="sysfunctionForm_id" name="data.sysFunction.id" class="easyui-combotree" data-options="editable:false,idField:'id',textField:'functionname',parentField:'pid',url:'<%=contextPath%>/sysFunction!noSy_getAllMenuWithRoot.action',value:0" style="width: 155px;"></select> <img class="iconImg ext-icon-cross" onclick="${symbol_dollar}('${symbol_pound}sysfunctionForm_id').combotree('clear');" title="清空" /></td>
					<th>资源图标</th>
					<td><input id="iconCls" name="data.iconCls" readonly="readonly" style="padding-left: 18px; width: 134px;" /> <img class="iconImg ext-icon-zoom" onclick="showIcons();" title="浏览图标" />&nbsp; <img class="iconImg ext-icon-cross" onclick="${symbol_dollar}('${symbol_pound}iconCls').val('');${symbol_dollar}('${symbol_pound}iconCls').attr('class','');" title="清空" /></td>
				</tr>
				<tr>
					<th>顺序</th>
					<td><input name="data.seq" class="easyui-numberspinner" data-options="required:true,min:-32767,max:32767,editable:true" style="width: 155px;" value="0" /></td>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>