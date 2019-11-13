<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PetMeeting - 관리자</title>
<style type="text/css">
.content-tr {
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
				<h4>문의 관리</h4>			
			</div>
			<div class="search-wrap">
				<form id="search-form" method="post">
					<input type="text" style="display: none">	<!-- 엔터 시 폼 제출 안되도록 제어 -->
					<div style="float: left; display: inline-block">
						<select style="width: 130px;" class="search-select" name="q_sorting_category">
							<option value="">전체</option>
							<option value="상품">상품</option>
							<option value="배송">배송</option>
							<option value="기타">기타</option>
						</select>
					</div>
					<div style="float: left; display: inline-block">
						<select style="width: 130px;" class="search-select" name="q_sorting_answer">
							<option value="">전체</option>
							<option value="wating">답변대기중</option>
							<option value="complete">답변완료</option>
						</select>
					</div>
					<input type="hidden" name="q_pageNumber" id="q_pageNumber">
					<select class="search-select" name="q_category">
						<option value="productcode">상품코드</option>
						<option value="productname">상품명</option>
						<option value="nickname">작성자</option>
						<option value="content">내용</option>
					</select>
					<input type="text" name="q_keyword" placeholder="문의글을 검색해보세요"><input type="button" class="search-btn">
				</form>
			</div>
			<div>
				<form id="delete-form" method="post">
					<table class="boardTable">
						<colgroup>
							<col width="50"><col width="80"><col width="150">
							<col width="300"><col width="200"><col width="150"><col width="150">
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" id="all-check"></th><th>번호</th><th>카테고리</th>
								<th>상품명</th><th>작성자</th><th>답변여부</th><th>작성일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${qlist }" var="que" varStatus="vs">
							<tr>
								<td style="text-align: center;"><input type="checkbox" class="del-check" name="delete_seq" value=${que.q_seq }></td>
								<td style="text-align: center;">${vs.count }</td>
								<td style="text-align: center;">${que.category }</td>
								<td class="qna-product">${que.productname }</td>
								<td style="text-align: center;">${que.nickname }</td>
								<td style="text-align: center;">
									<c:if test="${que.a_seq != 0 }">
									<span class="answer-complete">답변완료</span>
									</c:if>
									<c:if test="${que.a_seq == 0 }">
									<span class="answer-wating">답변대기중</span><br>
									</c:if>
								</td>	
								<td style="text-align: center;"><fmt:formatDate value="${que.q_regdate }" pattern="yyyy-MM-dd"/></td>	
							</tr>
							<tr class="content-tr">
								<td colspan="2">
									<div style="padding-bottom: 35px; height: 20px;">
										<img alt="이미지없음" src="${pageContext.request.contextPath}/admin_resources/images/enter-arrow.png"
												width="20px" height="20px" style="float: right">
									</div>
								</td>
								<td colspan="3">
									<div class="content-question">
										Q. ${que.q_content }
									</div>
									<div class="content-answer">
										<c:if test="${que.a_seq != 0 }">
											 <div class="content-answer-complete">
											 	<div class="content-answer-oriAnswer">A. ${que.a_content }</div>
											 </div>
										</c:if>
										<c:if test="${que.a_seq == 0 }">
											<div class="content-answer-wating">A. [답변 대기중 입니다]</div>
										</c:if>
									</div>
								</td>
								<td style="text-align: center">
									<c:if test="${que.a_seq != 0 }">
										<span class="answer-complete active answer-update" seq=${que.a_seq }>수정하기</span>
									</c:if>
									<c:if test="${que.a_seq == 0 }">
										<span class="answer-wating active answer-write" seq=${que.q_seq }>답변하기</span>
									</c:if>
								</td>
								<td></td>
							</tr>
							</c:forEach>
							<tr>
								<td colspan="7">
									<button type="button" class="delete-btn" id="delete-btn"></button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
			<div class="pagingWrap">
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
<script src="${pageContext.request.contextPath}/common/navbar/js/jquery-1.12.1.min.js"></script>
<script type="text/javascript">
$(function () {
	// 상품정보 클릭 시 리뷰 상세글 띄우기
	$(".qna-product").click(function () {
		// 초기화
		$(".content-answer-wating").html("A. [답변 대기중 입니다]");
		$(".answer-write").show();
		
		$("#update-form").remove();
		$(".content-answer-oriAnswer").show();
		$(".answer-update").show();
		$(".content-tr").css("display", "none");
		
		
		$(this).parent().next(".content-tr").css("display", "table-row");
	});
	
	// 검색 시 파라미터 유지
	var q_sorting_category = "${param.q_sorting_category }";
	var q_sorting_answer = "${param.q_sorting_answer }";
	var q_category = "${param.q_category }";
	var q_keyword = "${param.q_keyword }";
	
	$("select[name=q_sorting_category]").val(q_sorting_category);
	$("select[name=q_sorting_answer]").val(q_sorting_answer);
	
	if(q_category != "") {
		$("select[name=q_category]").val(q_category);
		$("input[name=q_keyword]").val(q_keyword);
	}
	
	// 검색 버튼 클릭 시 검색
	$(".search-btn").click(function () {
		$("input[name=q_pageNumber]").val(0);
		
		$("#search-form").attr("action", "adquestionlist.do").submit();				
	});
	
	// 정렬 셀렉트박스 변경 시 폼 제출
	$("select[name=q_sorting_category]").change(function () {
		$("input[name=q_pageNumber]").val(0);
		$("#search-form").attr("action", "adquestionlist.do").submit();
	});
	
	$("select[name=q_sorting_answer]").change(function () {
		$("input[name=q_pageNumber]").val(0);
		$("#search-form").attr("action", "adquestionlist.do").submit();
	});
	
	// 테이블 헤드의 체크박스 클릭 시 하위 체크박스 모두 선택
	$("#all-check").click(function () {
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
				$("#delete-form").attr("action", "adqnadelete.do").submit();
			}
		}
	});
	
	// 답변하기 클릭
	$(".answer-write").click(function () {
		$(this).hide();
		var q_seq = $(this).attr("seq");
	//	alert(q_seq);
		
		// 동적 폼생성
		var form = $("<form></form>");
		form.attr("id", "write-form");
		form.attr("method", "post");
		
		var seq = $("<input type='hidden' name='question_seq' value=" + q_seq + ">");
		var text = $("<textarea cols='70' rows='5' name='content' maxlength='200'></textarea><br>");
		var btn = $("<input type='button' id='write-btn' class='submit-btn' value='답변등록'>");
		
		form.append(seq);
		form.append(text);
		form.append(btn);
		
		var answer_div = $(this).parent().prev().children(".content-answer").children(".content-answer-wating");
		
		answer_div.html("");	
	//	alert(answer_div.html());
		answer_div.append(form);
	});
	
	// 답변등록
	$(document).on("click", "#write-btn", function () {
	//	alert("클릭");
		if($("textarea[name=content]").val().trim() == "") {
			alert("답변 내용을 입력해주세요");
		}else {
			$("#write-form").attr("action", "adanswerwriteAf.do").submit();
		}
	});
	
	// 수정하기 클릭
	$(".answer-update").click(function () {
		$(this).hide();
		var a_seq = $(this).attr("seq");
	//	alert(q_seq);
		
		var answer_div = $(this).parent().prev().children(".content-answer").children(".content-answer-complete");		
		var prev_content = answer_div.children(".content-answer-oriAnswer").html().substr(3);
		
	//	alert(prev_content);
		
		// 동적 폼생성
		var form = $("<form></form>");
		form.attr("id", "update-form");
		form.attr("method", "post");
		
		var seq = $("<input type='hidden' name='seq' value=" + a_seq + ">");
		var text = $("<textarea cols='70' rows='5' name='content' maxlength='200'>" + prev_content + "</textarea><br>");
		var btn = $("<input type='button' id='update-btn' class='submit-btn' value='답변수정'>");
		
		form.append(seq);
		form.append(text);
		form.append(btn);
		
		$(".content-answer-oriAnswer").hide();
		answer_div.append(form);
	});
	
	// 수정
	$(document).on("click", "#update-btn", function () {
	//	alert("클릭");
		if($("textarea[name=content]").val().trim() == "") {
			alert("답변 내용을 입력해주세요");
		}else {
			$("#update-form").attr("action", "adanswerupdateAf.do").submit();
		}
	});
	
});

function goPage(type, pageNumber) {
	$("input[name=q_pageNumber]").val(pageNumber);
	$("#search-form").attr("action", "adquestionlist.do").submit();	
}
</script>
</body>
</html>