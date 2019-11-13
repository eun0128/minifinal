<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetMeeting - 관리자</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/admin_resources/css/custom.css">
<style type="text/css">
.boardTable td{
text-align: center;
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
					<h4>주문 목록</h4>
				</div>

					<div class="search-wrap">
						<form id="search-form" method="post">
							<input type="hidden" name="pageNumber" id="_pageNumber" value="0">
							<div style="float: left;">
								<select class="search-select" name="sorting_category">
									<option value="">전체</option>
									<option value="0">배송준비</option>
									<option value="1">배송중</option>
									<option value="2">배송완료</option>
									<option value="3">주문취소</option>
								</select>
							</div>

							<select class="search-select" name="search_category"
								id="search-category">
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
							<col width="200">
							<col width="100">
							<col width="100">
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>주문번호</th>
								<th>상품명</th>
								<th>주문날짜</th>
								<th>주문자명</th>
								<th>주문상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${olist }" var="list" varStatus="vs">
								<tr>
									<td>${vs.count }</td>
									<%-- <td>${list.ordernumber }</td> --%>
									<td>
										<a href="adorderdetail.do?ordernumber=${list.ordernumber }" style="color: black;">${list.ordernumber }</a>
									</td>
									<td>${list.ordername }</td>
									<td><fmt:formatDate value="${list.orderdate }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td>${list.rname }</td>
									<td><c:if test="${list.status eq 0 }">
											<span class="status-change" style="cursor: pointer;" ordernumber="${list.ordernumber }">배송준비</span>
										</c:if> 
										<c:if test="${list.status eq 1 }">
											<span class="delivery-complete" style="cursor: pointer;" ordernumber="${list.ordernumber }">배송중</span>
										</c:if> 
										<c:if test="${list.status eq 2 }">
											<font color="#E5433E" style="font-weight: bold">배송완료</font>
										</c:if> 
										<c:if test="${list.status eq 3 }">
											주문취소
										</c:if>
									</td>
								</tr>
							</c:forEach>
							<tr>
								<td colspan="6">
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
		
		
<script type="text/javascript">
$(function () {

	var sort_category = "${param.sorting_category}";
	var s_keyword = "${param.s_keyword}";
	var search_category = "${param.search_category}";
	var pageNumber = "${param.pageNumber}";

	
	// 정렬값 유지
	$("select[name='sorting_category']").val(sort_category);
	
	// 검색 카테고리가 선택되어있을 시 값 유지
	if(search_category != ''){
		$("#search_keyword").val(s_keyword);
		$("#search-category").val(search_category);
	}

	// 정렬 카테고리 값 변경시
	$("select[name='sorting_category'").change(function() {
		$("#search-form").attr("action", "adorderlist.do").submit();	
	})
	
	// 검색 카테고리가 바뀌면 텍스트 ''로 초기화
	$("select[name='search_category'").change(function() {
		$("#search_keyword").val('');
	})
	
	$("#search_btn").click(function() {
		$("#search-form").attr("action", "adorderlist.do").submit();	
	})
	
});

$(".status-change").hover(function () {
	$(this).css("color", "#01b700");
	$(this).html("배송시작");
}, function () {
	$(this).css("color", "#000000");
	$(this).html("배송준비");
});

$(".status-change").click(function() {
	if(confirm("상품 발송을 시작하겠습니까?")){
		var ordernumber = $(this).attr("ordernumber");
		
// 		$("#search-form").attr("action", "adorderlist.do").submit();

		$.ajax({
			url : "adorderlist.do",
			type: "POST",
			data: {"ordernumber" : ordernumber},
			success: function () {
// 				alert("suc");
				$("#search-form").attr("action", "adorderlist.do").submit();
			},
			error: function () {
				alert("error");
			}
		})
	}else{
		return false;
	}
});

$(".delivery-complete").hover(function () {
	$(this).css("color", "#D24C0F");
	$(this).html("배송완료");
}, function () {
	$(this).css("color", "#000000");
	$(this).html("배송중");
});

$(".delivery-complete").click(function () {
	if(confirm("배송 완료 상태로 변경하시겠습니까?")){
		var ordernumber = $(this).attr("ordernumber");
// 		alert("or : " + ordernumber);
		
		$.ajax({
			url: "adorderlist.do",
			type: "POST",
			data: {"deliveryOrdernumber" : ordernumber},
			success: function () {
// 				alert("suc");
				location.reload();
			},
			error: function () {
				alert("err");
			}
		})
	}else{
		return false;
	}
});

function goPage( type, pageNumber ) {
	$("#_pageNumber").val(pageNumber);
	$("#search-form").attr("action", "adorderlist.do").submit();
}


</script>
</body>

</html>