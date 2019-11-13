<%@page import="com.petmeeting.joy.login.model.MemberDto"%>
<%@page import="com.petmeeting.joy.util.ProductUtility"%>
<%@page import="com.petmeeting.joy.store.model.CartDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
#cart-btn{
	margin: 50px 0;
	text-align: center;
}

#cart-table {
	width: 870px;
	margin: auto;
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
		<%
		List<CartDto> clist = (List<CartDto>)request.getAttribute("clist");
		%>
		<div class="s-title" style="text-align: center">
			<h2>Cart</h2>
		</div>
		<div id="cart-table">
			<form id="cart-form">
				<table border="1">
					<colgroup>
						<col width="70px"><col width="120px"><col width="300px">
						<col width="120px"><col width="150px"><col width="150px">
					</colgroup>
					<thead>
						<tr>
							<th><input type="checkbox" id="all-check"></th>
							<th colspan="2">상품정보</th>
							<th>수량</th>
							<th>가격</th>
							<th>배송비</th>
						</tr>
					</thead>
					<tbody>
						<%
						if(clist == null || clist.size() == 0) {
							%>
							<tr>
								<td colspan="6">장바구니에 등록된 상품이 없습니다.</td>
							</tr>
							<%
						}else {
							for(int i = 0; i < clist.size(); i++) {
								CartDto cart = clist.get(i);
								%>
								<tr>
									<td>
										<%
										if(cart.isSoldout()) {
										%>
											<span style="color: #c80000; font-weight: 800">품절</span>
										<%	
										}else {
										%>
											<input type="checkbox" class="del-check" name="index" value=<%=i %>>
										<%
										}
										%>
									</td>
									<td>
										<img alt="이미지없음" src="upload/<%=cart.getFilename() %>" width="100px" height="auto">
									</td>
									<td style="text-align: left">
										<div class="s-text" style="font-size: 17px;"><b><%=cart.getProductname() %></b></div>
										<div class="s-text">사이즈 : <%=cart.getPsize() %></div>
										<div class="s-text">색상 : <%=cart.getPcolor() %></div>
									</td>
									<td>
										<%
										if(cart.isSoldout()) {
										%>
											<span style="color: #c80000; font-weight: 800">품절</span>
										<%	
										}else {
										%>
											<button type="button" id="minus-btn" class="plus-minus-btn">-</button>
											<input type="text" name="quantity" value=<%=cart.getQuantity() %> onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" style="width: 20px;">
											<button type="button" id="plus-btn" class="plus-minus-btn">+</button>
											<input type="hidden" class="price" value=<%=cart.getPrice() %>>
										<%
										}
										%>
									</td>
									<td class="totalprice-td">
										<%
										if(cart.isSoldout()) {
										%>
											<span style="color: #c80000; font-weight: 800">품절</span>
										<%	
										}else {
										%>
											<input type="hidden" class="totalprice" value=<%=cart.getTotalprice() %>>
											<span class="totalprice-text"><%=ProductUtility.priceFormat(cart.getTotalprice()) %>원</span>
										<%
										}
										%>
									</td>
								<%
								if(i == 0) {
									%>
									<td rowspan="<%=clist.size() %>" style="text-align: center">2,500원</td>
									<%
								}
								%>
								</tr>
								<%
							}	
						}
						%>
						<tr>
							<td colspan="6" style="text-align: left">
								<button type="button" class="s-btn" id="delete-btn">선택상품 삭제</button>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		<c:if test="${clist != null && clist.size() > 0}">
		<div class="total">
			<div>
				<span id="product-price"></span>&nbsp;&nbsp; +  &nbsp;&nbsp;<span>2,500원</span>&nbsp;&nbsp;  =  &nbsp;&nbsp;<span class="total-price" id="total-price"></span>
			</div>
		</div>
		</c:if>
		<div id="cart-btn">
			<button type="button" class="l-btn" id="list-btn">계속쇼핑하기</button>
			<button type="button" class="l-btn" id="order-btn">주문하기</button>
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
	// checkbox 전부 체크
	$("#all-check").prop("checked", true);
	$(".del-check").prop("checked", true);
	
	// 금액합계
	setTotalprice();
	
	$(".del-check").change(setTotalprice);
	
	// table head의 체크박스 클릭 시 전체 체크박스 클릭
	$("#all-check").click(function () {
	//	alert($(this).prop("checked"));
		if($(this).prop("checked")) {
			$(".del-check").prop("checked", true);
		}else {
			$(".del-check").prop("checked", false);
		}
		
		setTotalprice();
	});
	
	// 수량 변경 시 total price 변경 / 장바구니세션 변경
	$("input[name=quantity]").change(function () {
		// 장바구니 세션 변경
		var tr = $(this).parent().parent();
		var index = tr.children().eq(0).children("input[name=index]").val();
	//	alert(index);
		var quantity = parseInt($(this).val());	
	//	alert(quantity);
		
		if(quantity < 1) {
			alert("최소 1개 이상 입력 가능합니다");
			$(this).val(1);
			quantity = 1;
		}else if(quantity > 10) {
			alert("11개 이상 주문은 문의전화 부탁드립니다");
			$(this).val(10);
			quantity = 10;
		}
		
		$.ajax({
			url: "cartupdate2.do",
			data: "index=" + index + "&quantity=" + quantity,
			type: "post",
			success: function () {
			//	alert("success");
			},
			error: function () {
				alert("error");
			}
		});
	
		// 장바구니 total price 변경..
		var price = parseInt($(this).parent().children(".price").val());
		var total = parseInt(price * quantity);
	//	alert(total);
	//	alert(price);
		tr.children(".totalprice-td").children(".totalprice-text").text(numberWithCommas(total) + "원");
		tr.children(".totalprice-td").children(".totalprice").val(total);
	
		setTotalprice();
	});
	
	// 수량 + - 버튼 클릭 시 텍스트필드값 변경 및 합계수량 변경
	$(".plus-minus-btn").click(function () {
		var quantity_tf = $(this).parent().children("input[name=quantity]");
		var quantity = parseInt(quantity_tf.val());
		
		if($(this).attr("id") == "plus-btn") {
			if(quantity >= 10) {
				alert("11개 이상 주문은 문의전화 부탁드립니다.");
				return;
			}
			quantity_tf.val(quantity + 1);
		}else if($(this).attr("id") == "minus-btn") {
			if(quantity <= 1) {
				alert("최소 1개 이상 입력 가능합니다");
				return;
			}
			quantity_tf.val(quantity - 1);
		}
		
		var tr = $(this).parent().parent();
		var index = tr.children().eq(0).children("input[name=index]").val();
	//	alert(index);
	
		var update_quantity = parseInt(quantity_tf.val());	
	//	alert(update_quantity);
		
		$.ajax({
			url: "cartupdate2.do",
			data: "index=" + index + "&quantity=" + update_quantity,
			type: "post",
			success: function () {
			//	alert("success");
			},
			error: function () {
				alert("error");
			}
		});
		
		// 장바구니 total price 변경..
		var price = parseInt($(this).parent().children(".price").val());
		var total = parseInt(price * update_quantity);
	
		tr.children(".totalprice-td").children(".totalprice-text").text(numberWithCommas(total) + "원");
		tr.children(".totalprice-td").children(".totalprice").val(total);
		
		setTotalprice();
		
	})
	
	// 선택상품 삭제버튼 클릭
	$("#delete-btn").click(function () {
		if($("input:checkbox[name='index']").is(":checked") == false){
			alert("삭제할 상품을 한 개 이상 선택하세요");
		}else{
			if(confirm("정말로 삭제하시겠습니까?")){
				$("#cart-form").attr("action", "cartdelete.do").submit();
			}
		}
	});
	
	// 계속 쇼핑하기 버튼 클릭
	$("#list-btn").click(function () {
		location.href="productlist.do";
	});
	
	// 금액 포맷
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	// total 금액세팅함수
	function setTotalprice() {
		var len = $(".del-check").length;
		var product_price = 0;
		
		for (var i = 0; i < len; i++) {
			if($(".del-check").eq(i).prop("checked")) {
				var tr =$(".del-check").eq(i).parent().parent();
				var totalprice = tr.children(".totalprice-td").children(".totalprice").val();
				
				product_price += parseInt($(".totalprice").eq(i).val());
			}
		}
	//	alert(product_price);
		$("#product-price").text(numberWithCommas(product_price)+ "원");
		$("#total-price").text(numberWithCommas(product_price + 2500) + "원");
		
	}

	$("#order-btn").click(function () {
		if($("input:checkbox[name='index']").is(":checked") == false){
			alert("주문할 상품을 한 개 이상 선택하세요");
		}else{
			$("#cart-form").attr("action", "cartorder.do").submit();
		}
	});
});
</script>
</body>
</html>