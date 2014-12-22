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
%>
<!DOCTYPE html>
<html>
	<head>
		<title>员工档案增加</title>
		<jsp:include page="../../inc.jsp"></jsp:include>
		<jsp:include page="../../pub.jsp"></jsp:include>
		<script type="text/javascript">
			${symbol_dollar}(function() {
				/* ---------------编辑操作员工档案信息加载start--------------- */
				if (${symbol_dollar}(':input[name="data.id"]').val().length > 0){
					parent.${symbol_dollar}.messager.progress({
						text : '数据加载中....'
					});
					${symbol_dollar}.post(
						datalook.contextPath + '/employee!getById.action', 
						{id : ${symbol_dollar}(':input[name="data.id"]').val()}, 
						function(result) {
							if (result.id != undefined){
								${symbol_dollar}('form').form('load', {
									'data.id' : result.id,
									'data.status' : result.status,
									'data.employeenumber' : result.employeenumber,
									'data.employeename' : result.employeename,
									'data.department.id' : result.department.id,
									'data.sex' : result.sex,
									'data.telphone' : chkEmpty(result.telphone),
									'data.email' : chkEmpty(result.email),
									'data.vacationdaysremain' : result.vacationdaysremain,
									'data.workextrahours' : fomatNumToFloat(result.workextrahours)
								});
			 				}
							parent.${symbol_dollar}.messager.progress('close');
						}, 
						'json'
					);
				}
				/* ---------------编辑操作员工档案信息加载end--------------- */
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
				if (${symbol_dollar}(':input[name="data.id"]').val().length > 0) {
					/* --------------编辑员工档案信息-------------- */
					url = datalook.contextPath + '/employee!update.action';
				} else {
					/* --------------新政员工档案信息-------------- */
					url = datalook.contextPath + '/employee!save.action';
				}
				${symbol_dollar}.post(url, ez.serializeObject(${symbol_dollar}('form')), function(result) {
					if (result.success) {
						${symbol_dollar}pjq.messager.alert('提示', result.msg, 'info');
						${symbol_dollar}grid.datagrid('load');
						${symbol_dollar}dialog.dialog('destroy');
					} else {
						${symbol_dollar}pjq.messager.alert('提示', result.msg, 'error');
					}
				}, 'json');
			};
			/* ---------------提交end--------------- */
			
		</script>
	</head>
	<body>
		<form method="post" class="form">
			<!-- 主键id -->
			<input type="hidden" name="data.id" value="<%=id%>"/>
			<!-- 员工状态 0删除1正常2异常 -->
			<input type="hidden" name="data.status" value="1"/>
			<fieldset>
				<legend>员工档案信息</legend>
				<table class="table" style="width: 100%;">
					<tr>
						<th>员工号</th>
						<td>
							<input name="data.employeenumber" class="easyui-validatebox"
								data-options="required:true,validType:'chkCharAndNum[32]'"/>
						</td>
						<th>员工姓名</th>
						<td>
							<input name="data.employeename" class="easyui-validatebox" 
								data-options="required:true,validType:'chkCharAndChinese'"/>
						</td>
					</tr>
					<tr>
						<th>部门</th>
						<td>
							<input id="deptTree" name="data.department.id" class="easyui-combotree" data-options="required:true"/>
							<img class="iconImg ext-icon-cross" onclick="${symbol_dollar}('${symbol_pound}deptTree').combotree('clear');" title="清空"/>
						</td>
						<th>性别</th>
						<td>
							<select class="easyui-combobox" name="data.sex" data-options="panelHeight:'40',width:'156'">
								<option value="1">男</option>
								<option value="0">女</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>电话</th>
						<td>
							<input name="data.telphone" class="easyui-validatebox" 
								data-options="validType:'length[0,15]',invalidMessage:'长度不能超过15个字符'"/>
						</td>
						<th>邮箱</th>
						<td>
							<input name="data.email" class="easyui-validatebox" 
								data-options="validType:['email','length[0,50]']"/>
						</td>
					</tr>
					<tr>
						<th>剩余假期</th>
						<td>
							<input id="vacationdaysremain" name="data.vacationdaysremain" class="easyui-numberbox" value="0"
								data-options="validType:'length[0,8]',invalidMessage:'不能超过99999999天'"/>天
						</td>
						<th>已加班</th>
						<td>
							<input name="data.workextrahours" class="easyui-validatebox" value="0.0"
								data-options="validType:'chkFloat[99999999]'"/>小时
						</td>
					</tr>
				</table>
			</fieldset>
		</form>
	</body>
</html>