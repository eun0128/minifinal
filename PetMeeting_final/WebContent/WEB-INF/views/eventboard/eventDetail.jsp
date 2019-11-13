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

<div class="container">	
	<div class="eventWrap">

		<div class="col-md-12">		
			<div class="event-infoWrap">							
					<div class="event-poster">					
						<img src="${pageContext.request.contextPath}/eventboardUpload/${detail.filename }" width="200px;" height="264px;">					
					</div>
				
					<div class="event-info">	
						<jsp:useBean id="pUtil" class="com.petmeeting.joy.playboard.Util.PlayboardUtil"/>
						<jsp:setProperty property="location" name="pUtil" value="${detail.location }"/>	
							<c:if test="${detail.progressCheck eq true }">
								<span class="progress-true">진행중인 행사</span>
							</c:if>		
							<c:if test="${detail.progressCheck eq false }">
								<span class="progress-false">행사기간이 아닙니다</span>
							</c:if>		
							<p class="event-title">${detail.title }</p>
							<span class="infotitle">행사기간</span><fmt:formatDate value="${detail.event_sdate }"  pattern="yyyy년 MM월 dd일"/> ~ 
							<fmt:formatDate value="${detail.event_edate }"  pattern="yyyy년 MM월 dd일"/>	<br>		
							<span class="infotitle">장소</span><jsp:getProperty property="simpleLocation" name="pUtil"/>	
					</div>
				
			</div>
			
			<div class="title">행사 설명</div>
			<div class="content-area">
				${detail.content }
			</div>
			
			<div class="title">행사 장소</div>
			<div class="map-area">
				<img src="${pageContext.request.contextPath}/playboard_resources/img/pin.png" width="35px" height="35px;" style="vertical-align: middle;">&nbsp;
				${detail.location } ${detail.location_detail }
				<div id="map" style="width:100%;height:400px;margin-top: 10px;"></div>	
			</div>
		</div>
	</div>
</div>



<!--::footer part start::-->    
<jsp:include page="/common/navbar/templates/footer.jsp" flush="false"/>   
<!-- footer part end-->

<script type="text/javascript">
/* 지도 출력 */
var geocoder = new kakao.maps.services.Geocoder();

var callback = function(result, status) {
    if (status === kakao.maps.services.Status.OK) {
        console.log(result);
        	        
        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
        
        var mapContainer = document.getElementById('map');
		var mapOption = {
			center: new daum.maps.LatLng(result[0].y, result[0].x),
			level: 3
		};

		var map = new kakao.maps.Map(mapContainer, mapOption); 

		var imageSrc = 'playboard_resources/img/mapPin.png', // 마커이미지의 주소입니다    
		imageSize = new kakao.maps.Size(50, 53), // 마커이미지의 크기입니다
		imageOption = {offset: new kakao.maps.Point(20, 60)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
		    markerPosition = coords // 마커가 표시될 위치입니다

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition, 
		    image: markerImage, // 마커이미지 설정 
		    clickable: true 
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);   

		map.relayout();
		map.setCenter(coords);
		
		// 마우스 오버 시 띄울 div
		var overContent = '<div align="center" style="padding:10px;">클릭해보세요!</div>';
		var infowindow = new kakao.maps.InfoWindow({
		    content : overContent
		});
		
		kakao.maps.event.addListener(marker, 'click', function() {
		  	var y = marker.getPosition().getLat();
		   	var x = marker.getPosition().getLng();

		    var URL = "https://map.kakao.com/link/map/" + y + "," + x;
		    //alert(URL);

		 // window.open('https://map.kakao.com/link/map/'+ y+','+x);
		    window.open('https://map.kakao.com/link/search/${detail.location }');
		});
		
		kakao.maps.event.addListener(marker, 'mouseover', function() {
			infowindow.open(map, marker);
		});
		kakao.maps.event.addListener(marker, 'mouseout', function() {
			infowindow.close();
		});

    }
};
		
geocoder.addressSearch("${detail.location }", callback);



</script>
</body>
</html>