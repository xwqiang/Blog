<%@ page language="java" pageEncoding="UTF-8"%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<validateResult>
	<c:if test="${validateUserInfo!='yes'}">true</c:if>
	<c:if test="${validateUserInfo=='no'}">false</c:if>
</validateResult>
