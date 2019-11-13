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
.order-product-list {
	margin: 50px 0;
}
.product-info{
	height: 220px;
	padding: 20px 10px;
	width: 100%;
	border-bottom: 1px solid #e0e0e0;
}
.product-info-ordernumber {
	height: 30px;
	text-align: left;
}
.product-info-img {
	display: inline-block;
	float: left;
}
.product-info-detail {
	display: inline-block;
	width: 50%;
	height: 150px;
	text-align: left;
	float: left;
	margin-left: 20px;
}
.product-info-name {
	font-size: 15px;
	font-weight: 600;
}
.product-info-orderdate {
	margin-top: 40px;
}
.m-btn {
	border-radius: 10px;
}
.button-wrap{
	display: inline-block;
	float: right;
}

td {
	text-align: left;
}

input[name=title] {
	width: 400px;
}

input.review-star-btn {
	width: 24px;
	height: 24px;
	background: url("store_resources/images/star.png") no-repeat;
	border: 0;
	padding: 0;
}

input.review-star-btn-active {
	width: 24px;
	height: 24px;
	background: url("store_resources/images/star-active.png") no-repeat;
	border: 0;
	padding: 0;
}
.file-text{
	font-size: 13px;
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
	color: #555555;
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

.review-list-content-title {
	cursor: pointer;
	display: inline-block;
}

.review-list-content-bottom {
	display: none;
}
div.minimenu-wrap{
	width: 20px;
	height: 20px;
	display: inline-block;
	float: right;
}
.minimenu-wrap-img {
	cursor: pointer;
}

.minimenu-select {
	width: 80px;
	display: none;
}

.minimenu-select ul {
	width: 80px;
	background: #f0f0f0;
	text-align: center;
	margin-left: 10px;
}
.minimenu-select ul li{
	cursor: pointer;
}

.minimenu-select ul li:hover {
	background-color: #9bd3bd;
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
						<li><img src="${pageContext.request.contextPath}/store_resources/images/right-arrow.png" 
							style="width: 10px; height: 10px; margin: 0 5px 5px 0;"><a href="myreview.do">나의 리뷰</a></li>
					</ul>
				</li>
			</ul>
		</div>
		
		<div class="mystore-container">
			
			
					
			<div class="info-wrap">
				<ul class="tab-menu">
					<li class="active"><a href="myreview.do">나의 리뷰</a></li>
					<li><a href="mywritablereview.do">작성 가능 리뷰</a></li>
				</ul>
				<div class="sub-content">
				
					<div class="warning-text">
						<b>내가 작성한 리뷰들을 볼 수 있는 페이지 입니다.<br>
						리뷰 작성은 '작성 가능 리뷰'에서 가능합니다.</b><br><br>
						
						<b><font color="#c80000">※ 아래와 같이 구매후기와 관계없는 글은 관리자 확인 후, 노출제한 될 수 있습니다. </font></b>
						<ul>
							<li>1. 작성한 글은 개인의 의견이므로 게시된 내용에 대한 모든 책임은 작성자에게 있으며, 상품 배송, 교환, 취소 등에 관한 문의사항은 고객센터를 이용해 주시기 바랍니다.</li>
							<li>2. 모든 구매후기는 공개함을 원칙으로 하나 욕설이나 상업적 내용, 게시물의 성격에 맞지 않는 내용은 임의로 삭제될 수 있습니다.</li>
							<li>3. 구매후기에 허위의 사실을 유포하여 다른 회원 또는 제3자에게 피해를 줄 경우 법적인 책임이 따를 수 있으며, 이에 대한 책임은 글을 게시한 당사자에게 있으니 불이익 당하지 않도록 주의하시기 바랍니다.
								<br>(예) 상품을 구매한 것처럼 허위 사실을 기재한 경우, 타 사이트를 고의적으로 홍보, 고의성을 가지고 상품을 폄하하는 경우 등</li>
							<li>4. 타인에 대한 욕설, 비방, 명예훼손, 불성실한 내용, 반복문자, 특정 효능에 있어 오해의 소지가 있는 내용 등 타인의 권리나 명예, 신용 기타 정당한 이익을 침해하는 내용의 경우 임의로 삭제될 수 있습니다.</li>
							<li>5. 개인정보보호와 관련한 피해를 방지하기 위해 주민번호, 전화번호, 이메일, 연락처 등의 내용의 기입은 삼가해 주시기 바라며, 제3자 노출을 방지하기 위해 임의 삭제될 수 있습니다.</li>
						</ul>
					</div>
					
					<div class="search-wrap">
						<form id="search-form">
							<input type="text" style="display: none">	<!-- 엔터 시 폼 제출 안되도록 제어 -->
							<input type="hidden" name="r_pageNumber">
							<select class="search-select" name="r_category">
								<option value="productname">상품명</option>
								<option value="content">내용</option>
							</select>
							<input type="text" name="r_keyword" placeholder="리뷰글을 검색해보세요"><input type="button" class="search-btn">
						</form>
					</div>
					
					<div class="reviews-list">
						<c:if test="${rlist.size() == 0 }">
						<div class="nonlist">
							작성된 리뷰가 없습니다
						</div>
						</c:if>
						<c:forEach items="#{rlist }" var="review">
						<div class="review-list-content" style="text-align: left;">
							<div class="review-list-content-wrap review-list-content-top">
								<div class="review-productinfo" style="display: inline-block; font-size: 15px; transform: translate(0, -3px);">
									<b>${review.productname }</b> [옵션] ${review.psize }, ${review.pcolor }
								</div>
								<div class="review-writerscore">
									<div class="review-writerscore-star-gray">
										<div class="review-writerscore-star-orange" rating=${review.score }></div>
									</div>
								</div>
								<div class="review-regdate">
									<fmt:formatDate value="${review.regdate }" pattern="yyyy-MM-dd HH:mm"/>
								</div>
								<div class="review-list-content-wrap">
									<div class="review-list-content-title">
										<span class="category" style="width: 55px;">한줄평</span> <b>${review.title }</b>
									</div>
									<div class="minimenu-wrap">
										<img class="minimenu-wrap-img" src="${pageContext.request.contextPath}/store_resources/images/menu.png" width="15px" height="15px">
										<div class="minimenu-select">
											<ul>
												<li class="update-review" seq=${review.seq }>수정하기</li>
												<li class="delete-review" seq=${review.seq }>삭제하기</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<div class="review-list-content-wrap review-list-content-bottom">
								<c:forTokens items="${review.filename }" delims="-" var="file">
									<img alt="이미지없음" src="${pageContext.request.contextPath}/upload/${file }" width="100px" height="100px">
								</c:forTokens>
								<div class="review-list-content-wrap">
									${review.content }
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
	
	<!-- Review Modal -->
	<div id="review-modal" class="modal">
		<div class="modal-content">
			<div style="margin-bottom: 20px" >
				<h3 style="display: inline-block">리뷰수정</h3>
				<span class="close">&times;</span>
			</div>
			<div>
				<form id="review-form" method="post" enctype="multipart/form-data">
					<input type="hidden" name="seq" value="">
					<input type="hidden" name="score" value="">
					<table>
						<col width="100px"><col width="500px">
						<tr>
							<th>상품</th>
							<td class="modal-productname"></td>
						</tr>
						<tr>
							<th>평점</th>
							<td>
								<input type="button" class="review-star-btn" score=1>
								<input type="button" class="review-star-btn" score=2>
								<input type="button" class="review-star-btn" score=3>
								<input type="button" class="review-star-btn" score=4>
								<input type="button" class="review-star-btn" score=5>
							</td>
						</tr>
						<tr>
							<th>제목</th>
							<td><input type="text" name="title"></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea rows="5" cols="50" name="content"></textarea></td>
						</tr>
						<tr>
							<th rowspan="2">파일첨부</th>
							<td>
								<input multiple="multiple" type="file" id="_fileload" name="fileload" onchange="limitUpload()">
							</td>
						</tr>
						<tr>
							<td>
								<span class="file-text" id="file-text">※ 파일은 최대 5개까지 업로드 가능합니다.<br></span>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: right">
								<button type="button" id="review-update-btn" class="s-btn">수정하기</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>	
	<!-- Review Modal end -->
	
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
		var r_category = "${param.r_category }";
		var r_keyword = "${param.r_keyword }";
		
		if(r_category != "") {
			$("select[name=r_category]").val(r_category);
			$("input[name=r_keyword]").val(r_keyword);
		}
		
		var writer_score_node = $(".review-writerscore-star-orange");
		for (var i = 0; i < writer_score_node.length; i++) {
			var writer_score = writer_score_node.eq(i).attr("rating");
		//	alert(writer_score);
			writer_score_node.eq(i).css("width", (18*writer_score)+"px");
		}
		
		// 리뷰 제목 누르면 내용 보이기
		$(".review-list-content-title").click(function () {
			if($(this).parent().parent().nextAll(".review-list-content-bottom").css("display") == "none") {
				$(".review-list-content-bottom").css("display", "none");
				$(this).parent().parent().nextAll(".review-list-content-bottom").css("display", "block");
			}else if($(this).parent().parent().nextAll(".review-list-content-bottom").css("display") == "block") {
				$(".review-list-content-bottom").css("display", "none");
			}
		});
		
		// 검색 버튼 클릭 시 검색
		$(".search-btn").click(function () {
			var key_tf = $("input[name=r_keyword]");
			$("input[name=r_pageNumber]").val(0);
			
			if(key_tf.val() == "") {
				alert("검색어를 입력해주세요");
				key_tf.focus();
			}else if(key_tf.val().length < 2){
				alert("검색어는 두 글자 이상만 가능합니다");
				key_tf.focus();
			}else {
				$("#search-form").attr("action", "myreview.do").submit();				
			}
		});
		
		// 수정하기/삭제하기 띄우기
		$(".minimenu-wrap-img").click(function () {
		//	alert("클릭!");
			$(this).next().toggle();
		});
		
		// 영역 밖 클릭 시 수정하기/삭제하기 지우기
		$("html").click(function (e) {
			if(!$(e.target).hasClass("minimenu-wrap-img")) {
			//	alert("영역 밖");
				$(".minimenu-select").css("display", "none");
			}
		});
		
		// 수정하기 클릭
		$(".update-review").click(function () {
			
			$.ajax({
				url: "updatereview.do",
				data: "seq=" + $(this).attr("seq"),
				type: "post",
				success: function (data) {
					// 시퀀스 적용
					$("input[name=seq]").val(data.seq);
					
					// 상품명 적용
					$(".modal-productname").html(data.productname + " [" + data.psize + ", " + data.pcolor + "]");
					
					// 별점 적용
					var star = $(".review-star-btn")
					for (var i = 0; i < data.score; i++) {
						star.eq(i).addClass("review-star-btn-active");
					}
					$("input[name=score]").val(data.score);
					
					// 한줄평적용
					$("input[name=title]").val(data.title);
					
					// 내용 적용
					$("textarea[name=content]").val(data.content);
				},
				error: function () {
					alert("error");
				}
			});
			
			$("#review-modal").css("display", "block");
			
			
		});
		
		// 모달창 닫기
		$(".close").click(function () {
			$(".modal").css("display", "none");
			
			// 별점 초기화
			$(".review-star-btn").removeClass("review-star-btn-active");
		});
		
		// 리뷰 평점버튼 클릭 시
		$(".review-star-btn").click(function () {
			$(this).addClass("review-star-btn-active");
			$(this).prevAll().addClass("review-star-btn-active");
			
			$(this).nextAll().removeClass("review-star-btn-active");
			
			var score = $(this).attr("score");
			$("input[name=score]").val(score);
		});
		
		// 리뷰 수정하기 버튼 클릭 
		$("#review-update-btn").click(function () {
			var score = $("input[name=score]").val();
			var title = $("input[name=title]").val();
			var content = $("textarea[name=content]").val();
			
			if(score == "") {
				alert("평점을 선택해주세요");
			}else if(title == "") {
				alert("제목을 입력해주세요");
			}else if(content == "") {
				alert("내용을 입력해주세요");
			}else {
				$("#review-form").attr("action", "updatereviewAf.do").submit();				
			}
		});
		
		// 삭제하기 클릭
		$(".delete-review").click(function () {
		//	alert($(this).attr("seq"));
			if(confirm("정말로 삭제하시겠습니까?")) {
				location.href = "delreview.do?seq=" + $(this).attr("seq");
			}
		});
	});
	
	// 파일 업로드 갯수 제한함수
	function limitUpload() {
		var load = document.getElementById("_fileload");
		var txt = "※ 파일은 최대 5개까지 업로드 가능합니다.<br>";
		
		if ('files' in load) {
			if (load.files.length > 5) {
				alert("파일은 최대 5개까지 등록할 수 있습니다.");
				load.value = "";
			}else {
				for (var i = 0; i < load.files.length; i++) {
					var file = load.files[i];
				
					if ('name' in file) {
					  txt += "파일" + (i+1) + " : " + file.name + "<br>";
					}
				}				
			}
		}

		document.getElementById("file-text").innerHTML = txt;
		
	}	
	
	function goPage(type, pageNumber) {
		$("input[name=r_pageNumber]").val(pageNumber);
		$("#search-form").attr("action", "myreview.do").submit();	
	}
	</script>
</body>
</html>