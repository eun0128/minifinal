<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="icon" href="${pageContext.request.contextPath}/common/navbar/img/petmeetingicon.png">
<link rel="stylesheet" href="${pageContext.request.contextPath}/admin_resources/css/admin_common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/admin_resources/css/fundingboardDetail.css">
</head>
<body>
<div id="right-panel" class="right-panel">
	<!--::header part start::-->
		<jsp:include page="/admin_resources/admincss/templates/adminheader.jsp" flush="false"/>
	<!-- Header part end-->

<!-- Content -->
<div class="content">
<div class="container">
<div class="mainTitle"><a href="#none">공지 상세보기</a></div>

<form id="frm">
<input type="hidden" id="seq" name="seq" value="${dto.seq }">
	<table class="detailTable">
		<tr>
			<th>제목</th>
			<td>${dto.title }</td>
		</tr>
		<tr>
			<th>공지유형</th>
			<td>${dto.category }</td>
		</tr>
		<tr>
			<th>등록일</th>
			<td><fmt:formatDate value="${dto.regdate }"  pattern="yyyy-MM-dd HH:mm:ss"/> </td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${dto.readcount }</td>
		</tr>
		<tr>
			<th colspan="2">내용</th>
		</tr>
		<tr>
			<td colspan="2">${dto.content }</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" id="delBtn2" value="삭제">
				<input type="button" id="upBtn2" value="수정">
				<input type="button" id="listBtn" value="목록" onclick="location.href='noticeList.do'">
			</td>
		</tr>
	</table>
	

</form>

</div>
</div>
</div>

<script type="text/javascript">
$("#delBtn2").click(function() {
	if (confirm("삭제하시겠습니까?") == true){    //확인
		location.href="noticeDelete.do?seq="+$("#seq").val();
	}else{   //취소
	    return;
	}
});

$("#upBtn2").click(function() {
	$("#frm").attr({"action":"noticeUpdate.do","method":"POST"}).submit();
});

</script>

</body>
</html>