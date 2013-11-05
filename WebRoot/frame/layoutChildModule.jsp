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
<!–[if IE 6]> 
          <script type="text/javascript" src="../js/DD_belatedPNG_0.0.8a-min.js"></script> 
          <script> 
            DD_belatedPNG.fix('.system-item span, background');  
          </script> 
<![endif]–>
<title>单点登录系统</title>
</head>

<body>

	<div class="system-list">
    <c:forEach items="${modules}" var="m">
    	<div class="system-item">
    	<a name="module" id="${m.id }" href="<%=path %>${m.module_url }" target="mainFrame" class="wrap">
    	<h3>${m.module_name }</h3>
        </a>
          </div>
    </c:forEach>   
    <div class="clear"></div>
	</div>

</body>
</html>
