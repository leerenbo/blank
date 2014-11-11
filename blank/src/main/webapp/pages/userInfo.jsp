<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.datalook.model.sys.web.SessionInfo"%>
<%@ page import="com.datalook.model.sys.SysRole"%>
<%@ page import="com.datalook.model.sys.SysFunction"%>
<%@ page import="com.datalook.model.sys.easyui.Tree"%>
<%@ page import="com.datalook.util.base.DateUtil"%>
<%@ page import="com.datalook.util.base.BeanUtils"%>
<%@ page import="com.datalook.util.base.ConfigUtil"%>
<%@ page import="com.datalook.util.base.StringUtil"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.HashSet"%>
<%
	String contextPath = request.getContextPath();
	SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
	Set<SysRole> roles = sessionInfo.getSysUser().getSysRoles();//用户的角色
	List<SysFunction> resources = new ArrayList<SysFunction>();//用户可访问的资源
	for (SysRole role : roles) {
		resources.addAll(role.getSysFunctions());
	}
	resources = new ArrayList<SysFunction>(new HashSet<SysFunction>(resources));//去重
	List<Tree> resourceTree = new ArrayList<Tree>();
	for (SysFunction resource : resources) {
		Tree node = new Tree();
		BeanUtils.copyNotNullProperties(resource, node);
		node.setText(resource.getFunctionname());
		if (resource.getSysFunction() != null) {
			node.setPid(resource.getSysFunction().getId().toString());
		}
		resourceTree.add(node);
	}
	String resourceTreeJson = com.alibaba.fastjson.JSON.toJSONString(resourceTree);
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<jsp:include page="../inc.jsp"></jsp:include>
<%
	out.println("<script>var resourceTreeJson = '" + resourceTreeJson + "';</script>");
%>
<script type="text/javascript">
	$(function() {
		$('#resources').tree({
			parentField : 'pid',
			data : eval("(" + resourceTreeJson + ")")
		});
	});
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',fit:true,border:false">
		<table style="width: 100%;">
			<tr>
				<td><fieldset>
						<legend>用户信息</legend>
						<table class="table" style="width: 100%;">
							<tr>
								<th>用户ID</th>
								<td><%=sessionInfo.getSysUser().getId()%></td>
							</tr>
							<tr>
								<th>账户</th>
								<td><%=sessionInfo.getSysUser().getUsername()%></td>
								<th>姓名</th>
								<td><%=sessionInfo.getSysUser().getRealname()%></td>
							</tr>
						</table>
					</fieldset></td>
			</tr>
			<tr>
				<td>
					<fieldset>
						<legend>权限信息</legend>
						<table class="table" style="width: 100%;">
							<thead>
								<tr>
									<th>角色</th>
									<th>机构</th>
									<th>权限</th>
								</tr>
							</thead>
							<tr>
								<td valign="top">
									<%
										out.println("<ul>");
										for (SysRole role : roles) {
											out.println(StringUtil.formateString("<li>{0}</li>", role.getRolename()));
										}
										out.println("</ul>");
									%>
								</td>
								<td valign="top"><ul id="resources"></ul></td>
							</tr>
						</table>
					</fieldset>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>