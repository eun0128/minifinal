<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetMeeting - 관리자</title>
<!-- 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> -->
	 <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/admin_resources/css/custom.css">
	
	<!-- Image Slider -->
	<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<style type="text/css">
.boardTable td{
text-align: center;
}

.refund-detail{
display: none;
}

.texts{
text-align: left;
}
.content-order-product{
color: #818181; 
}

/* Modal Css */
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%;
	height: 100%; /* Full height */
	overflow: hidden; /* Enable scroll if needed */
	background-color: rgb(0,0,0); /* Fallback color */
	background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content Box */
.modal-content {
	background-color: #fefefe;
	margin: 10% auto; /* 10% from the top and centered */
	padding: 20px;
	border: 1px solid #888;
 	width: 50%; /* Could be more or less, depending on screen size */  
}
/* The Close Button */
.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
	float: right;
}
.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}


</style>
</head>
<body>
	<div id="right-panel" class="right-panel">
		<!--::header part start::-->
		<jsp:include
			page="/admin_resources/admincss/templates/adminheader.jsp" flush="false" />
		<!-- Header part end-->

		<div class="content">
			<div class="container">
			<div style="margin: 40px 0;">
				<h4>반품/교환 목록</h4>			
			</div>
			
				<div class="search-wrap">
					<form id="search-form" method="post">
						<input type="hidden" name="pageNumber" id="_pageNumber" value="0">
						<div style="float: left;">
							<select class="search-select" name="sorting_category">
								<option value="">전체</option>
								<option value="1">반품대기</option>
								<option value="3">반품완료</option>
								<option value="4">교환대기</option>
								<option value="6">교환완료</option>
							</select>
						</div>

						<select class="search-select" name="search_category" id="search-category">
							<option value="주문번호">주문번호</option>
							<option value="주문자명">주문자명</option>
						</select> <input type="text" name="s_keyword" id="search_keyword">
						<input type="button" class="search-btn" id="search_btn">
					</form>
				</div>

				<table class="boardTable">
					<colgroup>
						<col width="30">
						<col width="160">
						<col width="220">
						<col width="180">
						<col width="80">
						<col width="80">
						<col width="100">
					</colgroup>
					<thead>
						<tr>
							<th>No.</th>
							<th>주문번호</th>
							<th>상품명</th>
							<th>반품/교환 날짜</th>
							<th>주문자명</th>
							<th>반품/교환</th>
							<th>반품/교환 상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${rlist }" var="list" varStatus="vs">
							<tr>
								<td>${vs.count }</td>
								<td class="refund_detail" rseq="${list.refund_seq }">${list.ordernumber }</td>
								<td>${list.ordername }</td>
								<td><fmt:formatDate value="${list.refund_date }" pattern="yyyy-MM-dd" /></td>
								<td>${list.rname }</td>
								<td>${list.refund_select }</td>
								<td>
									<c:if test="${list.status eq 1 }">
										<%-- <span class="status-refund" style="cursor: pointer;" ordernumber="${list.ordernumber }">반품대기</span> --%>
										반품대기
									</c:if>
									<c:if test="${list.status eq 2 }">
										반품진행
									</c:if>
									<c:if test="${list.status eq 3 }"> 	
										<font color="#E5433E" style="font-weight: bold">반품완료</font>
									</c:if>
									<c:if test="${list.status eq 4 }">
										<%-- <span class="status-change"  style="cursor: pointer;" orderno="${list.ordernumber }">교환대기</span> --%>
										교환대기
									</c:if>
									<c:if test="${list.status eq 5 }">
										교환진행
									</c:if>
									<c:if test="${list.status eq 6 }">
										<font color="#01b700" style="font-weight: bold">교환완료</font>
									</c:if>
									
								</td>
							</tr>
							<tr class="refund-detail">
								<td colspan="1"></td>
								<td colspan="6">
									<div class="content-refund-for-reason texts" >
										<span class="category" style="width: 120px;">반품/교환 사유</span>${list.reason }	&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;
										<c:if test="${list.status eq 1 }">
											<span class="status-refund" style="cursor: pointer; color: #B50000;" ordernumber="${list.ordernumber }" detail="${list.reason_detail }" refund_seq=${list.refund_seq }>반품진행</span>
										</c:if>
										<c:if test="${list.status eq 4 }">
										<span class="status-change"  style="cursor: pointer; color: #B50000;" ordernumber="${list.ordernumber }" refund_seq=${list.refund_seq }>교환진행</span>
										</c:if>
									</div>
									<div class="content-order-product texts" style="padding-left: 25px;">
											
									</div>
									<div class="content-refund-reason-for-detail texts" id="detail_reason">${list.reason_detail }</div>
									<div class="content-refund-img texts">
									<c:forTokens items="${list.filename }" delims="-" var="file" varStatus="vs">
										<img alt="이미지없음" src="${pageContext.request.contextPath }/upload/${file}" width="100px" height="100px" pos=${vs.index }>
									</c:forTokens>
									</div>
								</td>
							</tr>
						</c:forEach>
						<tr>
							<td colspan="7">
							<jsp:include page="/WEB-INF/views/store/mystore/paging.jsp" flush="false">
										<jsp:param name="type" value="" />
										<jsp:param name="pageNumber" value="${pageNumber }" />
										<jsp:param name="totalRecordCount" value="${totalRecordCount }" />
										<jsp:param name="pageCountPerScreen" value="${pageCountPerScreen }" />
										<jsp:param name="recordCountPerPage" value="${recordCountPerPage }" />
								</jsp:include>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
		<!-- Image Slider Modal -->
	<div id="slider-modal" class="modal">
		<div class="modal-content" style="background-color: rgba(0,0,0,0.0); border: 0; width: 35%">
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
	
<script type="text/javascript">

$(function () {
	
var sort_category = "${param.sorting_category}";
var s_keyword = "${param.s_keyword}";
var search_category = "${param.search_category}";
var pageNumber = "${param.pageNumber}";

//정렬값 유지
$("select[name='sorting_category']").val(sort_category);

// 검색 카테고리가 선택되어있을 시 값 유지
if(search_category != ''){
	$("#search_keyword").val(s_keyword);
	$("#search-category").val(search_category);
}

// 정렬 카테고리 값 변경시
$("select[name='sorting_category'").change(function() {
	$("#search-form").attr("action", "adrefundlist.do").submit();	
})

// 검색시
$("#search_btn").click(function() {
	$("#search-form").attr("action", "adrefundlist.do").submit();	
})

$(".refund_detail").hover(function() {
	$(".refund_detail").css("cursor", "pointer");
});

// 주문번호 클릭시 반품 사유 디테일 
$(".refund_detail").click(function() {
	var seq = $(this).attr("rseq");
	$(".refund-detail").css("display", "none");
	
	// 반품한 상품, 개수 가져옴
	$.ajax({
		url : "adrefundproduct.do",
		type: "POST",
		data: {"seq" : seq},
		success: function (data) {
			var htm = "";
			var sum = 0;
			$.each(data, function(i, val) {
				
				sum += val.price;
				
				htm += "-" + val.productname + "  [OPTION]" + val.psize + "/" + val.pcolor + "     " + val.quantity + "개 <br>";
				htm += "<input type='hidden' id='totalprice' value=''>";
			});
				$(".content-order-product").html(htm);
				$("#totalprice").val(sum);
		},
		error: function () {
			alert("err");
		}
		
	})
		$(this).parent().next(".refund-detail").css("display", "table-row");
	
});


$(".status-refund").click(function () {
	if(confirm("반품 및 환불을 정말로 진행하시겠습니까?")) {
		var ordernumber = $(this).attr("ordernumber");
		var totalprice = $("#totalprice").val();
		var detail = $(this).attr("detail");
		var refund_seq = $(this).attr("refund_seq");
		
	//	alert("order" + ordernumber);
	// 	alert("tp " + totalprice);
	// 	alert("detail " + detail);
		
		$.ajax({
	    url : "adcancelpay.do",
	    type : "POST",
	    data : {
	   	  "reason": detail,
	      "ordernumber" : ordernumber,
	      "refund_seq" : refund_seq,
	      "amount": totalprice
	    },
		error: function () {
			alert("error");
		}
	   }).done(function(result) {
		//   alert(result);
		if(result.trim() == 'refund complete') {
			alert("환불이 성공적으로 완료되었습니다.");
			location.reload();
		}
	   });
	}
});

// 교환 완료
 $(".status-change").click(function () {
	var seq = $(this).attr("refund_seq");
	alert("seq : " + seq)
	
	$.ajax({
		url : "adproductchange.do",
		type : "POST",
		data : "refund_seq=" + seq,
		success : function () {
			alert("교환 처리가 완료되었습니다.");
			
			location.reload();
		},
		error: function () {
			alert("err");
		}
	});
 });


// 리뷰 이미지 클릭 시 모달 띄우기
$(document).on("click", ".content-refund-img img", function () {
// 	alert($(this).parent().children().length);
// 	alert($(this).attr("pos"));

	var images = $(this).parent().children();
	
	for (var i = 0; i < images.length; i++) {
// 		alert(images.eq(i).attr("src"));
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

//모달창 닫기
$(".close").on("click", function () {
	// 모달 끄고
	$(".modal").css("display", "none");
	
	// 슬라이더 초기화
	$("#slider").children().remove();
	$("#pagination-wrap ul").children().remove();
	$('#slider-wrap ul#slider').css('left', 0);$
});



//hide/show controls/btns when hover
//pause automatic slide when hover
$('#slider-wrap').hover(
  function(){ $(this).addClass('active') }, 
  function(){ $(this).removeClass('active') }
);


	
});

// Slider page option
function countSlides(pos, totalSlides){
   $('#counter').html(pos+1 + ' / ' + totalSlides);
}
function pagination(pos){
   $('#pagination-wrap ul li').removeClass('active');
   $('#pagination-wrap ul li:eq('+pos+')').addClass('active');
}

//페이징 함수
function goPage( type, pageNumber ) {
	$("#_pageNumber").val(pageNumber);
	$("#search-form").attr("action", "adrefundlist.do").submit();
};


</script>

</body>
</html>