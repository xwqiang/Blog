<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="../css/global.css" />
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<script type="text/javascript" src="<%=path %>/js/easyui/jquery-1.7.1.min.js"></script>
<title>单点登录系统</title>
<script type="text/javascript">
	function gotoApp(appId){
		var data = "appId="+appId;
		var url = "<%=path%>/app/goto!validateApp.dhtml?"+data;
		window.open(url);
	}
</script>
</head>

<body>

<div class="system-list">
	<c:forEach items="${appListByRoleId}" var="app">
	<div class="system-item" onclick="gotoApp(${app.id });">
		<a class="wrap">
	    	<img src="<%=path%>/app_icons/${app.app_icon_url}" alt="${app.app_name }" width="58" height="58"/>
	    		<p>${app.app_name }</p>
	        <div class="clear"></div>
        </a>
         <span><a href="javascript:;"></a></span>
    </div>
       </c:forEach>
    <div class="clear"></div>
</div>
</body>
</html>
