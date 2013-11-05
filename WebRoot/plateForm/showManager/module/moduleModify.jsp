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
<title>权限修改_单点登录系统</title>
<script type="text/javascript">
		$(document).ready(function() {
			$("#moduleform").validationEngine({
				promptPosition: "centerRight"
			});
			
		});

	function submit(){
		var result = $("#moduleform").validationEngine("validate");
		if(!result){
			return ;
		}
	
		var name=$("#name").val();
		var url=$("#url").val();
		var name_old="${module_t.module_name }";
		var url_old="${module_t.module_url }";
		var order_old="${module_t.module_order }";
		var id="${module_t.id }";
		var parent_id_old = "${module_t.parent_id}";
		if(order_old == 0){//子模块
			var parent_id = $("#parent_id").val();
			var order = 0;
			var data="name="+name+"&url="+url+"&id="+id+"&order_old="+order_old+"&parent_id="+parent_id;
			var remarkdata="&operatormemo="+encodeURIComponent("进行了修改权限操作，修改权限ID为：")+id+",名称由${module_t.module_name}变为："+name+",url由${module_t.module_url}变为:"+url+",父模块ID由 "+$("#parent_id_hidden").val()+" 变为 "+$("#parent_id option:selected").text()+"&funId="+encodeURIComponent("权限module");
		}else{//根模块
			var parent_id = 0;
			var order=$("#order").val();
			var data="name="+name+"&url="+url+"&order="+order+"&id="+id+"&order_old="+order_old;
			if(order < order_old){
				var order_for_aspect =  parseInt(order)+1;
			}else{
				var order_for_aspect = order;
			}
			
			var remarkdata="&operatormemo="+encodeURIComponent("进行了修改权限操作，修改权限ID为：")+id+",名称由 ${module_t.module_name} 变为："+name+",url由${module_t.module_url} 变为:"+url+",排序由 ${m.module_order } 变为："+order_for_aspect+"&funId="+encodeURIComponent("权限module");
			order = parseInt(order)+1;
		}
		
		if($.trim(name) == ""){
			alert("请填写权限名称！");
			return;
		}
		if($.trim(url) == ""){
			alert("请填写权限url！");
			return;
		}
		if(name == name_old && url==url_old && order==order_old && parent_id==parent_id_old){
			alert("未作任何改变！");
			window.location.href="<%=path%>/moduleManage/module!show.dhtml";
			return;
		}
		
		//var data="name="+name+"&url="+url+"&order="+order+"&id="+id+"&order_old="+order_old;
		//var remarkdata="&operatormemo="+encodeURIComponent("进行了修改权限操作，修改权限名称为：")+name+"&funId="+encodeURIComponent("ceshi");
		data += remarkdata;
		$.ajax({
			type:"post",
			data:data,
			url:"<%=path %>/moduleManage/module!modifySubmitByAspect.dhtml",
			success:function(){
				window.location.href="<%=path%>/moduleManage/module!show.dhtml";
			}			
		});
	}
</script>
</head>

<body>
<div class="titlePanel"><h2>权限管理&nbsp;&gt;&nbsp;修改权限</h2>
		<a href="javascript:submit();" class="button">保存</a> 
		<a href="<%=path %>/moduleManage/module!show.dhtml" class="button">取消</a>

</div>
<div style="height:67px;"></div>





<div class="AddForm">
	<form name="moduleform" id="moduleform" action="" method="post">
	<div class="add-item"><label>权限ID</label><div class="add-item-ipt">${module_t.id }</div></div>
    <div class="add-item"><label>权限名称</label><div class="add-item-ipt"><input type="text" class="validate[required,maxSize[6]]" size="30" id="name" name="name" value="${module_t.module_name }" /></div></div>
    <div class="add-item"><label>权限url</label><div class="add-item-ipt"><input type="text" class="validate[required,maxSize[200]]" size="30" id="url" name="url" value="${module_t.module_url }" /></div></div>
    <c:if test="${module_t.module_order != 0}">
	    <div class="add-item"><label>权限排序</label><div class="add-item-ipt">排在
	        <select id="order" name="order" >
	              <option value="0">首位</option>
	              <c:forEach items="${modules}" var="m" >
	              
	              	<c:if test="${m.module_order+1 == module_t.module_order }">
		              <option value="${m.module_order }" selected="selected">|${m.module_name }|之后</option>
		            </c:if> 
		             
		             <c:if test="${m.module_order+1  != module_t.module_order }">
		              <option value="${m.module_order }" >|${m.module_name }|之后</option>
		             </c:if> 
		             
	              </c:forEach>
	         <!--      <option value="${maxOrder }">末尾</option>   -->
	        </select></div>
	    </div>
	 </c:if>   
	 
	 <c:if test="${module_t.module_order == 0}">
	  <div class="add-item"><label>父模块</label><div class="add-item-ipt">
	        <select id=parent_id name="parent_id" >
	              <c:forEach items="${modules}" var="m" >
	              
	              	<c:if test="${m.id == module_t.parent_id }">
		              <option value="${m.id }" selected="selected">${m.module_name }</option>
		              <input id="parent_id_hidden" type="hidden" value="${m.id }"/>
		             </c:if> 
		             
		             <c:if test="${m.id  != module_t.parent_id }">
		              <option value="${m.id }" >${m.module_name }</option>
		             </c:if> 
		             
	              </c:forEach>
	         <!--      <option value="${maxOrder }">末尾</option>   -->
	        </select></div>
	    </div>
	 </c:if>
  </form>
</div>

</body>
</html>
