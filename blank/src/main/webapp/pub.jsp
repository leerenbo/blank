<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%String contextPath = request.getContextPath();%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	/* ----------------------获得部门信息start---------------------- */
	var departmentList = "";
	$.ajax({
		type : "post", 
		async : false,//同步
		url : "<%=contextPath%>/department!noSnSy_findAll.action?hqland_status_dengyu_String=1",
		success : function(data){
			departmentList = eval(data);
		}
	});
	/* ----------------------获得部门信息end---------------------- */
	
	/* ----------------------获得卡序列号加密密钥start---------------------- */
	var cdidencryption = "";	
	$.ajax({
		type : "post", 
		async : false,//同步
		url : "<%=contextPath%>/sysParamDef!noSnSy_findAll.action",
		success : function(data) {
			res = eval(data);
			if (res != null && res.lengtn > 0) {
				cdidencryption = res[0].cdidencryption;
			} else {
				cdidencryption = "";
			}
		}
	});
	/* ----------------------获得卡序列号加密密钥end---------------------- */
	
	/* ----------------------部门树start---------------------- */
	$(function (){
		$("#deptTree").combotree({
			editable : false,
			url : '<%=contextPath%>/department!noSnSy_getDeptTreeData.action',
			checkbox : false,
			multiple : false,
			onSelect : function(node){
				var tree = $(this).tree;//返回树对象
				var isLeaf = tree('isLeaf', node.target);
				/*
				if (!isLeaf) {
					$("#deptTree").combotree('clear');//选中的节点是否为叶子节点。如果不是清除选中
				}
				*/
			}
		});
	});
	/* ----------------------部门树end---------------------- */
	
	/* ----------------------判断空start---------------------- */
	function chkEmpty(str){
		if (str == null || str == undefined || str == "undefined" || str == "null") {
			str = "";
		} 
		return str;
	}
	/* ----------------------判断空end---------------------- */
	
	/* ----------------------将整数格式化为小数点后一位start---------------------- */
	function fomatNumToFloat(num){
		if (num == null || num == undefined || num == "undefined" || num == "null") {
			num = "0";
		} else {
			num = num + "";
		}
		if (num.indexOf(".") == -1) {
			num = num + "." + "0";
		}
		return num;
	}
	/* ----------------------将整数格式化为小数点后一位start---------------------- */
</script>