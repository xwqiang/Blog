<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>个信管理</title>
    <meta http-equiv="pragma" content="no-cache"/> 
	<meta http-equiv="cache-control" content="no-cache"/> 
	<meta http-equiv="expires" content="0"/> 
	<link rel="stylesheet" href="<%=path%>/css/validationEngine.jquery.css" type="text/css" media="screen" charset="utf-8" />
	<link type="text/css" rel="stylesheet" href="<%=path %>/css/global.css" />
	<link type="text/css" rel="stylesheet" href="<%=path %>/css/content.css" />
	<link rel="stylesheet" type="text/css" href="<%=path %>/js/subModal/style.css" />
	<link rel="stylesheet" type="text/css" href="<%=path %>/js/subModal/submodal.css" />
	<script type="text/javascript" src="<%=path%>/js/subModal/submodalsource.js"></script>
	<script type="text/javascript" src="<%=path%>/js/easyui/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/easyui/easyloader.js"></script>
	<script type="text/javascript" src="<%=path%>/js/easyui/jquery.easyui.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/default/easyui.css"/>	
	<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/icon.css"/>
	<script src="<%=path %>/js/easyui/jquery.validationEngine.js" type="text/javascript"></script> 
	<script src="<%=path %>/js/easyui/jquery.validationEngine-zh_CN.js" type="text/javascript"></script> 
	<script>
	bool = false;
	remark = "";
	$(document).ready(function() {
		$("#myForm").validationEngine({
			promptPosition: "centerRight"
		});
		
	});
	function _submit(){
		var result = $("#myForm").validationEngine("validate");
		if(!result){
			return ;
		}
		var user_id = $("#user_id").val();
		var user_pwd = $("#user_pwd").val();
		var user_name = $("#user_name").val();
		var mobilephone = $("#mobilephone").val();
		var mail = $("#mail").val();
		var qq = $("#qq").val();
		var changeIt = {"1":_change('用户姓名',$("#user_name").val(),'${user.user_name}'),"1":_change('密码',$("#user_pwd").val(),'${user.user_pwd}'),"1":_change('联系电话',$("#mobilephone").val(),'${user.mobilephone}'),"1":_change('邮箱',$("#mail").val(),'${sessionScope.user.mail }'),"1":_change('QQ',$("#qq").val(),'${user.qq}')}[0]||1;
		if(bool){
			remark = "operatormemo="+"进行了个信管理操作,修改了：${user.user_id } 账号"+remark+"&funId="+"个信管理";
			alert(remark);
			var data = "user.id="+${user.id}+"&user.user_pwd="+user_pwd+"&user.user_name="+user_name+"&user.mobilephone="+mobilephone+"&user.mail="+mail+"&user.qq="+qq+"&user.dept_id="+$("#dept").val()+"&user.role_id="+$("#role").val()+"&user.use_enable="+$("#use_enable").val();
			data = data+'&'+remark;
			$.ajax({
					type:"post",
					url:"showManager/userAction!updateByAspect.dhtml",
					data:data,
					success:function(txt){
						var flag = 0 ;
						if(txt=='success'){
							changeSessionUser();
							$.messager.alert("提示","修改成功!","info");
						}
					}
				});
				
		}else{
			$.messager.alert("提示","未做任何修改！","info");
		}
	}
	//用于控制执行顺序
	function changeSessionUser(){
			$.ajax({
					type:"post",
					url:"<%=path%>/showManager/userAction!personalMod.dhtml?flag=change",
					data:"",
					success:function(txt){
						if(txt=='success'){
							freshImg();
						}else{
							alert("更新失败！");
						}
					}
				});
		
	}
	function freshImg(){
		top.rightFrame.location.reload();
	}
	function _change(title,currentVal,originalVal){
		var isChanged = false;
		if($.trim(originalVal)!=$.trim(currentVal)){
			remark +=title+'由'+originalVal+'变为 '+currentVal;
			isChanged = true;
			bool = true;
		}
		return isChanged;
	}
	function returnRefresh(returnVal){
		//alert(2323);
		//window.top.mainFrame.location="<%=path %>/showManager/userAction!personalMod.dhtml";
	}
	</script>
  </head>
  
  <body>
  <div class="titlePanel"><h2>个信管理</h2>

		<div class="panel-group">
			<div class="panel-group"> <a href="javascript:;" class="button" onclick="javascript:_submit()">保存</a> <a href="showManager/userAction!personalMod.dhtml" class="button">取消</a> <a href="javascript:showPopWin('showManager/personalAction!show.dhtml', 800, 400, returnRefresh(),null);" class="button">更换头像</a></div>
		</div>

	</div>
<div style="height:37px;"></div>
  
    

<div class="AddForm" name="form">
	<form id="myForm">
	<div class="add-item"><label>欢迎您！ ${user.user_name } </label></div>
    <div class="add-item"><label>登录账号</label> <div class="add-item-ipt">${user.user_id }<input id = "user_id" type="hidden" size="30" value="${sessionScope.user.user_id }" disabled="true" /><font color="red"><span id="user_tips"></span></font><br/></div></div>
    <div class="add-item"><label>密码</label><div class="add-item-ipt"><input id = "user_pwd" name = "user_pwd" type="password"  size="30" value="${sessionScope.user.user_pwd }" class="validate[required,minSize[8],maxSize[15]"/><span id="chkResult"></span><font color="red"><span id="pwd_tips"></span></font><br/></div></div>
    
    <div class="add-item"><label>确认密码</label><div class="add-item-ipt"><input id = "user_pwd1" name = "user_pwd1" type="password"  size="30" value="${sessionScope.user.user_pwd }" class="validate[required,minSize[8],maxSize[15],equals[user_pwd]]"/><font color="red"><span id="pwd_tips1"></span></font><br/></div></div><div class="add-item"><label>用户姓名</label><div class="add-item-ipt"><input id ="user_name"  type="text" size="30" value=${user.user_name } class="validate[required,minSize[1],maxSize[30]]"/><font color="red"><span id="name_tips"></span></font></div></div>
    <div class="add-item"><label>部门</label><div class="add-item-ipt">
        <select id="dept" disabled="disabled">
              <c:forEach items="${deptList}" var="dept">
					<option value="${dept.dept_id }">
						${dept.dept_name}
					</option>
				</c:forEach>
        </select></div>
    <div class="add-item"><label>角色</label><div class="add-item-ipt">
        <select id="role" disabled="disabled">
              <c:forEach items="${roleList}" var="role">
					<option value="${role.id }">
						${role.role_name}
					</option>
				</c:forEach>
        </select></div>
    <div class="add-item"><label>联系电话</label><div class="add-item-ipt"><input id = "mobilephone"  type="text" size="30" value="${user.mobilephone }" class="validate[required,custom[phone]]"/><font color="red"><span id="phone_tips"></span></font><br/></div></div>
    <div class="add-item"><label>邮箱</label><div class="add-item-ipt"><input id = "mail"  type="text" size="30" value="${sessionScope.user.mail }" class="validate[required,custom[email]]"/><font color="red" ><span id="mail_tips"></span></font><br/></div></div>
    <div class="add-item"><label>QQ</label><div class="add-item-ipt"><input id ="qq"  type="text" size="30" value="${sessionScope.user.qq }" class="validate[required,custom[number],minSize[1],maxSize[30]]"/><font color="red"><span id="qq_tips"></span></font><br/></div></div>
    <div class="add-item"><label>用户状态</label><div class="add-item-ipt">
        <select name="use_enable" id = "use_enable" disabled="disabled">
              <option value="0">未激活</option>
              <option value="1">激活 </option>
        </select></div>
  </form>
</div>
<input type="hidden" value="${changeUser }" id="changeUser"/>
<input type="hidden" value="${rightPortail }" id="rightPortail"/>
  </body>
  <script>
  $("#use_enable").val(${sessionScope.user.use_enable});
  $("#dept").val(${sessionScope.user.dept_id});
  $("#role").val(${sessionScope.user.role_id});
  if($("#changeUser").val()=='change'){
  	window.top.frames.rightFrame.location.reload(true);
  };
  </script>
</html>
