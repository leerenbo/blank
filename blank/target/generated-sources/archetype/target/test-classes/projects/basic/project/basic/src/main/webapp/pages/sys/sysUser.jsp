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
			url : ez.contextPath + '/pages/sys/sysUserForm.jsp',
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
			url : ez.contextPath + '/pages/sys/sysUserForm.jsp?id=' + row.id
		});
	}

	var openUpdate = function(row) {
		var dialog = parent.ez.modalDialog({
			title : '编辑用户信息',
			url : ez.contextPath + '/pages/sys/sysUserForm.jsp?id=' + row.id,
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
				$.post(ez.contextPath + '/sysUser!deleteByStatus.action', {
					'ids' : ids.join(',')
				}, function() {
					ezgrid.datagrid('reload');
					ezgrid.datagrid('clearChecked');
				}, 'json');
			}
		});
	};

	var openGrantSysRole = function(row) {
		var dialog = parent.ez.modalDialog({
			title : '授权角色',
			url : ez.contextPath + '/pages/sys/sysUserGrantsysRole.jsp?id=' + row.id,
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
			url : ez.contextPath + '/sysUser!datagridByPage.action?hqland_status_dengyu_String=1&hqland_id_budeng_Integer=1',
			striped : true,
			rownumbers : true,
			pagination : true,
			checkOnSelect : true,
			selectOnCheck : true,
			singleSelect : false,
			idField : 'id',
			sortName : 'id',
			sortOrder : 'desc',
			pageSize : 50,
			pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500 ],
			frozenColumns : [ [ {
				field : 'ck',
				checkbox : true
			}, {
				width : '100',
				title : '登陆账号',
				field : 'username',
				sortable : true
			}, {
				width : '80',
				title : '姓名',
				field : 'realname',
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
	<div id="eztoolbar" style="display: none;">
		<div>
			<form id="searchForm">
				登陆账号:
				<input id=name class="easyui-textbox" name="hqland_username_mohu_String" style="width: 80px;" />
				姓名:
				<input id=word class="easyui-textbox" name="hqland_realname_mohu_String" style="width: 80px;" />
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-zoom',plain:true" onclick="ezgrid.datagrid('load',ez.serializeObject($('#searchForm')));">查询</a>
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-zoom_out',plain:true" onclick="$('#searchForm input.easyui-textbox').textbox('setValue','');ezgrid.datagrid('load',{});">清空查询</a>
			</form>
		</div>
		<div>
			<s:if test="@it.pkg.util.base.SecurityUtil@havePermission('/sysUser!save')">
				<a onclick="save();" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_add',plain:true">添加</a>
			</s:if>
			<s:if test="@it.pkg.util.base.SecurityUtil@havePermission('/sysUser!getById')">
				<a onclick="ezgrid.datagrid('ezCheckedInvoke','openGetById');" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note',plain:true">查看</a>
			</s:if>
			<s:if test="@it.pkg.util.base.SecurityUtil@havePermission('/sysUser!update')">
				<a onclick="ezgrid.datagrid('ezCheckedInvoke','openUpdate');" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_edit',plain:true">编辑</a>
			</s:if>
			<s:if test="@it.pkg.util.base.SecurityUtil@havePermission('/sysUser!grantSysRole')">
				<a onclick="ezgrid.datagrid('ezCheckedInvoke','openGrantSysRole');" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-key',plain:true">授权</a>
			</s:if>
			<s:if test="@it.pkg.util.base.SecurityUtil@havePermission('/sysUser!deleteByStatus')">
				<a onclick="deleteByStatus();" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_delete',plain:true">删除</a>
			</s:if>
		</div>
	</div>
	<div data-options="region:'center',fit:true,border:false">
		<table id="ezgrid" data-options="fit:true,border:false"></table>
	</div>
</body>
</html>