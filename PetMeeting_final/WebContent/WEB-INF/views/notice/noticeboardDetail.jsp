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
<link rel="stylesheet" href="${pageContext.request.contextPath}/fundingboard_resources/css/fundingboard.css">
<!-- 슬라이드 화살표 -->
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="icon" href="${pageContext.request.contextPath}/common/navbar/img/petmeetingicon.png">
</head>
<body>

 <!--::header part start::-->
 <header class="header_area">
 	<jsp:include page="/common/navbar/templates/header.jsp" flush="false"/>
 </header>
 <!-- Header part end-->

	<div class="container">
		<div class="notice">
			공지사항
		</div>
		
		<div class="noticeTitle">
			${dto.title }
		</div>
		
		<div class="leftinfo">
			<div class="noticeCa">
				${dto.category }
			</div>
			<div class="noticeDate">
				<fmt:formatDate value="${dto.regdate }" pattern="YYYY.MM.dd HH:mm:ss"/>	
			</div>
			<div class="noticeRead">
				조회수 : ${dto.readcount }
			</div>
		</div>
		
		<div class="noticecontent">
			${dto.content }
		</div>
		
		<div class="noticeBtn">
			<input id="noticeListBtn" type="button" value="목록" onclick="location.href='noticeboard.do'">
		</div>
	</div>
	

<!--::footer part start::-->    
	<jsp:include page="/common/navbar/templates/footer.jsp" flush="false"/>   
<!-- footer part end-->	
</body>
</html>