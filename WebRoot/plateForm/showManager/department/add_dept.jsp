<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'appMain.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="application list">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link type="text/css" rel="stylesheet" href="<%=path %>/css/global.css" />
	<link type="text/css" rel="stylesheet" href="<%=path %>/css/content.css" />
	<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/default/easyui.css"/>	
	<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/icon.css"/>
	<script type="text/javascript" src="<%=path%>/js/easyui/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/easyui/easyloader.js"></script>
	<script type="text/javascript" src="<%=path%>/js/easyui/jquery.easyui.min.js"></script>
	<script>
	function _submit(){
			var aaa = "operatormemo="+encodeURIComponent("进行了新建部门操作，新建部门名称为：")+$("#dept_name").val()+"&funId="+encodeURIComponent("部门管理");
			var data = "dept.dept_name="+$("#dept_name").val();
			data =data+"&"+aaa;
			$.ajax({
					type:"post",
					url:"showManager/deptAction!insertByAspect.dhtml",
					data:data,
					success:function(txt){
						if(txt=='success'){
							//alert("插入成功");
							$.messager.alert("提示","插入成功！","info",function(){
								window.location.href="<%=path%>/showManager/deptAction!showDept.dhtml";
							});
						}else{
							$.messager.alert("提示","插入失败！","info");
						}
					}
				});
	}
	</script>
  </head>
  
  <body>
 <div class="titlePanel"><h2>部门管理&nbsp;&gt;&nbsp;新建部门</h2>
	<div class="panel-group"><a href="javascript:;" class="button" onclick="javascript:_submit()">保存</a> <a href="<%=path%>/showManager/deptAction!showDept.dhtml" class="button">取消</a></div>
 </div>
<div style="height:67px;"></div>
  
  
 
    


<div class="AddForm">
	<form>
   	 <div class="add-item"><label>部门名称</label><div class="add-item-ipt"><input id = "dept_name" type="text" size="30" /><br/></div></div>
 	 </form>
</div>

  </body>
</html>
