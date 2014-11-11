<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>查看卡信息</title>
		<jsp:include page="./operCardUtil.jsp"></jsp:include>
		<jsp:include page="../inc.jsp"></jsp:include>
		<script type="text/javascript">
			$(function() {
				/* ---------------读卡start--------------- */
				$("#readCard").click(function(){
					//参数为open时，会判断卡序列号是否被使用
					var cardInfo = queryCardInfo();
					$("#cardid").val(cardInfo.cardid);
					$("#cardpwd").val(cardInfo.cardpwd);
					$("#employeenumber").val(cardInfo.employeenumber);
					$("#employeename").val(cardInfo.employeename);
				});
				/* ---------------读卡end--------------- */
			});
			
			function queryCardInfo(){
				try {
					if (openSerial()) {//打开串口号
						if (hasCard()) {//是否有卡
							//蜂鸣
							beep();
							
							//卡信息
							var cardid = getCardId();//卡序列号
							var usercode = "";//用户代码(2扇区第0块前8位数据)
							var cardno = "";//卡号(2扇区第0块第二个8位数据)
							var employeenumber = "";//员工号(2扇区第1块数据)
							var cardpwd = "";//密码(2扇区第2块前6位数据)
							var employeename = "";//员工姓名(3扇区第2块数据)
							
							//加载卡密钥
							loadCardPwd();
							
							var str = readCard(8);
							if (str != null && str != "") {
								cardno = str.substring(8, 16);
							}
							
							str = readCard(9);
							if (str != null && str != "") {
								employeenumber = str;
							}
							
							str = readCard(10);
							if (str != null && str != "") {
								cardpwd = str.substring(0, 6);
							}
							
							str = readCard(14);
							if (str != null && str != "") {
								var len = str.indexOf("0");
								if (len < 0) {
									employeename = str;
								} else {
									employeename = str.substring(0, len);
								}
							}
							
							var cardinfo = {
								"cardid" : cardid,
								"cardno" : cardno,
								"employeenumber" : employeenumber,
								"employeename" : employeename,
								"cardpwd" : cardpwd
							};
							
							return cardinfo;
							
						} else {
							parent.$.messager.alert('','没有卡片!','error');
							return ;
						}
					} else {
						parent.$.messager.alert('','请设置串口!','error');
					}
		    	} catch(e) {
		    		parent.$.messager.alert('','页面异常，请重新打开该页面!','error');
		    	} finally {
		    		closeSerial();//关闭串口
		    	}
			};
		</script>
	</head>
	<body>
		<fieldset>
			<legend>卡片信息</legend>
			<table class="table" style="width: 100%;">
				<tr>
					<th>卡序列号</th>
					<td>
						<input id="cardid" name="" class="easyui-validatebox" readonly="readonly"/>
						<img class="iconImg ext-icon-vcard" id="readCard" title="读卡"/>
					</td>
					<th>卡密码</th>
					<td>
						<input id="cardpwd" name="" class="easyui-validatebox" readonly="readonly"/>
					</td>
				</tr>
				<tr>
					<th>员工号</th>
					<td>
						<input id="employeenumber" name="" class="easyui-validatebox" readonly="readonly"/>
					</td>
					<th>员工姓名</th>
					<td>
						<input id="employeename" name="" class="easyui-validatebox" readonly="readonly"/>
					</td>
				</tr>
			</table>
		</fieldset>
	</body>
</html>