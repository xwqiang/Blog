<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
<frameset cols="*,201" frameborder="0" border="0" framespacing="0" noresize="noresize" name="sso" id = "sso">

	<frameset rows="131,*" frameborder="0" border="0" framespacing="0" id="frameParent" name="frameParent">
	<frame src="<%=path %>/frame/head.jsp" frameborder="0" border="0" framespacing="0" name="topFrame" id="topFrame"/>
	<frame src="<%=path %>/frame/layout.jsp" name="mainFrame" id="mainFrame" frameborder="0" border="0" framespacing="0" name="mainFrame" id ="mainFrame" />	
	</frameset>
	
	<frame src="<%=path %>/frame/side.jsp" frameborder="0" border="0" framespacing="0" name="rightFrame" id = "rightFrame" style="border-left:1px solid #B9B4B4;"/>

<noframes>
<body>
您的浏览器无法处理框架！
</body>
</noframes>

</frameset>
</html>
