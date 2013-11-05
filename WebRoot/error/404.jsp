<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP '404.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<style>
body {
	margin: 0;
	padding: 0;
	background: url(<%=path%>/images/error-bg.gif) repeat-x 0 0;
	text-align: center;
	color: #505050;
	font: normal 14px/ 1.7 "宋体";
}

#error {
	position: relative;
	margin: 0 auto;
	width: 450px;
	text-align: left;
	margin-top: 120px;
}

h2 {
	background: url(../images/error.gif) no-repeat left center;
	padding-left: 40px;
	font-size: 22px;
	font-family: "微软雅黑";
	height: 40px;
}

p {
	margin-left: 40px;
}

ul {
	margin: 0;
	padding: 0;
	margin-left: 60px;
}
</style>
	</head>
	<body>
		<div id="error">
			<h2>
				404
			</h2>
			<h2>
				很抱歉，没有找到您要浏览的网页！
			</h2>
			<p>
				经分析，可能的原因是：
			</p>
			<ul>
				<li>
					服务器交互失败
				</li>
				<li>
					服务器故障
				</li>
			</ul>
			<p>
				请与管理员联系!
			</p>
		</div>
	</body>
</html>
