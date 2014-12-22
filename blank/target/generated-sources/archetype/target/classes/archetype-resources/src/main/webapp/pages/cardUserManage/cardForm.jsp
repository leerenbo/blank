#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
%>
<%
	String id = request.getParameter("id");
	if (id == null) {
		id = "";
	}
	
	String employeeid = request.getParameter("employeeid");
%>
<!DOCTYPE html>
<html>
	<head>
		<title>开卡</title>
		<jsp:include page="/opercard/operCardUtil.jsp"></jsp:include>
		<jsp:include page="../../pub.jsp"></jsp:include>
		<script type="text/javascript">
			${symbol_dollar}(function() {
				/* ---------------读卡start--------------- */
				${symbol_dollar}("${symbol_pound}readCard").click(function(){
					//参数为open时，会判断卡序列号是否被使用
					var cardInfo = readCardInfo("open");
					if (cardInfo != null && cardInfo != undefined) {
						${symbol_dollar}("${symbol_pound}cardid").val(cardInfo.cardid);
					}
				});
				/* ---------------读卡end--------------- */
				
				/* ---------------编辑卡户信息加载start--------------- */
				if (${symbol_dollar}(':input[name="data.id"]').val().length > 0){
					${symbol_dollar}("img").replaceWith("&nbsp;&nbsp;&nbsp;&nbsp;");//移除读卡，清除部门功能图片
					${symbol_dollar}("fieldset:last input").attr("readonly","readonly");//将档案信息改为只读
					${symbol_dollar}("${symbol_pound}deptTree").combotree('readonly',true);//部门只读
					${symbol_dollar}("${symbol_pound}sex").combobox('readonly',true);//性别只读
					parent.${symbol_dollar}.messager.progress({
						text : '数据加载中....'
					});
					${symbol_dollar}.post(
						datalook.contextPath + '/card!getById.action', 
						{id : ${symbol_dollar}(':input[name="data.id"]').val()}, 
						function(result) {
							if (result.id != undefined){
								${symbol_dollar}('form').form('load', {
									'data.id' : result.id,
									'data.status' : result.status,
									'data.employee.id' : result.employee.id,
									'data.employee.status' : result.employee.status,
									'data.cardid' : result.cardid,
									'data.cardpwd' : result.cardpwd,
									'data.employee.employeenumber' : result.employee.employeenumber,
									'data.employee.employeename' : result.employee.employeename,
									'data.employee.department.id' : result.employee.department.id,
									'data.employee.sex' : result.employee.sex,
									'data.employee.telphone' : chkEmpty(result.employee.telphone),
									'data.employee.email' : chkEmpty(result.employee.email),
									'data.employee.vacationdaysremain' : result.employee.vacationdaysremain,
									'data.employee.workextrahours' : fomatNumToFloat(result.employee.workextrahours)
								});
			 				}
							oldPassWord = result.cardpwd;
							parent.${symbol_dollar}.messager.progress('close');
						}, 
						'json'
					);
				}
				/* ---------------编辑卡户信息加载end--------------- */
				
				/* ---------------有档案开卡信息加载start--------------- */
				if (<%=employeeid%> != null){
					${symbol_dollar}("fieldset:last input").attr("readonly","readonly");//将档案信息改为只读
					${symbol_dollar}("${symbol_pound}deptTree").combotree('readonly',true);//部门只读
					${symbol_dollar}("${symbol_pound}sex").combobox('readonly',true);//性别只读
					parent.${symbol_dollar}.messager.progress({
						text : '数据加载中....'
					});
					${symbol_dollar}.post(
						datalook.contextPath + '/employee!getById.action', 
						{id : <%=employeeid%>}, 
						function(result) {
							if (result.id != undefined){
								${symbol_dollar}('form').form('load', {
									'data.id' : "",
									'data.status' : "1",
									'data.employee.id' : result.id,
									'data.employee.status' : result.status,
									'data.employee.employeenumber' : result.employeenumber,
									'data.employee.employeename' : result.employeename,
									'data.employee.department.id' : result.department.id,
									'data.employee.sex' : result.sex,
									'data.employee.telphone' : chkEmpty(result.telphone),
									'data.employee.email' : chkEmpty(result.email),
									'data.employee.vacationdaysremain' : result.vacationdaysremain,
									'data.employee.workextrahours' : fomatNumToFloat(result.workextrahours)
								});
			 				}
							parent.${symbol_dollar}.messager.progress('close');
						}, 
						'json'
					);
				}
				/* ---------------有档案开卡信息加载end--------------- */
			});
			
			/* ---------------提交前校验字段start--------------- */
			var submitForm = function(${symbol_dollar}dialog, ${symbol_dollar}grid, ${symbol_dollar}pjq) {
				if (${symbol_dollar}('form').form('validate')) {
					if (${symbol_dollar}("${symbol_pound}vacationdaysremain").val() == "") {
						${symbol_dollar}("${symbol_pound}vacationdaysremain").numberbox('setValue', 0);
					}
					submitNow(${symbol_dollar}dialog, ${symbol_dollar}grid, ${symbol_dollar}pjq);
		 		}
			};
			/* ---------------提交前校验字段end--------------- */
			
			/* ---------------提交start--------------- */
			var submitNow = function(${symbol_dollar}dialog, ${symbol_dollar}grid, ${symbol_dollar}pjq) {
				var url;
				if (${symbol_dollar}(':input[name="data.id"]').val().length > 0 || <%=employeeid%> != null) {
					/* --------------编辑卡信息与有档案开卡-------------- */
					url = datalook.contextPath + '/card!update.action';
				} else {
					/* --------------无档案开卡-------------- */
					url = datalook.contextPath + '/card!save.action';
				}
				${symbol_dollar}.post(url, ez.serializeObject(${symbol_dollar}('form')), function(result) {
					if (result.success) {
						/* --------------写卡start-------------- */
						${symbol_dollar}pjq.messager.progress({
							text : '正在写卡，请不要拿开卡片....'
						});
						var cardno = "00000000";
						var cardid = ${symbol_dollar}("${symbol_pound}cardid").val();
						var cardInfos = result.obj.split("@")[0];
						var newId = result.obj.split("@")[1];
						var res = writeCardInfo(cardno, cardid, cardInfos);
						${symbol_dollar}pjq.messager.progress('close');
						/* --------------写卡end-------------- */
						if (res == "0") {
							${symbol_dollar}pjq.messager.alert('提示', result.msg, 'info');
							${symbol_dollar}grid.datagrid('load');
							${symbol_dollar}dialog.dialog('destroy');
						} else if (res == "1") {
							${symbol_dollar}pjq.messager.alert('提示', '写卡失败，卡片不一致', 'error', function() {
								cancelOper(${symbol_dollar}dialog, ${symbol_dollar}grid, ${symbol_dollar}pjq, newId);
							});
						} else if (res == "2") {
							${symbol_dollar}pjq.messager.alert('提示', '写卡失败，卡片初始化错误', 'error', function() {
								cancelOper(${symbol_dollar}dialog, ${symbol_dollar}grid, ${symbol_dollar}pjq, newId);
							});
						} else if (res == "3") {
							${symbol_dollar}pjq.messager.alert('提示', '写卡失败，没有卡片', 'error', function() {
								cancelOper(${symbol_dollar}dialog, ${symbol_dollar}grid, ${symbol_dollar}pjq, newId);
							});
						} else if (res == "4") {
							${symbol_dollar}pjq.messager.alert('提示', '写卡失败，非法的写卡组织信息', 'error', function() {
								cancelOper(${symbol_dollar}dialog, ${symbol_dollar}grid, ${symbol_dollar}pjq, newId);
							});
						} else if (res == "-1") {
							${symbol_dollar}pjq.messager.alert('提示', '写卡失败，打开串口失败', 'error', function() {
								cancelOper(${symbol_dollar}dialog, ${symbol_dollar}grid, ${symbol_dollar}pjq, newId);
							});
						} else {
							${symbol_dollar}pjq.messager.alert('提示', '写卡失败', 'error', function() {
								cancelOper(${symbol_dollar}dialog, ${symbol_dollar}grid, ${symbol_dollar}pjq, newId);
							});
						}
					} else {
						${symbol_dollar}pjq.messager.alert('提示', result.msg, 'error');
					}
				}, 'json');
			};
			
			//撤销编辑，无档案开卡，与档案开卡
			function cancelOper(${symbol_dollar}dialog, ${symbol_dollar}grid, ${symbol_dollar}pjq, newId) {
				//无档案开卡撤销
				if (${symbol_dollar}(':input[name="data.id"]').val() == "" && <%=employeeid%> == null) {
					var cancelUrl = datalook.contextPath + '/card!noSy_cancelNoArchivesOpenCard.action?newId=' + newId;
					${symbol_dollar}.post(cancelUrl, ez.serializeObject(${symbol_dollar}('form')), function(result) {
						if (result.success) {
							${symbol_dollar}pjq.messager.alert('提示', result.msg, 'info');
							${symbol_dollar}grid.datagrid('load');
							${symbol_dollar}dialog.dialog('destroy');
						} else {
							${symbol_dollar}pjq.messager.alert('提示', result.msg, 'error');
						}
					}, 'json');
				}
				//编辑撤销
				if (${symbol_dollar}(':input[name="data.id"]').val().length > 0 && <%=employeeid%> == null) {
					${symbol_dollar}("${symbol_pound}cardpwd").val(oldPassWord);
					var cancelUrl = datalook.contextPath + '/card!noSy_cancelUpdate.action';
					${symbol_dollar}.post(cancelUrl, ez.serializeObject(${symbol_dollar}('form')), function(result) {
						if (result.success) {
							${symbol_dollar}pjq.messager.alert('提示', result.msg, 'info');
							${symbol_dollar}grid.datagrid('load');
							${symbol_dollar}dialog.dialog('destroy');
						} else {
							${symbol_dollar}pjq.messager.alert('提示', result.msg, 'error');
						}
					}, 'json');
					
				}
				//有档案开卡撤销
				if (${symbol_dollar}(':input[name="data.id"]').val() == "" && <%=employeeid%> != null) {
					var cancelUrl = datalook.contextPath + '/card!noSy_cancelArchivesOpenCard.action?newId=' + newId;
					${symbol_dollar}.post(cancelUrl, ez.serializeObject(${symbol_dollar}('form')), function(result) {
						if (result.success) {
							${symbol_dollar}pjq.messager.alert('提示', result.msg, 'info');
							${symbol_dollar}grid.datagrid('load');
							${symbol_dollar}dialog.dialog('destroy');
						} else {
							${symbol_dollar}pjq.messager.alert('提示', result.msg, 'error');
						}
					}, 'json');
				}
			}
			/* ---------------提交end--------------- */
		</script>
	</head>
	<body>
		<form method="post" class="form">
			<!-- 主键id -->
			<input type="hidden" name="data.id" value="<%=id%>"/>
			<!-- 卡状态 1正在使用2挂失3系统冻结4销户5预销户6手动冻结7换卡 -->
			<input type="hidden" name="data.status" value="1"/>
			<!-- 员工主键id -->
			<input type="hidden" name="data.employee.id" value=""/>
			<!-- 员工状态 0删除1正常2异常 -->
			<input type="hidden" name="data.employee.status" value="1"/>
			<fieldset>
				<legend>卡片信息</legend>
				<table class="table" style="width: 100%;">
					<tr>
						<th style="width: 60px;">卡序列号</th>
						<td style="width: 180px;">
							<input id="cardid" name="data.cardid" class="easyui-validatebox" readonly="readonly"
								data-options="required:true,validType:'length[1,32]',invalidMessage:'长度不能超过32个字符'"/>
							<img class="iconImg ext-icon-vcard" id="readCard" title="读卡"/>
						</td>
						<th style="width: 60px;">卡密码</th>
						<td style="width: 180px;">
							<input id="cardpwd" name="data.cardpwd" class="easyui-validatebox" type="password" value="123456"
								data-options="required:true,validType:'chkCharAndNum[6]'"/>
						</td>
					</tr>
				</table>
			</fieldset>
			<br>
			<fieldset>
				<legend>员工档案信息</legend>
				<table class="table" style="width: 100%;">
					<tr>
						<th style="width: 60px;">员工号</th>
						<td style="width: 180px;">
							<input name="data.employee.employeenumber" class="easyui-validatebox"
								data-options="required:true,validType:'chkCharAndNum[32]'"/>
						</td>
						<th style="width: 60px;">员工姓名</th>
						<td style="width: 180px;">
							<input name="data.employee.employeename" class="easyui-validatebox" 
								data-options="required:true,validType:'chkCharAndChinese'"/>
						</td>
					</tr>
					<tr>
						<th>部门</th>
						<td>
							<input id="deptTree" name="data.employee.department.id" class="easyui-combotree" data-options="required:true"/>
							<img class="iconImg ext-icon-cross" onclick="${symbol_dollar}('${symbol_pound}deptTree').combotree('clear');" title="清空"/>
						</td>
						<th>性别</th>
						<td>
							<select id="sex" class="easyui-combobox" name="data.employee.sex" data-options="panelHeight:'40',width:'156'">
								<option value="1">男</option>
								<option value="0">女</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>电话</th>
						<td>
							<input name="data.employee.telphone" class="easyui-validatebox" 
								data-options="validType:'length[0,15]',invalidMessage:'长度不能超过15个字符'"/>
						</td>
						<th>邮箱</th>
						<td>
							<input name="data.employee.email" class="easyui-validatebox" 
								data-options="validType:['email','length[0,50]']"/>
						</td>
					</tr>
					<tr>
						<th>剩余假期</th>
						<td>
							<input id="vacationdaysremain" name="data.employee.vacationdaysremain" class="easyui-numberbox" value="0"
								data-options="validType:'length[0,8]',invalidMessage:'长度不能超过8个数字'"/>天
						</td>
						<th>已加班</th>
						<td>
							<input name="data.employee.workextrahours" class="easyui-validatebox" value="0.0"
								data-options="validType:'chkFloat[99999999]'"/>小时
						</td>
					</tr>
				</table>
			</fieldset>
		</form>
	</body>
</html>