<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'appMain.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="application list">
	<script type="text/javascript" src="<%=path %>/js/easyui/jquery-1.7.1.min.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    	<c:forEach items="${appListByRoleId}" var="app">
    		应用名称：${app.app_name}
    	</c:forEach>
    	
    	<form action="<%=path%>/showManager/app!changeAppByAspect.dhtml">
    		operatormemo:<input type="text" value="${operatormemo}" name="operatormemo"/>
    		funId:<input type="text" value="" name="funId"/>
    		<input type="submit" value="提交">
    	</form>
    	
  </body>
</html>
