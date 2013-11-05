<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>SSO单点登陆系统密码找回</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript"
			src="<%=path%>/js/easyui/jquery-1.7.1.min.js"></script>
		<script type="text/javascript"
			src="<%=path%>/js/easyui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=path%>/js/easyui/easyloader.js"></script>
		<script src="<%=path%>/js/easyui/jquery.validationEngine.js"
			type="text/javascript"></script>
		<script src="<%=path%>/js/easyui/jquery.validationEngine-zh_CN.js"
			type="text/javascript"></script>
		<link rel="stylesheet"
			href="<%=path%>/css/validationEngine.jquery.css" type="text/css"
			media="screen" charset="utf-8" />
		<link rel="stylesheet" type="text/css"
			href="<%=path%>/js/easyui/themes/default/easyui.css" />
		<link type="text/css" rel="stylesheet" href="css/global.css" />
<style>
html,body {
	text-align: center;
}

#container {
	background: #4F99BE url(images/login/login-bg-01.gif) no-repeat 50% top;
	height: 100px;
	text-align: left;
	border-bottom: 1px solid #1C71A2;
}

#container h1 {
	margin: 0 auto;
	width: 400px;
	padding-top: 10px;
	font: bold 34px/ 2.0 "黑体";
	color: #FFF;
}

#pad_content {
	width: 700px;
	margin: 0 auto;
	border: 1px solid #1C71A2;
	border-top: none;
	padding: 10px;
	text-align: left;
	color: #333;
	font-size: 14px;
	font-family: "宋体";
}

.fd_item {
	margin: 10px 0 10px 100px;
	line-height: 200%;
	clear: left; *
	zoom: 1;
}

.fd_item:after {
	visibility: hidden;
	display: block;
	font-size: 0;
	content: " ";
	clear: both;
	height: 0;
}

.fd_left {
	float: left;
	text-align: right;
	padding-right: 10px;
	width: 130px;
}

.fd_right {
	float: left;
}

.fd_right input {
	width: 200px;
	height: 19px;
	border: 1px solid #C4C4C4;
	padding: 3px 0 0 3px;
	background: #F9F9F9;
}

.fd_right .ipt-code {
	width: 120px;
	float: left;
}

.fd_right .code-pic {
	float: left;
	padding-left: 15px;
}

.fd_btn {
	clear: both;
	margin-left: 240px;
}

.fd_btn input {
	background: url(images/button-bg.gif) no-repeat left top;
	width: 65px;
	height: 30px;
	cursor: pointer;
	font-size: 12px;
}
</style>
		<script type="text/javascript">
		$("#changePwdForm").validationEngine({
				promptPosition: "topRight"
			});	
			var id;//定时器
			var myTime=0;
	$(function(){
			using(["window","messager"]);
		}); 
	function changeValidateCode(obj) {      
		var timenow = new Date().getTime();      
		obj.src="<%=path%>/login/random!execute.dhtml?randomCodeName=findPwdRandomCode&d="+timenow;     
	} 
	function submitChangeOpration(){
			var imageArray=document.getElementById("validateImg").getElementsByTagName("img");
			var obj = imageArray[0];
			var result = $("#changePwdForm").validationEngine("validate");
			if(!result){
				return ;
			}
		var data = $("#changePwdForm").serialize();
		$.ajax({
			type:"post",
			url:"<%=path%>/adminLogin/login!getPassWord.dhtml",
			data:data,
			success:function(html){
				if(html=='success'){
					$.messager.alert("提示","修改成功!","info",function(){
						window.location.href="<%=path%>/adminLogin/login!logOut.dhtml";
					});
				}else if(html=='vaildateNumFailed'){
					$.messager.alert("提示","验证码错误!","info",function(){
						changeValidateCode(obj);
					});
				}else if(html=='userNotExist'){
					$.messager.alert("提示","用户不存在!","info",function(){
						changeValidateCode(obj);
					});
				}else if(html=='phoneIsNull'){
					$.messager.alert("提示","该用户手机号未填写，不能获取新密码!","info",function(){
						changeValidateCode(obj);
					});
				}else{//返回剩余时间
					myTime = html;
					changeLeaveTime();
					
				}
			}
		});
	}
	function returnToMain(){
		window.location.href="<%=path%>/adminLogin/login!logOut.dhtml";
	}
	
	function changeLeaveTime(){
		changeLeaveContext();
		id = window.setInterval(changeLeaveContext,1000);
	}
	function changeLeaveContext(){
		if(myTime>0){
			var minute = Math.floor(myTime/60);
			var second = myTime%60;
			document.getElementById("leaveTime").innerHTML="<font color='red'><b>重新获取密码时间：剩余"+minute+"分"+second+"秒"+"</b></font>";
			myTime--;
		}else{
			window.clearInterval(id);
			document.getElementById("leaveTime").innerHTML="";
		}
	}
</script>
	</head>

	<body>
		<div id="container">
			<h1>
				找回密码
			</h1>
		</div>
		<form id="changePwdForm">
		<div id="pad_content">
					<div style="text-align:center" id="leaveTime"></div>
			<div class="fd_item">
			<div class="fd_left">用&nbsp;户&nbsp;名：</div>
			<div class="fd_right"><input type="text" id="user_id" name="changeUser.user_id" class="validate[required],minSize[1],maxSize[20]" /></div>
			</div>
			<div class="fd_item">
				<div class="fd_left">验证码：</div>
				<div class="fd_right"><input type="text" name="verification" id="verification" class="ipt-code validate[required]" />
					<div class="code-pic" id="validateImg">
				<img style="width:70px;heitht:25px"  src="<%=path%>/login/random!execute.dhtml?randomCodeName=findPwdRandomCode" onclick="changeValidateCode(this);" title="点击图片刷新验证码" / alt="" /></div>
				</div>
				 
			</div>
			<div class="fd_item fd_btn">
				<input type="button" value="提交" onclick="submitChangeOpration();" />
				<input type="button" value="返回" onclick="returnToMain();"/>
			</div>
			<center><font color="red"><b>提交完成会将新生成的密码发到您的手机上，请注意查收！</b></font></center>
		</div>
		</form>
	</body>
</html>
