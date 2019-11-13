<%@page import="com.petmeeting.joy.store.model.CartDto"%>
<%@page import="java.util.List"%>
<%@page import="com.petmeeting.joy.login.model.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetMeeting Store</title>
	<!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="icon" href="${pageContext.request.contextPath}/common/navbar/img/petmeetingicon.png">
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/store_resources/css/bootstrap.min.css">
	<!-- animate CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/store_resources/css/animate.css">
	<!-- owl carousel CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/store_resources/css/owl.carousel.min.css">
	<!-- themify CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/store_resources/css/themify-icons.css">
	<!-- flaticon CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/store_resources/css/flaticon.css">
	<!-- font awesome CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/store_resources/css/magnific-popup.css">
	<!-- style CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/store_resources/css/style.css">
	<!-- 우리가 추가한 css -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/store_resources/css/custom.css?after">
<style type="text/css">
.warning-text {
	text-align: left;
	padding: 20px 10px;
	margin-bottom: 20px;
	background-color: #f0f0f0;
	border-radius: 10px;
}
.refund-table td{
text-align: left;
}

.sub-content{
	min-height: 40px;
}

.refundproductlist #listcheck{
text-align: center;
}
caption {
	caption-side: top;
}

ul.tab-menu {
	list-style: none;
	height: 50px;
	border-bottom: 2px solid #2a7d6b;
}
ul.tab-menu li{
	display: inline-block;
	width: 150px;
	height: 100%;
	text-align: center;
	color: #2a7d6b;
	font-size: 18px;
	padding-top: 10px;
}
li a {
	color: inherit;
}
ul.tab-menu li.active {
	background-color: #2a7d6b;
	color: #fff;
	font-weight: 600;
	border-radius: 5px 5px 0 0;
}

.searchDate{
	padding-left: 120px;
}
form{
	margin-top: 20px;
}
</style>
	<!-- datepicker -->
	<script src="${pageContext.request.contextPath}/common/navbar/js/jquery-1.12.1.min.js"></script>
   <link  href="${pageContext.request.contextPath}/store_resources/css/datepicker.css" rel="stylesheet">
   <script src="${pageContext.request.contextPath}/store_resources/js/datepicker.js"></script>
</head>
<body>
	<!--::header part start::-->
	<header class="header_area">
	    <div class="main_menu">
	        <div class="container">
	            <div class="row">
	                <div class="col-lg-12">
						<div class="s-navi-top">
							<div class="s-loginInfo">
							<c:if test="${login == null }">
								<a href="login.do">LOGIN</a>&nbsp;&nbsp;&nbsp;<a href="account.do">JOIN</a>							
							</c:if>
							<c:if test="${login != null }">
								안녕하세요. <b>${login.nickname }</b>님!&nbsp;&nbsp;&nbsp;<a href="logout.do">로그아웃</a>
							</c:if>
							</div>
						</div>
						
						<div class="s-navi-bottom">
	                        <div class="s-logo">
	                        	<img alt="이미지없음" src="${pageContext.request.contextPath}/common/navbar/img/petmeetinglogostore.png" width="auto" height="30px"
	                        		onclick="location.href='productlist.do'">
	                        </div>
	                        
	                        <div class="s-mymenu">
								<div class="s-mymenu-petmain">
									<img alt="이미지없음" src="${pageContext.request.contextPath}/store_resources/images/home.png" width="30px" height="30px" onclick="location.href='main.do'">&nbsp;&nbsp;&nbsp;
								</div>
								<div class="s-mymenu-mystore">
									<img alt="이미지없음" src="${pageContext.request.contextPath}/store_resources/images/user.png" width="30px" height="30px" onclick="location.href='mystore.do'">&nbsp;&nbsp;&nbsp;
								</div>
								<div class="s-mymenu-cart">
									<img alt="이미지없음" src="${pageContext.request.contextPath}/store_resources/images/cart.png" width="30px" height="30px" onclick="location.href='cart.do'">
								<%
								HttpSession se = request.getSession();
								MemberDto user = (MemberDto)se.getAttribute("login");
								
								if(user != null) {
									List<CartDto> clist = (List<CartDto>)se.getAttribute(user.getEmail());
									
									if(clist != null && clist.size() > 0) {
									%>
										<span class="s-mymenu-cart-count"><%=clist.size() %></span>
									<%
									}
								}
								%>
								</div>
							</div>
                        </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</header>
	<!-- Header part end--> 
	
	
	<!-- Content part start -->
	<div class="container s-container">
		<div class="mystore-sidebar">
			<div class="sub-title">
				<h3>MY STORE</h3>
			</div>
			<div class="side-meminfo">
				<div class="s-text">
					안녕하세요. <b>${login.nickname }</b>님!
				</div>
				<div class="s-text">적립금 : ${login.s_point }점</div>
			</div>

			<ul class="side-list">
				<li>나의 주문
					<ul class="side-sublist">
						<li><a href="myorder.do">나의 주문내역</a></li>
						<li><img
							src="${pageContext.request.contextPath}/store_resources/images/right-arrow.png"
							style="width: 10px; height: 10px; margin: 0 5px 5px 0;"><a
							href="myrefund.do">나의 반품/교환내역</a></li>
						<li><a href="mycancel.do">나의 취소내역</a></li>
					</ul>
				</li>

				<li>나의 활동
					<ul class="side-sublist">
						<li><a href="myquestion.do">나의 문의</a></li>
						<li><a href="myreview.do">나의 리뷰</a></li>
					</ul>
				</li>
			</ul>
		</div>

		<div class="mystore-container">
			<div class="info-wrap">
				 <ul class="tab-menu">
					<li class="active"><a href="myrefund.do">반품/교환 내역</a></li>
					<li><a href="myrefundapplication.do">반품/교환 신청</a></li>
				</ul>
				
				<%-- <div class="warning-text"
					style="padding: 20px 10px; margin-top: 40px; background: #EDEDED; border-radius: 5px">
					<div><img alt="이미지없음" src="${pageContext.request.contextPath}/store_resources/images/alert.png" width="20px" height="20px">&ensp; <h4 style="color: black; display: inline-block;">알아두세요!</h4></div>
					<br>
					<p>- 이러저러한 문구</p>
					<p>- 이러이러한 문구</p>
					<p>- 저러저러한 문구</p>
				</div> --%>
				
				<div class="sub-content">
				<form id="_refundReference" name="refundReference" method="post">
				<input type="hidden" name="pageNumber" id="_pageNumber" value="${(empty pageNumber)?0:pageNumber }">
				<input type="hidden" name="recordCountPerPage" id="_recordCountPerPage" value="${(empty recordCountPerPage)?0:recordCountPerPage }">
					<table class="searchBox">
					<colgroup>
						<col width="120px"><col width="800">
					</colgroup>
					<tbody>
					<tr>
						<th>조회기간</th>
						<td>
						<ul class="searchDate">
							<li>
								<span class="checkbox2">
									<input type="radio" name="dateType" id="dateType1" onclick="setSearchDate('0d')">
									<label for="dateType1">오늘</label>
								</span>
							</li>
							<li>
								<span class="checkbox2">
									<input type="radio" name="dateType" id="dateType2" onclick="setSearchDate('1w')">
									<label for="dateType2">1주일</label>
								</span>
							</li>
							<li>
								<span class="checkbox2">
									<input type="radio" name="dateType" id="dateType3" onclick="setSearchDate('1m')">
									<label for="dateType3">1개월</label>
								</span>
							</li>
							<li>
								<span class="checkbox2">
									<input type="radio" name="dateType" id="dateType4" onclick="setSearchDate('3m')">
									<label for="dateType4">3개월</label>
								</span>
							</li>
							<li>
								<span class="checkbox2">
									<input type="radio" name="dateType" id="dateType5" onclick="setSearchDate('6m')">
									<label for="dateType5">6개월</label>
								</span>
							</li>
						</ul>
			            <div class="clearfix">
                            <!-- 시작일 -->
                            <span class="dset">
                                <label><input type="text" class="datepicker inpType" name="startdate" id="searchStartDate" value="">
                                <img alt="" src="${pageContext.request.contextPath}/store_resources/images/calendar.png"> </label>
                            </span>
                            <span class="demi"><b>~</b></span>
                            <!-- 종료일 -->
                            <span class="dset">
                               <label><input type="text" class="datepicker inpType" name="enddate" id="searchEndDate" value="" >
                                 <img alt="" src="${pageContext.request.contextPath}/store_resources/images/calendar.png"> </label> 
                            </span>
                        </div>   
						</td>
					</tr>
					
				</tbody>
				</table>
			</form>
			</div>
					
			</div>
			
			<div class="info-wrap" style="padding: 20px 10px; background: #e0f0ee; border-radius: 5px">
				<p>※ 나의 반품/교환 내역에서의 조회는 반품/교환 신청 날짜에 의한 조회입니다. (주문 날짜X)</p>
			</div>

				<div class="sub-content">
					<table class="refund_list">
						<colgroup>
							<col width="150px"><col width="200px"><col width="250px">
							<col width="130px"><col width="130px">
						</colgroup>
						<thead>
							<tr>
								<th>주문번호</th><th>반품일자</th><th>반품내역</th>
								<th>반품/교환</th><th>처리상태</th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${olist == null || olist.size() == 0 }">
							<tr>
								<td colspan="5" style="height: 250px; background-color: #fafafa;">주문한 내역이 없습니다</td>
							</tr>
						</c:if>
						
						<c:if test="${olist != null }">
						<c:forEach items="${olist }" var="list">
							<tr>
									<td>${list.ordernumber }<br>
									</td>
									<td><fmt:formatDate value="${list.refund_date }" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
									<td><b>${list.productname }</b><br>
									[OPTION] ${list.psize }/${list.pcolor }
									</td>
									<td>
									<c:if test="${list.status eq 1 or list.status eq 2 or list.status eq 3}">
										반품
									</c:if>
									<c:if test="${list.status eq 4 or list.status eq 5 or list.status eq 6}">
										교환
									</c:if>
									</td>
									<td>
									<c:if test="${list.status eq 1 }">
										반품 신청
									</c:if>
									<c:if test="${list.status eq 2 }">
										반품 대기
									</c:if>
									<c:if test="${list.status eq 3 }">
										<font color="#E5433E" style="font-weight: bold">반품 완료</font>
									</c:if>
									<c:if test="${list.status eq 4 }">
										교환 신청
									</c:if>
									<c:if test="${list.status eq 5 }">
										교환 대기
									</c:if>
									<c:if test="${list.status eq 6 }">
										<font color="#E5433E" style="font-weight: bold">교환 완료</font>
									</c:if>
									</td>
									
							</tr>
							<tr></tr>
						 
						</c:forEach>
						</c:if>
						
						 <tr>
							<td colspan="5">
								<jsp:include page="/WEB-INF/views/store/mystore/paging.jsp" flush="false">
								<jsp:param name="" value="type" />
								<jsp:param name="pageNumber" value="${pageNumber }"/>		
								<jsp:param name="totalRecordCount" value="${totalRecordCount }"/>	
								<jsp:param name="pageCountPerScreen" value="${pageCountPerScreen }"/>	
								<jsp:param name="recordCountPerPage" value="${recordCountPerPage }"/>	
								</jsp:include>
							</td>
						</tr> 
						</tbody>
					</table>
				</div>
			
		</div>
	</div>
	<!-- Content part end -->

	<!-- Footer part start -->
	<footer class="footer_area">
		<div class="container">
			<div class="footer-title">
				PETMEETING STORE
			</div>
			<div class="footer-content">
				<div class="footer-content-element">
					<span class="element-title">회사명</span> (주)펫미팅스토어
				</div>
				<div class="footer-content-element">
					<span class="element-title">대표자명</span> 박유림
				</div>
				<div class="footer-content-element">
					<span class="element-title">주소</span> 서울특별시 서초구 강남대로 459 백암빌딩 5층
				</div>
				<div class="footer-content-element">
					<span class="element-title">대표번호</span> 010 1234 5678
				</div>
				<div class="footer-content-element">
					<span class="element-title">개인정보 보호 책임자</span> 김연하 younger9403@gmail.com
				</div>
				<div class="footer-text">
					PETMEETING STORE의 모든 콘텐츠는 저작권의 보호를 받고 있습니다.
				</div>
			</div>
			<div class="footer-bottom">
				
			</div>
		</div>
	</footer>
	<!-- Footer part end -->
	
	
	<!-- jquery plugins here-->

    <!-- popper js -->
    <script src="${pageContext.request.contextPath}/common/navbar/js/popper.min.js"></script>
    <!-- bootstrap js -->
    <script src="${pageContext.request.contextPath}/common/navbar/js/bootstrap.min.js"></script>
    <!-- counterup js -->
    <script src="${pageContext.request.contextPath}/common/navbar/js/jquery.counterup.min.js"></script>
    <!-- waypoints js -->
    <script src="${pageContext.request.contextPath}/common/navbar/js/waypoints.min.js"></script>
    <!-- easing js -->
    <script src="${pageContext.request.contextPath}/common/navbar/js/jquery.magnific-popup.js"></script>
    <!-- particles js -->
    <script src="${pageContext.request.contextPath}/common/navbar/js/owl.carousel.min.js"></script>
    <!-- custom js -->
    <script src="${pageContext.request.contextPath}/common/navbar/js/custom.js"></script>


<script type="text/javascript">
var start_D = "<c:out value="${start}"/>";
var end_D = "<c:out value="${end}"/>";
	
$(document).ready(function() {

     // Datepicker            
    $(".datepicker").datepicker({
        showButtonPanel: true,
        format: 'yyyy-mm-dd',
        language: "ko",
        todayHighlight: true,
        yearFirst: true,
        autoHide: true,
        yearSuffix: '년',
        dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
        monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        zIndex: 5000
    }); 
     
     // 시작일은 오늘 날짜까지만 선택 가능하게 설정 
     
    var endDate = new Date();
    $("#searchStartDate").datepicker('setEndDate', endDate);
   
    $('.datepicker').on('pick.datepicker', function () {
	    var sDate = $("#searchStartDate").datepicker('getDate');
	    document.getElementsByName('startdate').value = sDate;
	    
    	// 종료일은 시작일부터 오늘까지만 선택할 수 있게 설정
    	$('#searchEndDate').datepicker('setStartDate', sDate);
    	$('#searchEndDate').datepicker('setEndDate', endDate);
    
    	var eDate = $('#searchEndDate').datepicker('getDate');
    	document.getElementsByName('enddate').value = eDate;
    	
    });
    
});  

$("#searchEndDate").on("change", function () {
	$("#_refundReference").attr("action", "myrefund.do").submit();
});

function setSearchDate(start){		// 조회 기간을 선택했을 때
    var num = start.substring(0,1);		// 0d, 1w, 1m, 3m에서   숫자만 가져옴
    var str = start.substring(1,2);		// 0d, 1w, 1m, 3m에서   문자만 가져옴
    	
    var today = new Date();		// 오늘 날짜 가져옴
   
    
      // 날짜 개체를 설정된 날짜 형식('yyyy-mm-dd')으로 변경해준다
	var endDate = $(".datepicker").datepicker('formatDate', today);
      
	// 오늘 날짜를 종료날짜로 지정함
    $('#searchEndDate').val(endDate);
    
    if(str == 'd'){
        today.setDate(today.getDate() - num);		
    }else if (str == 'w'){
        today.setDate(today.getDate() - 7);
    }else if (str == 'm'){
        today.setMonth(today.getMonth() - num);
        today.setDate(today.getDate() + 1);
    }
    
   
    var startDate = $(".datepicker").datepicker('formatDate', today);
    $('#searchStartDate').val(startDate);
            
    // 종료일은 시작일 이전 날짜 선택하지 못하도록 비활성화
    $("#searchEndDate").datepicker( 'setEndDate', startDate );
      
        
      // 시작일은 종료일 이후 날짜 선택하지 못하도록 비활성화
// $("#searchStartDate").datepicker( "option", "maxDate", endDate );
    $("#searchStartDate").datepicker( 'setEndDate', startDate );
    
    
    document.getElementsByName('startdate').value = startDate;
    document.getElementsByName('enddate').value = endDate;
    
    $("#_refundReference").attr("action", "myrefund.do").submit();
}

$("#searchStartDate").val(start_D);
$("#searchEndDate").val(end_D);

		
function goPage( type, pageNumber ) {
	$("#_pageNumber").val(pageNumber);
	$("#_refundReference").attr("action", "myrefund.do").submit();
}
/* 
$.fn.rowspan = function(colIdx, isStats) {       
    return this.each(function(){      
        var that;     
        $('tr', this).each(function(row) {      
            $('td:eq('+colIdx+')', this).filter(':visible').each(function(col) {
                 
                if ($(this).html() == $(that).html()
                    && (!isStats 
                            || isStats && $(this).prev().html() == $(that).prev().html()
                            )
                    ) {            
                    rowspan = $(that).attr("rowspan") || 1;
                    rowspan = Number(rowspan)+1;
 
                    $(that).attr("rowspan",rowspan);
                     
                    // do your action for the colspan cell here            
                    $(this).hide();
                     
                    //$(this).remove(); 
                    // do your action for the old cell here
                     
                } else {            
                    that = this;         
                }          
                 
                // set the that if not already set
                that = (that == null) ? this : that;      
            });     
        });    
    });  
}; 
 */
 
</script>
</body>


</html>