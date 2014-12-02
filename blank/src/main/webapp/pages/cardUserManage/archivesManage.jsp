<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../inc.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<title>员工档案信息管理</title>
		<jsp:include page="../../pub.jsp"></jsp:include>
		<script type="text/javascript">
			var grid;
			$(function (){
				/* ----------------------列表start---------------------- */
				grid = $('#grid').datagrid({
					title : '',
					url : datalook.contextPath + '/employee!grid.action?hqland_status_dengyu_String=1',
					striped : true,
					rownumbers : true,
					pagination : true,
					singleSelect : true,
					idField : 'id',
					sortName : 'id',
					sortOrder : 'desc',
					pageSize : 50,
					pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500 ],
					checkOnSelect:true,
					selectOnCheck:true,
					singleSelect:false,
					frozenColumns : [
						[ 
				   			<s:if test="@com.datalook.util.base.CookieUtil@haveKeyValue('easyuiStyle','check')">
				   			{	                    
				   				field:'ck',
				   				checkbox:true
				   			},
				   			</s:if>
						    {
								width : '150',
								title : '员工号',
								field : 'employeenumber',
								sortable : true
							}, 
							{
								width : '150',
								title : '员工姓名',
								field : 'employeename',
								sortable : true
							}
						]
					],
					columns : [ 
						[  
							{
								width : '200',
								title : '部门',
								field : 'departmentid',
								sortable : true,
								formatter : function(value,row,index){
									if (row.department == null) {
										return "";
									}
									for (var i = 0; i < departmentList.length; i++) {
										if (row.department.id == departmentList[i].id) {
											return departmentList[i].departmentname;
										}
									}
								}
							}, 
							{
								width : '50',
								title : '性别',
								field : 'sex',
								sortable : false,
								formatter : function(value,row,index){
									if (row.sex == '1') {
										return "男";
									} else {
										return "女";
									}
								}
							}, 
							{
								width : '100',
								title : '电话',
								field : 'telphone',
								sortable : false,
								formatter : function(value,row,index){
									return chkEmpty(row.telphone);
								}
							}, 
							{
								width : '150',
								title : '邮箱',
								field : 'email',
								sortable : false,
								formatter : function(value,row,index){
									return chkEmpty(row.email);
								}
							}, 
							{
								width : '100',
								title : '剩余假期（天）',
								field : 'vacationdaysremain',
								sortable : false,
								formatter : function(value,row,index){
									var res = chkEmpty(row.vacationdaysremain);
									if (res == "") {
										return "0";
									}
									return res;
								}
							}, 
							{
								width : '100',
								title : '已加班（小时）',
								field : 'workextrahours',
								sortable : false,
								formatter : function(value,row,index){
									return fomatNumToFloat(row.workextrahours);
								}
							}
							<s:if test="@com.datalook.util.base.CookieUtil@haveKeyValue('easyuiStyle','icon')">
							,
							{
								title : '操作',
								field : 'action',
								width : '70',
								formatter : function(value, row){
									var str = '';
									<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/employee!update')">
										str += ez.formatString('<img class="iconImg ext-icon-note_edit" title="编辑" onclick="editFun(\'{0}\');"/>', row.id);
									</s:if>
									<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/employee!deleteByStatus')">
										str += ez.formatString('<img class="iconImg ext-icon-note_delete" title="删除" onclick="removeFun(\'{0}\');"/>', row.id);
									</s:if>
									if (row.cards == "undefined" || row.cards == null || row.cards == undefined || row.cards == "") {
										<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/employee!saveArchivesOpenCard')">
											str += ez.formatString('<img class="iconImg ext-icon-vcard_add" title="有档案开卡" onclick="ArchivesOpenCard(\'{0}\');"/>', row.id);
										</s:if>
									}
									return str;
								}
							}
							</s:if>
						] 
					],
					toolbar : '#toolbar',
					onBeforeLoad : function(param){
						parent.$.messager.progress({
							text : '数据加载中....'
						});
					},
					onLoadSuccess : function(data){
						$('.iconImg').attr('src', ez.pixel_0);
						parent.$.messager.progress('close');
					}
				});
				
				/* ----------------------列表end---------------------- */
				
				/* ----------------------员工档案增加start---------------------- */
				$("#addFun").click(function(){
					var dialog = parent.ez.modalDialog({
						title : '员工档案增加',
						url : datalook.contextPath + '/pages/cardUserManage/employeeForm.jsp',
						buttons : [ {
							text : '添加',
							handler : function() {
								dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
							}
						} ]
					});
				});
				/* ----------------------员工档案增加end---------------------- */
				
				/* ----------------------过滤和重置过滤start---------------------- */
				$("#query").click(function(){
					grid.datagrid('load',ez.serializeObject($('#searchForm')));
				});
				
				$("#clear").click(function(){
					$('#searchForm input').val('');
					grid.datagrid('load',{});
				});
				/* ----------------------过滤和重置过滤end---------------------- */
				
				/* ----------------------员工档案编辑start---------------------- */
				$("#editFun").click(function() {
					//单行判断
					var rows = $("#grid").datagrid('getChecked');
					if (rows.length > 1) {
						$.messager.alert('提示', '请选择一条信息进行操作', 'info');
						return;
					}
					var dialog = parent.ez.modalDialog({
						title : '编辑用户信息',
						url : datalook.contextPath + '/pages/cardUserManage/employeeForm.jsp?id=' + rows[0].id,
						buttons : [ 
						    {
								text : '编辑',
								handler : function() {
									dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
								}
						    } 
						]
					});
				});
				/* ----------------------员工档案编辑end---------------------- */
				
				/* ----------------------员工档案删除start---------------------- */
				//删除前判断该员工是否已经开卡,未开卡则直接删除档案信息，如果开卡，删除档案信息则同时删除卡户信息
				$("#removeFun").click(function() {
					//单行判断
					var rows = $("#grid").datagrid('getChecked');
					for(var i=0;i<rows.length;i++){
						if (checkCardInfo(rows[i].id)) {
							deleteOpenCardByStatus(rows[i]);
						} else {
							deleteByStatus(rows[i]);
						}
					}
					grid.datagrid('clearSelections');
					return;
				});
				
				//删除前判断该员工是否已经开卡
				function checkCardInfo(id) {
					var res = false;
					$.ajax({
						type : "post",
						dataType : "json",
						async : false,//同步
						url : datalook.contextPath + '/employee!noSy_checkCardInfo.action',
						data : {'data.id' : id},
					    success : function(data){
					    	if (data.success == true) {
								res = true;
								return;
							}
					    }
					});
					return res;
				}
				function deleteOpenCardByStatus(row) {
					parent.$.messager.confirm('询问', '该员工已开卡，删除档案信息则同时删除卡户信息，继续请按确定', function(r) {
						if (r) {
							parent.$.messager.confirm('询问', '您确定要删除员工['+row.employeename+row.employeenumber+']的记录？', function(r) {
								if (r) {
									$.post(
										datalook.contextPath + '/employee!deleteByStatus.action', 
										{'data.id' : row.id}, 
										function() {}, 
										'json'
									);
									grid.datagrid('deleteRow',grid.datagrid('getRowIndex',row));
								}
							});
						}
					});

				}
				function deleteByStatus(row) {
					parent.$.messager.confirm('询问', '您确定要删除员工['+row.employeename+row.employeenumber+']的记录？', function(r) {
						if (r) {
							console.info(row);
							$.post(
								datalook.contextPath + '/employee!deleteByStatus.action', 
								{'data.id' : row.id}, 
								function() {}, 
								'json'
							);
						}
						grid.datagrid('deleteRow',grid.datagrid('getRowIndex',row));
					});
				}
				/* ----------------------员工档案删除end---------------------- */
				
				/* ----------------------有档案开卡start---------------------- */
				$("#archivesOpenCard").click(function() {
					//单行判断
					var rows = $("#grid").datagrid('getChecked');
					if (rows.length > 1) {
						$.messager.alert('提示', '请选择一条信息进行操作', 'info');
						return;
					}
					var id = rows[0].id;
					//是否已经开卡
					if (checkCardInfo(id)) {
						$.messager.alert('提示', '该员工已开卡，不能重复开卡', 'info');
						return;
					}
					var dialog = parent.ez.modalDialog({
						title : '有档案开卡',
						url : datalook.contextPath + '/pages/cardUserManage/cardForm.jsp?employeeid=' + id,
						buttons : [ 
						    {
						    	id : 'openCardInfo',
								text : '开卡',
								handler : function() {
									dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
								}
						    } 
						]
					});
				});
				/* ----------------------有档案开卡end---------------------- */

			});
			
			/* ----------------------员工档案编辑start---------------------- */
			var editFun = function (id) {
				var dialog = parent.ez.modalDialog({
					title : '编辑用户信息',
					url : datalook.contextPath + '/pages/cardUserManage/employeeForm.jsp?id=' + id,
					buttons : [ 
					    {
							text : '编辑',
							handler : function() {
								dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
							}
					    } 
					]
				});
			};
			/* ----------------------员工档案编辑end---------------------- */
			
			/* ----------------------员工档案删除start---------------------- */
			//删除前判断该员工是否已经开卡,未开卡则直接删除档案信息，如果开卡，删除档案信息则同时删除卡户信息
			function removeFun(id) {
				if (checkCardInfo(id)) {
					parent.$.messager.confirm('询问', '该员工已开卡，删除档案信息则同时删除卡户信息，继续请按确定', function(r) {
						if (r) {
							deleteByStatus(id);
						}
					});
				} else {
					deleteByStatus(id);
				}
			};
			
			//删除前判断该员工是否已经开卡
			function checkCardInfo(id) {
				var res = false;
				$.ajax({
					type : "post",
					dataType : "json",
					async : false,//同步
					url : datalook.contextPath + '/employee!noSy_checkCardInfo.action',
					data : {'data.id' : id},
				    success : function(data){
				    	if (data.success == true) {
							res = true;
							return;
						}
				    }
				});
				return res;
			}
			
			function deleteByStatus(id) {
				parent.$.messager.confirm('询问', '您确定要删除此记录？', function(r) {
					if (r) {
						$.post(
							datalook.contextPath + '/employee!deleteByStatus.action', 
							{'data.id' : id}, 
							function() {grid.datagrid('reload');}, 
							'json'
						);
					}
				});
			}
			/* ----------------------员工档案删除end---------------------- */
			
			/* ----------------------有档案开卡start---------------------- */
			function ArchivesOpenCard(id){
				var dialog = parent.ez.modalDialog({
					title : '有档案开卡',
					url : datalook.contextPath + '/pages/cardUserManage/cardForm.jsp?employeeid=' + id,
					buttons : [ 
					    {
					    	id : 'openCardInfo',
							text : '开卡',
							handler : function() {
								dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
							}
					    } 
					]
				});
			}
			/* ----------------------有档案开卡end---------------------- */
		</script>
	</head>
	<body class="easyui-layout" data-options="fit:true,border:false">
		<!-- 工具栏 -->
		<div id="toolbar" style="display: none;">
			<table>
				<tr>
					<td>
					    <!-- 搜索 -->
						<form id="searchForm">
							<table>
								<tr>
									<!-- 新增员工档案信息(权限控制) -->
									<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/employee!save')">
										<td>
											<a id="addFun" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_add',plain:true">添加</a>
										</td>
									</s:if>
									
								<s:if test="@com.datalook.util.base.CookieUtil@haveKeyValue('easyuiStyle','check')">
									<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/employee!update')">
										<td>
											<a id="editFun" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_edit',plain:true">编辑</a>
										</td>
									</s:if>
									<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/employee!deleteByStatus')">
										<td>
											<a id="removeFun" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_delete',plain:true">删除</a>
										</td>
									</s:if>
									
									<s:if test="@com.datalook.util.base.SecurityUtil@havePermission('/employee!saveArchivesOpenCard')">
										<td>
											<a id="archivesOpenCard" class="easyui-linkbutton" data-options="iconCls:'ext-icon-vcard_add',plain:true">有档案开卡</a>
										</td>
									</s:if>
								</s:if>
								
									
		 							<td>
		 								<!-- 分割线 -->
		 								<div class="datagrid-btn-separator"></div>
		 							</td>
									<td>员工号</td>
									<td>
										<input name="hqland_employeenumber_dengyu_String" style="width: 80px;"/>
									</td>
									<td>员工姓名</td>
									<td>
										<input name="hqland_employeename_mohu_String" style="width: 80px;"/>
									</td>
									<td>部门</td>
									<td>
										<input id="deptTree" name="hqland_department.id_dengyu_Integer" class="easyui-combotree" data-options="width:200"/>
									</td>
									<td>
										<a id="query" class="easyui-linkbutton" data-options="iconCls:'ext-icon-zoom',plain:true">过滤</a>
										<a id="clear" class="easyui-linkbutton" data-options="iconCls:'ext-icon-zoom_out',plain:true">重置过滤</a>
									</td>
								</tr>
							</table>
						</form>
					</td>
				</tr>
			</table>
		</div>
		<!-- 列表 -->
		<div data-options="region:'center',fit:true,border:false">
			<table id="grid" data-options="fit:true,border:false"></table>
		</div>
	</body>
</html>