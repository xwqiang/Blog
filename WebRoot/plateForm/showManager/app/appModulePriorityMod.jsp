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
<title>应用权限修改_单点登录系统</title>
<script type="text/javascript">
	//0:modules_  1:id  2:parent_id   3:level    role_id
	function _check(){
		$('input').each(function(index){
		　　　var _now = this.name.split('_');
			//alert(_now[2]);
			$(this).bind('click',function(){
				_checkIt(this);
				//checkAllBox();			
			　});
		});
	}
	//检查是否合法  abandoned now
	function checkAllBox(){
		$('input').each(function(index){
			_checkIt(this);
		});
	}
	function _checkIt(child){
		if(child&&child.name)
		var box = child.name.split('_');
		////console.log("...................checkIt.");
		if(!!(box&&box[2])){
			//console.log(child.checked);
			if(!!$(child).attr('checked')){
				//console.log("..............................................√...勾选模块 ........"+child.name);
				var parent = getParent(child);
				//console.log(".............................. 勾选该父模块........."+parent);
				$(parent).attr("checked",true);
				_checkIt(parent);
			}else{
				var children = getChildren(child);
				for(i in children){
					$(children[i]).attr("checked",false);
					//console.log("..........................取消children的勾选："+children[i].name);
					_checkIt(children[i]);
				}
			}
		}
	}
	function getParent(child){
		//alert("getparent:"+child.name);
		var parent;
		var box = child.name.split('_');
		var id = box[2];
		$('input[name^="modules_'+id+'"]').each(function(){
			//console.log("..........................选择到的父模块。。。。。。。。。。"+this.name);
			parent = this;
			return parent;
		});
		return parent;
	}
	function getChildren(parent){
		var box = parent.name.split('_');
		var id = box[1];
		var children =[];
		$('input[name$="_'+id+'"]').each(function(index){
			children.push(this);
			//console.log("...............................获取到children:"+this.name);
		});
		return children;
	}
	function showTree(role_id,parent_id){
 			parent_id=parent_id||0;
			var data ="app_id=${appId}&role_id="+ role_id+"&parent_id="+parent_id;
	 		$.ajax({
				type:"post",
				data:'',
				dataType:"json",
				url:"<%=path %>/showManager/app!modTreeMenu.dhtml?"+data,
				success:function(txt){
					var json = txt;
					getNode(json,role_id,0);
					_check();
				}			
			});   
	  	}

	function getNode(json,role_id,level){
		var glen ;
		if(level==0){
			glen =json&&json.length||0;
			json = json;
		}else{
			var glen =json&&json.children&&json.children.length||0;
			json = json.children;
		}
		if(!!glen){
			level++;
			for(var i=0;i<glen;i++){
				var space = getPattern(level);
				if(json[i].flag=="true"){
					$("#module_"+role_id).append("<li>"+space+"<input type='checkbox' value='"+json[i].id+"' name='modules_"+json[i].id+"_"+json[i].parent_id +"' data-my-Attr='"+json[i].module_name+"' checked='checked' />"+json[i].module_name+"</li>");
					module1.addMsg(json[i].module_name);
				}else{
					$("#module_"+role_id).append("<li>"+space+"<input type='checkbox' value='"+json[i].id+"' name='modules_"+json[i].id+"_"+json[i].parent_id +"' data-my-Attr='"+json[i].module_name+"'/>"+json[i].module_name+"</li>");
				}
				var len = json[i]&&json[i].children&&json[i].children.length||0;
				if(!!len){
					level++;
					for(var j=0;j<len;j++){
						var space = getPattern(level);
						if(json[i].children[j].flag=="true"){
							$("#module_"+role_id).append("<li>"+space+"<input type='checkbox' value='"+json[i].children[j].id+"' name='modules_"+json[i].children[j].id+"_"+json[i].children[j].parent_id +"' data-my-Attr='"+json[i].children[j].module_name+"' checked='checked' />"+json[i].children[j].module_name+"</li>");
							module1.addMsg(json[i].children[j].module_name);
						}else{
							$("#module_"+role_id).append("<li>"+space+"<input type='checkbox' value='"+json[i].children[j].id+"' name='modules_"+json[i].children[j].id+"_"+json[i].children[j].parent_id +"' data-my-Attr='"+json[i].children[j].module_name+"'/>"+json[i].children[j].module_name+"</li>");
						}
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
	var module1 =(function() {  
		    var msg = '',  
		    addMsg= function(temp) {  
		        msg+= temp+',';  
		    },  
		    getMsg= function() { 
		    	msg =msg!=''&&msg.substring(0,msg.length-1)||'';
		    	return msg; 
		    }
		return {  
		    addMsg: addMsg,
		    getMsg: getMsg
		}  
	})();
	function submit(){
		var id="${roleId }";
		var chk_value =[];  
		var chk_name=[];  
		  $('input[name^="modules"]:checked').each(function(){    
		   chk_value.push($(this).val()); 
		   chk_name.push($(this).data('myAttr'));   
		  });    
		var data="chk_value="+chk_value+"&roleId="+id+"&appId=${appId}";
		var remarkdata="&operatormemo="+encodeURIComponent("进行了应用权限修改操作，修改了角色：${role_name },修改后角色权限由：  ")+module1.getMsg()+"变为"+chk_name+"&funId="+encodeURIComponent("应用权限管理");
		alert(remarkdata);
		data += remarkdata;
		$.ajax({
			type:"post",
			data:data,
			url:"<%=path %>/showManager/app!appModulePriorityModSubmitByAspect.dhtml",
			success:function(){
				window.location.href="<%=path%>/showManager/app!appModulePriorityShow.dhtml?appId=${appId}&app_name=${app_name}";
			}			
		});
	}
</script>
</head>

<body>

		<div class="titlePanel"><h2>应用权限管理&nbsp;&gt;&nbsp;${app_name }&nbsp;&gt;&nbsp;修改权限</h2>
		<a href="javascript:submit();" class="button">保存</a> 
		<a href="<%=path%>/showManager/app!appModulePriorityShow.dhtml?appId=${appId}&app_name=${app_name}" class="button">取消</a>
		</div>

<div class="AddForm">
	<form name="roleform" id="roleform" action="" method="post">
    <div class="add-item"><label>角色名称</label><div class="add-item-ipt">${role_name }</div></div>
    <div class="add-item">拥有权限<p></p>
	    <div >
	    	<div id="module_${roleId}"></div>
				<script>
					showTree(${roleId },0);
				</script>	
	    </div>
    </div>
  </form>
</div>
<img/><img/>
</body>
</html>
