<%@page import="com.petmeeting.joy.freeboard.model.FreeboardDto"%>
<%@page import="com.petmeeting.joy.playboard.model.PlayboardDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의페이지 홈</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/mypage_resources/mypagehome/css/mypage_home.css?after">
<link href='${pageContext.request.contextPath}/mypage_resources/mypagehome/fullcalendar/core/main.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/mypage_resources/mypagehome/fullcalendar/list/main.css' rel='stylesheet' />
<script src='${pageContext.request.contextPath}/mypage_resources/mypagehome/fullcalendar/core/main.js'></script>
<script src='${pageContext.request.contextPath}/mypage_resources/mypagehome/fullcalendar/list/main.js'></script>

<%
	List<PlayboardDto> joinlist = (List<PlayboardDto>) request.getAttribute("myattendList");
	List<PlayboardDto> makelist = (List<PlayboardDto>) request.getAttribute("mymakeList");
	List<FreeboardDto> freelist = (List<FreeboardDto>) request.getAttribute("flwerFreeList");
	String jsonData = (String)request.getAttribute("jsonData");
	System.out.println("jsonData 체크 : " + jsonData);
%>

<script>
var jsonData = 
document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	var calendar = new FullCalendar.Calendar(calendarEl, {
		  plugins: [ 'list' ],
		  defaultView: 'listWeek',
		  
		  header:{
			  left:'',
			  center:'',
			  right:''
		  },
		  <%
			if(!jsonData.equals("")){	
			%>
			events : <%=jsonData%>,
			<%
			 }
			 %>
			 locale : 'ko',
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


<body class="is-preload">
	<header class="header_area">
		<jsp:include page="/common/navbar/templates/header.jsp" flush="false"/>
	</header>
	<!-- Wrapper -->
	<div id="wrapper">
	  <!-- Main -->
		<div id="main">
			<div class="inner">
			  <h2>나의페이지 홈</h2>
				<hr>
				<section class="main-container">
					<div class="container-fluid">
						<div class="row">
							<div class="col-md-12 two-boxes">
								<div class="right-box">
									<div class="col-md-12 member-card">
										<div class="grade-container">
											<img class="gradeimg" alt="${userGrade.filename }" 
											src="${pageContext.request.contextPath}/mypage_resources/mypage_j/images/${userGrade.filename }">
											<span class="gradename" >${userGrade.grade_name }</span>
										</div>
										<div class="details">
											<div class="card-detail">
												<div class="card-detail-title">
													현재 포인트
												</div>
												<div class="card-detail-content">
													${userdto.point} 
												</div>
											</div>
											<div class="card-detail">
												<div class="card-detail-title">
													누적 포인트
												</div>
												<div class="card-detail-content">
													${userdto.totalpoint} 
												</div>
											</div>
											<div class="card-detail">
												<div class="card-detail-title">
													작성한 글
												</div>
												<div class="card-detail-content">
													${writingCount } 
												</div>
											</div>
											<div class="card-detail">
												<div class="card-detail-title">
													작성한 댓글
												</div>
												<div class="card-detail-content">
													${commentCount }
												</div>
											</div>
										</div>
									</div>
								<div class="col-md-12 my-description">
									<div class="accordion vertical">
									    <ul>
									        <li>
									            <input type="radio" id="radio-1" name="radio-accordion" />
									            <label for="radio-1">포인트 사용내역</label>
									            <div class="content plistcontent">
									            
									        	
									            </div>
									        </li>
									        <li>
									            <input type="radio" id="radio-2" name="radio-accordion" />
									            <label for="radio-2">등급 기준</label>
									            <div class="content">
									              <table class="grade-table">
									              <col width="25%"><col width="25%"><col width="25%"><col width="25%">
									              	<tr>
										              	<th class="grade-th">
										        	      	<img class="grade-th-img" src="${pageContext.request.contextPath}/mypage_resources/mypage_j/images/level_vvip.png">
										             		
										             		 <font color="#f57b76">VVIP</font>
										              	</th>
										              	<th class="grade-th">
										        		   	<img class="grade-th-img" src="${pageContext.request.contextPath}/mypage_resources/mypage_j/images/level_vip.png">            	
										              		<font color="#fed77c">VIP</font>
										              	</th>
										              	<th class="grade-th">
										         			<img class="grade-th-img" src="${pageContext.request.contextPath}/mypage_resources/mypage_j/images/level_family.png">              	
										              		<font color="#65d4f0">FAMILY</font>
										              	</th>
										              	<th class="grade-th">
										               		<img class="grade-th-img" src="${pageContext.request.contextPath}/mypage_resources/mypage_j/images/level_new.png"> 	
										          	    	<font color="#b4ce49">NEW</font>
										              	</th>
									              	</tr>
									              	<tr class="grade-tr">
										              	<td class="grade-td">	
										              		<p>▶ 10000포인트 이상 </p>
										              		<p>▶ 로그인 시 매일 1회 300포인트 증정</p>
										              		<p>▶  소모임/자유게시판 글 작성 시 100포인트 증정</p>
										              	</td>
										              	<td class="grade-td">
										              		<p>▶ 5000포인트 이상 10000포인트 미만</p>
										              		<p>▶ 로그인 시 매일 1회 300포인트 증정</p>
										              		<p>▶ 소모임/자유게시판 글 작성 시 100포인트 증정</p>
										              	</td>
										              	<td class="grade-td">
										              		
										              		<p>▶ 프로필 등록 완료 시</p>
										              		<p>▶ 1000포인트 이상 5000포인트 미만</p>
										              		<p>▶ 로그인 시 매일 1회 300포인트 증정</p>
										              		<p>▶ 소모임/자유게시판 글 작성 시 100포인트 증정</p>
										              	</td>
										              	<td class="grade-td"	>
										              	
										              		<p>▶ 펫미팅 신규가입 시</p>
										              		<p>▶ 로그인 시 매일 1회 300포인트 증정</p>
										              	</td>
									              	</tr>
									              </table>
									            </div>
									        </li>
									        <li>
									            <input type="radio" id="radio-3" name="radio-accordion"  checked="checked"/>
									            <label for="radio-3">이번주 모임</label>
										            <div class="content">
									          			<div id='calendar'></div>
									          	  </div>
									        </li>
									    </ul>
									</div>					
								</div>
							</div>
							<div class="left-box">
									 <label for="flwer-play-activity">팔로잉 최신 소모임</label>
									 <div class="flwer-activity">
											<table id="flwer-play-activity">
												<col width="15%"><col width="55%"><col width="25%">
													<c:if test="${ empty flwerAllPlayList }">
													<tr>
														<td>이번주의 팔로워 글이 없습니다.</td>
													</tr>
													</c:if>
													<jsp:useBean id="dateUtil" class="com.petmeeting.joy.mypage.util.MypageDateUtil"/>
													<c:if test="${ not empty flwerAllPlayList }">
														<input type="hidden" id="totalData" value="${flwerAllPlayList.size() }">
														<tr>
															<th>팔로잉</th>
															<th>소모임 정보</th>
															<th>모임 예정일</th>
														</tr>
													<c:forEach items="${flwerAllPlayList }" var="play" varStatus="i">
															<jsp:setProperty property="date2" name="dateUtil" value="${play.pdate }"/>
															<tr>
																<td>
																	<c:if test="${empty play.myprofile_img || play.myprofile_img eq ''}">
												                   		<img src="${pageContext.request.contextPath}/mypage_resources/mypage_s/images/user.png"  class="list-profileimg">
												                   	</c:if>
												                   	<c:if test="${not empty play.myprofile_img  }">
												                   		<img src="upload/${play.myprofile_img }" class="list-profileimg">
												                   	</c:if>
																<br>
																${play.nickname }
																</td>
																<td align="left">
																	${play.sort }
																	<br>
																	<font class="goDetail" seq="${play.seq }"  isEnd="<jsp:getProperty property='isEnd2' name='dateUtil'/>">[${play.category }]&nbsp;${play.title }</font>
																</td>
																<td><jsp:getProperty property="dateString2" name="dateUtil"/></td>
															</tr>
													</c:forEach>
												</c:if>
												</table>
									</div>
									
									 <label for="flwer-free-activity">팔로잉 최신 게시글</label>
									 <div class="flwer-activity">
											<table id="flwer-free-activity">
											<!-- 팔로워 프로필 사진, 닉네임  / [보드코드] 타이틀, 소모임의 경우   /레지데이트  -->
											<col width="15%"><col width="55%"><col width="25%">
											<c:if test="${ empty flwerFreeList }">
											<tr>
												<td>이번주의 팔로워 글이 없습니다.</td>
											</tr>
											</c:if>
											<c:if test="${ not empty flwerFreeList }">
												<tr>
												<th>팔로잉</th>
												<th>게시글 정보</th>
												<th>작성일</th>
												</tr>
												<c:forEach items="${flwerFreeList }" var="free" varStatus="i">
													<jsp:setProperty property="date1" name="dateUtil" value="${free.regdate }"/>
													<tr>
													<td>
														<c:if test="${empty free.myprofile_img || free.myprofile_img eq ''}">
												             <img src="${pageContext.request.contextPath}/mypage_resources/mypage_s/images/user.png"  class="list-profileimg">
												        </c:if>
												        <c:if test="${not empty free.myprofile_img  }">
															<img src="upload/${free.myprofile_img }" class="list-profileimg">
														</c:if>
														<br>
														${free.nickname }
													</td>
													
													<td align="left">
														[<font id="boardcode${i.index }" seq="${free.seq }" code="${free.board_code }"></font>&nbsp; - &nbsp;${free.category }]
														<br>
														<font class="gofreeDetail" seq="${free.seq }">${free.title }</font>
													</td>
													
													<td><jsp:getProperty property="dateString1" name="dateUtil"/></td>
													</tr>
												</c:forEach>
											</c:if>
											</table>
									</div>
							</div>
					</div>
				</div>
			</div>
			</section>
					<!--::footer part start::-->
				<br>
			<footer>
			<jsp:include page="/common/navbar/templates/footer.jsp" flush="false"/>   
			</footer> 
		<!-- footer part end-->
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/mypage/mypageSidemenu.jsp"/>
</div>

<script type="text/javascript">
$(document).ready(function(){
	var grade = $(".gradename").text();
	
	if(grade == 'new'){
		$(".gradename").css("color","#b4ce49");
	}
	else if(grade == 'family'){
		$(".gradename").css("color","#65d4f0");
	}
	else if(grade == 'vip'){
		$(".gradename").css("color","#fed77c");
	}
	else if(grade == 'vvip'){
		$(".gradename").css("color","#f57b76");
	}

	<%
	for(int i = 0; i< makelist.size();i++){
	%>
		$(".c2d7e1").text("모집");
	<%
	}
	%>
	<%
	for(int i = 0; i< joinlist.size();i++){
	%>
		$(".8893cc").text("참여");
	<%
	}
	%>
	
	<%
	for(int i = 0; i< freelist.size();i++){
	%>
		var code = $("#boardcode<%=i%>").attr("code");
	
		if(code == 'DOG'){
			$("#boardcode<%=i%>").text("강아지");
		}
		else if(code =='CAT'){
			$("#boardcode<%=i%>").text("고양이");
		}
		else{
			$("#boardcode<%=i%>").text("기타 소동물");
		}
	<%
	}
	%>
		
	
	
	
	var frmdata = $("#frm").serialize();
	$(".plistcontent").load("mypagehomePointHistoryList.do?frmdata=" +frmdata);
	
	$(".goDetail").on("click", function(){
		var seq = $(this).attr("seq");
		var isEnd = $(this).attr("isEnd");
		
		if(isEnd == 0){
			alert("마감된 소모임입니다.");
		}
		else{			
			location.href="detailPlay.do?seq="+seq;
		}
	});
	
	$(".gofreeDetail").on("click", function(){
		var seq = $(this).attr("seq");	
		location.href="freeboard_boarddetail.do?seq="+seq;
	});
});


function goPage(pageNumber){
	$("#_pageNumber").val(pageNumber);
	$("#_recordCountPerPage").val("${pparam.recordCountPerPage}");
	
	var frmdata = $("#frm").serialize();
	$(".plistcontent").load("mypagehomePointHistoryList.do?frmdata=" +frmdata);
};


</script>
</body>
</html>