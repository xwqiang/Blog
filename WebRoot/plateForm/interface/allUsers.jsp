<%@ page language="java" pageEncoding="UTF-8"%>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<users>
	<c:forEach items="${userList}" var="user">
		<user>
			<userId>${ user.user_id}</userId>
			<userName>${user.user_name}</userName>
			<userDepartMentId>${uesr.dept_id }</userDepartMentId>
			<roleId>${user.role_id }</roleId>
			<mobile>${user.mobilephone}</mobile>
			<mail>${user.mail }</mail>
			<qq>${user.qq }</qq>
			<useEnable>${user.use_enable}</useEnable>
			<headportraint_url>${user.headportraint_url}</headportraint_url>
		</user>
	</c:forEach>
	
</users>
