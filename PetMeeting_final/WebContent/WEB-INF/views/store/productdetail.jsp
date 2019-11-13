<%@page import="com.petmeeting.joy.store.model.CartDto"%>
<%@page import="java.util.List"%>
<%@page import="com.petmeeting.joy.store.model.ProductOptionDto"%>
<%@page import="com.petmeeting.joy.login.model.MemberDto"%>
<%@page import="com.petmeeting.joy.util.ProductUtility"%>
<%@page import="com.petmeeting.joy.store.model.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>

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
	
	<!-- kakao api -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
		
	
<style type="text/css">
#product-order{
	width: 100%;
	height: 500px;
	margin-bottom: 50px;
}
#product-img{
	width: 40%;
	float: left;
}
#product-info{
	width: 50%;
	float: right;
}
#product-detail{
	margin-bottom: 20px;
}
#product-options{
	margin-bottom: 20px;
}
#product-category {
	color: #999
}
#product-name {
	font-size: 20px;
	font-weight: bold;
}
#product-totalprice {
	font-size: 20px;
	font-weight: 600;
	color: #333;
	margin-bottom: 20px;
	width: 60%;
	border-radius: 10px;
	text-align: right;
	padding: 10px;
}
#product-price {
	font-size: 18px;
}

#sub-navbar {
	overflow: hidden;
	background: #fff;
	margin-bottom: 20px;
	border-bottom: 1px solid #999;
	border-top: 1px solid #999;
	z-index: 1;
}
.s-text h3 {
	margin: 30px 0;
}

.others-content {
	padding: 20px;
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
		ProductBean pbean = (ProductBean)request.getAttribute("pbean");
		%>
		<div class="s-text" style="margin: 0 auto;">
			<h3>Product Detail</h3>
		</div>
		<div id="product-order">
			<div id="product-img">
				<img alt="이미지없음" src="upload/${pbean.filename }" style="max-height: 500px; width: 500px; height: auto" >
			</div>
			<div id="product-info">
				<form id="order-form" method="post">
					<input type="hidden" name="productcode" value="${pbean.productcode }">
					<input type="hidden" name="productname" value="${pbean.productname }">
					<input type="hidden" name="filename" value="${pbean.filename }">
					<input type="hidden" name="price" value="${pbean.price }">
					<div id="product-detail">
						<div id="product-category" class="s-text">
							[${pbean.category }]
						</div>
						<div id="product-name" class="s-text">
							<div style="display: inline-block; transform: translate(0, 3px); margin-right: 20px;">${pbean.productname }</div>
							<a id="kakao-link-btn" href="javascript:sendLink()">
								<!-- <img src="//developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png"/> -->
								<img width="30px" height="30px" title="카카오톡 공유하기" src="${pageContext.request.contextPath}/store_resources/images/share.png">
							</a>
						</div>
						<div id="product-price" class="s-text">
							 ₩ <fmt:formatNumber value="${pbean.price }" pattern="#,###"/>
						</div>
					</div>
					<div id="product-options">
						<div id="product-size" class="s-text">
							<span class="sub-head">SIZE : </span>
							<select name="psize">
								<option value="">---------</option>
								<%
								String[] psize = pbean.getPsize();
								for(int i = 0; i < psize.length; i++) {
									%>
									<option value="<%=psize[i] %>"><%=psize[i] %></option>
									<%
								}
								%>
							</select>
						</div>
						<div id="product-color" class="s-text">
							<span class="sub-head">COLOR : </span>
							<select name="pcolor">
								<option value="">---------</option>
								<%
								String[] pcolor = pbean.getPcolor();
								for(int i = 0; i < pcolor.length; i++) {
									%>
									<option value="<%=pcolor[i] %>"><%=pcolor[i] %></option>
									<%
								}
								%>
							</select>
						</div>
						<div id="product-quantity" class="s-text">
							<span class="sub-head">QUANTITY :</span> 
							<button type="button" id="minus-btn" class="plus-minus-btn">-</button>
							<input type="text" name="quantity" value=1  onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
							<button type="button" id="plus-btn" class="plus-minus-btn">+</button>
						</div>
					</div>

					<div id="product-totalprice" class="s-text">
						TOTAL : ₩ <span id="total-price"><fmt:formatNumber value="${pbean.price }" pattern="#,###"/></span>
						<input type="hidden" name="totalprice" value=${pbean.price }>
					</div>

					<div id="order-buttons" class="s-text">
						<c:if test="${pbean.soldout }">
							<button type="button" class="m-btn" disabled="disabled">SOLD OUT</button>
						</c:if>
						<c:if test="${!pbean.soldout }">
							<button type="button" class="m-btn" id="addCart-btn">ADD CART</button>
							<button type="button" class="m-btn" id="order-btn">ORDER NOW</button>
						</c:if>
					</div>
				</form>
			</div>
		</div>
		<div id="others">
			<div id="sub-navbar">
				<ul id="menu-tab">
					<li><a href="#product-details">Detail</a></li>
					<li><a href="#product-reviews">Review</a></li>
					<li><a href="#product-qnas">Q & A</a></li>
				</ul>
			</div>
			<div id="product-details" class="others-content">
				<h3>Detail</h3>
				<div>
					${pbean.content }
				</div>
			</div>
			<div id="product-reviews" class="others-content">
				<div class="s-title">
					<h3>Review</h3>
				</div>
				<div class="s-text" style="padding-bottom: 20px; border-bottom: 2px solid #093a2770; margin-bottom: 30px;">
					<div style="height: 25px; vertical-align: center;">
						<img src="store_resources/images/alert.png" width="20px" height="20px">
						<h5 style="display: inline-block; margin: 0px 5px; font-weight: bold; color: #e46156">주의사항</h5>
					</div>
					<ul>
						<li>리뷰작성은 구매자에 한하여 <b>마이페이지 나의리뷰</b>에서 작성 가능합니다.</li>
						<li>상품문의 및 후기게시판을 통해 취소나 환불, 반품 등은 처리되지 않습니다.</li>
						<li>"해당 상품 자체"와 관계없는 글, 양도, 광고성, 욕설, 비방, 도배 등의 글은 예고 없이 이동, 노출제한, 삭제 등의 조치가 취해질 수 있습니다.</li>
						<li>공개 게시판이므로 전화번호, 메일 주소 등 <b>고객님의 소중한 개인정보는 절대 남기지 말아주세요.</b></li>
					</ul>
				</div>
				<div class="review-score">
					<div class="review-score-star">
						<div class="review-score-star-avg" rating=${pbean.score }></div>
					</div>
					<div class="review-score-text">
						${pbean.score }
					</div>
				</div>
				
				<div class="search-wrap">
					<form id="review-search-form" method="post">
						<input type="text" style="display: none">	<!-- 엔터 시 폼 제출 안되도록 제어 -->
						<div style="float: left; display: inline-block; margin-top: 5px">
							<select style="width: 130px;" class="search-select" name="r_sorting">
								<option value="latest">최신순</option>
								<option value="highscore">높은별점순</option>
								<option value="lowscore">낮은별점순</option>
							</select>
						</div>
						<input type="hidden" name="r_pageNumber" id="r_pageNumber">
						<input type="hidden" name="pcode" value="${pbean.productcode }">
						<select class="search-select" name="r_category">
							<option value="nickname">닉네임</option>
							<option value="content">내용</option>
						</select>
						<input type="text" name="r_keyword" placeholder="리뷰글을 검색해보세요"><input type="button" id="review-search-btn" class="search-btn">
					</form>
				</div>
					
				<div class="reviews-list">
					<c:if test="${rlist.size() == 0 }">
					<div class="nonlist">
						작성된 리뷰가 없습니다
					</div>
					</c:if>
					<c:forEach items="#{rlist }" var="review">
					<div class="review-list-content">
						<div class="review-list-content-wrap review-list-content-top">
							<div class="review-nickname">
								${review.nickname }
							</div>
							<div class="review-writerscore">
								<div class="review-writerscore-star-gray">
									<div class="review-writerscore-star-orange" rating=${review.score }></div>
								</div>
							</div>
							<div class="review-regdate">
								<fmt:formatDate value="${review.regdate }" pattern="yyyy-MM-dd HH:mm"/>
							</div>
							<div class="review-productinfo">
								${review.productname } [옵션] ${review.psize }, ${review.pcolor }
							</div>
						</div>
						
						<div class="review-list-content-wrap">
							<c:forTokens items="${review.filename }" delims="-" var="file" varStatus="vs">
								<img alt="이미지없음" src="${pageContext.request.contextPath}/upload/${file }" width="100px" height="100px" pos=${vs.index }>
							</c:forTokens>
						</div>
						
						<div class="review-list-content-wrap">
							<span class="category" style="width: 55px;">한줄평</span> <b>${review.title }</b>
						</div>
						<div class="review-list-content-wrap">
							${review.content }
						</div>
					</div>
					</c:forEach>
				</div>
				
				<div class="paging-wrap">
					<jsp:include page="/WEB-INF/views/store/mystore/paging.jsp" flush="false">
						<jsp:param name="type" value="review"/>
						<jsp:param name="pageNumber" value="${r_pageNumber }"/>		
						<jsp:param name="totalRecordCount" value="${r_totalRecordCount }"/>	
						<jsp:param name="pageCountPerScreen" value="${r_pageCountPerScreen }"/>	
						<jsp:param name="recordCountPerPage" value="${r_recordCountPerPage }"/>	
					</jsp:include>
				</div>
				
			</div>
			
			<div id="product-qnas" class="others-content">
				<div class="s-title" style="height: 50px;">
					<h3 style="display: inline-block; float: left">Q & A</h3>
					<button type="button" id="qna-btn" class="m-btn" style="margin-top: 0px; float: right;">문의하기</button>
				</div>
				<div>
					<div class="s-text" style="padding-bottom: 20px; border-bottom: 2px solid #093a2770; margin-bottom: 30px;">
						<div style="height: 25px; vertical-align: center;">
							<img src="store_resources/images/alert.png" width="20px" height="20px">
							<h5 style="display: inline-block; margin: 0px 5px; font-weight: bold; color: #e46156">주의사항</h5>
						</div>
						<ul>
							<li>구매한 상품의 취소/반품은 <b>마이페이지 구매내역</b>에서 신청 가능합니다.</li>
							<li>상품문의 및 후기게시판을 통해 취소나 환불, 반품 등은 처리되지 않습니다.</li>
							<li>"해당 상품 자체"와 관계없는 글, 양도, 광고성, 욕설, 비방, 도배 등의 글은 예고 없이 이동, 노출제한, 삭제 등의 조치가 취해질 수 있습니다.</li>
							<li>공개 게시판이므로 전화번호, 메일 주소 등 <b>고객님의 소중한 개인정보는 절대 남기지 말아주세요.</b></li>
						</ul>
					</div>
					
					<div class="search-wrap">
						<form id="qna-search-form" method="post">
							<input type="text" style="display: none">	<!-- 엔터 시 폼 제출 안되도록 제어 -->
							<div style="float: left; display: inline-block; margin-top: 5px">
								<select style="width: 130px;" class="search-select" name="q_sorting">
									<option value="">전체</option>
									<option value="product">상품</option>
									<option value="delivery">배송</option>
									<option value="etc">기타</option>
								</select>
							</div>
						
							<input type="hidden" name="q_pageNumber" id="q_pageNumber">
							<input type="hidden" name="pcode" value="${pbean.productcode }">
							<select class="search-select" name="q_category">
								<option value="nickname">닉네임</option>
								<option value="content">내용</option>
							</select>
							<input type="text" name="q_keyword" placeholder="문의글을 검색해보세요"><input type="button" id="qna-search-btn" class="search-btn">
						</form>
					</div>
					
					<c:if test="${qlist.size() == 0 }">
					<div class="nonlist">
						작성된 문의글이 없습니다
					</div>
					</c:if>
					<div class="qnas-list">
						<c:forEach items="${qlist }" var="qbean">
						<div class="qna-list-content">
							<div class="s-text">
								<span class="category">${qbean.category }</span>
								<b>${qbean.nickname }</b>
								<span class="qna-regdate"><fmt:formatDate value="${qbean.q_regdate }" pattern="yyyy-MM-dd HH:mm"/></span>
							</div>
							<div class="qna-contents">
								<div class="qna-qcontent">
									${qbean.q_content }
								</div>
								<div style="display: inline-block; float: left; margin: 10px 10px 10px 50px">
									<img alt="이미지없음" src="${pageContext.request.contextPath}/store_resources/images/enter-arrow.png" width="20px" height="20px">
								</div>				
								<div class="qna-acontent">
									${qbean.a_content }
								</div>
							</div>
						</div>
						</c:forEach>
					</div>
					
					<div class="paging-wrap">
						<jsp:include page="/WEB-INF/views/store/mystore/paging.jsp" flush="false">
							<jsp:param name="type" value="qna"/>
							<jsp:param name="pageNumber" value="${q_pageNumber }"/>		
							<jsp:param name="totalRecordCount" value="${q_totalRecordCount }"/>	
							<jsp:param name="pageCountPerScreen" value="${q_pageCountPerScreen }"/>	
							<jsp:param name="recordCountPerPage" value="${q_recordCountPerPage }"/>	
						</jsp:include>
					</div>
					
				</div>
			</div>
		</div>
	</div>
	<!-- Content part end -->
	
	<!-- Q&A Modal -->
	<div id="qna-modal" class="modal">
		<div class="modal-content">
			<div style="margin-bottom: 20px" >
				<h3 style="display: inline-block">문의하기</h3>
				<span class="close">&times;</span>
			</div>
			<div>
				<form id="qna-form" method="post">
					<input type="hidden" name="productcode" value="${pbean.productcode }">
					<input type="hidden" name="email" value="${login.email }">
					<table style="margin: auto;">
						<colgroup>
							<col width="150px"><col width="300px">
						</colgroup>
						<tr>
							<th>문의 카테고리</th>
							<td style="text-align: left">
								<select name="category">
									<option value="">-------</option>
									<option value="상품">상품</option>
									<option value="배송">배송</option>
									<option value="기타">기타</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>문의 내용</th>
							<td><textarea rows="5" cols="50" placeholder="내용을 입력해주세요" name="content"></textarea></td>
						</tr>
					</table>
					<div style="text-align: right">
						<button type="button" class="m-btn" id="qna-submit-btn">문의하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<!-- Image Slider Modal -->
	<div id="slider-modal" class="modal">
		<div class="modal-content" style="background-color: rgba(0,0,0,0.0); border: 0;">
			<div>
				<span class="close" style="color: #fff">&times;</span>
			</div>
			<div id="wrapper">
				<div id="slider-wrap">
					<ul id="slider">
					</ul>
					<!--controls-->
					<div class="btns" id="next"><i class="fa fa-arrow-right"></i></div>
					<div class="btns" id="previous"><i class="fa fa-arrow-left"></i></div>
					<div id="counter"></div>
					
					<div id="pagination-wrap">
					  <ul>
					  </ul>
					</div>
					<!--controls-->  
				</div>
			</div>
		</div>
	</div>
	<!-- Image Slider Modal -->

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
var thumbnailUrl = 'http://192.168.0.7:8090/PetMeeting/upload/${pbean.filename}';
// alert(thumbnailUrl);
//<![CDATA[
// // 사용할 앱의 JavaScript 키를 설정해 주세요.
Kakao.init('385b9a19e223503d0ca01cdae14f25d3');

// // 카카오링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
function sendLink() {
  var price = ${pbean.price };
	
  Kakao.Link.sendDefault({
    objectType: 'commerce',
    content: {
      title: '${pbean.productname }',
      imageUrl: thumbnailUrl,
      link: {
        mobileWebUrl: 'http://192.168.0.7:8090/PetMeeting/productdetail.do?pcode=${pbean.productcode }',
        webUrl: 'http://localhost:8090/PetMeeting/productdetail.do?pcode=${pbean.productcode }'
      }
    },
    commerce: {
      regularPrice: price,
      /* discountPrice: 146160,
      discountRate: 30 */
    },
    buttons: [
      {
        title: '구경하러 가기',
        link: {
          mobileWebUrl: 'http://192.168.0.7:8090/PetMeeting/productdetail.do?pcode=${pbean.productcode }',
          webUrl: 'http://localhost:8090/PetMeeting/productdetail.do?pcode=${pbean.productcode }'
        }
      }
      /* ,{
        title: '공유하기',
        link: {
          mobileWebUrl: 'https://localhost:8090/PetMeeting/productdetail.do?pcode=${pbean.productcode }',
          webUrl: 'https://localhost:8090/PetMeeting/productdetail.do?pcode=${pbean.productcode }'
        }
      } */
    ]
  });
}
//]]>

$(function () {
	// 검색 정렬 페이징
	var r_sorting = "${r_param.r_sorting }";
	var r_category = "${r_param.r_category }";
	var r_keyword = "${r_param.r_keyword }";
	
	$("select[name=r_sorting]").val(r_sorting);
	
	if(r_category != "") {
		$("select[name=r_category]").val(r_category);
		$("input[name=r_keyword]").val(r_keyword);
	}
	
	var q_sorting = "${q_param.q_sorting }";
	var q_category = "${q_param.q_category }";
	var q_keyword = "${q_param.q_keyword }";
	
	$("select[name=q_sorting]").val(q_sorting);
	
	if(q_category != "") {
		$("select[name=q_category]").val(q_category);
		$("input[name=q_keyword]").val(q_keyword);
	}
	
	// 별점주기
	var score = $(".review-score-star-avg").attr("rating");
	$(".review-score-star-avg").css("width", (64*score)+"px");
	
	var writer_score_node = $(".review-writerscore-star-orange");
	for (var i = 0; i < writer_score_node.length; i++) {
		var writer_score = writer_score_node.eq(i).attr("rating");
	//	alert(writer_score);
		writer_score_node.eq(i).css("width", (18*writer_score)+"px");
	}	
	
	var price = <%=pbean.getPrice() %>
	// 수량 + - 버튼 클릭 시 텍스트필드값 변경 및 합계수량 변경
	$(".plus-minus-btn").click(function () {
		var quantity_tf = $("input[name=quantity]");
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
		
		update_quantity = parseInt(quantity_tf.val());
		var total = update_quantity * price;
		
		$("#total-price").text(numberWithCommas(total));
		$("input[name=totalprice]").val(total);
		
	});
	
	// 수량 선택 시 합계금액 변경
	$("input[name=quantity]").change(function () {
	//	alert($(this).val());
		var quantity = $(this).val();
		
		if(quantity < 1) {
			alert("최소 1개 이상 입력 가능합니다");
			$(this).val(1);
		}else if(quantity > 10) {
			alert("11개 이상 주문은 문의전화 부탁드립니다");
			$(this).val(10);
		}else {
			
			var update_quantity = $(this).val();
			
			var total = update_quantity * price;
			
			$("#total-price").text(numberWithCommas(total));
			$("input[name=totalprice]").val(total);
			
		}
	//	alert($("input[name=totalprice]").val());
	});
	
	// 사이즈 선택 시 각 색상별 수량정보 가져와 품절여부 판단하기 AJAX
	$("select[name=psize]").change(isSoldout);
	$("select[name=pcolor]").change(isSoldout);
	
	// 장바구니버튼 클릭 시 ajax를 통해 컨트롤러에서 세션을 불러와 주문정보 추가 후 카트이동여부 묻기
	$("#addCart-btn").click(function () {
		var email = $("input[name=email]").val();
		
		if(email == "") {
			location.href="alert.do";
		}else {
		
			var psize = $("select[name=psize]").val();
			var pcolor = $("select[name=pcolor]").val();
			var quantity = $("input[name=quantity]").val();
			
			if(psize == "") {
				alert("[필수]상품 사이즈를 선택해주세요.");
			}else if(pcolor == "") {
				alert("[필수]상품 색상을 선택해주세요.");
			}else {
			
				var formdata = $("#order-form").serialize();
			//	alert(formdata);
				
				$.ajax({
					url: "cartadd.do",
					data: formdata,
					dataType: "text",
					async: false,
					type: "POST",
					success: function (data) {
					//	alert(data);
						if(data.trim() == "true") {	// 동일한 상품이 있을 경우 추가하지 않고 "true" 반환
							if(confirm("이미 카트에 동일한 상품이 있습니다. 추가하시겠습니까?")) {
								$.ajax({
									url: "cartupdate.do",
									data: formdata,
									async: false,
									type: "POST",
									success: function () {
										if(confirm("카트로 이동하시겠습니까?")){
											location.href="cart.do";
										}
									},
									error: function () {
										alert("error");
									}
								});
							}
						}else if(data.trim() == "false") {	// 동일한 상품이 없을 경우 카트에 추가 후 "false" 반환
							if(confirm("카트로 이동하시겠습니까?")){
								location.href="cart.do";
							}	
						}
					},
					error: function () {
						alert("error");
					}
				});
			}
		}
	});
	
	// 문의글 쓰기 모달 띄우자!
	$("#qna-btn").click(function () {
		var email = $("input[name=email]").val();
		
		if(email == "") {
			location.href="alert.do";
		}
		
		$("#qna-modal").css("display", "block");
	});
	
	// 모달창 닫기!
	$(".close").on("click", function () {
		// 모달 끄고
		$(".modal").css("display", "none");
		
		// 슬라이더 초기화
		$("#slider").children().remove();
		$("#pagination-wrap ul").children().remove();
		$('#slider-wrap ul#slider').css('left', 0);$
	});
	
	// 문의글쓰기 버튼
	$("#qna-submit-btn").click(function() {
	//	alert("문의글쓰기 버튼");
		var category = $("select[name=category]");
		var content = $("textarea[name=content]");
		
		if(category.val() == "") {
			alert("카테고리를 선택하세요");
			category.focus();
		}else if(content.val() == "") {
			alert("내용을 입력하세요");
			content.focus();
		}else {
			$("#qna-form").attr("action", "qnawrite.do").submit();
		}
		
	});
	
	// 리뷰검색
	function reviewSearch() {
		var key_tf = $("input[name=r_keyword]");
		$("#r_pageNumber").val(0);
		
		$("#review-search-form").attr("action", "productdetail.do#product-reviews").submit();			
	}
	// 리뷰 검색 - 검색버튼 클릭 시 검색 폼 제출
	$("#review-search-btn").click(reviewSearch);
	// 리뷰검색 - 정렬 셀렉트박스 변경 시 폼 제출
	$("select[name=r_sorting]").change(reviewSearch);
	
	function qnaSearch() {
		var key_tf = $("input[name=q_keyword]");
		$("#q_pageNumber").val(0);
		
		$("#qna-search-form").attr("action", "productdetail.do#product-qnas").submit();			
	}
	
	// 문의 검색 - 검색버튼 클릭 시 검색 폼 제출
	$("#qna-search-btn").click(qnaSearch);
	// 문의 검색 - 정렬 셀렉트박스 변경 시 검색 폼 제출
	$("select[name=q_sorting]").change(qnaSearch);
	
	// 리뷰 이미지 클릭 시 모달 띄우기
	$(document).on("click", ".review-list-content-wrap img", function () {
// 		alert($(this).parent().children().length);
// 		alert($(this).attr("pos"));
	
		var images = $(this).parent().children();
		
		for (var i = 0; i < images.length; i++) {
		//	alert(images.eq(i).attr("src"));
			var html = "<li><img alt='이미지없음' src='" + images.eq(i).attr("src") + "'></li>"
			
			$("#slider").append(html);
		}
		
		//current position
		var pos = parseInt($(this).attr("pos"));
		//number of slides
		var totalSlides = $('#slider').children().length;
		//get the slide width
		var sliderWidth = $('#slider-wrap').width();
		
	    /*****************
	    BUILD THE SLIDER
	   *****************/
	   //set width to be 'x' times the number of slides
	   $('#slider-wrap ul#slider').width(sliderWidth*totalSlides);
	   $('#slider-wrap ul#slider').css('left', -(sliderWidth*pos));
	   //next slide
	   $('#next').click(function(){
	       slideRight();
	   });
	   
	   //previous slide
	   $('#previous').click(function(){
	       slideLeft();
	   });
	   
	   /*************************
	    //*> OPTIONAL SETTINGS
	   ************************/
	   //for each slide 
	   $.each($('#slider-wrap ul li'), function() { 
	      //create a pagination
	      var li = document.createElement('li');
	      $('#pagination-wrap ul').append(li);    
	   });
	   
	   //counter
	   countSlides(pos, totalSlides);
	   
	   //pagination
	   pagination(pos);
	
	   /***********
		SLIDE LEFT
		************/
		function slideLeft(){
		   pos--;
		   if(pos==-1){ pos = totalSlides-1; }
		   $('#slider-wrap ul#slider').css('left', -(sliderWidth*pos));    
		   
		   //*> optional
		   countSlides(pos, totalSlides);
		   pagination(pos);
		}
		
		
		/************
		SLIDE RIGHT
		*************/
		function slideRight(){
			pos++;
			if(pos==totalSlides){ pos = 0; }
			$('#slider-wrap ul#slider').css('left', -(sliderWidth*pos)); 
			
			//*> optional 
			countSlides(pos, totalSlides);
			pagination(pos);
		}
		  
		$("#slider-modal").css("display", "block");
	});
	
	// Slider page option
	function countSlides(pos, totalSlides){
	   $('#counter').html(pos+1 + ' / ' + totalSlides);
	}
	function pagination(pos){
	   $('#pagination-wrap ul li').removeClass('active');
	   $('#pagination-wrap ul li:eq('+pos+')').addClass('active');
	}
	
	// 금액 포맷
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	// 옵션 선택 시 해당 옵션의 품절여부 판단
	function isSoldout() {
		var pcode = $("input[name=productcode]").val();
		var psize = $("select[name=psize]").val();
		var pcolor = $("select[name=pcolor]").val();
		
		if(psize != "" && pcolor != "") {
		
			$.ajax({
				url: "productquantity.do",
				data: "productcode=" + pcode + "&psize=" + psize + "&pcolor=" + pcolor,
				datatype: "text",
				success: function ( data ) {
				//	alert(data);
					if(data.trim() == "true") {
						alert("[SIZE] " + psize + "\n" 
								+ "[COLOR] " + pcolor + "\n"
								+ "해당 옵션의 상품은 품절입니다.");
						$("select[name=psize]").val("");
						$("select[name=pcolor]").val("");
					}
				},
				error: function () {
					alert("error");
				}
			});
			
		}
	}
	
	// 바로 구매하기 시 제어 및 주문창 이동
	$("#order-btn").click(function () {
		var email = $("input[name=email]").val();
		
		if(email == "") {
			location.href="alert.do";
		}else {
			if($("select[name=psize]").val() == '' && $("select[name=pcolor]").val() == ''){
				alert('[필수]옵션을 선택해주세요');
			}else if($("select[name=psize]").val() == ''){
				alert('[필수]사이즈를 선택해주세요.');
			}else if($("select[name=pcolor]").val() == ''){
				alert('[필수]색상을 선택해주세요.');
			}else{
				$("#order-form").attr("action", "productorder.do?type=one").submit();
			}
		}

	});
   
   //hide/show controls/btns when hover
   //pause automatic slide when hover
   $('#slider-wrap').hover(
     function(){ $(this).addClass('active') }, 
     function(){ $(this).removeClass('active') }
   );
   
	// sticky navi
	window.onscroll = function() {tabSticky()};
	
	var navbar = document.getElementById("sub-navbar");
	var sticky = navbar.offsetTop - 130;
	
	function tabSticky() {
		if (window.pageYOffset >= sticky) {
			navbar.classList.add("sticky");
			navbar.classList.add("animated");
			navbar.classList.add("fadeInDown");
		} else {
			navbar.classList.remove("sticky");
			navbar.classList.remove("animated");
			navbar.classList.remove("fadeInDown");
		}	
	}
	
});

function goPage(type, pageNumber) {
	if(type == "review") {
		$("#r_pageNumber").val(pageNumber);
		$("#review-search-form").attr("action", "productdetail.do#product-reviews").submit();
	}else if(type == "qna") {
		$("#q_pageNumber").val(pageNumber);
		$("#qna-search-form").attr("action", "productdetail.do#product-qnas").submit();
	}
}
</script>
</body>
</html>