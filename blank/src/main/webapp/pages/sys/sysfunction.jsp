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
			title : '添加功能信息',
			url : datalook.contextPath + '/pages/sys/sysfunctionForm.jsp',
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
			title : '编辑功能信息',
			url : datalook.contextPath + '/pages/sys/sysfunctionForm.jsp?id=' + id,
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
				$.post(datalook.contextPath + '/sysFunction!delete.action', {
					'data.id' : id
				}, function() {
					grid.treegrid('reload');
					grid.treegrid('clearSelections');
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
				$.post(datalook.contextPath + '/sysFunction!delete.action', {
					'ids' : ids.join(',')
				}, function() {
					grid.treegrid('reload');
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
			url : datalook.contextPath+'/sysFunction!treeGrid.action?hqland_id_budeng_Integer=0',
			idField : 'id',
			treeField : 'functionname',
			parentField : 'pid',
			checkbox : true,
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
				title : '功能名称',
				field : 'functionname'
			} ] ],
			columns : [ [ {
				width : '200',
				title : '图标路径',
				field : 'iconCls'
			}, {
				width : '200',
				title : '功能路径',
				field : 'url',
				formatter : function(value, row) {
					if(value){
						return sy.formatString('<span title="{0}">{1}</span>', value, value);
					}
				}
			}, {
				width : '60',
				title : '功能类型',
				field : 'functiontype',
				formatter : function(value, row) {
					if(row.functiontype=='0'){
						return '操作';
					}
/* 					if(row.functiontype=='1'){
						return '板块';
					}
 */					if(row.functiontype=='2'){
						return '滑动模块';
					}
					if(row.functiontype=='3'){
						return '功能页面';
					}
					return value;
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
					<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/sysFunction!update')">
						str += sy.formatString('<img class="iconImg ext-icon-note_edit" title="编辑" onclick="editFun(\'{0}\');"/>', row.id);
					</s:if>
					<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/sysFunction!delete')">
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
				<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/sysFunction!save')">
					<td><a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_add',plain:true" >添加</a></td>
				</s:if>
				<s:if test="@com.datalook.util.base.CookieUtil@haveKeyValue('easyuiStyle','check')">
					<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/sysFunction!update')">
						<td><a onclick="editFun(grid.datagrid('getSelected').id);" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_edit',plain:true" >编辑</a></td>
					</s:if>
					<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/sysFunction!delete')">
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