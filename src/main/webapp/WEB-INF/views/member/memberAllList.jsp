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
	$()
	/* function으로 일반회원 페이지 출력하는 기능, 관리자 페이지 출력하는 기능 구현 */
	function memberInfo(){
		$("#admin_table").attr('style', 'display:none;');
		$("#member_table").removeAttr('style')
	}
	function adminInfo(){
		$("#member_table").attr('style', 'display:none;');
		$("#admin_table").removeAttr('style')
	}
	/* function updateAdmin(){
		$.ajax({
			url : "updateAdmin",
			type : "POST",
			dataType : "json",
			data : {},
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
	} */
</script>
		<link rel="stylesheet" href="${contextPath }/assets/css/main.css" />
</head>
<body>
<c:import url="../default/header.jsp"/>
<div>
	<input type="button" value="일반회원" onclick="memberInfo();">
	<input type="button" value="관리자" onclick="adminInfo();">	
</div>
<div id="admin_table" style="display:none;">
	<h1><b>관리자 테이블</b></h1>
	<table border="1">
		<tr>
			<td>id</td> <td>pw</td> <td>email</td> <td>phoneNumber</td>
		</tr>
		<c:forEach items="${adminList }" var="list"><!-- 현재 모델이 아니기때문에 못불러오고있다. -->
		<tr>
			<th>
				<a href="${contextPath }/member/memberView?id=${list.id }">${list.id }</a>
			</th> <th>${list.pw }</th> <th>${list.email }</th> <th>${list.phoneNumber }</th>
		</tr>
		</c:forEach>
	</table>
</div>
<div id="member_table">
	<h1><b>일반회원 테이블</b></h1>
	<table border="1">
		<tr>
			<td>id</td> <td>pw</td> <td>email</td> <td>phoneNumber</td>
		</tr>
		<c:forEach items="${memberList }" var="list"><!-- 현재 모델이 아니기때문에 못불러오고있다. -->
		<tr>
			<th>
				<a href="${contextPath }/member/memberView?id=${list.id }">${list.id }</a>
			</th> <th>${list.pw }</th> <th>${list.email }</th> <th>${list.phoneNumber }</th>
		</tr>
		</c:forEach>
	</table>
</div>
<c:import url="../default/footer.jsp"/>

</body>
</html>