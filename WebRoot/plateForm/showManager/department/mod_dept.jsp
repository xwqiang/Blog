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
	<script type="text/javascript" src="<%=path%>/js/easyui/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/easyui/easyloader.js"></script>
	<script type="text/javascript" src="<%=path%>/js/easyui/jquery.easyui.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/default/easyui.css"/>	
	<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/icon.css"/>
	<script>
	function _submit(){
		var bool = false;
		var dept_name = "${dept.dept_name}";
		var dept_name_now =  $("#dept_name").val();
		if(dept_name_now!=dept_name)
		{
			bool = true;
		}
		if(bool){
			var remark = "operatormemo="+encodeURIComponent("进行了部门修改操作,由${dept.dept_name }")+"改为"+$("#dept_name").val()+"&funId="+encodeURIComponent("部门管理");
			var data = "dept.dept_name="+$("#dept_name").val()+"&dept.dept_id="+${dept.dept_id};
			data =data+"&"+remark;
			$.ajax({
					type:"post",
					url:"showManager/deptAction!updateByAspect.dhtml",
					data:data,
					success:function(txt){
						if(txt=='success'){
							$.messager.alert("提示","修改成功","info",function(){
								window.location.href="<%=path%>/showManager/deptAction!showDept.dhtml";
							});
						}
					}
				});
			}else{
				$.messager.alert("提示","并未做任何修改","info",function(){
					window.location.href="<%=path%>/showManager/deptAction!showDept.dhtml";
				});
			}
	}
	//function _onchange(obj,action_obj){
	//	var id_value = obj.id;
	//	 var value_this = action_obj.id_value;
	//	  alert(value_this);
	//}
	
	</script>
  </head>
  
  <body>
  <div class="titlePanel"><h2>部门管理&nbsp;&gt;&nbsp;修改部门信息</h2>
	<div class="panel-group"><a href="javascript:;" class="button" onclick="javascript:_submit()">保存</a> <a href="<%=path%>/showManager/deptAction!showDept.dhtml" class="button">取消</a></div>
  </div>
<div style="height:67px;"></div>
<div class="AddForm">
   	 <div class="add-item"><label>部门名称</label><div class="add-item-ipt"><input id = "dept_name" type="text" size="30" value=${dept.dept_name } /><br/></div></div>
</div>

  </body>
</html>
