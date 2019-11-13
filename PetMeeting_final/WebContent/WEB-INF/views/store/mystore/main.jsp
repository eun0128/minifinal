<%@page import="com.petmeeting.joy.store.model.CartDto"%>
<%@page import="java.util.List"%>
<%@page import="com.petmeeting.joy.login.model.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
.delivery-img {
	display: inline-block;
	padding: 5px;
	margin: 10px 30px;
}
.delivery-img img {
	width: 100px;
	height: 100px;
}
.delivery-img p {
	font-size: 18px;
	font-weight: 700;
	color: #505050;
}
.delivery-info {
	display:inline-block;
}
.delivery-count{
	font-size: 20px;
	font-weight: 500;
	color: #505050;
}
div.review-writerscore-star-gray{
	display:inline-block;
	position: relative;
	width: 90px;
	height: 18px;
	background: url("store_resources/images/star2.png");
}

div.review-writerscore-star-orange{
	position: absolute;
	height: 18px;
	background: url("store_resources/images/star-active2.png");
}
#tracking-btn{
	width: 100px;
    height: 30px;
    background: #e0e0e0;
    border: none;
    font-weight: bold;
    border-radius: 7px;
    font-size: 12px;
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
				<div class="s-text">
					적립금 : ${login.s_point }점
				</div>
			</div>
		
			<ul class="side-list">
				<li>나의 주문
					<ul class="side-sublist">
						<li><a href="myorder.do">나의 주문내역</a></li>
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
					<h3>배송정보</h3>
				</div>
				<div style="padding: 10px; text-align: center;">
					<div class="delivery-info">
						<div class="delivery-img">
							<img alt="" src="${pageContext.request.contextPath}/store_resources/images/ready.png">
							<p>배송준비중</p>
						</div>
						<div class="delivery-count">
							${rcount }
						</div>
					</div>
					<div class="delivery-info">
						<div class="delivery-img">
							<img alt="" src="${pageContext.request.contextPath}/store_resources/images/delivery-ing.png">
							<p>배송중</p>
						</div>
						<div class="delivery-count">
							${dcount }
						</div>
					</div>
					<div class="delivery-info">
						<div class="delivery-img">
							<img alt="" src="${pageContext.request.contextPath}/store_resources/images/complete.png">
							<p>배송완료</p>
						</div>
						<div class="delivery-count">
							${ccount }
						</div>
					</div>
				</div>
			</div>
			<div class="info-wrap" style="padding: 20px 10px; background: #e0f0ee; border-radius: 5px">
				<p>※ 최근 내역은 가장 최근순으로 <b>최대 5건</b>만 조회됩니다. 자세한 사항은 나의 내역에서 확인하세요.</p>
			</div>
			<div class="info-wrap">
				<div class="sub-title">
					<h3>최근 주문내역</h3>
				</div>
				<div class="sub-content">
					<table>
						<colgroup>
							<col width="150px"><col width="200px"><col width="300px">
							<col width="100px"><col width="100px">
						</colgroup>
						<thead>
							<tr>
								<th>주문번호</th><th>주문일자</th><th>주문내역</th>
								<th>주문금액</th><th>주문상태</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${olist == null || olist.size() == 0 }">
								<tr>
									<td colspan="5" style="height: 250px; background-color: #fafafa;">주문한 내역이 없습니다</td>
								</tr>
							</c:if>
							<c:if test="${olist != null }">
								<c:forEach items="${olist }" var="oi">
									<tr>
										<td>${oi.ordernumber }</td>
										<td><fmt:formatDate value="${oi.orderdate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<td style="text-align: left"><a href="orderdetail.do?ordernumber=${oi.ordernumber }">${oi.ordername }</a></td>
										<td><fmt:formatNumber value="${oi.totalprice + 2500}" pattern="#,###"/></td>
										<td>
											<c:if test="${oi.status == 0 }">
											배송준비중
											</c:if>
											<c:if test="${oi.status == 1 }">
											배송중<br>
											<button type="button" id="tracking-btn" onclick="showPopup()">배송추적</button>
											</c:if>
											<c:if test="${oi.status == 2 }">
											배송완료
											</c:if>
											<c:if test="${oi.status == 3 }">
											주문취소
											</c:if>
											<c:if test="${oi.status == 4 }">
											반품대기
											</c:if>
											<c:if test="${oi.status == 5 }">
											반품완료
											</c:if>
											<c:if test="${oi.status == 6 }">
											교환대기
											</c:if>
											<c:if test="${oi.status == 7 }">
											교환완료
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
			
			<div class="info-wrap">
				<div class="sub-title">
					<h3>최근 문의내역</h3>
				</div>
				<div class="sub-content">
					<table>
						<colgroup>
							<col width="100px"><col width="150px"><col width="300px">
							<col width="150px"><col width="100px">
						</colgroup>
						<thead>
							<tr>
								<th>카테고리</th><th>상품이름</th><th>문의내용</th>
								<th>문의날짜</th><th>답변여부</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${qlist == null || qlist.size() == 0 }">
								<tr>
									<td colspan="5" style="height: 250px; background-color: #fafafa;">문의 내역이 없습니다.</td>
								</tr>
							</c:if>
							<c:if test="${qlist != null }">
								<c:forEach items="${qlist }" var="qna">
									<tr>
										<td>[${qna.category }]</td>
										<td>${qna.productname }</td>
										<td style="text-align: left"><a>${qna.q_content }</a></td>
										<td><fmt:formatDate value="${qna.q_regdate }" pattern="yyyy-MM-dd HH:mm"/></td>
										<td>
											<c:if test="${qna.a_seq == 0 }">
												답변대기중
											</c:if>
											<c:if test="${qna.a_seq != 0 }">
												답변완료
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
			
			<div class="info-wrap">
				<div class="sub-title">
					<h3>최근 리뷰내역</h3>
				</div>
				<div class="sub-content">
					<table>
						<colgroup>
							<col width="200"><col width="200"><col width="300"><col width="150">
						</colgroup>
						<thead>
							<tr>
								<th>구매상품</th><th>평점</th><th>한줄평</th><th>작성일</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${rlist.size() == 0 }">
								<tr>
									<td colspan="3" style="height: 250px; background-color: #fafafa;">리뷰 내역이 없습니다.</td>
								</tr>
							</c:if>
							<c:forEach items="${rlist }" var="review">
								<tr>
									<td style="text-align: left;">
										<div>${review.productname }</div>
										<div>${review.psize }, ${review.pcolor }</div>
									</td>
									<td>
										<div class="review-writerscore-star-gray">
											<div class="review-writerscore-star-orange" rating="${review.score }"></div>
										</div>
									</td>
									<td style="text-align: left">
										<div>${review.title }</div>
									</td>
									<td>
										<fmt:formatDate value="${review.regdate }" pattern="yyyy-MM-dd"/>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
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
    <!-- jquery -->
    <script src="${pageContext.request.contextPath}/common/navbar/js/jquery-1.12.1.min.js"></script>
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
	$(function () {
		
		var writer_score_node = $(".review-writerscore-star-orange");
		for (var i = 0; i < writer_score_node.length; i++) {
			var writer_score = writer_score_node.eq(i).attr("rating");
		//	alert(writer_score);
			writer_score_node.eq(i).css("width", (18*writer_score)+"px");
		}	
		
	});
	
	// 배송추적 팝업창
	function showPopup(){
		
		window.open("mytracking.do", "a", "width=400, height=300, left=100, top=50"); 
		
		
	}
	</script>
</body>
</html>