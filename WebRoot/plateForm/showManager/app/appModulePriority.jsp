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
<title>系统App的角色管理_单点登录系统</title>
<script type="text/javascript">
 	function showTree(role_id,parent_id){
 			if(!parent_id){
 				parent_id =0;
 			}
			var data ="app_id=${appId}&role_id="+ role_id+"&parent_id="+parent_id;
	 		$.ajax({
				type:"post",
				data:'',
				dataType:"json",
				url:"<%=path %>/showManager/app!showTreeMenu.dhtml?"+data,
				success:function(txt){
					var json = txt;
					getNode(json,role_id,0);
				}			
			});   
	  	}
</script>
</head>

<body>
		<div class="titlePanel"><h2>应用权限管理&nbsp;&gt;&nbsp;${app_name }</h2>
		</div>
	<!--  <a href="<%=path %>/roleManage/role!add.dhtml" class="button">添加</a>   -->
<div style="height:37px;"></div>

<div class="page-list">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl-list">
	<tr><th width="5%" nowrap="nowrap">序号</th><th width="10%" nowrap="nowrap">角色名称</th><th width="35%" nowrap="nowrap">角色权限</th><th width="1%" nowrap="nowrap">操作</th></tr>
	
	<c:forEach items="${rolesList}" var="r" varStatus="status">
		<c:if test="${status.count%2 == 0}">
			<tr class="list-first">
			<td width="60">${status.count }</td>
			<td>${r.role_name }</td>
			<td>
			<div id="module_${r.id }">
			</div>
				<script>
					showTree(${r.id },0);
				</script>
	    	</td>
			<td><a class="list-a" href="<%=path %>/showManager/app!sappModulePriorityMod.dhtml?roleId=${r.id }&appId=${appId }&app_name=${app_name }&roleName=${r.role_name }">修改</a></td></tr>
		</c:if>
		<c:if test="${status.count%2 != 0}">
			<tr class="list-second">
			<td width="60">${status.count }</td>
			<td>${r.role_name }</td>
			<td>
				<div id="module_${r.id }"></div>
				<script>
					showTree(${r.id },0);
				</script>
    		</td>
			<td><a class="list-a" href="<%=path %>/showManager/app!sappModulePriorityMod.dhtml?roleId=${r.id }&appId=${appId }&app_name=${app_name }&roleName=${r.role_name }">修改</a></td></tr>
		</c:if>
	</c:forEach>
	</table>
</div>





</body>
<script type="text/javascript">
	//level为层级数，0为顶级菜单，否则其他都为子菜单
	function getNode(json,role_id,level){
		var glen ;
		if(level==0){
			glen =json&&json.length||0;
			json = json;
		}else{
			var glen =json&&json.children&&json.children.length||0;
			json = json.children;
		}
		if(glen>0){
			level++;
			for(var i=0;i<glen;i++){
				////////console.log("................"+json[i].module_name+".................."+level+"....................");
				var space = getPattern(level);
				$("#module_"+role_id).append("<li>"+space+json[i].module_name+"</li>");
				var len = json[i]&&json[i].children&&json[i].children.length||0;
				if(len>0){
					level++;
					for(var j=0;j<len;j++){
						var space = getPattern(level);
						//////console.log(".................."+json[i].children[j].module_name+".............level........."+space+".............");
						$("#module_"+role_id).append("<li>"+space+json[i].children[j].module_name+"</li>");
						getNode(json[i].children[j],role_id,level);
					}	
					level--;
				}
			}
		}
	}
	function getPattern(level){
		var space = "";
		for(var i =1;i<level;i++){
			space+="&nbsp&nbsp&nbsp";		
		}
		return space;
	}
	

</script>
</html>
