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
			window.location.href ="<%=path%>/showManager/userAction!add.dhtml";
		}
		function _modify(id){
			window.location.href ="<%=path%>/showManager/userAction!mod.dhtml?uid="+id;
		}
		function _del(id,user_id,user_name,dept_name,role_name,mobilephone,mail,qq,use_enable,insert_time,update_time){
			var myself= ${sessionScope.user.id};
			if(id ==myself){//changed to value in session
				$.messager.alert("提示","无法删除自己！","info");
			}else{
				$.messager.confirm("提示","确定要删除吗?",function(r){
					if(r){
						var remark = 'operatormemo='+encodeURIComponent('进行了用户删除操作，删除用户信息为：用户id：')+id+encodeURIComponent(' 用户账号：')+user_id+encodeURIComponent(' 用户姓名： ')+user_name+encodeURIComponent('用户角色： ')+encodeURIComponent(role_name)+encodeURIComponent(' 用户部门：')+encodeURIComponent(dept_name)+encodeURIComponent(' 用户手机：')+mobilephone+encodeURIComponent('用户邮箱：')+mail+encodeURIComponent('用户QQ：')+qq+encodeURIComponent('创建时间')+insert_time+encodeURIComponent('更新时间')+update_time+encodeURIComponent('员工状态：')+encodeURIComponent(use_enable)+'&funId='+encodeURIComponent('人员管理');
						var data='uid='+id;
						data =data+'&'+remark;
						$.ajax({
								type:'post',
								url:'<%=path%>/showManager/userAction!deleteByAspect.dhtml',
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
		}
		function _search(flag){
			var data ="user.user_id="+$.trim($("#search_id").val())+"&user.user_name="+encodeURIComponent($.trim($("#search_name").val()))+"&user.dept_id="+$.trim($("#search_dept").val())+"&user.role_id="+$.trim($("#search_role").val())+"&user.use_enable="+$.trim($("#search_status").val());
			if(flag==1){
				data ="";
			}
			var url = "<%=path%>/showManager/userAction!search.dhtml?"+data;
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
							{field:'id',title:'ID',width:$(this).width() * 0.05,hidden:true,sortable:true},
							{field:'user_id',title:'账号',width:$(this).width() * 0.05,sortable:true},
							{field:'user_name',title:'用户姓名',width:$(this).width() * 0.1,sortable:true},
							{field:'dept_name',title:'部门',width:$(this).width() * 0.08,sortable:true},
							{field:'role_name',title:'角色',width:$(this).width() * 0.08,sortable:true},
							{field:'mobilephone',title:'电话',width:$(this).width() * 0.1,sortable:true},
							{field:'mail',title:'邮箱',width:$(this).width() * 0.1,sortable:true},
							{field:'qq',title:'QQ',width:$(this).width() * 0.08,sortable:true},
							{field:'use_enable',title:'员工状态',width:$(this).width() * 0.05,sortable:true,
								formatter:function(value, tec) {
									var res = "未激活";
									 if(value!='0'){
										res ='激活';
									}
									 return res;
								}
							},
							{field:'insert_time',title:'创建时间',width:$(this).width() * 0.15,sortable:true},
							{field:'update_time',title:'更新时间',width:$(this).width() * 0.15,sortable:true}
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
									 var user_id = selected.user_id;
									 var user_name = selected.user_name;
									 var dept_name = selected.dept_name;
									 var role_name= selected.role_name;
									 var mobilephone= selected.mobilephone;
									 var mail = selected.mail;
									 var qq = selected.qq;
									 var use_enable= selected.use_enable;
									 var insert_time = selected.insert_time;
									 var update_time = selected.update_time;
									 
									 _del(id,user_id,user_name,dept_name,role_name,mobilephone,mail,qq,use_enable,insert_time,update_time);
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
	
	<div class="titlePanel"><h2>用户管理</h2>
		 <div class="operate-panel operate-form" style="background:none; padding:0;border:none;">
		
		 <label class="page-list">登录账号：</label><input type="text" size="30" id="search_id" value="${requestScope.user.user_id }"/><label class="page-list">用户姓名：</label><input type="text" id ="search_name" value="${requestScope.user.user_name }"/> 
		 <label class="page-list">部门：</label>
		 <select id="search_dept">
				 <option value="">----请选择部门----</option>
	              <c:forEach items="${deptList}" var="dept">
						<option value="${dept.dept_id }">
							${dept.dept_name}
						</option>
					</c:forEach>
	      </select>
	      <label class="page-list">用户角色：</label>
	      <select id="search_role">
	      			<option value="0">----请选择角色----</option>
	              <c:forEach items="${roleList}" var="role">
						<option value="${role.id }">
							${role.role_name}
						</option>
					</c:forEach>
	        </select>
	      <label class="page-list">员工状态：</label>
	      <select name="search_status" id = "search_status">
	      		<option value="-1">----请选择员工状态----</option>
	             <option value="0">未激活</option>
	             <option value="1">激活</option>
	       </select>
	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:_search()" class="button">搜索</a>
	         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:_search(1)" class="button">搜索全部</a>
	     
	  
	</div>
</div>
	<div style="height:65px;"></div>
	
		<div id="order_result"></div>
	</body>
</html>
