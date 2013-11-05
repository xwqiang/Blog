<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="../css/global.css" />
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<script type="text/javascript" src="<%=path %>/js/easyui/jquery-1.7.1.min.js"></script>
<title>单点登录系统</title>
<script type="text/javascript">
	function jump(appId,app_name){
		window.location.href="<%=path%>/showManager/app!appModulePriorityShow.dhtml?appId="+appId+"&app_name="+app_name;
	}
</script>
</head>

<body>
<div class="titlePanel"><h2>应用权限管理</h2></div>
<div style="height:47px;"></div>
<div class="system-list">
	<c:forEach items="${appListByRoleId}" var="app">
	<div class="system-item" onclick="jump(${app.id },'${app.app_name }')">
		<a class="wrap">
	    	<img src="<%=path%>/app_icons/${app.app_icon_url}" alt="${app.app_name }"  width="58" height="58"/>
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
