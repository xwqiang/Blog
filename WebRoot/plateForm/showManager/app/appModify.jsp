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
	<link rel="stylesheet" type="text/css" href="<%=path %>/js/subModal/style.css" />
	<link rel="stylesheet" type="text/css" href="<%=path %>/js/subModal/submodal.css" />
	<script type="text/javascript" src="<%=path%>/js/subModal/submodalsource.js"></script>
	<script src="<%=path %>/js/easyui/jquery.validationEngine.js" type="text/javascript"></script> 
	<script src="<%=path %>/js/easyui/jquery.validationEngine-zh_CN.js" type="text/javascript"></script> 
	<link rel="stylesheet" href="<%=path%>/css/validationEngine.jquery.css" type="text/css" media="screen" charset="utf-8" />
	<script type="text/javascript" src="<%=path%>/js/easyui/easyloader.js"></script>
	<script type="text/javascript" src="<%=path%>/js/easyui/jquery.easyui.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/default/easyui.css"/>	
	<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/icon.css"/>
<title>系统修改_单点登录系统</title>
<script type="text/javascript">
	$(document).ready(function() {
			$("#appform").validationEngine({
				promptPosition: "centerRight"
			});
			
		});

	function submit(){
		var result = $("#appform").validationEngine("validate");
		if(!result){
			return ;
		}
	
		var flag = "${flag}";
		if(flag == null || flag == ""){
			window.location.href="<%=path %>/showManager/app!appModify.dhtml?id=${id}&flag=1&app_icon_url=${app_icon_url}";
		}else{
	
			var name=$("#name").val();
			var account = $("#account").val();
			var url=$("#url").val();
			var pwd=$("#pwd").val();
			var order=$("#order").val();
			var app_icon_url=$("#app_icon_url").val();
			
			var name_old="${tempApp.app_name }";
			var account_old = "${tempApp.app_account }";
			var url_old="${tempApp.app_description_url }";
			var pwd_old="${tempApp.app_pwd}";
			var order_old="${tempApp.app_order }";
			var app_icon_url_old="${tempApp.app_icon_url }";
			
			var id="${tempApp.id }";
			if($.trim(name) == ""){
				alert("请填写系统名称！");
				return;
			}
			if($.trim(url) == ""){
				alert("请填写系统地址！");
				return;
			}
			if(name == name_old && url==url_old && pwd==pwd_old && order==order_old && account==account_old && app_icon_url==app_icon_url_old){
				alert("未作任何改变！");
				window.location.href="<%=path%>/showManager/app!show.dhtml";
				return;
			}
			
			var data="name="+name+"&url="+url+"&order="+order+"&id="+id+"&order_old="+order_old+"&pwd="+pwd+"&account="+account+"&app_icon_url="+app_icon_url;
			if(order < order_old){
				order = parseInt(order)+1;
			}
			var remarkdata="&operatormemo="+encodeURIComponent("进行了修改系统App的操作，修改App的ID为：")+id+",App名称：由${tempApp.app_name }变为"+name+" ,账户：由${tempApp.app_account } 变为"+account+",地址：由${tempApp.app_description_url }变为"+url+",密码：由${tempApp.app_pwd }变为"+pwd+",排序：由 ${app.app_order } 变为"+order+",图标：由${app_icon_url } 变为"+app_icon_url+"&funId="+encodeURIComponent("系统App");
			data += remarkdata;
			$.ajax({
				type:"post",
				data:data,
				url:"<%=path %>/showManager/app!appModifySubmitByAspect.dhtml",
				success:function(txt){
					if(txt=="success"){
						$.messager.alert("提示","修改成功","info",function(){
							window.location.href="<%=path%>/showManager/app!show.dhtml";
						});
					}
				}			
			});
		}	
	}
</script>
</head>

<body>
<div class="titlePanel"><h2>应用管理&nbsp;&gt;&nbsp;修改应用信息<c:if test="${flag != null}">&nbsp;&gt;&nbsp;修改应用基本信息</c:if><c:if test="${flag == null}">&nbsp;&gt;&nbsp;修改应用图标</c:if></h2>

	<div class="panel-group">
		<a href="javascript:submit();" class="button">保存</a> 
		<a href="<%=path%>/showManager/app!show.dhtml" class="button">取消</a>
	</div>
    <div class="clear"></div>
</div>

<div style="height:67px;"></div>

<div class="AddForm">
	<c:if test="${flag != null}">
		<form name="appform" id="appform" action="" method="post">
	    <div class="add-item"><label>系统名称</label><div class="add-item-ipt"><input type="text" class="validate[required,maxSize[50]]" size="30" id="name" name="name" value="${tempApp.app_name }" /></div></div>
	    <div class="add-item"><label>系统账户</label><div class="add-item-ipt"><input type="text" class="validate[required,maxSize[100]]" size="30" id="account" name="account" value="${tempApp.app_account }" /></div></div>
	    <div class="add-item"><label>系统地址</label><div class="add-item-ipt"><input type="text" class="validate[required,maxSize[100]]" size="30" id="url" name="url" value="${tempApp.app_description_url }" /></div></div>
	     <div class="add-item"><label>系统密码</label><div class="add-item-ipt"><input type="password" class="validate[required,maxSize[50]]" size="30" id="pwd" name="pwd" value="${tempApp.app_pwd }" /></div></div>
		 <div class="add-item"><label>密码确认</label><div class="add-item-ipt"><input type="password" class="validate[required,maxSize[50],equals[pwd]]" size="30" id="pwd2" name="pwd2" value="${tempApp.app_pwd }" /></div></div>	    
	     <div class="add-item" style="display: none;"><label>系统图标</label><div class="add-item-ipt"><input type="text" size="30" id="app_icon_url" name="app_icon_url" value="${app_icon_url }" /></div></div>
	    <div class="add-item"><label>系统排序</label><div class="add-item-ipt">排在
	        <select id="order" name="order" >
	              <option value="0">首位</option>				
	              <c:forEach items="${appList}" var="app" >
	              
	              	<c:if test="${app.app_order+1 == tempApp.app_order }">
		              <option value="${app.app_order }" selected="selected">|${app.app_name }|之后</option>
		             </c:if> 
		             
		             <c:if test="${app.app_order+1  != tempApp.app_order }">
		              <option value="${app.app_order }" >|${app.app_name }|之后</option>
		             </c:if> 
		             
	              </c:forEach>
	        <!--       <option value="${size }">末尾</option>  -->
	        </select></div>
	    </div>
	  </form>
  </c:if>
  
  
  <c:if test="${flag == null}">
  		<span style="color: #666;">点击更换图标可重新自定义图片；点击保存，进行下一步修改详细信息</span>
  		<br/>
	  <img src="<%=path %>/app_icons/${app_icon_url }" width="200" height="200"/>
	  <form name="moduleform" id ="modulform" action="<%=path %>/showManager/app!appAddSubmit.dhtml" method="post" enctype="multipart/form-data">
	  		<div class="add-item"><label>当前图标</label><div class="add-item-ipt"><a href="javascript:showPopWin('<%=path %>/plateForm/showManager/app/uploadAppIcon.jsp?type=mod&id=${tempApp.id }', 800, 400, null);" class="button">更换图标</a></div></div>
	  </form>
  </c:if>
  
  
</div>

</body>
</html>
