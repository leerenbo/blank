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
			title : '添加休息日',
			url : datalook.contextPath + '/pages/information/legalHolidayForm.jsp',
			buttons : [ {
				text : '添加',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
				}
			} ]
		});
	};
	var addWeek = function() {
		var dialog = parent.sy.modalDialog({
			title : '添加每周休息日',
			url : datalook.contextPath + '/pages/information/legalHolidayWeekForm.jsp',
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
			title : '查看休息日信息',
			url : datalook.contextPath + '/pages/information/legalHolidayForm.jsp?date=' + id
		});
	};
	var editFun = function(id) {
		var dialog = parent.sy.modalDialog({
			title : '编辑休息日信息',
			url : datalook.contextPath + '/pages/information/legalHolidayForm.jsp?date=' + id,
			buttons : [ {
				text : '编辑',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
				}
			} ]
		});
	};
	var removeFun = function(date) {
		parent.$.messager.confirm('询问', '您确定要删除此记录？', function(r) {
			if (r) {
				$.post(datalook.contextPath + '/legalHoliday!deleteByDate.action', {
					'Date' : date
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
					ids.push(rows[i].date);
				}
				$.post(datalook.contextPath + '/legalHoliday!deleteByDate.action', {
					'ids' : ids.join(',')
				}, function() {
					grid.datagrid('reload');
					grid.datagrid('clearSelections');
				}, 'json');
			}
		});
	};

	$(function() {
		grid = $('#grid').datagrid({
			title : '',
			url : datalook.contextPath + '/legalHoliday!grid.action',
			striped : true,
			rownumbers : true,
			pagination : true,
			checkOnSelect:true,
			selectOnCheck:true,
			singleSelect:false,
			idField : 'date',
			sortName : 'date',
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
				title : '日期',
				field : 'date',
				sortable : true
			} ] ],
			columns : [ [  {
				width : '300',
				title : '节假日名称',
				field : 'name',
				sortable : true
			}
			<s:if test="@com.datalook.util.base.CookieUtil@haveKeyValue('easyuiStyle','icon')">
			, {
				title : '操作',
				field : 'action',
				width : '80',
				formatter : function(value, row) {
					var str = '';
					<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/legalHoliday!getByDate')">
						str += sy.formatString('<img class="iconImg ext-icon-note" title="查看" onclick="showFun(\'{0}\');"/>', row.date);
					</s:if>	
					<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/legalHoliday!update')">
						str += sy.formatString('<img class="iconImg ext-icon-note_edit" title="编辑" onclick="editFun(\'{0}\');"/>', row.date);
					</s:if>	
					<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/legalHoliday!deleteByDate')">
						str += sy.formatString('<img class="iconImg ext-icon-note_delete" title="删除" onclick="removeFun(\'{0}\');"/>', row.date);
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
	}
	);
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div id="toolbar" style="display: none;">
		<table>
			<tr>
			<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/legalHoliday!save')">
				<td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_add',plain:true" onclick="addFun();">添加节日</a></td>
			</s:if>
			<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/legalHoliday!saveWeek')">
				<td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_add',plain:true" onclick="addWeek();">设置每周休息日</a></td>
			</s:if>	
		<s:if test="@com.datalook.util.base.CookieUtil@haveKeyValue('easyuiStyle','check')">
			<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/legalHoliday!getByDate')">
				<td><a onclick="showFun(grid.datagrid('getSelected').date);" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note',plain:true" >查看</a></td>
			</s:if>	
			<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/legalHoliday!update')">
				<td><a onclick="editFun(grid.datagrid('getSelected').date);" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_edit',plain:true" >编辑</a></td>
			</s:if>	
			<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/legalHoliday!deleteByDate')">
				<td><a onclick="removeFuns(grid.datagrid('getSelections'));" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_delete',plain:true" >删除</a></td>
			</s:if>	
		</s:if>	
				<td><div class="datagrid-btn-separator"></div></td>
				<td>
					<input id="searchBox" class="easyui-searchbox" style="width: 150px" 
						data-options="
							searcher:function(value,name){
								grid.datagrid('load',{'hqland_date_mohu_String_or_name_mohu_String':value+'_or_'+value});
							}
							,prompt:'日期查询'">
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