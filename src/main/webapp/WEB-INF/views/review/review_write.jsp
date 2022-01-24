<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${contextPath }/assets/css/main.css" />
<style type="text/css">
</style>
<meta charset="utf-8">
<title>리뷰 작성</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	var photo_count = 1; // 사진 파일 수 
	var photo_num = 1; // input 변수 지정하기 위한 수
	
	$(function(){
		$("#photo_count").val(photo_count); /* 페이지 출력 시 사진파일 수를 input[type=number]에 지정하는 기능 */
	})
	
	function load_preview_0(input){/* 대표이미지 프리뷰 */
	
		var file = input.files[0]
		
		if (file != '') { /* 파일이 비어있지 않다면 */
			
			var reader = new FileReader();
			
			reader.readAsDataURL(file);
			reader.onload = function (e) {
				$('#preview_0').attr('src', e.target.result);/* 대표이미지 프리뷰 등록 */
			}
		}
	}
	
	
	function add_file(){/* 사진을 추가할 수 있는 새로운 input과 비어있는 preview를 생성하는 기능 */
		if(photo_count == 10){
			alter("사진은 최대 10장까지 첨부할 수 있습니다.")
		}else{
			var str_photo = "<p id='p_"+photo_num+"'><input type='file' name='review_file_name_"+(photo_num)+"' "
				+ "id='review_file_name_"+(photo_num)+"' onchange='load_preview(review_file_name_"+(photo_num)+", preview_"+photo_num+"); '/>"
				+ "<a href='#p_"+photo_num+"' onClick='delete_photo(p_"+photo_num+");' class='btn'>삭제하기</a></p>"
			var str_preview = "<p id='p_"+photo_num+"' style='margin:2px;'><img id='preview_"+ photo_num +"' "
				+ "style='align:right;' alt='이미지가 없습니다.' src='#'  width='320' height='180'></p>"
			$("#photo_div").append(str_photo);
			$("#preview_div").append(str_preview);
			photo_num++;
			photo_count++;
			$("#photo_count").val(photo_count);
		}
	}
	
	function load_preview(input, preview){/* 파일이 로드되었을 때 비어있는 이미지에 미리보기 이미지 추가 */
		var file1 = input.files[0]
		if(file1 != ''){
			var reader = new FileReader();
			reader.readAsDataURL(file1);
			reader.onload = function(e){
				$(preview).attr('src', e.target.result);
			}
		}
	}
	
	function delete_photo(del){
		console.log("안녕하세요")
		$(this).parent().remove(); 
		photo_count--;
		$(del).remove();
	}
</script>
</head>
<body>
	<jsp:include page="../default/header.jsp"></jsp:include>

		<div id="wrap" style="width:600px; margin: 0 auto;">
			<h1 style="text-align:center;">여행 리뷰 작성</h1><br>
			<form method="post" action="${contextPath }/review/r_writeSave" enctype="multipart/form-data">
				<b>작성자</b>	<input type="text" name="id" value="${ userId }" readonly>
				<br>
				<b>제목</b><input type="text" name="review_title" size="30" placeholder="제목을 입력해 주세요.">
				<br>
				<b>내용</b>
				<textarea style="resize:none;" rows="40" cols="80" placeholder="내용을 입력해 주세요." name="review_content"></textarea>
				<br>
				<div id="preview_div">
      				<img id="preview_0" name="preview_0" src="#" width=320 height=180 alt="대표이미지가 없습니다." />
				</div>
				<hr>
				<div id="photo_div">
					<p>
						<b>대표이미지</b>
						<input type="file" id="review_file_name_0" name="review_file_name_0" onchange="load_preview_0(this);"/>
						<span style="font-size:15px; color: gray;">※사진은 최대 10장까지 등록 가능합니다.</span>
					</p>
				</div>
				
				<div align="right">
					<p>
					이미지 파일 <input type="number" id="photo_count"  name="photo_count" readonly> 장 &emsp;
					<input type="button" value="사진추가" onClick="add_file();">
					</p>
				</div>
				<hr>
				<div align="right">
					<input type="button" value="목록으로" onClick="location.href='${contextPath}/review/review_boardList'"/>
					&emsp;
					<input type="submit" value="등록"/>
				</div>
			</form>
		</div>
	<jsp:include page="../default/footer.jsp"></jsp:include>
</body>
</html>