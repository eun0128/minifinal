<%@page import="java.util.List"%>
<%@page import="com.petmeeting.joy.freeboard.model.FreeboardDto"%>
<%@page import="com.petmeeting.joy.freeboard.model.ReportDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetMeeting</title>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/admin_resources/css/reportReason.css?after">
</head>
<body>


<%-- <%
	ReportDto reportdto = (ReportDto)request.getAttribute("_reportform");
%> --%>
<%
	FreeboardDto dto = (FreeboardDto)request.getAttribute("dto");
%>

<%
	List<ReportDto> list = (List<ReportDto>)request.getAttribute("reportform");
%>



<div class="mainTitle">
<img src="${pageContext.request.contextPath}/playboard_resources/img/siren.png" width="30px" height="30px" style="vertical-align: sub">신고내역
</div>

<div class="reasonWrap">



<form id="boardReportDeleteFrm">
	<input type="hidden" name="seq">
	<input type="hidden" name="board_seq" value="${board_seq }">
	<input type="hidden" name="board_code" value="${board_code }">
</form>

		<%	for(int i = 0; i < list.size(); i++) { 
  			ReportDto fb = list.get(i); %>
  			
  			
		<table class="reasonTable">
		
		
		
		
		
		
				<th>신고자</th>
				<td><%=fb.getEmail() %></td>
			</tr>
			<tr>
				<th>신고 사유</th>
				<td>
					<%=fb.getReason() %>
				</td>
			</tr>
		</table>

		<%} %>


</div>







</body>
</html>