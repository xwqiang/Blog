<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'appMain.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="application list">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<link type="text/css" rel="stylesheet"
			href="<%=path%>/css/global.css" />
		<link type="text/css" rel="stylesheet"
			href="<%=path%>/css/content.css" />
		
		<script type="text/javascript" src="<%=path%>/js/easyui/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=path%>/js/easyui/easyloader.js"></script>
		<script type="text/javascript" src="<%=path%>/js/easyui/jquery.easyui.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/default/easyui.css"/>	
		<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/icon.css"/>
		<link rel="stylesheet" href="<%=path%>/css/validationEngine.jquery.css" type="text/css" media="screen" charset="utf-8" />
		<script src="<%=path %>/js/easyui/jquery.validationEngine.js" type="text/javascript"></script> 
		<script src="<%=path %>/js/easyui/jquery.validationEngine-zh_CN.js" type="text/javascript"></script> 
	<script>
		$(function(){
			using(["window","messager"]);
		}); 
		$(document).ready(function() {
			$("#addForm").validationEngine({
				promptPosition: "centerRight"
			});
			
		});
		function checkUserId(userid){
			var user_id = $("#user_id").val();
			$.get("showManager/userAction!checkUserName.dhtml", {user_id: user_id},
			  function(data){
			    if(data=="success"){
			    	_submit();
			    }else{
			    	$.messager.alert("提示","登录账号已经被使用","info");
			    }
			  });
		}
	function _submit(){
		var result = $("#addForm").validationEngine("validate");
		if(!result){
			return ;
		}
		var user_id = $("#user_id").val();
		var user_pwd = $("#user_pwd").val();
		var user_pwd1 = $("#user_pwd1").val();
		var user_name = $("#user_name").val();
		var mobilephone = $("#mobilephone").val();
		var mail = $("#mail").val();
		var qq = $("#qq").val();
		var remark =  "operatormemo="+encodeURIComponent("新建了员工，员工信息为,账号：")+$("#user_id").val()+encodeURIComponent("密码：")+$("#user_pwd").val()+encodeURIComponent("姓名：")+$("#user_name").val()+encodeURIComponent("部门：")+$("#user_id").text()+encodeURIComponent("角色：")+$("#role  option:selected").text()+encodeURIComponent("联系电话：")+$("#mobilephone").val()+encodeURIComponent("邮箱：")+$("#mail").val()+encodeURIComponent("QQ：")+$("#qq").val()+encodeURIComponent("用户状态：")+$("#use_enable option:selected").text()+"&funId="+encodeURIComponent("人员管理");
		var data = "user.user_id="+user_id+"&user.user_pwd="+user_pwd+"&user.user_name="+user_name+"&user.mobilephone="+mobilephone+"&user.mail="+mail+"&user.qq="+qq+"&user.dept_id="+$("#dept").val()+"&user.role_id="+$("#role").val()+"&user.use_enable="+$("#use_enable").val();
		data = data+"&"+remark;
		$.ajax({
				type:"post",
				url:"showManager/userAction!insertByAspect.dhtml",
				data:data,
				success:function(txt){
					//alert(txt);
					if(txt=='success'){
						$.messager.alert("提示","插入成功","info",function(){
							window.location.href="<%=path%>/showManager/userAction!show.dhtml";
						});
					}else if(txt=='usedId'){
						$.messager.alert("提示","该账号已经被使用","info",function(){
							$("#user_id").focus();
						});
					}else{
							$.messager.alert("提示","插入失败","info",function(){
						});
					}
				}
			});
	}
	</script>
	</head>

	<body>
	
	<div class="titlePanel"><h2>用户管理&nbsp;&gt;&nbsp;新建用户</h2>
			<div class="panel-group">
				<a href="javascript:;" class="button" id="save"
					onclick="javascript:checkUserId()">保存</a>
				<a href="showManager/userAction!show.dhtml" class="button">取消</a>
			</div>
	</div>
	<div style="height:67px;"></div>
			
		

		<div class="AddForm">
			<form id="addForm">
				<div class="add-item">
					<label>
						登录账号
					</label>
					<div class="add-item-ipt">
						<input id="user_id" type="text" size="30"  class="validate[required,minSize[3],maxSize[15]]" />
						<font color="red"><span id="user_tips"></span>
						</font>
						<br />
					</div>
				</div>
				<div class="add-item">
					<label>
						密码
					</label>
					<div class="add-item-ipt">
						<input id="user_pwd" type="password" size="30" class="validate[required,minSize[8],maxSize[15]" oncopy="return false"
							oncut="return false" onpaste="return false" /><span id="chkResult"></span>
						<font color="red"><span id="pwd_tips"></span>
						</font>
						<br />
					</div>
				</div>
				<div class="add-item">
					<label>
						确认密码
					</label>
					<div class="add-item-ipt">
						<input id="user_pwd1" type="password"
							equalTo(user_pwd) size="30" oncopy="return false"
							oncut="return false" onpaste="return false"  class="validate[required,maxSize[15],equals[user_pwd]]"/>
						<font color="red"><span id="pwd_tips1"></span>
						</font>
						<br />
					</div>
				</div>
				<div class="add-item">
					<label>
						用户姓名
					</label>
					<div class="add-item-ipt">
						<input id="user_name" type="text" size="30" class="validate[required,minSize[1],maxSize[30]]"/>
						<font color="red"><span id="name_tips"></span>
						</font>
					</div>
				</div>
				<div class="add-item">
					<label>
						部门
					</label>
					<div class="add-item-ipt">
						<select id="dept">
							<c:forEach items="${deptList}" var="dept">
								<option value="${dept.dept_id }">
									${dept.dept_name}
								</option>
							</c:forEach>
						</select>
					</div>
					<div class="add-item">
						<label>
							角色
						</label>
						<div class="add-item-ipt">
							<select id="role">
								<c:forEach items="${roleList}" var="role">
									<option value="${role.id }">
										${role.role_name}
									</option>
								</c:forEach>
							</select>
						</div>
						<div class="add-item">
							<label>
								联系电话
							</label>
							<div class="add-item-ipt">
								<input id="mobilephone" type="text" size="30" class="validate[required,custom[phone]]" />
								<font color="red"><span id="phone_tips"></span>
								</font>
								<br />
							</div>
						</div>
						<div class="add-item">
							<label>
								邮箱
							</label>
							<div class="add-item-ipt">
								<input id="mail" type="text" size="30"  class="validate[required,custom[email]]"/>
								<font color="red"><span id="mail_tips"></span>
								</font>
								<br />
							</div>
						</div>
						<div class="add-item">
							<label>
								QQ
							</label>
							<div class="add-item-ipt">
								<input id="qq" type="text" size="30" class="validate[required,custom[number],minSize[1],maxSize[30]]"/>
								<font color="red"><span id="qq_tips"></span>
								</font>
								<br />
							</div>
						</div>
						<div class="add-item">
							<label>
								用户状态
							</label>
							<div class="add-item-ipt">
								<select name="use_enable" id="use_enable">
									<option value="0">
										未激活
									</option>
									<option value="1">
										激活
									</option>
								</select>
							</div>
						</div>
					
			</form>
		</div>

	</body>
</html>
