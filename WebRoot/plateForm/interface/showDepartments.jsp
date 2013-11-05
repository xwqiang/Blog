<%@ page language="java" pageEncoding="UTF-8"%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<departments>
	<c:forEach items="${departmentsList}" var="depart">
	<department>
		<id>${depart.dept_id }</id>
		<dept_name>${depart.dept_name }</dept_name>
	</department>
	</c:forEach>
</departments>
