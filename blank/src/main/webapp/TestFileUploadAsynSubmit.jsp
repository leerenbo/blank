<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>测试</title>
<script type="text/javascript">
$(function () {
	$('#ff').form({
		url : ez.contextPath + '/test!noSySn_upload.action',
	    onSubmit: function(){
	        // do some check
	        // return false to prevent submit;
	        return true;
	    },
	    success:function(data){
	    	console.info(data);
	    }
	});
})
function aa(){
	$('#ff').submit();
}
</script>
</head>
<body>
<form id="ff"  method="post" enctype="multipart/form-data">
<input type="file" name="image" />
<input type="button" value="button" onclick="aa();">
</form>

<form id="dd" action="test!noSySn_upload.action"  method="post" enctype="multipart/form-data">
<input type="file" name="image" />
<input type="submit" value="submit">
</form>
</body>
</html>