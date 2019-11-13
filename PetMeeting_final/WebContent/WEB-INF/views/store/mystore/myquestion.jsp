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
.warning-text {
	text-align: left;
	padding: 20px 10px;
	margin-bottom: 20px;
	background-color: #f0f0f0;
	border-radius: 10px;
}
.qna-list-questionInfo {
	cursor: pointer;
}
div.qna-list-questionInfo-image{
	width: 10%;
	min-width: 80px;
	display: inline-block;
}
div.qna-list-questionInfo-text {
	width: 85%;
	display: inline-block;
	transform: translate(0, 10px);
	padding: 5px;
}
div.qna-list-questionInfo-image img {
	width: 80px;
	height: 80px;
	border-radius: 40px;
}
div.qna-list-questionInfo-name {
	padding: 5px;
}
div.qna-contents {
	display: none;
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
						<li><img src="${pageContext.request.contextPath}/store_resources/images/right-arrow.png" 
							style="width: 10px; height: 10px; margin: 0 5px 5px 0;"><a href="myquestion.do">나의 문의</a></li>
						<li><a href="myreview.do">나의 리뷰</a></li>
					</ul>
				</li>
			</ul>
		</div>
		
		<div class="mystore-container">
			<div class="info-wrap">
				<div class="sub-title">
					<h3>나의 문의 내역</h3>
				</div>
				<div class="sub-content">
					<div class="warning-text">
						<b>내가 작성한 문의글을 확인할 수 있는 페이지 입니다.<br>
						문의글 작성은 상품의 상세 페이지에서 작성이 가능합니다.</b><br><br>
						
						<b><font color="#c80000">※ 아래와 같이 상품문의와 관계없는 글은 관리자 확인 후, 노출제한 될 수 있습니다. </font></b>
						<ul>
							<li>1. 구매한 상품의 취소/반품은 <b>마이페이지 구매내역</b>에서 신청 가능합니다.</li>
							<li>2. 상품문의을 통해 취소나 환불, 반품 등은 처리되지 않습니다.</li>
							<li>3. "해당 상품 자체"와 관계없는 글, 양도, 광고성, 욕설, 비방, 도배 등의 글은 예고 없이 이동, 노출제한, 삭제 등의 조치가 취해질 수 있습니다.</li>
							<li>4. 공개 게시판이므로 전화번호, 메일 주소 등 <b>고객님의 소중한 개인정보는 절대 남기지 말아주세요.</b></li>
						</ul>
					</div>
					
					<div class="search-wrap">
						<form id="search-form">
							<input type="text" style="display: none">	<!-- 엔터 시 폼 제출 안되도록 제어 -->
							<input type="hidden" name="q_pageNumber">
							<select class="search-select" name="q_category">
								<option value="productname">상품명</option>
								<option value="content">내용</option>
							</select>
							<input type="text" name="q_keyword" placeholder="문의글을 검색해보세요"><input type="button" class="search-btn">
						</form>
					</div>
					
					<c:if test="${qlist.size() == 0 }">
					<div class="nonlist">
						작성된 문의글이 없습니다
					</div>
					</c:if>
					<div class="qnas-list" style="text-align: left">
						<c:forEach items="${qlist }" var="qbean">
						<div class="qna-list-content">
							<div class="qna-list-questionInfo">
								<div class="qna-list-questionInfo-image">
									<img alt="이미지없음" src="${pageContext.request.contextPath}/upload/${qbean.p_filename}">
								</div>
								<div class="qna-list-questionInfo-text">
									<div class="qna-list-questionInfo-name">
										<b>${qbean.productname }</b>
										<span class="qna-regdate"><fmt:formatDate value="${qbean.q_regdate }" pattern="yyyy-MM-dd HH:mm"/></span>
									</div>
									<div class="qna-list-questionInfo-qcontent">
										<span class="category">${qbean.category }</span>
										${qbean.q_content }
									</div>
								</div>
							</div>
							<div class="qna-contents">
								<div style="display: inline-block; float: left; margin: 10px 10px 10px 50px">
									<img alt="이미지없음" src="${pageContext.request.contextPath}/store_resources/images/enter-arrow.png" width="20px" height="20px">
								</div>				
								<div class="qna-acontent">
									<c:if test="${qbean.a_content == null }">
										[판매자의 답변 대기중 입니다]
									</c:if>
									<c:if test="${qbean.a_content != null }">
										${qbean.a_content }									
									</c:if>
								</div>
							</div>
						</div>
						</c:forEach>
					</div>
					<div class="paging-wrap">
						<jsp:include page="/WEB-INF/views/store/mystore/paging.jsp" flush="false">
							<jsp:param name="" value="type" />
							<jsp:param name="pageNumber" value="${pageNumber }"/>		
							<jsp:param name="totalRecordCount" value="${totalRecordCount }"/>	
							<jsp:param name="pageCountPerScreen" value="${pageCountPerScreen }"/>	
							<jsp:param name="recordCountPerPage" value="${recordCountPerPage }"/>	
						</jsp:include>
					</div>
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
		// 검색 페이징
		var q_category = "${param.q_category }";
		var q_keyword = "${param.q_keyword }";
		
		if(q_category != "") {
			$("select[name=q_category]").val(q_category);
			$("input[name=q_keyword]").val(q_keyword);
		}
		
		// 문의글 누르면 답변 보이기
		$(".qna-list-questionInfo").click(function () {
			if($(this).nextAll(".qna-contents").css("display") == "none") {
				$(".qna-contents").css("display", "none");
				$(this).nextAll(".qna-contents").css("display", "block");
			}else if($(this).nextAll(".qna-contents").css("display") == "block") {
				$(".qna-contents").css("display", "none");
			}
		});
		
		// 검색버튼 클릭 시 검색 폼 제출
		$(".search-btn").click(function () {
			var key_tf = $("input[name=q_keyword]");
			$("input[name=q_pageNumber]").val(0);
			
			if(key_tf.val() == "") {
				alert("검색어를 입력해주세요");
				key_tf.focus();
			}else if(key_tf.val().length < 2){
				alert("검색어는 두 글자 이상만 가능합니다");
				key_tf.focus();
			}else {
				$("#search-form").attr("action", "myquestion.do").submit();				
			}
		});
		
	});
	
	function goPage(type, pageNumber) {
		$("input[name=q_pageNumber]").val(pageNumber);
		$("#search-form").attr("action", "myquestion.do").submit();	
	}
	</script>
</body>
</html>