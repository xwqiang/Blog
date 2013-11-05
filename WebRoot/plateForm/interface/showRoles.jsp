<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<?xml version="1.0" encoding="UTF-8" ?>
<roles>
	<c:forEach items="${roleList}" var="role">
		<role>
			<id>${role.id }</id>
			<role_name>${role.role_name }</role_name>
		</role>
	</c:forEach>
</roles>
