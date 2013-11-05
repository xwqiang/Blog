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
<title>权限管理_单点登录系统</title>
<script type="text/javascript">
	function del(id,module_order,module_name,module_url,parentName){
		$.messager.confirm("提示","确定删除吗？",function(result){
			if(result){
				$.ajax({
					type:"post",
					data:"",
					url:"<%=path %>/moduleManage/module!checkChildrenModule.dhtml?id="+id,
					success:function(num){
						if(num > 0){
							$.messager.alert("提示","该模块有"+num+"个子模块，不能删除！","info");
						}else{
							var remarkdata="&operatormemo="+encodeURIComponent("进行了删除权限操作，删除权限ID为：")+id+",名称："+module_name+",url:"+module_url+",父模块："+parentName+",排序:"+module_order+"&funId="+encodeURIComponent("权限module");
							window.location.href="<%=path %>/moduleManage/module!delByAspect.dhtml?id="+id+"&module_order="+module_order+remarkdata;
						}
					}
				});
			}
		});
		
		
	}
</script>
</head>
 
<body>
	<div class="titlePanel"><h2>权限管理&nbsp;&gt;&nbsp;权限列表</h2>
		<a href="<%=path %>/moduleManage/module!add.dhtml" class="button">添加</a>
	</div>
	<div style="height:67px;"></div>



<div class="page-list">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl-list">
	<tr><th nowrap="nowrap">排序</th><th width="20%" nowrap="nowrap">权限名称</th><th width="40%" nowrap="nowrap">权限url</th><th width="20%" nowrap="nowrap">父模块</th><th width="10%" nowrap="nowrap">操作</th></tr>
	
	<c:forEach items="${modules}" var="m" varStatus="status">
		<c:if test="${status.count%2 == 0}">
			<tr class="list-first"><td width="60">${m.module_order }</td><td>${m.module_name }</td><td>${m.module_url }</td>
			<td>
				<c:if test="${m.parentName == null}">根模块</c:if>
				<c:if test="${m.parentName != null}">${m.parentName }</c:if>
			</td>
			<td><a class="list-a" href="<%=path %>/moduleManage/module!modify.dhtml?id=${m.id }">修改</a>&nbsp;&brvbar;&nbsp;<a class="list-a" href="javascript:del(${m.id },${m.module_order },'${m.module_name }','${m.module_url }','${m.parentName }');">删除</a></td></tr>
		</c:if>
		<c:if test="${status.count%2 != 0}">
			<tr class="list-second"><td width="60">${m.module_order }</td><td>${m.module_name }</td><td>${m.module_url }</td>
			<td>
				<c:if test="${m.parentName == null}">根模块</c:if>
				<c:if test="${m.parentName != null}">${m.parentName }</c:if>
			</td>
			<td><a class="list-a" href="<%=path %>/moduleManage/module!modify.dhtml?id=${m.id }">修改</a>&nbsp;&brvbar;&nbsp;<a class="list-a" href="javascript:del(${m.id },${m.module_order },'${m.module_name }','${m.module_url }','${m.parentName }');">删除</a></td></tr>
		</c:if>
	</c:forEach>
	</table>
</div>

</body>
</html>
