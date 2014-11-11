<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
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
	var onEndEdit = function(rowIndex, rowData, changes){
		url = datalook.contextPath + '/sign!update.action';
		if(!$.isEmptyObject(changes)){
		$.post(url,
				{'data.id':rowData.id,'data.reason':rowData.reason}
				, function(result) {
			if (result.success) {
			} else {
			}
		}, 'json');
		}
	};
	
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

	$(function() {
		setDate();
		grid = $('#grid').datagrid({
			title : '',
			url : datalook.contextPath + '/sign!grid.action',
			striped : true,
			rownumbers : true,
			pagination : true,
			singleSelect : true,
			idField : 'id',
			sortName : 'id',
			sortOrder : 'asc',
			<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/sign!update')">
			onClickCell : onClickCell,
			onEndEdit : onEndEdit,
			</s:if>
			frozenColumns : [ [ {
				width : '100',
				title : '员工编号',
				field : 'scheduleEmployee.employee.employeenumber',
				sortable : true,
				formatter : function(value, row) {
					return row.scheduleEmployee.employee.employeenumber;
				}
			},{
				width : '60',
				title : '员工姓名',
				field : 'scheduleEmployee.employee.employeename',
				sortable : true,
				formatter : function(value, row) {
					return row.scheduleEmployee.employee.employeename;
				}
			} ] ],
			columns : [ [ {
				width : '150',
				title : '打卡时间',
				field : 'dataCollection.signtime',
				sortable : true,
				formatter : function(value, row) {
					if(row.dataCollection==undefined){
						return '';
					}
					return row.dataCollection.signtime;
				}
			} ,{
				width : '100',
				title : '打卡类型',
				field : 'signtype',
				sortable : true,
				formatter : function(value, row) {
					if(value=='00'){return '上班未打卡';}
					if(value=='01'){return '上班准时打卡';}
					if(value=='02'){return '上班迟到打卡';}
					if(value=='03'){return '异地上班准时打卡';}
					if(value=='04'){return '异地上班迟到打卡';}
					if(value=='10'){return '下班未打卡';}
					if(value=='11'){return '下班准时打卡';}
					if(value=='12'){return '异地正点下班打卡';}
					if(value=='13'){return '晚下班打卡';}
					if(value=='14'){return '异地晚下班打卡';}
					if(value=='15'){return '早下班打卡';}
					if(value=='16'){return '异地早下班打卡';}
					if(value=='20'){return '无故打卡';}
					if(value=='21'){return '打卡机设置错误，无法找到对应打卡机';}
					if(value=='30'){return '加班上班打卡';}
					if(value=='31'){return '加班下班打卡';}
					if(value=='32'){return '异地加班上班打卡';}
					if(value=='33'){return '异地加班下班打卡';}
					if(value=='34'){return '加班上班未打卡';}
					if(value=='35'){return '加班下班未打卡';}
					return '异常';
				}
			},{
				width : '150',
				title : '打卡原因',
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
	
	

</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div id="toolbar" style="display: none;">
		<form id="searchForm">
		<table>
			<tr>
				<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/sign!save')">
					<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_add',plain:true" onclick="addFun();">添加</a>
				</s:if>
				<td><div class="datagrid-btn-separator"></div></td>
				<td>员工编号</td>
				<td><input clear="clear" name="hqland_scheduleEmployee.employee.employeenumber_mohu_String" style="width: 80px;" /></td>
				<td>姓名</td>
				<td><input clear="clear"  name="hqland_scheduleEmployee.employee.employeename_mohu_String" style="width: 80px;" /></td>
				<td>部门</td>
				<td>
					<input id="deptTree" name="hqland_scheduleEmployee.employee.department.id_dengyu_Integer" class="easyui-combotree"  data-options="editable:false,url:'<%=contextPath%>/department!noSnSy_getDeptTreeData.action',checkbox:false,multiple:false,width:150"/>
				</td>
				
				
				<td>打卡类型</td>
				<td>
					<select name="hqland_signtype_dengyu_String" class="easyui-combobox" data-options="editable:false,panelHeight:'300px'" style="width: 155px;">
						<option value=''>全部</option>
						<option value=00>上班未打卡</option>
						<option value=01>上班准时打卡</option>
						<option value=02>上班迟到打卡</option>
						<option value=03>异地上班准时打卡</option>
						<option value=04>异地上班迟到打卡</option>
						<option value=10>下班未打卡</option>
						<option value=11>下班准时打卡</option>
						<option value=12>异地正点下班打卡</option>
						<option value=13>晚下班打卡</option>
						<option value=14>异地晚下班打卡</option>
						<option value=15>早下班打卡</option>
						<option value=16>异地早下班打卡</option>
						<option value=20>无故打卡</option>
						<option value=21>打卡机设置错误，无法找到对应打卡机</option>
						<option value=30>加班上班打卡</option>
						<option value=31>加班下班打卡</option>
						<option value=32>异地加班上班打卡</option>
						<option value=33>异地加班下班打卡</option>
						<option value=34>加班上班未打卡</option>
						<option value=35>加班下班未打卡</option>
					</select>
				</td>
				<td>查询起始日期</td>
				<td><input id="startDate" name="hqland_dataCollection.signtime_dayu_String" type="text" class="easyui-datebox" data-options="required:true,editable:false" style="width:100px"></td>
				<td>查询结束日期</td>
				<td><input id="endDate" name="hqland_dataCollection.signtime_xiaoyu_String" type="text" class="easyui-datebox" data-options="required:true,editable:false" style="width:100px"></td>
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