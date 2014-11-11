<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<jsp:include page="../../inc.jsp"></jsp:include>
<script type="text/javascript">
	function setDate(){
		var now=new Date();
		var thismonthfirstDay=new Date();
		thismonthfirstDay.setDate(1);
		var lastmonthfirstDay=new Date();
		lastmonthfirstDay.setMonth(now.getMonth()-1, 1);
		$('#startDate').datebox('setValue', lastmonthfirstDay.Format('yyyy-MM-dd'));
		$('#endDate').datebox('setValue',  thismonthfirstDay.Format('yyyy-MM-dd'));
		$('#startDate').val(lastmonthfirstDay.Format('yyyy-MM-dd'));
		$('#endDate').val(thismonthfirstDay.Format('yyyy-MM-dd'));
	}

	var grid;
	$(function() {
		setDate();
		
		grid = $('#grid').datagrid({
			title : '',
			url : datalook.contextPath + '/attendenceStatistic!grid.action',
			striped : true,
			rownumbers : true,
			pagination : true,
			singleSelect : true,
			idField : 'employeenumber',
			sortName : 'employeenumber',
			sortOrder : 'asc',
			frozenColumns : [ [ {
				width : '100',
				title : '员工编号',
				field : 'employeenumber',
				sortable : true,
			},{
				width : '60',
				title : '员工姓名',
				field : 'employeename',
				sortable : true,
			},{
				width : '60',
				title : '部门名称',
				field : 'departmentname'
			} ] ],
			columns : [ [{
				width : '150',
				title : '应上班(天)',
				field : 'needWorkDay'
			} ,{
				width : '150',
				title : '出席(天)',
				field : 'attendenceDays'
			},{
				width : '150',
				title : '缺席(天)',
				field : 'missDays'
			},{
				width : '150',
				title : '迟到/早退(天)',
				field : 'lateearlyDays'
			},{
				width : '150',
				title : '加班(天)',
				field : 'workextraDays'
			},{
				width : '150',
				title : '晚下班(天)',
				field : 'workovertimeDays'
			},{
				width : '150',
				title : '带薪休假(天)',
				field : 'vocationDaysWithSalary'
			},{
				width : '150',
				title : '无薪请假(天)',
				field : 'vocationDaysWithoutSalary'
			},{
				width : '150',
				title : '异地上班(天)',
				field : 'differentPlace'
			},{
				width : '150',
				title : '忘记打卡(天)',
				field : 'forget'
			},{
				width : '150',
				title : '其他情况(天)',
				field : 'otherDays'
			},{
				width : '150',
				title : '未结算(天)',
				field : 'unsettleDay'
			},{
				width : '150',
				title : '应付(日薪)',
				field : 'totalDaylyWagePercent'
			},{
				width : '150',
				title : '奖罚(元)',
				field : 'totalMinusWage'
			},{
				width : '150',
				title : '剩余带薪假期(天)',
				field : 'vacationdaysremain'
			},{
				width : '150',
				title : '累计加班(小时)',
				field : 'workextrahours'
			}  ] ],
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
	
	
    var downloadExcel= function(){
		var url = datalook.contextPath + '/attendenceStatistic!downloadExcel.action?'+$('#searchForm').serialize();
		window.open(url);
    }
    
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div id="toolbar" style="display: none;">
		<form id="searchForm">
		<input type="hidden" name="hqland_status_dengyu_String" value="1">
		<table>
			<tr>
				<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/attendenceStatistic!downloadExcel')">
				<td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_add',plain:true" onclick="downloadExcel();">Excel报表下载</a></td>
				</s:if>				
				<td><div class="datagrid-btn-separator"></div></td>
				<td>员工编号</td>
				<td><input clear="clear" name="hqland_employeenumber_mohu_String" style="width: 80px;" /></td>
				<td>姓名</td>
				<td><input clear="clear" name="hqland_employeename_mohu_String" style="width: 80px;" /></td>
				<td>部门</td>
				<td>
					<input id="deptTree" name="hqland_department.id_dengyu_Integer" class="easyui-combotree"  data-options="editable:false,url:'<%=contextPath%>/department!noSnSy_getDeptTreeData.action',checkbox:false,multiple:false,width:150"/>
				</td>
				<td>查询起始日期</td>
				<td><input id="startDate" name="startDay" type="text" class="easyui-datebox" data-options="required:true,editable:false" style="width:100px"></td>
				<td>查询结束日期</td>
				<td><input id="endDate" name="endDay" type="text" class="easyui-datebox" data-options="required:true,editable:false" style="width:100px"></td>
				<td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-zoom',plain:true" onclick="grid.datagrid('load',sy.serializeObject($('#searchForm')));">过滤</a><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-zoom_out',plain:true" onclick="$('#deptTree').combotree('clear');$('[clear=clear]').val('');grid.datagrid('load',sy.serializeObject($('#searchForm')))">重置过滤</a></td>
			</tr>
		</table>
		</form>
	</div>
	<div data-options="region:'center',fit:true,border:false">
		<table id="grid" data-options="fit:true,border:false"></table>
	</div>
</body>
</html>