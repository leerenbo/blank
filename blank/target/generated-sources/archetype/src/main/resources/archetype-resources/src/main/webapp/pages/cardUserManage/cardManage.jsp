#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../opercard/operCardUtil.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<title>卡户管理</title>
		<jsp:include page="../../pub.jsp"></jsp:include>
		<script type="text/javascript">
			var grid;
			${symbol_dollar}(function (){
				/* ----------------------列表start---------------------- */
				grid = ${symbol_dollar}('${symbol_pound}grid').datagrid({
					title : '',
					url : datalook.contextPath + '/card!grid.action?hqland_status_in_String=1|2|3|5|6',
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
				   			<s:if test="@${package}.util.base.CookieUtil@haveKeyValue('easyuiStyle','check')">
				   			{	                    
				   				field:'ck',
				   				checkbox:true
				   			},
				   			</s:if>
							{
								width : '100',
								title : '卡序列号',
								field : 'cardid',
								sortable : true
							}, 
							{
								width : '70',
								title : '卡户状态',
								field : 'status',
								sortable : true,
								formatter : function(value,row,index){
									if (row.status == '1') {
										return "正常";
									} else if (row.status == '2') {
										return "挂失";
									} else if (row.status == '3') {
										return "系统冻结";
									} else if (row.status == '5') {
										return "预销户";
									} else if (row.status == '6') {
										return "手动冻结";
									}
								}
							},
							{
								width : '150',
								title : '员工号',
								field : 'employeenumber',
								sortable : true,
								formatter : function(value,row,index){
									if (row.employee == undefined) {
										return "";
									}
									return row.employee.employeenumber;
								}
							}, 
							{
								width : '100',
								title : '员工姓名',
								field : 'employeename',
								sortable : true,
								formatter : function(value,row,index){
									if (row.employee == undefined) {
										return "";
									}
									return row.employee.employeename;
								}
							}
						]
					],
					columns : [ 
						[   
							{
								width : '100',
								title : '部门',
								field : 'departmentid',
								sortable : true,
								formatter : function(value,row,index){
									if (row.employee == undefined || row.employee.department == undefined || row.employee.department.id == undefined) {
										return "";
									}
									for (var i = 0; i < departmentList.length; i++) {
										if (row.employee.department.id == departmentList[i].id) {
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
									if (row.employee == undefined) {
										return "";
									}
									if (row.employee.sex == '1') {
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
									if (row.employee == undefined) {
										return "";
									}
									return chkEmpty(row.employee.telphone);
								}
							}, 
							{
								width : '150',
								title : '邮箱',
								field : 'email',
								sortable : false,
								formatter : function(value,row,index){
									if (row.employee == undefined) {
										return "";
									}
									return chkEmpty(row.employee.email);
								}
							}, 
							{
								width : '100',
								title : '剩余假期（天）',
								field : 'vacationdaysremain',
								sortable : false,
								formatter : function(value,row,index){
									if (row.employee == undefined) {
										return "";
									}
									var res = chkEmpty(row.employee.vacationdaysremain);
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
									if (row.employee == undefined) {
										return "";
									}
									return fomatNumToFloat(row.employee.workextrahours);
								}
							}
							<s:if test="@${package}.util.base.CookieUtil@haveKeyValue('easyuiStyle','icon')">
							,
							{
								title : '操作',
								field : 'action',
								width : '100',
								formatter : function(value, row){
									var str = '';
									if (row.id > 30000000) {
										<s:if test="@${package}.util.base.SecurityUtil@havePermission('/card!update')">
											str += ez.formatString('<img class="iconImg ext-icon-note_edit" title="编辑" onclick="editFun(${symbol_escape}'{0}${symbol_escape}');"/>', row.id);
										</s:if>
									}
									if (row.id > 30000000) {
										<s:if test="@${package}.util.base.SecurityUtil@havePermission('/card!deleteByStatus')">
											str += ez.formatString('<img class="iconImg ext-icon-note_delete" title="销户" onclick="removeFun(${symbol_escape}'{0}${symbol_escape}', ${symbol_escape}'{1}${symbol_escape}');"/>', row.id, row.employee.id);
										</s:if>
									}
									if (row.status == '1' && row.id > 30000000) {
										<s:if test="@${package}.util.base.SecurityUtil@havePermission('/card!cardLoss')">
											str += ez.formatString('<img class="iconImg ext-icon-key_delete" title="挂失" onclick="cardLoss(${symbol_escape}'{0}${symbol_escape}');"/>', row.id);
										</s:if>
									} else if (row.status == '2' && row.id > 30000000) {
										<s:if test="@${package}.util.base.SecurityUtil@havePermission('/card!cardRemoveLoss')">
											str += ez.formatString('<img class="iconImg ext-icon-key_add" title="解挂" onclick="cardRemoveLoss(${symbol_escape}'{0}${symbol_escape}');"/>', row.id);
										</s:if>
										<s:if test="@${package}.util.base.SecurityUtil@havePermission('/card!cardChange')">
											str += ez.formatString('<img class="iconImg ext-icon-page_refresh" title="换卡" onclick="cardChange(${symbol_escape}'{0}${symbol_escape}');"/>', row.id);
										</s:if>
									}
									return str;
								}
							}
							</s:if>
						] 
					],
					toolbar : '${symbol_pound}toolbar',
					onBeforeLoad : function(param){
						parent.${symbol_dollar}.messager.progress({
							text : '数据加载中....'
						});
					},
					onLoadSuccess : function(data){
						${symbol_dollar}('.iconImg').attr('src', ez.pixel_0);
						parent.${symbol_dollar}.messager.progress('close');
					}
				});
				/* ----------------------列表end---------------------- */
				
				/* ----------------------无档案开卡start---------------------- */
				${symbol_dollar}("${symbol_pound}noArchivesOpenCard").click(function(){
					var dialog = parent.ez.modalDialog({
						title : '无档案开卡',
						url : datalook.contextPath + '/pages/cardUserManage/cardForm.jsp',
						buttons : [ 
						    {
								id : 'openCardInfo',
								text : '开卡',
								handler : function() {
									dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.${symbol_dollar});
								}
							} 
						]
					});
				});
				/* ----------------------无档案开卡end---------------------- */
				
				/* ----------------------过滤和重置过滤start---------------------- */
				${symbol_dollar}("${symbol_pound}query").click(function(){
					grid.datagrid('load',ez.serializeObject(${symbol_dollar}('${symbol_pound}searchForm')));
				});
				
				${symbol_dollar}("${symbol_pound}clear").click(function(){
					${symbol_dollar}('${symbol_pound}searchForm input').val('');
					grid.datagrid('load',{});
				});
				/* ----------------------过滤和重置过滤end---------------------- */
				
				/* ---------------读卡start--------------- */
				${symbol_dollar}("${symbol_pound}readCard").click(function(){
					//参数为空时，不判断卡序列号是否已被使用，直接读卡信息。参数为open时，判断卡序列号是否已经被使用
					var cardInfo = readCardInfo("");
					if (cardInfo != null && cardInfo != undefined) {
						${symbol_dollar}("${symbol_pound}cardid").val(cardInfo.cardid);
					}
				});
				/* ---------------读卡end--------------- */
				
				/* ----------------------卡户编辑start---------------------- */
				${symbol_dollar}("${symbol_pound}editFun").click(function() {
					//单行判断
					var rows = ${symbol_dollar}("${symbol_pound}grid").datagrid('getChecked');
					if (rows.length > 1) {
						${symbol_dollar}.messager.alert('提示', '请选择一条信息进行操作', 'info');
						return;
					}
					//如果是一卡通同步数据，禁止编辑
					var id = rows[0].id;
					if (id <= 30000000) {
						${symbol_dollar}.messager.alert('提示', '一卡通同步数据，不允许编辑', 'info');
						return;
					}
					var dialog = parent.ez.modalDialog({
						title : '编辑卡信息',
						url : datalook.contextPath + '/pages/cardUserManage/cardForm.jsp?id=' + id,
						buttons : [ 
						    {
						    	id : 'openCardInfo',
								text : '编辑',
								handler : function() {
									dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.${symbol_dollar});
								}
						    } 
						]
					});
				});
				/* ----------------------卡户编辑end---------------------- */
				
				/* ----------------------销户start---------------------- */
				${symbol_dollar}("${symbol_pound}removeFun").click(function() {
					//单行判断
					var rows = ${symbol_dollar}("${symbol_pound}grid").datagrid('getChecked');
					console.info(rows);
					for(var i=0;i<rows.length;i++){
						xiaohu(rows[i]);
					}
					grid.datagrid('clearSelections');
				});
				function xiaohu(row){
					//如果是一卡通同步数据，禁止销户
					if (row.id <= 30000000) {
						${symbol_dollar}.messager.alert('提示', '一卡通同步数据，不允许销户', 'info');
						return;
					}
					parent.${symbol_dollar}.messager.confirm('询问', '您确定要销户['+row.employee.employeename+row.employee.employeenumber+']', function(r) {
						if (r) {
							${symbol_dollar}.post(
								datalook.contextPath + '/card!deleteByStatus.action', 
								{
									'data.id' : row.id,
									'data.employee.id' : row.employee.id
								}, 
								function() {
									grid.datagrid('deleteRow',grid.datagrid('getRowIndex',row));
								}, 
								'json'
							);
						}
					});
				}
				/* ----------------------销户end---------------------- */
				
				/* ----------------------挂失解挂start---------------------- */
				//打开挂失页面
				${symbol_dollar}("${symbol_pound}cardLoss").click(function() {
					//单行判断
					var rows = ${symbol_dollar}("${symbol_pound}grid").datagrid('getChecked');
					if (rows.length > 1) {
						${symbol_dollar}.messager.alert('提示', '请选择一条信息进行操作', 'info');
						return;
					}
					//如果是一卡通同步数据，禁止挂失
					var id = rows[0].id;
					if (id <= 30000000) {
						${symbol_dollar}.messager.alert('提示', '一卡通同步数据，不允许挂失', 'info');
						return;
					}
					//只有正常状态允许挂失
					var status = rows[0].status;
					if (status != "1") {
						${symbol_dollar}.messager.alert('提示', '卡状态非正常，不允许挂失', 'info');
						return;
					}
					${symbol_dollar}.post(
						datalook.contextPath + '/card!getById.action', 
						{id : id},
						function(result) {
							${symbol_dollar}("${symbol_pound}cardKey").val(result.id);
							${symbol_dollar}("${symbol_pound}employeeid").val(result.employee.id);
							${symbol_dollar}("${symbol_pound}employeenumber").val(result.employee.employeenumber);
							${symbol_dollar}("${symbol_pound}employeename").val(result.employee.employeename);
							showBtn("挂失", 1);
							${symbol_dollar}("${symbol_pound}lossDialog").dialog('open');
						}, 
						'json'
					);
				});
				
				//打开解挂页面
				${symbol_dollar}("${symbol_pound}cardRemoveLoss").click(function() {
					//单行判断
					var rows = ${symbol_dollar}("${symbol_pound}grid").datagrid('getChecked');
					if (rows.length > 1) {
						${symbol_dollar}.messager.alert('提示', '请选择一条信息进行操作', 'info');
						return;
					}
					//如果是一卡通同步数据，禁止解挂
					var id = rows[0].id;
					if (id <= 30000000) {
						${symbol_dollar}.messager.alert('提示', '一卡通同步数据，不允许解挂', 'info');
						return;
					}
					//只有挂失状态允许解挂
					var status = rows[0].status;
					if (status != "2") {
						${symbol_dollar}.messager.alert('提示', '卡状态非挂失，不允许解挂', 'info');
						return;
					}
					${symbol_dollar}.post(
						datalook.contextPath + '/card!getById.action', 
						{id : id},
						function(result) {
							${symbol_dollar}("${symbol_pound}cardKey").val(result.id);
							${symbol_dollar}("${symbol_pound}employeeid").val(result.employee.id);
							${symbol_dollar}("${symbol_pound}employeenumber").val(result.employee.employeenumber);
							${symbol_dollar}("${symbol_pound}employeename").val(result.employee.employeename);
							showBtn("解挂", 2);
							${symbol_dollar}("${symbol_pound}lossDialog").dialog('open');
						}, 
						'json'
					);
				});
				
				//为lossDialog添加挂失解挂按钮
				//btnName(挂失，解挂) operateType(1为挂失方法，2为解挂方法)
				function showBtn(btnName, operateType) {
					${symbol_dollar}("${symbol_pound}lossDialog").show().dialog({
						modal : true,
						closable : false,
						iconCls : 'ext-icon-lock_open',
						buttons : [
							{
								id : 'cardLossBtn',
								text : btnName,
								handler : function() {
									lossSubmit(operateType);
								}
							},
							{
								id : 'closeCardLossBtn',
								text : '关闭',
								handler : function() {
									${symbol_dollar}("${symbol_pound}lossDialog").dialog('close');
								}
							}
						],
						onOpen : function() {
							${symbol_dollar}("${symbol_pound}cardpwd").val("");
							${symbol_dollar}("form :input").keyup(function(event) {
								if (event.keyCode == 13) {
									lossSubmit(operateType);
								}
							});
						}
					}).dialog('close');
				};
				
				//挂失解挂提交
				function lossSubmit(operateType) {
					if (${symbol_dollar}("${symbol_pound}lossDialog form").form('validate')) {
						var url = "";
						if (operateType == 1) {
							url = datalook.contextPath + '/card!noSy_cardLoss.action';
						} else {
							url = datalook.contextPath + '/card!noSy_cardRemoveLoss.action';
						}
						${symbol_dollar}("${symbol_pound}cardLossBtn").linkbutton('disable');
						${symbol_dollar}.post(
							url, 
							${symbol_dollar}("${symbol_pound}lossDialog form").serialize(), 
							function(result) {
								if (result.success) {
									${symbol_dollar}("${symbol_pound}lossDialog").dialog('close');
									${symbol_dollar}.messager.alert('提示', result.msg, 'info', function() {
										grid.datagrid('reload');
									});
								} else {
									${symbol_dollar}.messager.alert('提示', result.msg, 'error', function() {
										${symbol_dollar}("${symbol_pound}lossDialog form :input:eq(3)").focus();
									});
								}
								${symbol_dollar}("${symbol_pound}cardLossBtn").linkbutton('enable');
							}, 
							'json'
						);
					}
				};
				/* ----------------------挂失解挂end---------------------- */

				
			});
			
			/* ----------------------卡户编辑start---------------------- */
			function editFun(id) {
				var dialog = parent.ez.modalDialog({
					title : '编辑卡信息',
					url : datalook.contextPath + '/pages/cardUserManage/cardForm.jsp?id=' + id,
					buttons : [ 
					    {
					    	id : 'openCardInfo',
							text : '编辑',
							handler : function() {
								dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.${symbol_dollar});
							}
					    } 
					]
				});
			};
			/* ----------------------卡户编辑end---------------------- */
			
			/* ----------------------销户start---------------------- */
			function removeFun(id, employeeid) {
				parent.${symbol_dollar}.messager.confirm('询问', '您确定要销户？', function(r) {
					if (r) {
						${symbol_dollar}.post(
							datalook.contextPath + '/card!deleteByStatus.action', 
							{
								'data.id' : id,
								'data.employee.id' : employeeid
							}, 
							function() {grid.datagrid('reload');}, 
							'json'
						);
					}
				});
			};
			

			/* ----------------------销户end---------------------- */
			
			/* ----------------------挂失解挂start---------------------- */
			//打开挂失页面
			function cardLoss(id){
				${symbol_dollar}.post(
					datalook.contextPath + '/card!getById.action', 
					{id : id},
					function(result) {
						${symbol_dollar}("${symbol_pound}cardKey").val(result.id);
						${symbol_dollar}("${symbol_pound}employeeid").val(result.employee.id);
						${symbol_dollar}("${symbol_pound}employeenumber").val(result.employee.employeenumber);
						${symbol_dollar}("${symbol_pound}employeename").val(result.employee.employeename);
						showBtn("挂失", 1);
						${symbol_dollar}("${symbol_pound}lossDialog").dialog('open');
					}, 
					'json'
				);
			}
			
			//打开解挂页面
			function cardRemoveLoss(id){
				${symbol_dollar}.post(
					datalook.contextPath + '/card!getById.action', 
					{id : id},
					function(result) {
						${symbol_dollar}("${symbol_pound}cardKey").val(result.id);
						${symbol_dollar}("${symbol_pound}employeeid").val(result.employee.id);
						${symbol_dollar}("${symbol_pound}employeenumber").val(result.employee.employeenumber);
						${symbol_dollar}("${symbol_pound}employeename").val(result.employee.employeename);
						showBtn("解挂", 2);
						${symbol_dollar}("${symbol_pound}lossDialog").dialog('open');
					}, 
					'json'
				);
			}
			
			//为lossDialog添加挂失解挂按钮
			//btnName(挂失，解挂) operateType(1为挂失方法，2为解挂方法)
			function showBtn(btnName, operateType) {
				${symbol_dollar}("${symbol_pound}lossDialog").show().dialog({
					modal : true,
					closable : false,
					iconCls : 'ext-icon-lock_open',
					buttons : [
						{
							id : 'cardLossBtn',
							text : btnName,
							handler : function() {
								lossSubmit(operateType);
							}
						},
						{
							id : 'closeCardLossBtn',
							text : '关闭',
							handler : function() {
								${symbol_dollar}("${symbol_pound}lossDialog").dialog('close');
							}
						}
					],
					onOpen : function() {
						${symbol_dollar}("${symbol_pound}cardpwd").val("");
						${symbol_dollar}("form :input").keyup(function(event) {
							if (event.keyCode == 13) {
								lossSubmit(operateType);
							}
						});
					}
				}).dialog('close');
			};
			
			//挂失解挂提交
			function lossSubmit(operateType) {
				if (${symbol_dollar}("${symbol_pound}lossDialog form").form('validate')) {
					var url = "";
					if (operateType == 1) {
						url = datalook.contextPath + '/card!noSy_cardLoss.action';
					} else {
						url = datalook.contextPath + '/card!noSy_cardRemoveLoss.action';
					}
					${symbol_dollar}("${symbol_pound}cardLossBtn").linkbutton('disable');
					${symbol_dollar}.post(
						url, 
						${symbol_dollar}("${symbol_pound}lossDialog form").serialize(), 
						function(result) {
							if (result.success) {
								${symbol_dollar}("${symbol_pound}lossDialog").dialog('close');
								${symbol_dollar}.messager.alert('提示', result.msg, 'info', function() {
									grid.datagrid('reload');
								});
							} else {
								${symbol_dollar}.messager.alert('提示', result.msg, 'error', function() {
									${symbol_dollar}("${symbol_pound}lossDialog form :input:eq(3)").focus();
								});
							}
							${symbol_dollar}("${symbol_pound}cardLossBtn").linkbutton('enable');
						}, 
						'json'
					);
				}
			};
			/* ----------------------挂失解挂end---------------------- */
			
			/* ----------------------换卡start---------------------- */
			//换卡读卡
			${symbol_dollar}(function (){
				${symbol_dollar}("${symbol_pound}cardChange_readCard").click(function(){
					//参数为空时，不判断卡序列号是否已被使用，直接读卡信息。参数为open时，判断卡序列号是否已经被使用
					var cardInfo = readCardInfo("open");
					if (cardInfo != null && cardInfo != undefined) {
						${symbol_dollar}("${symbol_pound}cardChange_cardid").val(cardInfo.cardid);
					}
				});
			});
			
			//打开换卡页面
			function cardChange(id){
				${symbol_dollar}.post(
					datalook.contextPath + '/card!getById.action', 
					{id : id},
					function(result) {
						${symbol_dollar}("${symbol_pound}cardChange_cardKey").val(result.id);
						${symbol_dollar}("${symbol_pound}cardChange_employeeid").val(result.employee.id);
						${symbol_dollar}("${symbol_pound}cardChange_employeenumber").val(result.employee.employeenumber);
						${symbol_dollar}("${symbol_pound}cardChange_employeename").val(result.employee.employeename);
						showChangeBtn("换卡");
						${symbol_dollar}("${symbol_pound}cardChangeDialog").dialog('open');
					}, 
					'json'
				);
			}
			
			//为cardChangeDialog添加换卡按钮
			//btnName(换卡)
			function showChangeBtn(btnName) {
				${symbol_dollar}("${symbol_pound}cardChangeDialog").show().dialog({
					modal : true,
					closable : false,
					iconCls : 'ext-icon-lock_open',
					buttons : [
						{
							id : 'cardChangeBtn',
							text : btnName,
							handler : function() {
								cardChangeSubmit();
							}
						},
						{
							id : 'closeCardChangeBtn',
							text : '关闭',
							handler : function() {
								${symbol_dollar}("${symbol_pound}cardChangeDialog").dialog('close');
							}
						} 
					],
					onOpen : function() {
						${symbol_dollar}("${symbol_pound}cardChange_cardpwd").val("123456");
						${symbol_dollar}("${symbol_pound}cardChange_cardid").val("");
						${symbol_dollar}("${symbol_pound}cardChange_dumpCardpwd").val("123456");
						${symbol_dollar}("form :input").keyup(function(event) {
							if (event.keyCode == 13) {
								cardChangeSubmit();
							}
						});
					}
				}).dialog('close');
			};
			
			//换卡提交
			function cardChangeSubmit() {
				if (${symbol_dollar}("${symbol_pound}cardChangeDialog form").form('validate')) {
					var url = datalook.contextPath + '/card!noSy_cardChange.action';
					${symbol_dollar}("${symbol_pound}cardChangeBtn").linkbutton('disable');
					${symbol_dollar}.post(
						url, 
						${symbol_dollar}("${symbol_pound}cardChangeDialog form").serialize(), 
						function(result) {
							if (result.success) {
								/* --------------写卡start-------------- */
								${symbol_dollar}.messager.progress({
									text : '正在写卡，请不要拿开卡片....'
								});
								var cardno = "00000000";
								var cardid = ${symbol_dollar}("${symbol_pound}cardChange_cardid").val();
								var cardInfos = result.obj.split("@")[0];
								var newId = result.obj.split("@")[1];
								var res = writeCardInfo(cardno, cardid, cardInfos);
								${symbol_dollar}.messager.progress('close');
								/* --------------写卡end-------------- */
								if (res == "0") {
									${symbol_dollar}("${symbol_pound}cardChangeDialog").dialog('close');
									${symbol_dollar}.messager.alert('提示', result.msg, 'info', function() {
										grid.datagrid('reload');
									});
								} else if (res == "1") {
									${symbol_dollar}.messager.alert('提示', '写卡失败，卡片不一致', 'error', function() {
										cancelOper(newId);
									});
								} else if (res == "2") {
									${symbol_dollar}.messager.alert('提示', '写卡失败，卡片初始化错误', 'error', function() {
										cancelOper(newId);
									});
								} else if (res == "3") {
									${symbol_dollar}.messager.alert('提示', '写卡失败，没有卡片', 'error', function() {
										cancelOper(newId);
									});
								} else if (res == "4") {
									${symbol_dollar}.messager.alert('提示', '写卡失败，非法的写卡组织信息', 'error', function() {
										cancelOper(newId);
									});
								} else if (res == "-1") {
									${symbol_dollar}.messager.alert('提示', '写卡失败，打开串口失败', 'error', function() {
										cancelOper(newId);
									});
								} else {
									${symbol_dollar}.messager.alert('提示', '写卡失败', 'error', function() {
										cancelOper(newId);
									});
								}
							} else {
								${symbol_dollar}.messager.alert('提示', result.msg, 'error', function() {
									${symbol_dollar}("${symbol_pound}cardChangeDialog form :input:eq(4)").focus();
								});
							}
						}, 
						'json'
					);
					${symbol_dollar}("${symbol_pound}cardChangeBtn").linkbutton('enable');
				}
			};
			
			//撤销换卡
			function cancelOper(newId){
				var cancelUrl = datalook.contextPath + '/card!noSy_cancelCardChange.action?newId=' + newId;
				${symbol_dollar}.post(cancelUrl, ez.serializeObject(${symbol_dollar}("${symbol_pound}cardChangeDialog form")), function(result) {
					if (result.success) {
						${symbol_dollar}("${symbol_pound}cardChangeDialog").dialog('close');
						${symbol_dollar}.messager.alert('提示', result.msg, 'info', function() {
							grid.datagrid('reload');
						});
					} else {
						${symbol_dollar}.messager.alert('提示', result.msg, 'error');
					}
				}, 'json');
			};
			/* ----------------------换卡end---------------------- */
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
									<!-- 开卡(权限控制) -->
									<s:if test="@${package}.util.base.SecurityUtil@havePermission('/card!save')">
										<td>
											<a id="noArchivesOpenCard" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_add',plain:true">无档案开卡</a>
										</td>
									</s:if>
									<s:if test="@${package}.util.base.CookieUtil@haveKeyValue('easyuiStyle','check')">
										<s:if test="@${package}.util.base.SecurityUtil@havePermission('/card!update')">
											<td>
												<a id="editFun" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_edit',plain:true">编辑</a>
											</td>
										</s:if>
										<!-- 销户(权限控制) -->
										<s:if test="@${package}.util.base.SecurityUtil@havePermission('/card!deleteByStatus')">
											<td>
												<a id="removeFun" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_delete',plain:true">销户</a>
											</td>
										</s:if>
										<!-- 挂失(权限控制) -->
										<s:if test="@${package}.util.base.SecurityUtil@havePermission('/card!cardLoss')">
											<td>
												<a id="cardLoss" class="easyui-linkbutton" data-options="iconCls:'ext-icon-key_delete',plain:true">挂失</a>
											</td>
										</s:if>
										<!-- 解挂(权限控制) -->
										<s:if test="@${package}.util.base.SecurityUtil@havePermission('/card!cardRemoveLoss')">
											<td>
												<a id="cardRemoveLoss" class="easyui-linkbutton" data-options="iconCls:'ext-icon-key_add',plain:true">解挂</a>
											</td>
										</s:if>
										<!-- 换卡(权限控制) -->
										<s:if test="@${package}.util.base.SecurityUtil@havePermission('/card!cardChange')">
											<td>
												<a id="cardChange" onclick="var rows = ${symbol_dollar}('${symbol_pound}grid').datagrid('getChecked');if(rows.length>0){cardChange(rows[0].id)}" class="easyui-linkbutton" data-options="iconCls:'ext-icon-page_refresh',plain:true">换卡</a>
											</td>
										</s:if>
									</s:if>
		 							<td>
		 								<!-- 分割线 -->
		 								<div class="datagrid-btn-separator"></div>
		 							</td>
		 							<td>卡序列号</td>
									<td>
										<input id="cardid" name="hqland_cardid_dengyu_String" class="easyui-validatebox"/>
										<img class="iconImg ext-icon-vcard" id="readCard" title="读卡"/>
									</td>
									<td>员工号</td>
									<td>
										<input name="hqland_employee.employeenumber_dengyu_String" style="width: 80px;"/>
									</td>
									<td>员工姓名</td>
									<td>
										<input name="hqland_employee.employeename_mohu_String" style="width: 80px;"/>
									</td>
									<td>部门</td>
									<td>
										<input id="deptTree" name="data.department.id" class="easyui-combotree" data-options="width:200"/>
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
		<!-- 挂失解挂弹框 -->
		<div id="lossDialog" title="挂失解挂" style="display: none;">
			<form method="post" class="form" onsubmit="return false;">
				<input id="cardKey" name="data.id" type="hidden"/>
				<input id="employeeid" name="data.employee.id" type="hidden"/>
				<table class="table">
					<tr>
						<th>员工号</th>
						<td>
							<input id="employeenumber" name="data.employee.employeenumber" readonly="readonly" class="easyui-validatebox" value=""/>
						</td>
					</tr>
					<tr>
						<th>员工姓名</th>
						<td>
							<input id="employeename" name="data.employee.employeename" readonly="readonly" class="easyui-validatebox" value=""/>
						</td>
					</tr>
					<tr>
						<th>密码</th>
						<td>
							<input id="cardpwd" name="data.cardpwd" class="easyui-validatebox" type="password"
								data-options="required:true,validType:'chkCharAndNum[6]'"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<!-- 换卡弹框 -->
		<div id="cardChangeDialog" title="换卡" style="display: none;">
			<form method="post" class="form" onsubmit="return false;">
				<input id="cardChange_cardKey" name="data.id" type="hidden"/>
				<input id="cardChange_employeeid" name="data.employee.id" type="hidden"/>
				<fieldset>
					<legend>原卡户信息</legend>
					<table class="table" style="width: 100%;">
						<tr>
							<th>员工号</th>
							<td>
								<input id="cardChange_employeenumber" name="data.employee.employeenumber" readonly="readonly" class="easyui-validatebox" value=""/>
							</td>
							<th>员工姓名</th>
							<td>
								<input id="cardChange_employeename" name="data.employee.employeename" readonly="readonly" class="easyui-validatebox" value=""/>
							</td>
						</tr>
					</table>
				</fieldset>
				<br/>
				<fieldset>
					<legend>新卡户信息</legend>
					<table class="table" style="width: 100%;">
						<tr>
							<th>卡序列号</th>
							<td colspan="3">
								<input id="cardChange_cardid" name="changeCard.cardid" class="easyui-validatebox"/>
								<img class="iconImg ext-icon-vcard" id="cardChange_readCard" title="读卡"/>
							</td>
						</tr>
						<tr>
							<th>卡密码</th>
							<td>
								<input id="cardChange_cardpwd" name="changeCard.cardpwd" class="easyui-validatebox" type="password"
									data-options="required:true,validType:'chkCharAndNum[6]'"/>
							</td>
							<th>重复卡密码</th>
							<td>
								<input id="cardChange_dumpCardpwd" type="password" class="easyui-validatebox" data-options="required:true,validType:'eqPwd[${symbol_escape}'${symbol_pound}cardChange_cardpwd${symbol_escape}']'"/>
							</td>
						</tr>
					</table>
				</fieldset>
				<input id="cardChange_status" name="changeCard.status" type="hidden" value="1"/>
			</form>
		</div>
	</body>
</html>