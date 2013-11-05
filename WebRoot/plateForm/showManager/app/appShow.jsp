<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="../css/global.css" />
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<script type="text/javascript" src="<%=path %>/js/easyui/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyui/jquery.easyui.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/default/easyui.css"/>
<title>app管理_单点登录系统</title>
<script type="text/javascript">
	function del(id,name,url,app_icon_url,account,pwd,order){
		var data="id="+id+"&order="+order;
		var remarkdata="&operatormemo="+encodeURIComponent("进行了删除系统App的操作，删除App的ID为：")+id+",名称："+name+",账户："+account+",地址："+url+",密码："+pwd+",排序："+order+",图标："+app_icon_url+"&funId="+encodeURIComponent("系统App");
		data += remarkdata;
		
		$.messager.confirm("提示","确定删除吗？",function(result){
			if(result){
				$.ajax({
				type:"post",
				data:data,
				url:"<%=path %>/showManager/app!appDelByAspect.dhtml",
				success:function(num){
						window.location.href="<%=path %>/showManager/app!show.dhtml";
				}
			});
			}
		
		});
		
	}
</script>
</head>

<body>
<div class="titlePanel"><h2>应用管理</h2>


	<div class="panel-group">
		<a href="<%=path %>/showManager/app!appAdd.dhtml" class="button">添加</a>
	</div>
    <div class="clear"></div>

</div>
<div style="height:67px;"></div>




<div class="page-list">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl-list">
	<tr><th nowrap="nowrap">排序</th><th width="10%" nowrap="nowrap">系统名称</th><th width="30%" nowrap="nowrap">系统地址</th><th width="30%" nowrap="nowrap">系统图标链接</th><th width="5%" nowrap="nowrap">系统账户</th><th width="8%" nowrap="nowrap">系统密码</th><th width="10%" nowrap="nowrap">操作</th></tr>
	
	<c:forEach items="${appList}" var="app" varStatus="status">
		<c:if test="${status.count%2 == 0}">
			<tr class="list-first"><td width="60">${app.app_order }</td><td>${app.app_name }</td><td>${app.app_description_url }</td><td>${app.app_icon_url }</td><td>${app.app_account }</td><td>${app.app_pwd }</td>
			<td><a class="list-a" href="<%=path %>/showManager/app!appModify.dhtml?id=${app.id }">修改</a>&nbsp;&brvbar;&nbsp;<a class="list-a" href="javascript:del(${app.id },'${app.app_name }','${app.app_description_url }','${app.app_icon_url }','${app.app_account }','${app.app_pwd }','${app.app_order }');">删除</a></td></tr>
		</c:if>
		<c:if test="${status.count%2 != 0}">
			<tr class="list-second"><td width="60">${app.app_order }</td><td>${app.app_name }</td><td>${app.app_description_url }</td><td>${app.app_icon_url }</td><td>${app.app_account }</td><td>${app.app_pwd }</td>
			<td><a class="list-a" href="<%=path %>/showManager/app!appModify.dhtml?id=${app.id }">修改</a>&nbsp;&brvbar;&nbsp;<a class="list-a" href="javascript:del(${app.id },'${app.app_name }','${app.app_description_url }','${app.app_icon_url }','${app.app_account }','${app.app_pwd }','${app.app_order }');">删除</a></td></tr>
		</c:if>
	</c:forEach>
	</table>
</div>

</body>
</html>
