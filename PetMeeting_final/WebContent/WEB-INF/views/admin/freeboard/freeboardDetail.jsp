<%@page import="com.petmeeting.joy.freeboard.model.FreeboardDto"%>
<%@page import="com.petmeeting.joy.freeboard.model.CommentDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

<%List<CommentDto> cmlist = (List<CommentDto>)request.getAttribute("cmlist");%>
<%FreeboardDto dto = (FreeboardDto)request.getAttribute("dto");%>
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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/admin_resources/css/playboardDetail.css">
</head>
<body>

<div id="right-panel" class="right-panel">
<!--::header part start::-->
	<jsp:include page="/admin_resources/admincss/templates/adminheader.jsp" flush="false"/>
<!-- Header part end-->

<!-- Content -->
<div class="content">
<div class="container">
<div class="mainTitle">자유게시판 상세보기</div>
	<table class="detailTable">
		<tr>
			<th>게시판 유형</th><td>${dto.category }</td>
		</tr>
		<tr>
			<th>제목</th><td>${dto.title }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>
			
			${dto.email }(${dto.nickname })
			</td>
		</tr>
		
		<tr>
			<th>작성일</th><td>${dto.regdate } </td>
		</tr>
		<tr>
			<th>좋아요</th><td>${dto.likecount }</td>
		</tr>
		<tr>
			<th>신고</th><td>${dto.reportcount }&emsp;<button type="button" id="reportResaonBtn" onclick="reportcheck()">신고내역 보기</button></td>
		</tr>
		<tr>
			<td colspan="2" align="center"><input id="deleteBtn" type="button" onclick="golist()" value="목록으로"></td>
		</tr>
	</table>
	
	
</div>
</div>
</div>

<script>

function golist(){
	location.href="adminFreeboardList.do";
}

function reportcheck() {
	
	var seq = "${dto.seq}";
	//alert(seq);
	
 	$.ajax({
			url:"beforereportchk.do",
			type:"get",
			data: "seq=" + seq,
			success:function (data){
				//alert(data);
				if(data != 0){
					var option = "width = 500, height = 500, top = 100, left = 200, location = no, resizeable = no";
					window.open("freeboard_adminreportcheck.do?seq="+${dto.seq}, "report", option);
					
				}else if(data === 0){
					alert("신고 내역이 없습니다.");
				}
				
			},
			error:function(){
				alert("err");
			}			
		});
	
	
};




</script>



</body>
</html>