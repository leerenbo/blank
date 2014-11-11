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
			$(function() {
				/* ---------------编辑操作员工档案信息加载start--------------- */
				if ($(':input[name="data.id"]').val().length > 0){
					parent.$.messager.progress({
						text : '数据加载中....'
					});
					$.post(
						datalook.contextPath + '/employee!getById.action', 
						{id : $(':input[name="data.id"]').val()}, 
						function(result) {
							if (result.id != undefined){
								$('form').form('load', {
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
							parent.$.messager.progress('close');
						}, 
						'json'
					);
				}
				/* ---------------编辑操作员工档案信息加载end--------------- */
			});
			
			/* ---------------提交前校验字段start--------------- */
			var submitForm = function($dialog, $grid, $pjq) {
				if ($('form').form('validate')) {
					if ($("#vacationdaysremain").val() == "") {
						$("#vacationdaysremain").numberbox('setValue', 0);
					}
					submitNow($dialog, $grid, $pjq);
		 		}
			};
			/* ---------------提交前校验字段end--------------- */
			
			/* ---------------提交start--------------- */
			var submitNow = function($dialog, $grid, $pjq) {
				var url;
				if ($(':input[name="data.id"]').val().length > 0) {
					/* --------------编辑员工档案信息-------------- */
					url = datalook.contextPath + '/employee!update.action';
				} else {
					/* --------------新政员工档案信息-------------- */
					url = datalook.contextPath + '/employee!save.action';
				}
				$.post(url, sy.serializeObject($('form')), function(result) {
					if (result.success) {
						$pjq.messager.alert('提示', result.msg, 'info');
						$grid.datagrid('load');
						$dialog.dialog('destroy');
					} else {
						$pjq.messager.alert('提示', result.msg, 'error');
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
							<img class="iconImg ext-icon-cross" onclick="$('#deptTree').combotree('clear');" title="清空"/>
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