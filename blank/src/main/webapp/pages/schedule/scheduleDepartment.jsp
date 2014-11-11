<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<%@ include file="../../inc.jsp"%>
<script type="text/javascript" src="<%=contextPath%>/js/datagrid-groupview.js"></script>
<script type="text/javascript">
var selecteddate;
var selecteddepartment;
var shangbandakaid;
var xiabandakaid;
var scheduletype;
	var grid;
	var addFun = function(clockRuleid,clockRuleTwoid,departmentid,scheduledate,scheduletype) {
		$.post(datalook.contextPath + '/scheduleDepartment!save.action', {
			'data.clockRule.id' : clockRuleid,
			'data.clockRuleTwo.id' : clockRuleTwoid,
			'data.department.id' : departmentid,
			'data.scheduledate' : scheduledate,
			'data.scheduletype' : scheduletype
		}, function(result) {
			if (result.success) {
				grid.datagrid('load');
			} else {
				$.messager.alert('提示', result.msg, 'error');
			}

		}, 'json');

	};
	
	var refresh=function(){
		var now=$('#daydate').calendar('options').current;
		var xingqi=now.getDay();
		var weekdays='';
		for (var i=0;i<7;i++){
			var temp=new Date(now);
			temp.setDate(now.getDate()-xingqi+i);
			weekdays=weekdays+'|'+temp.Format('yyyy-MM-dd');
		}
		weekdays=weekdays.substring(1, weekdays.length);
		selecteddepartment=$('#departmenttree').tree('getSelected');
    	if(selecteddepartment!=null){
    		grid.datagrid({
    			url : datalook.contextPath + '/scheduleDepartment!find.action?hqland_department.status_dengyu_String=1&hqland_scheduledate_in_String='+weekdays+'&hqland_department.id_dengyu_Integer='+selecteddepartment.id,
    		});
    	}else{
    		grid.datagrid({
    			url : datalook.contextPath + '/scheduleDepartment!find.action?hqland_department.status_dengyu_String=1&hqland_scheduledate_in_String='+weekdays,
    		});
    	}
    	setHeightWeight();
	}
	
	var removeFun = function(id) {
		parent.$.messager.confirm('询问', '您确定要删除此记录？', function(r) {
			if (r) {
				$.post(datalook.contextPath + '/scheduleDepartment!delete.action', {
					'data.id' : id
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
				$.post(datalook.contextPath + '/scheduleDepartment!delete.action', {
					'ids' : ids.join(',')
				}, function() {
					grid.datagrid('reload');
					grid.datagrid('clearSelections');
				}, 'json');
			}
		});
	};

	 function setHeightWeight(){
         var centerPanel = $('#centerPanel');
         var height=centerPanel.outerHeight()-20;
         var width=centerPanel.outerWidth()-10;
         $('#dropable').css('height',height);
         $('#dropable').css('width',width);
     }
	
	 var extendsToMonth=function(){
	     	var selecteddatetemp =$('#daydate').calendar('options').current.Format('yyyy-MM-dd');
	    	selecteddepartment=$('#departmenttree').tree('getSelected');
        	if(selecteddepartment==null){
        		$.messager.alert('信息不完整','请选择部门','info');
        		return;
        	}
			$.post(datalook.contextPath + '/scheduleDepartment!extendsToMonth.action', {
				'data.department.id' : selecteddepartment.id,
				'data.scheduledate' : selecteddatetemp,
			}, function(result) {
				if (result.success) {
					refresh();
				} else {
					$.messager.alert('提示', result.msg, 'error');
				}
			}, 'json');
	 }
	 
	 
	function chooseEmployee(){
    	selecteddepartment=$('#departmenttree').tree('getSelected');
    	if(selecteddepartment==null){
    		$.messager.alert('信息不完整','请选择部门','info');
    		return;
    	}
		var dialog = parent.sy.modalDialog({
			title : '选择排班员工',
			url : datalook.contextPath + '/pages/schedule/scheduleDepartmentSelectEmployee.jsp?id='+$('#departmenttree').tree('getSelected').id+'&scheduledate='+$('#daydate').calendar('options').current.Format('yyyy-MM-dd'),
			buttons : [ {
				text : '排班',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
				}
			} ]
		});
	}
	
	$(function() {
		setHeightWeight();
		
        $('.dragitem').draggable({
            revert:true,
            deltaX:10,
            deltaY:10,
            proxy:function(source){
                var n = $('<div class="proxy"></div>');
                n.appendTo('body');
                return n;
            },
            onStopDrag:function(){
                $(this).draggable('options').cursor='move';
            },
            onStartDrag:function(){
	        	var paibanleixing;
	        	if($(this).attr('value')==00){
	        		paibanleixing='上班';
	        		if(!$('#shangbandaka').combobox('isValid')){
		        		$(this).draggable('options').cursor='not-allowed';
		        		$(this).draggable('proxy').html('请选择上班打卡类型');
		        		return;
	        		}
	        		if(!$('#xiabandaka').combobox('isValid')){
		        		$(this).draggable('options').cursor='not-allowed';
		        		$(this).draggable('proxy').html('请选择下班打卡类型');
		        		return;
	        		}
	        		shangbandakaid=$('#shangbandaka').combobox('getValue');
	        		xiabandakaid=$('#xiabandaka').combobox('getValue');
	        	}
	        	if($(this).attr('value')==01){
	        		paibanleixing='加班';
	        		if(!$('#jiabanshangbandaka').combobox('isValid')){
	        			$(this).draggable('options').cursor='not-allowed';
		        		$(this).draggable('proxy').html('请选择上班打卡类型');
		        		return;
	        		}
	        		if(!$('#jiabanxiabandaka').combobox('isValid')){
	        			$(this).draggable('options').cursor='not-allowed';
		        		$(this).draggable('proxy').html('请选择下班打卡类型');
		        		return;
	        		}
	        		shangbandakaid=$('#jiabanshangbandaka').combobox('getValue');
	        		xiabandakaid=$('#jiabanxiabandaka').combobox('getValue');
	        	}
	        	if($(this).attr('value')==02){
	        		paibanleixing='补班';
	        		if(!$('#bubanshangbandaka').combobox('isValid')){
	        			$(this).draggable('options').cursor='not-allowed';
		        		$(this).draggable('proxy').html('请选择上班打卡类型');
		        		return;
	        		}
	        		if(!$('#bubanxiabandaka').combobox('isValid')){
	        			$(this).draggable('options').cursor='not-allowed';
		        		$(this).draggable('proxy').html('请选择下班打卡类型');
		        		return;
	        		}
	        		shangbandakaid=$('#bubanshangbandaka').combobox('getValue');
	        		xiabandakaid=$('#bubanxiabandaka').combobox('getValue');
	        	}
	        	if($(this).attr('value')==10){
	        		paibanleixing='休假';
	        	}
	        	if($(this).attr('value')==11){
	        		paibanleixing='补休';
	        	}
	        	if($(this).attr('value')==12){
	        		paibanleixing='请假';
	        	}
	        	selecteddepartment=$('#departmenttree').tree('getSelected');
	        	if(selecteddepartment==null){
	        		$(this).draggable('options').cursor='not-allowed';
	        		$(this).draggable('proxy').html('请选择部门');
	        		return;
	        	}
	        	selecteddate =$('#daydate').calendar('options').current.Format('yyyy年MM月dd日');
	        	$(this).draggable('proxy').html(selecteddate+'安排部门<'+selecteddepartment.departmentname+'>'+paibanleixing);
	        }
        });

		grid = $('#grid').datagrid({
			title : '',
			striped : true,
			rownumbers : true,
			checkOnSelect:true,
			selectOnCheck:true,
			singleSelect:false,
			idField : 'id',
			sortName : 'scheduledate',
			sortOrder : 'asc',
            view: groupview,
            groupField:'scheduledate',
            groupFormatter:function(value, rows){
            	var nowday=$('#daydate').calendar('options').current.Format('yyyy-MM-dd');
        		var xingqiji=new Date();
        		xingqiji.setFullYear(value.substring(0,4), value.substring(5,7)-1, value.substring(8,10));
        		if(value==nowday){
            		if(value==nowday&&xingqiji.getDay()==0){
                		return '<font color="red">'+value + ' - 星期天'+' - ' + rows.length + ' Item(s)'+'</font>';
                	}
            		return '<font color="red">'+value + ' - 星期'+xingqiji.getDay()+' - ' + rows.length + ' Item(s)'+'</font>';
            	}
        		if(xingqiji.getDay()==0){
        			return value + ' - 星期天'+' - ' + rows.length + ' Item(s)';
            	}
        		return value + ' - 星期'+xingqiji.getDay()+' - ' + rows.length + ' Item(s)';
    		},
			columns : [ [ 
	 			<s:if test="@com.datalook.util.base.CookieUtil@haveKeyValue('easyuiStyle','check')">
				{
					field:'ck',
					checkbox:true
				},
				</s:if>
			    {
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
				width : '80',
				title : '部门名称',
				field : 'department.departmentname',
				sortable : true,
				formatter : function(value, row) {
					return row.department.departmentname;
				}
			} ,{
				width : '80',
				title : '上班开始时间',
				field : 'clockRule.receivetime',
				formatter : function(value, row) {
					if(row.clockRule!=undefined)
					return row.clockRule.receivetime;
				}
			} ,{
				width : '80',
				title : '上班正点时间',
				field : 'clockRule.righttime',
				formatter : function(value, row) {
					if(row.clockRule!=undefined)
					return row.clockRule.righttime;
				}
			} ,{
				width : '80',
				title : '上班结束时间',
				field : 'clockRule.endtime',
				formatter : function(value, row) {
					if(row.clockRule!=undefined)
					return row.clockRule.endtime;
				}
			}  ,{
				width : '80',
				title : '下班开始时间',
				field : 'clockRuleTwo.receivetime',
				formatter : function(value, row) {
					if(row.clockRuleTwo!=undefined){
						return row.clockRuleTwo.receivetime;
					}
				}
			} ,{
				width : '80',
				title : '下班正点时间',
				field : 'clockRuleTwo.righttime',
				formatter : function(value, row) {
					if(row.clockRuleTwo!=undefined){
						return row.clockRuleTwo.righttime;
					}
				}
			} ,{
				width : '80',
				title : '下班结束时间',
				field : 'clockRuleTwo.endtime',
				formatter : function(value, row) {
					if(row.clockRuleTwo!=undefined){
						return row.clockRuleTwo.endtime;
					}
				}
			}  
			<s:if test="@com.datalook.util.base.CookieUtil@haveKeyValue('easyuiStyle','icon')">
			, {
				title : '操作',
				field : 'action',
				width : '80',
				formatter : function(value, row) {
					var str = '';
					<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/scheduleDepartment!delete')">
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
				setHeightWeight();
			}
		});
		
		$('#departmenttree').tree({onSelect:function(node){refresh()}});
		$('#daydate').calendar({onSelect:function(date){refresh()}});
		refresh();
	});

</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
        <div data-options="region:'west',split:true,border:false" title="选择" style="width:228px;">
        	<div class="easyui-layout" data-options="fit:true">
	        	<div data-options="region:'north',split:true" style="height:228px;width:228px;padding:10px">
	        		<div id="daydate" class="easyui-calendar" style="height:200px;width:200px;"></div>
	            </div>
	            <div data-options="region:'center'" style="padding:10px">
					<ul id="departmenttree" class="easyui-tree" data-options="fit:true,idField:'id',textField:'departmentname',parentField:'pid',url :'<%=contextPath%>/department!treeGrid.action?hqland_id_budeng_Integer=100000&&hqland_status_dengyu_String=1',animate:true"></ul>
	            </div>
	    	</div>
        </div>
        
        <div id="centerPanel" data-options="region:'center',title:'排班情况',border:false">
			<div style="float:left;width:200px;">
		        <div id="dropable" class="easyui-droppable targetarea"
		                data-options="
		                    accept: '.dragitem',
		                    onDragEnter:function(e,source){
			                    $('.datagrid-td-rownumber').addClass('over');
			                    $('.datagrid-row-alt').addClass('over');
			                    $('.datagrid-body').addClass('over');
			                    
			                    if($(source).attr('value')==00){
		                    		if(!$('#shangbandaka').combobox('isValid')){
		                    		$('.over').addClass('error');
		                    		return;
		                    		}
		                    		if(!$('#xiabandaka').combobox('isValid')){
		                    		$('.over').addClass('error');
		                    		return;
		                    		}
		                    		shangbandakaid=$('#shangbandaka').combobox('getValue');
		                    		xiabandakaid=$('#xiabandaka').combobox('getValue');
		                    	}
		                    	if($(source).attr('value')==01){
		                    		if(!$('#jiabanshangbandaka').combobox('isValid')){
		                    		$('.over').addClass('error');
		                    		return;
		                    		}
		                    		if(!$('#jiabanxiabandaka').combobox('isValid')){
		                    		$('.over').addClass('error');
		                    		return;
		                    		}
		                    		shangbandakaid=$('#jiabanshangbandaka').combobox('getValue');
		                    		xiabandakaid=$('#jiabanxiabandaka').combobox('getValue');
		                    	}
		                    	if($(source).attr('value')==02){
		                    		if(!$('#bubanshangbandaka').combobox('isValid')){
		                    		$('.over').addClass('error');
		                    		return;
		                    		}
		                    		if(!$('#bubanxiabandaka').combobox('isValid')){
		                    		$('.over').addClass('error');
		                    		return;
		                    		}
		                    		shangbandakaid=$('#bubanshangbandaka').combobox('getValue');
		                    		xiabandakaid=$('#bubanxiabandaka').combobox('getValue');
		                    	}
		                    	selecteddepartment=$('#departmenttree').tree('getSelected');
		                    	if(selecteddepartment==null){
		                    		$('.over').addClass('error');
		                    		return;
		                    	}
		                    },
		                    onDragLeave: function(e,source){
		                    	$('.over').removeClass('over');
		                    	$('.error').removeClass('error');
		                    },
		                    onDrop: function(e,source){
								$('.over').removeClass('over');
								$('.error').removeClass('error');
		                    	if($(source).attr('value')==00){
		                    		if(!$('#shangbandaka').combobox('isValid')){
		                    		return;
		                    		}
		                    		if(!$('#xiabandaka').combobox('isValid')){
		                    		return;
		                    		}
		                    		shangbandakaid=$('#shangbandaka').combobox('getValue');
		                    		xiabandakaid=$('#xiabandaka').combobox('getValue');
		                    	}
		                    	if($(source).attr('value')==01){
		                    		if(!$('#jiabanshangbandaka').combobox('isValid')){
		                    		return;
		                    		}
		                    		if(!$('#jiabanxiabandaka').combobox('isValid')){
		                    		return;
		                    		}
		                    		shangbandakaid=$('#jiabanshangbandaka').combobox('getValue');
		                    		xiabandakaid=$('#jiabanxiabandaka').combobox('getValue');
		                    	}
		                    	if($(source).attr('value')==02){
		                    		if(!$('#bubanshangbandaka').combobox('isValid')){
		                    		return;
		                    		}
		                    		if(!$('#bubanxiabandaka').combobox('isValid')){
		                    		return;
		                    		}
		                    		shangbandakaid=$('#bubanshangbandaka').combobox('getValue');
		                    		xiabandakaid=$('#bubanxiabandaka').combobox('getValue');
		                    	}
		                    	selecteddepartment=$('#departmenttree').tree('getSelected');
		                    	if(selecteddepartment==null){
		                    		return;
		                    	}
		                    	selecteddate =$('#daydate').calendar('options').current.Format('yyyy-MM-dd');
		                    	addFun(shangbandakaid,xiabandakaid,selecteddepartment.id,selecteddate,$(source).attr('value'));
		                    }
		                ">
		        	<table id="grid"  style="background-color:green" data-options="fit:true,border:false"></table>
		        </div>
		    </div>
		    <div style="clear:both"></div>
        </div>






        <div data-options="region:'east',split:true,border:false" title="排班" style="width:200px;">
	        <div>
			<s:if test="@com.datalook.util.base.CookieUtil@haveKeyValue('easyuiStyle','check')">
				<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/scheduleDepartment!delete')">
					<a onclick="removeFuns(grid.datagrid('getSelections'));" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_delete',plain:true" >删除</a>
				</s:if>
	        	<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/scheduleEmployee!extendsToMonth')">
	        		<a href="#" class="easyui-linkbutton" data-options="onClick:extendsToMonth">排班推广至全月未排班日</a>
				</s:if>
	        	<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/scheduleEmployee!useToEmployeeSchedule')">
	            	<a href="#" class="easyui-linkbutton" data-options="onClick:chooseEmployee">安排部门人员</a>
				</s:if>
	        </s:if>
	            <div class="dragitem" value='00'>
	            	上班<br/>
	            	上班打卡规则:<select id="shangbandaka" class="easyui-combobox" data-options="required:true,valueField:'id',textField:'clockname',url:'<%=contextPath%>/clockRule!noSy_findClockRule.action?hqland_clocktype_dengyu_String=0&&hqland_status_dengyu_String=1'" style="width:100px;"></select><br/>
	            	下班打卡规则:<select id="xiabandaka" class="easyui-combobox" data-options="required:true,valueField:'id',textField:'clockname',url:'<%=contextPath%>/clockRule!noSy_findClockRule.action?hqland_clocktype_dengyu_String=1&&hqland_status_dengyu_String=1'" style="width:100px;"></select><br/>
	            </div>
	            <div class="dragitem" value='01'>
	            	加班<br/>
	            	上班打卡规则:<select id="jiabanshangbandaka" class="easyui-combobox" data-options="required:true,valueField:'id',textField:'clockname',url:'<%=contextPath%>/clockRule!noSy_findClockRule.action?hqland_clocktype_dengyu_String=2&&hqland_status_dengyu_String=1'" style="width:100px;"></select><br/>
	            	下班打卡规则:<select id="jiabanxiabandaka" class="easyui-combobox" data-options="required:true,valueField:'id',textField:'clockname',url:'<%=contextPath%>/clockRule!noSy_findClockRule.action?hqland_clocktype_dengyu_String=3&&hqland_status_dengyu_String=1'" style="width:100px;"></select><br/>
	            </div>
	            <div class="dragitem" value='02'>
	            	补班<br/>
	            	上班打卡规则:<select id="bubanshangbandaka" class="easyui-combobox" data-options="required:true,valueField:'id',textField:'clockname',url:'<%=contextPath%>/clockRule!noSy_findClockRule.action?hqland_clocktype_dengyu_String=0&&hqland_status_dengyu_String=1'" style="width:100px;"></select><br/>
	            	下班打卡规则:<select id="bubanxiabandaka" class="easyui-combobox" data-options="required:true,valueField:'id',textField:'clockname',url:'<%=contextPath%>/clockRule!noSy_findClockRule.action?hqland_clocktype_dengyu_String=1&&hqland_status_dengyu_String=1'" style="width:100px;"></select><br/>
	            </div>
	            <div class="dragitem" value='10'>休假</div>
	            <div class="dragitem" value='11'>补休</div>
	            <div class="dragitem" value='12'>请假</div>
	        </div>
        </div>
	<style type="text/css">
        .title{
            margin-bottom:10px;
        }
        .dragitem{
            border:1px solid #ccc;
            width:190px;
            height:70px;
            margin-bottom:10px;
        }
        .targetarea{
            border:1px solid red;
            height: 800px;
            width: auto;
        }
        .proxy{
            border:1px solid #ccc;
            background:#fafafa;
        }
        .over{
            background:#FBEC88;
            width: 100%;
			z-index: 1000;
			top: 1000;	
         }
        .error{
            background:#ffaaaa;
            width: 100%;
			z-index: 1000;
			top: 1000;	
         }
    </style>
</body>

</body>
</html>