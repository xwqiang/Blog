<%@ page language="java" pageEncoding="UTF-8"%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<apps>
	<c:forEach items="${app_Module_list}" var="app_module">
	<app_module>
		<id>${app_module.id }</id>
		<appModuleId>${app_module.appModuleId }</appModuleId>
		<appModuleName>${app_module.appModuleName }</appModuleName>
		<appModuleUrl>${app_module.appModuleUrl }</appModuleUrl>
		<parentId>${app_module.parentId }</parentId>
		<parentName>${app_module.parentName }</parentName>
	</app_module>
	</c:forEach>
</apps>
