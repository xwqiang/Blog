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
    
    <title>My JSP 'appMain.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="application list">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link type="text/css" rel="stylesheet" href="<%=path %>/css/global.css" />
	<link type="text/css" rel="stylesheet" href="<%=path %>/css/content.css" />
	<script type="text/javascript" src="<%=path%>/js/easyui/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/easyui/easyloader.js"></script>
	<script type="text/javascript" src="<%=path%>/js/easyui/jquery.easyui.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/default/easyui.css"/>	
	<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/icon.css"/>
	<link rel="stylesheet" href="<%=path%>/css/validationEngine.jquery.css" type="text/css" media="screen" charset="utf-8" />
	<script src="<%=path %>/js/easyui/jquery.validationEngine.js" type="text/javascript"></script> 
	<script src="<%=path %>/js/easyui/jquery.validationEngine-zh_CN.js" type="text/javascript"></script> 
	<script>
	bool = false;
	$(document).ready(function() {
		$("#modForm").validationEngine({
			promptPosition: "centerRight"
		});
		
	});
	function chkpwd(obj){
		  var t=obj.value;
		  var id=getResult(t);
		   
		  //定义对应的消息提示
		  var msg=new Array(4);
		  msg[0]="密码过短。";
		  msg[1]="密码强度差。";
		  msg[2]="密码强度良好。";
		  msg[3]="密码强度高。";
		   
		  var sty=new Array(4);
		  sty[0]=-45;
		  sty[1]=-30;
		  sty[2]=-15;
		  sty[3]=0;
		   
		  var col=new Array(4);
		  col[0]="gray";
		  col[1]="red";
		  col[2]="#ff6600";
		  col[3]="Green";
		   
		  //设置显示效果
		  var sWidth=300;
		  var sHeight=15;
		  var Bobj=document.getElementById("chkResult");
		 
		  Bobj.style.fontSize="12px";
		  Bobj.style.color=col[id];
		  Bobj.style.width=sWidth + "px";
		  Bobj.style.height=sHeight + "px";
		  Bobj.style.lineHeight=sHeight + "px";
		  Bobj.style.textIndent="20px";
		  Bobj.innerHTML="检测提示：" + msg[id];
	 }
	 function getResult(s){
		  if(s.length < 4){
		   return 0;
		  }
		  var ls = 0;
		  if (s.match(/[a-z]/ig)){
		   ls++;
		  }
		  if (s.match(/[0-9]/ig)){
		   ls++;
		  }
		   if (s.match(/(.[^a-z0-9])/ig)){
		   ls++;
		  }
		  if (s.length < 6 && ls > 0){
		   ls--;
		  }
		  return ls
	 }
	var remark = "";
	function _submit(){
		var result = $("#modForm").validationEngine("validate");
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
		var changeIt = {"1":_change('用户姓名',$("#user_name").val(),'${user.user_name}'),"1":_change('密码',$("#user_pwd").val(),'${user.user_pwd}'),"1":_change('部门',$("#dept option:selected").text(),'${user.dept_name}'),"1":_change('角色',$("#role option:selected").text(),'${user.role_name}'),"1":_change('联系电话',$("#mobilephone").val(),'${user.mobilephone}'),"1":_change('邮箱',$("#mail").val(),'${user.mail}'),"1":_change('QQ',$("#qq").val(),'${user.qq}'),"1":_change('用户状态',$("#use_enable").val(),'${user.use_enable}')}[1]||1;
		//var changeIt= _change('用户姓名',$("#user_name").val(),'${user.user_name}')&&_change('密码',$("#user_pwd").val(),'${user.user_pwd}')&&_change('部门',$("#dept option:selected").text(),'${user.dept_name}')&&_change('角色',$("#role option:selected").text(),'${user.role_name}')&&_change('联系电话',$("#mobilephone").val(),'${user.mobilephone}')&&_change('邮箱',$("#mail").val(),'${user.mail}')&&_change('QQ',$("#qq").val(),'${user.qq}')&&_change('用户状态',$("#use_enable").val(),'${user.use_enable}');
		
		if(bool){
			remark = "operatormemo="+"进行了人员修改操作,修改了：${user.user_id } 账号"+remark+"&funId="+"人员管理";
			var data = "user.id="+${user.id}+"&user.user_pwd="+user_pwd+"&user.user_name="+user_name+"&user.mobilephone="+mobilephone+"&user.mail="+mail+"&user.qq="+qq+"&user.dept_id="+$("#dept").val()+"&user.role_id="+$("#role").val()+"&user.use_enable="+$("#use_enable").val();
			data = data+'&'+remark;
			$.ajax({
					type:"post",
					url:"showManager/userAction!updateByAspect.dhtml",
					data:data,
					success:function(txt){
						if(txt=='success'){
							$.messager.alert("提示","修改成功","info",function(){
								window.location.href="<%=path%>/showManager/userAction!show.dhtml";
							});
						}else{
							$.messager.alert("提示","修改失败","info");
						}
					}
				});
		}else{
				$.messager.alert("提示","并为做任何修改","info",function(){
				window.location.href="<%=path%>/showManager/userAction!show.dhtml";
			});
		}
	}
	function _change(title,currentVal,originalVal){
		var isChanged = false;
		if($.trim(originalVal)!=$.trim(currentVal)){
			remark +='  '+title+'由'+originalVal+'变为 '+currentVal;
			isChanged = true;
			bool = true;
		}
		return isChanged;
	}
	</script>
  </head>
  
  <body>
  
  <div class="titlePanel"><h2>用户管理&nbsp;&gt;&nbsp;修改用户信息</h2>
  	<div class="panel-group"><a href="javascript:;" class="button" onclick="javascript:_submit()">保存</a> <a href="showManager/userAction!show.dhtml" class="button">取消</a></div>
    <div class="clear"></div>
  </div>

  <div style="height:67px;"></div>

<div class="AddForm">
	<form id="modForm">
    <div class="add-item"><label>登录账号</label><div class="add-item-ipt">${user.user_id }<input id = "user_id" type="hidden" size="30" value="${user.user_id }" disabled="true" /><font color="red"><span id="user_tips"></span></font><br/></div></div>
    <div class="add-item"><label>密码</label><div class="add-item-ipt"><input id = "user_pwd" type="password" size="30" value="${user.user_pwd }" oncopy="return false" oncut="return false" onpaste="return false"  class="validate[required,minSize[8],maxSize[15]" onblur="chkpwd(this);"/><span id="chkResult"></span><font color="red"><span id="pwd_tips"></span></font><br/></div></div>
    <div class="add-item"><label>确认密码</label><div class="add-item-ipt"><input id = "user_pwd1" type="password" size="30" value="${user.user_pwd }" oncopy="return false" oncut="return false" onpaste="return false"  class="validate[required,minSize[8],maxSize[15],equals[user_pwd]]"/><font color="red"><span id="pwd_tips1"></span></font><br/></div></div>
    <div class="add-item"><label>用户姓名</label><div class="add-item-ipt"><input id ="user_name" type="text" size="30" value="${user.user_name }" class="validate[required,minSize[1],maxSize[30]]"/><font color="red"><span id="name_tips"></span></font></div></div>
    <div class="add-item"><label>部门</label><div class="add-item-ipt">
        <select id="dept">
              <c:forEach items="${deptList}" var="dept">
					<option value="${dept.dept_id }">
						${dept.dept_name}
					</option>
				</c:forEach>
        </select></div>
    <div class="add-item"><label>角色</label><div class="add-item-ipt">
        <select id="role">
              <c:forEach items="${roleList}" var="role">
					<option value="${role.id }">
						${role.role_name}
					</option>
				</c:forEach>
        </select></div>
    <div class="add-item"><label>联系电话</label><div class="add-item-ipt"><input id = "mobilephone" type="text" size="30" value="${user.mobilephone }" class="validate[required,custom[phone]]" /><font color="red"><span id="phone_tips"></span></font><br/></div></div>
    <div class="add-item"><label>邮箱</label><div class="add-item-ipt"><input id = "mail" type="text" size="30" value="${user.mail }"  class="validate[required,custom[email]]"/><font color="red"><span id="mail_tips"></span></font><br/></div></div>
    <div class="add-item"><label>QQ</label><div class="add-item-ipt"><input id ="qq" type="text" size="30" value="${user.qq }"  class="validate[required,custom[number],minSize[1],maxSize[30]]"/><font color="red"><span id="qq_tips"></span></font><br/></div></div>
    <div class="add-item"><label>用户状态</label><div class="add-item-ipt">
        <select name="use_enable" id = "use_enable">
              <option value="0">未激活</option>
              <option value="1">激活</option>
        </select>
    </div>
    </div>
  </form>
</div>

  </body>
  <script>
  $("#use_enable").val(${user.use_enable});
  $("#dept").val(${user.dept_id});
  $("#role").val(${user.role_id});
  </script>
</html>
