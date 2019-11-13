<%@page import="com.petmeeting.joy.store.model.CartDto"%>
<%@page import="java.util.List"%>
<%@page import="com.petmeeting.joy.login.model.MemberDto"%>
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/store_resources/css/custom.css?after">
<style type="text/css">

table{
width: 970px;
margin: auto;
}

/* img{ */
/* max-width: 100% */
/* } */

#complete{
	margin-bottom: 30px;
	width: 180px;	
}
.product_name{
text-align: left;
}

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
	<header class="header_area">
		<div class="main_menu">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="s-navi-top">
							<div class="s-loginInfo">
								<c:if test="${login == null }">
									<a href="login.do">LOGIN</a>&nbsp;&nbsp;&nbsp;<a
										href="account.do">JOIN</a>
								</c:if>
								<c:if test="${login != null }">
									안녕하세요. <b>${login.nickname }</b>님!&nbsp;&nbsp;&nbsp;<a
										href="logout.do">로그아웃</a>
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
	
<br><br><br><br>
<c:forEach items="${olist }" var="list" varStatus="vs" begin="0" end="0">
<div id="orderCompletMessage" align="center">
	<div><img alt="이미지없음" id="complete" src="${pageContext.request.contextPath}/store_resources/images/orderComplete.png" width="200px"></div>
	<div><h2>고객님의 주문이 완료되었습니다</h2></div>
	<div><b>주문번호</b> : <font color="#E5433E" style="font-weight: bold; font-size: 17px"> ${list.ordernumber }</font></div>
	<div><b>주문일자</b> : <fmt:formatDate value="${list.orderdate }" pattern="yyyy-MM-dd hh:mm:ss"/></div>
</div>
</c:forEach>
<br><br><br>

<table class="orderlist" border="1">
<caption>주문상품내역</caption>
<colgroup>
<col width="200"><col width="250"><col width="120"><col width="150"><col width="200">
</colgroup>
<thead>
	<tr>
		<th colspan="2">상품정보</th>
		<th>수량</th>
		<th>배송비</th>
		<th>주문금액</th>
	</tr>
</thead>
<tbody>
<c:set var="sum" value="0" />
<c:forEach items="${olist }" var="list" varStatus="vs">
	<tr align="center">
		<td>
			<div class="product_img_link">
			<a href="${pageContext.request.contextPath}/productdetail.do?pcode=${list.productcode }">
				<img class="thumbnailImg" alt="이미지 없음" src="upload/${list.filename }" name="filename" width="100px">
			</a>
			</div>
		</td>
		<td>
			<div class="product_name">
				<b><a href="${pageContext.request.contextPath}/productdetail.do?pcode=${list.productcode }">${list.productname }</a></b><br>
					[사이즈] ${list.psize }<br>
					[색상] ${list.pcolor }
			</div>
		</td>
		<td>${list.quantity }</td>
		<c:if test="${vs.count eq 1 }">
			<td rowspan="${fn:length(olist) }" >2,500원</td>
		</c:if>
		<td>₩ <fmt:formatNumber value="${list.price * list.quantity }" pattern="#,###" /></td>
	</tr>
	<c:set var="sum" value="${sum + (list.price * list.quantity) }" />
	</c:forEach>
	<tr>
		<td colspan="5" align="right">
			총 결제금액 ₩ <fmt:formatNumber value="${sum }" pattern="#,###"/>  + 배송비 2,500 &ensp; <c:if test="${not empty usepoint or usepoint ne 0 }"> <b>(사용포인트 ${usepoint }P)</b></c:if> &ensp; | 총 합계 <font color="#E5433E" size="6px" style="font-weight: bold"> ₩<fmt:formatNumber value="${sum + 2500 - usepoint }" pattern="#,###"/> </font>
		</td>
	</tr>
</tbody>
</table>
<br><br><br>

<c:forEach items="${olist }" var="list" varStatus="vs" begin="0" end="0">
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

<br><br>
<div align="center">
<button type="button" class="l-btn" name="main" id="_main" onclick="main()" style="cursor: pointer;">메인으로</button>
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

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

// 총 금액 뿌려주기
var tot = $(".totalP");
var total_p = 0;

for (var i = 0; i < tot.length; i++) {
	var _totalprice = tot.eq(i);
	total_p += parseInt(_totalprice.val());
	
	$("#product_price").text(numberWithCommas(total_p));
}

function main() {
	location.href = "productlist.do";
}

</script>
</body>
</html>