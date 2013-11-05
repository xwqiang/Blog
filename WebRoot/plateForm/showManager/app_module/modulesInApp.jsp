<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
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
		<title>My JSP 'show.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<meta http-equiv="expires" content="0">
		<link type="text/css" rel="stylesheet" href="<%=path %>/css/global.css" />
		<link type="text/css" rel="stylesheet" href="<%=path %>/css/content.css" />
  		<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/default/easyui.css"/>	
		<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/icon.css"/>
		<script type="text/javascript" src="<%=path%>/js/easyui/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=path%>/js/easyui/easyloader.js"></script>
		<script type="text/javascript" src="<%=path%>/js/easyui/jquery.easyui.min.js"></script>
		<script type="text/javascript">
			
			$(function(){
			using(["window","messager"]);
			using("datagrid", function(){
				_search();
			}); 
		}); 
		$(document).ready(function(){
		document.onkeydown=function() { 
			if (event.keyCode==13) { 
				_search(); 
				} 
			}
		});
		function _add(){
			window.location.href ="<%=path%>/showManager/appModuleAction!add.dhtml?app_module.appId=${app_module.appId}&app_module.appName=${app_module.appName}";
		}
		function _modify(id){
			window.location.href ="<%=path%>/showManager/appModuleAction!mod.dhtml?id="+id;
		}
		function hasChild(value,appModuleId,appModuleName,appModuleUrl,appId,insert_time,update_time)
		{	
				var url ="<%=path%>/showManager/appModuleAction!getParentId.dhtml?appId=${app_module.appId}";
				$.ajax({
					type:'post',
					dataType:"json",
					url:url,
					success:function(txt){
						var num=0;
						var items=[];
						for(var i = 0;i<txt.length;i++){
							var id = txt[i].parentId.toString();
							if(value==id){
								items.push(txt[i].appModuleName);
								num++;
							}else{
								continue;
							}
						}
						if(num>0){
							$.messager.alert("提示","该模块下有"+num+"个子模块:"+items+"，禁止删除","info");
							}else{
								_del(value,appModuleId,appModuleName,appModuleUrl,appId,insert_time,update_time);
							}
						}
					});
		}
		function _del(id,appModuleId,appModuleName,appModuleUrl,appId,insert_time,update_time){
			//hasChild(id);
			//alert(bool);
			var myself= ${sessionScope.user.id};
				$.messager.confirm("提示","确定要删除吗?",function(r){
					if(r){
						var remark = 'operatormemo='+encodeURIComponent('进行了应用模块删除操作，删除模块信息为：id：')+id+encodeURIComponent(' 模块序列号账号：')+appModuleId+encodeURIComponent(' 模块URL： ')+appModuleUrl+encodeURIComponent('所属应用： ')+encodeURIComponent(appId)+encodeURIComponent('创建时间')+insert_time+encodeURIComponent('更新时间')+update_time+'&funId='+"${app_module.appName}";
						//alert(remark);
						var data='id='+id;
						data =data+'&'+remark;
						$.ajax({
								type:'post',
								url:'<%=path%>/showManager/appModuleAction!deleteByAspect.dhtml',
								data:data,
								success:function(txt){
									if(txt=='success'){
										$.messager.alert('提示','删除成功','info',function(){
											$("#order_result").datagrid("reload");
										});
									}
								}
							});
					}
				});
			
		}
		function _search(flag){
			var data ="app_module.appModuleId="+$.trim($("#search_appModuleId").val())+"&app_module.appModuleName="+encodeURIComponent($.trim($("#search_appModuleName").val()))+"&app_module.appId=${requestScope.app_module.appId}";
			//alert(data);
			if(flag==1){
				data ="app_module.appId=${app_module.appId}";
			}
			var url = "<%=path%>/showManager/appModuleAction!search.dhtml?"+data;
			$('#order_result').datagrid({
						url: url ,  
						singleSelect:true,
						title: $('#query_result').attr('结果'),
						nowrap: false,
						striped: true,
						collapsible:true,
						sortOrder: 'desc',
						remoteSort: false,
						queryParams:"",
						pageNumber: 1, 
						columns:[[
							{field:'id',title:'ID',width:$(this).width() * 0.1,hidden:true,sortable:true},
							{field:'appModuleId',title:'模块ID',width:$(this).width() * 0.1,sortable:true},
							{field:'appModuleName',title:'模块名称',width:$(this).width() * 0.15,sortable:true},
							{field:'appModuleUrl',title:'URL',width:$(this).width() * 0.14,sortable:true},
							{field:'appId',title:'appId',width:$(this).width() * 0.1,hidden:true,sortable:true},
							{field:'parentId',title:'父模块',width:$(this).width() * 0.1,hidden:true,sortable:true},
							{field:'parentName',title:'父模块',width:$(this).width() * 0.1,sortable:true,
							formatter:function(value,tec){
										if(value==""||value==null){
											value = "<font color='red'>一级菜单</font>";
										}
										return value;
                                  }
                            },
							{field:'insertTime',title:'创建时间',width:$(this).width() * 0.13,sortable:true},
							{field:'updateTime',title:'更新时间',width:$(this).width() * 0.13,sortable:true}
						]],
						pagination:true,
						rownumbers:true,
						toolbar:[
							'-',{
								text:'新建',
								iconCls:'icon-add',
								handler:function(){
									_add();
								}
							},'-',{
								text:'修改',
								iconCls:'icon-reload',
								handler:function(){
									 var selected = $("#order_result").datagrid("getSelected");
									 if(selected==null){
									 	$.messager.alert("提示","请选择一条记录！","info");
									 	return;
									 }
									 var id = selected.id;
									 _modify(id);
								}
							},'-',{
								text:'删除',
								iconCls:'icon-no',
								handler:function(){
									 var selected = $("#order_result").datagrid("getSelected");
									 if(selected==null){
									 	$.messager.alert("提示","请选择一条记录！","info");
									 	return;
									 }
									 var id = selected.id;
									 var appModuleId = selected.appModuleId;
									 var appModuleName = selected.appModuleName;
									 var appModuleUrl= selected.appModuleUrl;
									 var appId= selected.appId;
									 var insert_time = selected.insertTime;
									 var update_time = selected.updateTime;
									 
									 hasChild(id,appModuleId,appModuleName,appModuleUrl,appId,insert_time,update_time);
								}
							},'-',{
								text:'所属模块--->${app_module.appName}',
								iconCls:'icon-tip',
								handler:function(){
									 
								}
							}]
					});
		}
		function _searchAll(){
			_search();
		}
				
				
				

		</script>
	</head>

	<body>
	<div class="titlePanel"><h2>应用模块管理&nbsp;&gt;&nbsp;${app_module.appName}</h2>
		<div class="operate-panel operate-form" style="background:none; padding:0;border:none;">
			
				 <label class="page-list">模块ID：</label><input type="text" size="30" id="search_appModuleId" value=""/><label class="page-list">模块名称：</label><input type="text" id ="search_appModuleName" value=""/>&nbsp;&nbsp;&nbsp;&nbsp;
			        &nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:_search()" class="button">搜索</a>
			         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:_search(1)" class="button">搜索全部</a>
		</div>
	</div>
	    <div style="height:67px;"></div>
	
	
		<div id="order_result"></div>
	</body>
</html>
