<%@page import="com.petmeeting.joy.funding.util.DateUtil"%>
<%@page import="com.petmeeting.joy.funding.model.FundingDto"%>
<%@page import="java.util.List"%>
<%@page import="java.io.IOException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.Reader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetMeeting-funding</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/admin_resources/css/noticeboard.css">
<link rel="icon" href="${pageContext.request.contextPath}/common/navbar/img/petmeetingicon.png">
</head>
<body>

 <!--::header part start::-->
 <header class="header_area">
 	<jsp:include page="/common/navbar/templates/header.jsp" flush="false"/>
 </header>
 <!-- Header part end-->
 
	<!-- 게시판 소개 부분 -->
  	<div class="container">
   		<div class="mainTitle">                                     
        <span id="mainTitle-petmeeting">PetMeeting</span>
        <span id="mainTitle-boardname"><img src="${pageContext.request.contextPath}/common/img/megaphone.png" width="60px">&nbsp;공지사항</span>
        <span id="mainTitle-info">펫미팅에서 알립니다!</span>                                                 
       </div>
	 </div>
 
<div class="container">
<form id="frm" class="nofrm">
	<div class="searchdiv">
		<select id="selected" name="f_categorys" onchange="selec()">
			<option value=""<c:if test="${f_categorys == '' }">selected</c:if>>구분</option>
			<option value="전체 공지"<c:if test="${f_categorys == '전체 공지' }">selected</c:if>>전체 공지</option>
			<option value="소모임 공지"<c:if test="${f_categorys == '소모임 공지' }">selected</c:if>>소모임 공지</option>
			<option value="자유게시판 공지"<c:if test="${f_categorys == '자유게시판 공지' }">selected</c:if>>자유게시판 공지</option>
			<option value="후원 공지"<c:if test="${f_categorys == '후원 공지' }">selected</c:if>>후원 공지</option>
			<option value="굿즈샵 공지"<c:if test="${f_categorys == '굿즈샵 공지' }">selected</c:if>>굿즈샵 공지</option>
		</select>
		
		<input type="text" name="f_keyword" id="search_title" placeholder="제목" <c:if test="${f_keyword != null }">value='${f_keyword }'</c:if>> 
		<input type="button" id="searchBtn" class="search-btn">
	</div>
	
	<div class="totalcount">
		전체<span id="num">${totalRecordCount }</span>
	</div>
	<table class="noticeTable">
		<thead>
			<tr>
				<th>No.</th>
				<th>구분</th>
				<th>제목</th>
				<th>공지일</th>
				<th>조회수</th>
			</tr>
		</thead>
		
		<tbody>
			<c:if test="${empty list }">
			<tr>
				<td colspan="5" align="center">해당 공지가 없습니다.</td>
			</tr>
			</c:if>
			<c:forEach items="${list }" var="list" varStatus="vs">
			<tr>
				<td>${vs.count }</td>
				<td>${list.category }</td>
				<td><a style="color:black" class="underline" href="noticeboardDetail.do?seq=${list.seq }">${list.title }</a></td>
				<td><fmt:formatDate value="${list.regdate }" pattern="yyyy-MM-dd"/></td>
				<td>${list.readcount }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>

	<input type="hidden" name="pageNumber" id="_pageNumber" value="${(empty pageNumber)?0:pageNumber }">
	<input type="hidden" name="recordCountPerPage" id="_recordCountPerPage" value="${(empty recordCountPerPage)?0:recordCountPerPage }">
</form>
	<!-- 페이징 -->
	<div id="paging_wrap">
		<jsp:include page="/WEB-INF/views/notice/paging.jsp" flush="false">
			<jsp:param  name="pageNumber" value="${pageNumber }"/>
			<jsp:param  name="totalRecordCount" value="${totalRecordCount }"/>
			<jsp:param  name="pageCountPerScreen" value="${pageCountPerScreen }"/>
			<jsp:param  name="recordCountPerPage" value="${recordCountPerPage }"/>
		</jsp:include>
	</div>
</div>

<!--::footer part start::-->    
	<jsp:include page="/common/navbar/templates/footer.jsp" flush="false"/>   
<!-- footer part end-->

<script type="text/javascript">
function selec() {
	$("#_pageNumber").val(0);
	$("#frm").attr({"action":"noticeboard.do","method":"post"}).submit();
}

$("#searchBtn").click(function() {
	$("#_pageNumber").val(0);
	$("#frm").attr({"action":"noticeboard.do","method":"post"}).submit();	
}); 

/*페이징 번호*/
function goPage( pageNumber ) {
	//alert(pageNumber);
	$("#_pageNumber").val(pageNumber);
	$("#frm").attr({"action":"noticeboard.do","method":"post"}).submit();
}


</script>
</body>
</html>