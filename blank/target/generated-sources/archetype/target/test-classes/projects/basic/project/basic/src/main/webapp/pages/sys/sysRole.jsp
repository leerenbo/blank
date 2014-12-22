<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<%@ include file="../../inc.jsp"%>
<script type="text/javascript">
	var ezgrid;

	var save = function() {
		var dialog = parent.ez.modalDialog({
			title : '添加用户信息',
			url : ez.contextPath + '/pages/sys/sysRoleForm.jsp',
			buttons : [ {
				text : '添加',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, ezgrid, parent.$);
				}
			} ]
		});
	};

	var openGetById = function(row) {
		var dialog = parent.ez.modalDialog({
			title : '查看用户信息',
			url : ez.contextPath + '/pages/sys/sysRoleForm.jsp?id=' + row.id
		});
	}

	var openUpdate = function(row) {
		var dialog = parent.ez.modalDialog({
			title : '编辑用户信息',
			url : ez.contextPath + '/pages/sys/sysRoleForm.jsp?id=' + row.id,
			buttons : [ {
				text : '编辑',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, ezgrid, parent.$);
				}
			} ]
		});
	}

	var deleteByStatus = function() {
		var rows = ezgrid.datagrid('getChecked');
		parent.$.messager.confirm('询问', '您确定要删除记录？', function(r) {
			if (r) {
				var ids = [];
				for (var i = 0; i < rows.length; i++) {
					ids.push(rows[i].id);
				}
				$.post(ez.contextPath + '/sysRole!deleteByStatus.action', {
					'ids' : ids.join(',')
				}, function() {
					ezgrid.datagrid('reload');
					ezgrid.datagrid('clearChecked');
				}, 'json');
			}
		});
	};

	var openGrantSysFunction = function(row) {
		var dialog = parent.ez.modalDialog({
			title : '授权角色',
			url : ez.contextPath + '/pages/sys/sysRoleGrantsysFunction.jsp?id=' + row.id,
			buttons : [ {
				text : '授权',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, ezgrid, parent.$);
				}
			} ]
		});
	}

	$(function() {
		ezgrid = $('#ezgrid').datagrid({
			title : '',
			url : ez.contextPath + '/sysRole!datagridByPage.action?hqland_status_dengyu_String=1&hqland_id_budeng_Integer=1',
			striped : true,
			rownumbers : true,
			pagination : true,
			checkOnSelect : true,
			selectOnCheck : true,
			singleSelect : false,
			idField : 'id',
			sortName : 'seq',
			sortOrder : 'asc',
			frozenColumns : [ [ {
				field : 'ck',
				checkbox : true
			}, {
				width : '100',
				title : '角色名称',
				field : 'rolename',
				sortable : true
			} ] ],
			columns : [ [ {
				width : '60',
				title : '排序',
				field : 'seq',
				hidden : true,
				sortable : true
			} ] ],
			toolbar : '#eztoolbar',
			onBeforeLoad : function(param) {
				parent.$.messager.progress({
					text : '数据加载中....'
				});
			},
			onLoadSuccess : function(data) {
				$('.iconImg').attr('src', ez.pixel_0);
				parent.$.messager.progress('close');
			}
		});
	});
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div id="eztoolbar">
		<div>
			<form id="searchForm">
				<input name="hqland_rolename_mohu_String" class="easyui-textbox" style="width: 150px" data-options="prompt:'搜索角色名称'"></input>
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-zoom',plain:true" onclick="ezgrid.datagrid('load',ez.serializeObject($('#searchForm')));">查询</a>
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-zoom_out',plain:true" onclick="$('#searchForm input.easyui-textbox').textbox('setValue','');ezgrid.datagrid('load',{});">清空查询</a>
			</form>
		</div>

		<div>
			<s:if test="@it.pkg.util.base.SecurityUtil@havePermission('/sysRole!save')">
				<a onclick="save();" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_add',plain:true">添加</a>
			</s:if>
			<s:if test="@it.pkg.util.base.SecurityUtil@havePermission('/sysRole!getById')">
				<a onclick="ezgrid.datagrid('ezCheckedInvoke','openGetById');" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note',plain:true">查看</a>
			</s:if>
			<s:if test="@it.pkg.util.base.SecurityUtil@havePermission('/sysRole!update')">
				<a onclick="ezgrid.datagrid('ezCheckedInvoke','openUpdate');" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_edit',plain:true">编辑</a>
			</s:if>
			<s:if test="@it.pkg.util.base.SecurityUtil@havePermission('/sysRole!grantSysFunction')">
				<a onclick="ezgrid.datagrid('ezCheckedInvoke','openGrantSysFunction');" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-key',plain:true">授权</a>
			</s:if>
			<s:if test="@it.pkg.util.base.SecurityUtil@havePermission('/sysRole!deleteByStatus')">
				<a onclick="deleteByStatus();" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_delete',plain:true">删除</a>
			</s:if>
		</div>

	</div>
	<div data-options="region:'center',fit:true,border:false">
		<table id="ezgrid" data-options="fit:true,border:false"></table>
	</div>
</body>
</html>