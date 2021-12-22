<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행 후기 게시글</title>
<style type="text/css">
</style>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
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

	// 댓글 수정 함수
	function replyUpdate(r_reply_no, writeDate, id, r_reply_content) {
		console.log(r_reply_no);
		console.log(writeDate);
		console.log(id);
		console.log(r_reply_content);
		var htmls = "";
		
		htmls += '<div align="left" id="nid' + r_reply_no + '">';
		htmls += '<b>작성자</b> : ' + id + '&emsp;';
		htmls += '<b>작성일</b> : ' + writeDate + '<br>';
		htmls += '<textarea name="editContent" id="editContent" row="5" cols="30">' + r_reply_content + '</textarea><br>';
		htmls += '<a href="#" onclick="replyUpdateSave(' + r_reply_no + ', \'' + id + '\')">저장</a>';
		htmls += '&emsp; &emsp;'
		htmls += '<a href="#" onclick="replyData()">취소</a>';
		htmls += '<hr>'
		htmls += '</div>';
		$('#rid' + r_reply_no).replaceWith(htmls);
		$('#rid' + r_reply_no + '#editContent').focus();
	}
	
	// 댓글 수정을 저장하는 함수
	function replyUpdateSave(r_reply_no, id) {
		var replyEditContent = $('#editContent').val();
		var paramData = JSON.stringify({"content":replyEditContent,"rid":r_reply_no});
		console.log('replyUpdateSave 실행')
		$.ajax({
			url : "updateReply",
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
	
	// 댓글 삭제 함수
	function replyDelete(r_reply_no) {
		console.log(r_reply_no)
		var deletePrint = confirm("정말 삭제하시겠습니까?");
		if(deletePrint == true) {
			var paramData = JSON.stringify({"rid":r_reply_no});
			$.ajax({
				url : "deleteReply",
				type : "POST",
				dataType : "json",
				data : paramData,
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					alert('삭제되었습니다.');
					replyData();
				},
				error : function() {
					alert('문제 발생')
				}
			})
		} else {
			return false;
		}
	}
	
	// 댓글 작성 함수
   	function replyAdd() {
		console.log('replyAdd 실행')
		let form = {};
		let arr = $("#frm").serializeArray()
		for (i = 0; i < arr.length; i++) {
			form[arr[i].name] = arr[i].value;
		}
		console.log('반복문 실행')
		$.ajax({
			url : "replyAdd",
			type : "POST",
			dataType : "json",
			data : JSON.stringify(form),
			contentType : "application/json;charset=utf-8",
			success : function(data) {
				alert("성공적으로 댓글이 달렸습니다.");
				$("#repId").val("")
				$("#repContent").val("")
				location.reload();
				replyData();
			},
			error : function() {
				console.log();
				alert("문제 발생!")
			}
		});
	}
   	
   	// 댓글 목록 함수
	function replyData(){
	   var sessId = '<%=(String)session.getAttribute("userId")%>';
	   var rid = ${contentData.review_no};
	      $.ajax({
	         url:"replyData/"+${contentData.review_no}, type:"GET", 
	         dataType:"json",
	         success: function(rep){
	            var htmls = ""
	            if(rep.length < 1) {
	            	htmls += '등록된 댓글이 없습니다.';
	            } else {
	            	// 맨 아래 <div id="reply"> 에 반복적으로 보여지는 댓글 양식
	            	rep.forEach(function(data){
	            		let tid = data.id
	            		let date = new Date(data.r_reply_date)
	 	               	let writeDate = date.getFullYear()+"년"+(date.getMonth()+1)+"월"
	 	               	writeDate += date.getDate()+"일 "+date.getHours()+"시"
	 	               	writeDate += date.getMinutes()+"분"+date.getSeconds()+"초";
	 	               	htmls += '<div align="left" id="rid' + data.r_reply_no + '">';
	 	               	if(sessId == data.id) {
		 	               	htmls += '<b>작성자</b> : ' + data.id + '&emsp;';
	 	               	} else {
	 	               		// 현재 로그인 중인 회원과 댓글 작성자가 다르면, 그 댓글의 작성자는 <a href> 처리 되어 클릭 시 insertTag 함수로 넘어감
	 	               		htmls += '<b>작성자</b> : <a href="#" onclick="insertTag(' + data.r_reply_no + ',\'' + data.id + '\')">' + data.id + '</a>&emsp;'; 
	 	               	}
	 	               	htmls += '<b>작성일</b> : ' + writeDate + '<br>';
	 	               	if(data.r_reply_tag != null) {
	 	               		htmls += '<b>@' + data.r_reply_tag + '</b>'
	 	               	}
	 	               	htmls += '<b> : </b>' + data.r_reply_content + '<br>';
	 	              	
	 	               	// 현재 로그인 중인 회원과 댓글의 작성자가 같을 시 수정(replyUpdate), 삭제(replyDelete) 버튼이 나타남
 						if(sessId == data.id) {
	 						htmls += '<button type="button" onclick="replyUpdate(' + data.r_reply_no + ',\'' + writeDate + '\',\'' + data.id + '\',\'' + data.r_reply_content + '\')">수정</button>';
		 	               	htmls += '<button type="button" onclick="replyDelete(' + data.r_reply_no  + ')">삭제</button><br><hr></div>'
 						} else {
 							htmls += '<br><hr></div>';
 						}
 	            	})
	            }
	            $("#reply").html(htmls)
	         },error:function(){
	            alert('데이터를 가져올 수 없습니다')
	         }
	      });
	}
	
	// 댓글 작성자 태그 함수
	function insertTag(r_reply_no, id) {
		var tagId = id;
		$("#tagId").val(tagId);
	}
	
	// 게시글 넘버, 현재 세션 아이디
	var review_no = ${contentData.review_no};
	var id = '<%=(String)session.getAttribute("userId")%>';

	// 좋아요 체크 함수
	function updateLike(){
		$.ajax({
			type : "POST",
			url : "updateLike",
			dataType : "json",
			data : {'review_no' : review_no, 'id' : id},
			success : function(likeCheck){
				if(likeCheck == 0){
					alert("이 게시글을 좋아합니다.");
					location.reload();
				} else if(likeCheck == 1){
					alert("좋아요를 취소하였습니다.")
					location.reload();
				}
			},
			error : function(){
				alert("통신 에러");
			}
		});
	}
	
	// 비회원 용 좋아요 버튼(로그인 폼으로 보내는 역할만 수행)
	function fakeLike(){
		alert("로그인이 필요한 서비스입니다.")
		document.location.href="${contextPath}/member/loginForm";
	}
	
</script>
</head>
<body onload="replyData()">
	<c:import url="../default/header.jsp" />
	<div class="wrap" align="center">
	
		<!-- 게시글 세부 내용 -->
		<table border="1">
			<tr>
				<th>글번호</th>
				<td>${ contentData.review_no }</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${ contentData.id }</td>
			</tr>
			<tr>
				<th>글제목</th>
				<td>${ contentData.review_title }</td>
				<th>작성시간</th>
				<td>${ contentData.review_date }</td>
				<th>조회수</th>
				<td>${ contentData.review_hit_num }</td>
			</tr>
			<tr>
				<th>글 내용</th>
				<td>${ contentData.review_content }</td>
			</tr>
			
			<!-- 좋아요 -->
			<tr>
				<td>
				<c:choose>
					<c:when test="${ userId == null }">
						<div>
							<button type="button" onclick="fakeLike();">좋아요</button>
							<img src="${contextPath}/resources/img/like_on.png" height="25" width="25"> &nbsp; ${contentData.review_like}
						</div>
					</c:when>
					<c:otherwise>
						<div>
							<button type="button" onclick="updateLike();" id="like_btn" value="">좋아요</button>
							<img src="${contextPath}/resources/img/like_on.png" height="25" width="25"> &nbsp; ${contentData.review_like}
						</div>
					</c:otherwise>
				</c:choose>
				</td>
			</tr>
			
			<tr>
				<td>
					<c:if test="${ contentData.review_file_name != 'nan' }">
						<img width="200px" height="150px" id="preview"
							src="${contextPath}/review/download?review_file_name=${contentData.review_file_name}">
					</c:if>
					<c:if test="${contentData.review_file_name == 'nan' }">
						<img style="align: right;" alt="선택된 이미지가 없습니다." src=""
							id="preview" width="200" height="150">
					</c:if>
					</td>
				<td>
					<br>
					<input type="button" value="modify" onclick="location.href='${contextPath}/review/review_modify?review_no=${contentData.review_no }'">
					<input type="button" value="목록으로" onclick="location.href='${contextPath}/review/review_boardList'">
				</td>
			</tr>
		</table>
		<br>
		<hr>
		<br>
		
		<!-- 댓글 수 -->
		<table border="1">
			<tr>
				<th>이 게시글에 달린 댓글 [&nbsp;<b>${ contentData.r_reply_count }</b>&nbsp;]</th>
			</tr>
		</table>
		
		<!-- 댓글 입력 창 -->
		<form id="frm">
			<table border="1">
				<tr>
					<td><input type="hidden" name="write_no" value="${contentData.review_no}">
					<c:choose>
						<c:when test="${ userId == null }">
							<b>로그인 한 회원만 댓글을 작성할 수 있습니다.</b>
							<a href="${contextPath }/member/loginForm">로그인</a>
						</c:when>
						<c:otherwise>
							<b>댓글 작성자</b><input type="text" id="repId" name="replyId" value="${ userId }" readonly />
							<br>
							<b>태그할 사람<input type="text" id="tagId" name="tagId" value="" readonly /></b>
							<br>
							<textarea id="repContent" name="replyContent" rows="5" cols="30"></textarea><br>
							<button type="button" onclick='replyAdd()'>댓글</button>
						</c:otherwise>
					</c:choose>
				</tr>
			</table>
		</form>
		<hr>
		
		<!-- 댓글 목록 -->
		<div id="reply"></div>
	</div>
	<c:import url="../default/footer.jsp" />
</body>
</html>