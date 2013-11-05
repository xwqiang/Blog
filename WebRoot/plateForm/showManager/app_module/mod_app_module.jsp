<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
		<link type="text/css" rel="stylesheet"
			href="<%=path%>/css/global.css" />
		<link type="text/css" rel="stylesheet"
			href="<%=path%>/css/content.css" />
		
		<script type="text/javascript" src="<%=path%>/js/easyui/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=path%>/js/easyui/easyloader.js"></script>
		<script type="text/javascript" src="<%=path%>/js/easyui/jquery.easyui.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/default/easyui.css"/>	
		<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/icon.css"/>
		<link rel="stylesheet" href="<%=path%>/css/validationEngine.jquery.css" type="text/css" media="screen" charset="utf-8" />
		<script src="<%=path %>/js/easyui/jquery.validationEngine.js" type="text/javascript"></script> 
		<script src="<%=path %>/js/easyui/jquery.validationEngine-zh_CN.js" type="text/javascript"></script> 
		<script>
		$(document).ready(function() {
		$("#modForm").validationEngine({
			promptPosition: "centerRight"
		});
		showParentID();
	});
	function _check(account){
		//alert(account);
		$.ajax({
			type:"post",
			url:"showManager/appModuleAction!validateModuleAccount.dhtml?app_module.appId=+${app_module.appId}&app_module.appModuleId="+account,
			success:function(txt){
				//alert(txt);
				if(txt=="success")
				$("#user_tips").html("该ID已经被使用，请重新选择一个ID");
				else
				$("#user_tips").html("");
			}
		});
	}
	function showParentID(){
		var parentId=${app_module.parentId};
		var id=${app_module.id};
		//alert(parentId);
		var url ="showManager/appModuleAction!getParentId.dhtml?appId="+${app_module.appId};
		$.ajax({
			type:'post',
			dataType:"json",
			url:url,
			success:function(txt){
			$("#parentId").append("<option value=0>一级菜单</option>");
			  for(var i=0;i<txt.length;i++){
				  	if(txt[i].id==id){
				  		continue;
				  	}
				  	if(txt[i].id==parentId)
				  	{
				  		$("#parentId").append("<option value='"+txt[i].id+"' selected='selected'>"+txt[i].appModuleName+"</option>");
				  	}else{
				     $("#parentId").append("<option value='"+txt[i].id+"'>"+txt[i].appModuleName+"</option>");
				  }
			 }
			}
		});
	}
	 function getResult(s){
		  if(s.length < 4){
		   return 0;
		  }
		  var ls = 0;
		  if (s.match(/[a-z]/ig)){
		   ls++;
		  }
		  if (s.match(/[0-9]/ig)){
		   ls++;
		  }
		   if (s.match(/(.[^a-z0-9])/ig)){
		   ls++;
		  }
		  if (s.length < 6 && ls > 0){
		   ls--;
		  }
		  return ls
	 }
	bool = false;
	remark = "";
	function _submit(){
		var result = $("#modForm").validationEngine("validate");
			if(!result){
				return ;
			}
		if($("#user_tips").html()!="")
			return;
		var changed = _change('模块序列号',$("#appModuleId").val(),'${app_module.appModuleId}')||_change('模块名称',$("#appModuleName").val(),'${app_module.appModuleName}')||_change('模块URL',$("#appModuleUrl").val(),'${app_module.appModuleUrl}')||_change('父模块',$("#parentId").val(),'${app_module.parentId}');
		//alert(changed);
		if(changed){
			var parentName = $("#parentId option:selected").text();
			if(parentName=="一级菜单"){
				parentName ="";
			}
			remark = "operatormemo="+"进行了应用模块管理操作,被修改的模块id：${app_module.id } "+remark+"&funId="+"模块${app_module.appName}";
			var data = "app_module.appModuleId="+$("#appModuleId").val()+"&app_module.appModuleName="+$("#appModuleName").val()+"&app_module.appModuleUrl="+$("#appModuleUrl").val()+"&app_module.id=${app_module.id}"+"&app_module.parentId="+$("#parentId").val()+"&app_module.parentName="+parentName+"&app_module.appId=${app_module.appId}";
			data = data+'&'+remark;
			$.ajax({
					type:"post",
					url:"showManager/appModuleAction!updateByAspect.dhtml",
					data:data,
					success:function(txt){
						if(txt=='success'){
							$.messager.alert("提示","修改成功","info",function(){
								window.location.href="<%=path%>/showManager/appModuleAction!show.dhtml?appId=${app_module.appId}&appName=${app_module.appName}";
							});
						}else{
							$.messager.alert("提示","修改失败","info");
						}
					}
				});
		}else{
			
					$.messager.alert("提示","并为做任何修改","info",function(){
					window.location.href="<%=path%>/showManager/appModuleAction!show.dhtml?appId=${app_module.appId}&appName=${app_module.appName}";
				});
			
		}
	}
	
	
	
  
	function _change(title,currentVal,originalVal){
		var isChanged = false;
		if($.trim(originalVal)!=$.trim(currentVal)){
			remark +=title+'由'+originalVal+'变为 '+currentVal;
			//alert(title+"  "+originalVal+"-->"+currentVal);
			isChanged = true;
		}
		return isChanged;
	}
	</script>
	</head>

	<body>
	<div class="titlePanel"><h2>应用模块管理&nbsp;&gt;&nbsp;${app_module.appName}&nbsp;&gt;&nbsp;修改模块</h2>
		
			<div class="panel-group">
				<a href="javascript:;" class="button" id="save"
					onclick="javascript:_submit()">保存</a>
				<a href="<%=path%>/showManager/appModuleAction!show.dhtml?appId=${app_module.appId}&appName=${app_module.appName}" class="button">取消</a> 
			</div>
			
	</div>
		<div style="height:67px;"></div>
		<div class="AddForm">
			<form id="modForm">
				<div class="add-item">
					<label>
						模块序列号
					</label>
					<div class="add-item-ipt">
						<input id="appModuleId" type="text" size="30" value="${app_module.appModuleId }" class="validate[required,minSize[1],maxSize[15]]"  onblur="javascript:_check(this.value)" />
						<font color="red"><span id="user_tips"></span>
						</font>
						<br />
					</div>
				</div>
				<div class="add-item">
					<label>
						模块名称
					</label>
					<div class="add-item-ipt">
						<input id="appModuleName" type="text" size="30" value="${app_module.appModuleName }" class="validate[required,maxSize[15]]" onblur="" /><span id="chkResult">
						<font color="red"><span id="pwd_tips"></span>
						</font>
						<br />
					</div>
				</div>
				<div class="add-item">
					<label>
						模块URL
					</label>
					<div class="add-item-ipt">
						<input id="appModuleUrl" type="text" value="${app_module.appModuleUrl }" class="validate[required,maxSize[200]]"/>
						<font color="red"><span id="pwd_tips1"></span>
						</font>
						<br />
					</div>
				</div>
				<div class="add-item">
					<label>
						父模块
					</label>
					<div class="add-item-ipt">
						<select id="parentId" name="parentId">
					</div>
				</div>
					
			</form>
		</div>

	</body>
</html>
