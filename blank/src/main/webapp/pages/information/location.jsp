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
			title : '添加工作地点信息',
			url : datalook.contextPath + '/pages/information/locationForm.jsp',
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
			title : '查看工作地点信息',
			url : datalook.contextPath + '/pages/information/locationForm.jsp?id=' + id
		});
	};
	var editFun = function(id) {
		var dialog = parent.sy.modalDialog({
			title : '编辑工作地点信息',
			url : datalook.contextPath + '/pages/information/locationForm.jsp?id=' + id,
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
				$.post(datalook.contextPath + '/location!deleteByStatus.action', {
					'data.id' : id
				}, function(result) {
					if(result.success){
						grid.datagrid('reload');
						grid.datagrid('clearSelections');
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
				$.post(datalook.contextPath + '/location!deleteByStatus.action', {
					'ids' : ids.join(',')
				}, function(result) {
					if(result.success){
						grid.datagrid('reload');
						grid.datagrid('clearSelections');
					} else {
						$.messager.alert('提示', result.msg, 'error');
					}
				}, 'json');
			}
		});
	};

	$(function() {
		grid = $('#grid').datagrid({
			title : '',
			url : datalook.contextPath + '/location!grid.action?hqland_status_dengyu_String=1',
			striped : true,
			rownumbers : true,
			pagination : true,
			checkOnSelect:true,
			selectOnCheck:true,
			singleSelect:false,
			idField : 'id',
			sortName : 'id',
			sortOrder : 'asc',
			frozenColumns : [ [ 
			<s:if test="@com.datalook.util.base.CookieUtil@haveKeyValue('easyuiStyle','check')">
			{	                    
				field:'ck',
				checkbox:true
			},
			</s:if>
				{
				width : '100',
				title : '工作地点',
				field : 'locationname',
				sortable : true
			} ] ],
			columns : [ [{
				width : '60',
				title : '排序',
				field : 'seq',
				hidden : true,
				sortable : true
			}
			<s:if test="@com.datalook.util.base.CookieUtil@haveKeyValue('easyuiStyle','icon')">
			, {
				title : '操作',
				field : 'action',
				width : '80',
				formatter : function(value, row) {
					var str = '';
						<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/location!getById')">
						str += sy.formatString('<img class="iconImg ext-icon-note" title="查看" onclick="showFun(\'{0}\');"/>', row.id);
					</s:if>
						<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/location!update')">
						str += sy.formatString('<img class="iconImg ext-icon-note_edit" title="编辑" onclick="editFun(\'{0}\');"/>', row.id);
					</s:if>
						<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/location!deleteByStatus')">
						str += sy.formatString('<img class="iconImg ext-icon-note_delete" title="删除" onclick="removeFun(\'{0}\');"/>', row.id);
					</s:if>
					return str;
				}
			} 
			</s:if>
			] ],
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
				<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/location!save')">
				<td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_add',plain:true" onclick="addFun();">添加</a></td>
				</s:if>
			<s:if test="@com.datalook.util.base.CookieUtil@haveKeyValue('easyuiStyle','check')">
				<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/location!getById')">
					<td><a onclick="showFun(grid.datagrid('getSelected').id);" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note',plain:true" >查看</a></td>
				</s:if>
				<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/location!update')">
					<td><a onclick="editFun(grid.datagrid('getSelected').id);" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_edit',plain:true" >编辑</a></td>
				</s:if>
				<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/location!deleteByStatus')">
					<td><a onclick="removeFuns(grid.datagrid('getSelections'));" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_delete',plain:true" >删除</a></td>
				</s:if>
			</s:if>
				<td><div class="datagrid-btn-separator"></div></td>
				<td>
					<input id="searchBox" class="easyui-searchbox" style="width: 150px" 
						data-options="
							searcher:function(value,name){
								grid.datagrid('load',{'hqland_locationname_mohu_String':value});
							}
							,prompt:'搜索工作地点'">
					</input>
				</td>
				<td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-zoom_out',plain:true" onclick="$('#searchBox').searchbox('setValue','');grid.datagrid('load',{});">清空查询</a></td>
			</tr>
		</table>
	</div>
	<div data-options="region:'center',fit:true,border:false">
		<table id="grid" data-options="fit:true,border:false"></table>
	</div>
</body>
</html>