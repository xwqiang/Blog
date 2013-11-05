<%@ page language="java" pageEncoding="UTF-8"%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<validateResult>
	<c:if test="${tempModel!=null}">true</c:if>
	<c:if test="${tempModel==null}">false</c:if>
</validateResult>
