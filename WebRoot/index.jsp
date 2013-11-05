<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="<%=path %>/js/easyui/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyui/jquery.easyui.min.js"></script>
<script src="<%=path %>/js/easyui/jquery.validationEngine.js" type="text/javascript"></script> 
<script src="<%=path %>/js/easyui/jquery.validationEngine-zh_CN.js" type="text/javascript"></script> 
<link rel="stylesheet" href="<%=path%>/css/validationEngine.jquery.css" type="text/css" media="screen" charset="utf-8" />
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/default/easyui.css"/>
<link rel="shortcut icon" type="image/ico" href="images/favicon.ico"/>
<link type="text/css" rel="stylesheet" href="css/global.css" />
<link type="text/css" rel="stylesheet" href="css/login.css" />

<title>Blog</title>

</head>

<body>
<form action="loginAction!login.dhtml"> 
=username:<input type="text" name="user.uname"/><br/>
passwd:<input type="password" name="user.upwd"/>
<input type="submit" value="submit"/> 
<a href="<%=path %>/roleAction!show.dhtml" >角色管理</a>
</form>
</body>
</html>
