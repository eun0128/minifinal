<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<title>admin</title>
<link rel="icon" href="${pageContext.request.contextPath}/common/navbar/img/petmeetingicon.png">
   <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	
	<link rel="icon" href="${pageContext.request.contextPath}/common/navbar/img/petmeetingicon.png">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/admin_resources/css/admin_common.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/admin_resources/css/fundingboard.css">
     
    <!-- include libraries(jQuery, bootstrap) summernote -->
	<!-- <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet"> -->
	<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
	<!-- include summernote css/js-->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css" rel="stylesheet">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
	<!-- include summernote-ko-KR -->
	<script src="fundingboard_resources/js/summernote-ko-KR.js"></script>
</head>
<body>

<div id="right-panel" class="right-panel">
	<!--::header part start::-->
		<jsp:include page="/admin_resources/admincss/templates/adminheader.jsp" flush="false"/>
	<!-- Header part end-->
<!-- Content -->
<div class="content">
<div class="container">
<div class="mainTitle"><img class="advericon" src="admin_resources/img/advertising.png">공지</div>

<form id="frm">
<input type="hidden" name="email" value="${login.email }">
	<table class="WriteTable">
		<tr>
			<th>공지유형</th>
			<td>
				<select id="selected" name="category">
					<option value="전체 공지">전체 공지</option>
					<option value="소모임 공지">소모임 공지</option>
					<option value="자유게시판 공지">자유게시판 공지</option>
					<option value="후원 공지">후원 공지</option>
					<option value="굿즈샵 공지">굿즈샵 공지</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input style="width: 400px;" type="text" placeholder="글 제목" name="title"></td>
		</tr>
		<tr>
			<th colspan="2">내용</th>
		</tr>
		
		<tr>
			<td colspan="2"><textarea id="summernote" name="content"></textarea></td>
		</tr>
		
		<tr>
			<td colspan="2" align="center">
				<input type="button" id="subBtn" value="등록">
			</td>
		</tr>
	
	</table>
</form>

</div>
</div>
</div>

<script type="text/javascript">

$("#subBtn").click(function() {
	//alert("글쓰기");
	$("#frm").attr({"action":"noticeWriteAf.do","method":"POST"}).submit();
});

$(document).ready(function() {
	  $('#summernote').summernote({
	    	placeholder: 'content',
	        minHeight: 370,
	        maxHeight: null,
	        focus: true, 
	        lang : 'ko-KR',
	        callbacks: { // 콜백을 사용
              // 이미지를 업로드할 경우 이벤트를 발생
			    onImageUpload: function(files, editor, welEditable) {
			    	  for (var i = files.length - 1; i >= 0; i--) {
			              sendFile(files[i], this);

			            }
	        		}
	        	}
	  });
});

function sendFile(file, editor) {
    // 파일 전송을 위한 폼생성
		data = new FormData();
	    data.append("file", file);
	    $.ajax({ // ajax를 통해 파일 업로드 처리
	        data : data,
	        type : "POST",
	        url : "img.do",
	        cache : false,
	        contentType : false,
	        enctype: 'multipart/form-data',
	        processData : false,
	        success : function(data) { // 처리가 성공할 경우
            // 에디터에 이미지 출력
	        	$(editor).summernote('editor.insertImage', data);
	        },
	        error : function () {
	        	alert("error");
			}
	    });
}
</script>


</body>
</html>