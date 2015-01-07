<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	if (id == null) {
		id = "";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<jsp:include page="../../inc.jsp"></jsp:include>
<script type="text/javascript">
	var submitForm = function($dialog, $grid, $pjq) {
		if ($('form').form('validate')) {
			var url;
			if ($(':input[name="data.id"]').val().length > 0) {
				url = ez.contextPath + '/sysExcelUpload!update.action';
			} else {
				url = ez.contextPath + '/sysExcelUpload!save.action';
			}
			$('#ezAddAndUpdataform').form('submit', {
				url : url,
				onSubmit : function() {
					// do some check
					// return false to prevent submit;
					return true;
				},
				success : function(result) {
					result = $.parseJSON(result);
					$pjq.messager.alert('提示', result.msg, 'info');
					$grid.datagrid('load');
					$dialog.dialog('destroy');
				}
			});
		}
	};
	$(function() {
		if ($(':input[name="data.id"]').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});

			$.post(ez.contextPath + '/sysExcelUpload!getById.action', {
				'data.id' : $(':input[name="data.id"]').val()
			}, function(result) {
				if (result.id != undefined) {
					var data = ez.formLoadConvert(result);
					if (result.id != undefined) {
						$('#ezAddAndUpdataform').form('load', data);
					}
				}
				parent.$.messager.progress('close');
			}, 'json');
		}
	});
</script>
</head>
<body>
	<form id="ezAddAndUpdataform" method="post" enctype="multipart/form-data" class="form">
		<fieldset>
			<legend>excel批量导入信息管理信息</legend>
			<table class="table" style="width: 100%;">
			
				<tr>
				<input name="data.id" type="hidden" value="<%=id%>" />
				<th>上传时间</th>
				<td>
					<input name="data.uploadTime" class="easyui-datetimebox" data-options="editable:false,missingMessage:'该输入项为必输项'"/>
				</td>
				<th>下载</th>
				<td>
					<input name="data.errorDocPath" class="easyui-textbox" data-options="missingMessage:'该输入项为必输项'"/>
				</td>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>