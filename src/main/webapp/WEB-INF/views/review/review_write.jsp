<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
   function readURL(input) {
      var file = input.files[0] //파일에 대한 정보
      console.log(file)
      if (file != '') {
         var reader = new FileReader();
         reader.readAsDataURL(file); //파일의 정보를 토대로 파일을 읽고 
         reader.onload = function (e) { // 파일 로드한 값을 표현한다
          //e : 이벤트 안에 result값이 파일의 정보를 가지고 있다.
           $('#preview').attr('src', e.target.result); //target은 실질적인 이미지의 경로이다
          }
      }
  }  
</script>
</head>
<body>review_write.jsp<br>
	<jsp:include page="../default/header.jsp"></jsp:include>
		<div id="wrap" style="width:600px; margin: 0 auto;">
			<h1 style="text-align:center;">review write form</h1><br>
			<form method="post" action="${contextPath }/review/writeSave" enctype="multipart/form-data">
				<%-- <table style="text-align : right;" border="1">
					<tr>
						<th>작성자 : </th> <td style="text-align:left">${loginUser }</td>
					</tr>
					<tr>
						<th>제  목 : </th> <td style="text-align:left;"><input type="text" name="title" size="30" placeholder="제목을 입력해 주세요."></td>
					</tr>
					<tr>
						<th>내 용 : </th> <td><textarea style="resize:none;" rows="15" cols="60" placeholder="내용을 입력해 주세요." ></textarea></td>
					</tr>
				</table> --%>
				<b>작성자 : </b>	<input type="text" name="id" value="soomin" readonly>
				<hr>
				<b>제 목 : </b>	<input type="text" name="review_title" size="30" placeholder="제목을 입력해 주세요.">
				<hr>
				<b>내 용 : </b><br> 
				<textarea style="resize:none;" rows="20" cols="80" placeholder="내용을 입력해 주세요." name="review_content"></textarea>
				<hr>
				<div >
				<b>이미지 첨부</b><br>
				<img style="align:right;" alt="선택된 이미지가 없습니다." src="#" id="preview" width="200" height="150">
				<input type="file" name="review_file_name" onchange="readURL(this)"><!-- onchange="readURL(this)" 이미지를 미리보기 할 수 있음 -->
				<hr>
				</div>
				<div align="right">
				<input type="submit" value="저장">
				<input type="button" value="목록보기" onClick="location.href='${contextPath}/review/review_boardList'">
				</div>
			</form>
		</div>
	<jsp:include page="../default/footer.jsp"></jsp:include>

</body>
</html>