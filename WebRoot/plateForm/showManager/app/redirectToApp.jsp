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
    
    <title>My JSP 'redirectToApp.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=path%>/js/easyui/jquery-1.7.1.min.js"></script>
  </head>
  
  <body>
  
  				<font size="2" color="green"><b>正在打开请稍候。。。</b></font>  
  
  
  
  
  	<form id="form1" action="${intercativeModel.interactiveUrl}" method="post">
	  	<input id="userId" name="userId" type="hidden" value="${intercativeModel.userId}"/>
	  	<input id="roleId" name="roleId" type="hidden" value="${intercativeModel.roleId}"/>
	  	<input id="interactiveData" name="interactiveData" type="hidden" value="${intercativeModel.interactiveData}"/>
	  	<input id="sso_time" name="sso_time" type="hidden" value="${intercativeModel.sso_time}"/>
  	</form>
  </body>
   <script type="text/javascript">
   		document.forms.form1.submit();
   </script>
</html>
