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
		<meta http-equiv="Content-Type" content="text/html; charset=utf8">
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
		<script type="text/javascript" src="<%=path%>/js/easyui/locale/easyui-lang-zh_CN.js"></script>
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
		
		function _search(flag){
			var data ="remark.remark_type="+encodeURIComponent($.trim($("#search_remark_type").val()))+"&remark.operator="+encodeURIComponent($.trim($("#search_operator").val()))+"&remark.operator_ip="+encodeURIComponent($.trim($("#search_operator_ip").val()))+"&remark.start_time="+$("#search_start_time").datetimebox('getValue')+"&remark.end_time="+$("#search_end_time").datetimebox('getValue');
			if(flag==1){
				data ="";
			}
			var url = "<%=path%>/showManager/logAction!search.dhtml?"+data;
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
						showFooter:true,
						pageNumber: 1, 
						columns:[[
							{field:'id',title:'ID',width:$(this).width() * 0.05,hidden:true,sortable:true},
							{field:'remark_type',title:'日志类型',width:$(this).width() * 0.05,sortable:true},
							{field:'operator',title:'操作者',width:$(this).width() * 0.1,sortable:true},
							{field:'insert_time',title:'日志创建时间',width:$(this).width() * 0.08,sortable:true},
							{field:'operator_ip',title:'操作者IP',width:$(this).width() * 0.08,sortable:true},
							{field:'content',title:'日志内容',width:$(this).width() * 0.6,sortable:true}
						]],
						pagination:true,
						rownumbers:true,
						toolbar:[
							'-',{
								text:'日志管理',
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
		 <div class="operate-panel operate-form">
	<div class="panel-group">
	
	 <label class="page-list">日志类型：</label><input type="text" size="30" id="search_remark_type" value=""/><label class="page-list">操作用户：</label><input type="text" id ="search_operator" value=""/><label class="page-list">来自IP：</label><input type="text" size="30" id="search_operator_ip" value=""/><label class="page-list">开始时间：</label><input type="text" size="30" id="search_start_time" value=""  class="easyui-datetimebox" /><label class="page-list">结束时间：</label><input type="text" size="30" id="search_end_time" value="" class="easyui-datetimebox" showSeconds="true"/>&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:_search()" class="button">搜索</a>
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:_search(1)" class="button">搜索全部</a>
     
	 </div>
    <div class="clear"></div>
</div>
	
	
		<div id="order_result"></div>
	</body>
</html>
