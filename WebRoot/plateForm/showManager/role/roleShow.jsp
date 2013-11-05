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
<title>角色管理_单点登录系统</title>
<script type="text/javascript">
	function del(id,role_name,r){
		$.messager.confirm("提示","确定删除吗？",function(result){
			if(result){
				$.ajax({
					type:"post",
					date:"",
					url:"<%=path %>/roleManage/role!checkUserByRole.dhtml?id="+id,
					success:function(num){
						if(num > 0){
							  $.messager.alert("提示","有"+num+"个用户拥有该角色，不能删除！","info");
						}else{
							 document.getElementById("roleId").value = id;
							 document.getElementById("operatormemo").value = "进行了删除角色操作，删除角色ID为："+id+" 名称为："+role_name;
							 document.getElementById("funId").value ="角色role";
							 document.form1.submit();
						}
					}
				});
			}
		});
	}
</script>
</head>


<body>
<div class="titlePanel"><h2>角色管理</h2>
	<div class="panel-group">
		<a href="<%=path %>/roleManage/role!add.dhtml" class="button">添加</a>
	</div>
</div>

  <div style="height:67px;"></div>

<div class="page-list">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl-list">
    	<tr><th nowrap="nowrap">序号</th><th width="182" nowrap="nowrap">名称</th><th width="337" nowrap="nowrap">权限</th><th width="337" nowrap="nowrap">可进入系统</th><th width="965" nowrap="nowrap">操作</th></tr>
   	 	<c:forEach items="${rolesList}" var="r" varStatus="status">
    	<tr class="list-first"><td width="96">${status.count }</td><td>${r.role_name }</td>
    	  <td>
    	  <c:forEach items="${r.modulesList}" var="m">
    	  		<c:if test="${m.parent_id ==0}">
	    	  		<div class="level-list"><h3>${m.module_name }</h3>
	    	  			 <p>
	    	  			 <c:forEach items="${r.modulesList}" var="m2">
	    	  			 	<c:if test="${m2.parent_id == m.mid}">
	    	  			 		<span>${m2.module_name }&nbsp;</span>
	    	  			 	</c:if>
	    	  			 </c:forEach>
	    	  			 </p>
	    	  		</div>
    	  		</c:if>
            </c:forEach>
          </td>
            
         <td>
         	<c:forEach items="${r.appList}" var="app">
    			${app.app_name }&nbsp;
    		</c:forEach>
	    </td>
           
          <td><a class="list-a" href="<%=path %>/roleManage/role!modify.dhtml?id=${r.id }">修改</a>&nbsp;&brvbar;&nbsp;<a class="list-a" href="javascript:del(${r.id },'${r.role_name }');">删除</a></td></tr>
       </c:forEach>
    </table>
    <form id="form1" name="form1" action="<%=path %>/roleManage/role!delByAspect.dhtml" method="post">
    	<input name="id" id="roleId"/>
    	<input name="operatormemo" id="operatormemo"/>
    	<input name="funId" id="funId"/>
    </form>
</div>

</body>
</html>

