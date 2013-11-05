<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
 	<link rel="stylesheet" href="<%=path%>/css/validationEngine.jquery.css" type="text/css" media="screen" charset="utf-8" />
 	<script src="<%=path %>/js/easyui/jquery-1.7.1.min.js" type="text/javascript"></script> 
 	<script src="<%=path %>/js/easyui/jquery.validationEngine.js" type="text/javascript"></script> 
	<script src="<%=path %>/js/easyui/jquery.validationEngine-zh_CN.js" type="text/javascript"></script> 
	<script type="text/javascript">
		$(document).ready(function() {
			$("#formID").validationEngine({
				promptPosition: "centerRight"
			});
		})
		function clickToSubmit(){
			var result = $("#formID").validationEngine("validate");
			alert(result);
		}
	</script>
  </head>
  
  <body>
     <form  id="formID">
     	<input id="validateName"  class="validate[required,length[0,3]]" type="text" name="user" id="user" />
     	<input type="button" value="提交" onclick="clickToSubmit()"; id="submitButton"/>aaaCCCDDDEEFFFAAAAcCC1AADD
     </form>
  </body>
</html>
