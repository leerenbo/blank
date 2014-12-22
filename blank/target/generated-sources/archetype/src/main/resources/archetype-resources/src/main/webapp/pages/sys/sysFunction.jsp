#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
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
			title : '添加功能信息',
			url : ez.contextPath + '/pages/sys/sysfunctionForm.jsp',
			buttons : [ {
				text : '添加',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, ezgrid, parent.${symbol_dollar}, parent.mainMenu);
				}
			} ]
		});
	};

	var deletePhysical = function() {
		var rows = ezgrid.datagrid('getChecked');
		parent.${symbol_dollar}.messager.confirm('询问', '您确定要删除记录？', function(r) {
			if (r) {
				var ids = [];
				for (var i = 0; i < rows.length; i++) {
					ids.push(rows[i].id);
				}
				${symbol_dollar}.post(ez.contextPath + '/sysFunction!deletePhysical.action', {
					'ids' : ids.join(',')
				}, function() {
					ezgrid.treegrid('reload');
				}, 'json');
			}
		});
	};

	var openUpdate = function(row) {
		var dialog = parent.ez.modalDialog({
			title : '编辑功能信息',
			url : ez.contextPath + '/pages/sys/sysfunctionForm.jsp?id=' + row.id,
			buttons : [ {
				text : '编辑',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, ezgrid, parent.${symbol_dollar}, parent.mainMenu);
				}
			} ]
		});
	};

	${symbol_dollar}(function() {
		ezgrid = ${symbol_dollar}('${symbol_pound}ezgrid').treegrid({
			title : '',
			url : ez.contextPath + '/sysFunction!treegridNoPage.action?hqland_id_budeng_Integer=0',
			idField : 'id',
			treeField : 'functionname',
			parentField : 'pid',
			checkbox : true,
			rownumbers : true,
			pagination : false,
			sortName : 'seq',
			sortOrder : 'asc',
			checkOnSelect : true,
			selectOnCheck : true,
			singleSelect : false,
			frozenColumns : [ [ {
				field : 'ck',
				checkbox : true
			}, {
				width : '200',
				title : '功能名称',
				field : 'functionname',
			} ,] ],
			columns : [ [ {
				width : '200',
				title : '图标路径',
				field : 'iconCls'
			}, {
				width : '200',
				title : '功能路径',
				field : 'url'
			}, {
				width : '60',
				title : '功能类型',
				field : 'functiontype',
				formatter : function(value,row){
					return ez.columnsFomatter(value,row,'${package}.model.sys.SysFunction.functiontype');
				}
			}, {
				width : '80',
				title : '排序',
				field : 'seq',
				hidden : true
			} ] ],
			toolbar : '${symbol_pound}eztoolbar',
			onBeforeLoad : function(row, param) {
				parent.${symbol_dollar}.messager.progress({
					text : '数据加载中....'
				});
			},
			onLoadSuccess : function(row, data) {
				${symbol_dollar}('.iconImg').attr('src', ez.pixel_0);
				parent.${symbol_dollar}.messager.progress('close');
			}
		});
	});
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div id="eztoolbar" style="display: none;">
		<s:if test="@${package}.util.base.SecurityUtil@havePermission('/sysFunction!save')">
			<a onclick="save();" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_add',plain:true">添加</a>
		</s:if>
		<s:if test="@${package}.util.base.SecurityUtil@havePermission('/sysFunction!update')">
			<a onclick="ezgrid.datagrid('ezCheckedInvoke','openUpdate');" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_edit',plain:true">编辑</a>
		</s:if>
		<s:if test="@${package}.util.base.SecurityUtil@havePermission('/sysFunction!deletePhysical')">
			<a onclick="deletePhysical();" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_delete',plain:true">删除</a>
		</s:if>

		<a onclick="ezgrid.treegrid('ezCheckedExpand');" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'ext-icon-resultset_next'">展开</a>
		<a onclick="ezgrid.treegrid('ezCheckedCollapse');" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'ext-icon-resultset_previous'">折叠</a>
		<a onclick="ezgrid.treegrid('reload');" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'ext-icon-arrow_refresh'">刷新</a>
	</div>
	<div data-options="region:'center',fit:true,border:false">
		<table id="ezgrid" data-options="fit:true,border:false"></table>
	</div>
</body>
</html>