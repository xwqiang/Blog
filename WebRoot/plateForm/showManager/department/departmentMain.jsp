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
    
    <title>Myjsp' starting page</title>
    
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
	<script type="text/javascript">
	 function getState(state,id){
		var res = '未激活';
		if(state!=0){
			res ='激活';
		}
		document.getElementById("changeValue_"+id).innerText=res;
	}
	function _delete(dept_id,dept_count,dept_name){
		if(dept_count>0){
			$.messager.alert("提示","该部门下有"+dept_count+"个员工 ，禁止删除","info");
			return;
		}else{
			$.messager.confirm("提示","确定要删除吗？",function(r){
			if(r){
					var remark = "operatormemo="+encodeURIComponent("进行了部门删除操作,删除了")+dept_name+"&funId="+encodeURIComponent("部门管理");
					var data="dept_id="+dept_id;
					data =data+"&"+remark
					$.ajax({
							type:"post",
							url:"showManager/deptAction!deleteByAspect.dhtml",
							data:data,
							success:function(txt){
								if(txt=='success'){
									$.messager.alert("提示","删除成功","info",function(){
										window.location.href="<%=path%>/showManager/deptAction!showDept.dhtml";
									});
								}
							}
						});
					
			}
			});
		}
	}
	</script>
  </head>
  
  <body>
 <div class="titlePanel"><h2>部门管理&nbsp;&gt;&nbsp;新建部门</h2>
	<div class="panel-group"><a href="showManager/deptAction!add.dhtml" class="button">添加部门</a> </div>

 </div>
	<div style="height:67px;"></div>
  


<div class="page-list">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl-list">
	<tr><th nowrap="nowrap">序号</th><th width="15%" nowrap="nowrap">部门名称</th><th width=65%" nowrap="nowrap">人数</th><th width="20%" nowrap="nowrap">操作</th></tr>
   
    	
	    	<c:forEach items="${deptList}" var="dept" varStatus="status">
		    	<tr class="list-first"><td width="60">${status.index+1}</td><td>${dept.dept_name }</td><td>${dept.dept_count }</td>
	        		<td><a href="<%=path %>/showManager/deptAction!mod.dhtml?dept_id=${dept.dept_id }">修改</a>&nbsp;&brvbar;&nbsp;<a href="javascript:_delete(${dept.dept_id },${dept.dept_count },'${dept.dept_name }')" >删除</a></td>
	       		</tr>
	    	</c:forEach>
	  </table>
   
</div>
	
  </body>
</html>
