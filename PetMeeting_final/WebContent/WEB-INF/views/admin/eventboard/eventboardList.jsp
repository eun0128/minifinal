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
	
	<!-- fullcalendar -->
	<!----------------- CSS------------------->
	<link href='${pageContext.request.contextPath}/admin_resources/fullcalendar/core/main.css' rel='stylesheet' />
	<link href='${pageContext.request.contextPath}/admin_resources/fullcalendar/daygrid/main.css' rel='stylesheet' />
	
	<!----------------- JS------------------->
	<script src='${pageContext.request.contextPath}/admin_resources/fullcalendar/core/main.js'></script>
	<script src='${pageContext.request.contextPath}/admin_resources/fullcalendar/daygrid/main.js'></script>
	<script src='${pageContext.request.contextPath}/admin_resources/fullcalendar/core/locales/ko.js'></script>
	
	
	<link rel="icon" href="${pageContext.request.contextPath}/common/navbar/img/petmeetingicon.png">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/admin_resources/css/eventboard.css">

</head>
<body>

<%
String jsonData = (String)request.getAttribute("jsonData");
%>

<div id="right-panel" class="right-panel">
<!--::header part start::-->
	<jsp:include page="/admin_resources/admincss/templates/adminheader.jsp" flush="false"/>
<!-- Header part end-->

	<!-- Content -->
	<div class="content">
		<div class="container">
			<div class="mainTitle">반려동물 행사 안내 게시판</div>
						
			<div id='calendar'></div>
									
		</div>
	</div>

</div>


<!-- fullCalendar 초기화 :버튼, 한글화  -->
<script>
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');

		var calendar = new FullCalendar.Calendar(calendarEl, {
			plugins : ['dayGrid' ],			
			customButtons: {
				customButton: {
			      text: '행사 등록',
			      click: function() {
			        location.href="adminEventWrite.do";
			      }
				}
			},
			header : {
				left : 'today prev,next',
				center : 'title',
				right : 'customButton'
			},			
			editable : false,
			contentHeight: 730,
			eventLimit: 3,
			locale : 'ko',			
			 <%
			if(!jsonData.equals("")){	
			%>
			events : <%=jsonData%>,
			<%
			 }
			 %>				
			displayEventTime:false,
			eventClick: function(info) {
				var seq = info.event.id;
				location.href="adminEventDetail.do?seq="+seq;
			}
		
	});
		calendar.render();
	});
</script>


</body>
</html>