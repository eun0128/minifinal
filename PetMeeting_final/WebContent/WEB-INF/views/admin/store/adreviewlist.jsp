<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetMeeting - 관리자</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<!-- 셀렉트박스 이미지넣기 -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/admin_resources/css/dd.css" />
	<script type="text/javascript"  src="${pageContext.request.contextPath}/admin_resources/js/jquery.dd.min.js"></script>

<style type="text/css">
tr.content-tr {
	display: none;
}
</style>
</head>
<body>
<div id="right-panel" class="right-panel">
	<!--::header part start::-->
		<jsp:include page="/admin_resources/admincss/templates/adminheader.jsp" flush="false"/>
	<!-- Header part end-->

	<!-- Content -->
	<div class="content">
		<div class="container">
			<div style="margin: 40px 0;">
				<h4>리뷰 관리</h4>			
			</div>
			<div class="search-wrap">
				<form id="search-form" method="post">
					<input type="text" style="display: none">	<!-- 엔터 시 폼 제출 안되도록 제어 -->
					<div style="float: left; display: inline-block;">
						<select style="width: 150px;" class="search-select" name="r_sorting_score" id="score-select">
							<option data-image="${pageContext.request.contextPath}/admin_resources/images/total.png" value=""></option>
							<c:forEach varStatus="i" begin="1" end="5">
							<option data-image="${pageContext.request.contextPath}/admin_resources/images/score${i.index }.png" value=${i.index }></option>
							</c:forEach>
						</select>
					</div>
					<input type="hidden" name="r_pageNumber" id="r_pageNumber">
					<select class="search-select" name="r_category">
						<option value="productcode">상품코드</option>
						<option value="productname">상품명</option>
						<option value="nickname">작성자</option>
						<option value="content">내용</option>
					</select>
					<input type="text" name="r_keyword" placeholder="리뷰글을 검색해보세요"><input type="button" id="review-search-btn" class="search-btn">
				</form>
			</div>
			
			<div>
				<form id="delete-form" method="post">
					<table class="boardTable">
						<colgroup>
							<col width="50"><col width="50"><col width="300">
							<col width="150"><col width="150"><col width="100">
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" id="all-check"></th><th>번호</th><th>상품정보</th>
								<th>작성자</th><th>평점</th><th>등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${rlist }" var="review" varStatus="vs">
							<tr>
								<td style="text-align: center;"><input type="checkbox" class="del-check" name="delete_seq" value=${review.seq }></td>
								<td style="text-align: center;">${vs.count }</td>
								<td class="review-productInfo">
									<div>[${review.productcode }] ${review.productname }</div>
									<div>옵션 : ${review.psize }, ${review.pcolor }</div>
								</td>
								<td style="text-align: center;">${review.nickname }</td>
								<td style="text-align: center;">
									<div class="review-writerscore-star-gray">
										<div class="review-writerscore-star-orange" rating=${review.score }></div>
									</div>
								</td>
								<td style="text-align: center;"><fmt:formatDate value="${review.regdate }" pattern="yyyy-MM-dd"/></td>
							</tr>
							<tr class="content-tr">
								<td colspan="2"></td>
								<td colspan="4">
									<div class="content-review-title texts">
										<span class="category" style="width:50px">한줄평</span> ${review.title }
									</div>
									<div class="content-review-content texts">${review.content }</div>
									<div class="content-review-image texts">
									<c:forTokens items="${review.filename }" delims="-" var="file">
										<img alt="이미지없음" src="${pageContext.request.contextPath}/upload/${file}" width="100px" height="100px">
									</c:forTokens>
									</div>
								</td>
							</tr>
							</c:forEach>
							<tr>
								<td colspan="6"><button type="button" class="delete-btn" id="delete-btn"></button></td>
							</tr>
						</tbody>
					</table>
				</form>
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
<script type="text/javascript">
$(function () {
	// 검색 시 파라미터 유지
	var r_sorting_score = "${param.r_sorting_score }";
	var r_category = "${param.r_category }";
	var r_keyword = "${param.r_keyword }";
		
	$("#score-select").val(r_sorting_score);
	
	$('#score-select').msDropDown().data("dd");
	
	if(r_category != "") {
		$("select[name=r_category]").val(r_category);
		$("input[name=r_keyword]").val(r_keyword);
	}
	
	// 검색 버튼 클릭 시 검색
	$(".search-btn").click(function () {
		$("input[name=r_pageNumber]").val(0);
		
		$("#search-form").attr("action", "adreviewlist.do").submit();				
	});
	
	// 정렬 셀렉트박스 변경 시 폼 제출
	$("select[name=r_sorting_score]").change(function () {
		$("input[name=r_pageNumber]").val(0);
		$("#search-form").attr("action", "adreviewlist.do").submit();
	});
	
	// 상품정보 클릭 시 리뷰 상세글 띄우기
	$(".review-productInfo").click(function () {
		$(".content-tr").css("display", "none");
		$(this).parent().next(".content-tr").css("display", "table-row");
	});
	
	// 테이블 헤드의 체크박스 클릭 시 하위 체크박스 모두 선택
	$("#all-check").click(function () {
	//	alert($(this).prop("checked"));
		if($(this).prop("checked")) {
			$(".del-check").prop("checked", true);
		}else {
			$(".del-check").prop("checked", false);
		}
	});
	
	// 삭제버튼 클릭 시 체크된 리뷰 삭제
	$("#delete-btn").click(function () {
		if($(".del-check").is(":checked") == false){
			alert("삭제할 글을 한 개 이상 선택하세요");
		}else{
			if(confirm("정말로 삭제하시겠습니까?")){
				$("#delete-form").attr("action", "adreviewdelete.do").submit();
			}
		}
	});
	
	// 별점주기
	var writer_score_node = $(".review-writerscore-star-orange");
	for (var i = 0; i < writer_score_node.length; i++) {
		var writer_score = writer_score_node.eq(i).attr("rating");
	//	alert(writer_score);
		writer_score_node.eq(i).css("width", (18*writer_score)+"px");
	}

});

function goPage(type, pageNumber) {
	$("input[name=r_pageNumber]").val(pageNumber);
	$("#search-form").attr("action", "adreviewlist.do").submit();	
}
</script>
</body>
</html>