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

.sub-title{
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
					<li><a href="myrefund.do">반품/교환 내역</a></li>
					<li class="active"><a href="myrefundapplication.do">반품/교환 신청</a></li>
				</ul>
				<div class="sub-content">
				
					<div>
						<img alt="" src="${pageContext.request.contextPath}/store_resources/images/refundimg.jpg">
					</div>
				
				
				<div class="warning-text"
					style="padding: 20px 10px; background: #EDEDED; border-radius: 5px">
					<div><img alt="이미지없음" src="${pageContext.request.contextPath}/store_resources/images/alert.png"  width="20px" height="20px">&ensp; <h4 style="color: black; display: inline-block;">알아두세요!</h4></div>
					<br>
					<b>배송이 완료 된 상품의 반품/교환신청이 가능한 페이지입니다.</b><br><br>
					<p>1. 고객 변심에 의한 반품,교환의 경우 왕복택배비는 5,000원으로 고객이 부담합니다.</p>
					<p>2. 상품의 개봉으로 또는 고객의 부주의로 인하여 상품가치 훼손시에는 반품,교환이 불가합니다.</p>
					<p>3. 사용흔적(택제거, 세탁, 훼손,착용)이 있을시에는 반품,교환이 불가합니다.</p>
					<p>4. 교환 신청시에는 교환하고싶은 상품이름과 옵션을 반품/교환 사유에 작성해주세요.<br>
						&ensp;&ensp;  만약 공백으로 교환 신청 진행시에는 교환이 신속히 이루어지지 않을 수 있습니다.</p>
				</div>


					<form id="refund-form" method="post" enctype="multipart/form-data">
						<input type="hidden" name="email" value="${login.email }">
					<table class="refund-table">
						<caption>반품/교환 신청</caption>
						<colgroup>
				<%-- 			<col width="210px">
							<col width="640px"> --%>
							<col width="60">
							<col width="150">
							<col width="290">
							<col width="100">
							<col width="100">
						</colgroup>
						<tbody>
							<tr id="ordernumberTr">
								<th colspan="2">주문번호</th>
								<td colspan="3"><select name="ordernumber" id="_ordernumberSel" style="width: 140px" onchange="ordernumberSelect()">
										<option>------------------</option>
										<c:forEach items="${rlist }" var="rlist" varStatus="vs">
											<option value="${rlist.ordernumber }">${rlist.ordernumber }</option>
										</c:forEach>
								</select></td>
							</tr>
								
							<tr>
								<th colspan="2">반품/교환 선택</th>
								<td colspan="3">
									<label style="margin-bottom: 0 "><input type="radio" name="refund_select" value="반품">반품</label> &ensp; &ensp; &ensp; &ensp; 
									<label style="margin-bottom: 0"><input type="radio" name="refund_select" value="교환">교환</label> &ensp; &ensp; 
								</td>
							</tr>

							<tr>
								<th colspan="2">반품/교환 사유 선택</th>
								<td colspan="3">
									<label style="margin-bottom: 0 "><input type="radio" name="reason" value="단순변심">단순변심</label>&ensp; &ensp; 
									<label style="margin-bottom: 0"><input type="radio" name="reason" value="제품이상">제품이상</label> &ensp; &ensp; 
									<label style="margin-bottom: 0"><input type="radio" name="reason" value="상품정보 오류">상품정보 오류</label> &ensp; &ensp;
									<label style="margin-bottom: 0"><input type="radio" name="reason" value="오배송">오배송</label> &ensp; &ensp;
									<label style="margin-bottom: 0"><input type="radio" name="reason" id="etc" value="기타">기타</label> &ensp; &ensp;
								</td>
							</tr>
							<tr>
								<th colspan="2">파일 첨부</th>
								<td colspan="3">
									<input type="file" multiple="multiple" name="fileload" id="_fileload" onchange="limitUpload()"><br>
									<p class="file-text" id="file-text">※ 파일은 최대 3개까지 업로드 가능합니다.</p>
								</td>
							</tr>
							<tr>
								<th colspan="2">반품/교환 사유</th>
								<td colspan="3" id="resonDetail">
									<textarea rows="4" cols="78" name="reason_detail" id="_reason_detail" placeholder="반품/교환 사유를 적어주세요" 
											style="background-color: #ededed; resize: none;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>
					</form>
					<br>
					<button type="button" class="s-btn" id="refundBtn">신청 완료</button>
					<br><br><br><br>
				
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


function ordernumberSelect() {
	var selected = document.getElementById('_ordernumberSel');
	
    // 선택된 option의 value가 저장
    var selecOrdernumber = selected.options[selected.selectedIndex].value;

    	$.ajax({
	    	url: "refundlist.do",
	    	type: "POST",
	    	dataType: "JSON",
			data: {"ordernumber" : selecOrdernumber},
			success: function (data) {
				console.log(data);
				
				$.each(data, function(i, val) {
					var htm = "<tr class='refundproductlist' style='background-color : #EDEDED'>";
					htm += "<td style='text-align: center;'>" + "<input type='checkbox' name='order_seq' id='listcheck' value=" + val.order_seq + ">" + "</td>";
					htm += "<td><div class='product_img_link'><a href='${pageContext.request.contextPath}/productdetail.do?pcode=" + val.productcode + "'><img class='thumbnailImg' alt='이미지 없음' src='upload/"+ val.filename + "' name='filename' width='70px'></a></div></td>";
					htm += "<td><div class='product_name'><b><a href='${pageContext.request.contextPath}/productdetail.do?pcode=" + val.productcode + "'>" + val.productname + "</a></b><br>[사이즈]" + val.psize + " [색상]" + val.pcolor + "</div></td>";
					htm += "<td>" + val.quantity + "</td>";
					htm += "<td>" + val.price * val.quantity +"</td>";
					htm += "</tr>"

					$("#ordernumberTr").after(htm);					
				})
			},
			error: function () {
				alert("err");
			}
	    });
    	
    	$(".refundproductlist").remove();		// 셀렉트 값이 바뀌면 지워줌
}


//파일 업로드 갯수 제한함수
function limitUpload() {
	var load = document.getElementById("_fileload");
	var txt = "※ 파일은 최대 3개까지 업로드 가능합니다.<br>";
	
	if ('files' in load) {
		if (load.files.length > 3) {
			alert("파일은 최대 3개까지 등록할 수 있습니다.");
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

$("#refundBtn").click(function () {
	
	if($("input:checkbox[id='listcheck']").is(":checked") == false){
		alert("반품/교환 할 상품을 한 개 이상 선택해주세요.");
	}else if($("input:radio[name='refund_select']").is(":checked") == false){
		alert("반품/교환을 선택하세요.");
	}else if($("input:radio[name='reason']").is(":checked") == false){
		alert("반품/교환 사유를 선택하세요.");
	}else{
		$("#refund-form").attr("action", "refundwrite.do").submit();
		alert("신청이 완료되었습니다.");
	}
});


</script>
</body>


</html>