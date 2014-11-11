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
			title : '添加部门信息',
			url : datalook.contextPath + '/pages/information/departmentForm.jsp',
			buttons : [ {
				text : '添加',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$, parent.mainMenu);
				}
			} ]
		});
	};
	var editFun = function(id) {
		var dialog = parent.sy.modalDialog({
			title : '编辑部门信息',
			url : datalook.contextPath + '/pages/information/departmentForm.jsp?id=' + id,
			buttons : [ {
				text : '编辑',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$, parent.mainMenu);
				}
			} ]
		});
	};
	var removeFun = function(id) {
		parent.$.messager.confirm('询问', '您确定要删除此记录？', function(r) {
			if (r) {
				$.post(datalook.contextPath + '/department!deleteByStatus.action', {
					'data.id' : id
				}, function(result) {
					if(result.success){
						grid.treegrid('reload');
						parent.mainMenu.tree('reload');
					} else {
						$.messager.alert('提示', result.msg, 'error');
					}
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
				$.post(datalook.contextPath + '/department!deleteByStatus.action', {
					'ids' : ids.join(',')
				}, function(result) {
					if(result.success){
						grid.treegrid('reload');
						grid.treegrid('clearSelections');
					} else {
						$.messager.alert('提示', result.msg, 'error');
					}
				}, 'json');
			}
		});
	};

	var redoFun = function() {
		var node = grid.treegrid('getSelected');
		if (node) {
			grid.treegrid('expandAll', node.id);
		} else {
			grid.treegrid('expandAll');
		}
	};
	var undoFun = function() {
		var node = grid.treegrid('getSelected');
		if (node) {
			grid.treegrid('collapseAll', node.id);
		} else {
			grid.treegrid('collapseAll');
		}
	};
	$(function() {
		grid = $('#grid').treegrid({
			title : '',
			url : datalook.contextPath+'/department!treeGrid.action?hqland_id_budeng_Integer=100000&&hqland_status_dengyu_String=1',
			idField : 'id',
			treeField : 'departmentname',
			parentField : 'pid',
			rownumbers : true,
			pagination : false,
			sortName : 'seq',
			sortOrder : 'asc',
			checkOnSelect:true,
			selectOnCheck:true,
			singleSelect:false,
			frozenColumns : [ [
		<s:if test="@com.datalook.util.base.CookieUtil@haveKeyValue('easyuiStyle','check')">
   			{	                    
   				field:'ck',
   				checkbox:true
   			},
		</s:if>
			{
				width : '200',
				title : '部门名称',
				field : 'departmentname'
			} ] ],
			columns : [ [ {
				width : '200',
				title : '部门工作地点',
				field : 'locationname',
				formatter : function(value, row) {
					if (row.location == undefined) {
						return "";
					}
					return row.location.locationname;
				}
			}, {
				width : '80',
				title : '排序',
				field : 'seq',
				hidden : true
			}
			<s:if test="@com.datalook.util.base.CookieUtil@haveKeyValue('easyuiStyle','icon')">
			, {
				title : '操作',
				field : 'action',
				width : '60',
				formatter : function(value, row) {
					var str = '';
					<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/department!update')">
						str += sy.formatString('<img class="iconImg ext-icon-note_edit" title="编辑" onclick="editFun(\'{0}\');"/>', row.id);
					</s:if>
					<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/department!deleteByStatus')">
						str += sy.formatString('<img class="iconImg ext-icon-note_delete" title="删除" onclick="removeFun(\'{0}\');"/>', row.id);
					</s:if>
					return str;
				}
			} 
			</s:if>
			] ],
			toolbar : '#toolbar',
			onBeforeLoad : function(row, param) {
				parent.$.messager.progress({
					text : '数据加载中....'
				});
			},
			onLoadSuccess : function(row, data) {
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
			<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/department!save')">
				<td><a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_add',plain:true" >添加</a></td>
			</s:if>
		<s:if test="@com.datalook.util.base.CookieUtil@haveKeyValue('easyuiStyle','check')">
			<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/department!update')">
				<td><a onclick="editFun(grid.datagrid('getSelected').id);" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_edit',plain:true" >编辑</a></td>
			</s:if>
			<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/department!deleteByStatus')">
				<td><a onclick="removeFuns(grid.datagrid('getSelections'));" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_delete',plain:true" >删除</a></td>
			</s:if>
		</s:if>
				<td><div class="datagrid-btn-separator"></div></td>
				<td>
					<a onclick="redoFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'ext-icon-resultset_next'">展开</a>
					<a onclick="undoFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'ext-icon-resultset_previous'">折叠</a>
				</td>
				<td><div class="datagrid-btn-separator"></div></td>
				<td>
					<a onclick="grid.treegrid('reload');" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'ext-icon-arrow_refresh'">刷新</a>
				</td>
			</tr>
		</table>
	</div>
	<div data-options="region:'center',fit:true,border:false">
		<table id="grid" data-options="fit:true,border:false"></table>
	</div>
</body>
</html>