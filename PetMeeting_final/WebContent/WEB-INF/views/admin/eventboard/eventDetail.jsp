<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pet Meeting - 관리자</title>
 <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	
	<link rel="icon" href="${pageContext.request.contextPath}/common/navbar/img/petmeetingicon.png">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/admin_resources/css/eventboard.css">
</head>
<body>

<div id="right-panel" class="right-panel">
<!--::header part start::-->
	<jsp:include page="/admin_resources/admincss/templates/adminheader.jsp" flush="false"/>
<!-- Header part end-->

	<!-- Content -->
	<div class="content">
		<div class="container">
			<div class="mainTitle">반려동물 행사 상세정보</div>
			
			
			<table class="detailTable">
				<tr>
					<th>행사 명</th>
					<td>${detail.title }</td>
				</tr>
				
				<tr>
					<th>행사 썸네일</th>
					<td><img src="${pageContext.request.contextPath}/eventboardUpload/${detail.filename }" width="300px;"></td>
				</tr>
				
				<tr>
					<th>행사 기간</th>
					<td><fmt:formatDate value="${detail.event_sdate }"  pattern="yyyy년 MM월 dd일"/> ~ 
						<fmt:formatDate value="${detail.event_edate }"  pattern="yyyy년 MM월 dd일"/></td>
				</tr>
				
				<tr>
					<th>행사 장소</th>
					<td>${detail.location } ${detail.location_detail }</td>
				</tr>
				
				<tr>
					<th colspan="2">행사 상세설명</th>
				</tr>
				
				<tr>
					<td colspan="2">
						<div style="width: 100%">
							${detail.content }
						</div>
					</td>
				</tr>
								
			</table>
			
			<div class="buttons">
				<button type="button" id="updateBtn">수정</button>
				<button type="button" id="deleteBtn">삭제</button>
			</div>
		</div>
	</div>

</div>


<script type="text/javascript">
$(function () {
	$("#updateBtn").click(function () {
		location.href="adminEventUpdate.do?seq=${detail.seq }";
	});
	
	$("#deleteBtn").click(function () {
		location.href="adminEventDelete.do?seq=${detail.seq }";
	});
});

</script>


</body>
</html>
    
