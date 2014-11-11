<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<%@ include file="../../inc.jsp"%>
<script type="text/javascript">
	var grid;
	var addFun = function() {
		var dialog = parent.sy.modalDialog({
			title : '添加用户信息',
			url : datalook.contextPath + '/pages/sys/sysUserForm.jsp',
			buttons : [ {
				text : '添加',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
				}
			} ]
		});
	};
	var showFun = function(id) {
		var dialog = parent.sy.modalDialog({
			title : '查看用户信息',
			url : datalook.contextPath + '/pages/sys/sysUserForm.jsp?id=' + id
		});
	};
	var editFun = function(id) {
		var dialog = parent.sy.modalDialog({
			title : '编辑用户信息',
			url : datalook.contextPath + '/pages/sys/sysUserForm.jsp?id=' + id,
			buttons : [ {
				text : '编辑',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
				}
			} ]
		});
	};
	var removeFun = function(id) {
		parent.$.messager.confirm('询问', '您确定要删除此记录？', function(r) {
			if (r) {
				$.post(datalook.contextPath + '/sysUser!deleteByStatus.action', {
					'data.id':id
				}, function() {
					grid.datagrid('reload');
				}, 'json');
			}
		});
	};
	var removeFuns = function(rows) {
		parent.$.messager.confirm('询问', '您确定要删除记录？', function(r) {
			if (r) {
				var ids = [];
				for (var i = 0; i < rows.length; i++) {
					ids.push(rows[i].id);
				}
				$.post(datalook.contextPath + '/sysUser!deleteByStatus.action', {
					'ids' : ids.join(',')
				}, function() {
					grid.datagrid('reload');
					grid.datagrid('clearSelections');
				}, 'json');
			}
		});
	};

	var grantRoleFun = function(id) {
		var dialog = parent.sy.modalDialog({
			title : '授权角色',
			url : datalook.contextPath + '/pages/sys/sysUserRoleGrant.jsp?id=' + id,
			buttons : [ {
				text : '授权',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
				}
			} ]
		});
	};
	$(function() {
		grid = $('#grid').datagrid({
			title : '',
			url : datalook.contextPath + '/sysUser!grid.action?hqland_status_dengyu_String=1',
			striped : true,
			rownumbers : true,
			pagination : true,
			checkOnSelect:true,
			selectOnCheck:true,
			singleSelect:false,
			idField : 'id',
			sortName : 'id',
			sortOrder : 'desc',
			pageSize : 50,
			pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500 ],
			frozenColumns : [ [ 
   			<s:if test="@com.datalook.util.base.CookieUtil@haveKeyValue('easyuiStyle','check')">
   			{	                    
   				field:'ck',
   				checkbox:true
   			},
   			</s:if>
			{
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
		<s:if test="@com.datalook.util.base.CookieUtil@haveKeyValue('easyuiStyle','icon')">
			columns : [ [  {
				title : '操作',
				field : 'action',
				width : '90',
				formatter : function(value, row) {
					var str = '';
					<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/sysUser!getById')">
						str += sy.formatString('<img class="iconImg ext-icon-note" title="查看" onclick="showFun(\'{0}\');"/>', row.id);
					</s:if>
					<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/sysUser!update')">
						str += sy.formatString('<img class="iconImg ext-icon-note_edit" title="编辑" onclick="editFun(\'{0}\');"/>', row.id);
					</s:if>
					<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/sysUser!grantSysRole')">
						str += sy.formatString('<img class="iconImg ext-icon-user" title="用户角色" onclick="grantRoleFun(\'{0}\');"/>', row.id);
					</s:if>
					<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/sysUser!deleteByStatus')">
						str += sy.formatString('<img class="iconImg ext-icon-note_delete" title="删除" onclick="removeFun(\'{0}\');"/>', row.id);
					</s:if>
					return str;
				}
			} ] ],
		</s:if>
			toolbar : '#toolbar',
			onBeforeLoad : function(param) {
				parent.$.messager.progress({
					text : '数据加载中....'
				});
			},
			onLoadSuccess : function(data) {
				$('.iconImg').attr('src', sy.pixel_0);
				parent.$.messager.progress('close');
			}
		});
	});
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div id="toolbar" style="display: none;">
		<table>
			<tr>
				<td>
					<form id="searchForm">
						<table>
							<tr>
								<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/sysUser!save')">
								<td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_add',plain:true" onclick="addFun();">添加</a></td>
									</s:if>
								<s:if test="@com.datalook.util.base.CookieUtil@haveKeyValue('easyuiStyle','check')">
									<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/sysUser!getById')">
										<td><a onclick="showFun(grid.datagrid('getSelected').id);" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note',plain:true" >查看</a></td>
									</s:if>
									<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/sysUser!update')">
										<td><a onclick="editFun(grid.datagrid('getSelected').id);" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_edit',plain:true" >编辑</a></td>
									</s:if>
									<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/sysUser!grantSysRole')">
										<td><a onclick="grantRoleFun(grid.datagrid('getSelected').id);" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-key',plain:true" >授权</a></td>
									</s:if>
									<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/sysUser!deleteByStatus')">
										<td><a onclick="removeFuns(grid.datagrid('getSelections'));" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_delete',plain:true" >删除</a></td>
									</s:if>
								</s:if>
	 							<td><div class="datagrid-btn-separator"></div></td>
								<td>登陆账号</td>
								<td><input name="hqland_username_mohu_String" style="width: 80px;" /></td>
								<td>姓名</td>
								<td><input name="hqland_realname_mohu_String" style="width: 80px;" /></td>
								<td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-zoom',plain:true" onclick="grid.datagrid('load',sy.serializeObject($('#searchForm')));">过滤</a><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-zoom_out',plain:true" onclick="$('#searchForm input').val('');grid.datagrid('load',{});">重置过滤</a></td>
							</tr>
						</table>
					</form>
				</td>
			</tr>
			<tr>
				<td>
					<table>
						<tr>

<!--							<td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-table_add',plain:true" onclick="">导入</a></td>
							<td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-table_go',plain:true" onclick="">导出</a></td>
 -->						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
	<div data-options="region:'center',fit:true,border:false">
		<table id="grid" data-options="fit:true,border:false"></table>
	</div>
</body>
</html>