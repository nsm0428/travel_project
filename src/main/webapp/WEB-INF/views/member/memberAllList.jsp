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
	
	/* function으로 일반회원 페이지 출력하는 기능, 관리자 페이지 출력하는 기능 구현 */
	/* function memberInfo(){
		$.ajax({
			url : "getMemberInfo",
			type : "GET",
			dataType : "json",
			success : function(data){
				alert("일반회원 목록 불러오기 성공")
			},
			eroor : function(){
				alert("일반회원 목록 불러오기 실패")
			}
			
		})
	}
	function adminInfo(){
		$.ajax({
			url : "getAdminInfo",
			type : "GET",
			dataType : "json",
			success : function(data){
				alert("관리자 목록 불러오기 성공")
			},
			eroor : function(){
				alert("관리자 목록 불러오기 실패")
			}
			
		})
	}
	 */
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
<%-- <c:if test="${ }"> --%>
<div id="member_table">
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
<%-- </c:if> --%>
</div>
<c:import url="../default/footer.jsp"/>


</body>
</html>