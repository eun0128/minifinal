<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetMeeting</title>
 <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- 지도 -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=689cdd3b092f29b4c71fe175d367652c&libraries=services"></script>
   
    <link rel="icon" href="${pageContext.request.contextPath}/common/navbar/img/petmeetingicon.png">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/playboard_resources/css/eventboard.css">
</head>
<body>
<!--::header part start::-->
<jsp:include page="/common/navbar/templates/header.jsp" flush="false"/>    
<!-- Header part end-->

 <!-- 게시판 소개 부분 -->
  	<div class="container">
   		<div class="mainTitle">                                     
        <span id="mainTitle-petmeeting">PetMeeting</span>
        <span id="mainTitle-boardname"><img src="${pageContext.request.contextPath}/common/img/garlands.png" width="60px;">&nbsp;반려동물 행사 캘린더</span>
        <span id="mainTitle-info">펫미팅에서 다가오는 반려동물 행사를 안내드립니다!</span>                                                 
       </div>
	 </div>
	 
<div class="container">
 	<div class="eventWrap">
		<div class="event-infoWrap">
		
		<div class="dateWrap">
			<a id="prev" class="dateArrow"><img src="${pageContext.request.contextPath}/common/img/eventboard_prev.png" width="30px"></a>
				${year }년 ${month }월
			<a id="next" class="dateArrow"><img src="${pageContext.request.contextPath}/common/img/eventboard_next.png" width="30px"></a>
		</div>
		
			<div class="col-md-12">
			<c:if test="${empty monthlyEvents }">
				<div class="emptyevent">
					이 달에 등록된 행사가 없습니다.
				</div>
			</c:if>
			
			<c:if test="${not empty monthlyEvents }">
				<c:forEach items="${monthlyEvents }" var="eList">
					<div class="event-row">
						<img class="event-thumbnail" src="${pageContext.request.contextPath}/eventboardUpload/${eList.filename}">
						<div class="event-day">
							<fmt:formatDate value="${eList.event_sdate }"  pattern="dd일"/>
						</div>
						<a class="eventAnchor" seq="${eList.seq }">${eList.title }</a> 
					</div>
				</c:forEach>
			</c:if>
			
			
			</div>
		</div>
	</div>
</div>

<!--::footer part start::-->    
<jsp:include page="/common/navbar/templates/footer.jsp" flush="false"/>   
<!-- footer part end-->

<script type="text/javascript">
$(function () {
	$(".eventAnchor").click(function () {
		location.href="eventDetail.do?seq="+$(this).attr("seq");
	});

	
	$("#prev").click(function () {
		var year = parseInt("${year }");
		var month = parseInt("${month }");
		
		month--;
		if(month < 1){
			month="12";
			year--;
		}
		if(month > 0 && month < 10){
			month = "0"+month;
		}
		var date = year+""+month+"";
		
		location.href="eventBoard.do?date="+date;
	});
	
	$("#next").click(function () {
		var year = parseInt("${year }");
		var month = parseInt("${month }");
		
		month++;
		if(month > 12){
			month="1";
			year++;
		}
		if(month > 0 && month < 10){
			month = "0"+month;
		}
		var date = year+""+month+"";
		
		location.href="eventBoard.do?date="+date;
	});
});
</script>
</body>
</html>