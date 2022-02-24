<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	function manage_admin(){
		$.ajax({
			url : "update_admin",
			type : "POST",
			dataType : "json",
			data : paramData,
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				alert("댓글이 성공적으로 수정되었습니다.");
				replyData();
			},
			error : function() {
				console.log();
				alert("문제 발생!")
			}
		});
	}
</script>
		<link rel="stylesheet" href="${contextPath }/assets/css/main.css" />
</head>
<body>
<c:import url="../default/header.jsp"/>
<table border="1">
	<tr>
		<td>관리자 여부</td> <td>id</td> <td>pw</td> <td>email</td> <td>phoneNumber</td>
	</tr>
	<c:forEach items="${memberList }" var="list">
	<tr>
		<th> 
			<c:if test="${list.admin == 1 }">
				<input type="checkbox" id="admin_check" checked onchange="manage_admin();">
			</c:if>
			<c:if test="${list.admin == 0 }">
				<input type="checkbox" id="admin_check" onchange="manage_admin();">
			</c:if>
		</th>
		<th>
			<a href="${contextPath }/member/memberView?id=${list.id }">${list.id }</a>
		</th> <th>${list.pw }</th> <th>${list.email }</th> <th>${list.phoneNumber }</th>
	</tr>
	</c:forEach>
</table>
<c:import url="../default/footer.jsp"/>


</body>
</html>