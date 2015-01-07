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
			title : '添加excel批量导入信息管理',
			url : ez.contextPath + '/pages/sys/sysExcelUploadForm.jsp',
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
			title : '查看excel批量导入信息管理',
			url : ez.contextPath + '/pages/sys/sysExcelUploadForm.jsp?id=' + row.id
		});
	}

	var openUpdate = function(row) {
		var dialog = parent.ez.modalDialog({
			title : '编辑excel批量导入信息管理',
			url : ez.contextPath + '/pages/sys/sysExcelUploadForm.jsp?id=' + row.id,
			buttons : [ {
				text : '编辑',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, ezgrid, parent.$);
				}
			} ]
		});
	}

	var deletePhysical = function() {
		var rows = ezgrid.datagrid('getChecked');
		parent.$.messager.confirm('询问', '您确定要删除记录？', function(r) {
			if (r) {
				var ids = [];
				for (var i = 0; i < rows.length; i++) {
					ids.push(rows[i].id);
				}
				$.post(ez.contextPath + '/sysExcelUpload!deletePhysical.action', {
					'ids' : ids.join(',')
				}, function() {
					ezgrid.datagrid('reload');
					ezgrid.datagrid('clearChecked');
				}, 'json');
			}
		});
	};

	var clean = function() {
		$('#searchForm input.easyui-textbox,#searchForm input.easyui-numberbox').textbox('setValue', '');
		$('#searchForm input.easyui-datebox').datebox('setValue', '');
		$('#searchForm input.easyui-datetimebox').datetimebox('setValue', '');
		$('#searchForm input.easyui-combobox').combobox('setValue', '');
		$('#searchForm input.easyui-combotree').combotree('setValue', '');
		$('#searchForm input.easyui-combogrid').combogrid('setValue', '');
		$('#searchForm input.easyui-timespinner').spinner('setValue', '');
		ezgrid.datagrid('load', ez.serializeObject($('#searchForm')));
	}

	$(function() {
		ezgrid = $('#ezgrid').datagrid({
			title : '',
			url : ez.contextPath + '/sysExcelUpload!datagridByPage.action',
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
			} ] ],
			columns : [ [ {
				width : '150',
				title : '上传时间',
				field : 'uploadTime',
			}, {
				width : '100',
				title : '成功（条）',
				field : 'successCount',
			}, {
				width : '100',
				title : '失败（条）',
				field : 'errorCount',
			}, {
				width : '300',
				title : '错误信息下载',
				field : 'errorDocPath',
				formatter : function(value, row) {
					if (value != undefined) {
						return ez.formatString("<a href='{0}'>{0}</a>", value);
					} else {
						return '';
					}
				}
			}, ] ],
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
				<input name="hqland_id_dengyu_Integer" type="hidden" value="" />
				从上传时间
				<input name="hqland_uploadTime_dayudengyu_Date" class="easyui-datetimebox" data-options="editable:false" style="width: 80px;" />
				到上传时间
				<input name="hqland_uploadTime_xiaoyudengyu_Date" class="easyui-datetimebox" data-options="editable:false" style="width: 80px;" />
				下载
				<input name="hqland_errorDocPath_mohu_String" class="easyui-textbox" data-options="" style="width: 80px;" />
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-zoom',plain:true" onclick="ezgrid.datagrid('load',ez.serializeObject($('#searchForm')));">查询</a>
				<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-zoom_out',plain:true" onclick="clean();">清空查询</a>
			</form>
		</div>
		<div></div>
	</div>
	<div data-options="region:'center',fit:true,border:false">
		<table id="ezgrid" data-options="fit:true,border:false"></table>
	</div>
</body>
</html>