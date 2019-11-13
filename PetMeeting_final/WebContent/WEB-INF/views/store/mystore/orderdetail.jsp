<%@page import="com.petmeeting.joy.store.model.CartDto"%>
<%@page import="com.petmeeting.joy.login.model.MemberDto"%>
<%@page import="com.petmeeting.joy.store.model.OrderInfoDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/store_resources/css/custom.css">
<style type="text/css">
caption {
	caption-side: top;
	text-align: left;
	font-weight: bold;
	font-size: 16px;
}

.orderInfo td{
text-align: left;
}

</style>
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
						<li><img
							src="${pageContext.request.contextPath}/store_resources/images/right-arrow.png"
							style="width: 10px; height: 10px; margin: 0 5px 5px 0;"><a
							href="myorder.do">나의 주문내역</a></li>
						<li><a href="myrefund.do">나의 반품/교환내역</a></li>
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
				<div class="sub-title">
					<h3>상세 주문 내역</h3>
				</div>
				<div class="info-wrap"
					style="padding: 20px 10px; margin-top: 40px; background: #EDEDED; border-radius: 5px">
					<c:forEach items="${mylist }" var="olist" begin="0" end="0">
						<h3>주문번호 : ${olist.ordernumber }</h3>
						<br>
						<p><b>동일한 주문번호로 조회한 상품들만 볼 수 있는 상세페이지입니다.</b></p>
					</c:forEach>
				</div>
				<div class="sub-content">
					<table>
						<colgroup>
							<col width="200">
							<col width="250">
							<col width="120">
							<col width="150">
							<col width="200">
							<col width="200">
						</colgroup>
						<thead>
							<tr>
								<th colspan="2">상품정보</th>
								<th>수량</th>
								<th>배송비</th>
								<th>주문금액</th>
								<th>주문상태</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="sum" value="0" />
							<c:forEach items="${mylist }" var="list" varStatus="vs">
								<tr>
									<td>
										<div class="product_img_link">
											<a
												href="${pageContext.request.contextPath}/productdetail.do?pcode=${list.productcode }">
												<img class="thumbnailImg" alt="이미지 없음"
												src="upload/${list.filename }" name="filename" width="100px">
											</a>
										</div>
									</td>
									<td>
										<div class="product_name" align="left">
											<b><a
												href="${pageContext.request.contextPath}/productdetail.do?pcode=${list.productcode }">${list.productname }</a></b><br>
											[사이즈] ${list.psize }<br> [색상] ${list.pcolor }
										</div>
									</td>
									<td>${list.quantity }</td>
									<c:if test="${vs.count eq 1 }">
										<td rowspan="${fn:length(mylist) }">2,500원</td>
									</c:if>
									<td>${list.price * list.quantity }</td>
									<td>
										<c:if test="${list.status eq 0}">
											배송준비중
										</c:if>
										<c:if test="${list.status eq 1}">
											배송중
										</c:if>
										<c:if test="${list.status eq 2}">
											배송완료
										</c:if>
										<c:if test="${list.status eq 3}">
											주문 취소
										</c:if>
										<c:if test="${list.status eq 4}">
											반품 대기
										</c:if>
										<c:if test="${list.status eq 5}">
											반품 완료
										</c:if>
										<c:if test="${list.status eq 6}">
											교환 대기
										</c:if>
										<c:if test="${list.status eq 7}">
											교환 완료
										</c:if>
									</td>
								</tr>
							<c:set var="sum" value="${sum + (list.price * list.quantity) }" />
							</c:forEach>
							<tr>
								<td colspan="6" align="right">
									총 결제금액 ₩ <fmt:formatNumber value="${sum }" pattern="#,###"/>  + 배송비 2,500 &ensp; <c:if test="${not empty usepoint or usepoint ne 0 }"> <b>(사용포인트 ${usepoint }P)</b></c:if> &ensp; | 총 합계 <font color="#E5433E" size="6px" style="font-weight: bold"> ₩<fmt:formatNumber value="${sum + 2500 - usepoint }" pattern="#,###"/> </font>
<%-- 									총 결제금액 ₩ <fmt:formatNumber value="${sum }" pattern="#,###"/> + 배송비 2,500  &ensp;&ensp; | 총 합계 <font color="#E5433E" size="6px" style="font-weight: bold"> ₩<fmt:formatNumber value="${sum + 2500}" pattern="#,###"/> </font> --%>
								</td>
							</tr>
						</tbody>
					</table>
					<br><br><br>

					<c:forEach items="${mylist }" var="list" varStatus="vs" begin="0" end="0">
					<table class="orderInfo" border="1" >
					<caption>배송 정보</caption>
					<col width="170"><col width="800">
						<tr>
							<th>수령인 명</th>
							<td>${list.rname }</td>
						</tr>
						<tr>
							<th>수령인 연락처</th>
							<td><fmt:formatNumber var="phone" value="${list.rphone }" pattern="###,####,####" />
								0<c:out value="${fn:replace(phone, ',', '-')}" />
							</td>
						</tr>
						<tr>
							<th>배송정보</th>
							<td>${list.raddress } ${list.raddress_detail } </td>
						</tr>
						<tr>
							<th>추가 배송 메시지</th>
							<td>
								${list.require }
							</td>
						</tr>
					</table>
					</c:forEach>
					
					<br><br><br><br>
					
				</div>
			</div>
		</div>
	</div>
	
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
    <!-- jquery -->
    <script src="${pageContext.request.contextPath}/common/navbar/js/jquery-1.12.1.min.js"></script>
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


</script>
</body>
</html>