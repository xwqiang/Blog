<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="../css/global.css" />
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<script type="text/javascript" src="<%=path %>/js/easyui/jquery-1.7.1.min.js"></script>
<script src="<%=path %>/js/easyui/jquery.validationEngine.js" type="text/javascript"></script> 
<script src="<%=path %>/js/easyui/jquery.validationEngine-zh_CN.js" type="text/javascript"></script> 
<script type="text/javascript" src="<%=path%>/js/easyui/jquery.easyui.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/default/easyui.css"/>
<link rel="stylesheet" href="<%=path%>/css/validationEngine.jquery.css" type="text/css" media="screen" charset="utf-8" />
<title>角色添加_单点登录系统</title>
<script type="text/javascript">
		$(document).ready(function() {
			$("#roleform").validationEngine({
				promptPosition: "centerRight"
			});
			
		});

	function _check(){
	    	$('input[name^="modules_c"]:checked').each(function(){ 
			 var cc = this.name.split('modules_c');
			 var tt = $('input[name=modules_p'+cc[1]+']');
		 	 tt.attr("checked",'true')
			 return;
		 	}); 
	 	}
	function _cancelAll(obj,id){
	 	if(!$(obj).attr("checked")){
		 	$('input[name=modules_c'+id+']').each(function(){
		 		$(this).attr("checked",false);
		 	}); 
	 	}
	 }
	function submit(){
		var result = $("#roleform").validationEngine("validate");
		if(!result){
			return ;
		}
		_check();
		var name=$("#name").val();
		if($.trim(name) == ""){
			alert("请填写角色名称！");
			return;
		}
		  var chk_value =[]; 
		  var chk_name =[];   
		  $('input[name^="modules"]:checked').each(function(){    
		   chk_value.push($(this).val());    
		   chk_name.push($(this).data('myAttr'));
		  });    
		  if(chk_value.length==0){
		  	$.messager.alert("提示","还未选择权限！","info");
		  	return;
		  }
		  
		   var chk_value2 =[];   
		   var chk_name2 =[];   
		  $('input[name="apps"]:checked').each(function(){    
		   chk_value2.push($(this).val()); 
		   chk_name2.push($(this).data('myAttr'));   
		  });    
		  if(chk_value2.length==0){
		  $.messager.alert("提示","还未选择可进入的系统!","info");
		  	return;
		  }
		  
		
		var data="name="+name+"&chk_value="+chk_value+"&chk_value2="+chk_value2;
		var remarkdata="&operatormemo="+encodeURIComponent("进行了添加角色操作，新添加角色名称为：")+name+",角色权限有："+chk_name+",角色可进入系统App有："+chk_name2+"&funId="+encodeURIComponent("角色role");
		data += remarkdata;
		$.ajax({
			type:"post",
			data:data,
			url:"<%=path %>/roleManage/role!submitByAspect.dhtml",
			success:function(){
				window.location.href="<%=path%>/roleManage/role!show.dhtml";
			}			
		});
	}
</script>
</head>

<body>
<div class="titlePanel"><h2>角色管理&nbsp;&gt;&nbsp;新建角色</h2>
	<div class="panel-group">
		<a href="javascript:submit();" class="button">保存</a> 
		<a href="<%=path %>/roleManage/role!show.dhtml" class="button">取消</a>
	</div>
</div>

    
<div style="height:67px;"></div>

<div class="AddForm">
	<form name="roleform" id="roleform" action="<%=path %>/moduleManage/module!submitbyAspect.dhtml" method="post">
    <div class="add-item"><label>角色名称</label><div class="add-item-ipt"><input type="text" size="30" id="name" name="name" class="validate[required,maxSize[50]]" /></div></div>
    <div class="add-item"><label>权限</label>
    	<div  class="page-list">
	    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl-list">
	    	<c:forEach items="${modules}" var="m">
	    	<tr class="list-first">
	    		<c:if test="${m.parent_id == 0}">
		    	<td>
		    	<div class="level-list">
	    			<input type="checkbox" value="${m.id }" data-my-Attr='${m.module_name }' name="modules_p${m.id }" onclick="javascript:_cancelAll(this,'${m.id }')"/>
   			 		<strong>${m.module_name }</strong>
   				 	<p>
	    			 <c:forEach items="${modules}" var="m2">
	    			 	<c:if test="${m2.parent_id == m.id}">
	    			 		 <input type="checkbox" value="${m2.id }" data-my-Attr='${m2.module_name }' name="modules_c${m.id }" onclick="javascript:_check()"/>
						 	 <span>
	    			 			${m2.module_name }&nbsp;
	    			 		</span>
	    			 	</c:if>
	    			 </c:forEach>
    			 	</p>
			 	</div>
		    	</td>
	    		</c:if>
	    	</tr>
	    	</c:forEach>
	    </table>
	    </div>
    </div>
    
    <div class="add-item"><label>系统</label>
    	<div >
    		<c:forEach items="${appList}" var="app">
	    		<input type="checkbox" name="apps" data-my-Attr='${app.app_name }' value="${app.id }"/>${app.app_name }&nbsp;&nbsp;&nbsp;
    		</c:forEach>
    	</div>
    </div>
  </form>
</div>

</body>
</html>
