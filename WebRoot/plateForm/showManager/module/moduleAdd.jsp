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
<link rel="stylesheet" href="<%=path%>/css/validationEngine.jquery.css" type="text/css" media="screen" charset="utf-8" />
<title>权限添加_单点登录系统</title>
<script type="text/javascript">
		$(document).ready(function() {
			$("#moduleform").validationEngine({
				promptPosition: "centerRight"
			});
			
		});


	function check(obj){
		if(obj.value != 0){
			$("#div_order").hide();		
		}else{
			$("#div_order").show();		
		}
	}



	function submit(){
		var result = $("#moduleform").validationEngine("validate");
		if(!result){
			return ;
		}
	
	
		var name=$("#name").val();
		var url=$("#url").val();
		var order=$("#order").val();
		var parent_id=document.getElementById("module_type").value;
		
		if($.trim(name) == ""){
			alert("请填写权限名称！");
			return;
		}
		if($.trim(url) == ""){
			alert("请填写权限url！");
			return;
		}
		var data="name="+name+"&url="+url+"&order="+order+"&parent_id="+parent_id;
		if(parent_id == 0){
			var module_type = "根模块";
		}else{
			order=0;
			var module_type = "父模块ID为"+parent_id;
		}
		var remarkdata="&operatormemo="+encodeURIComponent("进行了添加权限操作，新添加权限名称为：")+name+",url:"+url+",类型："+module_type+",排序:"+order+"&funId="+encodeURIComponent("权限module");
		data += remarkdata;
		$.ajax({
			type:"post",
			data:data,
			url:"<%=path %>/moduleManage/module!submitByAspect.dhtml",
			success:function(){
				window.location.href="<%=path%>/moduleManage/module!show.dhtml";
			}			
		});
	}
</script>
</head>

<body>
<div class="titlePanel"><h2>权限管理&nbsp;&gt;&nbsp;新建权限 </h2>
		<a href="javascript:submit();" class="button">保存</a> 
		<a href="<%=path %>/moduleManage/module!show.dhtml" class="button">取消</a>
</div>
<div style="height:67px;"></div>


<div class="AddForm">
	<form name="moduleform" id="moduleform" action="<%=path %>/moduleManage/module!submitbyAspect.dhtml" method="post">
	<div class="add-item"><label>权限ID</label><div class="add-item-ipt">${maxId+1 }</div></div>
    <div class="add-item"><label>权限名称</label><div class="add-item-ipt"><input type="text" class="validate[required,maxSize[6]]" size="30" id="name" name="name" /></div></div>
    <div class="add-item"><label>权限url</label><div class="add-item-ipt"><input type="text" class="validate[required,maxSize[200]]" size="30" id="url" name="url" /></div></div>
     <div class="add-item"><label>权限类型</label><div class="add-item-ipt">
     	<select id="module_type" name="module_type" onchange="check(this);">
			<option value="0">根权限</option>
			<c:forEach items="${modules}" var="m">
				<option value="${m.id }">|${m.module_name }|&nbsp;&nbsp;的子权限</option>
			</c:forEach>
     	</select>
     </div></div>
    <div class="add-item" id="div_order"><label>权限排序</label><div class="add-item-ipt">排在
        <select id="order" name="order">
              <option value="1">首位</option>
              <c:forEach items="${modules}" var="m">
	              <option value="${m.module_order+1 }">|${m.module_name }|&nbsp;&nbsp;之后</option>
              </c:forEach>
        <!--       <option value="${maxOrder+1 }">末尾</option>   -->
        </select></div>
    </div>
  </form>
</div>

</body>
</html>
