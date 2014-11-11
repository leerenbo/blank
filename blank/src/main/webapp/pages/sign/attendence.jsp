<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<script type="text/javascript">

var attendenceTypeComboboxJson=[{"key":"","value":"全部"},
                                {"key":"11111","value":"带薪休息"},
                                {"key":"00000","value":"无薪休息"},
                                {"key":"00,10","value":"缺勤"},
                                {"key":"01,13","value":"晚下班"},
                                {"key":"01,11","value":"出勤"},
                                {"key":"00,11","value":"上班忘记打卡"},
                                {"key":"01,10","value":"下班忘记打卡"},
                                {"key":"01,15","value":"早退"},
                                {"key":"02,11","value":"迟到"},
                                {"key":"02,15","value":"迟到并早退"},
                                {"key":"01,12","value":"异地下班"},
                                {"key":"03,11","value":"异地上班"},
                                {"key":"03,12","value":"异地上下班"},
                                {"key":"30,31","value":"加班"},
                                {"key":"30,35","value":"加班下班忘打卡"},
                                {"key":"34,31","value":"加班上班忘打卡"},
                                {"key":"32,33","value":"异地加班"},
                                {"key":"34,35","value":"未加班"},
                                {"key":"12345","value":"特殊情况"}];

	var grid;
	var onEndEdit = function(rowIndex, rowData, changes){
		url = datalook.contextPath + '/attendence!update.action';
		if(!$.isEmptyObject(changes)){
			$.post(url,
					{
				'data.id':rowData.id,
				'data.reason':rowData.reason,
				'data.attendencetype':rowData.attendencetype,
				'data.minusWage':rowData.minusWage,
				'data.dailyWagePercent':rowData.dailyWagePercent,
					}
					, function(result) {
				if (result.success) {
				} else {
				}
			}, 'json');
		}
	};
	
	function setDate(){
		var now=new Date();
		thismonthfirstDay=new Date();
		thismonthfirstDay.setDate(1);
		lastmonthfirstDay=new Date();
		lastmonthfirstDay.setMonth(now.getMonth()-1, 1);
		$('#startDate').datebox('setValue', lastmonthfirstDay.Format('yyyy-MM-dd'));
		$('#endDate').datebox('setValue',  thismonthfirstDay.Format('yyyy-MM-dd'));
		$('#startDate').val(lastmonthfirstDay.Format('yyyy-MM-dd'));
		$('#endDate').val(thismonthfirstDay.Format('yyyy-MM-dd'));
	}
	
	$(function() {
		setDate();
		
		grid = $('#grid').datagrid({
			title : '',
			url : datalook.contextPath + '/attendence!grid.action?hqland_employee.status_dengyu_String=1',
			queryParams:{startDay:lastmonthfirstDay.Format('yyyy-MM-dd'),endDay:thismonthfirstDay.Format('yyyy-MM-dd')},
			striped : true,
			rownumbers : true,
			pagination : true,
			singleSelect : true,
			idField : 'id',
			sortName : 'scheduledate',
			sortOrder : 'asc',
			<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/attendence!update')">
			onClickCell:onClickCell,
			onEndEdit:onEndEdit,
			</s:if>
			frozenColumns : [ [ {
				width : '100',
				title : '员工编号',
				field : 'employee.employeenumber',
				sortable : true,
				formatter : function(value, row) {
					return row.employee.employeenumber;
				}
			},{
				width : '60',
				title : '员工姓名',
				field : 'employee.employeename',
				sortable : true,
				formatter : function(value, row) {
					return row.employee.employeename;
				}
			} ] ],
			columns : [ [ {
				width : '150',
				title : '日期',
				field : 'scheduledate',
				sortable : true,
				formatter : function(value, row) {
					return row.scheduledate;
				}
			} ,{
				width : '60',
				title : '排班类型',
				field : 'scheduletype',
				sortable : true,
				formatter : function(value, row) {
					if(value=='00'){
						return '上班';
					}else if(value=='01'){
						return '加班';
					}else if(value=='02'){
						return '补班';
					}else if(value=='10'){
						return '休假';
					}else if(value=='11'){
						return '补休';
					}else if(value=='12'){
						return '请假';
					}
				}
			},{
				width : '150',
				title : '打卡类型',
				field : 'attendencetype',
				sortable : true,
				editor:{
                    type:'combobox',
                    options:{valueField:'key',textField:'value',data:attendenceTypeComboboxJson}
				},
				formatter : function(value, row) {
					if(value=='11111'){return '带薪休息';};
					if(value=='00000'){return '无薪休息';}
					if(value=='00,10'){return '缺勤';}
					if(value=='01,13'){return '晚下班';}
					if(value=='01,11'){return '出勤';}
					if(value=='00,11'){return '上班忘记打卡';}
					if(value=='01,10'){return '下班忘记打卡';}
					if(value=='01,15'){return '早退';}
					if(value=='02,11'){return '迟到';}
					if(value=='02,15'){return '迟到并早退';}
					if(value=='01,12'){return '异地下班';}
					if(value=='03,11'){return '异地上班';}
					if(value=='03,12'){return '异地上下班';}
					if(value=='30,31'){return '加班';}
					if(value=='30,35'){return '加班下班忘打卡';}
					if(value=='34,31'){return '加班上班忘打卡';}
					if(value=='32,33'){return '异地加班';}
					if(value=='34,35'){return '未加班';}
					if(value=='12345'){return '特殊情况';}
					if(value==undefined||value==""){return '未结算';}
					return '异常';
				}
			},{
				width : '150',
				title : '领取工资日百分比(-1~1)',
				field : 'dailyWagePercent',
				sortable : true,
				editor:{type:'numberbox',options:{precision:2,max:1,min:-1}}
			} ,{
				width : '150',
				title : '工资金额变动(元)',
				field : 'minusWage',
				sortable : true,
				editor:'numberbox'
			} ,{
				width : '150',
				title : '特殊原因',
				field : 'reason',
				sortable : true,
				editor:'text'
			} ] ],
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
	
    $.extend($.fn.datagrid.methods, {
        editCell: function(jq,param){
            return jq.each(function(){
                var opts = $(this).datagrid('options');
                var fields = $(this).datagrid('getColumnFields',true).concat($(this).datagrid('getColumnFields'));
                for(var i=0; i<fields.length; i++){
                    var col = $(this).datagrid('getColumnOption', fields[i]);
                    col.editor1 = col.editor;
                    if (fields[i] != param.field){
                        col.editor = null;
                    }
                }
                $(this).datagrid('beginEdit', param.index);
                for(var i=0; i<fields.length; i++){
                    var col = $(this).datagrid('getColumnOption', fields[i]);
                    col.editor = col.editor1;
                }
            });
        }
    });
    
    var editIndex = undefined;
    function endEditing(){
        if (editIndex == undefined){return true;};
        if (grid.datagrid('validateRow', editIndex)){
            grid.datagrid('endEdit', editIndex);
            editIndex = undefined;
            return true;
        } else {
            return false;
        }
    }
    function onClickCell(index, field){
        if (endEditing()){
            grid.datagrid('selectRow', index)
                    .datagrid('editCell', {index:index,field:field});
            editIndex = index;
        }
    }
    var downloadExcel= function(){
		var url = datalook.contextPath + '/attendence!downloadExcel.action?'+$('#searchForm').serialize();
		window.open(url);
    }
    
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div id="toolbar" style="display: none;">
		<form id="searchForm">
		<table>
			<tr>
				<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/attendence!downloadExcel')">
				<td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_add',plain:true" onclick="downloadExcel();">Excel报表下载</a></td>
				</s:if>
				<td><div class="datagrid-btn-separator"></div></td>
				<td>员工编号</td>
				<td><input clear="clear" name="hqland_employee.employeenumber_mohu_String" style="width: 80px;" /></td>
				<td>姓名</td>
				<td><input clear="clear" name="hqland_employee.employeename_mohu_String" style="width: 80px;" /></td>
				<td>部门</td>
				<td>
					<input id="deptTree" name="hqland_employee.department.id_dengyu_Integer" class="easyui-combotree"  data-options="editable:false,url:'<%=contextPath%>/department!noSnSy_getDeptTreeData.action',checkbox:false,multiple:false,width:150"/>
				</td>
				<td>签到类型</td>
				<td>
					<select name="hqland_attendencetype_dengyu_String" class="easyui-combobox" data-options="valueField:'key',textField:'value',data:attendenceTypeComboboxJson,editable:false,panelHeight:'300px'" style="width: 155px;"></select>
				</td>
				<td>查询起始日期</td>
				<td><input id="startDate"  name="hqland_scheduledate_dayu_String" class="easyui-datebox" data-options="required:true,editable:false" style="width:100px"></td>
				<td>查询结束日期</td>
				<td><input id="endDate" name="hqland_scheduledate_xiaoyu_String" class="easyui-datebox" data-options="required:true,editable:false" style="width:100px"></td>
				<td><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-zoom',plain:true" onclick="grid.datagrid('load',sy.serializeObject($('#searchForm')));">过滤</a><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-zoom_out',plain:true" onclick="$('#searchForm select').combobox('clear');$('#deptTree').combotree('clear');$('[clear=clear]').val('');grid.datagrid('load',sy.serializeObject($('#searchForm')));">重置过滤</a></td>
			</tr>
		</table>
		</form>
	</div>
	<div data-options="region:'center',fit:true,border:false">
		<table id="grid" data-options="fit:true,border:false"></table>
	</div>
</body>
</html>