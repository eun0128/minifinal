<%@page import="com.petmeeting.joy.store.model.CartDto"%>
<%@page import="com.petmeeting.joy.login.model.MemberDto"%>
<%@page import="com.petmeeting.joy.util.ProductUtility"%>
<%@page import="com.petmeeting.joy.store.model.ProductDto"%>
<%@page import="java.util.List"%>
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
    <!-- Image Slider -->
	<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<style type="text/css">
.pro-img img{
	width: 300px;
	height: 300px;
	border-radius: 5px;
	position: relative;
	opacity: 1;
}
li.list-slider-li ul.pro-list li {
	margin-bottom: 0;
}
span.soldout{
	background: #c80000;
	color: #fff;
	font-size: 12px;
	padding: 3px;
	border-radius: 4px;
	font-weight: 700;
} 

.more-wrap {
	text-align: center;
}

.more-btn {
	background-color: #fff;
	border: 2px solid #333;
	border-radius: 5px;
	width: 150px;
	height: 50px;
	font-size: 20px;
	color: #333;
	font-weight: 800;
}

.more-btn:hover {
	background: #fff;
}

.s-text b {
	font-size: 17px;
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
		
		<!-- Recommend Product Part Start -->
		<div class="s-list-wrap" style="margin-bottom: 50px;">
			<div class="s-title" style="width: 1000px; margin: 30px auto;">
				<h3>MD 추천상품</h3>
			</div>
			<div id="list-slider-wrapper">
				<div id="list-slider-wrap">
					<ul id="list-slider">
						<li class="list-slider-li">
							<ul class="pro-list">
								<c:forEach items="${recommlist }" var="recommPro" begin="0" end="2">
								<li pcode="${recommPro.productcode }">
									<div class="pro-img">
										<img alt="이미지없음" src="upload/${recommPro.filename }">
									</div>
									<div class="s-text">
										<b>${recommPro.productname }</b>
									</div>
									<div class="s-text">
										<fmt:formatNumber value="${recommPro.price }" pattern="#,###"/>원
									</div>
								</li>
								</c:forEach>
							</ul>
						</li>
						<li class="list-slider-li">
							<ul class="pro-list">
								<c:forEach items="${recommlist }" var="recommPro" begin="3" end="5">
								<li pcode="${recommPro.productcode }">
									<div class="pro-img">
										<img alt="이미지없음" src="upload/${recommPro.filename }">
									</div>
									<div class="s-text">
										<b>${recommPro.productname }</b>
									</div>
									<div class="s-text">
										<fmt:formatNumber value="${recommPro.price }" pattern="#,###"/>원
									</div>
								</li>
								</c:forEach>
							</ul>
						</li>
					</ul>
					<!--controls-->
					<div class="btns" id="next"><i class="fa fa-arrow-right"></i></div>
					<div class="btns" id="previous"><i class="fa fa-arrow-left"></i></div>
					<!--controls-->  
				</div>
			</div>
		</div>
		<!-- Recommend Product Part End -->
		
		<!-- All Product part start -->
		<div id="all-product" style="padding: 30px">
		</div>
		<div class="s-list-wrap">
			<div class="s-title" style="width: 1000px; margin: 30px auto;">
				<h3>All Product</h3>
			</div>
			
			<div class="search-wrap">
				<form id="search-form" method="post">
					<input type="hidden" name="list_count" value=0>
					<div style="float: left; display: inline-block; margin-top: 5px; margin-left: 50px;">
						<select style="width: 130px;" class="search-select" name="p_sorting">
							<option value="latest">최신순</option>
							<option value="highprice">높은가격순</option>
							<option value="lowprice">낮은가격순</option>
						</select>
					</div>
					<input type="text" name="p_keyword" placeholder="상품명을 검색해보세요"><input type="button" class="search-btn">
					<input type="text" style="display: none">
				</form>
			</div>
			
			<ul class="pro-list" id="pro-list">
				<c:forEach items="${plist }" var="pro">
				<li pcode="${pro.productcode }">
					<div class="pro-img hover">
						<img alt="이미지없음" src="upload/${pro.filename }">
					</div>
					<div class="s-text">
						<b>${pro.productname }</b>
						<c:if test="${pro.soldout }">
							<span class="soldout">품절</span>
						</c:if>
					</div>
					<div class="s-text">
						<fmt:formatNumber value="${pro.price }" pattern="#,###"/>원
					</div>
				</li>
				</c:forEach>
			</ul>
		</div>
		<div class="more-wrap" style="margin-bottom: 150px;">
			<button type="button" class="more-btn">Load More+</button>
		</div>
		<!-- Total Content part end -->
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
	// 검색 시 파라미터 유지
	var p_sorting = "${p_param.p_sorting }"
	var p_keyword = "${p_param.p_keyword }"
	
	$("select[name=p_sorting]").val(p_sorting);
	$("input[name=p_keyword]").val(p_keyword);
	
	$(".hover").mouseleave(function () {
		$(this).removeClass("hover");
	});
	
	$(document).on("click", ".pro-list li", function () {
	//	alert($(this).attr("pcode"));
		location.href="productdetail.do?pcode=" + $(this).attr("pcode");
	});
	
	// 검색버튼 클릭 시 검색폼 제출
	$(".search-btn").click(function () {
		$("#search-form").attr("action", "productlist.do#all-product").submit();
	});
	
	// 정렬 셀렉트박스 변경 시 검색 폼 제출
	$("select[name=p_sorting]").change(function () {
		$("#search-form").attr("action", "productlist.do#all-product").submit();
	});
	
	// 더보기 ajax
	$(".more-btn").click(function () {
	//	alert("더보기 클릭");
		
		var list_count = $("#pro-list li").length;
	//	alert(list_count);
		$("input[name=list_count]").val(list_count);
	
		$.ajax({
			url: "productmore.do",
			data: $("#search-form").serialize(),
			type: "post",
			dataType: "json",
			async: false,
			success: function (data) {
			//	alert(data.plist_count);
				if(data.plist_count > 0) {
					addList(data.plist_more);
				}else {
					alert("더 이상 불러올 목록이 없습니다.");					
				}
			},
			error: function () {
				alert("error");
			}
		});
		
	});
	
	function addList(list) {
		var length = list.length;
		var html = "";
		
		for (var i = 0; i < length; i++) {
			var pro = list[i];
		//	alert(pro.productname);
			html += "<li pcode='"+ pro.productcode + "' class='animated fadeIn'>"
			html += "<div class='pro-img'><img alt='이미지없음' src='upload/" + pro.filename + "'></div>"
			html += "<div class='s-text'><b>" + pro.productname + "</b>&nbsp;&nbsp;"
			if(pro.soldout) {
				html += "<span class='soldout'>품절</span>"
			}
			html += "</div>";
			html += "<div class='s-text'>" + numberWithCommas(pro.price) + "원</div>"
			html += "</li>";
		}
		
		$("#pro-list").append(html);
	}
	
	// 금액 포맷
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	
	// 리스트 슬라이더 
	//current position
	var pos = 0;
	//number of slides
	var totalSlides = $('#list-slider').children().length;
	//get the slide width
	var sliderWidth = $('#list-slider-wrap').width();
	
	autoSlider = setInterval(slideRight, 5000);
	
	  $('#list-slider-wrap ul#list-slider').width(sliderWidth*totalSlides);
	  $('#listslider-wrap ul#list-slider').css('left', -(sliderWidth*pos));
	  //next slide
	  $('#next').click(function(){
	      slideRight();
	  });
	  
	  //previous slide
	  $('#previous').click(function(){
	      slideLeft();
	  });
	
	  /***********
	SLIDE LEFT
	************/
	function slideLeft(){
	   pos--;
	   if(pos==-1){ pos = totalSlides-1; }
	   $('#list-slider-wrap ul#list-slider').css('left', -(sliderWidth*pos));    
	}
	
	
	/************
	SLIDE RIGHT
	*************/
	function slideRight(){
		pos++;
		if(pos==totalSlides){ pos = 0; }
		$('#list-slider-wrap ul#list-slider').css('left', -(sliderWidth*pos)); 
	}
	
	$('#list-slider-wrap').hover(
	    function(){ $(this).addClass('active'); clearInterval(autoSlider); }, 
	    function(){ $(this).removeClass('active'); autoSlider = setInterval(slideRight, 5000); }
	);
	   
	
});
</script>


</body>
</html>