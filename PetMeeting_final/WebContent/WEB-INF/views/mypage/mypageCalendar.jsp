<%@page import="com.petmeeting.joy.playboard.model.PlayboardDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%!public String dot3(String msg){
	String str = "";
	if(msg.length() >= 17){
		str = msg.substring(0,15);	// 0에서 9까지
		str += "...";
	}else{
		str = msg.trim();
	}
	return str;
}%>
<!DOCTYPE html>
<html>
<head>
<title>마이페이지 - 나의 일정</title>
<!----------------- CSS------------------->
<link href='mypage_resources/mypage_s/fullcalendar/core/main.css' rel='stylesheet' />
<link href='mypage_resources/mypage_s/fullcalendar/daygrid/main.css' rel='stylesheet' />

<!----------------- JS------------------->
<script src='mypage_resources/mypage_s/fullcalendar/core/main.js'></script>
<script src='mypage_resources/mypage_s/fullcalendar/daygrid/main.js'></script>
<script src='mypage_resources/mypage_s/fullcalendar/core/locales/ko.js'></script>


<%
	//Data를 넣기 위해 json 생성
	List<PlayboardDto> joinlist = (List<PlayboardDto>) request.getAttribute("myjoinlist");
	List<PlayboardDto> makelist = (List<PlayboardDto>) request.getAttribute("mymakelist");
	String jsonData = (String)request.getAttribute("jsonData");

%>

<!-- fullCalendar 초기화 :버튼, 한글화  -->
<script>
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');

		var calendar = new FullCalendar.Calendar(calendarEl, {
			plugins : ['dayGrid' ],
			header : {
				left : '',
				center : 'title',
				right : 'today prev,next'
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
				var pdate = info.event.start;
				var today = new Date();
				if(today.getTime()>pdate.getTime()){
					alert("마감된 소모임입니다.");					
				}
				else{
					var seq = info.event.id;
					location.href="detailPlay.do?seq="+seq;
					
				}
			}
	});
		calendar.render();
	});
</script>

</head>
<body>
  <header class="header_area">
    	<jsp:include page="/common/navbar/templates/header.jsp" flush="false"/>
    </header>
<div id="wrapper">

  <!-- Main -->
	<div id="main">
		<div class="inner">
		 <h2>나의 일정</h2>
		 <hr>
		<section class="main-container">
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-12">
				<div id='calendar'></div>
							</div>
						</div>
					</div>
					    
<!--::footer part start::-->
	<br>
	<footer>
	<jsp:include page="/common/navbar/templates/footer.jsp" flush="false"/>   
	</footer> 
<!-- footer part end-->
			</section>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/mypage/mypageSidemenu.jsp"/>
	
</div>	


<script type="text/javascript">
$(document).ready(function() {
	$(".fc-left").append(
			"<font>참여</font><div id='join-color'></div><font>모집</font><div id='make-color'></div>");
	

	
});

</script>


</body>
</html>