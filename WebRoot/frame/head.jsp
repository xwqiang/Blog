<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script type="text/javascript" src="<%=path%>/js/easyui/jquery-1.7.1.min.js"></script>
<!–[if IE 6]> 
          <script type="text/javascript" src="../js/DD_belatedPNG_0.0.8a-min.js"></script> 
          <script> 
            DD_belatedPNG.fix('.system-item span, background');  
          </script> 
<![endif]–>
<title>单点登录系统</title>
<script type="text/javascript">
	$(document).ready(function(){
		document.onkeydown=function() { 
			if (event.keyCode==13) { 
				_search(); 
			} 
		}
	});
	function change(id){
		var obj = document.getElementsByName("module");
		for(i=0;i<obj.length;i++){
			obj[i].className="";
		}
		document.getElementById(id).className="circle-active";	
		
	}
	function _search(){
	var data = "appModel.app_name="+$("#condition").val();
	if($("#condition").val() == $.trim('应用名称')){
		data="appModel.app_name=";
		//alert(data);
	}
	window.parent.frames.mainFrame.location.href="<%=path %>/showManager/app!search.dhtml?"+data;
	}
</script>
</head>

<body style="overflow:hidden;">
<div class="operate-panel">
	<div class="operate-left operate-circle ">
		<c:forEach items="${modules}" var="m">
			<a onmousedown="change(${m.id })"  name="module" id="${m.id }" href="<%=path %>${m.module_url }" target="mainFrame">${m.module_name }</a>
		</c:forEach>
	</div>
   <div class="search">
    	<div class="search-cont"><form action=""><input type="text" id="condition" class="ipt-txt" value="应用名称" onfocus="if(value=='应用名称') {value=''}" onblur="if (value=='') {value='应用名称'}"/>
    	<input name="" type="button" class="ipt-btn" onclick="_search()"/></form></div>
    </div>
    <div class="clear"></div>
</div>
</body>
</html>
