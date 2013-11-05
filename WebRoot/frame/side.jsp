<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="../css/global.css" />
<title>右侧个人信息_单点登录系统</title>
<style>
html,body{background:#F9F9F9;}
</style>
<script type="text/javascript">
	function logOut(){
		if (confirm("您确定要退出单点登录系统吗？"))
		top.location = "<%=path %>/adminLogin/login!logOut.dhtml";
		return false;
	}
</script>

</head>

<body>
<div id="side_box">
    <div class="side_box">
    <div class="user_info">
            <div class="user_head"><a href="<%=path %>/showManager/userAction!personalMod.dhtml" title="点击修改头像" target="mainFrame"><img src="<%=path %>/${user.headportraint_url}" alt="" /></a></div>
            <div class="user_name"><p><a href="javascript:;" target="mainFrame">${user.user_name }</a></p></div>
            <div class="clear"></div>
      <div class="user_opt"><a href="<%=path %>/showManager/userAction!personalMod.dhtml" target="mainFrame">个人信息</a>&nbsp;&nbsp;&brvbar;&nbsp;&nbsp;
                <a href="javascript:logOut();">退出</a>
  </div>
        </div>
        <div id="user_nav">
        <ul>
        	<li><a href="javascript:parent.window.location.reload();" target="mainFrame">系统首页</a></li>
        </ul></div>
    </div>
</div>
</body>
</html>
